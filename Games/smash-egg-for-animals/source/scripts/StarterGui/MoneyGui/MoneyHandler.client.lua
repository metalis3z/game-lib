-- Affiche l'argent du joueur (attribut "Money") avec un compteur qui défile.
-- Quand on gagne de l'argent, un "+$N" vert jaillit à droite du compteur, puis monte vers le ciel en s'effaçant.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local player = Players.LocalPlayer
local holder = script.Parent:WaitForChild("Holder")
local amountLabel = holder:WaitForChild("Amount")
local scale = amountLabel:WaitForChild("UIScale")

local COUNT_TIME = 0.5
local POP_SCALE = 1.15
local QUIET_START = 5 -- secondes après l'arrivée sans "+$N" : le chargement de la sauvegarde n'est pas un gain

local shown = player:GetAttribute("Money") or 0
local from, to, elapsed = shown, shown, COUNT_TIME
amountLabel.Text = Config.FormatMoney(shown)

---------------------------------------------------------------- "+$N" à chaque gain
local GAIN_FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local OUT = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local RISE = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local startedAt = os.clock()
-- les "+$N" sont dessinés dans leur propre couche, au-dessus de la barre d'objets qui est juste à droite du compteur
local layer = Instance.new("ScreenGui")
layer.Name = "MoneyGainGui"
layer.DisplayOrder = 60
layer.ResetOnSpawn = false
layer.IgnoreGuiInset = script.Parent.IgnoreGuiInset
layer.Parent = player:WaitForChild("PlayerGui")
local pending, scheduled = 0, false
local function gainPopup(gained)
	local label = Instance.new("TextLabel")
	label.Name = "Gain"
	label:SetAttribute("No3D", true) -- pas de relief Text3D : il garderait un contour noir pendant le fondu
	label.BackgroundTransparency = 1
	label.FontFace = GAIN_FONT
	label.Text = "+" .. Config.FormatMoney(gained)
	label.TextSize = 38
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.Size = UDim2.fromOffset(320, 46)
	label.Rotation = 0 -- droit (italique par la police)
	local start = UDim2.fromOffset(holder.AbsolutePosition.X + 74 + amountLabel.TextBounds.X + 4, holder.AbsolutePosition.Y + holder.AbsoluteSize.Y / 2 + math.random(-6, 6))
	label.Position = start
	local color = Instance.new("UIGradient") -- vert vif, un peu plus soutenu en bas
	color.Rotation = 90
	color.Color = ColorSequence.new(Color3.fromRGB(170, 255, 110), Color3.fromRGB(60, 226, 50))
	color.Parent = label
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 4
	stroke.Color = Color3.fromRGB(14, 52, 18)
	stroke.Parent = label
	local size = Instance.new("UIScale")
	size.Scale = 0.3
	size.Parent = label
	label.Parent = layer
	-- 1. il sort vers la droite en grossissant
	TweenService:Create(label, OUT, {Position = start + UDim2.fromOffset(64, -4), Rotation = 0}):Play()
	TweenService:Create(size, OUT, {Scale = 1}):Play()
	-- 2. puis il monte vers le ciel et s'efface
	task.delay(0.42, function()
		TweenService:Create(label, RISE, {Position = start + UDim2.fromOffset(86, -112), TextTransparency = 1}):Play()
		TweenService:Create(stroke, RISE, {Transparency = 1}):Play()
		TweenService:Create(size, RISE, {Scale = 0.8}):Play()
		task.delay(0.8, function() label:Destroy() end)
	end)
end

player:GetAttributeChangedSignal("Money"):Connect(function()
	local money = player:GetAttribute("Money") or 0
	local spent = money < to
	local gained = money - to
	from, to, elapsed = shown, money, 0
	if spent then -- petit "pop" du compteur quand on dépense
		scale.Scale = POP_SCALE
		TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	elseif gained > 0 and os.clock() - startedAt > QUIET_START then
		-- plusieurs gains au même instant (plusieurs animaux qui paient) ne font qu'un seul "+$N"
		pending += gained
		if not scheduled then
			scheduled = true
			task.delay(0.12, function()
				scheduled = false
				local total = pending
				pending = 0
				gainPopup(total)
			end)
		end
	end
end)

RunService.RenderStepped:Connect(function(dt)
	if elapsed >= COUNT_TIME then return end
	elapsed = math.min(elapsed + dt, COUNT_TIME)
	local a = 1 - (1 - elapsed / COUNT_TIME) ^ 3
	shown = from + (to - from) * a
	amountLabel.Text = Config.FormatMoney(elapsed >= COUNT_TIME and to or shown)
end)
