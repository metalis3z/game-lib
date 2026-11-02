-- Quand un sachet de graines est en main : aperçu sous la souris, clic = planter à cet endroit dans la zone "plantes".
-- Le sachet reste en main tant qu'il reste des graines, pour en planter plusieurs à la suite.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local system = ReplicatedStorage:WaitForChild("PlantSystem")
local Config = require(system:WaitForChild("PlantConfig"))
local remotes = system:WaitForChild("Remotes")
local cropModels = system:WaitForChild("CropModels")

local player = Players.LocalPlayer
local bases = workspace:WaitForChild("all base")
local placedPlants = workspace:WaitForChild("PlacedPlants")

local ZONE_MARGIN = 1.5 -- même valeur que PlantServer
local MAX_RAY = 300
local GHOST_SCALE = 0.5
local GHOST_TRANSPARENCY = 0.5
local VALID_COLOR = Color3.fromRGB(90, 255, 120)
local INVALID_COLOR = Color3.fromRGB(255, 70, 70)
local HINT_PLANT = "Click in the plants area of your garden to plant"
local HINT_ZONE = "This is not the plants area of your garden!"
local HINT_CLOSE = "Too close to another plant!"

---------------------------------------------------------------- texte d'aide
local gui = Instance.new("ScreenGui")
gui.Name = "SeedPlantingGui"
gui.ResetOnSpawn = false
gui.Enabled = false
local hint = Instance.new("TextLabel")
hint.AnchorPoint = Vector2.new(0.5, 1)
hint.Position = UDim2.new(0.5, 0, 0.8, 0)
hint.Size = UDim2.new(0.7, 0, 0, 30)
hint.BackgroundTransparency = 1
hint.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
hint.TextScaled = true
hint.TextColor3 = Color3.new(1, 1, 1)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.new(0, 0, 0)
stroke.Thickness = 2.5
stroke.Parent = hint
hint.Parent = gui
gui.Parent = player:WaitForChild("PlayerGui")

---------------------------------------------------------------- plantation
local session = nil -- {Tool, Ghost, Ring, Connections, Position, Valid}

local function getZone()
	local number = player:GetAttribute("BaseNumber")
	local base = number and bases:FindFirstChild("base " .. number)
	return base and base:FindFirstChild("plantes")
end

local function stop()
	if not session then return end
	for _, connection in session.Connections do connection:Disconnect() end
	if session.Ghost then session.Ghost:Destroy() end
	session.Ring:Destroy()
	session = nil
	gui.Enabled = false
end

local function makeGhost(seedName)
	local template = cropModels:FindFirstChild(seedName)
	if not template then return nil end
	local ghost = template:Clone()
	ghost:ScaleTo(GHOST_SCALE)
	for _, part in ghost:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
			part.Transparency = math.max(part.Transparency, GHOST_TRANSPARENCY)
		end
	end
	ghost.Parent = workspace
	return ghost
end

local function makeRing()
	local ring = Instance.new("Part")
	ring.Shape = Enum.PartType.Cylinder
	ring.Size = Vector3.new(0.15, Config.MinSpacing, Config.MinSpacing)
	ring.Material = Enum.Material.Neon
	ring.Transparency = 0.45
	ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch, ring.CastShadow = true, false, false, false, false
	ring.Parent = workspace
	return ring
end

local function tooClose(position)
	for _, plant in placedPlants:GetChildren() do
		if plant:GetAttribute("Owner") == player.UserId then
			local other = plant:GetPivot().Position
			if (Vector2.new(other.X, other.Z) - Vector2.new(position.X, position.Z)).Magnitude < Config.MinSpacing then return true end
		end
	end
	return false
end

-- point visé par la souris / le doigt, projeté sur le sol de la zone ; renvoie aussi le texte d'aide
local function aim(zone)
	local camera = workspace.CurrentCamera
	local location = UserInputService:GetMouseLocation()
	local ray = camera:ViewportPointToRay(location.X, location.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {player.Character, placedPlants, workspace:FindFirstChild("PlacedPets"), workspace:FindFirstChild("PlacedEggs"), session.Ghost, session.Ring}
	local hit = workspace:Raycast(ray.Origin, ray.Direction * MAX_RAY, params)
	if not hit then return nil, false, HINT_PLANT end
	local lp = zone.CFrame:PointToObjectSpace(hit.Position)
	local inZone = math.abs(lp.X) <= zone.Size.X / 2 - ZONE_MARGIN and math.abs(lp.Z) <= zone.Size.Z / 2 - ZONE_MARGIN and math.abs(lp.Y) < 4
	if not inZone then return hit.Position, false, HINT_ZONE end
	local ground = (zone.CFrame * CFrame.new(lp.X, zone.Size.Y / 2, lp.Z)).Position
	if tooClose(ground) then return ground, false, HINT_CLOSE end
	return ground, true, HINT_PLANT
end

local function start(tool)
	stop()
	local seedName = tool:GetAttribute("SeedName")
	local ghost = makeGhost(seedName)
	session = {Tool = tool, Ghost = ghost, Ring = makeRing(), Connections = {}, Valid = false}
	gui.Enabled = true

	table.insert(session.Connections, RunService.RenderStepped:Connect(function()
		local zone = getZone()
		if not zone then return end
		local position, valid, text = aim(zone)
		session.Position, session.Valid = position, valid
		hint.Text = text
		if position then
			session.Ring.Color = valid and VALID_COLOR or INVALID_COLOR
			session.Ring.CFrame = CFrame.new(position + Vector3.new(0, 0.1, 0)) * CFrame.Angles(0, 0, math.pi / 2)
			if ghost then ghost:PivotTo(CFrame.new(position)) end
		end
	end))

	table.insert(session.Connections, tool.Activated:Connect(function()
		if session and session.Valid and session.Position then
			remotes.SeedAction:FireServer("Plant", seedName, session.Position)
		end
	end))

	-- sachet rangé, vidé ou détruit : fin de la plantation
	table.insert(session.Connections, tool.AncestryChanged:Connect(function()
		if tool.Parent ~= player.Character then stop() end
	end))
end

local function watchCharacter(character)
	stop()
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") and child:GetAttribute("SeedName") then start(child) end
	end)
	for _, child in character:GetChildren() do
		if child:IsA("Tool") and child:GetAttribute("SeedName") then start(child) end
	end
end

player.CharacterAdded:Connect(watchCharacter)
if player.Character then watchCharacter(player.Character) end
