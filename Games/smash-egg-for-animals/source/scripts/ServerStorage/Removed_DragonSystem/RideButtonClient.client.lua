-- Bouton RIDE, en bas de l'écran : il appelle le dragon du joueur, qui vient se poser sous lui, et le joueur monte dessus.
-- Dans la zone sûre le dragon dort sur l'arbre de la base (DragonServer) : c'est ce bouton qui le réveille.
-- Visible tant qu'on n'est pas en selle. Raccourcis : touche R (clavier), bouton Y (manette).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local action = ReplicatedStorage:WaitForChild("DragonSystem"):WaitForChild("DragonAction")
local TAG = "RideDragon"
local KEY, PAD = Enum.KeyCode.R, Enum.KeyCode.ButtonY
local STUD_TEXTURE = "rbxassetid://7447638591"
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local gui = Instance.new("ScreenGui")
gui.Name = "RideGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 2

-- le cadre porte la mise à l'échelle (UIScaler), le bouton garde son effet de survol (UIEffects)
local holder = Instance.new("Frame")
holder.Name = "Holder"
holder.BackgroundTransparency = 1
holder.AnchorPoint = Vector2.new(0.5, 1)
holder.Position = UDim2.new(0.5, 0, 1, -150) -- à la place de la barre d'endurance, qui n'existe qu'en selle
holder.Size = UDim2.fromOffset(240, 66)
holder.Visible = false -- (on ne touche pas à gui.Enabled : les cinématiques s'en servent pour cacher l'interface)
holder.Parent = gui
CollectionService:AddTag(holder, "AutoScale")

local button = Instance.new("TextButton")
button.Name = "Ride"
button.Text = ""
button.AutoButtonColor = false
button.Size = UDim2.fromScale(1, 1)
button.BackgroundColor3 = Color3.new(1, 1, 1)
button.BorderSizePixel = 0
button.Parent = holder
local shade = Instance.new("UIGradient")
shade.Rotation = 90
shade.Color = ColorSequence.new(Color3.fromRGB(150, 240, 110), Color3.fromRGB(46, 170, 66))
shade.Parent = button
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 2)
corner.Parent = button
local outline = Instance.new("UIStroke")
outline.Thickness = 4
outline.Color = Color3.new(0, 0, 0)
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outline.Parent = button
local studs = Instance.new("ImageLabel")
studs.Name = "Studs"
studs.BackgroundTransparency = 1
studs.Size = UDim2.fromScale(1, 1)
studs.Image = STUD_TEXTURE
studs.ImageTransparency = 0.2
studs.ScaleType = Enum.ScaleType.Tile
studs.TileSize = UDim2.fromOffset(22, 22)
studs.Parent = button

local function text(name, str, position, size, strokeThickness)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.BackgroundTransparency = 1
	label.Position, label.Size = position, size
	label.FontFace = FONT
	label.Text = str
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.ZIndex = 3
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = strokeThickness
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Parent = label
	label.Parent = button
	return label
end
local keyboard = UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled
text("Label", "RIDE", UDim2.fromScale(0.08, keyboard and 0.06 or 0.14), UDim2.fromScale(0.84, keyboard and 0.62 or 0.72), 3.5)
if keyboard then text("Key", "Press [R]", UDim2.fromScale(0.1, 0.66), UDim2.fromScale(0.8, 0.26), 2) end
gui.Parent = player:WaitForChild("PlayerGui")

local function myDragon()
	for _, dragon in CollectionService:GetTagged(TAG) do
		if dragon:GetAttribute("Owner") == player.UserId and dragon:IsDescendantOf(workspace) then return dragon end
	end
end

local lastCall = 0
local function ride()
	if not holder.Visible or os.clock() - lastCall < 0.8 then return end
	lastCall = os.clock()
	action:FireServer("Ride")
end
button.Activated:Connect(ride)
UserInputService.InputBegan:Connect(function(input, processed)
	if processed or UserInputService:GetFocusedTextBox() then return end
	if input.KeyCode == KEY or input.KeyCode == PAD then ride() end
end)

-- visible seulement à pied, vivant, avec un dragon à soi
local elapsed = 0
RunService.Heartbeat:Connect(function(dt)
	elapsed += dt
	if elapsed < 0.15 then return end
	elapsed = 0
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local dragon = myDragon()
	holder.Visible = humanoid ~= nil and humanoid.Health > 0 and humanoid.SeatPart == nil and dragon ~= nil and dragon:GetAttribute("Rider") == nil
end)
