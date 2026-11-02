--[[
	DoorService  (Fase 2 — apertura de la entrada / "abrir el turno")

	La MainDoor (puerta de vidrio de la entrada) viene CERRADA y ningún script la
	manejaba (era server-side, perdido). Con ella cerrada el navmesh NO conecta
	la calle (MovePoints.outside) con el mostrador (checkIn) → los pacientes no
	pueden entrar. (Verificado: abrir SOLO la MainDoor conecta outside→checkIn.)

	Este servicio la abre al iniciar: baja las hojas "Door" (se hunden en el piso)
	y las deja CanCollide=false, además de la parte "block". Reproduce el sonido.

	API: DoorService:OpenMainDoor(), :CloseMainDoor()
]]

local TweenService = game:GetService("TweenService")

local DoorService = {}

local mainDoor = workspace.Misc:WaitForChild("MainDoor")
local originalCFrames = {}   -- [part] = CFrame original (para cerrar)
local isOpen = false

local OPEN_TWEEN = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function doorLeaves()
	local leaves = {}
	for _, d in ipairs(mainDoor:GetDescendants()) do
		if d:IsA("BasePart") and d.Name == "Door" then
			table.insert(leaves, d)
		end
	end
	return leaves
end

local function blockers()
	local t = {}
	for _, d in ipairs(mainDoor:GetDescendants()) do
		if d:IsA("BasePart") and (d.Name == "Door" or d.Name == "block") then
			table.insert(t, d)
		end
	end
	return t
end

local function playSound()
	local snd = mainDoor:FindFirstChild("Main") and mainDoor.Main:FindFirstChildOfClass("Sound")
	if snd then snd:Play() end
end

function DoorService:OpenMainDoor()
	if isOpen then return end
	isOpen = true

	-- libera colisión (conecta el navmesh calle -> mostrador)
	for _, p in ipairs(blockers()) do
		p.CanCollide = false
	end

	-- hunde las hojas en el piso para que se vea abierta
	for _, leaf in ipairs(doorLeaves()) do
		originalCFrames[leaf] = leaf.CFrame
		local down = leaf.CFrame - Vector3.new(0, leaf.Size.Y + 0.5, 0)
		TweenService:Create(leaf, OPEN_TWEEN, { CFrame = down }):Play()
	end

	playSound()
end

function DoorService:CloseMainDoor()
	if not isOpen then return end
	isOpen = false
	for leaf, cf in pairs(originalCFrames) do
		TweenService:Create(leaf, OPEN_TWEEN, { CFrame = cf }):Play()
	end
	task.delay(OPEN_TWEEN.Time, function()
		for _, p in ipairs(blockers()) do
			p.CanCollide = true
		end
	end)
	playSound()
end

function DoorService:Init()
	if self._initialized then return end
	self._initialized = true
	-- Abre la entrada al arrancar (inicio de turno).
	self:OpenMainDoor()
	print("[DoorService] inicializado — entrada abierta")
end

return DoorService
