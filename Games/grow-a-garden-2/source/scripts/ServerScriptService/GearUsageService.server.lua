--credit to leon games studio
--[[
	GearUsageService  (servidor)  [añadido]
	--------------------------------------------------------------------
	Autoridad de servidor que faltaba para el gear de COLOCACION que vive
	fuera del sistema de plantas: Gnomos, Teleporter y Wheelbarrow. Se apoya
	en los controllers cliente ya existentes (GnomeController, TeleporterController,
	WheelbarrowController) y en GearService (ConsumeGear) / GameServerAPI (GetPlot).

	  • Gnome (Place.PlaceGnome / RemoveGnome): coloca un BasePart en
	    workspace.Gnomes que el GnomeController convierte en el modelo animado.
	    El gnomo deambula por el radio, persigue/empuja a intrusos (no-dueños)
	    dentro del jardin ("Attacks garden intruders!") y expira por Lifetime.
	  • Teleporter (Place.UseTeleporter): el cliente ya teletransporta su propio
	    personaje (network owner); aqui solo se acepta/valida (anti-spam).
	  • Wheelbarrow (Wheelbarrow.Charge): se reconoce el canal (la mecanica de
	    regalo entre amigos la gatea el WheelbarrowController en el cliente).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GameServerAPI = require(ServerScriptService.GameServerAPI)

----------------------------------------------------------------------
-- Gnomos
----------------------------------------------------------------------
local GnomesFolder = workspace:FindFirstChild("Gnomes")
if not GnomesFolder then
	GnomesFolder = Instance.new("Folder")
	GnomesFolder.Name = "Gnomes"
	GnomesFolder.Parent = workspace
end

local GNOME_RANGE = 50
local GNOME_LIFETIME = 600
local GNOME_SPEED = 8       -- studs/seg al deambular o perseguir
local GNOME_ATTACK_DIST = 7 -- distancia para empujar al intruso
local GNOME_ATTACK_PUSH = 60

-- Conjunto de gnomos activos -> { part, ownerUserId, anchor, range, target, nextWander, lifetimeEnd }
local gnomes: { [BasePart]: any } = {}

local function plotAreaPart(plot: Instance?): BasePart?
	local visual = plot and plot:FindFirstChild("Visual")
	local area = visual and visual:FindFirstChild("GardenTotalArea")
	return (area and area:IsA("BasePart")) and area or nil
end

local function inArea(area: BasePart?, pos: Vector3, margin: number): boolean
	if not area then
		return true
	end
	local rel = area.CFrame:PointToObjectSpace(pos)
	local half = area.Size / 2
	return math.abs(rel.X) <= half.X + margin and math.abs(rel.Z) <= half.Z + margin
end

local function destroyGnome(part: BasePart)
	gnomes[part] = nil
	if part.Parent then
		part:Destroy()
	end
end

Networking.Place.PlaceGnome.OnServerEvent:Connect(function(player, worldPos, name, tool, rotDeg)
	if typeof(worldPos) ~= "Vector3" then
		return
	end
	if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or not tool:GetAttribute("Gnome") then
		return
	end
	local plot = GameServerAPI.WaitFor("GetPlot")(player)
	if not plot then
		return
	end
	local area = plotAreaPart(plot)
	if not inArea(area, worldPos, 4) then
		return
	end
	if not GameServerAPI.ConsumeGear or not GameServerAPI.ConsumeGear(player, name or "Gnome") then
		return
	end

	local part = Instance.new("Part")
	part.Name = "Gnome"
	part.Size = Vector3.new(2, 3, 2)
	part.Transparency = 1        -- el visual lo arma el GnomeController
	part.CanCollide = false
	part.CanQuery = true
	part.Anchored = true
	part.Position = worldPos + Vector3.new(0, 1.5, 0)
	part:SetAttribute("Owner", player.Name)
	part:SetAttribute("OwnerUserId", player.UserId)
	part:SetAttribute("Range", GNOME_RANGE)
	part:SetAttribute("GnomeState", "idle")
	part:SetAttribute("PlacedAt", workspace:GetServerTimeNow())
	part:SetAttribute("Lifetime", GNOME_LIFETIME)
	part.Parent = GnomesFolder

	gnomes[part] = {
		part = part,
		ownerUserId = player.UserId,
		anchor = part.Position,
		range = GNOME_RANGE,
		target = part.Position,
		nextWander = 0,
		lifetimeEnd = os.clock() + GNOME_LIFETIME,
	}
end)

Networking.Place.RemoveGnome.OnServerEvent:Connect(function(player, inst)
	if typeof(inst) ~= "Instance" or not inst:IsA("BasePart") then
		return
	end
	local g = gnomes[inst]
	if g and g.ownerUserId == player.UserId then
		destroyGnome(inst)
	end
end)

-- Busca el intruso (jugador distinto al dueño) mas cercano dentro del radio.
local function findIntruder(g): (Player?, Vector3?)
	local best, bestPos, bestDist = nil, nil, g.range * g.range
	local center = g.part.Position
	for _, p in Players:GetPlayers() do
		if p.UserId ~= g.ownerUserId then
			local char = p.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				local dx = root.Position.X - center.X
				local dz = root.Position.Z - center.Z
				local d2 = dx * dx + dz * dz
				if d2 <= bestDist then
					best, bestPos, bestDist = p, root.Position, d2
				end
			end
		end
	end
	return best, bestPos
end

-- Bucle de IA de los gnomos: deambular / perseguir intrusos / empujar.
task.spawn(function()
	local lastClock = os.clock()
	while true do
		local now = os.clock()
		local dt = now - lastClock
		lastClock = now
		for part, g in gnomes do
			if not part.Parent then
				gnomes[part] = nil
			elseif now >= g.lifetimeEnd then
				destroyGnome(part)
			else
				local intruder, intruderPos = findIntruder(g)
				local pos = part.Position
				local target
				if intruder and intruderPos then
					local flat = Vector3.new(intruderPos.X, pos.Y, intruderPos.Z)
					local dist = (flat - pos).Magnitude
					if dist <= GNOME_ATTACK_DIST then
						part:SetAttribute("GnomeState", "attacking")
						-- empuje al intruso (disuasion real)
						local root = intruder.Character and intruder.Character:FindFirstChild("HumanoidRootPart")
						if root then
							local dir = (root.Position - pos)
							dir = Vector3.new(dir.X, 0, dir.Z)
							if dir.Magnitude > 0.01 then
								root.AssemblyLinearVelocity = dir.Unit * GNOME_ATTACK_PUSH + Vector3.new(0, 20, 0)
							end
						end
						target = pos
					else
						part:SetAttribute("GnomeState", "chasing")
						target = flat
					end
				else
					-- deambular dentro del radio alrededor del ancla
					if now >= g.nextWander then
						local angle = math.random() * math.pi * 2
						local r = math.random() * (g.range * 0.5)
						g.target = g.anchor + Vector3.new(math.cos(angle) * r, 0, math.sin(angle) * r)
						g.nextWander = now + math.random(3, 6)
					end
					target = g.target
					if (Vector3.new(target.X, pos.Y, target.Z) - pos).Magnitude <= 1 then
						part:SetAttribute("GnomeState", "idle")
					else
						part:SetAttribute("GnomeState", "wandering")
					end
				end

				-- mover el part hacia el objetivo (el cliente lerpa el modelo)
				if target then
					local flat = Vector3.new(target.X, pos.Y, target.Z)
					local delta = flat - pos
					local step = GNOME_SPEED * dt
					if delta.Magnitude > step then
						part.Position = pos + delta.Unit * step
					elseif delta.Magnitude > 0 then
						part.Position = flat
					end
				end
			end
		end
		task.wait(0.15)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	for part, g in gnomes do
		if g.ownerUserId == player.UserId then
			destroyGnome(part)
		end
	end
end)

----------------------------------------------------------------------
-- Teleporter: el cliente teletransporta su propio personaje (network owner);
-- aqui solo se acepta con un anti-spam suave por jugador.
----------------------------------------------------------------------
local lastTeleport: { [Player]: number } = {}
Networking.Place.UseTeleporter.OnServerEvent:Connect(function(player, pos)
	if typeof(pos) ~= "Vector3" then
		return
	end
	local now = os.clock()
	if now - (lastTeleport[player] or 0) < 0.5 then
		return
	end
	lastTeleport[player] = now
	-- (autoridad: el movimiento ya lo aplica el cliente sobre su Character)
end)

----------------------------------------------------------------------
-- Wheelbarrow: el canal Charge existe para la mecanica de regalo entre amigos
-- (el WheelbarrowController la gatea en el cliente). Se reconoce el canal.
----------------------------------------------------------------------
Networking.Wheelbarrow.Charge.OnServerEvent:Connect(function(player)
	-- sin amigos en el server el cliente desequipa la carretilla; no hay carga.
end)

----------------------------------------------------------------------
-- Gamepass gears: habilidades de combate (autoridad de servidor). El cliente
-- dispara el canal al activar el Tool; aquí se aplica el efecto a los demás.
-- Respeta zona segura / jardín propio del objetivo (no lo afecta).
----------------------------------------------------------------------
do
	local CollectionService = game:GetService("CollectionService")

	local function broadcast(packet, ...)
		for _, p in Players:GetPlayers() do
			packet:FireClient(p, ...)
		end
	end

	local function isProtected(player: Player): boolean
		return player:GetAttribute("InSafeZone") == true or player:GetAttribute("IsInOwnGarden") == true
	end

	-- Inmoviliza un Humanoid y devuelve el restaurador.
	local function immobilize(character)
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return function() end
		end
		local ws, jp, jh = humanoid.WalkSpeed, humanoid.JumpPower, humanoid.JumpHeight
		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
		humanoid.JumpHeight = 0
		return function()
			if humanoid.Parent then
				humanoid.WalkSpeed = ws
				humanoid.JumpPower = jp
				humanoid.JumpHeight = jh
			end
		end
	end

	-- Freeze Ray: congela al jugador más cercano al impacto. El hielo lo pinta el
	-- cliente al ver el tag "Ice_Block" (FreezeRayController.newIceBlock).
	local FREEZE_DURATION = 5
	local FREEZE_RADIUS = 12
	local freezeBusy = {}
	Networking.FreezeRay.Fire.OnServerEvent:Connect(function(player, hitPos, tool)
		if typeof(hitPos) ~= "Vector3" then return end
		if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or not tool:GetAttribute("FreezeRay") then return end
		local target, best = nil, FREEZE_RADIUS * FREEZE_RADIUS
		for _, p in Players:GetPlayers() do
			if p ~= player and not isProtected(p) and not freezeBusy[p] then
				local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local d2 = (root.Position - hitPos).Magnitude ^ 2
					if d2 <= best then
						target, best = p, d2
					end
				end
			end
		end
		if not target then return end
		freezeBusy[target] = true
		local character = target.Character
		local restore = immobilize(character)
		-- Bloque de hielo sobre el torso (como la Freeze Ray Scene): Ice_Part soldado
		-- + tag "Ice_Block" (FreezeRayController.newIceBlock lo realza) + sonido Freeze.
		local torso = character:FindFirstChild("HumanoidRootPart")
			or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
		local iceTemplate = ReplicatedStorage.Assets:FindFirstChild("Ice_Part")
		local iceBlock
		if torso and iceTemplate then
			iceBlock = iceTemplate:Clone()
			iceBlock.Anchored = false
			iceBlock.CanCollide = false
			iceBlock.Massless = true
			iceBlock.CFrame = torso.CFrame
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = iceBlock
			weld.Part1 = torso
			weld.Parent = iceBlock
			iceBlock.Parent = character
			CollectionService:AddTag(iceBlock, "Ice_Block")
			local sfx = game.SoundService:FindFirstChild("SFX")
			local freezeSfx = sfx and sfx:FindFirstChild("Freeze")
			if freezeSfx then
				local s = freezeSfx:Clone()
				s.Parent = iceBlock
				s.Playing = true
				game:GetService("Debris"):AddItem(s, 4)
			end
		end
		task.delay(FREEZE_DURATION, function()
			restore()
			if iceBlock then
				iceBlock:Destroy()
			end
			freezeBusy[target] = nil
		end)
	end)

	-- Power Hose: empuja a los jugadores en el cono frontal del que dispara.
	local HOSE_RANGE = 24
	local HOSE_CONE = 0.45 -- cos del semiángulo (~63°)
	local HOSE_FORCE = 90
	Networking.PowerHose.Activate.OnServerEvent:Connect(function(player, tool)
		if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or not tool:GetAttribute("PowerHose") then return end
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local look = root.CFrame.LookVector
		for _, p in Players:GetPlayers() do
			if p ~= player and not isProtected(p) then
				local proot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
				if proot then
					local to = proot.Position - root.Position
					local dist = to.Magnitude
					if dist > 0.1 and dist <= HOSE_RANGE and look:Dot(to.Unit) >= HOSE_CONE then
						local flat = Vector3.new(to.Unit.X, 0, to.Unit.Z)
						if flat.Magnitude > 0 then
							proot.AssemblyLinearVelocity = flat.Unit * HOSE_FORCE + Vector3.new(0, 35, 0)
						end
						Networking.PowerHose.KnockbackFx:FireClient(p, p.Character)
					end
				end
			end
		end
	end)

	-- Vine Wrapper: enreda (inmoviliza) al objetivo que eligió el cliente y avisa a
	-- todos para que pinten la enredadera. El cliente ya hace el chorro/spline.
	local VINE_DURATION = 4
	local vineBusy = {}
	Networking.VineWrapper.Activate.OnServerEvent:Connect(function(player, pos)
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root and typeof(pos) == "Vector3" then
			for _, p in Players:GetPlayers() do
				if p ~= player then
					Networking.VineWrapper.SendVisual:FireClient(p, root, pos)
				end
			end
		end
	end)
	Networking.VineWrapper.AssignTarget.OnServerEvent:Connect(function(player, targetChar, num)
		if typeof(targetChar) ~= "Instance" then return end
		local victim = Players:GetPlayerFromCharacter(targetChar)
		if not victim or victim == player or isProtected(victim) or vineBusy[victim] then return end
		vineBusy[victim] = true
		targetChar:SetAttribute("VineWrapped", true)
		local restore = immobilize(targetChar)
		broadcast(Networking.VineWrapper.WrapCharacter, targetChar)
		task.delay(VINE_DURATION, function()
			restore()
			if targetChar then
				targetChar:SetAttribute("VineWrapped", false)
			end
			vineBusy[victim] = nil
			broadcast(Networking.VineWrapper.UnwrapCharacter, targetChar)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		freezeBusy[player] = nil
		vineBusy[player] = nil
	end)

	print("[GearUsageService] combat gears (Freeze/Hose/Vine) listos")
end

----------------------------------------------------------------------
-- Rainbow Carpet (gamepass): mount volador. RainbowMagicCarpetController es
-- "driven-by-server": al recibir Carpet.Equip corre HandleFlightControl, que ESPERA
-- a que aparezca un "FlightHold" en el HRP y entonces pilota los body movers
-- FlightSpin (BodyGyro) / FlightPower (BodyVelocity) / FlightHold (BodyPosition) con
-- la cámara + MoveDirection. ESTE server los crea (en el orden correcto: Hold último).
----------------------------------------------------------------------
do
	local carpetState = {} -- [player] = { bodies = {...}, carpet = Model }
	local hookedTools = {}

	local function stopCarpet(player)
		local st = carpetState[player]
		if not st then
			return
		end
		carpetState[player] = nil
		Networking.Carpet.Unequip:FireClient(player)
		for _, b in st.bodies do
			if b then
				b:Destroy()
			end
		end
		if st.hiddenTool then -- MODDED: restaurar la visibilidad de la Tool
			for _, pair in st.hiddenTool do
				if pair[1] and pair[1].Parent then
					pair[1].Transparency = pair[2]
				end
			end
		end
		if st.carpet then
			st.carpet:Destroy()
		end
	end

	local function startCarpet(player, tool)
		if carpetState[player] then
			return
		end
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end
		carpetState[player] = { bodies = {}, hiddenTool = {} }
		-- MODDED: ocultar la Tool del carpet mientras se vuela (no se ve en la mano)
		for _, d in tool:GetDescendants() do
			if d:IsA("BasePart") then
				table.insert(carpetState[player].hiddenTool, { d, d.Transparency })
				d.Transparency = 1
			end
		end

		Networking.Carpet.Equip:FireClient(player)
		task.wait(0.2) -- dar tiempo a que el controller conecte su watcher de "FlightHold"

		if not (carpetState[player] and tool.Parent == player.Character and hrp.Parent) then
			stopCarpet(player)
			return
		end

		local spin = Instance.new("BodyGyro")
		spin.Name = "FlightSpin"
		spin.MaxTorque = Vector3.one * 400000
		spin.P = 3000
		spin.D = 500
		spin.CFrame = hrp.CFrame
		spin.Parent = hrp

		local power = Instance.new("BodyVelocity")
		power.Name = "FlightPower"
		power.P = 1250
		power.MaxForce = Vector3.zero
		power.Velocity = Vector3.zero
		power.Parent = hrp

		local hold = Instance.new("BodyPosition")
		hold.Name = "FlightHold"
		hold.P = 10000
		hold.D = 1250
		hold.MaxForce = Vector3.zero
		hold.Position = hrp.Position
		hold.Parent = hrp -- ÚLTIMO: dispara HandleFlightControl (watcher de "FlightHold")

		carpetState[player].bodies = { spin, power, hold }

		Networking.Carpet.PlayAnimation:FireClient(player, "Sit")

		-- visual del tapete bajo el jugador (estático, soldado al HRP)
		local mc = ReplicatedStorage.Assets:FindFirstChild("MagicCarpet")
		if mc then
			local carpet = mc:Clone()
			for _, d in carpet:GetDescendants() do
				if d:IsA("BasePart") then
					d.Anchored = false
					d.CanCollide = false
					d.Massless = true
				end
			end
			local prim = carpet.PrimaryPart or carpet:FindFirstChildWhichIsA("BasePart")
			carpet:PivotTo(hrp.CFrame * CFrame.new(0, -2.5, 0))
			carpet.Parent = char
			if prim then
				local w = Instance.new("WeldConstraint")
				w.Part0 = prim
				w.Part1 = hrp
				w.Parent = prim
			end
			carpetState[player].carpet = carpet
		end
	end

	local function hookCarpetTool(tool, player)
		if hookedTools[tool] or not (tool:IsA("Tool") and tool:GetAttribute("Carpet")) then
			return
		end
		hookedTools[tool] = true
		tool.Equipped:Connect(function()
			startCarpet(player, tool)
		end)
		tool.Unequipped:Connect(function()
			stopCarpet(player)
		end)
		tool.Destroying:Connect(function()
			hookedTools[tool] = nil
			stopCarpet(player)
		end)
	end

	local function hookCarpetPlayer(player)
		local function scan(container)
			if not container then
				return
			end
			for _, t in container:GetChildren() do
				hookCarpetTool(t, player)
			end
			container.ChildAdded:Connect(function(t)
				hookCarpetTool(t, player)
			end)
		end
		scan(player:FindFirstChild("Backpack") or player:WaitForChild("Backpack"))
		if player.Character then
			scan(player.Character)
		end
		player.CharacterAdded:Connect(function(char)
			stopCarpet(player) -- resetear al respawnear
			scan(char)
		end)
	end

	Players.PlayerAdded:Connect(hookCarpetPlayer)
	for _, p in Players:GetPlayers() do
		hookCarpetPlayer(p)
	end
	Players.PlayerRemoving:Connect(function(player)
		carpetState[player] = nil
	end)

	print("[GearUsageService] Rainbow Carpet (vuelo) listo")
end

print("[GearUsageService] listo — gnomos (colocacion + IA) + teleporter + wheelbarrow")
