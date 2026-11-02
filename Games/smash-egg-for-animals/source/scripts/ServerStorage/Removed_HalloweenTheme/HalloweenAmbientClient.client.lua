-- Thème Halloween : toutes les lumières du décor (Workspace.HalloweenTheme) vacillent comme des bougies.
-- Seules les lumières proches de la caméra sont animées, dix fois par seconde.
local CollectionService = game:GetService("CollectionService")
local RANGE = 260
local lights = {}
local function add(d)
	if d:IsA("PointLight") and not lights[d] then
		lights[d] = {Base = d.Brightness, Seed = math.random() * 100}
	end
end
local function watch(root)
	for _, d in root:GetDescendants() do add(d) end
	root.DescendantAdded:Connect(add)
	root.DescendantRemoving:Connect(function(d) lights[d] = nil end)
end
task.spawn(function()
	local theme = workspace:WaitForChild("HalloweenTheme", 30)
	if theme then watch(theme) end
end)
while true do
	local camera = workspace.CurrentCamera
	local eye = camera and camera.CFrame.Position
	local t = os.clock()
	if eye then
		for light, info in lights do
			local holder = light.Parent
			if holder and holder:IsA("BasePart") and (holder.Position - eye).Magnitude < RANGE then
				light.Brightness = info.Base * (0.82 + 0.14 * math.sin(t * 9 + info.Seed) + 0.1 * math.noise(t * 3, info.Seed))
			end
		end
	end
	task.wait(0.1)
end
