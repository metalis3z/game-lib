-- Message de zone : quand CE joueur entre dans une zone d'œufs, un bandeau apparaît en haut au milieu de son écran
-- (nom du lieu, puis "Recommended: [icône de vitesse] 750K speed") sur une bande sombre translucide. Il disparaît quand il en sort.
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local SpeedConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
local gui = script.Parent
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local ITALIC = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local FLAME_ICON = "rbxassetid://78970514864199"
local MARGIN = 25 -- le bandeau reste affiché un peu autour de la zone

local holder = Instance.new("CanvasGroup")
holder.Name = "Banner"
holder.AnchorPoint = Vector2.new(0.5, 0)
holder.Position = UDim2.new(0.5, 0, 0.12, 0)
holder.Size = UDim2.fromOffset(720, 150)
holder.BackgroundTransparency = 1
holder.GroupTransparency = 1
holder.Visible = false
holder.Parent = gui
holder:SetAttribute("ScaleMult", 1 / 1.2) -- 1,2 fois plus petit (UIScaler)
CollectionService:AddTag(holder, "AutoScale")
-- bande sombre translucide, qui s'efface sur les côtés
local band = Instance.new("Frame")
band.BackgroundColor3 = Color3.new(0, 0, 0)
band.BorderSizePixel = 0
band.Position = UDim2.fromScale(0, 0.12)
band.Size = UDim2.fromScale(1, 0.84)
local fade = Instance.new("UIGradient")
fade.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.18, 0.5), NumberSequenceKeypoint.new(0.82, 0.5), NumberSequenceKeypoint.new(1, 1)})
fade.Parent = band
band.Parent = holder

local function label(text, position, size, thickness, font)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = position, size
	l.FontFace = font or MONT
	l.Text = text
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	l.ZIndex = 2
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Parent = l
	l.Parent = holder
	return l
end
local SPEED_ICON = "rbxassetid://80184389303970" -- la chaussure de l'affichage de vitesse (SpeedGui)
local title = label("Forest Zone", UDim2.fromScale(0.05, 0.06), UDim2.fromScale(0.9, 0.5), 5)
local titleGradient = Instance.new("UIGradient")
titleGradient.Rotation = 90
titleGradient.Parent = title
local rarity = label("Common", UDim2.fromScale(0.15, 0.45), UDim2.fromScale(0.7, 0.2), 3.5, ITALIC)
local recommended = label("Recommended:", UDim2.fromScale(0.02, 0.69), UDim2.fromScale(0.3, 0.23), 4)
recommended.TextXAlignment = Enum.TextXAlignment.Right
local flame = Instance.new("ImageLabel")
flame.BackgroundTransparency = 1
flame.Image = FLAME_ICON
flame.ScaleType = Enum.ScaleType.Fit
flame.Position = UDim2.fromScale(0.51, 0.6)
flame.Size = UDim2.fromScale(0.08, 0.38)
flame.ZIndex = 3
flame.Parent = holder
flame.Visible = false -- plus de burn : la ligne affiche les points de vie des œufs de la zone
local burn = label("", UDim2.fromScale(0.34, 0.69), UDim2.fromScale(0.64, 0.23), 4)
burn.TextXAlignment = Enum.TextXAlignment.Left
rarity.Visible, recommended.Visible, burn.Visible = false, false, false
local row = Instance.new("Frame")
row.Name = "Recommendation"
row.BackgroundTransparency = 1
row.AnchorPoint = Vector2.new(0.5, 0)
row.Position = UDim2.fromScale(0.5, 0.6)
row.Size = UDim2.fromScale(1, 0.32)
row.ZIndex = 2
row.Parent = holder
local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = row
local function rowText(text, order)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.AutomaticSize = Enum.AutomaticSize.X
	l.Size = UDim2.fromScale(0, 1)
	l.FontFace = MONT
	l.TextSize = 36
	l.Text = text
	l.TextColor3 = Color3.new(1, 1, 1)
	l.LayoutOrder = order
	l.ZIndex = 3
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 4
	stroke.Parent = l
	l.Parent = row
	return l
end
rowText("Recommended:", 1)
local speedIcon = Instance.new("ImageLabel")
speedIcon.BackgroundTransparency = 1
speedIcon.Image = SPEED_ICON
speedIcon.ScaleType = Enum.ScaleType.Fit
speedIcon.Size = UDim2.fromOffset(46, 46)
speedIcon.LayoutOrder = 2
speedIcon.ZIndex = 3
speedIcon.Parent = row
local speedText = rowText("0 speed", 3)
local speedGradient = Instance.new("UIGradient")
speedGradient.Rotation = 90
speedGradient.Color = ColorSequence.new(Color3.fromRGB(150, 245, 255), Color3.fromRGB(40, 190, 255))
speedGradient.Parent = speedText
local burnGradient = Instance.new("UIGradient")
burnGradient.Rotation = 90
burnGradient.Color = ColorSequence.new(Color3.fromRGB(255, 230, 90), Color3.fromRGB(255, 90, 30))
burnGradient.Parent = burn

local SHOW_TIME = 3 -- le bandeau reste 3 secondes quand on entre dans une zone, puis s'efface même si on y est encore
local current
local shownId = 0
local function hide()
	local id = shownId
	local tween = TweenService:Create(holder, TweenInfo.new(0.3), {GroupTransparency = 1})
	tween:Play()
	tween.Completed:Connect(function() if shownId == id then holder.Visible = false end end)
end
local function show(zone)
	if zone == current then return end
	current = zone
	shownId += 1
	if zone then
		local id = shownId
		task.delay(SHOW_TIME, function() if shownId == id then hide() end end)
		title.Text = zone:GetAttribute("ZoneTitle") or zone.Name
		titleGradient.Color = ColorSequence.new(zone:GetAttribute("ZoneColor1") or Color3.new(1, 1, 1), zone:GetAttribute("ZoneColor2") or Color3.new(1, 1, 1))
		-- le script Text3D recopie le dégradé sur sa face : on la met à jour aussi
		local face = title:FindFirstChild("Face3D")
		local faceGradient = face and face:FindFirstChildOfClass("UIGradient")
		if faceGradient then faceGradient.Color = titleGradient.Color end
		rarity.Text = (zone:GetAttribute("ZoneRarity") or "") .. "  ·  Eggs " .. (zone:GetAttribute("ZoneHp") or 0) .. " HP"
		rarity.TextColor3 = zone:GetAttribute("ZoneRarityColor") or Color3.new(1, 1, 1)
		local speed = zone:GetAttribute("ZoneSpeed") or 0
		speedText.Text = speed > 0 and (SpeedConfig.Format(speed) .. " speed") or "any speed"
		holder.Visible = true
		holder.Position = UDim2.new(0.5, 0, 0.08, 0)
		TweenService:Create(holder, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {GroupTransparency = 0, Position = UDim2.new(0.5, 0, 0.12, 0)}):Play()
	else
		hide()
	end
end

while true do
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local found
	if hrp then
		for _, zone in CollectionService:GetTagged("EggZoneArea") do
			if zone:IsA("BasePart") and zone:GetAttribute("ZoneTitle") then
				local r = zone.CFrame:PointToObjectSpace(hrp.Position)
				if math.abs(r.X) <= zone.Size.X / 2 + MARGIN and math.abs(r.Z) <= zone.Size.Z / 2 + MARGIN and r.Y > -zone.Size.Y then found = zone break end
			end
		end
	end
	show(found)
	task.wait(0.25)
end
