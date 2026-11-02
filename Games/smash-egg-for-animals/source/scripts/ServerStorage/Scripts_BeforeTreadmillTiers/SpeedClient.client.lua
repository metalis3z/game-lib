-- Speed côté joueur : compteur (au-dessus de l'argent), "+N" qui s'envolent à chaque pas sur le tapis,
-- course sur place quand on est sur sa bande, et bouton d'amélioration sur le panneau de sa base.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local system = ReplicatedStorage:WaitForChild("SpeedSystem")
local Config = require(system:WaitForChild("SpeedConfig"))
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local player = Players.LocalPlayer
local gui = script.Parent

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local GREEN = Color3.fromRGB(110, 255, 120)
local STUDS = "rbxassetid://7447638591"

local function text(parent, props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.FontFace = FONT
	l.TextColor3 = Color3.new(1, 1, 1)
	for k, v in props do l[k] = v end
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = l
	l.Parent = parent
	return l
end

---------------------------------------------------------------- compteur
local holder = Instance.new("Frame")
holder.Name = "Holder"
holder.BackgroundTransparency = 1
holder.AnchorPoint = Vector2.new(0, 1)
holder.Position = UDim2.new(0, 18, 1, -90)
holder.Size = UDim2.fromOffset(460, 64)
holder.Parent = gui
local scale = Instance.new("UIScale")
scale.Parent = holder
local icon = Instance.new("ImageLabel") -- l'icône de chaussure fournie (StarterGui["icon leaderboard"]["Speed icon"])
icon.Name = "Icon"
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://80184389303970"
icon.ScaleType = Enum.ScaleType.Fit
icon.Size = UDim2.fromOffset(66, 66)
icon.Position = UDim2.fromOffset(0, -1)
icon.Parent = holder
local amount = text(holder, {Name = "Amount", Text = "0", TextSize = 52, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(74, 0), Size = UDim2.new(1, -74, 1, 0), TextColor3 = GREEN})
local pop = Instance.new("UIScale")
pop.Parent = amount

local function refresh()
	local speed, level = player:GetAttribute("Speed") or 0, player:GetAttribute("TreadmillLevel") or 0
	amount.Text = Config.Format(speed) .. "  (+" .. Config.Format(Config.GainPerSecond(level) * math.max(player:GetAttribute("TrailMult") or 1, 1)) .. "/s)"
end
player:GetAttributeChangedSignal("Speed"):Connect(refresh)
player:GetAttributeChangedSignal("TreadmillLevel"):Connect(refresh)
player:GetAttributeChangedSignal("TrailMult"):Connect(refresh)
refresh()
local function scaleOf() return scale.Scale end
local function fit()
	local camera = workspace.CurrentCamera
	scale.Scale = math.clamp(camera.ViewportSize.Y / 760, 0.6, 1)
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
fit()

---------------------------------------------------------------- "+N" à chaque pas
local SHOE = "rbxassetid://80184389303970"
-- une étiquette "chaussure +N" : l'icône du speed à gauche, le montant à droite
local function gainTag(parent, amountGained, height)
	local tag = Instance.new("Frame")
	tag.BackgroundTransparency = 1
	tag.Size = UDim2.fromOffset(height * 4.2, height)
	local shoe = Instance.new("ImageLabel")
	shoe.Name = "Shoe"
	shoe.BackgroundTransparency = 1
	shoe.Image = SHOE
	shoe.ScaleType = Enum.ScaleType.Fit
	shoe.Size = UDim2.fromOffset(height, height)
	shoe.Parent = tag
	local amountLabel = text(tag, {Name = "Amount", Text = "+" .. Config.Format(amountGained), TextSize = math.floor(height * 0.86), TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(height + 6, 0), Size = UDim2.new(1, -height - 6, 1, 0), TextColor3 = GREEN})
	local scale = Instance.new("UIScale")
	scale.Parent = tag
	tag.Parent = parent
	return tag, shoe, amountLabel, scale
end
local function fadeOut(shoe, amountLabel, delayTime, duration)
	local info = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, delayTime)
	TweenService:Create(shoe, info, {ImageTransparency = 1}):Play()
	TweenService:Create(amountLabel, info, {TextTransparency = 1}):Play()
	TweenService:Create(amountLabel:FindFirstChildOfClass("UIStroke"), info, {Transparency = 1}):Play()
end

local function floatText(amountGained)
	-- 1. au-dessus du personnage : "chaussure +N" sort de lui et monte, en partant parfois à gauche, parfois à droite
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then
		local b = Instance.new("BillboardGui")
		b.Size = UDim2.fromOffset(250, 60)
		b.StudsOffset = Vector3.new(math.random(-12, 12) / 10, 1, 0) -- repère de l'écran : X = gauche / droite
		b.AlwaysOnTop = false -- (avec true, l'étiquette ne s'affichait pas)
		b.LightInfluence = 0
		b.Adornee = root
		local tag, shoe, amountLabel, scale = gainTag(b, amountGained, 54)
		tag.AnchorPoint, tag.Position, tag.Rotation = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), math.random(-9, 9)
		b.Name = "SpeedGain"
		b.ResetOnSpawn = false
		b.Parent = gui.Parent -- dans PlayerGui : un BillboardGui rangé dans un ScreenGui ne s'affiche pas
		scale.Scale = 0.4
		TweenService:Create(scale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
		local drift = Vector3.new(math.random(-30, 30) / 10, 5.5 + math.random() * 1.5, 0)
		TweenService:Create(b, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {StudsOffset = b.StudsOffset + drift}):Play()
		fadeOut(shoe, amountLabel, 0.5, 0.3)
		task.delay(0.85, function() b:Destroy() end)
	end
	-- 2. à droite du compteur : l'étiquette jaillit, rebondit, glisse vers le haut en penchant, puis s'efface
	local tag, shoe, amountLabel, scale = gainTag(gui, amountGained, 46)
	local startX = holder.AbsolutePosition.X + (amount.TextBounds.X + 96) * scaleOf() + math.random(0, 50)
	local startY = holder.AbsolutePosition.Y + holder.AbsoluteSize.Y * 0.5 + math.random(-10, 10)
	tag.AnchorPoint = Vector2.new(0, 0.5)
	tag.Position = UDim2.fromOffset(startX, startY)
	tag.Rotation = math.random(-12, 12)
	scale.Scale = 0.2
	TweenService:Create(scale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = scaleOf() * 1.15}):Play()
	task.delay(0.22, function()
		TweenService:Create(scale, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = scaleOf() * 0.85}):Play()
	end)
	TweenService:Create(tag, TweenInfo.new(0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(startX + math.random(10, 60), startY - 80 - math.random(0, 30)), Rotation = tag.Rotation * -0.5}):Play()
	fadeOut(shoe, amountLabel, 0.5, 0.35)
	task.delay(0.9, function() tag:Destroy() end)
	-- le compteur et sa chaussure réagissent
	pop.Scale = 1.16
	TweenService:Create(pop, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	icon.Rotation = -14
	TweenService:Create(icon, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
end
system:WaitForChild("Gain").OnClientEvent:Connect(floatText)

---------------------------------------------------------------- course sur place et bande qui défile
local RUN_SPEED = 2.8 -- vitesse de l'animation de course sur la bande : deux fois celle d'avant (le gain de speed, lui, ne change pas)
local runTrack
local function setRunning(on)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if on and animator and not runTrack then
		local animate = character:FindFirstChild("Animate")
		local run = animate and animate:FindFirstChild("run") and animate.run:FindFirstChildOfClass("Animation")
		if run then
			runTrack = animator:LoadAnimation(run)
			runTrack.Priority = Enum.AnimationPriority.Action
			runTrack.Looped = true
			runTrack:Play(0.15, 1, RUN_SPEED)
		end
	elseif not on and runTrack then
		runTrack:Stop(0.15)
		runTrack = nil
	end
end
local hint = text(gui, {Name = "TreadmillHint", Text = "JUMP to get off the treadmill", TextSize = 24, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -110), Size = UDim2.fromOffset(460, 30), Visible = false})
player:GetAttributeChangedSignal("OnTreadmill"):Connect(function()
	local on = player:GetAttribute("OnTreadmill") == true
	setRunning(on)
	hint.Visible = on
end)
player.CharacterAdded:Connect(function() runTrack = nil end)

local bases = workspace:WaitForChild("all base")
local function myBase()
	local number = player:GetAttribute("BaseNumber")
	return number and bases:FindFirstChild("base " .. number)
end
RunService.RenderStepped:Connect(function(dt)
	if not player:GetAttribute("OnTreadmill") then return end
	local base = myBase()
	local scroll = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt") and base.Treadmill.Belt:FindFirstChild("Scroll")
	if scroll then scroll.OffsetStudsV = (scroll.OffsetStudsV + dt * 18) % scroll.StudsPerTileV end
end)

-- Montée sur la bande : c'est cet écran qui la voit, à chaque image (même à très grande vitesse on ne traverse plus le tapis
-- sans être pris). Le personnage s'arrête tout de suite, puis glisse en douceur jusqu'au milieu de la bande en se tournant vers
-- la console ; le serveur est prévenu (remote Mount) et confirme avec l'attribut OnTreadmill.
-- Sur la bande il reste droit, face à la console, même avec le shift lock ou en bougeant la caméra.
-- Le shift lock tourne le personnage vers la caméra à chaque image : on repasse juste après la caméra.
local gameSettings = UserSettings():GetService("UserGameSettings")
local mountRemote = system:WaitForChild("Mount")
local EXIT_PAUSE = 2    -- secondes après une descente pendant lesquelles la bande ne reprend pas le joueur (comme SpeedServer)
local GLIDE_TIME = 0.8  -- durée maximale de la glissade vers le milieu
local GLIDE_RATE = 8    -- rapidité de la glissade
local wasOn = false
local pending           -- heure à laquelle cet écran a annoncé la montée, tant que le serveur n'a pas confirmé
local heldSpeed         -- vitesse de marche à rendre si le serveur refuse
local glideUntil = 0
local leftAt = 0
local lastPosition
local function insideBelt(belt, position)
	local rel = belt.CFrame:PointToObjectSpace(position)
	return math.abs(rel.X) <= belt.Size.X / 2 + 0.6 and math.abs(rel.Z) <= belt.Size.Z / 2 + 0.6 and rel.Y > 0 and rel.Y < 7
end
RunService:BindToRenderStep("TreadmillFacing", Enum.RenderPriority.Camera.Value + 1, function(dt)
	local on = player:GetAttribute("OnTreadmill") == true
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local base = myBase()
	local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
	if not (humanoid and root and belt) then
		wasOn, pending, lastPosition = on, nil, nil
		return
	end
	local now = os.clock()
	if on and not wasOn then
		if not pending then glideUntil = now + GLIDE_TIME end -- pris par le serveur : même glissade
		pending = nil
	elseif wasOn and not on then
		leftAt = now
		humanoid.AutoRotate = true
	end
	wasOn = on
	if not on and not pending and humanoid.Health > 0 and now - leftAt > EXIT_PAUSE and player:GetAttribute("Speed")
		and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
		-- entre deux images un joueur très rapide parcourt plusieurs studs : on regarde aussi le milieu du trajet
		local position = root.Position
		if insideBelt(belt, position) or (lastPosition and (position - lastPosition).Magnitude < 60 and insideBelt(belt, (position + lastPosition) / 2)) then
			pending = now
			glideUntil = now + GLIDE_TIME
			heldSpeed = humanoid.WalkSpeed
			humanoid.WalkSpeed = 0
			root.AssemblyLinearVelocity = Vector3.new(0, math.min(root.AssemblyLinearVelocity.Y, 0), 0)
			setRunning(true)
			mountRemote:FireServer()
		end
	elseif pending and now - pending > 1.5 then -- le serveur n'a pas confirmé : on rend la main
		pending = nil
		leftAt = now
		if humanoid.WalkSpeed == 0 and heldSpeed then humanoid.WalkSpeed = heldSpeed end
		humanoid.AutoRotate = true
		setRunning(false)
	end
	lastPosition = root.Position
	if on or pending then
		humanoid.AutoRotate = false
		gameSettings.RotationType = Enum.RotationType.MovementRelative
		root.AssemblyAngularVelocity = Vector3.zero
		if now < glideUntil then
			-- glissade : chaque image rapproche le personnage du milieu de la bande et le tourne un peu plus vers la console
			local alpha = 1 - math.exp(-dt * GLIDE_RATE)
			local target = (belt.CFrame * CFrame.new(0, 0, 0.8)).Position
			local position = root.Position:Lerp(Vector3.new(target.X, root.Position.Y, target.Z), alpha)
			root.CFrame = CFrame.new(position) * root.CFrame.Rotation:Lerp(belt.CFrame.Rotation, alpha)
			root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
		else
			root.CFrame = CFrame.new(root.Position) * belt.CFrame.Rotation
		end
	end
end)

---------------------------------------------------------------- tapis des autres joueurs : on passe à travers
-- Seul son propre tapis est solide (et lui seul donne du speed). Réglé sur cet écran seulement : chaque joueur garde le sien solide.
local solid = setmetatable({}, {__mode = "k"}) -- [pièce] = si elle était solide à l'origine
local function setSolid(base)
	local mine = base == myBase()
	for _, name in {"Treadmill", "TreadmillBoard"} do
		local model = base:FindFirstChild(name)
		for _, p in model and model:GetDescendants() or {} do
			if p:IsA("BasePart") then
				if solid[p] == nil then solid[p] = p.CanCollide end
				p.CanCollide = mine and solid[p]
			end
		end
	end
end
for _, base in bases:GetChildren() do
	setSolid(base)
	base.ChildAdded:Connect(function(child) -- le tapis d'une base arrive quand un joueur la prend
		if child.Name == "Treadmill" or child.Name == "TreadmillBoard" then
			task.defer(setSolid, base)
			child.DescendantAdded:Connect(function() task.defer(setSolid, base) end)
		end
	end)
end
player:GetAttributeChangedSignal("BaseNumber"):Connect(function()
	for _, base in bases:GetChildren() do setSolid(base) end
end)

---------------------------------------------------------------- montée de niveau : gerbe d'étincelles sur son tapis
local lastLevel = player:GetAttribute("TreadmillLevel")
player:GetAttributeChangedSignal("TreadmillLevel"):Connect(function()
	local level = player:GetAttribute("TreadmillLevel")
	local grew = lastLevel and level and level > lastLevel
	lastLevel = level
	local base = myBase()
	local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
	if not grew or not belt then return end
	local skin = Config.Skin(level)
	local at = Instance.new("Attachment")
	at.Position = Vector3.new(0, 1, 0)
	at.Parent = belt
	for _, spec in {{Tex = "Flare", Count = 40, Speed = {16, 30}, Size = 1.3, Life = {0.5, 0.9}}, {Tex = "Star", Count = 26, Speed = {10, 22}, Size = 1.6, Life = {0.7, 1.2}},
		{Tex = "LightRing", Count = 1, Speed = {0.01, 0.01}, Size = 16, Life = {0.6, 0.6}, Flat = true}} do
		local e = Instance.new("ParticleEmitter")
		e.Texture = Config.FxTextures[spec.Tex]
		e.Color = ColorSequence.new(skin.Glow, skin.Trim)
		e.LightEmission, e.LightInfluence = 1, 0
		e.Rate = 0
		e.Lifetime = NumberRange.new(spec.Life[1], spec.Life[2])
		e.Speed = NumberRange.new(spec.Speed[1], spec.Speed[2])
		e.EmissionDirection = Enum.NormalId.Top
		e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-200, 200)
		if spec.Flat then
			e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
			e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, spec.Size)})
			e.RotSpeed = NumberRange.new(0)
		else
			e.SpreadAngle = Vector2.new(60, 60)
			e.Acceleration, e.Drag = Vector3.new(0, -34, 0), 2
			e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, spec.Size), NumberSequenceKeypoint.new(1, 0)})
		end
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1)})
		e.Parent = at
		e:Emit(spec.Count)
	end
	task.delay(2, function() at:Destroy() end)
end)

---------------------------------------------------------------- bouton d'amélioration sur le panneau de sa base
local surface = Instance.new("SurfaceGui")
surface.Name = "TreadmillUpgrade"
surface.Face = Enum.NormalId.Back
surface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
surface.PixelsPerStud = 40
surface.LightInfluence = 0
surface.ResetOnSpawn = false
surface.Parent = player:WaitForChild("PlayerGui")
local GREY_BUTTON, GREEN_BUTTON, ROBUX_BUTTON = Color3.fromRGB(150, 156, 172), Color3.fromRGB(64, 214, 60), Color3.fromRGB(236, 70, 232)
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
-- Un bouton du panneau, dans le style du jeu : dégradé clair en haut et soutenu en bas, studs, gros contour noir, filet clair
-- à l'intérieur, reflet en haut. Il grossit un peu sous la souris et s'enfonce quand on clique.
local function boardButton(name, position, size, color)
	local b = Instance.new("TextButton")
	b.Name = name
	b.AnchorPoint = Vector2.new(0.5, 0.5)
	b.Position = position + UDim2.fromScale(size.X.Scale / 2, size.Y.Scale / 2)
	b.Size = size
	b.BackgroundColor3 = WHITE
	b.BorderSizePixel = 0
	b.Text = ""
	b.AutoButtonColor = false
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 6
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = b
	local fill = Instance.new("UIGradient")
	fill.Name = "Fill"
	fill.Rotation = 90
	fill.Parent = b
	local studs = Instance.new("ImageLabel")
	studs.Name = "Studs"
	studs.BackgroundTransparency = 1
	studs.Size = UDim2.fromScale(1, 1)
	studs.Image, studs.ScaleType, studs.TileSize, studs.ImageTransparency = STUDS, Enum.ScaleType.Tile, UDim2.fromOffset(40, 40), 0.72
	studs.Parent = b
	local shine = Instance.new("Frame") -- reflet : la moitié haute, un peu plus claire
	shine.Name = "Shine"
	shine.BackgroundColor3 = WHITE
	shine.BackgroundTransparency = 0.78
	shine.BorderSizePixel = 0
	shine.Position, shine.Size = UDim2.fromOffset(8, 8), UDim2.new(1, -16, 0.42, -8)
	shine.Parent = b
	local inner = Instance.new("Frame") -- filet clair à l'intérieur du contour
	inner.Name = "Inner"
	inner.BackgroundTransparency = 1
	inner.Position, inner.Size = UDim2.fromOffset(7, 7), UDim2.new(1, -14, 1, -14)
	local line = Instance.new("UIStroke")
	line.Thickness = 3
	line.Color = WHITE
	line.Transparency = 0.45
	line.Parent = inner
	inner.Parent = b
	local label = text(b, {Name = "Label", Text = "", TextScaled = true, Position = UDim2.fromScale(0.06, 0.16), Size = UDim2.fromScale(0.88, 0.68), ZIndex = 2})
	label:FindFirstChildOfClass("UIStroke").Thickness = 4
	local press = Instance.new("UIScale")
	press.Parent = b
	local function to(value, time) TweenService:Create(press, TweenInfo.new(time, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = value}):Play() end
	b.MouseEnter:Connect(function() to(1.05, 0.15) end)
	b.MouseLeave:Connect(function() to(1, 0.15) end)
	b.MouseButton1Down:Connect(function() to(0.92, 0.08) end)
	b.MouseButton1Up:Connect(function() to(1.05, 0.2) end)
	b.Parent = surface
	return b, label
end
local function setColor(b, color)
	b.Fill.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color:Lerp(WHITE, 0.55)), ColorSequenceKeypoint.new(0.55, color), ColorSequenceKeypoint.new(1, color:Lerp(BLACK, 0.22))})
end
local button, bText = boardButton("Upgrade", UDim2.fromScale(0.04, 0.66), UDim2.fromScale(0.56, 0.28), GREY_BUTTON)
local robuxButton, robuxText = boardButton("UpgradeRobux", UDim2.fromScale(0.64, 0.66), UDim2.fromScale(0.32, 0.28), ROBUX_BUTTON)
setColor(button, GREY_BUTTON)
setColor(robuxButton, ROBUX_BUTTON)
-- l'icône d'argent du jeu à gauche du prix
local moneyIcon = Instance.new("ImageLabel")
moneyIcon.Name = "Icon"
moneyIcon.BackgroundTransparency = 1
moneyIcon.Image = "rbxassetid://70666404213952"
moneyIcon.ScaleType = Enum.ScaleType.Fit
moneyIcon.Position, moneyIcon.Size = UDim2.fromScale(0.05, 0.14), UDim2.fromScale(0.24, 0.72)
moneyIcon.ZIndex = 2
moneyIcon.Parent = button
-- le symbole Robux n'existe que dans les polices Roblox : il a son propre label, à gauche du prix
robuxText.Position, robuxText.Size, robuxText.TextXAlignment = UDim2.fromScale(0.4, 0.16), UDim2.fromScale(0.54, 0.68), Enum.TextXAlignment.Left
local robuxIcon = text(robuxButton, {Name = "Icon", Text = utf8.char(0xE002), TextScaled = true, Position = UDim2.fromScale(0.06, 0.16), Size = UDim2.fromScale(0.32, 0.68), ZIndex = 2})
robuxIcon.FontFace = Font.fromEnum(Enum.Font.GothamBold)
robuxText.Text = tostring(Config.RobuxPrice)
button.Activated:Connect(function() system.Upgrade:FireServer() end)
robuxButton.Activated:Connect(function() system.Upgrade:FireServer(true) end)
-- place d'un bouton sur le panneau (ils sont ancrés par leur centre, pour grossir sans se décaler)
local function layout(b, x, width)
	b.Size = UDim2.fromScale(width, 0.28)
	b.Position = UDim2.fromScale(x + width / 2, 0.8)
end

-- bouton d'argent : vert quand on peut payer l'amélioration, gris sinon
local function refreshButton()
	local base = myBase()
	surface.Adornee = base and base:FindFirstChild("TreadmillBoard") and base.TreadmillBoard:FindFirstChild("Screen") or nil
	local level = player:GetAttribute("TreadmillLevel") or 0
	if level >= Config.MaxLevel then
		bText.Text = "MAX"
		bText.Position, bText.Size = UDim2.fromScale(0.06, 0.16), UDim2.fromScale(0.88, 0.68)
		moneyIcon.Visible = false
		setColor(button, GREY_BUTTON)
		layout(button, 0.04, 0.92)
		robuxButton.Visible = false
		return
	end
	layout(button, 0.04, 0.56)
	robuxButton.Visible = true
	moneyIcon.Visible = true
	bText.Position, bText.Size = UDim2.fromScale(0.31, 0.16), UDim2.fromScale(0.64, 0.68)
	local cost = Config.Cost(level)
	bText.Text = EggConfig.FormatMoney(cost)
	setColor(button, (player:GetAttribute("Money") or 0) >= cost and GREEN_BUTTON or GREY_BUTTON)
end
for _, name in {"TreadmillLevel", "Money", "BaseNumber"} do player:GetAttributeChangedSignal(name):Connect(refreshButton) end
-- le tapis et le panneau d'une base n'apparaissent que quand elle a un joueur : on raccroche les boutons à ce moment-là
for _, base in bases:GetChildren() do
	base.ChildAdded:Connect(function() task.defer(refreshButton) end)
	base.ChildRemoved:Connect(function() task.defer(refreshButton) end)
end
refreshButton()
