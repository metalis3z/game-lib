--[[
	StaffDoor
	Abre la puerta de personal (Workspace.Misc.StaffDoorClosed) GIRANDO sus dos
	hojas (Glass Door > Model) +90° en Y sobre su PROPIO PIVOTE (bisagra): de la
	orientación cerrada (0,-90,0) a la abierta (0,0,0). Prompt Open/Close,
	sonido Main.Sound y panel Model.spins.ui alterna CLOSED/OPEN.
	El pivote de cada Model define la bisagra (ajustable en Studio).
]]

local door = workspace:WaitForChild("Misc"):WaitForChild("StaffDoorClosed")

-- Puerta doble: las hojas giran en sentido OPUESTO (una a -180, otra a 0).
-- Si quedan cambiadas de lado, poné FLIP = true.
local FLIP = false
local OPEN_TIME = 1.2
local STEPS     = 40
local PROMPT_NAME = "StaffDoorPrompt"
local OBJECT_TEXT = "Staff Door"

-- Las hojas de la puerta = los Models bajo "Glass Door".
local function leafModels(root)
	local gd = root:FindFirstChild("Glass Door")
	local t = {}
	if gd then
		for _, m in ipairs(gd:GetChildren()) do
			if m:IsA("Model") then table.insert(t, m) end
		end
	end
	return t
end

local leaves = leafModels(door)
-- Orden estable de las hojas (por Z, luego X) para asignarles sentidos opuestos.
table.sort(leaves, function(a, b)
	local pa, pb = a:GetPivot().Position, b:GetPivot().Position
	if math.abs(pa.Z - pb.Z) > 0.01 then return pa.Z < pb.Z end
	return pa.X < pb.X
end)

-- CFrame cerrado y abierto (mismo pivote, giro en Y sobre el pivote) de cada hoja.
-- Hoja 1 gira -90 (cerrada -90 -> abierta -180); hoja 2 gira +90 (-> 0). FLIP invierte.
local closedCF, openCF = {}, {}
for i, m in ipairs(leaves) do
	local swing = (i == 1) and math.rad(-90) or math.rad(90)
	if FLIP then swing = -swing end
	local c = m:GetPivot()
	closedCF[m] = c
	openCF[m] = CFrame.new(c.Position) * CFrame.Angles(0, swing, 0) * (c - c.Position)
end

-- Partes "Door" (el vidrio que bloquea) para desactivar colisión al abrir.
local blockers = {}
for _, m in ipairs(leaves) do
	for _, d in ipairs(m:GetDescendants()) do
		if d:IsA("BasePart") and d.Name == "Door" then table.insert(blockers, d) end
	end
end

local isOpen, animating = false, false

local function swingTo(targetOf)
	animating = true
	local starts = {}
	for _, m in ipairs(leaves) do starts[m] = m:GetPivot() end
	for i = 1, STEPS do
		local a = i / STEPS
		for _, m in ipairs(leaves) do
			m:PivotTo(starts[m]:Lerp(targetOf[m], a))
		end
		task.wait(OPEN_TIME / STEPS)
	end
	animating = false
end

local function playSound()
	local main = door:FindFirstChild("Main")
	local snd = main and main:FindFirstChildOfClass("Sound")
	if snd then pcall(function() snd:Play() end) end
end

local function setPanel(text)
	local model = door:FindFirstChild("Model")
	local spins = model and model:FindFirstChild("spins")
	local ui = spins and spins:FindFirstChild("ui")
	local label = ui and ui:FindFirstChildWhichIsA("TextLabel")
	if label then label.Text = text end
end

local function toggle()
	if animating then return end
	isOpen = not isOpen
	setPanel(isOpen and "OPEN" or "CLOSED")
	playSound()
	if isOpen then
		for _, p in ipairs(blockers) do p.CanCollide = false end
	end
	swingTo(isOpen and openCF or closedCF)
	if not isOpen then
		for _, p in ipairs(blockers) do if p.Parent then p.CanCollide = true end end
	end
end

-- Prompt en la primera hoja (sobre su PrimaryPart o una parte cualquiera).
local host = leaves[1] and (leaves[1].PrimaryPart or leaves[1]:FindFirstChildWhichIsA("BasePart", true))
if host then
	local old = host:FindFirstChild(PROMPT_NAME)
	if old then old:Destroy() end
	local pp = Instance.new("ProximityPrompt")
	pp.Name = PROMPT_NAME
	pp.ActionText = "Open"
	pp.ObjectText = OBJECT_TEXT
	pp.MaxActivationDistance = 12
	pp.RequiresLineOfSight = false
	pp.HoldDuration = 0.3
	pp.Parent = host
	pp.Triggered:Connect(function()
		toggle()
		pp.ActionText = isOpen and "Close" or "Open"
	end)
else
	warn("[StaffDoor] no encontré hojas (Glass Door > Model) en StaffDoorClosed")
end

setPanel("CLOSED")
-- print("[StaffDoor] listo — gira las hojas -90° sobre su pivote")
