-- Pose le tag (ServerScriptService.TagConfig) au-dessus de la tête des joueurs listés. L'effet "gleam" est animé côté client (TagClient).
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local Tags = require(script.Parent:FindFirstChild("TagConfig") or script.Parent:WaitForChild("TagConfig_Old")) -- la liste des tags, quel que soit son nom
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local byName = {}
for name, tag in Tags do byName[string.lower(name)] = tag end

local function label(parent, text, position, size, thickness)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = position, size
	l.FontFace = MONT
	l.Text = text
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Parent = l
	local gradient = Instance.new("UIGradient") -- couleurs glace -> flamme, animées par TagClient
	gradient.Parent = l
	CollectionService:AddTag(gradient, "TagGleam")
	CollectionService:AddTag(l, "Text3D") -- texte en relief
	l.Parent = parent
	return l
end

local function give(player, character)
	local tag = byName[string.lower(player.Name)]
	if not tag then return end
	local head = character:WaitForChild("Head", 10)
	if not head then return end
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PlayerTag"
	billboard.Size = UDim2.fromScale(9, 3.2)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, 4.2, 0)
	billboard.LightInfluence = 0
	billboard.MaxDistance = 250
	-- un seul texte : le titre, en gros (là où il y avait le pseudo). Ancien format {Title = ...} encore accepté.
	local title = type(tag) == "table" and (tag.Title or tag.Name) or tostring(tag)
	label(billboard, title, UDim2.fromScale(0, 0.36), UDim2.fromScale(1, 0.62), 3.5)
	billboard.Parent = head
end

local function onPlayer(player)
	player.CharacterAdded:Connect(function(character) give(player, character) end)
	if player.Character then task.spawn(give, player, player.Character) end
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end
