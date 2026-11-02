--[[
	EmergencyService  (Fase 13 — NPCs baleados -> cargar a Emergency)

	Cuando un NPC recibe daño letal (gun, u otro NPC), NO muere: pasa a "downed":
	  · Se cae/duerme (anim Sleep) y se le saca del sistema de espera.
	  · Aparece un ProximityPrompt "Carry" sobre él.
	  · Sobre su cabeza sale el Counter (ReplicatedStorage.Misc.Counter) con una
	    cuenta regresiva de 50s estilo "50☠️".
	El jugador lo carga (queda pegado a sus brazos, sigue durmiendo) y lo lleva a la
	zona Emergency (Areas.Emergency / Rooms.Emergency 6-8) ANTES de que el contador
	llegue a 0. Si lo entrega a tiempo -> salvado (+recompensa). Si no -> se pierde.

	API: EmergencyService:Init(), EmergencyService:Down(npc, byPlayer)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))

local EmergencyService = {}

local COUNTDOWN   = 50
local SLEEP_ANIM  = "rbxassetid://90640137077275"   -- Sleep (echado)
local REWARD_CASH = 100
-- Cómo queda el NPC en los brazos del jugador. Tuneá estos números si se ve mal
-- (describímelo en Play y lo ajusto): POS 1er=lado, 2do=altura, 3er=adelante(negativo);
-- ROT en grados (X,Y,Z).
local CARRY_POS = Vector3.new(0, -0.3, -1.6)   -- más cerca del jugador y más abajo
local CARRY_ROT = Vector3.new(0, 0, -90)       -- al otro lado
local CARRY_OFFSET = CFrame.new(CARRY_POS)
	* CFrame.fromOrientation(math.rad(CARRY_ROT.X), math.rad(CARRY_ROT.Y), math.rad(CARRY_ROT.Z))

local counterTemplate  -- ReplicatedStorage.Misc.Counter (Attachment con BillboardGui)
local zone             -- Workspace.Areas.Emergency (Part footprint)
local emergencyPoints = {} -- puntos Patient de Rooms.Emergency (dónde dejarlo)
local pointIdx = 0

local downed = {}      -- [npc] = { remaining, carriedBy, prompt, counterAtt, weld }
local carrying = {}    -- [player] = npc (uno a la vez)

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function loadTrack(hum, id)
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
	for _, t in ipairs(animator:GetPlayingAnimationTracks()) do t:Stop(0.1) end
	local anim = Instance.new("Animation"); anim.AnimationId = id
	local ok, tr = pcall(function() return animator:LoadAnimation(anim) end)
	if ok and tr then
		tr.Looped = true
		tr.Priority = Enum.AnimationPriority.Action
		tr:Play(0.2)
		return tr
	end
	return nil
end

local DELIVER_RADIUS = 14   -- qué tan cerca del punto de la room asignada = entregado

-- ¿el jugador (cargando) llegó a la ROOM asignada (6/7/8)?
local function atTarget(player, target)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not (hrp and target and target.point) then return false end
	return (hrp.Position - target.point.Position).Magnitude <= DELIVER_RADIUS
end

local function cleanup(npc)
	local st = downed[npc]
	if not st then return end
	if st.prompt then st.prompt:Destroy() end
	if st.counterAtt then st.counterAtt:Destroy() end
	if st.weld then st.weld:Destroy() end
	if st.carriedBy then carrying[st.carriedBy] = nil end
	downed[npc] = nil
end

--------------------------------------------------------------------------------
-- Entregado a tiempo
--------------------------------------------------------------------------------
local function deliver(npc)
	local st = downed[npc]
	if not st then return end
	local player = st.carriedBy
	local target = st.target
	cleanup(npc)

	-- Dejarlo en la cama/punto de la room asignada
	local point = target and target.point
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Anchored = true
		if point then hrp.CFrame = point.CFrame + Vector3.new(0, 2, 0) end
	end

	if player then
		local DataService = ServerScriptService:FindFirstChild("DataService")
		if DataService then
			local ok, ds = pcall(require, DataService)
			if ok and ds.AddCash then pcall(function() ds:AddCash(player, REWARD_CASH) end) end
		end
		pcall(function()
			Network:FireClient(player, "Notify", ("Patient saved! +$%d"):format(REWARD_CASH), Color3.fromRGB(120, 230, 120))
			Network:FireClient(player, "SetObjective", "")
		end)
	end

	-- Se recupera y desaparece
	task.delay(5, function() PatientService:Despawn(npc) end)
end

--------------------------------------------------------------------------------
-- Se acabó el tiempo (o murió sin entregar)
--------------------------------------------------------------------------------
local function fail(npc)
	local st = downed[npc]
	if not st then return end
	local player = st.carriedBy
	cleanup(npc)
	if player then
		pcall(function()
			Network:FireClient(player, "Notify", "Patient lost!", Color3.fromRGB(230, 90, 90))
		end)
	end
	local hum = npc:FindFirstChildOfClass("Humanoid")
	if hum then hum.Health = 0 end
	task.delay(2, function() PatientService:Despawn(npc) end)
end

--------------------------------------------------------------------------------
-- Cargar
--------------------------------------------------------------------------------
local function startCarry(npc, player)
	local st = downed[npc]
	if not st or st.carriedBy then return end
	if carrying[player] then return end   -- ya carga a otro
	local char = player.Character
	local playerHrp = char and char:FindFirstChild("HumanoidRootPart")
	local npcHrp = npc:FindFirstChild("HumanoidRootPart")
	if not (playerHrp and npcHrp) then return end

	st.carriedBy = player
	carrying[player] = npc
	if st.prompt then st.prompt.Enabled = false end

	-- Soldar al jugador (echado en los brazos)
	for _, p in ipairs(npc:GetDescendants()) do
		if p:IsA("BasePart") then p.CanCollide = false; p.Massless = true end
	end
	npcHrp.Anchored = false
	local weld = Instance.new("Weld")
	weld.Part0 = playerHrp
	weld.Part1 = npcHrp
	weld.C0 = CARRY_OFFSET
	weld.Parent = npcHrp
	st.weld = weld

	local roomName = st.target and st.target.name or "Emergency"
	pcall(function()
		Network:FireClient(player, "Notify", "Carry the patient to " .. roomName .. "!", Color3.fromRGB(230, 210, 120))
		Network:FireClient(player, "SetObjective", "Carry patient to " .. roomName)
	end)
end

--------------------------------------------------------------------------------
-- Down (lo llama GunService al balear un NPC)
--------------------------------------------------------------------------------
function EmergencyService:Down(npc, byPlayer)
	if not npc or not npc.Parent then return end
	if downed[npc] or npc:GetAttribute("Downed") then return end
	local hum = npc:FindFirstChildOfClass("Humanoid")
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if not (hum and hrp) then return end

	npc:SetAttribute("Downed", true)

	-- Sacarlo del sistema de espera (cola/silla/mostrador)
	PatientService:RemoveFromWaiting(npc)

	-- Caer/dormir en el sitio
	hum.WalkSpeed = 0
	hum.AutoRotate = false
	hrp.Anchored = true
	loadTrack(hum, SLEEP_ANIM)

	local head = npc:FindFirstChild("Head") or hrp

	-- Prompt "Carry"
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "CarryPrompt"
	prompt.ActionText = "Carry"
	prompt.ObjectText = "To Emergency"
	prompt.HoldDuration = 0.4
	prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false
	prompt.Parent = hrp

	-- Counter sobre la cabeza
	local counterAtt = counterTemplate:Clone()
	counterAtt.Parent = head

	-- Room asignada (6/7/8): por ahora al azar ("o cualquier cosa"); fácil de cambiar
	-- a criterio de daño/severidad más adelante.
	local target = emergencyPoints[math.random(1, math.max(1, #emergencyPoints))]
	if target then prompt.ObjectText = "-> " .. target.name end
	local st = { remaining = COUNTDOWN, carriedBy = nil, prompt = prompt, counterAtt = counterAtt, weld = nil, target = target }
	downed[npc] = st

	prompt.Triggered:Connect(function(player)
		startCarry(npc, player)
	end)

	-- Actualizar el texto del Counter
	local label = counterAtt:FindFirstChildWhichIsA("TextLabel", true)
	local function setText(n) if label then label.Text = tostring(n) .. "☠️" end end
	setText(COUNTDOWN)

	-- Loop: cuenta regresiva + detectar entrega
	task.spawn(function()
		local t0 = os.clock()
		while npc.Parent and downed[npc] do
			local remaining = math.max(0, COUNTDOWN - math.floor(os.clock() - t0))
			setText(remaining)
			local carriedBy = downed[npc] and downed[npc].carriedBy
			if carriedBy and (not carriedBy.Parent or not carriedBy.Character) then
				-- el que cargaba se fue: soltar (queda downed en el sitio)
				local weld = downed[npc].weld
				if weld then weld:Destroy(); downed[npc].weld = nil end
				carrying[carriedBy] = nil
				downed[npc].carriedBy = nil
				hrp.Anchored = true
			elseif carriedBy and atTarget(carriedBy, downed[npc].target) then
				deliver(npc)
				return
			end
			if remaining <= 0 then
				fail(npc)
				return
			end
			task.wait(0.2)
		end
	end)
end

--------------------------------------------------------------------------------
function EmergencyService:Init()
	if self._initialized then return end
	self._initialized = true

	counterTemplate = ReplicatedStorage:WaitForChild("Misc"):WaitForChild("Counter")
	zone = workspace:WaitForChild("Areas"):FindFirstChild("Emergency")

	-- puntos Patient de las salas Emergency 6-8
	local em = workspace:WaitForChild("Rooms"):FindFirstChild("Emergency")
	if em then
		for _, room in ipairs(em:GetChildren()) do
			local mp = room:FindFirstChild("MovePoints")
			local pt = mp and (mp:FindFirstChild("Patient") or mp:FindFirstChildWhichIsA("BasePart"))
			if pt then table.insert(emergencyPoints, { point = pt, name = room.Name }) end
		end
	end

	-- Soltar al NPC si el jugador que lo cargaba se va
	Players.PlayerRemoving:Connect(function(plr)
		local npc = carrying[plr]
		if npc and downed[npc] then
			local weld = downed[npc].weld
			if weld then weld:Destroy(); downed[npc].weld = nil end
			downed[npc].carriedBy = nil
			local hrp = npc:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Anchored = true end
		end
		carrying[plr] = nil
	end)

	-- print("[EmergencyService] inicializado — carry de NPCs baleados a Emergency (" .. #emergencyPoints .. " puntos)")
end

return EmergencyService
