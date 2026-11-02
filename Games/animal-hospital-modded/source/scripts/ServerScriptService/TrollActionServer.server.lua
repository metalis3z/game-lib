-- TrollActionServer
-- Ejecuta las acciones del panel Troll (StarterGui.Troll) sobre jugadores:
--   * TrollFrame (single, 19 R$): actua sobre el jugador que el comprador esta
--     ESPECTANDO ahora mismo. El target lo sincroniza TrollSpectatorClient via
--     el RemoteEvent SetTrollTarget cada vez que cambia (next/previous).
--   * ServerTrollFrame (ALL, 49 R$): actua sobre TODOS los jugadores del
--     server menos el comprador.
-- Se dispara desde StoreServer.applyReward (Reward.TrollAction) via el
-- BindableEvent RunTrollAction, cuando se compra el DevProduct correspondiente
-- (ver ProductCatalog: Troll_Fling, Troll_Explode, Troll_Freeze, Troll_Trip,
-- Troll_Kill, Troll_Kick, y las variantes *All).
--
-- Acciones:
--   Fling   -> empujon fuerte hacia arriba/aleatorio (BodyVelocity temporal)
--   Explode -> lo mata + Explosion visual en su posicion
--   Freeze  -> lo encierra en un bloque de hielo, no se puede mover, se libera
--              solo a los FREEZE_DURATION segundos
--   Trip    -> lo tira al suelo un momento (PlatformStand) y se levanta solo
--   Kill    -> Humanoid.Health = 0
--   Kick    -> NO es Players:Kick real (no lo desconecta) -> respawn suave via
--              player:LoadCharacter() (usa el mismo RespawnLocation de su plot
--              que ya fija PlotServer, asi que reaparece en su base)

-- Troll action purchase handling
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local GunService = require(ServerScriptService:WaitForChild("GunService"))
local ProductConfig = require(ReplicatedStorage.Data.ProductConfig)

local FXsFolder = ReplicatedStorage:FindFirstChild("FXs")
local function emitStars(cframe)
	local template = FXsFolder and FXsFolder:FindFirstChild("Box_Star")
	if not (template and template:IsA("BasePart")) then return end
	local fx = template:Clone()
	fx.Anchored = true
	fx.CanCollide = false
	fx.CanTouch = false
	fx.CanQuery = false
	fx.Transparency = 1
	fx.CFrame = cframe
	fx.Parent = workspace
	for _, d in ipairs(fx:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			d.Enabled = true
			local burst = d:GetAttribute("EmitCount")
			d:Emit(burst or 15)
		end
	end
	Debris:AddItem(fx, 2)
end

local Events = ReplicatedStorage:WaitForChild("Events")
local SetTrollTarget = Events:FindFirstChild("SetTrollTarget")
if not SetTrollTarget then
	SetTrollTarget = Instance.new("RemoteEvent")
	SetTrollTarget.Name = "SetTrollTarget"
	SetTrollTarget.Parent = Events
end

local RunTrollAction = ServerStorage:FindFirstChild("RunTrollAction")
if not RunTrollAction then
	RunTrollAction = Instance.new("BindableEvent")
	RunTrollAction.Name = "RunTrollAction"
	RunTrollAction.Parent = ServerStorage
end

local remoteGui = ReplicatedStorage:FindFirstChild("RemoteGUI")
local notifyEvent = remoteGui and remoteGui:FindFirstChild("UNotifyEvent")
local function notify(player, title, kind)
	if notifyEvent then
		notifyEvent:FireClient(player, title, 4, kind or "Success")
	end
end

----------------------------------------------------------------
-- Target tracking (sincronizado por TrollSpectatorClient)
----------------------------------------------------------------

local trollTargets = {} -- [buyerUserId] = targetPlayer

SetTrollTarget.OnServerEvent:Connect(function(player, targetPlayer)
	if typeof(targetPlayer) == "Instance" and targetPlayer:IsA("Player") and targetPlayer ~= player then
		trollTargets[player.UserId] = targetPlayer
	else
		trollTargets[player.UserId] = nil
	end
end)

Players.PlayerRemoving:Connect(function(p)
	trollTargets[p.UserId] = nil
	for buyerId, target in pairs(trollTargets) do
		if target == p then
			trollTargets[buyerId] = nil
		end
	end
end)

----------------------------------------------------------------
-- Acciones individuales sobre un Player
----------------------------------------------------------------

-- El respawn NATIVO de Roblox (Health=0 -> auto LoadCharacter tras
-- Players.RespawnTime) no esta siendo confiable en este juego: el jugador
-- se queda sin personaje, sin respawnear en su plot. Kick ya evita esto
-- llamando target:LoadCharacter() a mano (ver mas abajo) -> reusamos el
-- mismo mecanismo probado como red de seguridad para Kill/Explode/Fling:
-- si a los 0.5s el jugador SIGUE en el mismo cadaver (el nativo no actuo),
-- forzamos el respawn manual.
local function forceRespawnIfStuck(target, deadChar)
	task.spawn(function()
		-- varios intentos por si el primer LoadCharacter no agarra (personaje
		-- todavia terminando de "morir", HumanoidRootPart en transicion, etc.)
		for _, delaySec in ipairs({ 0.5, 2, 5 }) do
			task.wait(delaySec)
			if not (target.Parent and target.Character == deadChar) then
				return -- ya respawneo (nativo o un intento anterior)
			end
			local ok = pcall(function() target:LoadCharacter() end)
			if ok then
				task.wait(0.2)
				if target.Parent and target.Character ~= deadChar then
					return
				end
			end
		end
	end)
end

local function killChar(target)
	local char = target.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.Health = 0 end
	if char then forceRespawnIfStuck(target, char) end
end

-- El Fling los manda muy alto/lejos pero Roblox moderno NO tiene fall damage
-- por defecto (se quito de los scripts default hace años) -> sin esto no
-- morian al aterrizar, entonces nunca reaparecian en su plot.
local FALL_KILL_HEIGHT = 45 -- studs caidos para morir al aterrizar
-- Red de seguridad por TIEMPO, independiente de los estados del Humanoid: el
-- Fling a veces lo saca del mapa y Landed nunca llega (cae al vacio para
-- siempre), o "aterriza" en varios rebotes cortos sobre geometria invisible
-- fuera del mapa que individualmente nunca superan los 45 studs -> el chequeo
-- basado solo en Freefall/Landed nunca disparaba y el jugador quedaba
-- bugueado ahi sin morir ni respawnear. WATCHDOG_DELAY chequea el
-- desplazamiento TOTAL desde antes del fling, pase lo que pase con los estados.
local WATCHDOG_DELAY = 5 -- s (el fling ya cayo de vuelta bastante antes si aterrizo normal)
local function attachFallDamage(target)
	local char = target.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not (char and hum and hrp) then return end
	if char:GetAttribute("_FallWatch") then return end
	char:SetAttribute("_FallWatch", true)

	local startY = hrp.Position.Y
	local fallStartY = nil
	local conn

	local function cleanup()
		if conn then conn:Disconnect() end
		if char.Parent then char:SetAttribute("_FallWatch", nil) end
	end

	conn = hum.StateChanged:Connect(function(_, new)
		if new == Enum.HumanoidStateType.Freefall then
			fallStartY = hrp.Position.Y
		elseif new == Enum.HumanoidStateType.Landed then
			if fallStartY and hum.Health > 0 and (fallStartY - hrp.Position.Y) > FALL_KILL_HEIGHT then
				hum.Health = 0
				forceRespawnIfStuck(target, char)
			end
			fallStartY = nil
		elseif new == Enum.HumanoidStateType.Dead then
			cleanup()
		end
	end)

	task.delay(WATCHDOG_DELAY, function()
		if hum.Parent and hum.Health > 0 and char.Parent and (startY - hrp.Position.Y) > FALL_KILL_HEIGHT then
			hum.Health = 0
			forceRespawnIfStuck(target, char)
		end
		cleanup()
	end)
end

local function flingChar(target)
	local char = target.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local dir = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
	if dir.Magnitude < 0.1 then dir = Vector3.new(1, 0, 0) end
	dir = dir.Unit
	local bv = Instance.new("BodyVelocity")
	bv.Name = "TrollFling"
	bv.MaxForce = Vector3.new(1, 1, 1) * math.huge
	bv.Velocity = dir * 350 + Vector3.new(0, 300, 0)
	bv.Parent = hrp
	Debris:AddItem(bv, 0.3)
	attachFallDamage(target)
end

local function explodeChar(target)
	local char = target.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp then return end
	local ex = Instance.new("Explosion")
	ex.Position = hrp.Position
	ex.BlastRadius = 8
	ex.BlastPressure = 0 -- NO mover partes del mapa ni a otros jugadores, solo visual
	ex.DestroyJointRadiusPercent = 0
	ex.Parent = workspace
	if hum then hum.Health = 0 end
	if char then forceRespawnIfStuck(target, char) end
end

local FREEZE_DURATION = 8
local function freezeChar(target)
	local char = target.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not (char and hum and hrp) then return end
	if char:GetAttribute("_Frozen") then return end -- ya congelado, no dupliques el bloque
	char:SetAttribute("_Frozen", true)

	hum.WalkSpeed = 0
	hum.JumpPower = 0
	hum.JumpHeight = 0
	hum.AutoRotate = false

	local _, size = char:GetBoundingBox()
	local ice = Instance.new("Part")
	ice.Name = "TrollFreezeBlock"
	ice.Material = Enum.Material.Ice
	ice.Color = Color3.fromRGB(150, 220, 255)
	ice.Transparency = 0.25
	ice.Anchored = true
	ice.CanCollide = false
	ice.CanQuery = false
	ice.CanTouch = false
	ice.Size = size + Vector3.new(1, 1, 1)
	ice.CFrame = char:GetPivot()
	ice.Parent = workspace

	local conn
	conn = hrp:GetPropertyChangedSignal("CFrame"):Connect(function()
		if ice.Parent then
			ice.CFrame = char:GetPivot()
		end
	end)

	task.delay(FREEZE_DURATION, function()
		if conn then conn:Disconnect() end
		if ice.Parent then ice:Destroy() end
		if char.Parent and hum.Parent then
			hum.WalkSpeed = 16
			hum.JumpPower = 50
			hum.JumpHeight = 7.2
			hum.AutoRotate = true
			char:SetAttribute("_Frozen", nil)
		end
	end)
end

local TRIP_DURATION = 1.5
local TRIP_FLIP_TIME = 0.45
local function tripChar(target)
	local char = target.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not (hum and hrp) then return end
	if char:GetAttribute("_Tripped") then return end
	char:SetAttribute("_Tripped", true)

	hum.PlatformStand = true
	emitStars(hrp.CFrame)

	-- Voltereta comica hacia adelante (en vez del ragdoll generico de antes):
	-- da una vuelta completa + un pequeño salto, con ease-out para que el
	-- "aterrizaje" se sienta con peso.
	local baseCF = hrp.CFrame
	task.spawn(function()
		local start = os.clock()
		while hrp.Parent and os.clock() - start < TRIP_FLIP_TIME do
			local t = math.clamp((os.clock() - start) / TRIP_FLIP_TIME, 0, 1)
			local eased = 1 - (1 - t) * (1 - t) -- ease-out cuadratico
			local angle = eased * math.rad(370) -- vuelta completa + un poco de "rebote"
			local hop = math.sin(t * math.pi) * 3
			local forward = eased * 3
			hrp.CFrame = baseCF * CFrame.new(0, hop, -forward) * CFrame.Angles(angle, 0, 0)
			task.wait()
		end
	end)

	task.delay(TRIP_DURATION, function()
		if hum.Parent then
			hum.PlatformStand = false
		end
		if char.Parent then
			char:SetAttribute("_Tripped", nil)
		end
	end)
end

local function kickChar(target)
	-- "kick" = reset/respawn suave, NO lo desconecta del server. Usa
	-- LoadCharacter (mismo mecanismo que PlotServer usa para respawns) asi que
	-- reaparece en su plot via RespawnLocation, no en un spawn random.
	pcall(function() target:LoadCharacter() end)
end

local ACTIONS = {
	Fling = flingChar,
	Explode = explodeChar,
	Freeze = freezeChar,
	Trip = tripChar,
	Kill = killChar,
	Kick = kickChar,
}

----------------------------------------------------------------
-- Dispatcher
----------------------------------------------------------------

local function dispatchTrollAction(buyer, actionName)
	if typeof(actionName) ~= "string" then return end
	local isAll = actionName:sub(-3) == "All"
	local base = isAll and actionName:sub(1, -4) or actionName
	local fn = ACTIONS[base]
	if not fn then
		warn("[TrollActionServer] Accion desconocida: " .. tostring(actionName))
		return
	end

	if isAll then
		local count = 0
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= buyer then
				fn(p)
				count += 1
			end
		end
		notify(buyer, base .. " aplicado a " .. count .. " jugadores!", "Success")
	else
		local target = trollTargets[buyer.UserId]
		if not (target and target.Parent) then
			notify(buyer, "No estas espectando a nadie ahora mismo!", "Error")
			return
		end
		fn(target)
		notify(buyer, base .. " aplicado a " .. target.Name .. "!", "Success")
		notify(target, buyer.Name .. " te aplico " .. base .. "!", "Error")
	end
end

RunTrollAction.Event:Connect(dispatchTrollAction)

----------------------------------------------------------------
-- Compra real (DevProducts) -> ProcessReceipt (dueño unico = GunService).
-- Antes nadie registraba estos ids: la compra se cobraba pero la accion
-- nunca se disparaba. IDs = los que hay HOY en TrollButtonsClient
-- (SINGLE_PRODUCTS / ALL_PRODUCTS); si se cambian ahi, hay que actualizarlos
-- aca tambien.
----------------------------------------------------------------

local TROLL_PRODUCT_ACTIONS = {}
for _, group in pairs(ProductConfig.TrollButtons) do
	for _, product in pairs(group) do
		if product.enabled then
			TROLL_PRODUCT_ACTIONS[product.id] = product.action
		end
	end
end

for productId, actionName in pairs(TROLL_PRODUCT_ACTIONS) do
	GunService:RegisterProduct(productId, function(player)
		dispatchTrollAction(player, actionName)
		return true
	end)
end

----------------------------------------------------------------
-- Modo gratis (SOLO thehalconyt1, activado con /troll free): el cliente
-- (TrollButtonsClient) dispara esto EN VEZ de PromptProductPurchase cuando
-- LocalPlayer:GetAttribute("TrollFree") es true. El check de verdad (que
-- importa, no el del cliente) se hace ACA en el server -> nadie mas puede
-- spoofear el atributo porque solo TrollFreeAdmin lo setea, y solo para ese
-- jugador exacto.
----------------------------------------------------------------

local FREE_TROLL_PLAYER_NAME = "thehalconyt1"

local FreeTrollAction = Events:FindFirstChild("FreeTrollAction")
if not FreeTrollAction then
	FreeTrollAction = Instance.new("RemoteEvent")
	FreeTrollAction.Name = "FreeTrollAction"
	FreeTrollAction.Parent = Events
end

FreeTrollAction.OnServerEvent:Connect(function(player, actionName)
	if player.Name ~= FREE_TROLL_PLAYER_NAME then return end
	if not player:GetAttribute("TrollFree") then return end
	dispatchTrollAction(player, actionName)
end)