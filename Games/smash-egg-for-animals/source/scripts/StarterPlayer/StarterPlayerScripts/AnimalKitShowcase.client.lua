-- Vitrine des animaux de AnimalKit : désactivée par défaut. Active ce script (Disabled = false) puis lance Play pour les voir
-- tous animés sur une plateforme dans le ciel ; ils alternent repos et déplacement toutes les 4 secondes.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animator = require(ReplicatedStorage:WaitForChild("AnimalKit"):WaitForChild("AnimalAnimator"))

local ORIGIN = Vector3.new(3000, 2000, 3000)
local COLUMNS, SPACING, HEIGHT = 12, 16, 7
local names = Animator.names()
local rows = math.ceil(#names / COLUMNS)

local stage = Instance.new("Model")
stage.Name = "AnimalKitShowcase"
local floor = Instance.new("Part")
floor.Anchored = true
floor.Size = Vector3.new(COLUMNS * SPACING + 40, 2, rows * SPACING + 60)
floor.Position = ORIGIN + Vector3.new(0, -1, (rows - 1) * SPACING / 2 - 10)
floor.Color = Color3.fromRGB(110, 170, 110)
floor.Material = Enum.Material.SmoothPlastic
floor.Parent = stage
stage.Parent = workspace

local anims = {}
for i, name in names do
	local col, row = (i - 1) % COLUMNS, math.floor((i - 1) / COLUMNS)
	local src = ReplicatedStorage.AnimalKit.Models[name]
	local move = src:GetAttribute("Move")
	local lift = (move == "Fly" or move == "Swim" or move == "Drift") and 3 or 0
	local height = (src:GetAttribute("Length") > src:GetAttribute("Height") * 4) and 2.5 or HEIGHT -- les serpents restent bas
	local model, anim = Animator.spawn(name, CFrame.new(ORIGIN + Vector3.new((col - (COLUMNS - 1) / 2) * SPACING, lift, row * SPACING)) * CFrame.Angles(0, math.rad(180), 0), {height = height, parent = stage})
	local tag = Instance.new("BillboardGui")
	tag.Size, tag.StudsOffset, tag.AlwaysOnTop = UDim2.fromOffset(160, 26), Vector3.new(0, model.PrimaryPart.Size.Y / 2 + 2, 0), false
	local label = Instance.new("TextLabel")
	label.Size, label.BackgroundTransparency, label.Text, label.TextScaled = UDim2.fromScale(1, 1), 1, name, true
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.TextColor3 = Color3.new(1, 1, 1)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Parent = label
	label.Parent = tag
	tag.Parent = model.PrimaryPart
	table.insert(anims, anim)
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local spot = ORIGIN + Vector3.new(0, 6, -24)
task.spawn(function() -- le jeu replace le joueur à son arrivée : on insiste quelques secondes
	for _ = 1, 12 do
		if (hrp.Position - spot).Magnitude > 60 then hrp.CFrame = CFrame.new(spot, ORIGIN + Vector3.new(0, 6, 0)) end
		task.wait(0.5)
	end
end)

local moving = false
while true do
	task.wait(4)
	moving = not moving
	for _, anim in anims do anim:play(moving and "Move" or "Idle") end
end
