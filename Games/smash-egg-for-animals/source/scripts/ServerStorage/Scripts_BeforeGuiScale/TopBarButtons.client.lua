-- Barre du haut : deux boutons ronds à droite des boutons Roblox (menu, chat, micro) : Inventaire puis Réglages.
-- Ils ouvrent les fenêtres existantes par les signaux ReplicatedStorage.UiSignals (ToggleInventory, ToggleSettings).
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local signals = ReplicatedStorage:WaitForChild("UiSignals")
local SIZE, GAP = 44, 8
local BUTTONS = {
	{Name = "Inventory", Signal = "ToggleInventory", Image = "rbxassetid://135211112386622"},
	{Name = "Settings", Signal = "ToggleSettings", Image = "rbxassetid://106209837661975"},
}

local gui = Instance.new("ScreenGui")
gui.Name = "TopBarGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 20
gui.Parent = player:WaitForChild("PlayerGui")
local row = Instance.new("Frame")
row.Name = "Row"
row.BackgroundTransparency = 1
row.Size = UDim2.fromOffset(#BUTTONS * (SIZE + GAP), SIZE)
row.Parent = gui

for index, info in BUTTONS do
	local button = Instance.new("ImageButton")
	button.Name = info.Name
	button.Position = UDim2.fromOffset((index - 1) * (SIZE + GAP), 0)
	button.Size = UDim2.fromOffset(SIZE, SIZE)
	button.BackgroundColor3 = Color3.fromRGB(18, 18, 21) -- le même fond que les boutons Roblox
	button.BackgroundTransparency = 0.08
	button.AutoButtonColor = false
	button.Image = ""
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.5, 0)
	corner.Parent = button
	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.BackgroundTransparency = 1
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.Position = UDim2.fromScale(0.5, 0.5)
	icon.Size = UDim2.fromScale(0.7, 0.7)
	icon.Image = info.Image
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Parent = button
	local scale = Instance.new("UIScale")
	scale.Parent = icon
	button.MouseEnter:Connect(function() button.BackgroundTransparency = 0.25 end)
	button.MouseLeave:Connect(function() button.BackgroundTransparency = 0.08 end)
	button.Activated:Connect(function()
		scale.Scale = 0.8
		TweenService:Create(scale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
		signals:WaitForChild(info.Signal):Fire()
	end)
	button.Parent = row
end

-- la place libre de la barre du haut commence après les boutons Roblox : on s'y colle
local function place()
	local inset = GuiService.TopbarInset
	local height = inset.Height > 0 and inset.Height or 58
	row.Position = UDim2.fromOffset(inset.Min.X + GAP, inset.Min.Y + math.floor((height - SIZE) / 2))
end
GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(place)
place()
