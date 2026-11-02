-- Texte « Admin Skipped your egg time ! » quand un admin fait GLOBALSKIPFUSEEGG (PetServer) et que le joueur avait
-- un œuf de la Fuse Machine qui couvait dans sa base.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local remote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("FuseEggSkipped")
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local gui = Instance.new("ScreenGui")
gui.Name = "FuseEggSkipGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 50
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.fromScale(0.5, 0.28)
label.Size = UDim2.fromScale(0.7, 0.09)
label.BackgroundTransparency = 1
label.FontFace = FONT
label.Text = "Admin Skipped your egg time !"
label.TextScaled = true
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextTransparency = 1
label.Visible = false
label.Parent = gui
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new(Color3.fromRGB(255, 225, 90), Color3.fromRGB(200, 120, 255))
gradient.Rotation = 90
gradient.Parent = label
local stroke = Instance.new("UIStroke")
stroke.Thickness = 4
stroke.Color = Color3.fromRGB(40, 10, 70)
stroke.Transparency = 1
stroke.Parent = label
local scale = Instance.new("UIScale")
scale.Parent = label
local sizeLimit = Instance.new("UITextSizeConstraint")
sizeLimit.MaxTextSize = 60
sizeLimit.Parent = label

local token = 0
remote.OnClientEvent:Connect(function()
	token += 1
	local mine = token
	label.Visible = true
	scale.Scale = 0.4
	label.TextTransparency, stroke.Transparency = 0, 0
	TweenService:Create(scale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.wait(4)
	if mine ~= token then return end
	local info = TweenInfo.new(0.6)
	TweenService:Create(label, info, {TextTransparency = 1}):Play()
	TweenService:Create(stroke, info, {Transparency = 1}):Play()
	task.wait(0.6)
	if mine == token then label.Visible = false end
end)
