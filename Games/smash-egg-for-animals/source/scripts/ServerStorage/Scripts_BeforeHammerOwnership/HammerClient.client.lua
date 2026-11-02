-- Marteau côté joueur : quand il est sorti (attribut HammerOut), un clic, F, la gâchette ou le bouton HIT frappe l'œuf
-- le plus proche. Le geste (élan au-dessus de l'épaule, coup vers le bas) est calculé ici, sur les articulations du bras.
-- Aussi : la boutique du stand HAMMERS.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local EggConfig = require(eggSystem:WaitForChild("EggConfig"))
local hitRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("HitEgg")
local system = ReplicatedStorage:WaitForChild("HammerSystem")
local HammerConfig = require(system:WaitForChild("HammerConfig"))
local models = system:WaitForChild("Models")
local SWING_TIME = 0.5  -- secondes entre deux coups
local IMPACT = 0.24     -- moment du coup dans le geste
local REACH = 9         -- distance max du bord de l'œuf
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local rad = math.rad

local function hammerOut() return player:GetAttribute("HammerOut") == true end
local function batOut() return player.Character ~= nil and player.Character:FindFirstChild("Bat") ~= nil end
local BAT_TIME = 0.75   -- secondes entre deux coups de batte
local BAT_IMPACT = 0.3  -- moment où la batte touche

---------------------------------------------------------------- cible : l'œuf le plus proche à portée
local function nearestEgg()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local folder = workspace:FindFirstChild("ZoneEggs")
	if not root or not folder then return nil end
	local best, bestGap
	for _, zone in folder:GetChildren() do
		for _, egg in zone:GetChildren() do
			if egg:IsA("Model") and egg:GetAttribute("MaxHp") and not egg:GetAttribute("Hatching") then
				local center = egg:GetPivot().Position
				local flat = Vector3.new(root.Position.X - center.X, 0, root.Position.Z - center.Z).Magnitude
				if flat < 60 then
					local size = egg:GetExtentsSize()
					local gap = flat - math.max(size.X, size.Z) / 2
					if gap <= REACH and (not bestGap or gap < bestGap) then best, bestGap = egg, gap end
				end
			end
		end
	end
	return best
end

---------------------------------------------------------------- le geste : élan en arrière, coup vers le bas, retour
-- angles (degrés) à chaque instant du geste : épaule, coude, buste ; interpolés en douceur
-- (buste : waist positif = penché en arrière, négatif = plié vers l'avant ; l'épaule est réglée par rapport au buste.
--  Le buste prend exactement ces angles pendant le coup, quelle que soit la pose de repos de l'avatar : certains packs
--  d'animations tiennent le buste penché en arrière, et le coup ne se voyait presque plus.)
-- Marteau : élan derrière l'épaule, puis il s'abat devant. Batte : élan sur le côté, grand coup à l'horizontale.
-- On tient l'outil d'une main ; pendant le coup la main gauche vient serrer le manche (attache OffHand du manche).
local HAMMER_KEYS = {
	{t = 0.00, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
	{t = 0.13, shoulder = 10, elbow = 12, waist = 10, twist = -16, wrist = 42, inward = -40, roll = 25},    -- élan : le buste se redresse un peu en arrière, le marteau part derrière l'épaule
	{t = 0.24, shoulder = 10, elbow = 0, waist = -26, twist = 12, wrist = -112, inward = -50, roll = -45},   -- coup : le buste se plie vers l'avant, le marteau s'abat devant
	{t = 0.31, shoulder = 14, elbow = 0, waist = -32, twist = 14, wrist = -118, inward = -50, roll = -45},   -- il s'écrase, tout le poids dessus
	{t = 0.50, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
}
local BAT_KEYS = {
	{t = 0.00, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
	{t = 0.18, shoulder = -2, elbow = 16, waist = 6, twist = -58, wrist = -84, inward = -34},    -- élan : le buste tourne, la batte passe derrière
	{t = 0.30, shoulder = 12, elbow = 0, waist = -10, twist = 62, wrist = -100, inward = -48},    -- coup : le buste accompagne vers l'avant, la batte balaie à l'horizontale
	{t = 0.40, shoulder = 12, elbow = 6, waist = -10, twist = 74, wrist = -102, inward = -48},   -- fin du geste
	{t = 0.70, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
}
local CHANNELS = {"shoulder", "elbow", "waist", "twist", "wrist", "inward", "roll"}
local swingStart, swingKeys, swingTool
local function pose(keys, t)
	local out = {}
	for i = 2, #keys do
		local a, b = keys[i - 1], keys[i]
		if t <= b.t then
			local u = (t - a.t) / (b.t - a.t)
			u = i == 3 and u * u or u * u * (3 - 2 * u) -- le coup accélère
			for _, name in CHANNELS do out[name] = (a[name] or 0) + ((b[name] or 0) - (a[name] or 0)) * u end
			return out
		end
	end
	for _, name in CHANNELS do out[name] = 0 end
	return out
end
local function endSwing()
	swingStart, swingTool = nil, nil
end
-- La main gauche vient serrer le manche. On calcule nous-mêmes l'épaule et le coude gauches (deux os), APRÈS avoir posé le geste
-- du bras droit et du buste : un IKControl de Roblox se résout avant ce geste, il visait donc l'ancienne place du manche.
local function leftArmTo(character, target, near, weight)
	local torso, upperArm, lowerArm, hand = character:FindFirstChild("UpperTorso"), character:FindFirstChild("LeftUpperArm"), character:FindFirstChild("LeftLowerArm"), character:FindFirstChild("LeftHand")
	local shoulder = upperArm and upperArm:FindFirstChild("LeftShoulder")
	local elbow = lowerArm and lowerArm:FindFirstChild("LeftElbow")
	local wrist = hand and hand:FindFirstChild("LeftWrist")
	if not (torso and shoulder and elbow and wrist) then return end
	local base = torso.CFrame * shoulder.C0            -- repère de l'épaule (le buste est déjà penché)
	local u = elbow.C0.Position - shoulder.C1.Position -- bras : de l'épaule au coude, dans le repère du bras
	local f = wrist.C0.Position - elbow.C1.Position    -- avant-bras : du coude au poignet
	local a, b = u.Magnitude, f.Magnitude + wrist.C1.Position.Magnitude
	-- si l'attache du manche est hors de portée, la main gauche se pose plus près de la main droite (elle glisse le long du manche)
	for _, k in {1, 0.66, 0.33, 0} do
		local point = near:Lerp(target, k)
		if (base.Position - point).Magnitude <= a + b - 0.05 or k == 0 then target = point break end
	end
	local toTarget = base:PointToObjectSpace(target)   -- le manche vu de l'épaule
	local d = math.clamp(toTarget.Magnitude, math.abs(a - b) + 0.02, a + b - 0.02)
	local dir = toTarget.Unit
	local pole = Vector3.new(-1, -0.7, 0.5)            -- le coude part vers l'extérieur et le bas
	local side = pole - dir * pole:Dot(dir)
	side = side.Magnitude > 0.01 and side.Unit or Vector3.new(-1, 0, 0)
	local alpha = math.acos(math.clamp((a * a + d * d - b * b) / (2 * a * d), -1, 1))
	local armDir = dir * math.cos(alpha) + side * math.sin(alpha)
	local rest = u.Unit
	local axis = rest:Cross(armDir)
	local turn = axis.Magnitude > 1e-4 and CFrame.fromAxisAngle(axis.Unit, math.acos(math.clamp(rest:Dot(armDir), -1, 1))) or CFrame.new()
	-- on vrille le bras autour de lui-même pour que le coude plie vers le manche
	local forward = turn:VectorToWorldSpace(Vector3.new(0, 0, -1))
	local want = dir * d - armDir * a
	want = want - armDir * want:Dot(armDir)
	if want.Magnitude > 1e-3 then
		want = want.Unit
		turn = CFrame.fromAxisAngle(armDir, math.atan2(forward:Cross(want):Dot(armDir), forward:Dot(want))) * turn
	end
	local bend = math.pi - math.acos(math.clamp((a * a + b * b - d * d) / (2 * a * b), -1, 1))
	shoulder.Transform = shoulder.Transform:Lerp(turn, weight)
	elbow.Transform = elbow.Transform:Lerp(CFrame.Angles(bend, 0, 0), weight)
end
-- après les animations de Roblox (qui écrivent Motor6D.Transform), on ajoute le geste par-dessus
RunService.Stepped:Connect(function()
	if not swingStart then return end
	local t = os.clock() - swingStart
	local character = player.Character
	if t >= swingKeys[#swingKeys].t or not character then endSwing() return end
	local p = pose(swingKeys, t)
	local upperArm, lowerArm, hand, upperTorso = character:FindFirstChild("RightUpperArm"), character:FindFirstChild("RightLowerArm"), character:FindFirstChild("RightHand"), character:FindFirstChild("UpperTorso")
	local j1 = upperArm and upperArm:FindFirstChild("RightShoulder")
	local j2 = lowerArm and lowerArm:FindFirstChild("RightElbow")
	local j3 = upperTorso and upperTorso:FindFirstChild("Waist")
	local j4 = hand and hand:FindFirstChild("RightWrist")
	if j1 then j1.Transform = j1.Transform * CFrame.Angles(rad(p.shoulder), 0, rad(p.inward)) end -- le bras se lève / s'abat et vient devant le buste
	if j2 then j2.Transform = j2.Transform * CFrame.Angles(rad(p.elbow), 0, 0) end
	local total = swingKeys[#swingKeys].t
	local blend = math.clamp(math.min(t / 0.08, (total - t) / 0.14), 0, 1) -- on prend la main sur le buste, puis on la rend
	if j3 then j3.Transform = j3.Transform:Lerp(CFrame.Angles(rad(p.waist), rad(p.twist), 0), blend) end
	local head = character:FindFirstChild("Head")
	local neck = head and head:FindFirstChild("Neck")
	if neck then neck.Transform = neck.Transform:Lerp(CFrame.Angles(rad(-p.waist * 0.5), 0, 0), blend) end -- la tête reste tournée vers l'œuf quand le buste plonge
	if j4 then j4.Transform = j4.Transform * CFrame.Angles(rad(p.wrist), rad(p.roll), 0) end -- roll : garde le marteau dans l'axe quand le bras vient devant le buste
	-- la main gauche vient sur le manche (elle arrive vite, puis lâche à la fin du geste)
	local off = swingTool and swingTool:FindFirstChild("Handle") and swingTool.Handle:FindFirstChild("OffHand")
	if off and hand then
		local near = hand.Position + (off.WorldPosition - hand.Position).Unit * 0.55 -- juste à côté de la main droite, sur le manche
		leftArmTo(character, off.WorldPosition, near, math.clamp(math.min(t / 0.06, (total - t) / 0.12), 0, 1))
	end
	if not j1 then -- R6 : une seule articulation
		local torso = character:FindFirstChild("Torso")
		local joint = torso and torso:FindFirstChild("Right Shoulder")
		if joint then joint.Transform = joint.Transform * CFrame.Angles(0, 0, rad(-p.wrist * 0.6)) end
	end
end)

-- choc : étincelles sur l'œuf et petite secousse de caméra
local function sparks(position)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.one
	part.CFrame = CFrame.new(position)
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 200, 80))
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.25, 0.5)
	e.Speed = NumberRange.new(12, 26)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 4
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = part
	e:Emit(20)
	game:GetService("Debris"):AddItem(part, 1)
end

-- couleur des effets du marteau tenu (attribut FxColor du modèle, posé par ServerStorage.HammerBuilder)
local function hammerColor()
	local tier = player:GetAttribute("EquippedHammer") or player:GetAttribute("Hammer") or 1
	local template = models:FindFirstChild("Tier" .. tier)
	return template and template:GetAttribute("FxColor") or Color3.fromRGB(255, 200, 80)
end

-- chiffre de dégâts qui saute au-dessus de l'œuf : texte du jeu (blanc contour noir) avec un dégradé à la couleur du marteau
local function damagePopup(position, amount, color)
	local anchor = Instance.new("Part")
	anchor.Anchored, anchor.CanCollide, anchor.CanQuery, anchor.CanTouch, anchor.Transparency = true, false, false, false, 1
	anchor.Size = Vector3.one
	anchor.CFrame = CFrame.new(position + Vector3.new((math.random() - 0.5) * 2, 0, (math.random() - 0.5) * 2))
	anchor.Parent = workspace
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(160, 64)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.MaxDistance = 140
	bb.Adornee = anchor
	bb.Parent = anchor
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Text = "-" .. string.sub(EggConfig.FormatMoney(amount), 2)
	label.FontFace = FONT
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Rotation = math.random(-10, 10)
	label.Parent = bb
	local gradient = Instance.new("UIGradient")
	gradient.Rotation = 90
	gradient.Color = ColorSequence.new(Color3.new(1, 1, 1):Lerp(color, 0.25), color)
	gradient.Parent = label
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3.5
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Parent = label
	local scale = Instance.new("UIScale")
	scale.Scale = 0.2
	scale.Parent = label
	TweenService:Create(scale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.15}):Play()
	task.delay(0.16, function() TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Scale = 1}):Play() end)
	TweenService:Create(bb, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {StudsOffsetWorldSpace = Vector3.new(0, 3, 0)}):Play()
	task.delay(0.45, function()
		TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
	end)
	game:GetService("Debris"):AddItem(anchor, 1)
end

-- onde de choc : un anneau lumineux plat qui s'élargit et s'efface autour du point d'impact
local function shockwave(position, width, color)
	local ring = Instance.new("Part")
	ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch = true, false, false, false
	ring.Shape = Enum.PartType.Cylinder
	ring.Material = Enum.Material.Neon
	ring.Color = color
	ring.Transparency = 0.25
	ring.CastShadow = false
	ring.Size = Vector3.new(0.15, width * 0.5, width * 0.5)
	ring.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
	ring.Parent = workspace
	TweenService:Create(ring, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.05, width * 1.9, width * 1.9), Transparency = 1}):Play()
	game:GetService("Debris"):AddItem(ring, 0.4)
end

local function impactFx(egg)
	if not egg.Parent then return end
	local color = hammerColor()
	local center = egg:GetPivot().Position
	local size = egg:GetExtentsSize()
	local hit = center + Vector3.new(0, size.Y * 0.35, 0)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.one
	part.CFrame = CFrame.new(hit)
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.25, 0.5)
	e.Speed = NumberRange.new(10, 22)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 4
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = part
	e:Emit(18)
	local flash = Instance.new("PointLight")
	flash.Color, flash.Range, flash.Brightness = color, 12, 3
	flash.Parent = part
	TweenService:Create(flash, TweenInfo.new(0.25), {Brightness = 0}):Play()
	game:GetService("Debris"):AddItem(part, 1)
	shockwave(center - Vector3.new(0, size.Y * 0.45, 0), math.max(size.X, size.Z), color)
	damagePopup(center + Vector3.new(0, size.Y * 0.6, 0), player:GetAttribute("HammerDamage") or 1, color)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		task.spawn(function()
			local t = 0
			while t < 0.16 do
				t += RunService.RenderStepped:Wait()
				humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, 0) * 0.35 * (1 - t / 0.16)
			end
			humanoid.CameraOffset = Vector3.zero
		end)
	end
end

local lastSwing = 0
local lastBonk = 0 -- dernier coup de marteau (le marteau de la case Auto Swing donne un petit coup)
local function swing()
	local character = player.Character
	if not character then return end
	if batOut() then -- batte : un coup toutes les 0,75 s sur le joueur devant soi
		if os.clock() - lastSwing < BAT_TIME then return end
		lastSwing = os.clock()
		swingKeys, swingStart = BAT_KEYS, os.clock()
		swingTool = character:FindFirstChild("Bat")
		task.delay(BAT_IMPACT, function() system.BatHit:FireServer() end)
		return
	end
	if not hammerOut() or os.clock() - lastSwing < SWING_TIME then return end
	lastSwing = os.clock()
	swingKeys, swingStart = HAMMER_KEYS, os.clock()
	swingTool = character:FindFirstChild("Hammer")
	lastBonk = os.clock()
	local trail = swingTool and swingTool:FindFirstChild("SwingTrail", true)
	if trail then -- traînée de couleur pendant que le marteau s'abat
		trail.Enabled = true
		task.delay(0.36, function() trail.Enabled = false end)
	end
	local egg = nearestEgg()
	if egg then
		task.delay(IMPACT, function()
			hitRemote:FireServer(egg)
			impactFx(egg)
		end)
	end
end

-- coup de batte reçu : c'est ce joueur qui est projeté et tombe un instant ; les étincelles du choc sont pour tout le monde
system:WaitForChild("Knock").OnClientEvent:Connect(function(velocity, position)
	if position then sparks(position) return end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid or typeof(velocity) ~= "Vector3" then return end
	humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
	root.AssemblyLinearVelocity = velocity
	task.delay(0.9, function()
		if humanoid.Parent and humanoid.Health > 0 then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
	end)
end)

---------------------------------------------------------------- commandes : clic, appui, bouton HIT
local holding = false
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonR2 then
		holding = true
		swing()
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonR2 then holding = false end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "HammerGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 6
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local hitButton = new("TextButton", {Name = "Hit", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -150, 1, -150), Size = UDim2.fromOffset(104, 104),
	BackgroundColor3 = Color3.fromRGB(235, 70, 60), Text = "HIT", FontFace = FONT, TextSize = 30, TextColor3 = Color3.new(1, 1, 1), Visible = false}, gui)
new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, hitButton)
new("UIStroke", {Thickness = 4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, hitButton)
new("UIStroke", {Thickness = 3}, hitButton)
local touchHold = false
hitButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then touchHold = true swing() end
end)
hitButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then touchHold = false end
end)

---------------------------------------------------------------- bouton Auto Swing : tape automatiquement les œufs à portée
-- Même taille sur tous les appareils : tout est en proportion de la hauteur de l'écran (SizeConstraint RelativeYY + rapport
-- largeur/hauteur fixe), les contours et le texte suivent la taille réelle du bouton.
-- Style du jeu : face en dégradé, studs, reflet, relief noir dessous. Tout bouge en douceur : les couleurs passent en fondu,
-- l'interrupteur glisse, un reflet traverse la face, le contour lumineux respire quand c'est allumé, et le marteau de la case
-- tourne et donne un petit coup à chaque frappe.
local AUTO_HEIGHT = 0.115  -- hauteur du bouton, en fraction de la hauteur de l'écran
local AUTO_RATIO = 3.5     -- largeur / hauteur
local AUTO_BOTTOM = 0.895  -- bas du bouton, en fraction de la hauteur de l'écran (au-dessus de la barre)
local LIP = 0.1            -- épaisseur du relief sous la face (fraction de la hauteur)
local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local rgb = Color3.fromRGB
local STATES = {
	off = {Top = rgb(252, 252, 255), Bottom = rgb(180, 186, 204), Lip = rgb(92, 96, 114), Studs = rgb(140, 146, 168), Track = rgb(64, 68, 86), Glow = rgb(255, 226, 150), Hint = "Tap to hit eggs for you"},
	on = {Top = rgb(196, 255, 140), Bottom = rgb(44, 196, 74), Lip = rgb(18, 112, 42), Studs = rgb(30, 146, 62), Track = rgb(26, 136, 54), Glow = rgb(150, 255, 120), Hint = "Smashing eggs for you!"},
}
local autoSwing = false
local autoHolder = new("Frame", {
	Name = "AutoSwing",
	AnchorPoint = Vector2.new(0.5, 1),
	Position = UDim2.fromScale(0.5, AUTO_BOTTOM),
	Size = UDim2.fromScale(AUTO_HEIGHT * AUTO_RATIO, AUTO_HEIGHT),
	SizeConstraint = Enum.SizeConstraint.RelativeYY,
	BackgroundTransparency = 1,
	Visible = false,
}, gui)
local autoButton = new("TextButton", {Name = "Button", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", AutoButtonColor = false}, autoHolder)
local autoScale = new("UIScale", {Scale = 1}, autoButton)
local strokes = {} -- {UIStroke, épaisseur en fraction de la hauteur}
local function stroke(parent, k, mode)
	local st = new("UIStroke", {Color = BLACK, Thickness = 3, ApplyStrokeMode = mode or Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter}, parent)
	table.insert(strokes, {st, k})
	return st
end
-- contour lumineux derrière le bouton : il respire quand l'auto swing est allumé
local aura = new("Frame", {Name = "Aura", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = STATES.on.Glow, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 0}, autoButton)
new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 0.2)})}, aura)
-- relief sous la face (la face s'y enfonce quand on appuie)
local autoLip = new("Frame", {Name = "Lip", Position = UDim2.fromScale(0, LIP), Size = UDim2.fromScale(1, 1 - LIP), BackgroundColor3 = STATES.off.Lip, BorderSizePixel = 0, ZIndex = 1}, autoButton)
stroke(autoLip, 0.04)
-- la face : opaque, dégradé de la couleur de l'état
local autoFace = new("Frame", {Name = "Face", Size = UDim2.fromScale(1, 1 - LIP), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 2, ClipsDescendants = true}, autoButton)
stroke(autoFace, 0.04)
local faceGradient = new("UIGradient", {Rotation = 90}, autoFace)
local autoStuds = new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile,
	TileSize = UDim2.fromScale(1 / (AUTO_RATIO * 3.2), 1 / 3.2 / (1 - LIP)), ImageTransparency = 0.78, ZIndex = 3}, autoFace)
-- reflet en haut, ombre en bas : effet bombé ; couture blanche à l'intérieur
new("Frame", {Name = "Gloss", Size = UDim2.fromScale(1, 0.4), BackgroundColor3 = WHITE, BackgroundTransparency = 0.7, BorderSizePixel = 0, ZIndex = 3}, autoFace)
new("Frame", {Name = "Shade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.12), BackgroundColor3 = BLACK, BackgroundTransparency = 0.82, BorderSizePixel = 0, ZIndex = 3}, autoFace)
local stitch = new("Frame", {Name = "Stitch", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 1, -8), BackgroundTransparency = 1, ZIndex = 3}, autoFace)
local stitchStroke = new("UIStroke", {Color = WHITE, Thickness = 1.5, Transparency = 0.45}, stitch)
-- reflet qui traverse la face de temps en temps
local sweep = new("Frame", {Name = "Sweep", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.3, 0.5), Size = UDim2.fromScale(0.09, 2.4), Rotation = 22,
	BackgroundColor3 = WHITE, BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 8}, autoFace)
new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1)})}, sweep)

-- case du marteau : écrin sombre, lumière douce derrière, marteau qui tourne
local slot = new("Frame", {Name = "HammerSlot", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.03, 0.5), Size = UDim2.fromScale(0.8, 0.8),
	SizeConstraint = Enum.SizeConstraint.RelativeYY, BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 4, ClipsDescendants = true}, autoFace)
stroke(slot, 0.035)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(72, 76, 96), rgb(22, 23, 32))}, slot)
local slotGlow = new("Frame", {Name = "Glow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1.1, 1.1),
	BackgroundColor3 = STATES.off.Glow, BorderSizePixel = 0, ZIndex = 4}, slot)
new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, slotGlow)
new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.55, 0.85), NumberSequenceKeypoint.new(1, 1)})}, slotGlow)
new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromScale(0.34, 0.34),
	ImageColor3 = rgb(120, 125, 150), ImageTransparency = 0.82, ZIndex = 4}, slot)
local autoViewport = new("ViewportFrame", {Name = "Preview", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5,
	Ambient = rgb(150, 150, 165), LightColor = rgb(255, 244, 225), LightDirection = Vector3.new(-0.6, -1, -0.8)}, slot)
new("Frame", {Name = "Shine", Size = UDim2.fromScale(1, 0.32), BackgroundColor3 = WHITE, BackgroundTransparency = 0.88, BorderSizePixel = 0, ZIndex = 6}, slot)

-- texte : AUTO SWING (dégradé doré) et une ligne d'aide
local textX = 0.03 + 0.8 / AUTO_RATIO + 0.035
local autoLabel = new("TextLabel", {Name = "Label", BackgroundTransparency = 1, Position = UDim2.fromScale(textX, 0.1), Size = UDim2.fromScale(0.74 - textX, 0.5),
	Text = "AUTO SWING", FontFace = FONT, TextScaled = true, TextColor3 = WHITE, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6}, autoFace)
local labelGradient = new("UIGradient", {Rotation = 90, Color = ColorSequence.new(WHITE, rgb(255, 236, 150))}, autoLabel)
stroke(autoLabel, 0.04, Enum.ApplyStrokeMode.Contextual)
local hint = new("TextLabel", {Name = "Hint", BackgroundTransparency = 1, Position = UDim2.fromScale(textX, 0.62), Size = UDim2.fromScale(0.74 - textX, 0.24),
	Text = STATES.off.Hint, FontFace = FONT, TextScaled = true, TextColor3 = WHITE, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6}, autoFace)
stroke(hint, 0.024, Enum.ApplyStrokeMode.Contextual)

-- interrupteur : rail sombre, bouton blanc à studs qui glisse, ON / OFF du côté libre
local track = new("Frame", {Name = "Switch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(0.965, 0.5), Size = UDim2.fromScale(0.21, 0.5),
	BackgroundColor3 = STATES.off.Track, BorderSizePixel = 0, ZIndex = 6}, autoFace)
stroke(track, 0.03)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(160, 160, 160), WHITE)}, track) -- creux : plus sombre en haut
local trackText = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.46, 0.62),
	Text = "OFF", FontFace = FONT, TextScaled = true, TextColor3 = WHITE, ZIndex = 7}, track)
stroke(trackText, 0.02, Enum.ApplyStrokeMode.Contextual)
local knob = new("Frame", {Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.04, 0.5), Size = UDim2.fromScale(0.44, 0.84),
	BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 8}, track)
stroke(knob, 0.025)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(WHITE, rgb(196, 200, 214))}, knob)
new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromScale(0.5, 0.5),
	ImageColor3 = rgb(150, 156, 176), ImageTransparency = 0.6, ZIndex = 8}, knob)

-- les contours (toujours noirs) gardent la même épaisseur relative sur tous les écrans
local function resizeStrokes()
	local h = autoHolder.AbsoluteSize.Y
	for _, entry in strokes do entry[1].Thickness = math.max(1, h * entry[2]) end
end
autoHolder:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeStrokes)
resizeStrokes()

-- fondu des couleurs entre OFF et ON : une seule valeur (0 = off, 1 = on) qu'on anime
local blend = Instance.new("NumberValue")
local function paint()
	local k = blend.Value
	local off, on = STATES.off, STATES.on
	faceGradient.Color = ColorSequence.new(off.Top:Lerp(on.Top, k), off.Bottom:Lerp(on.Bottom, k))
	autoLip.BackgroundColor3 = off.Lip:Lerp(on.Lip, k)
	autoStuds.ImageColor3 = off.Studs:Lerp(on.Studs, k)
	track.BackgroundColor3 = off.Track:Lerp(on.Track, k)
	slotGlow.BackgroundColor3 = off.Glow:Lerp(on.Glow, k)
	stitchStroke.Transparency = 0.45 + 0.2 * (1 - k)
end
blend.Changed:Connect(paint)
paint()
local function paintAuto(instant)
	local info = TweenInfo.new(instant and 0 or 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(blend, info, {Value = autoSwing and 1 or 0}):Play()
	TweenService:Create(knob, TweenInfo.new(instant and 0 or 0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(autoSwing and 0.52 or 0.04, 0.5)}):Play()
	trackText.Text = autoSwing and "ON" or "OFF"
	trackText.Position = UDim2.fromScale(autoSwing and 0.04 or 0.5, 0.5)
	hint.Text = autoSwing and STATES.on.Hint or STATES.off.Hint
	labelGradient.Color = autoSwing and ColorSequence.new(WHITE, rgb(220, 255, 170)) or ColorSequence.new(WHITE, rgb(255, 236, 150))
end
paintAuto(true)

-- survol : studs bien visibles et léger grossissement ; appui : la face s'enfonce et le bouton se tasse
local hovering = false
local function setHover(on)
	hovering = on
	TweenService:Create(autoStuds, TweenInfo.new(0.18), {ImageTransparency = on and 0.35 or 0.78}):Play()
	TweenService:Create(autoScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = on and 1.05 or 1}):Play()
end
local function press(down)
	TweenService:Create(autoFace, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Position = UDim2.fromScale(0, down and LIP * 0.8 or 0)}):Play()
	TweenService:Create(autoScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Scale = down and 0.96 or (hovering and 1.05 or 1)}):Play()
end
autoButton.MouseEnter:Connect(function() setHover(true) end)
autoButton.MouseLeave:Connect(function() setHover(false) press(false) end)
autoButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then press(true) end
end)
autoButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		press(false)
		if input.UserInputType == Enum.UserInputType.Touch then setHover(false) end
	end
end)

-- miniature du marteau équipé : de trois quarts, penché, cadré au plus près ; il tourne doucement (boucle plus bas)
local previewModel
local function updateHammerPreview()
	local tier = player:GetAttribute("EquippedHammer") or player:GetAttribute("Hammer") or 1
	autoViewport:ClearAllChildren()
	previewModel = nil
	local template = models:FindFirstChild("Tier" .. tier)
	if not template then return end
	local model = template:Clone()
	for _, d in model:GetDescendants() do -- les particules ne s'affichent pas dans une ViewportFrame
		if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Light") then d:Destroy() end
	end
	local cf, size = model:GetBoundingBox()
	-- centré sur l'origine, la tête du marteau en haut, penché de 30°
	model:PivotTo(CFrame.Angles(0, 0, math.rad(-30)) * (cf:Inverse() * model:GetPivot()))
	model.Parent = autoViewport
	previewModel = {Model = model, Base = model:GetPivot()}
	local camera = Instance.new("Camera")
	camera.FieldOfView = 30
	local radius = size.Magnitude / 2
	local distance = radius / math.tan(math.rad(camera.FieldOfView / 2)) * 0.82
	camera.CFrame = CFrame.lookAt(Vector3.new(0.35, 0.25, 1).Unit * distance, Vector3.zero)
	camera.Parent = autoViewport
	autoViewport.CurrentCamera = camera
	local glow = template:GetAttribute("FxColor")
	if glow then STATES.off.Glow = glow:Lerp(rgb(255, 226, 150), 0.4) paint() end -- la lumière de la case prend la couleur du marteau
end

local function setAuto(on)
	autoSwing = on
	paintAuto()
	autoScale.Scale = 0.9
	TweenService:Create(autoScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = hovering and 1.05 or 1}):Play()
	-- éclat : une copie du contour lumineux jaillit et s'efface (le contour, lui, respire tant que c'est allumé)
	local burst = aura:Clone()
	burst.Name = "Burst"
	burst.BackgroundColor3 = on and STATES.on.Glow or WHITE
	burst.Size = UDim2.new(1, 0, 1, 0)
	burst.BackgroundTransparency = 0.15
	burst.Parent = autoButton
	TweenService:Create(burst, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1.14, 0, 1.6, 0), BackgroundTransparency = 1}):Play()
	game:GetService("Debris"):AddItem(burst, 0.5)
end
autoButton.Activated:Connect(function() setAuto(not autoSwing) end)

player:GetAttributeChangedSignal("Hammer"):Connect(updateHammerPreview)
player:GetAttributeChangedSignal("EquippedHammer"):Connect(updateHammerPreview)

local function refreshHitButton()
	local armed = hammerOut() or batOut()
	hitButton.Visible = armed and UserInputService.TouchEnabled
	if hammerOut() and not autoHolder.Visible then -- le bouton arrive en glissant depuis le bas
		autoHolder.Position = UDim2.fromScale(0.5, AUTO_BOTTOM + 0.06)
		TweenService:Create(autoHolder, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, AUTO_BOTTOM)}):Play()
	end
	autoHolder.Visible = hammerOut()
	if hammerOut() then
		if not previewModel then updateHammerPreview() end
	elseif autoSwing then
		setAuto(false)
	end
	if not armed then holding, touchHold = false, false end
end
player:GetAttributeChangedSignal("HammerOut"):Connect(refreshHitButton)
refreshHitButton()

-- animations continues : le marteau tourne (et donne un petit coup à chaque frappe), le reflet passe, le contour respire
RunService.RenderStepped:Connect(function()
	if not autoHolder.Visible then return end
	local now = os.clock()
	if previewModel and previewModel.Model.Parent then
		local k = now - lastBonk
		local tilt = k < 0.3 and -math.sin(k / 0.3 * math.pi) * 40 or 0
		previewModel.Model:PivotTo(CFrame.Angles(0, now * (autoSwing and 2.2 or 1.1), 0) * CFrame.Angles(0, 0, math.rad(tilt)) * previewModel.Base)
	end
	local cycle = (now % 2.6) / 0.7 -- le reflet traverse en 0,7 s toutes les 2,6 s
	sweep.Position = UDim2.fromScale(cycle <= 1 and -0.3 + cycle * 1.6 or -0.3, 0.5)
	if autoSwing then
		local pulse = (math.sin(now * 4) + 1) / 2
		aura.Size = UDim2.new(1.03 + pulse * 0.03, 0, 1.1 + pulse * 0.12, 0)
		aura.BackgroundTransparency = 0.45 + pulse * 0.3
	elseif aura.BackgroundTransparency < 1 then
		aura.BackgroundTransparency = math.min(1, aura.BackgroundTransparency + 0.08)
	end
end)

---------------------------------------------------------------- boucle : coups enchaînés, arêtes arc-en-ciel du dernier marteau
while true do
	task.wait(0.05)
	if (holding or touchHold) and (hammerOut() or batOut()) then swing() end
	if autoSwing and hammerOut() and nearestEgg() then swing() end
	if hitButton.Visible ~= ((hammerOut() or batOut()) and UserInputService.TouchEnabled) then refreshHitButton() end
	local tool = player.Character and player.Character:FindFirstChild("Hammer")
	if tool then
		local color = Color3.fromHSV((os.clock() * 0.3) % 1, 0.55, 1)
		for _, p in tool:GetChildren() do if p.Name == "Prism" then p.Color = color end end
	end
end
