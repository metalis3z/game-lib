-- Petits modèles 3D des étiquettes de mutation (ViewportFrames tag "SpinIcon", posés par SkyEventsServer avec l'attribut
-- IconModel) : on construit ici le modèle (ReplicatedStorage.SkyEvents.Models), centré et cadré, puis il tourne.
-- OPTIMISÉ : un ViewportFrame redessine son modèle à chaque mouvement. On ne construit et ne fait tourner que ceux qui sont
-- près de la caméra (NEAR), 20 fois par seconde ; les autres sont vidés.
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local models = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models")
local NEAR = 90
local views = {}   -- [viewport] = true
local icons = {}   -- [viewport] = {Model, Offset} (seulement ceux qui sont construits)

local function worldPart(view)
	local bb = view:FindFirstAncestorOfClass("BillboardGui")
	local part = bb and (bb.Adornee or bb.Parent)
	return part and part:IsA("BasePart") and part or nil
end

local function build(view)
	local name = view:GetAttribute("IconModel")
	local template = name and models:FindFirstChild(name)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	local box, size = model:GetBoundingBox()
	local offset = -box.Position
	model:PivotTo(CFrame.new(offset))
	model.Parent = view
	local distance = math.max(size.X, size.Y, size.Z) / (2 * math.tan(math.rad(20))) * 1.05
	local cam = view.CurrentCamera or Instance.new("Camera")
	cam.FieldOfView = 40
	cam.CFrame = CFrame.lookAt(Vector3.new(0, 0.6, -0.8).Unit * distance, Vector3.zero)
	cam.Parent = view
	view.CurrentCamera = cam
	icons[view] = {Model = model, Offset = offset}
end
local function unbuild(view)
	local icon = icons[view]
	if icon and icon.Model then icon.Model:Destroy() end
	icons[view] = nil
end

for _, v in CollectionService:GetTagged("SpinIcon") do views[v] = true end
CollectionService:GetInstanceAddedSignal("SpinIcon"):Connect(function(v) views[v] = true end)
CollectionService:GetInstanceRemovedSignal("SpinIcon"):Connect(function(v) views[v] = nil unbuild(v) end)

-- qui est près de la caméra ? (3 fois par seconde)
task.spawn(function()
	while true do
		task.wait(0.33)
		local camPos = workspace.CurrentCamera.CFrame.Position
		for view in views do
			if not view.Parent then
				views[view] = nil
				unbuild(view)
			else
				local part = worldPart(view)
				local near = part == nil or (part.Position - camPos).Magnitude < NEAR -- (icône d'interface : toujours)
				if near and not icons[view] then build(view)
				elseif not near and icons[view] then unbuild(view) end
			end
		end
	end
end)

-- rotation, 20 fois par seconde
local angle, acc = 0, 0
RunService.RenderStepped:Connect(function(dt)
	angle += dt * 1.6
	acc += dt
	if acc < 0.05 then return end
	acc = 0
	for view, icon in icons do
		if view.Parent and icon.Model.Parent then
			icon.Model:PivotTo(CFrame.Angles(0, angle, 0) * CFrame.new(icon.Offset))
		end
	end
end)
