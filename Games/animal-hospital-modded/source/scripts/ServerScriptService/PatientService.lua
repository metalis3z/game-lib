--[[
	PatientService  (Fase 2 — NPCs de pacientes / visitantes)

	Spawnea y camina los NPCs; la ESTACIÓN de check-in (CheckInService) maneja el
	registro. El cliente ya está (Cutscenes, DisguiseReveals, ProximityPromptScript).

	Pool de spawn (ReplicatedStorage.NPCs):
	  · UniqueVisitors/* : 7 personajes pre-armados CON atributos (Barney, Ratthew,
	    Ratthew2, Doctor, Ron from Accounting, Clown, Officer Duckman). Se PRESERVAN
	    sus atributos. "Fake"=true = visitante impostor (no paciente real).
	  · Visitors.SkinDummy : base genérica (nombre aleatorio).

	Flujo: spawn en la calle (MovePoints.outside) -> camina ENTRANDO por la MainDoor
	(DoorService la abre) al mostrador (checkIn) -> cutscene "VisitorArrived" ->
	dispara PatientService.Arrived(npc) -> CheckInService corre el registro y llama
	PatientService:CompleteCheckIn(npc) -> "VisitorCheckedIn", el paciente se retira
	por la calle y despawnea -> entra el siguiente.

	API: :Init(), :SpawnPatient([templateName]), :CompleteCheckIn(npc), :Despawn(npc),
	     :GetActivePatient(), evento .Arrived
]]

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local PathfindingService = game:GetService("PathfindingService")
local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

--------------------------------------------------------------------------------
-- Grupos de colisión: los pacientes ATRAVIESAN las puertas (el jugador NO). Sin
-- esto el NPC choca con la hoja cerrada (CanCollide) y se atora camino a la sala.
-- Ver DoorsService (marca las hojas como "MapDoors").
--------------------------------------------------------------------------------
local NPC_GROUP = "PatientNPC"
local DOOR_GROUP = "MapDoors"
local PLAYER_GROUP = "Players"   -- personajes de jugador: NO colisionan con NPCs (no empujan)
local function ensureCollisionGroups()
	for _, g in ipairs({ NPC_GROUP, DOOR_GROUP, PLAYER_GROUP }) do
		if not PhysicsService:IsCollisionGroupRegistered(g) then
			pcall(function() PhysicsService:RegisterCollisionGroup(g) end)
		end
	end
	pcall(function() PhysicsService:CollisionGroupSetCollidable(NPC_GROUP, DOOR_GROUP, false) end)
	-- Los jugadores atraviesan a los NPCs: no pueden EMPUJARLOS (antes los movían al chocar).
	pcall(function() PhysicsService:CollisionGroupSetCollidable(NPC_GROUP, PLAYER_GROUP, false) end)
	-- Patients never body-block one another in queues, doors, or narrow halls.
	pcall(function() PhysicsService:CollisionGroupSetCollidable(NPC_GROUP, NPC_GROUP, false) end)
end

-- Mete todas las partes del personaje del jugador al grupo PLAYER_GROUP (para que no
-- colisione con los NPCs). Se reaplica en cada respawn y para los que ya estén dentro.
local function setupPlayerCollision()
	local function tagCharacter(char)
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then
				pcall(function() p.CollisionGroup = PLAYER_GROUP end)
			end
		end
		char.DescendantAdded:Connect(function(d)
			if d:IsA("BasePart") then
				pcall(function() d.CollisionGroup = PLAYER_GROUP end)
			end
		end)
	end
	local function onPlayer(plr)
		plr.CharacterAdded:Connect(tagCharacter)
		if plr.Character then tagCharacter(plr.Character) end
	end
	Players.PlayerAdded:Connect(onPlayer)
	for _, plr in ipairs(Players:GetPlayers()) do onPlayer(plr) end
end

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
local NPCsFolder = ReplicatedStorage:WaitForChild("NPCs")
local UNIQUE_VISITORS = NPCsFolder:WaitForChild("UniqueVisitors")
local GENERIC_TEMPLATE = NPCsFolder.Visitors:WaitForChild("SkinDummy")

local SPAWN_POINT = "outside"
local CHECKIN_POINT = "checkIn"
local CHECKIN_LOOKAT = "checkInLookAt"
local LEAVE_POINT = "outside"

-- Dos mostradores (estaciones). Se ALTERNAN entre pacientes para usar AMBOS:
--   est.1 = checkIn / checkInLookAt   (props Form / Photo)
--   est.2 = checkIn2 / checkInLookAt2 (props Form2 / Photo2)
-- CheckInService elige el prop por el atributo del NPC "CheckInStation" (1/2).
-- Sigue habiendo UN solo check-in activo a la vez (el jugador atiende de a uno).
local CHECKIN_POINTS  = { "checkIn", "checkIn2" }
local CHECKIN_LOOKATS = { "checkInLookAt", "checkInLookAt2" }
local nextStation = 1
-- Grados extra en Y que gira el visitante al LLEGAR al mostrador.
-- 0 = NO gira: queda mirando derecho al frente del check-in (lo que se pidio).
-- 90/-90 = de perfil; 180/-180 = de espaldas. Con 0 ni se toca el CFrame.
local ARRIVAL_TURN_Y = 0
-- Debug de orientacion: con true, cada NPC que se presenta en el check-in
-- imprime en el Output su Orientation.Y antes y despues del giro, y cuantos
-- grados le faltan para mirar al mostrador (Delta al mostrador).
local DEBUG_ORIENTATION = false
local WALK_SPEED = 5
local RESPAWN_DELAY = 4
local GENERIC_NAMES = { "Bob", "Alice", "Karen", "Greg", "Mia", "Tom", "Nina", "Carl", "Rosa", "Ivan" }

-- Anim de caminata para TODOS los NPC que salen (varios modelos no traen la suya).
local WALK_ANIM_ID = "rbxassetid://71726815866919" -- Walk(Old) (caminando)
local IDLE_ANIM_ID = "rbxassetid://133347859620537" -- idle (parado)
local SIT_ANIM_ID  = "rbxassetid://88200596112343" -- Sit (sentado en las sillas de espera) — mismo id que ReplicatedStorage.Animations.Sit

-- Sala de espera
local SIT_HEIGHT  = 1.0   -- cuánto sube el HRP sobre el asiento (ajústalo si flota/hunde)
local SIT_LEG_ANGLE = 80  -- grados que se doblan las piernas al sentarse (0=parado, 90=horizontal)
local MAX_WAITING = 4     -- pacientes en la sala de espera (cola + mostrador) a la vez (antes 6: "no muchos")
local INITIAL_SPAWN = 3   -- mínimo de visitantes que aparecen rápido al arrancar
local DEBUG_WAIT  = false  -- imprime [Wait]/[Sit] para diagnosticar el Sit (poner false luego)
local function dbg(...) if DEBUG_WAIT then print("[Wait]", ...) end end

--------------------------------------------------------------------------------
local PatientService = {}
PatientService.Arrived = Instance.new("BindableEvent") -- fires (npc) al llegar al mostrador
PatientService.CheckedIn = Instance.new("BindableEvent") -- fires (npc) al completar el check-in
local activePatient = nil
local roomCounter = 0

local function templatePool()
	local pool = {}
	for _, m in ipairs(UNIQUE_VISITORS:GetChildren()) do
		if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") then
			table.insert(pool, m)
		end
	end
	-- Solo salen los NPCs de ReplicatedStorage.NPCs.UniqueVisitors (sin genérico)
	return pool
end

local function pickTemplate(name)
	if name then
		return UNIQUE_VISITORS:FindFirstChild(name) or (GENERIC_TEMPLATE.Name == name and GENERIC_TEMPLATE)
	end
	local pool = templatePool()
	return pool[math.random(1, #pool)]
end

local function movePoint(name)
	return workspace:WaitForChild("MovePoints"):FindFirstChild(name)
end

-- Reliable waypoint traversal with bounded waits and active stuck detection.
local WAYPOINT_RADIUS = 1.75
local ARRIVAL_RADIUS = 3.5
local STUCK_WINDOW = 1.25
local MIN_PROGRESS = 0.3
local MAX_REPATHS = 8
local MAX_WALK_TIME = 18

local function flatDistance(a, b)
	return ((a - b) * Vector3.new(1, 0, 1)).Magnitude
end

local function resolveTarget(target)
	if typeof(target) == "Vector3" then
		return target
	end
	if typeof(target) == "Instance" and target:IsA("BasePart") and target.Parent then
		return target.Position
	end
	return nil
end

local function moveStep(npc, hum, hrp, waypoint, timeout)
	local position = waypoint.Position
	if waypoint.Action == Enum.PathWaypointAction.Jump then
		hum.Jump = true
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end

	hum:MoveTo(position)

	local finished = nil
	local connection = hum.MoveToFinished:Connect(function(reached)
		finished = reached
	end)

	local startedAt = os.clock()
	local lastProgressAt = startedAt
	local lastPosition = hrp.Position
	local result = "timeout"

	while os.clock() - startedAt < timeout do
		if not npc.Parent or npc:GetAttribute("Downed") then
			result = "cancelled"
			break
		end
		if finished == true or flatDistance(hrp.Position, position) <= WAYPOINT_RADIUS then
			result = "reached"
			break
		end
		if finished == false then
			result = "blocked"
			break
		end

		if flatDistance(hrp.Position, lastPosition) >= MIN_PROGRESS then
			lastPosition = hrp.Position
			lastProgressAt = os.clock()
		elseif os.clock() - lastProgressAt >= STUCK_WINDOW then
			result = "stuck"
			break
		end

		task.wait(0.05)
	end

	connection:Disconnect()
	return result
end

local function computePath(fromPosition, targetPosition)
	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
		AgentCanClimb = true,
		WaypointSpacing = 3,
	})

	local ok = pcall(function()
		path:ComputeAsync(fromPosition, targetPosition)
	end)
	if ok and path.Status == Enum.PathStatus.Success then
		return path
	end
	return nil
end

local function walkTo(npc, target)
	local hum = npc:FindFirstChildOfClass("Humanoid")
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then
		return false
	end

	hum.AutoRotate = true
	pcall(function()
		hrp:SetNetworkOwner(nil)
	end)

	local startedAt = os.clock()
	local repaths = 0

	while repaths < MAX_REPATHS and os.clock() - startedAt < MAX_WALK_TIME do
		if not npc.Parent or npc:GetAttribute("Downed") then
			return false
		end

		local targetPosition = resolveTarget(target)
		if not targetPosition then
			return false
		end
		if flatDistance(hrp.Position, targetPosition) <= ARRIVAL_RADIUS then
			return true
		end

		-- A small retry offset helps with corners while preserving the real target.
		local pathTarget = targetPosition
		if repaths > 0 then
			local angle = repaths * 2.4
			local radius = math.min(repaths * 0.75, 2.25)
			pathTarget += Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
		end

		local path = computePath(hrp.Position, pathTarget)
		if path then
			local waypoints = path:GetWaypoints()
			local currentWaypoint = 2
			local blockedAhead = false
			local blockedConnection = path.Blocked:Connect(function(index)
				if index >= currentWaypoint then
					blockedAhead = true
				end
			end)

			for index = 2, #waypoints do
				currentWaypoint = index
				if blockedAhead then
					break
				end

				local result = moveStep(npc, hum, hrp, waypoints[index], 4)
				if result ~= "reached" then
					break
				end

				local latestTarget = resolveTarget(target)
				if not latestTarget then
					blockedAhead = true
					break
				end
				if typeof(target) == "Instance" and flatDistance(latestTarget, targetPosition) > 5 then
					blockedAhead = true
					break
				end
			end

			blockedConnection:Disconnect()

			local latestTarget = resolveTarget(target)
			if latestTarget and flatDistance(hrp.Position, latestTarget) <= ARRIVAL_RADIUS + 2 then
				return true
			end
		else
			-- A direct attempt still works through doors because NPCs ignore door collision.
			local directWaypoint = {
				Position = targetPosition,
				Action = Enum.PathWaypointAction.Walk,
			}
			moveStep(npc, hum, hrp, directWaypoint, 2.5)
			if flatDistance(hrp.Position, targetPosition) <= ARRIVAL_RADIUS + 2 then
				return true
			end
		end

		repaths += 1
		task.wait(0.1)
	end

	-- Last resort: never leave a patient permanently frozen in the game flow.
	local targetPosition = resolveTarget(target)
	if not targetPosition then
		return false
	end

	local directWaypoint = {
		Position = targetPosition,
		Action = Enum.PathWaypointAction.Walk,
	}
	moveStep(npc, hum, hrp, directWaypoint, 2.5)
	if flatDistance(hrp.Position, targetPosition) <= 10 then
		return true
	end

	pcall(function()
		local rotation = hrp.CFrame - hrp.CFrame.Position
		hrp.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0)) * rotation
	end)
	return true
end

-- Grados que le FALTAN al NPC para mirar de frente a `part` (0 = de frente,
-- +/-180 = de espaldas). Signo: + = tiene que girar a su izquierda.
local function yawDiff(hrp, part)
	if not (hrp and part) then return nil end
	local flat = Vector3.new(part.Position.X, hrp.Position.Y, part.Position.Z) - hrp.Position
	if flat.Magnitude < 0.01 then return 0 end
	local dir = flat.Unit
	local lv = hrp.CFrame.LookVector
	local ang = math.deg(math.acos(math.clamp(lv:Dot(dir), -1, 1)))
	return (lv:Cross(dir).Y < 0) and -ang or ang
end

-- Imprime la orientacion del NPC (y respecto a que punto mira) en el Output.
local function dbgOrient(tag, npc, lookPart)
	if not DEBUG_ORIENTATION then return end
	local hrp = npc and npc:FindFirstChild("HumanoidRootPart")
	if not hrp then
		print(("[Orient] %-22s | %s | sin HumanoidRootPart"):format(tag, npc and npc.Name or "?"))
		return
	end
	local o = hrp.Orientation
	local lv = hrp.CFrame.LookVector
	local delta = yawDiff(hrp, lookPart)
	print(("[Orient] %-22s | %-18s | Orientation=(%.1f, %.1f, %.1f) | Look=(%.2f, %.2f, %.2f) | Delta al mostrador=%s")
		:format(tag, npc.Name, o.X, o.Y, o.Z, lv.X, lv.Y, lv.Z,
			delta and ("%.1f"):format(delta) or "s/lookAt"))
end

local function facePoint(npc, lookPart)
	-- Antes tenía `if npc:GetAttribute("DontFace") then return end`: eso dejaba a los
	-- impostores (Clown/Doctor/Ron, DontFace=true) mirando hacia donde caminaron
	-- (random) al llegar al mostrador. En el check-in TODOS deben mirar al mostrador.
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if not (hrp and lookPart) then return end

	-- POR QUÉ TODOS TERMINABAN MIRANDO AL MISMO LADO (y no al frente):
	-- moveStep corta el paso apenas entra en NEXT_WAYPOINT_RADIUS, SIN esperar a
	-- MoveToFinished, así que el Humanoid sigue con el MoveTo pendiente al último
	-- waypoint y, con AutoRotate encendido, vuelve a girar solo hacia la dirección
	-- de caminata (idéntica para todos, porque todos hacen el mismo camino) justo
	-- después de que facePoint los enderezaba. Se cancela el MoveTo y se apaga
	-- AutoRotate mientras esperan en el mostrador; walkTo lo vuelve a encender.
	local hum = npc:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:MoveTo(hrp.Position)
		hum.AutoRotate = false
	end

	local function aim()
		local pos = hrp.Position
		local look = Vector3.new(lookPart.Position.X, pos.Y, lookPart.Position.Z)
		if (look - pos).Magnitude < 0.01 then return end
		hrp.CFrame = CFrame.lookAt(pos, look)
	end
	aim()

	-- Re-afirma un par de veces por si el Humanoid alcanza a dar un último paso
	-- (solo mientras siga "plantado": si empieza a caminar, AutoRotate vuelve a
	-- true y este loop se corta solo).
	task.spawn(function()
		for _ = 1, 4 do
			task.wait(0.15)
			if not npc.Parent then return end
			if hum and hum.AutoRotate then return end
			if npc:GetAttribute("Sitting") then return end
			aim()
		end
	end)
end

-- Carga la anim de caminata en el Animator del NPC y la sincroniza con su
-- movimiento (Humanoid.Running): camina al moverse, para al detenerse. Se juega
-- en el server (el NPC es de red del server) y se replica a los clientes.
local function loadTrack(animator, id, priority)
	local anim = Instance.new("Animation")
	anim.AnimationId = id
	local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
	if not ok or not track then return nil end
	track.Looped = true
	track.Priority = priority
	return track
end

local function setupWalkAnimation(npc, hum)
	if not hum then return end
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = hum
	end
	local walk = loadTrack(animator, WALK_ANIM_ID, Enum.AnimationPriority.Movement)
	local idle = loadTrack(animator, IDLE_ANIM_ID, Enum.AnimationPriority.Idle)
	if idle then idle:Play(0.2) end -- arranca parado (idle)

	-- Token de debounce: al detenerse esperamos un poco antes de pasar a idle, para
	-- que el micro-stop entre waypoints del pathfinding NO haga parpadear walk<->idle.
	local moveToken = 0
	hum.Running:Connect(function(speed)
		moveToken += 1
		if not npc.Parent then
			if walk then walk:Stop(0.1) end
			if idle then idle:Stop(0.1) end
			return
		end
		if npc:GetAttribute("InBed") or npc:GetAttribute("Sitting") then
			-- echado en la cama (Sleep) o sentado en la sala de espera (Sit): esas
			-- anims mandan; no pisar con walk/idle.
			if walk then walk:Stop(0.1) end
			if idle then idle:Stop(0.1) end
			return
		end
		if speed > 0.1 then
			-- caminando: Walk(Old) (inmediato)
			if idle and idle.IsPlaying then idle:Stop(0.2) end
			if walk and not walk.IsPlaying then walk:Play(0.2) end
		else
			-- parado: idle, pero con retardo (si vuelve a moverse, se cancela)
			local my = moveToken
			task.delay(0.25, function()
				if my ~= moveToken or not npc.Parent or npc:GetAttribute("InBed") or npc:GetAttribute("Sitting") then return end
				if walk and walk.IsPlaying then walk:Stop(0.2) end
				if idle and not idle.IsPlaying then idle:Play(0.2) end
			end)
		end
	end)
end

local function fireCutsceneToAll(name, npc, ...)
	for _, player in ipairs(Players:GetPlayers()) do
		Network:FireClient(player, "PlayCutscene", name, npc, ...)
	end
end

--------------------------------------------------------------------------------
-- Retirarse
--------------------------------------------------------------------------------
local function leaveAndDespawn(npc)
	local leavePart = movePoint(LEAVE_POINT)
	if leavePart then
		walkTo(npc, leavePart.Position)
	end
	task.wait(0.5)
	PatientService:Despawn(npc)
end

--------------------------------------------------------------------------------
-- Helpers expuestos para PatientCareService (evita duplicar pathfinding/salida)
--------------------------------------------------------------------------------
function PatientService:WalkTo(npc, pos) return walkTo(npc, pos) end
function PatientService:MovePoint(name) return movePoint(name) end
function PatientService:LeaveAndDespawn(npc) return leaveAndDespawn(npc) end
-- Lo setea PatientCareService en su Init(). Si está, los pacientes reales pasan
-- a cuidados tras el check-in en vez de retirarse de inmediato.
PatientService.CareHandler = nil
-- Lo setea RejectionService: si está, el jugador decide admitir/rechazar en el
-- mostrador en vez de auto-rutear.
PatientService.DecisionHandler = nil

--------------------------------------------------------------------------------
-- API pública
--------------------------------------------------------------------------------
function PatientService:GetActivePatient()
	return activePatient
end

--------------------------------------------------------------------------------
-- SALA DE ESPERA — los pacientes que aún no se atienden se sientan en las sillas
-- (Workspace.Misc.Chairs, anim Sit); una cola FIFO los manda al mostrador de a uno.
--------------------------------------------------------------------------------
local chairs = {}       -- { {cf=CFrame, taken=false}, ... }
local queue = {}        -- FIFO de npcs esperando (sentados)
local chairOf = {}      -- [npc] = chair
local sitTracks = {}    -- [npc] = AnimationTrack
local sitPose = {}      -- [npc] = { [Motor6D]=C0 original } para restaurar al pararse
local sitCollide = {}   -- [npc] = { [BasePart]=CanCollide original } para restaurar al pararse
local waitingSet = {}   -- [npc] = true (desde spawn hasta CompleteCheckIn) = tope de aforo
local counterBusy = false
local dispatchNext      -- fwd decl

local function waitingCount()
	local n = 0
	for npc in pairs(waitingSet) do
		if npc.Parent then n += 1 else waitingSet[npc] = nil end
	end
	return n
end

local function buildChairs()
	local model = workspace:WaitForChild("Misc"):FindFirstChild("Chairs")
	table.clear(chairs)
	if not model then return end
	for _, part in ipairs(model:GetChildren()) do
		if part:IsA("BasePart") then
			local att = part:FindFirstChildWhichIsA("Attachment")
			if att then
				table.insert(chairs, { cf = att.WorldCFrame, taken = false })
			end
		end
	end
end

local function claimChair()
	for _, c in ipairs(chairs) do
		if not c.taken then c.taken = true; return c end
	end
	return nil
end

-- Posa las PIERNAS del NPC dobladas hacia adelante (sentado) rotando sus Motor6D.
-- Como la anim Sit es un asset inaccesible (Length 0), esto NO usa animación: mueve
-- los joints directamente. Identifica piernas+pies dinámicamente (partes bajas a los
-- lados del RootPart) porque el nombrado varía entre templates.
local function poseSit(npc)
	local root = npc:FindFirstChild("RootPart") or npc:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local perSide = { [1] = {}, [-1] = {} }   -- +X derecha, -X izquierda
	for _, d in ipairs(npc:GetDescendants()) do
		if d:IsA("Motor6D") and d.Part1 and d.Part1 ~= root then
			local rel = root.CFrame:PointToObjectSpace(d.Part1.Position)
			if rel.Y < -0.3 and math.abs(rel.X) > 0.1 then   -- parte baja y a un lado = pierna/pie
				table.insert(perSide[rel.X > 0 and 1 or -1], { motor = d, rel = rel, size = d.Part1.Size })
			end
		end
	end
	local saved = {}
	local R = CFrame.Angles(math.rad(SIT_LEG_ANGLE), 0, 0)
	local total = 0
	for _, parts in pairs(perSide) do
		if #parts > 0 then
			-- cadera = arriba de la parte más alta (la pierna) de ese lado
			local hipY, hipX = -math.huge, 0
			for _, e in ipairs(parts) do
				local top = e.rel.Y + e.size.Y / 2
				if top > hipY then hipY = top; hipX = e.rel.X end
			end
			local pivot = Vector3.new(hipX, hipY, 0)
			for _, e in ipairs(parts) do
				saved[e.motor] = e.motor.C0
				e.motor.C0 = CFrame.new(pivot) * R * CFrame.new(-pivot) * e.motor.C0
				total += 1
			end
		end
	end
	sitPose[npc] = saved
	dbg("poseSit", npc.Name, "joints posados=", total)
end

local function unposeSit(npc)
	local saved = sitPose[npc]
	if saved then
		for motor, c0 in pairs(saved) do
			if motor and motor.Parent then motor.C0 = c0 end
		end
		sitPose[npc] = nil
	end
end

local function sitDown(npc, chair)
	local hum = npc:FindFirstChildOfClass("Humanoid")
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if not (hum and hrp) then return end
	npc:SetAttribute("Sitting", true)
	hum.WalkSpeed = 0
	hum.AutoRotate = false
	hrp.CFrame = chair.cf * CFrame.new(0, SIT_HEIGHT, 0)
	hrp.Anchored = true

	-- Sentado queda ANCLADO (inamovible): si sigue con CanCollide, es un
	-- obstaculo solido en pleno medio de la sala de espera que el pathfinding
	-- no conoce (el navmesh no lo tiene en cuenta), asi que otros NPCs que
	-- tengan que pasar cerca quedan literalmente empujando contra el, atascados,
	-- hasta que el walkTo se rinde tras varios reintentos (de ahi la demora / el
	-- "se quedan al lado sin sentarse"). Se restaura en standUp.
	local savedCollide = {}
	for _, d in ipairs(npc:GetDescendants()) do
		if d:IsA("BasePart") then
			savedCollide[d] = d.CanCollide
			d.CanCollide = false
		end
	end
	sitCollide[npc] = savedCollide
	-- Reproducir la anim Sit en bucle con prioridad Action para que gane al idle.
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
	-- Parar walk/idle actuales para que no peleen con el sit.
	for _, t in ipairs(animator:GetPlayingAnimationTracks()) do t:Stop(0.1) end
	local track = loadTrack(animator, SIT_ANIM_ID, Enum.AnimationPriority.Action)
	if track then
		track:Play(0.2)
		sitTracks[npc] = track
	else
		-- Fallback (solo si la anim no cargara): sentar doblando piernas por Motor6D.
		dbg("sitDown: LoadAnimation Sit falló, uso poseSit", npc.Name)
		poseSit(npc)
		task.delay(0.4, function()
			if npc.Parent and npc:GetAttribute("Sitting") and not sitPose[npc] then
				poseSit(npc)
			end
		end)
	end
end

local function standUp(npc)
	npc:SetAttribute("Sitting", false)
	unposeSit(npc)   -- restaurar piernas ANTES de caminar
	local tr = sitTracks[npc]; if tr then tr:Stop(0.2); sitTracks[npc] = nil end
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.Anchored = false end
	local hum = npc:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = WALK_SPEED; hum.AutoRotate = true end
	local c = chairOf[npc]; if c then c.taken = false; chairOf[npc] = nil end

	local savedCollide = sitCollide[npc]
	if savedCollide then
		for part, orig in pairs(savedCollide) do
			if part and part.Parent then part.CanCollide = orig end
		end
		sitCollide[npc] = nil
	end
end

local function sendToCounter(npc)
	counterBusy = true
	activePatient = npc
	-- Alterna de estación para que se usen AMBOS mostradores (Form y Form2).
	local station = nextStation
	nextStation = (station == 1) and 2 or 1
	npc:SetAttribute("CheckInStation", station)
	task.spawn(function()
		local ci = movePoint(CHECKIN_POINTS[station]) or movePoint(CHECKIN_POINT)
		if ci then walkTo(npc, ci.Position) end
		if not npc.Parent then
			counterBusy = false
			task.spawn(dispatchNext)
			return
		end
		local lookPart = movePoint(CHECKIN_LOOKATS[station]) or movePoint(CHECKIN_LOOKAT)
		dbgOrient("llego (crudo)", npc, lookPart)
		facePoint(npc, lookPart)
		dbgOrient("tras facePoint", npc, lookPart)
		-- Giro extra mientras espera. Con ARRIVAL_TURN_Y = 0 NO se toca nada: el
		-- NPC se queda como lo dejo facePoint, mirando al frente del check-in.
		if ARRIVAL_TURN_Y ~= 0 then
			local waitHrp = npc:FindFirstChild("HumanoidRootPart")
			if waitHrp then
				waitHrp.CFrame = waitHrp.CFrame * CFrame.Angles(0, math.rad(ARRIVAL_TURN_Y), 0)
			end
			dbgOrient(("tras giro %d"):format(ARRIVAL_TURN_Y), npc, lookPart)
		end
		fireCutsceneToAll("VisitorArrived", npc)
		PatientService.Arrived:Fire(npc)
	end)
end

dispatchNext = function()
	if counterBusy then return end
	while #queue > 0 do
		local npc = table.remove(queue, 1)
		if npc and npc.Parent then
			standUp(npc)
			sendToCounter(npc)
			return
		end
	end
end

-- Llamado tras entrar: si el mostrador está libre va directo; si no, se sienta.
local function enterWaitingRoom(npc)
	if not counterBusy and #queue == 0 then
		dbg(npc.Name, "-> mostrador (directo, no se sienta)")
		sendToCounter(npc)
		return
	end
	local chair = claimChair()
	if chair then
		chairOf[npc] = chair
		table.insert(queue, npc)
		-- Caminar a un punto en el PISO frente a la silla (NO al asiento, que está
		-- sobre la silla y el pathfinding no lo alcanza -> por eso fallaba con dist alto).
		local approach = (chair.cf * CFrame.new(0, -1.8, -2.5)).Position
		dbg(npc.Name, "-> caminando al frente de la silla...")
		local reached = walkTo(npc, approach)
		local hrp = npc:FindFirstChild("HumanoidRootPart")
		local dist = hrp and math.floor((hrp.Position - approach).Magnitude) or -1
		dbg(npc.Name, "llegó al frente?", reached, "dist=", dist)
		if npc.Parent then sitDown(npc, chair) end
	else
		-- sin silla libre: igual encola (parado cerca del mostrador)
		table.insert(queue, npc)
		dbg(npc.Name, "sin silla libre, encolado parado")
		local ci = movePoint(CHECKIN_POINT)
		if ci then walkTo(npc, ci.Position + Vector3.new(0, 0, 10)) end
	end
end
PatientService._buildChairs = buildChairs

-- Saca un npc del sistema de espera (cola/silla/mostrador) SIN destruirlo. Lo usa
-- EmergencyService cuando un paciente es baleado (pasa a estado "downed").
function PatientService:RemoveFromWaiting(npc)
	local wasCounter = (activePatient == npc)
	if wasCounter then activePatient = nil end
	waitingSet[npc] = nil
	local tr = sitTracks[npc]; if tr then tr:Stop(0.1) end
	sitTracks[npc] = nil
	unposeSit(npc)   -- restaurar piernas si estaba sentado
	npc:SetAttribute("Sitting", false)
	local savedCollide = sitCollide[npc]
	if savedCollide then
		for part, orig in pairs(savedCollide) do
			if part and part.Parent then part.CanCollide = orig end
		end
		sitCollide[npc] = nil
	end
	for i = #queue, 1, -1 do if queue[i] == npc then table.remove(queue, i) end end
	local c = chairOf[npc]; if c then c.taken = false; chairOf[npc] = nil end
	if wasCounter and counterBusy then
		counterBusy = false
		task.spawn(dispatchNext)
	end
end

-- Llamado por CheckInService cuando el registro termina
-- Admite a un paciente a cuidados: reserva la sala REAL, anuncia ese número (para
-- que coincida con la sala a la que camina) y lo enruta a PatientCareService.
function PatientService:AdmitToCare(npc)
	local roomNumber
	if PatientService.ReserveCareRoom then
		roomNumber = PatientService.ReserveCareRoom(npc)
	end
	roomNumber = roomNumber or ((roomCounter % 8) + 1)
	roomCounter = roomNumber
	npc:SetAttribute("AssignedRoom", roomNumber)

	fireCutsceneToAll("VisitorCheckedIn", npc, tostring(roomNumber))

	if PatientService.CareHandler then
		task.spawn(PatientService.CareHandler, npc)
	else
		task.spawn(leaveAndDespawn, npc)
	end
end

function PatientService:CompleteCheckIn(npc)
	if not npc or not npc.Parent then return end

	-- Deja de estar girado esperando: vuelve a mirar derecho al mostrador
	-- antes de admitir/rechazar o retirarse.
	do
		local station = npc:GetAttribute("CheckInStation")
		local lookPart = (station and movePoint(CHECKIN_LOOKATS[station])) or movePoint(CHECKIN_LOOKAT)
		dbgOrient("CompleteCheckIn antes", npc, lookPart)
		facePoint(npc, lookPart)
		dbgOrient("CompleteCheckIn despues", npc, lookPart)
	end

	npc:SetAttribute("CheckedIn", true)
	PatientService.CheckedIn:Fire(npc)

	-- El mostrador queda libre: el siguiente paciente sentado se levanta y viene.
	waitingSet[npc] = nil
	counterBusy = false
	task.spawn(dispatchNext)

	-- Con RejectionService activo, el JUGADOR decide admitir/rechazar.
	if PatientService.DecisionHandler then
		task.spawn(PatientService.DecisionHandler, npc)
		return
	end

	-- Fallback (sin RejectionService): auto-rutea por IsPatient/Fake.
	local isRealPatient = npc:GetAttribute("IsPatient") == true and not npc:GetAttribute("Fake")
	if isRealPatient then
		PatientService:AdmitToCare(npc)
	else
		task.spawn(leaveAndDespawn, npc)
	end
end

function PatientService:SpawnPatient(templateName)
	local template = pickTemplate(templateName)
	local spawnPart = movePoint(SPAWN_POINT)
	local checkInPart = movePoint(CHECKIN_POINT)
	if not template or not spawnPart or not checkInPart then
		warn("[PatientService] falta plantilla o MovePoints")
		return
	end

	local npc = template:Clone()

	if npc:GetAttribute("IsPatient") == nil and not npc:GetAttribute("Fake") then
		npc:SetAttribute("IsPatient", true)
	end
	local dialogName = npc:GetAttribute("DisplayDialogName")
	local displayName
	if dialogName and dialogName ~= "" then
		displayName = dialogName
	elseif template == GENERIC_TEMPLATE then
		displayName = GENERIC_NAMES[math.random(1, #GENERIC_NAMES)]
		npc.Name = displayName
	else
		displayName = npc.Name
	end
	npc:SetAttribute("DisplayName", displayName)

	npc:PivotTo(spawnPart.CFrame + Vector3.new(0, 3, 0))
	npc.Parent = workspace.NPCs
	CollectionService:AddTag(npc, "NPC")

	-- Grupo de colisión: el NPC atraviesa puertas (no se atora en la hoja cerrada).
	-- Y DESANCLA todo: algunos rigs (p.ej. Clown) traen un accesorio anclado
	-- (Handle) soldado al cuerpo que ancla TODA la asamblea -> no camina.
	for _, p in ipairs(npc:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = false
			pcall(function() p.CollisionGroup = NPC_GROUP end)
		end
	end

	local hum = npc:FindFirstChildOfClass("Humanoid")
	local hrp = npc:FindFirstChild("HumanoidRootPart")
	if hum then hum.WalkSpeed = WALK_SPEED end
	if hrp then pcall(function() hrp:SetNetworkOwner(nil) end) end
	setupWalkAnimation(npc, hum)

	waitingSet[npc] = true

	-- Entra por la calle y va a la sala de espera (se sienta) o al mostrador si está libre.
	task.spawn(function()
		enterWaitingRoom(npc)
	end)

	return npc
end

function PatientService:Despawn(npc)
	if not npc then return end
	PatientService:RemoveFromWaiting(npc)
	npc:Destroy()
end

--------------------------------------------------------------------------------
-- Bootstrap
--------------------------------------------------------------------------------
function PatientService:Init()
	if self._initialized then return end
	self._initialized = true

	ensureCollisionGroups()
	setupPlayerCollision()   -- jugadores al grupo Players (no empujan a los NPCs)

	if not workspace:FindFirstChild("NPCs") then
		local f = Instance.new("Folder")
		f.Name = "NPCs"
		f.Parent = workspace
	end

	buildChairs()

	task.spawn(function()
		task.wait(2)
		-- Arranque: siembra rápido un mínimo de visitantes para que no esté vacío.
		for _ = 1, math.min(INITIAL_SPAWN, MAX_WAITING) do
			if waitingCount() < MAX_WAITING then
				self:SpawnPatient()
			end
			task.wait(0.6)
		end
		while true do
			-- Mantener la sala de espera poblada (cola + mostrador) hasta el tope.
			if waitingCount() < MAX_WAITING then
				self:SpawnPatient()
			end
			task.wait(RESPAWN_DELAY)
		end
	end)

	-- print("[PatientService] inicializado — sala de espera (sillas) + cola al mostrador")
end

return PatientService
