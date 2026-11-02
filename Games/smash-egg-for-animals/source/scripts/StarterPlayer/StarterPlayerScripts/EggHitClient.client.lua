-- Œufs des zones : ce qu'on voit quand on les frappe au marteau.
--   barre de vie au-dessus de l'œuf (verte, puis jaune, puis rouge), avec un morceau blanc qui montre le coup qu'il vient de prendre
--   "-N" qui jaillit à chaque coup, éclair blanc sur la coquille, "CRACK!" et gerbe d'éclats quand il casse
-- Le serveur (EggZoneServer) ne fait que baisser l'attribut Hp de l'œuf : tout l'affichage est ici.
-- Les affichages sont accrochés à la racine de l'œuf.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")

local Format = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig")).Format
local folder = workspace:WaitForChild("ZoneEggs")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local ITALIC = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
-- couleur de la barre selon ce qu'il reste : {clair en haut, soutenu en bas}
local function barColors(ratio)
	if ratio > 0.5 then return rgb(160, 255, 110), rgb(40, 196, 70) end
	if ratio > 0.25 then return rgb(255, 236, 110), rgb(245, 170, 30) end
	return rgb(255, 150, 130), rgb(226, 44, 44)
end

local bars = {} -- [œuf] = {Gui, Fill, Ghost, Gradient, Label, Scale, Hp}

local function rootOf(egg) return egg.PrimaryPart or egg:FindFirstChild("Root") end

local function makeBar(egg, root)
	local height = egg:GetAttribute("Height") or 3
	local gui = Instance.new("BillboardGui")
	gui.Name = "EggHpBar"
	gui.Size = UDim2.new(7 + height * 0.7, 0, 1.6 + height * 0.16, 0)
	gui.StudsOffsetWorldSpace = Vector3.new(0, height / 2 + 5.5 + height * 0.42, 0)
	gui.AlwaysOnTop = false -- (avec true, les captures de Studio ne montrent pas l'affichage)
	gui.LightInfluence = 0
	gui.MaxDistance = 160 + height * 6
	local back = Instance.new("Frame")
	back.Name = "Back"
	back.AnchorPoint = Vector2.new(0.5, 0.5)
	back.Position = UDim2.fromScale(0.5, 0.5)
	back.Size = UDim2.fromScale(0.92, 0.62)
	back.BackgroundColor3 = rgb(28, 30, 40)
	back.BorderSizePixel = 0
	local outline = Instance.new("UIStroke")
	outline.Thickness = 4
	outline.Parent = back
	local scale = Instance.new("UIScale")
	scale.Parent = back
	local function layer(name, color, z)
		local f = Instance.new("Frame")
		f.Name = name
		f.BackgroundColor3 = color
		f.BorderSizePixel = 0
		f.Size = UDim2.fromScale(1, 1)
		f.ZIndex = z
		f.Parent = back
		return f
	end
	local ghost = layer("Ghost", WHITE, 1) -- le coup qu'il vient de prendre : reste un instant, puis fond
	local fill = layer("Fill", WHITE, 2)
	local gradient = Instance.new("UIGradient")
	gradient.Rotation = 90
	gradient.Parent = fill
	local shine = layer("Shine", WHITE, 3) -- reflet sur la moitié haute
	shine.BackgroundTransparency = 0.78
	shine.Size = UDim2.fromScale(1, 0.4)
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromScale(0, -0.1)
	label.Size = UDim2.fromScale(1, 1.2)
	label.FontFace = FONT
	label.TextScaled = true
	label.TextColor3 = WHITE
	label.ZIndex = 4
	local textStroke = Instance.new("UIStroke")
	textStroke.Thickness = 3
	textStroke.Parent = label
	label.Parent = back
	CollectionService:AddTag(label, "Text3D") -- relief du texte (script Text3D)
	back.Parent = gui
	gui.Parent = root
	return {Gui = gui, Back = back, Fill = fill, Ghost = ghost, Gradient = gradient, Label = label, Scale = scale}
end

local function setBar(bar, hp, maxHp, animate)
	local ratio = math.clamp(hp / math.max(maxHp, 1), 0, 1)
	local top, bottom = barColors(ratio)
	bar.Gradient.Color = ColorSequence.new(top, bottom)
	bar.Label.Text = Format(hp) .. " / " .. Format(maxHp)
	if animate then
		TweenService:Create(bar.Fill, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(ratio, 1)}):Play()
		TweenService:Create(bar.Ghost, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.18), {Size = UDim2.fromScale(ratio, 1)}):Play()
		bar.Scale.Scale = 1.22
		bar.Back.Rotation = math.random(0, 1) == 0 and -4 or 4
		TweenService:Create(bar.Scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
		TweenService:Create(bar.Back, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
	else
		bar.Fill.Size, bar.Ghost.Size = UDim2.fromScale(ratio, 1), UDim2.fromScale(ratio, 1)
	end
end

-- un texte qui jaillit de l'œuf, monte et s'efface
local function popup(root, height, text, color, size)
	local gui = Instance.new("BillboardGui")
	gui.Name = "EggHitText"
	gui.Size = UDim2.fromOffset(260, 70)
	gui.AlwaysOnTop = false -- (avec true, les captures de Studio ne montrent pas l'affichage)
	gui.LightInfluence = 0
	local side = (math.random() - 0.5) * math.max(height, 3) * 0.9
	gui.StudsOffsetWorldSpace = Vector3.new(side, height * 0.35, 0)
	local label = Instance.new("TextLabel")
	label:SetAttribute("No3D", true) -- pas de relief Text3D : il garderait un contour noir pendant le fondu
	label.BackgroundTransparency = 1
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.fromScale(0.5, 0.5)
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = ITALIC
	label.Text = text
	label.TextSize = size
	label.TextColor3 = color
	label.Rotation = math.random(-12, 12)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 4
	stroke.Parent = label
	local scale = Instance.new("UIScale")
	scale.Scale = 0.3
	scale.Parent = label
	label.Parent = gui
	gui.Parent = root
	TweenService:Create(scale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	TweenService:Create(gui, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {StudsOffsetWorldSpace = gui.StudsOffsetWorldSpace + Vector3.new(side * 0.4, height * 0.5 + 3, 0)}):Play()
	local fade = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.45)
	TweenService:Create(label, fade, {TextTransparency = 1}):Play()
	TweenService:Create(stroke, fade, {Transparency = 1}):Play()
	Debris:AddItem(gui, 0.8)
end

-- éclair blanc sur toute la coquille
local function flash(egg)
	local h = Instance.new("Highlight")
	h.FillColor, h.FillTransparency = WHITE, 0.3
	h.OutlineColor, h.OutlineTransparency = WHITE, 0.2
	h.DepthMode = Enum.HighlightDepthMode.Occluded
	h.Parent = egg
	TweenService:Create(h, TweenInfo.new(0.2), {FillTransparency = 1, OutlineTransparency = 1}):Play()
	Debris:AddItem(h, 0.22)
end

-- gerbe d'éclats quand il casse
local function burst(position, height)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.one
	part.CFrame = CFrame.new(position)
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(rgb(255, 250, 220), rgb(255, 200, 70))
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.4, 0.8)
	e.Speed = NumberRange.new(height * 4, height * 9)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 3
	e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-200, 200)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, math.max(height * 0.3, 0.8)), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = part
	e:Emit(36)
	Debris:AddItem(part, 1.2)
	return part
end

local function drop(egg)
	local bar = bars[egg]
	if bar then
		if bar.Gui then bar.Gui:Destroy() end
		bars[egg] = nil
	end
end

local function onHp(egg)
	local maxHp, hp = egg:GetAttribute("MaxHp"), egg:GetAttribute("Hp")
	local root = rootOf(egg)
	if not maxHp or not hp or not root then return end
	local bar = bars[egg] or {Hp = maxHp}
	bars[egg] = bar
	local lost = (bar.Hp or maxHp) - hp
	bar.Hp = hp
	local height = egg:GetAttribute("Height") or 3
	if hp >= maxHp then -- œuf intact : pas de barre
		if bar.Gui then bar.Gui:Destroy() bar.Gui = nil end
		return
	end
	if hp <= 0 then
		drop(egg)
		popup(burst(root.Position, height), height, "CRACK!", rgb(255, 226, 90), 54) -- sur un point fixe : l'œuf va disparaître
		return
	end
	if not bar.Gui then
		for k, v in makeBar(egg, root) do bar[k] = v end
		setBar(bar, hp + math.max(lost, 0), maxHp, false) -- part de la valeur d'avant le coup
	end
	if lost > 0 then
		setBar(bar, hp, maxHp, true)
		popup(root, height, "-" .. Format(lost), hp / maxHp <= 0.25 and rgb(255, 110, 90) or rgb(255, 236, 110), 40)
		flash(egg)
	else
		setBar(bar, hp, maxHp, false)
	end
end

local watched = setmetatable({}, {__mode = "k"})
local function watch(egg)
	if watched[egg] or not egg:IsA("Model") then return end
	watched[egg] = true
	egg:GetAttributeChangedSignal("Hp"):Connect(function() onHp(egg) end)
	egg.AncestryChanged:Connect(function()
		if not egg:IsDescendantOf(workspace) then drop(egg) end
	end)
	-- un œuf déjà entamé quand il arrive sur cet écran : on affiche sa barre telle quelle
	local hp, maxHp = egg:GetAttribute("Hp"), egg:GetAttribute("MaxHp")
	if hp and maxHp and hp < maxHp and hp > 0 then
		bars[egg] = {Hp = hp}
		task.defer(onHp, egg)
	end
end
local function watchZone(zone)
	for _, egg in zone:GetChildren() do watch(egg) end
	zone.ChildAdded:Connect(watch)
end
for _, zone in folder:GetChildren() do watchZone(zone) end
folder.ChildAdded:Connect(watchZone)
