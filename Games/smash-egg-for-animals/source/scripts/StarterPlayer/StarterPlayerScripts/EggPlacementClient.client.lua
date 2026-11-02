-- Quand un oeuf est en main : aperçu sous la souris, clic = poser à cet endroit dans la zone "animaux"
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local remotes = system:WaitForChild("Remotes")
local eggModels = system:WaitForChild("EggModels")

local player = Players.LocalPlayer
local bases = workspace:WaitForChild("all base")

local EGG_HALF_HEIGHT = 6.5
local EGG_MARGIN = 1.5 -- même valeur que PetServer
local MAX_RAY = 300
local GHOST_TRANSPARENCY = 0.5
local VALID_COLOR = Color3.fromRGB(90, 255, 120)
local INVALID_COLOR = Color3.fromRGB(255, 70, 70)
local HINT_PLACE = "Click in the animals area of your garden to place the egg"
local HINT_INVALID = "This is not the animals area of your garden!"

---------------------------------------------------------------- texte d'aide
local gui = Instance.new("ScreenGui")
gui.Name = "EggPlacementGui"
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

---------------------------------------------------------------- placement
local session = nil -- {Tool, Ghost, Ring, Connections, Position, Valid}

local function getZone()
	local number = player:GetAttribute("BaseNumber")
	local base = number and bases:FindFirstChild("base " .. number)
	return base and base:FindFirstChild("animaux")
end

local function stop()
	if not session then return end
	for _, connection in session.Connections do connection:Disconnect() end
	if session.Ghost then session.Ghost:Destroy() end
	session.Ring:Destroy()
	session = nil
	gui.Enabled = false
end

local function makeGhost(eggKey, sizeScale)
	local template = eggModels:FindFirstChild(eggKey)
	if not template then return nil end
	local ghost = template:Clone()
	ghost:ScaleTo(ghost:GetScale() * (sizeScale or 1))
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
	ring.Size = Vector3.new(0.15, 3.2, 3.2)
	ring.Material = Enum.Material.Neon
	ring.Transparency = 0.45
	ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch, ring.CastShadow = true, false, false, false, false
	ring.Parent = workspace
	return ring
end

-- point visé par la souris / le doigt, projeté sur le sol de la zone
local function aim(zone)
	local camera = workspace.CurrentCamera
	local location = UserInputService:GetMouseLocation()
	local ray = camera:ViewportPointToRay(location.X, location.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {player.Character, workspace:FindFirstChild("PlacedPets"), workspace:FindFirstChild("PlacedEggs"), session.Ghost, session.Ring}
	local hit = workspace:Raycast(ray.Origin, ray.Direction * MAX_RAY, params)
	if not hit then return nil, false end
	local lp = zone.CFrame:PointToObjectSpace(hit.Position)
	local valid = math.abs(lp.X) <= zone.Size.X / 2 - EGG_MARGIN and math.abs(lp.Z) <= zone.Size.Z / 2 - EGG_MARGIN and math.abs(lp.Y) < 4
	local ground = valid and (zone.CFrame * CFrame.new(lp.X, zone.Size.Y / 2, lp.Z)).Position or hit.Position
	return ground, valid
end

local function start(tool)
	stop()
	local ghost = makeGhost(tool:GetAttribute("EggKey"), tool:GetAttribute("SizeScale"))
	session = {Tool = tool, Ghost = ghost, Ring = makeRing(), Connections = {}, Valid = false}
	local half = ghost and EGG_HALF_HEIGHT * ghost:GetScale() or 0
	gui.Enabled = true

	table.insert(session.Connections, RunService.RenderStepped:Connect(function()
		local zone = getZone()
		if not zone then return end
		local position, valid = aim(zone)
		session.Position, session.Valid = position, valid
		hint.Text = (valid or not position) and HINT_PLACE or HINT_INVALID
		if position then
			session.Ring.Color = valid and VALID_COLOR or INVALID_COLOR
			session.Ring.CFrame = CFrame.new(position + Vector3.new(0, 0.1, 0)) * CFrame.Angles(0, 0, math.pi / 2)
			if ghost then ghost:PivotTo(CFrame.new(position + Vector3.new(0, half, 0))) end
		end
	end))

	table.insert(session.Connections, tool.Activated:Connect(function()
		if session and session.Valid and session.Position then
			remotes.PetAction:FireServer("PlaceEgg", tool:GetAttribute("EggId"), session.Position)
		end
	end))

	-- outil rangé, posé ou détruit : fin du placement
	table.insert(session.Connections, tool.AncestryChanged:Connect(function()
		if tool.Parent ~= player.Character then stop() end
	end))
end

local function watchCharacter(character)
	stop()
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") and child:GetAttribute("EggId") then start(child) end
	end)
	for _, child in character:GetChildren() do
		if child:IsA("Tool") and child:GetAttribute("EggId") then start(child) end
	end
end

player.CharacterAdded:Connect(watchCharacter)
if player.Character then watchCharacter(player.Character) end
