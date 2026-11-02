-- Guide "HOW TO PLAY" : explique le jeu en 5 étapes (bouton Guide de la colonne de gauche)
-- Même style que les autres fenêtres du jeu (ReplicatedStorage.UIKit)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local UI = require(ReplicatedStorage:WaitForChild("UIKit"))
local player = Players.LocalPlayer
local gui = script.Parent
local touch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local new = UI.new

local STEPS = {
	{Icon = "👟", Color = "green", Title = "Train your speed",
		Text = "Stand on the treadmill next to your garden: every step gives you speed, and speed makes you run faster. Upgrade the treadmill on its board to gain more per step."},
	{Icon = "🔨", Color = "orange", Title = "Break an egg",
		Text = touch and "Run to an egg zone and hold the HIT button next to an egg until it breaks. Eggs of rare zones have more HP!"
			or "Run to an egg zone and hold [Left Click] next to an egg to hit it with your hammer until it breaks. Eggs of rare zones have more HP!"},
	{Icon = "✋", Color = "blue", Title = "Grab your pet",
		Text = touch and "Go next to the pet that hatched and tap GRAB. Watch out: the zone guardian chases you!"
			or "Go next to the pet that hatched and hold [E] to grab it. Watch out: the zone guardian chases you!"},
	{Icon = "🏠", Color = "purple", Title = "Bring it home",
		Text = touch and "Run back to the Safe Zone. Open your Inventory at the top of the screen, tap your pet, then tap your garden to place it. It makes money every second!"
			or "Run back to the Safe Zone. Open your Inventory [B], click your pet, then click your garden to place it. It makes money every second!"},
	{Icon = "🚀", Color = "red", Title = "Get stronger",
		Text = "Spend your money on treadmill upgrades to outrun the guardians of the rare zones, Rebirth for a money boost, fill the Index and join events to get x4 / x5 eggs!"},
}

---------------------------------------------------------------- fenêtre (style du jeu)
local window, header, title, close, scale = UI.window(gui, "Window", UDim2.fromOffset(560, 430), "How to Play", "blue")

-- carte de l'étape
local card = UI.box(window, {Name = "Card", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 80), Size = UDim2.new(1, -20, 0, 250)})
local badge = new("Frame", {Name = "Badge", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.fromOffset(140, 140), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3}, card)
UI.corner(badge)
UI.outline(badge, 3)
local badgeShade = new("UIGradient", {Name = "Shade", Rotation = 90}, badge)
UI.studs(badge, 26)
local icon = UI.text(badge, {Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 4, Stroke = false})
new("UIPadding", {PaddingTop = UDim.new(0, 22), PaddingBottom = UDim.new(0, 22), PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 22)}, icon)
local stepNum = UI.text(card, {Name = "StepNum", Position = UDim2.new(0, 172, 0, 16), Size = UDim2.new(1, -188, 0, 26), Text = "Step 1/5", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3})
local stepGrad = new("UIGradient", {Rotation = 90}, stepNum)
local stepTitle = UI.text(card, {Name = "StepTitle", Position = UDim2.new(0, 172, 0, 44), Size = UDim2.new(1, -188, 0, 40), Text = "", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3, Stroke = 4})
local stepText = UI.text(card, {Name = "StepText", Position = UDim2.new(0, 172, 0, 92), Size = UDim2.new(1, -188, 1, -104), Text = "", TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3, Stroke = 3})
new("UITextSizeConstraint", {MaxTextSize = 24}, stepText)

-- navigation : précédent / points / suivant
local back = UI.button(window, "< Back", "grey", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -14), Size = UDim2.fromOffset(160, 56)})
local nextB = UI.button(window, "Next >", "green", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -14, 1, -14), Size = UDim2.fromOffset(160, 56)})
local dots = new("Frame", {Name = "Dots", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -32), Size = UDim2.fromOffset(170, 24)}, window)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8)}, dots)
local dotList = {}
for i = 1, #STEPS do
	local d = new("Frame", {Size = UDim2.fromOffset(18, 18), BackgroundColor3 = Color3.new(1, 1, 1), LayoutOrder = i}, dots)
	UI.corner(d)
	UI.outline(d, 2.5)
	dotList[i] = d
end

local current = 1
local function show(i, animate)
	current = math.clamp(i, 1, #STEPS)
	local st = STEPS[current]
	local c = UI.COLORS[st.Color]
	icon.Text = st.Icon
	badgeShade.Color = ColorSequence.new(c[1], c[2])
	stepNum.Text = "Step " .. current .. "/" .. #STEPS
	stepGrad.Color = ColorSequence.new(c[1], c[2])
	stepTitle.Text = st.Title
	stepText.Text = st.Text
	for k, d in dotList do
		d.BackgroundColor3 = k == current and c[2] or Color3.new(1, 1, 1)
		d.Size = k == current and UDim2.fromOffset(24, 24) or UDim2.fromOffset(18, 18)
	end
	back.Visible = current > 1
	nextB.Text = current == #STEPS and "Let's go!" or "Next >"
	UI.recolor(nextB, current == #STEPS and "orange" or "green")
	if animate then
		card.Position = UDim2.new(0.5, 0, 0, 92)
		TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0, 80)}):Play()
		badge.Rotation = -12
		TweenService:Create(badge, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
	end
end

local open = false
local function setOpen(v)
	open = v
	if v then
		show(1)
		window.Visible = true
		local target = scale.Scale
		scale.Scale = target * 0.85
		TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = target}):Play()
	else
		window.Visible = false
	end
end

nextB.Activated:Connect(function()
	if current == #STEPS then setOpen(false) else show(current + 1, true) end
end)
back.Activated:Connect(function() show(current - 1, true) end)
close.Activated:Connect(function() setOpen(false) end)
UserInputService.InputBegan:Connect(function(input, processed)
	if processed or not open then return end
	if input.KeyCode == Enum.KeyCode.Escape then setOpen(false)
	elseif input.KeyCode == Enum.KeyCode.Right then
		if current == #STEPS then setOpen(false) else show(current + 1, true) end
	elseif input.KeyCode == Enum.KeyCode.Left and current > 1 then show(current - 1, true) end
end)

-- le bouton Guide de la colonne de gauche ouvre / ferme le guide
task.spawn(function()
	local holder = player:WaitForChild("PlayerGui"):WaitForChild("left bottom", 30)
	holder = holder and holder:WaitForChild("Holder", 10)
	local button = holder and holder:WaitForChild("GuideButton", 10)
	if button then button.Activated:Connect(function() setOpen(not open) end) end
end)
