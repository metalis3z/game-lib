--[[
	DoorsService  (Fase 2 — puertas interactivas)

	Las puertas de Workspace.Doors (8 "Door" + 1 "MainDoor") YA traen su
	ProximityPrompt ("Open") en Puerta.Door.Handle, pero nadie conectaba el
	Triggered → no se abrían. Este servicio las hace funcionar: al usar el prompt,
	la hoja gira sobre su bisagra (la Part anclada "Movement" dentro de Puerta.Door)
	y suena; volver a usarlo la cierra.

	Técnica: la hoja es un cuerpo rígido (Parts soldadas). Anclamos todas sus
	partes al iniciar y las movemos por CFrame alrededor del eje vertical de la
	bisagra — determinista, sin depender de física, sin jitter.

	API: DoorsService:Init(), :SetOpen(doorModel, open)
]]

local TweenService = game:GetService("TweenService")
local PhysicsService = game:GetService("PhysicsService")

-- Las hojas van al grupo "MapDoors": los pacientes NPC (grupo "PatientNPC", ver
-- PatientService) NO colisionan con ellas y así no se atoran; el jugador SÍ.
local DOOR_GROUP = "MapDoors"
local NPC_GROUP = "PatientNPC"
local function ensureCollisionGroups()
	for _, g in ipairs({ DOOR_GROUP, NPC_GROUP }) do
		if not PhysicsService:IsCollisionGroupRegistered(g) then
			pcall(function() PhysicsService:RegisterCollisionGroup(g) end)
		end
	end
	pcall(function() PhysicsService:CollisionGroupSetCollidable(NPC_GROUP, DOOR_GROUP, false) end)
end

local DoorsService = {}

local OPEN_ANGLE = 90
local ANIM_TIME = 0.45
local STEPS = 18

local doors = {}   -- lista de estados { model, hinge, parts={[part]=closedCFrame}, prompt, angle, target, animating, sounds }

local function findFirstDescByName(root, name)
	for _, d in ipairs(root:GetDescendants()) do
		if d.Name == name then return d end
	end
	return nil
end

local function applyAngle(state, angle)
	local pivot = CFrame.new(state.hinge.Position)
	local rot = CFrame.Angles(0, math.rad(angle), 0)
	local transform = pivot * rot * pivot:Inverse()
	for part, closedCF in pairs(state.parts) do
		part.CFrame = transform * closedCF
	end
end

local function animate(state, target)
	if state.animating then
		state.target = target
		return
	end
	state.animating = true
	state.target = target

	-- sonido
	local snd = target > 0.5 and state.sounds.Open or state.sounds.Close
	if snd then snd:Play() end

	local start = state.angle
	for i = 1, STEPS do
		if state.target ~= target then -- cambió de dirección a mitad
			start = state.angle
			target = state.target
		end
		state.angle = start + (target - start) * (i / STEPS)
		applyAngle(state, state.angle)
		task.wait(ANIM_TIME / STEPS)
	end
	state.angle = state.target
	applyAngle(state, state.angle)
	state.animating = false
end

function DoorsService:SetOpen(state, open)
	animate(state, open and OPEN_ANGLE or 0)
	state.open = open
end

local function setupDoor(model)
	local swing = model:FindFirstChild("Puerta") and model.Puerta:FindFirstChild("Door")
	local hinge = swing and swing:FindFirstChild("Movement")
	local promptPart = swing and swing:FindFirstChild("Handle")
	local prompt = promptPart and promptPart:FindFirstChildOfClass("ProximityPrompt")
	if not (swing and hinge and prompt) then
		return
	end

	local state = {
		model = model,
		hinge = hinge,
		parts = {},
		prompt = prompt,
		angle = 0,
		open = false,
		animating = false,
		sounds = {},
	}

	-- ancla y guarda el CFrame cerrado de cada parte de la hoja
	for _, p in ipairs(swing:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = true
			state.parts[p] = p.CFrame
			pcall(function() p.CollisionGroup = DOOR_GROUP end)
		end
	end

	-- sonidos
	local soundsFolder = model.Puerta:FindFirstChild("DoorObjects") and model.Puerta.DoorObjects:FindFirstChild("Sounds")
	if soundsFolder then
		state.sounds.Open = soundsFolder:FindFirstChild("Open")
		state.sounds.Close = soundsFolder:FindFirstChild("Close")
	end

	prompt.Triggered:Connect(function(player)
		DoorsService:SetOpen(state, not state.open)
		prompt.ActionText = state.open and "Close" or "Open"
	end)

	table.insert(doors, state)
	return state
end

function DoorsService:Init()
	if self._initialized then return end
	self._initialized = true

	ensureCollisionGroups()

	local folder = workspace:FindFirstChild("Doors")
	if not folder then
		warn("[DoorsService] no existe Workspace.Doors")
		return
	end

	local count = 0
	for _, model in ipairs(folder:GetChildren()) do
		if model:IsA("Model") then
			if setupDoor(model) then count += 1 end
		end
	end

	print("[DoorsService] inicializado — " .. count .. " puertas activas")
end

return DoorsService
