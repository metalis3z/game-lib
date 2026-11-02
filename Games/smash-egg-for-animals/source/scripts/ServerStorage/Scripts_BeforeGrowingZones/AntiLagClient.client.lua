-- Anti-lag : seuls les décors et les œufs des zones proches de la caméra sont dans le monde de ce joueur.
-- Ceux des zones lointaines attendent dans un dossier hors du Workspace (ils ne sont plus dessinés ni simulés) et reviennent
-- quand on s'approche. Une seule zone change par passage, pour ne pas faire de saccade.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SHOW, HIDE = 340, 430 -- distance (studs, le long du couloir) entre la caméra et le centre de la zone : on affiche en dessous de SHOW, on cache au-dessus de HIDE
local hidden = Instance.new("Folder")
hidden.Name = "AntiLagHidden"
hidden.Parent = ReplicatedStorage

local entries = {} -- {Instance, Home, CenterX, Shown}
local function add(instance, home, centerX)
	if not centerX then return end
	for _, e in entries do if e.Instance == instance then return end end
	table.insert(entries, {Instance = instance, Home = home, CenterX = centerX, Shown = true})
end

task.spawn(function() -- décors des plateaux et des zones
	local decor = workspace:WaitForChild("ZoneDecor", 30)
	if not decor then return end
	for _, folder in decor:GetChildren() do add(folder, decor, folder:GetAttribute("CenterX")) end
	decor.ChildAdded:Connect(function(folder) task.defer(function() if folder.Parent == decor then add(folder, decor, folder:GetAttribute("CenterX")) end end) end)
end)
task.spawn(function() -- œufs : un dossier par zone, du nom de la pièce de la zone
	local eggs = workspace:WaitForChild("ZoneEggs", 30)
	if not eggs then return end
	local function watch(folder)
		local zone = workspace:FindFirstChild(folder.Name) or workspace:WaitForChild(folder.Name, 10)
		if zone and zone:IsA("BasePart") then add(folder, eggs, zone.Position.X) end
	end
	for _, folder in eggs:GetChildren() do task.spawn(watch, folder) end
	eggs.ChildAdded:Connect(function(folder) task.spawn(function() if folder.Parent == eggs then watch(folder) end end) end)
end)
task.spawn(function() -- décors d'origine de la zone Halloween
	local model = workspace:WaitForChild("Halloween Zone Decor", 30)
	local zone = workspace:WaitForChild("Halloween demon egg zone", 30)
	if model and zone then add(model, workspace, zone.Position.X) end
end)

while true do
	task.wait(0.35)
	local camera = workspace.CurrentCamera
	if camera then
		local x = camera.CFrame.Position.X
		-- la zone la plus proche à faire revenir d'abord ; sinon la plus lointaine à cacher
		local best, bestDistance, show
		for _, e in entries do
			local d = math.abs(x - e.CenterX)
			if not e.Shown and d < SHOW and (not show or d < bestDistance) then best, bestDistance, show = e, d, true end
			if e.Shown and d > HIDE and not show and (not best or d > bestDistance) then best, bestDistance = e, d end
		end
		if best and best.Instance.Parent then
			best.Shown = show == true
			best.Instance.Parent = best.Shown and best.Home or hidden
		end
	end
end
