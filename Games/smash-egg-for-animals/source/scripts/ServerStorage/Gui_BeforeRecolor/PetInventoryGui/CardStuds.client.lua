-- Texture "studs" sur chaque carte de l'inventaire (les cartes sont créées par InventoryHandler)
local grid = script.Parent:WaitForChild("Main"):WaitForChild("Grid")
local function add(card)
	if not card:IsA("GuiObject") or card:FindFirstChild("Studs") then return end
	local studs = Instance.new("ImageLabel")
	studs.Name = "Studs"
	studs.BackgroundTransparency = 1
	studs.Image = "rbxassetid://7447638591"
	studs.ScaleType = Enum.ScaleType.Tile
	studs.TileSize = UDim2.fromOffset(22, 22)
	studs.Size = UDim2.fromScale(1, 1)
	studs.ImageTransparency = 0.2
	studs.ZIndex = 0 -- au-dessus du fond de la carte, sous son contenu
	studs.Parent = card
end
for _, card in grid:GetChildren() do add(card) end
grid.ChildAdded:Connect(function(card) task.defer(add, card) end)
