local CutsceneLock = require(game:GetService("ReplicatedStorage"):WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
-- CutsceneClient : cinématique "Point Zéro" (lancée par CutsceneServer via ReplicatedStorage.CutscenePlay)
-- 1. Une sphère d'énergie dans le ciel ; Kinoshi112 y est agenouillé, les mains dans deux filets électriques.
-- 2. Rexydev1 vole autour, tape sur la sphère ; Kinoshi : "I won't hold on much longer!"
-- 3. Rexydev1 sort une épée électrique et coupe la sphère en deux.
-- 4. Kinoshi tombe et s'évanouit dans la Safe Zone ; Nono275er arrive à pied.
-- 5. Gifle, réveil, Rexydev1 atterrit : "Are you okay?", il relève Kinoshi.
-- 6. Les trois s'éloignent ensemble, retour au jeu.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local assets = ReplicatedStorage:WaitForChild("CutsceneAssets")
local Poses = require(assets:WaitForChild("CutscenePoses"))
local P = Poses.POSES

---------------------------------------------------------------- RÉGLAGES DE LA SCÈNE
local SAFE = workspace:FindFirstChild("safe zone")
local GROUND_Y = SAFE and (SAFE.Position.Y + SAFE.Size.Y / 2) or 0
local L = Vector3.new(-100, GROUND_Y, -162)       -- là où Kinoshi tombe (au milieu de la Safe Zone)
local S = L + Vector3.new(0, 62, 0)               -- centre de la sphère dans le ciel
local SF = CFrame.new(S) * CFrame.Angles(0, math.rad(90), 0) -- repère de la sphère (coupe = plan vertical face à la caméra)
local RADIUS = 22

local ENERGY = Color3.fromRGB(120, 200, 255)
local PURPLE = Color3.fromRGB(150, 90, 255)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local function smooth(x) x = math.clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function lerp(a, b, t) return a + (b - a) * t end

---------------------------------------------------------------- PETITS OUTILS VISUELS
local scene -- dossier des objets de la cinématique

local function part(props)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	for k, v in props do p[k] = v end
	p.Parent = props.Parent or scene
	return p
end

local function playSound(name, volume)
	local s = assets:FindFirstChild(name)
	if not s then return end
	s = s:Clone()
	s.Volume = volume or s.Volume
	s.Parent = SoundService
	s:Play()
	Debris:AddItem(s, 8)
end

-- éclair en zigzag entre deux points (disparaît tout seul)
local function bolt(a, b, color, width, life)
	local segs = math.clamp(math.floor((b - a).Magnitude / 1.6), 3, 10)
	local dir = (b - a)
	local side = dir:Cross(Vector3.yAxis)
	if side.Magnitude < 0.01 then side = dir:Cross(Vector3.xAxis) end
	side = side.Unit
	local up = dir:Cross(side).Unit
	local prev = a
	for i = 1, segs do
		local t = i / segs
		local p = a + dir * t
		if i < segs then
			local j = math.min(1.4, dir.Magnitude * 0.12)
			p += side * (math.random() - 0.5) * j * 2 + up * (math.random() - 0.5) * j * 2
		end
		local seg = part({Material = Enum.Material.Neon, Color = color, Size = Vector3.new(width, width, (p - prev).Magnitude), CFrame = CFrame.lookAt((p + prev) / 2, p)})
		Debris:AddItem(seg, life or 0.08)
		prev = p
	end
end

local function burst(position, color, size, time, material)
	local b = part({Shape = Enum.PartType.Ball, Material = material or Enum.Material.Neon, Color = color, Size = Vector3.one * 0.5, CFrame = CFrame.new(position), Transparency = 0.1})
	TweenService:Create(b, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.one * size, Transparency = 1}):Play()
	Debris:AddItem(b, time + 0.1)
end

local function ring(position, normal, color, radius, time)
	local r = part({Shape = Enum.PartType.Cylinder, Material = Enum.Material.Neon, Color = color, Transparency = 0.2,
		Size = Vector3.new(0.2, 1, 1), CFrame = CFrame.lookAt(position, position + normal) * CFrame.Angles(0, math.rad(90), 0)})
	TweenService:Create(r, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.2, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(r, time + 0.1)
end

local function dust(position, size, count)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxassetid://13346862770"
	e.FlipbookLayout, e.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	e.Rate = 0
	e.Lifetime = NumberRange.new(1, 1.8)
	e.Speed = NumberRange.new(size * 0.6, size * 1.6)
	e.SpreadAngle = Vector2.new(180, 20)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.5), NumberSequenceKeypoint.new(1, size * 1.5)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
	e.Color = ColorSequence.new(Color3.fromRGB(210, 210, 200))
	e.Drag = 3
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, 3)
end

---------------------------------------------------------------- INTERFACE (bandes noires, sous-titres, fondu)
local gui, topBar, bottomBar, fade, subtitle, subName, subText
local hiddenGuis = {}

local function buildGui()
	gui = Instance.new("ScreenGui")
	gui.Name = "PointZeroGui"
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 200
	gui.ResetOnSpawn = false
	local function bar(y)
		local f = Instance.new("Frame")
		f.BackgroundColor3 = Color3.new(0, 0, 0)
		f.BorderSizePixel = 0
		f.Size = UDim2.new(1, 0, 0, 0)
		f.AnchorPoint = Vector2.new(0, y)
		f.Position = UDim2.fromScale(0, y)
		f.Parent = gui
		return f
	end
	topBar, bottomBar = bar(0), bar(1)
	fade = Instance.new("Frame")
	fade.BackgroundColor3 = Color3.new(0, 0, 0)
	fade.BorderSizePixel = 0
	fade.Size = UDim2.fromScale(1, 1)
	fade.BackgroundTransparency = 0
	fade.ZIndex = 10
	fade.Parent = gui
	subtitle = Instance.new("Frame")
	subtitle.BackgroundTransparency = 1
	subtitle.AnchorPoint = Vector2.new(0.5, 1)
	subtitle.Position = UDim2.new(0.5, 0, 1, -18)
	subtitle.Size = UDim2.new(0.8, 0, 0, 70)
	subtitle.ZIndex = 5
	subtitle.Visible = false
	subtitle.Parent = gui
	subName = Instance.new("TextLabel")
	subName.BackgroundTransparency = 1
	subName.Size = UDim2.new(1, 0, 0, 24)
	subName.FontFace = FONT
	subName.TextScaled = true
	subName.ZIndex = 5
	subName.Parent = subtitle
	subText = subName:Clone()
	subText.Position = UDim2.new(0, 0, 0, 26)
	subText.Size = UDim2.new(1, 0, 0, 40)
	subText.TextColor3 = Color3.new(1, 1, 1)
	subText.Parent = subtitle
	for _, l in {subName, subText} do
		local s = Instance.new("UIStroke") s.Thickness = 2.5 s.Parent = l
	end
	gui.Parent = player:WaitForChild("PlayerGui")
end

local function bars(on)
	local h = on and UDim2.new(1, 0, 0.11, 0) or UDim2.new(1, 0, 0, 0)
	TweenService:Create(topBar, TweenInfo.new(0.8), {Size = h}):Play()
	TweenService:Create(bottomBar, TweenInfo.new(0.8), {Size = h}):Play()
end

local function fadeTo(transparency, time, color)
	if color then fade.BackgroundColor3 = color end
	TweenService:Create(fade, TweenInfo.new(time), {BackgroundTransparency = transparency}):Play()
end

-- réplique : sous-titre en bas + bulle au-dessus de la tête de celui qui parle
local function say(actor, color, text, duration)
	subtitle.Visible = true
	subName.Text = actor.name
	subName.TextColor3 = color
	subText.Text = ""
	local head = actor.rig:FindFirstChild("Head")
	local bubble
	if head then
		bubble = Instance.new("BillboardGui")
		bubble.Size = UDim2.fromOffset(260, 60)
		bubble.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0)
		bubble.AlwaysOnTop = true
		bubble.LightInfluence = 0
		local bg = Instance.new("TextLabel")
		bg.Size = UDim2.fromScale(1, 1)
		bg.BackgroundColor3 = Color3.new(1, 1, 1)
		bg.TextColor3 = Color3.fromRGB(25, 25, 35)
		bg.FontFace = FONT
		bg.TextScaled = true
		bg.Text = ""
		local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 14) c.Parent = bg
		local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0, 10) pad.PaddingRight = UDim.new(0, 10) pad.PaddingTop = UDim.new(0, 6) pad.PaddingBottom = UDim.new(0, 6) pad.Parent = bg
		local st = Instance.new("UIStroke") st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border st.Thickness = 3 st.Color = color st.Parent = bg
		bg.Parent = bubble
		bubble.Adornee = head
		bubble.Parent = gui
		bubble:SetAttribute("Label", true)
	end
	task.spawn(function()
		for i = 1, #text do
			subText.Text = string.sub(text, 1, i)
			if bubble then bubble:FindFirstChildOfClass("TextLabel").Text = string.sub(text, 1, i) end
			task.wait(0.035)
		end
		task.wait(math.max(0.5, duration - #text * 0.035))
		subtitle.Visible = false
		if bubble then bubble:Destroy() end
	end)
end

local function popText(position, text, color)
	local holder = part({Size = Vector3.one * 0.2, Transparency = 1, CFrame = CFrame.new(position)})
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(240, 90)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = UDim2.fromScale(1, 1)
	l.FontFace = FONT
	l.TextScaled = true
	l.Text = text
	l.TextColor3 = color
	l.Rotation = -8
	local s = Instance.new("UIStroke") s.Thickness = 4 s.Parent = l
	l.Parent = bb
	bb.Parent = holder
	local sc = Instance.new("UIScale") sc.Scale = 0.2 sc.Parent = l
	TweenService:Create(sc, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.delay(0.9, function()
		TweenService:Create(l, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		TweenService:Create(s, TweenInfo.new(0.4), {Transparency = 1}):Play()
	end)
	Debris:AddItem(holder, 1.4)
end

---------------------------------------------------------------- LA CINÉMATIQUE
local playing = false

local function run()
	local actorsFolder = assets:WaitForChild("Actors", 15)
	if not actorsFolder then return end
	for _ = 1, 50 do
		if #actorsFolder:GetChildren() >= 3 then break end
		task.wait(0.2)
	end
	local function actor(role)
		local template = actorsFolder:FindFirstChild(role)
		if not template then return nil end
		local rig = template:Clone()
		rig.Parent = scene
		local a = Poses.setup(rig)
		a.name = template:GetAttribute("DisplayName") or role
		a.speed = 10
		return a
	end
	local K = actor("Prisoner") -- Kinoshi112
	local R = actor("Flyer")    -- Rexydev1
	local N = actor("Slapper")  -- Nono275er
	if not (K and R and N) then return end
	local actors = {K, R, N}

	local t0 = os.clock()
	local function T() return os.clock() - t0 end
	-- décalage du minutage : après le combat contre la sorcière, la suite de la scène est décalée d'autant
	local shift = 0
	local function waitUntil(t) while T() < t + shift and playing do RunService.RenderStepped:Wait() end end

	-- déplacements animés : fn(alpha) appelée chaque image entre start et start+dur
	local tracks = {}
	local function track(start, dur, fn) table.insert(tracks, {s = start + shift, d = dur, fn = fn}) end
	local function moveTo(a, start, dur, toCF, easeFn)
		local from
		track(start, dur, function(u)
			from = from or a.cf
			a.cf = from:Lerp(toCF, (easeFn or smooth)(u))
		end)
	end

	-- marche procédurale
	local walkers = {}
	local function walk(a, start, dur, fromPos, toPos, amp, speed)
		local dist = (toPos - fromPos).Magnitude
		track(start, dur, function(u)
			-- il accélère en partant et ralentit en arrivant ; la cadence des pas suit la distance réellement parcourue (les pieds ne glissent plus)
			local e = u - 0.6 * math.sin(2 * math.pi * u) / (2 * math.pi)
			local pace = (1 - 0.6 * math.cos(2 * math.pi * u)) / 1.6
			local p = fromPos:Lerp(toPos, e)
			local dir = (toPos - fromPos)
			dir = Vector3.new(dir.X, 0, dir.Z).Unit
			local running = Poses.run ~= nil and dist / math.max(dur, 0.01) > 9 -- déplacement rapide : il court
			local phase = e * dist / (running and 7 or 4.4) * math.pi * 2
			local side = Vector3.new(-dir.Z, 0, dir.X)
			a.cf = (CFrame.lookAt(p, p + dir) + Vector3.new(0, (0.5 - 0.5 * math.cos(phase * 2)) * 0.14 * pace, 0) + side * math.sin(phase) * 0.06 * pace) * CFrame.Angles(math.rad(-5 * pace), 0, 0)
			Poses.set(a, running and Poses.run(phase, math.clamp(pace * 1.2, 0.5, 1.05)) or Poses.walk(phase, (amp or 1) * math.clamp(pace * 1.25, 0.4, 1.1)))
			walkers[a] = u < 1 or nil
		end)
	end

	-- caméra
	local shot = function() return camera.CFrame end
	local shake = 0
	local function cut(fn) local sh = shift shot = function(t) return fn(t - sh) end end

	---------------------------------------------------------- DÉCOR : LA SPHÈRE "POINT ZÉRO"
	local sphereParts = {}
	local glass = part({Shape = Enum.PartType.Ball, Material = Enum.Material.Glass, Color = Color3.fromRGB(170, 220, 255), Transparency = 0.55, Size = Vector3.one * (RADIUS * 2 + 1.5), CFrame = SF})
	local halves = {}
	for _, n in {"HalfA", "HalfB"} do
		local h = assets:FindFirstChild(n)
		if h then
			h = h:Clone()
			h.Material = Enum.Material.ForceField
			h.Color = PURPLE
			h.Transparency = 0
			h.CFrame = SF * CFrame.new(h:GetAttribute("OffsetX") or 0, 0, 0)
			h.Parent = scene
			table.insert(halves, h)
		end
	end
	local core = part({Shape = Enum.PartType.Ball, Transparency = 1, Size = Vector3.one * RADIUS * 2, CFrame = SF})
	local light = Instance.new("PointLight") light.Color = ENERGY light.Range = 60 light.Brightness = 3 light.Parent = core
	local swirl = Instance.new("ParticleEmitter")
	swirl.Shape = Enum.ParticleEmitterShape.Sphere
	swirl.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
	swirl.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
	swirl.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	swirl.Rate = 60
	swirl.Lifetime = NumberRange.new(1.2, 2)
	swirl.Speed = NumberRange.new(6, 12)
	swirl.RotSpeed = NumberRange.new(-180, 180)
	swirl.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
	swirl.Color = ColorSequence.new(ENERGY, PURPLE)
	swirl.LightEmission = 1
	swirl.Parent = core
	-- anneaux de vortex lumineux qui tournent autour du centre
	local vortex = {}
	for i, info in {{18, ENERGY, 0.7}, {14, PURPLE, 0.55}, {20.5, Color3.fromRGB(255, 255, 255), 0.3}} do
		local holder = part({Size = Vector3.one * 0.2, Transparency = 1, CFrame = SF})
		local r, k = info[1], info[1] * 4 / 3
		local a0 = Instance.new("Attachment") a0.Position = Vector3.new(-r, 0, 0) a0.Axis = Vector3.new(0, 0, 1) a0.SecondaryAxis = Vector3.new(0, 1, 0) a0.Parent = holder
		local a1 = Instance.new("Attachment") a1.Position = Vector3.new(r, 0, 0) a1.Axis = Vector3.new(0, 0, 1) a1.SecondaryAxis = Vector3.new(0, 1, 0) a1.Parent = holder
		for _, sgn in {1, -1} do
			local b = Instance.new("Beam")
			b.Attachment0, b.Attachment1 = a0, a1
			b.CurveSize0, b.CurveSize1 = k * sgn, -k * sgn
			b.Width0, b.Width1 = info[3], info[3]
			b.Color = ColorSequence.new(info[2])
			b.LightEmission = 1
			b.Transparency = NumberSequence.new(0.15)
			b.FaceCamera = true
			b.Segments = 30
			b.Parent = holder
		end
		vortex[i] = holder
	end
	local sphereAlive = true
	local electric = true

	---------------------------------------------------------- LA SORCIÈRE (en studs) qui bombarde la sphère d'électricité
	local WITCH_ZAP = Color3.fromRGB(190, 90, 255)
	local witch = assets:FindFirstChild("Witch")
	witch = witch and witch:Clone()
	local witchMode = "orbit" -- orbit (tourne et bombarde), face (regarde Rexy), hit (reçoit l'électricité), fall
	-- position de la sorcière autour de la sphère à l'instant t
	local function witchPos(t)
		local a = 0.6 + t * 0.35
		return S + Vector3.new(math.cos(a) * 36, 6 + math.sin(t * 1.7) * 2.5, math.sin(a) * 36)
	end
	local witchCF = CFrame.new(witchPos(0))
	if witch then
		witch.Parent = scene
		witch:PivotTo(witchCF)
	end
	-- bras articulés de la sorcière : chaque bras (épaule -> poing, + la baguette à droite) pivote autour de l'épaule
	local ARM_PARTS = {Epaule = true, HautBras = true, Manche = true, AvantBras = true, Poignet = true, Poing = true, Pouce = true}
	local WAND_PARTS = {Baguette = true, BaguetteAnneau = true, BaguetteEtoile = true}
	local witchArms = {R = {}, L = {}}
	local witchWandTip
	local SHOULDER = {R = CFrame.new(1.05, -1.02, 0), L = CFrame.new(-1.05, -1.02, 0)}
	if witch then
		local pivot = witch:GetPivot()
		for _, p in witch:GetChildren() do
			if p:IsA("BasePart") and (ARM_PARTS[p.Name] or WAND_PARTS[p.Name]) then
				local off = pivot:ToObjectSpace(p.CFrame)
				local side = (WAND_PARTS[p.Name] or off.Position.X > 0) and "R" or "L"
				-- position de la pièce vue depuis l'épaule
				table.insert(witchArms[side], {part = p, off = SHOULDER[side]:Inverse() * off})
				if p.Name == "BaguetteEtoile" then witchWandTip = p end
			end
		end
	end
	local witchArmRot = {R = CFrame.identity, L = CFrame.identity}
	-- angles en degrés : x > 0 lève le bras (qui pointe devant elle), z écarte sur le côté
	local function witchArmTarget(side, x, y, z, dt, speed)
		local target = CFrame.Angles(math.rad(x), math.rad(y or 0), math.rad(z or 0))
		witchArmRot[side] = witchArmRot[side]:Lerp(target, 1 - math.exp(-(speed or 14) * dt))
	end
	-- place toute la sorcière puis ses bras dans leur pose du moment
	local function poseWitch()
		witch:PivotTo(witchCF)
		for side, list in witchArms do
			local base = witchCF * SHOULDER[side] * witchArmRot[side]
			for _, a in list do a.part.CFrame = base * a.off end
		end
	end
	-- bout de la baguette : c'est de là que partent ses éclairs
	local function witchHand()
		if witchWandTip and witchWandTip.Parent then return witchWandTip.Position end
		return (witchCF * CFrame.new(0.6, -1.4, -2)).Position
	end

	---------------------------------------------------------- L'ÉPÉE ÉLECTRIQUE (dans la main droite de Rexydev1)
	local sword
	local function makeSword()
		local hand = R.rig:FindFirstChild("RightHand")
		if not hand then return end
		sword = Instance.new("Model")
		sword.Name = "ElectricSword"
		local function piece(size, offset, color, mat, transp)
			local p = Instance.new("Part")
			p.Size, p.Color, p.Material, p.Transparency = size, color, mat or Enum.Material.Metal, transp or 0
			p.CanCollide, p.CanQuery, p.CanTouch, p.Massless, p.CastShadow = false, false, false, true, false
			p.CFrame = hand.CFrame * offset
			local w = Instance.new("WeldConstraint") w.Part0, w.Part1 = hand, p w.Parent = p
			p.Parent = sword
			return p
		end
		-- la lame prolonge le bras : bras levé = lame vers le ciel
		piece(Vector3.new(0.35, 1.3, 0.35), CFrame.new(0, -0.2, 0), Color3.fromRGB(35, 35, 45))
		piece(Vector3.new(1.9, 0.3, 0.5), CFrame.new(0, -0.95, 0), Color3.fromRGB(255, 200, 60))
		local blade = piece(Vector3.new(0.7, 7.5, 0.22), CFrame.new(0, -4.85, 0), ENERGY, Enum.Material.Neon, 0.05)
		piece(Vector3.new(0.28, 7.2, 0.26), CFrame.new(0, -4.85, 0), Color3.new(1, 1, 1), Enum.Material.Neon)
		local l = Instance.new("PointLight") l.Color = ENERGY l.Range = 18 l.Brightness = 4 l.Parent = blade
		local sp = Instance.new("ParticleEmitter")
		sp.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		sp.Rate = 40 sp.Lifetime = NumberRange.new(0.2, 0.5) sp.Speed = NumberRange.new(3, 8) sp.SpreadAngle = Vector2.new(180, 180)
		sp.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0)})
		sp.Color = ColorSequence.new(ENERGY, Color3.new(1, 1, 1)) sp.LightEmission = 1 sp.Parent = blade
		local a0 = Instance.new("Attachment") a0.Position = Vector3.new(0, 3.6, 0) a0.Parent = blade
		local a1 = Instance.new("Attachment") a1.Position = Vector3.new(0, -3.6, 0) a1.Parent = blade
		local trail = Instance.new("Trail")
		trail.Attachment0, trail.Attachment1 = a0, a1
		trail.Lifetime = 0.3 trail.LightEmission = 1 trail.Color = ColorSequence.new(Color3.new(1, 1, 1), ENERGY)
		trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
		trail.Parent = blade
		sword.Parent = R.rig
		sword:SetAttribute("Tip", true)
		sword.PrimaryPart = blade
		burst(blade.Position, ENERGY, 12, 0.4)
	end

	---------------------------------------------------------- BOUCLE PAR IMAGE
	local lastBolt = 0
	local lastPulse = 0
	local lastWitchZap = 0
	local conn = RunService.RenderStepped:Connect(function(dt)
		local t = T()
		for i = #tracks, 1, -1 do
			local tr = tracks[i]
			if t >= tr.s then
				local u = tr.d > 0 and math.clamp((t - tr.s) / tr.d, 0, 1) or 1
				tr.fn(u)
				if u >= 1 then table.remove(tracks, i) end
			end
		end
		for _, a in actors do Poses.step(a, dt) end
		-- sphère : vortex qui tourne, pulsations d'énergie
		if sphereAlive then
			vortex[1].CFrame = SF * CFrame.Angles(t * 1.3, t * 0.7, 0)
			vortex[2].CFrame = SF * CFrame.Angles(0, t * -1.6, t * 1.1)
			vortex[3].CFrame = SF * CFrame.Angles(t * 0.5, 0, t * -2)
			light.Brightness = 3 + math.sin(t * 6) * 1.5
			glass.Size = Vector3.one * (RADIUS * 2 + 1.5 + math.sin(t * 4) * 0.6)
			if t - lastPulse > 1.1 then
				lastPulse = t
				local pulse = part({Shape = Enum.PartType.Ball, Material = Enum.Material.ForceField, Color = ENERGY, Size = Vector3.one * RADIUS * 2, CFrame = SF})
				TweenService:Create(pulse, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.one * RADIUS * 2.9, Transparency = 1}):Play()
				Debris:AddItem(pulse, 1.2)
			end
		end
		-- la sorcière
		if witch then
			if witchMode == "orbit" then
				local p = witchPos(t)
				-- elle se penche dans ses sorts
				witchCF = CFrame.lookAt(p, Vector3.new(S.X, p.Y, S.Z)) * CFrame.Angles(-0.12 + math.sin(t * 7) * 0.08, 0, math.sin(t * 3.5) * 0.07)
				-- bras droit (baguette) : il pousse le sort vers la sphère ; bras gauche : il tourne en invoquant
				witchArmTarget("R", 22 + math.sin(t * 7) * 30, math.sin(t * 3.5) * 12, -8, dt, 18)
				witchArmTarget("L", 55 + math.sin(t * 7 + math.pi) * 25, math.cos(t * 3.5) * 15, 18 + math.cos(t * 7) * 18, dt, 18)
				-- elle bombarde la sphère d'éclairs violets
				if t - lastWitchZap > 0.09 then
					lastWitchZap = t
					local hand = witchHand()
					local hit = S + ((hand - S).Unit + Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 0.5).Unit * (RADIUS + 0.8)
					bolt(hand, hit, math.random() < 0.6 and WITCH_ZAP or Color3.new(1, 1, 1), 0.12, 0.1)
					if math.random() < 0.35 then burst(hit, WITCH_ZAP, 4, 0.25) end
				end
			elseif witchMode == "face" or witchMode == "hit" then
				local p = witchPos(16)
				local r = R.cf.Position
				witchCF = CFrame.lookAt(p, Vector3.new(r.X, p.Y, r.Z))
				if witchMode == "hit" then
					witchCF = (witchCF + Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 0.7) * CFrame.Angles(0, 0, (math.random() - 0.5) * 0.4)
					-- électrocutée : les bras se tordent dans tous les sens
					witchArmTarget("R", 60 + math.random(-60, 60), math.random(-40, 40), -math.random(10, 60), dt, 30)
					witchArmTarget("L", 60 + math.random(-60, 60), math.random(-40, 40), math.random(10, 60), dt, 30)
				else
					-- en garde : baguette pointée sur Rexy, l'autre bras levé
					witchArmTarget("R", 12 + math.sin(t * 4) * 6, 0, -5, dt, 10)
					witchArmTarget("L", 85, 0, 30, dt, 10)
				end
			elseif witchMode == "fall" then
				-- elle tombe en battant des bras
				witchArmTarget("R", 140 + math.sin(t * 18) * 30, 0, -40 + math.cos(t * 18) * 20, dt, 20)
				witchArmTarget("L", 140 + math.sin(t * 18 + 2) * 30, 0, 40 + math.cos(t * 18 + 2) * 20, dt, 20)
			end
			poseWitch()
		end
		-- filets électriques tenus par Kinoshi + arcs le long de ses bras
		if electric and t - lastBolt > 0.07 then
			lastBolt = t
			local look = K.cf.LookVector
			local right = K.cf.RightVector
			for _, side in {1, -1} do
				local hand = K.rig:FindFirstChild(side == 1 and "RightHand" or "LeftHand")
				local upper = K.rig:FindFirstChild(side == 1 and "RightUpperArm" or "LeftUpperArm")
				if hand then
					local hp = hand.Position
					for _, d in {Vector3.new(1, 0.45, 0.5), Vector3.new(1, -0.3, 0.75), Vector3.new(0.5, 0.9, 0.6), Vector3.new(0.6, -0.8, 0.4)} do
						local dir = (look * d.X + Vector3.yAxis * d.Y + right * side * d.Z).Unit
						bolt(hp, S + dir * (RADIUS - 0.5), math.random() < 0.5 and ENERGY or Color3.new(1, 1, 1), 0.06, 0.09)
					end
					if upper then bolt(hp, upper.Position + Vector3.yAxis * 0.4, ENERGY, 0.04, 0.07) end
				end
			end
		end
		-- caméra (+ tremblement)
		local cf = shot(t)
		if shake > 0.01 then
			cf *= CFrame.new((math.random() - 0.5) * shake, (math.random() - 0.5) * shake, 0)
			shake *= math.exp(-dt * 5)
		end
		camera.CFrame = cf
	end)

	local ok, err = pcall(function()
		local head = function(a) local h = a.rig:FindFirstChild("Head") return h and h.Position or a.cf.Position end
		------------------------------------------------------ 1. LE CIEL : Kinoshi agenouillé dans la sphère
		local kPos = S + Vector3.new(0, K.kneelY - 2.6, 0)
		K.cf = CFrame.lookAt(kPos, kPos + Vector3.xAxis)
		Poses.set(K, P.KNEEL_HOLD, true)
		R.cf = CFrame.new(S + Vector3.new(-400, 200, 400))
		Poses.set(R, P.FLY, true)
		local nStart = L + Vector3.new(26, N.standY, 2.7)
		N.cf = CFrame.lookAt(nStart, nStart + Vector3.new(-1, 0, 0))
		Poses.set(N, P.STAND, true)
		cut(function(t)
			local ang = lerp(0.25, 1.05, smooth(t / 6))
			return CFrame.lookAt(S + Vector3.new(math.cos(ang) * 80, 14 - t, math.sin(ang) * 80), S)
		end)
		fadeTo(1, 1.2)
		bars(true)
		waitUntil(6)
		cut(function(t)
			local u = smooth((t - 6) / 5)
			return CFrame.lookAt(S + Vector3.new(lerp(17, 9.5, u), lerp(4, 2.4, u), lerp(7, 3.5, u)), head(K) - Vector3.new(0, 0.6, 0))
		end)

		------------------------------------------------------ 2. Rexydev1 arrive en volant et tape sur la sphère
		-- (la sorcière vole autour depuis le début : voir "LA SORCIÈRE" plus haut)
		waitUntil(10)
		-- gros plan sur la sorcière qui bombarde la sphère d'électricité
		cut(function(t)
			local wp = witchCF.Position
			local out = Vector3.new(wp.X - S.X, 0, wp.Z - S.Z).Unit
			local side = out:Cross(Vector3.yAxis)
			return CFrame.lookAt(wp + out * 13 + side * 6 + Vector3.new(0, 3, 0), wp:Lerp(S, 0.35))
		end)

		------------------------------------------------------ 2. Rexydev1 arrive et se bat contre la sorcière dans les airs
		local W16 = witchPos(16)
		local rexFight = W16 + Vector3.new(15, 2, 11)
		local p0, p1 = S + Vector3.new(170, 50, 120), S + Vector3.new(90, 34, 70)
		local function bez(u) return p0:Lerp(p1, u):Lerp(p1:Lerp(rexFight, u), u) end
		track(12.4, 4, function(u)
			local e = smooth(u)
			local p = bez(e)
			local ahead = bez(math.min(1, e + 0.02))
			if (ahead - p).Magnitude < 0.05 then ahead = p + (W16 - p).Unit end
			R.cf = CFrame.lookAt(p, ahead) * CFrame.Angles(math.rad(-62 * (1 - smooth((u - 0.75) / 0.25))), 0, 0)
		end)
		waitUntil(12.6)
		cut(function(t)
			-- Rexy arrive de derrière la caméra et fonce vers la sorcière
			local u = smooth((t - 12.6) / 3.4)
			return CFrame.lookAt(S + Vector3.new(66, 16, 56), S:Lerp(W16, 0.55):Lerp(R.cf.Position, 0.25 * u))
		end)
		waitUntil(15.4)
		Poses.set(R, P.HOVER)
		waitUntil(16)
		-- face à face : elle arrête de bombarder et se tourne vers lui
		witchMode = "face"
		local function fightCam(dist, height)
			return function(t)
				local a, b = witchCF.Position, R.cf.Position
				local mid = (a + b) / 2
				local perp = (b - a):Cross(Vector3.yAxis).Unit
				if perp.X < 0 then perp = -perp end -- toujours du côté de la map
				return CFrame.lookAt(mid + perp * dist + Vector3.new(0, height, 0), mid)
			end
		end
		cut(fightCam(24, 4))
		R.cf = CFrame.lookAt(R.cf.Position, W16)
		waitUntil(16.7)
		-- elle lui lance un éclair violet, il l'esquive
		for i = 1, 5 do
			bolt(witchHand(), R.cf.Position + Vector3.new(math.random() * 4 - 2, 3 + math.random() * 2, math.random() * 4 - 2), WITCH_ZAP, 0.12, 0.12)
			task.wait(0.04)
		end
		local dodge = rexFight + Vector3.new(0, 4, -4)
		moveTo(R, 17, 0.3, CFrame.lookAt(dodge, W16))
		Poses.set(R, P.FLY) R.speed = 16
		waitUntil(17.4)
		Poses.set(R, P.HOVER)
		-- il sort son épée électrique
		waitUntil(17.8)
		Poses.set(R, P.SWORD_DRAW)
		R.speed = 14
		makeSword()
		waitUntil(18.7)
		Poses.set(R, P.SWORD_POINT)
		R.cf = CFrame.lookAt(R.cf.Position, W16 + Vector3.new(0, 1, 0))
		cut(fightCam(17, 2))
		-- il envoie l'électricité sur la sorcière
		witchMode = "hit"
		playSound("SlashSound", 1)
		local zapEnd = T() + 1.9
		while T() < zapEnd and playing do
			local tip = sword and sword.PrimaryPart and (sword.PrimaryPart.CFrame * CFrame.new(0, -3.7, 0)).Position or R.cf.Position
			local target = witchCF.Position + Vector3.new(0, 0.5, 0)
			bolt(tip, target, ENERGY, 0.22, 0.07)
			bolt(tip, target + Vector3.new(math.random() * 3 - 1.5, math.random() * 3 - 1.5, math.random() * 3 - 1.5), Color3.new(1, 1, 1), 0.1, 0.06)
			if math.random() < 0.3 then burst(target, ENERGY, 5, 0.2) end
			task.wait(0.05)
		end
		-- elle est touchée : elle tombe en tournoyant et disparaît
		playSound("BoomSound", 1)
		shake = 1.4
		burst(witchCF.Position, Color3.new(1, 1, 1), 14, 0.5)
		witchMode = "fall"
		local fallStart = witchCF
		track(20.6, 1.8, function(u)
			if witch then
				witchCF = (fallStart + Vector3.new(u * 6, -u * u * 45, u * 4)) * CFrame.Angles(u * 5, u * 9, u * 3)
			end
		end)
		Poses.set(R, P.HOVER)
		R.speed = 8
		cut(function(t)
			return CFrame.lookAt(W16 + Vector3.new(16, 6, 20), witchCF.Position:Lerp(W16, 0.3))
		end)
		waitUntil(22.1)
		if witch then
			local p = witchCF.Position
			burst(p, WITCH_ZAP, 16, 0.7, Enum.Material.ForceField)
			dust(p, 3, 30)
			popText(p + Vector3.new(0, 4, 0), "POOF!", Color3.fromRGB(200, 120, 255))
			witch:Destroy()
			witch = nil
		end
		-- il range son épée
		if sword then
			burst(sword.PrimaryPart.Position, ENERGY, 6, 0.3)
			sword:Destroy()
			sword = nil
		end
		waitUntil(22.4)
		-- la suite (il tape sur la sphère, la découpe...) est décalée de 5,8 s
		shift = 5.8
		local dirK = Vector3.new(math.cos(0.2), 0, math.sin(0.2))
		local knockPos = S + dirK * 24.6 + Vector3.new(0, -1.2, 0)
		local knockCF = CFrame.lookAt(knockPos, Vector3.new(S.X, knockPos.Y, S.Z))
		waitUntil(16.6)
		Poses.set(R, P.HOVER)
		moveTo(R, 16.6, 0.7, knockCF)
		waitUntil(17.2)
		cut(function(t)
			return CFrame.lookAt(S + Vector3.new(40, 3, 21), S:Lerp(R.cf.Position, 0.62))
		end)
		for i = 1, 3 do
			waitUntil(17.3 + (i - 1) * 0.75)
			Poses.set(R, P.KNOCK_BACK)
			R.speed = 18
			waitUntil(17.6 + (i - 1) * 0.75)
			Poses.set(R, P.KNOCK_HIT)
			R.speed = 30
			local hit = S + dirK * (RADIUS + 0.6) + Vector3.new(0, -0.4, 0)
			ring(hit, dirK, ENERGY, 5, 0.5)
			burst(hit, Color3.new(1, 1, 1), 2.5, 0.25)
		end
		waitUntil(19.9)
		Poses.set(R, P.HOVER)
		R.speed = 8
		-- Kinoshi lève les yeux
		waitUntil(20.6)
		cut(function(t)
			local u = smooth((t - 20.6) / 4.5)
			return CFrame.lookAt(S + Vector3.new(lerp(6.5, 5.2, u), lerp(0.4, 0.8, u), 2.4), head(K))
		end)
		Poses.set(K, P.KNEEL_LOOKUP)
		K.speed = 4
		waitUntil(21.6)
		say(K, Color3.fromRGB(120, 200, 255), "I won't hold on much longer!", 3.4)

		------------------------------------------------------ 3. L'épée électrique et la découpe
		waitUntil(25.2)
		local above = S + Vector3.new(30, 24, 0)
		Poses.set(R, P.HOVER)
		moveTo(R, 25.2, 1.1, CFrame.lookAt(above, above - Vector3.xAxis))
		cut(function(t)
			return CFrame.lookAt(S + Vector3.new(44, 20, 17), R.cf.Position + Vector3.new(0, 1, 0))
		end)
		K.speed = 10
		Poses.set(K, P.KNEEL_HOLD)
		waitUntil(26.6)
		Poses.set(R, P.SWORD_DRAW)
		R.speed = 14
		makeSword()
		waitUntil(28.2)
		Poses.set(R, P.WINDUP)
		R.speed = 9
		waitUntil(29.3)
		cut(function(t) return CFrame.lookAt(S + Vector3.new(78, 6, 0), S + Vector3.new(0, 2, 0)) end)
		playSound("SlashSound", 1.5)
		Poses.set(R, P.SLASH)
		R.speed = 26
		local slashTo = S + Vector3.new(27, -26, 0)
		track(29.35, 0.5, function(u)
			local p = above:Lerp(slashTo, u * u)
			R.cf = CFrame.lookAt(p, p - Vector3.xAxis) * CFrame.Angles(math.rad(-55 * u), 0, 0)
		end)
		waitUntil(29.6)
		-- COUPE : la sphère est tranchée en deux
		playSound("BoomSound", 1.6)
		shake = 2.5
		electric = false
		sphereAlive = false
		local slice = part({Material = Enum.Material.Neon, Color = Color3.new(1, 1, 1), Size = Vector3.new(RADIUS * 2.4, RADIUS * 2.4, 0.4), CFrame = CFrame.new(S), Transparency = 0})
		TweenService:Create(slice, TweenInfo.new(0.6), {Transparency = 1, Size = Vector3.new(RADIUS * 3, RADIUS * 3, 0.1)}):Play()
		Debris:AddItem(slice, 0.7)
		burst(S, Color3.new(1, 1, 1), RADIUS * 4, 0.9)
		burst(S, ENERGY, RADIUS * 6, 1.6, Enum.Material.ForceField)
		ring(S, Vector3.yAxis, ENERGY, 80, 1.3)
		ring(S, Vector3.zAxis, PURPLE, 60, 1.1)
		fadeTo(0.2, 0.08, Color3.new(1, 1, 1))
		task.delay(0.12, function() fadeTo(1, 0.7) end)
		swirl.Enabled = false
		for _, v in vortex do v:Destroy() end
		TweenService:Create(glass, TweenInfo.new(0.4), {Transparency = 1}):Play()
		TweenService:Create(light, TweenInfo.new(1.5), {Brightness = 0}):Play()
		for i, h in halves do
			local side = (h:GetAttribute("OffsetX") or 0) > 0 and 1 or -1
			local from = h.CFrame
			local to = SF * CFrame.new(side * 40, -6, 0) * CFrame.Angles(0, 0, math.rad(-side * 35)) * CFrame.new(h:GetAttribute("OffsetX") or 0, 0, 0)
			track(29.6, 2.6, function(u)
				h.CFrame = from:Lerp(to, 1 - (1 - u) ^ 3)
				h.Transparency = smooth((u - 0.4) / 0.6)
			end)
		end
		local shower = Instance.new("ParticleEmitter")
		shower.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		shower.Rate = 0 shower.Lifetime = NumberRange.new(1, 2.5) shower.Speed = NumberRange.new(20, 50) shower.SpreadAngle = Vector2.new(180, 180)
		shower.Acceleration = Vector3.new(0, -25, 0)
		shower.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6), NumberSequenceKeypoint.new(1, 0)})
		shower.Color = ColorSequence.new(ENERGY, PURPLE) shower.LightEmission = 1 shower.Parent = core
		shower:Emit(250)
		Poses.set(K, P.KNEEL_LOOKUP)

		------------------------------------------------------ 4. Chute dans la Safe Zone
		waitUntil(30.6)
		moveTo(R, 30.6, 1.5, CFrame.lookAt(S + Vector3.new(36, 8, -10), S))
		Poses.set(R, P.HOVER)
		R.speed = 8
		if sword then
			for _, p in sword:GetDescendants() do
				if p:IsA("BasePart") then TweenService:Create(p, TweenInfo.new(0.6), {Transparency = 1}):Play() end
			end
			task.delay(0.7, function() if sword then sword:Destroy() end end)
		end
		waitUntil(31.2)
		Poses.set(K, P.FALL)
		K.speed = 6
		local fallFrom = K.cf.Position
		local lieRot = CFrame.lookAt(Vector3.zero, Vector3.xAxis) * CFrame.Angles(math.rad(90), 0, 0)
		local lieCF = CFrame.new(L + Vector3.new(0, K.lieY, 0)) * lieRot
		track(31.2, 1.6, function(u)
			local p = fallFrom:Lerp(lieCF.Position, u * u)
			local spin = CFrame.Angles(u * math.pi * 2.5, 0, u * 0.8)
			K.cf = (u < 1) and (CFrame.new(p) * CFrame.lookAt(Vector3.zero, Vector3.xAxis) * spin) or lieCF
		end)
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(20, 4, 15), K.cf.Position)
		end)
		waitUntil(32.8)
		K.cf = lieCF
		Poses.set(K, P.LYING)
		K.speed = 30
		playSound("BoomSound", 0.8)
		shake = 1.6
		dust(L + Vector3.new(0, 0.5, 0), 3, 30)
		ring(L + Vector3.new(0, 0.2, 0), Vector3.yAxis, Color3.fromRGB(220, 220, 210), 9, 0.6)
		-- Nono a tout vu : il tourne la tête vers lui
		Poses.patch(N, {Neck = {10, 25, 0}})
		cut(function(t)
			local u = smooth((t - 32.8) / 2.2)
			return CFrame.lookAt(L + Vector3.new(lerp(7, 5, u), lerp(5, 3.4, u), lerp(6, 4, u)), L + Vector3.new(0, 0.6, 0))
		end)

		------------------------------------------------------ 5. Nono arrive à pied, la gifle, le réveil
		waitUntil(35)
		local slapSpot = L + Vector3.new(-2.1, N.standY, 2.7)
		walk(N, 35, 3.2, nStart, slapSpot, 1.1, 10)
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(6, 5, -11), N.cf.Position:Lerp(L, 0.35))
		end)
		waitUntil(38.2)
		local squatCF = CFrame.lookAt(L + Vector3.new(-2.1, N.squatY, 2.7), L + Vector3.new(-2.1, N.squatY, -5))
		moveTo(N, 38.2, 0.4, squatCF)
		Poses.set(N, P.SQUAT_WIND)
		N.speed = 9
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(-6.2, 3.2, -2.6), L + Vector3.new(-2, 0.8, 1))
		end)
		waitUntil(39)
		Poses.set(N, P.SQUAT_SLAP)
		N.speed = 40
		waitUntil(39.12)
		playSound("SlapSound", 1.6)
		shake = 1.2
		local face = head(K)
		popText(face + Vector3.new(0, 2.5, 0), "SLAP!", Color3.fromRGB(255, 220, 60))
		burst(face, Color3.fromRGB(255, 240, 150), 4, 0.3)
		Poses.patch(K, {Neck = {0, -45, 0}}, true)
		-- il sursaute et se réveille d'un coup : il s'assoit
		waitUntil(39.35)
		local sitCF = CFrame.lookAt(L + Vector3.new(0, K.sitY, 0), L + Vector3.new(10, K.sitY, 0))
		moveTo(K, 39.35, 0.3, sitCF, function(u) return 1 - (1 - u) ^ 3 end)
		Poses.set(K, P.SITTING)
		K.speed = 22
		popText(head(K) + Vector3.new(0, 3, 0), "!!", Color3.new(1, 1, 1))
		waitUntil(40)
		moveTo(N, 40, 0.5, CFrame.lookAt(slapSpot + Vector3.new(-0.6, 0, 1), L + Vector3.new(0, N.standY, 0)))
		Poses.set(N, P.STAND)
		N.speed = 8

		------------------------------------------------------ 6. Rexydev1 atterrit : "Are you okay?" et le relève
		local landPos = L + Vector3.new(3.6, R.standY, -0.8)
		local landCF = CFrame.lookAt(landPos, L + Vector3.new(0, R.standY, 0))
		R.cf = landCF + Vector3.new(0, 40, 0)
		Poses.set(R, P.HOVER, true)
		moveTo(R, 40, 2, landCF, function(u) return 1 - (1 - u) ^ 2 end)
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(13, 4, -8), R.cf.Position:Lerp(L, 0.3))
		end)
		waitUntil(42)
		Poses.set(R, P.LEAN_ASK)
		R.speed = 14
		dust(landPos - Vector3.new(0, R.standY - 0.3, 0), 1.5, 12)
		Poses.set(K, P.SITTING)
		Poses.patch(K, {Neck = {20, 0, 0}})
		waitUntil(42.4)
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(1.6, 3.6, 8), head(R):Lerp(head(K), 0.5))
		end)
		say(R, Color3.fromRGB(255, 200, 80), "Are you okay?", 3)
		waitUntil(45.6)
		Poses.set(R, P.PULL)
		Poses.set(K, P.SIT_REACH)
		cut(function(t)
			return CFrame.lookAt(L + Vector3.new(1.5, 4.2, -10), L + Vector3.new(1.8, 2.4, -0.4))
		end)
		waitUntil(46.6)
		local standCF = CFrame.lookAt(L + Vector3.new(0.9, K.standY, 0), L + Vector3.new(10, K.standY, 0))
		moveTo(K, 46.6, 1, standCF)
		Poses.set(K, P.STAND_HOLD)
		K.speed = 6
		moveTo(R, 46.6, 1, landCF * CFrame.new(0, 0, 0.5))
		Poses.set(R, P.STAND_HOLD)
		waitUntil(47.8)
		Poses.set(K, P.STAND)
		Poses.set(R, P.STAND)

		------------------------------------------------------ 7. Ils s'éloignent ensemble
		waitUntil(48.4)
		-- ils marchent côte à côte vers l'allée dégagée (+X)
		local dir = Vector3.new(1, 0, 0)
		local startX = L.X + 2
		for _, info in {{N, 3.6}, {K, 0}, {R, -3.6}} do
			local a, z = info[1], info[2]
			local from = Vector3.new(startX, a.cf.Position.Y, L.Z + z)
			moveTo(a, 48.4, 0.6, CFrame.lookAt(from, from + dir))
			walk(a, 49, 7.5, from, from + dir * 30, 0.7, 7)
		end
		cut(function(t)
			local u = smooth((t - 48.4) / 8)
			return CFrame.lookAt(L + Vector3.new(lerp(-10, -13, u), lerp(4, 8, u), 0), L + Vector3.new(12 + u * 14, 2.5, 0))
		end)
		waitUntil(55.2)
		fadeTo(0, 1.3, Color3.new(0, 0, 0))
		waitUntil(56.6)
	end)
	if not ok then warn("[Cutscene] " .. tostring(err)) end
	conn:Disconnect()
end

local function begin()
	if playing then return end
	playing = true
	-- on fige le joueur et on cache son interface
	local controls
	pcall(function()
		local module = player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("PlayerModule")
		if module then controls = require(module):GetControls() controls:Disable() end
	end)
	-- le personnage du joueur reste immobile pendant la cinématique
	local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local wasAnchored = myRoot and myRoot.Anchored
	if myRoot then myRoot.Anchored = true end
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
	hiddenGuis = {}
	for _, g in player:WaitForChild("PlayerGui"):GetChildren() do
		if g:IsA("ScreenGui") and g.Enabled and g.Name ~= "PointZeroGui" then g.Enabled = false table.insert(hiddenGuis, g) end
	end
	scene = Instance.new("Folder")
	scene.Name = "CutsceneScene"
	scene.Parent = workspace
	buildGui()
	local oldType = camera.CameraType
	camera.CameraType = Enum.CameraType.Scriptable

	local ok, err = pcall(run)
	if not ok then warn("[Cutscene] " .. tostring(err)) end

	-- retour au jeu normal
	scene:Destroy()
	camera.CameraType = Enum.CameraType.Custom
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then camera.CameraSubject = hum end
	for _, g in hiddenGuis do if g.Parent then g.Enabled = true end end
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
	if controls then pcall(function() controls:Enable() end) end
	if myRoot and myRoot.Parent then myRoot.Anchored = wasAnchored or false end
	bars(false)
	fadeTo(1, 0.8)
	task.delay(1, function() if gui then gui:Destroy() end end)
	playing = false
end

ReplicatedStorage:WaitForChild("CutscenePlay").OnClientEvent:Connect(function(action)
	if action == "play" then
		task.spawn(function()
			if not CutsceneLock.take("CutscenePlay", 240) then return end
			pcall(begin)
			CutsceneLock.release("CutscenePlay")
		end)
	end
end)
-- CutsceneClient : cutscene "Dev Studio" (lancée par un admin, voir ServerScriptService.CutsceneServer)
-- kinoshi112 et rexydev1 codent sur Roblox Studio. Nono275er arrive avec deux cafés (un mug et un gobelet, un dans chaque main),
-- ils font pivoter leur chaise pour les prendre, un éternuement plus tard le café est sur les claviers, les PC grillent
-- et prennent feu, tout le monde court sur le balcon... et découvre la map au lever du soleil.
-- Tout est joué en local : décor (ReplicatedStorage.Cutscene.Set), avatars (Cutscene.Rigs) et sons (Cutscene.Sounds).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")
local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local playRemote = remotes:WaitForChild("PlayCutscene")
local folder = ReplicatedStorage:WaitForChild("Cutscene")

local rad, sin, cos, abs, clamp = math.rad, math.sin, math.cos, math.abs, math.clamp
local rgb = Color3.fromRGB
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local KCOL, RCOL, NCOL = rgb(90, 180, 255), rgb(255, 95, 95), rgb(120, 240, 110)

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props or {} do o[k] = v end
	o.Parent = parent
	return o
end
local function smooth(u) u = clamp(u, 0, 1) return u * u * (3 - 2 * u) end
local function easeOutBack(u) u = clamp(u, 0, 1) local c = 1.6 return 1 + (c + 1) * (u - 1) ^ 3 + c * (u - 1) ^ 2 end

---------------------------------------------------------------- interface : bandes cinéma, sous-titres, fondus, titres
local gui = new("ScreenGui", {Name = "CutsceneGui", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 300, Enabled = false}, playerGui)
local topBar = new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.11), Position = UDim2.fromScale(0, -0.11)}, gui)
local bottomBar = new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1.15), Size = UDim2.fromScale(1, 0.15)}, gui)
local caption = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.86, 0.6), FontFace = BOLD,
	TextScaled = true, RichText = true, TextColor3 = Color3.new(1, 1, 1), Text = ""}, bottomBar)
new("UIStroke", {Thickness = 2}, caption)
new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0), Size = UDim2.fromOffset(300, 20), FontFace = BOLD, TextScaled = true,
	TextColor3 = rgb(150, 150, 165), Text = "DEV STUDIO  ·  EVENT", TextXAlignment = Enum.TextXAlignment.Right}, topBar)
local rec = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 22, 0.5, 0), Size = UDim2.fromOffset(12, 12), BackgroundColor3 = rgb(255, 50, 50), BorderSizePixel = 0}, topBar)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, rec)
new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 42, 0.5, 0), Size = UDim2.fromOffset(120, 18), FontFace = BOLD, TextScaled = true,
	TextColor3 = rgb(200, 200, 210), Text = "REC", TextXAlignment = Enum.TextXAlignment.Left}, topBar)
local fade = new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0, ZIndex = 20}, gui)
local flash = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 19}, gui)
local function bigText(y, size, color, z)
	local l = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, y), Size = UDim2.fromScale(0.9, size), FontFace = HEAVY,
		TextScaled = true, TextColor3 = color, Text = "", TextTransparency = 1, ZIndex = z or 10}, gui)
	local s = new("UIStroke", {Thickness = 5, Transparency = 1}, l)
	local sc = new("UIScale", {}, l)
	return {Label = l, Stroke = s, Scale = sc}
end
local titleBig = bigText(0.36, 0.12, rgb(255, 210, 60))
local titleSub = bigText(0.48, 0.08, Color3.new(1, 1, 1))
local cardBig = bigText(0.45, 0.13, Color3.new(1, 1, 1), 25)
local cardSub = bigText(0.56, 0.05, rgb(255, 90, 90), 25)

local captionToken = 0
local function say(text, color, who)
	captionToken += 1
	local my = captionToken
	if who then
		caption.Text = string.format('<font color="#%s">%s</font>  %s', color:ToHex(), who, text)
	else
		caption.Text = '<i>' .. text .. '</i>'
	end
	-- effet machine à écrire
	local total = #caption.ContentText
	caption.MaxVisibleGraphemes = 0
	task.spawn(function()
		local s = os.clock()
		while captionToken == my and caption.MaxVisibleGraphemes < total do
			caption.MaxVisibleGraphemes = math.floor((os.clock() - s) * 55)
			RunService.RenderStepped:Wait()
		end
		if captionToken == my then caption.MaxVisibleGraphemes = -1 end
	end)
end
local function showText(t, text, on, pop)
	if text then t.Label.Text = text end
	TweenService:Create(t.Label, TweenInfo.new(0.5), {TextTransparency = on and 0 or 1}):Play()
	TweenService:Create(t.Stroke, TweenInfo.new(0.5), {Transparency = on and 0 or 1}):Play()
	if on and pop then
		t.Scale.Scale = 0.6
		TweenService:Create(t.Scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end
end
local function fadeTo(alpha, t) TweenService:Create(fade, TweenInfo.new(t or 0.8), {BackgroundTransparency = alpha}):Play() end
local function flashWhite(t)
	flash.BackgroundTransparency = 0.25
	TweenService:Create(flash, TweenInfo.new(t or 0.35), {BackgroundTransparency = 1}):Play()
end
local function letterbox(on)
	TweenService:Create(topBar, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Position = UDim2.fromScale(0, on and 0 or -0.11)}):Play()
	TweenService:Create(bottomBar, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Position = UDim2.fromScale(0, on and 1 or 1.15)}):Play()
end

---------------------------------------------------------------- avatars : poses + animations procédurales
local JOINTS = {"Neck", "Waist", "Root", "LeftShoulder", "RightShoulder", "LeftElbow", "RightElbow", "LeftWrist", "RightWrist", "LeftHip", "RightHip", "LeftKnee", "RightKnee", "LeftAnkle", "RightAnkle"}
local SIT = {LeftHip = {88, 0, 4}, RightHip = {88, 0, -4}, LeftKnee = {-88, 0, 0}, RightKnee = {-88, 0, 0}, LeftAnkle = {6, 0, 0}, RightAnkle = {6, 0, 0}}
local function withSit(extra)
	local p = table.clone(SIT)
	for k, v in extra do p[k] = v end
	return p
end
local POSES = {
	Stand = {LeftShoulder = {0, 0, -3}, RightShoulder = {0, 0, 3}, LeftElbow = {8, 0, 0}, RightElbow = {8, 0, 0}},
	Type = withSit({LeftShoulder = {70, 0, 16}, RightShoulder = {70, 0, -16}, LeftElbow = {28, 0, 0}, RightElbow = {28, 0, 0}, LeftWrist = {-12, 0, 0}, RightWrist = {-12, 0, 0}, Neck = {-12, 0, 0}, Waist = {-10, 0, 0}}),
	Stretch = withSit({LeftShoulder = {170, 0, -12}, RightShoulder = {170, 0, 12}, LeftElbow = {35, 0, 0}, RightElbow = {35, 0, 0}, Neck = {18, 0, 0}, Waist = {8, 0, 0}}),
	Carry = {LeftShoulder = {42, 0, 6}, RightShoulder = {42, 0, -6}, LeftElbow = {58, 0, 0}, RightElbow = {58, 0, 0}, Neck = {-4, 0, 0}},
	GiveLeft = {LeftShoulder = {78, 0, 10}, LeftElbow = {12, 0, 0}, RightShoulder = {42, 0, -6}, RightElbow = {58, 0, 0}, Waist = {-6, 0, 0}},
	GiveRight = {RightShoulder = {78, 0, -10}, RightElbow = {12, 0, 0}, LeftShoulder = {10, 0, 0}, LeftElbow = {10, 0, 0}, Waist = {-6, 0, 0}},
	SitReach = withSit({RightShoulder = {82, 0, -6}, RightElbow = {14, 0, 0}, Waist = {-10, 0, 0}, LeftShoulder = {12, 0, 0}, LeftElbow = {25, 0, 0}}),
	SitHold = withSit({RightShoulder = {38, 0, -6}, RightElbow = {62, 0, 0}, LeftShoulder = {20, 0, 0}, LeftElbow = {40, 0, 0}}),
	Toast = withSit({RightShoulder = {125, 0, -18}, RightElbow = {35, 0, 0}, LeftShoulder = {20, 0, 0}, LeftElbow = {40, 0, 0}, Neck = {8, 0, 0}}),
	Drink = withSit({RightShoulder = {98, 0, 8}, RightElbow = {72, 0, 0}, Neck = {14, 0, 0}, LeftShoulder = {20, 0, 0}, LeftElbow = {40, 0, 0}}),
	Sneeze = withSit({RightShoulder = {70, 0, -10}, RightElbow = {25, 0, 0}, LeftShoulder = {95, 0, 20}, LeftElbow = {110, 0, 0}, Neck = {-32, 0, 0}, Waist = {-18, 0, 0}}),
	Shock = withSit({RightShoulder = {70, 0, -25}, RightElbow = {10, 0, 0}, LeftShoulder = {120, 0, 25}, LeftElbow = {60, 0, 0}, Neck = {-12, 0, 0}, Waist = {8, 0, 0}}),
	Facepalm = {LeftShoulder = {120, 0, 25}, LeftElbow = {115, 0, 0}, RightShoulder = {10, 0, 0}, Neck = {-20, 0, 0}, Waist = {-8, 0, 0}},
	Panic = {LeftShoulder = {165, 0, -15}, RightShoulder = {165, 0, 15}, LeftElbow = {25, 0, 0}, RightElbow = {25, 0, 0}, Neck = {12, 0, 0}},
	Proud = {LeftShoulder = {5, 0, -45}, RightShoulder = {5, 0, 45}, LeftElbow = {95, 0, 0}, RightElbow = {95, 0, 0}, Neck = {5, 0, 0}},
	Lean = {LeftShoulder = {72, 0, 10}, RightShoulder = {72, 0, -10}, LeftElbow = {38, 0, 0}, RightElbow = {38, 0, 0}, Waist = {-14, 0, 0}, Neck = {6, 0, 0}},
	Wave = {RightShoulder = {160, 0, -20}, RightElbow = {22, 0, 0}, LeftShoulder = {5, 0, -3}},
	-- remise des cafés
	SitRest = withSit({LeftShoulder = {22, 0, 6}, RightShoulder = {22, 0, -6}, LeftElbow = {48, 0, 0}, RightElbow = {48, 0, 0}, Waist = {4, 0, 0}}),
	Burn = withSit({RightShoulder = {118, 0, -25}, RightElbow = {30, 0, 0}, RightWrist = {20, 0, 0}, LeftShoulder = {70, 0, 20}, LeftElbow = {95, 0, 0}, Neck = {18, 0, 0}, Waist = {14, 0, 0}}),
	GiveLeftOut = {LeftShoulder = {86, 0, 14}, LeftElbow = {6, 0, 0}, LeftWrist = {-10, 0, 0}, RightShoulder = {42, 0, -6}, RightElbow = {58, 0, 0}, Waist = {-12, 0, 0}, Neck = {-8, 0, 0}},
	GiveRightOut = {RightShoulder = {86, 0, -14}, RightElbow = {6, 0, 0}, RightWrist = {-10, 0, 0}, LeftShoulder = {8, 0, -4}, LeftElbow = {12, 0, 0}, Waist = {-12, 0, 0}, Neck = {-8, 0, 0}},
	SitReachFar = withSit({RightShoulder = {95, 0, -8}, RightElbow = {2, 0, 0}, RightWrist = {-12, 0, 0}, LeftShoulder = {18, 0, 4}, LeftElbow = {30, 0, 0}, Waist = {-18, 0, 0}, Neck = {-10, 0, 0}}),
	SitGrab = withSit({RightShoulder = {88, 0, -6}, RightElbow = {18, 0, 0}, RightWrist = {6, 0, 0}, LeftShoulder = {18, 0, 4}, LeftElbow = {30, 0, 0}, Waist = {-14, 0, 0}, Neck = {-8, 0, 0}}),
	SitSniff = withSit({RightShoulder = {62, 0, 4}, RightElbow = {98, 0, 0}, LeftShoulder = {40, 0, 14}, LeftElbow = {75, 0, 0}, Neck = {-20, 0, 0}, Waist = {-6, 0, 0}}),
	SitThanks = withSit({RightShoulder = {45, 0, -6}, RightElbow = {65, 0, 0}, LeftShoulder = {70, 0, 22}, LeftElbow = {30, 0, 0}, Neck = {6, 0, 0}}),
	SitBlow = withSit({RightShoulder = {78, 0, 8}, RightElbow = {104, 0, 0}, LeftShoulder = {42, 0, 16}, LeftElbow = {88, 0, 0}, Neck = {-8, 0, 0}, Waist = {-4, 0, 0}}),
	-- éternuement / sursaut / café renversé
	SneezeWindup = withSit({RightShoulder = {62, 0, -6}, RightElbow = {70, 0, 0}, LeftShoulder = {60, 0, 18}, LeftElbow = {95, 0, 0}, Neck = {28, 0, 0}, Waist = {12, 0, 0}}),
	SneezeSpill = withSit({RightShoulder = {92, 0, -6}, RightElbow = {4, 0, 0}, RightWrist = {-25, 0, 0}, LeftShoulder = {95, 0, 20}, LeftElbow = {110, 0, 0}, Neck = {-35, 0, 0}, Waist = {-24, 0, 0}}),
	Startle = withSit({RightShoulder = {102, 0, -14}, RightElbow = {2, 0, 0}, RightWrist = {-25, 0, 0}, LeftShoulder = {115, 0, 28}, LeftElbow = {45, 0, 0}, Neck = {14, 0, 0}, Waist = {14, 0, 0}}),
	Wipe = withSit({LeftShoulder = {72, 0, 10}, RightShoulder = {72, 0, -10}, LeftElbow = {22, 0, 0}, RightElbow = {22, 0, 0}, LeftWrist = {-12, 0, 0}, RightWrist = {-12, 0, 0}, Waist = {-22, 0, 0}, Neck = {-22, 0, 0}}),
	Cheer = {LeftShoulder = {160, 0, -20}, RightShoulder = {160, 0, 20}, LeftElbow = {15, 0, 0}, RightElbow = {15, 0, 0}, Neck = {10, 0, 0}},
}

-- vraies animations Roblox (marche / course / respiration) jouées par l'Animator, par-dessus les poses
local SHOW_NAMES = false -- pseudos au-dessus des têtes désactivés
local ANIM_IDS = {Walk = 507777826, Run = 507767714, Idle = 507766388}
local ANIM_OBJS = {}
for name, id in ANIM_IDS do ANIM_OBJS[name] = new("Animation", {Name = name, AnimationId = "rbxassetid://" .. id}) end
local function newHand(nextT) return {U = 1, Dur = 0.1, Next = nextT, Reach = 0, Row = 0, Reach0 = 0, Row0 = 0, Lift = 0, Pressed = true} end

local function makeActor(rig, color, label)
	local a = {Rig = rig, Root = rig:WaitForChild("HumanoidRootPart"), Joints = {}, Angles = {}, Target = POSES.Stand, Speed = 7,
		Shake = 0, Typing = false, Waving = false, Pushing = false, Flail = false, Move = 0, Run = false, Phase = 0, Look = nil, LookW = 0, Seed = math.random() * 50,
		TypeW = 0, Ty = {Pause = 0, Burst = 2 + math.random() * 2, Mouse = false, MouseW = 0, PauseW = 0, L = newHand(0), R = newHand(0.06)}, Tracks = {}}
	-- les avatars récents utilisent des AnimationConstraint : on les remplace par des Motor6D pour pouvoir animer les bras/jambes
	for _, d in rig:GetDescendants() do
		if d:IsA("AnimationConstraint") and d.Attachment0 and d.Attachment1 then
			local m6 = Instance.new("Motor6D")
			m6.Name = d.Name
			m6.Part0 = d.Attachment0.Parent
			m6.Part1 = d.Attachment1.Parent
			m6.C0 = d.Attachment0.CFrame
			m6.C1 = d.Attachment1.CFrame
			local parent = d.Parent
			d:Destroy()
			m6.Parent = parent
		elseif d:IsA("BallSocketConstraint") or d:IsA("HingeConstraint") then
			d:Destroy()
		end
	end
	for _, d in rig:GetDescendants() do
		if d:IsA("Motor6D") and table.find(JOINTS, d.Name) then
			a.Joints[d.Name] = {Motor = d, Base = d.C0}
			a.Angles[d.Name] = Vector3.zero
		end
	end
	a.Root.Anchored = true
	local humanoid = rig:FindFirstChildOfClass("Humanoid")
	if humanoid then
		pcall(function() humanoid.EvaluateStateMachine = false end)
		local animator = humanoid:FindFirstChildOfClass("Animator") or new("Animator", {}, humanoid)
		for name, anim in ANIM_OBJS do
			local ok, tr = pcall(function() return animator:LoadAnimation(anim) end)
			if ok and tr then
				tr.Priority = name == "Idle" and Enum.AnimationPriority.Idle or Enum.AnimationPriority.Movement
				a.Tracks[name] = tr
			end
		end
	end
	a.StandOffset = (humanoid and humanoid.HipHeight or 2) + a.Root.Size.Y / 2
	local lower, hip = rig:FindFirstChild("LowerTorso"), a.Joints.LeftHip
	local hipY = -1
	if lower and hip then hipY = (lower.CFrame * hip.Base).Position.Y - a.Root.Position.Y end
	local thigh = rig:FindFirstChild("LeftUpperLeg")
	a.SitOffset = (thigh and thigh.Size.Z / 2 or 0.5) - hipY
	local head = rig:FindFirstChild("Head")
	a.Head = head
	if head and SHOW_NAMES then
		local bb = new("BillboardGui", {Name = "CutsceneTag", Adornee = head, ResetOnSpawn = false, Size = UDim2.fromOffset(200, 30), StudsOffset = Vector3.new(0, 2.1, 0), AlwaysOnTop = true,
			LightInfluence = 0, MaxDistance = math.huge}, playerGui)
		local t = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), FontFace = HEAVY, TextScaled = true, TextColor3 = color, Text = label}, bb)
		new("UIStroke", {Thickness = 2.5}, t)
		a.Tag = bb
	end
	return a
end
local function setPose(a, name, speed) if a then a.Target = POSES[name] or POSES.Stand a.Speed = speed or 7 end end
local function snapPose(a)
	for name in a.Joints do
		local t = a.Target[name]
		a.Angles[name] = t and Vector3.new(t[1], t[2], t[3]) or Vector3.zero
	end
end

-- angles (degrés) pour que la tête regarde un point
local function lookAngles(a)
	if not a.Look or not a.Head then return 0, 0 end
	local upper = a.Rig:FindFirstChild("UpperTorso")
	if not upper then return 0, 0 end
	local target = typeof(a.Look) == "Instance" and a.Look.Position or a.Look
	local dir = upper.CFrame:VectorToObjectSpace((target - a.Head.Position).Unit)
	local yaw = math.deg(math.atan2(-dir.X, -dir.Z))
	local pitch = math.deg(math.asin(clamp(dir.Y, -1, 1)))
	return clamp(pitch, -35, 35), clamp(yaw, -75, 75)
end

-- frappe au clavier réaliste : rafales de frappes, pauses de réflexion, main sur la souris, touches qui s'enfoncent
local SIDES = {"L", "R"}
local WHITE = Color3.new(1, 1, 1)
local function typingTick(a, dt)
	local ty = a.Ty
	if a.Typing then
		if ty.Pause > 0 then
			ty.Pause -= dt
		else
			ty.Burst -= dt
			if ty.Burst <= 0 then -- petite pause : relit son code, ou attrape la souris
				ty.Pause = 0.3 + math.random() * 0.4
				ty.Burst = 2.2 + math.random() * 2.8
				ty.Mouse = math.random() < 0.3
			end
		end
	end
	local paused = a.Typing and ty.Pause > 0
	local active = a.Typing and not paused
	ty.MouseW += (((paused and ty.Mouse) and 1 or 0) - ty.MouseW) * math.min(1, dt * 7)
	ty.PauseW += ((paused and 1 or 0) - ty.PauseW) * math.min(1, dt * 5)
	for _, side in SIDES do
		local h = ty[side]
		h.U = math.min(1, h.U + dt / h.Dur)
		if active and not (side == "R" and ty.MouseW > 0.3) then
			h.Next -= dt
			if h.Next <= 0 then -- nouvelle frappe : la main se lève puis retombe sur une touche
				h.U, h.Dur, h.Pressed = 0, 0.08 + math.random() * 0.05, false
				h.Next = 0.07 + math.random() * 0.16 + (math.random() < 0.12 and 0.22 or 0)
				h.Reach, h.Row = math.random() * 2 - 1, math.random() * 2 - 1
			end
		end
		if h.U >= 0.8 and not h.Pressed then
			h.Pressed = true
			local list = a.Keys and a.Keys[side]
			if list and #list > 0 then list[math.random(1, #list)].T = 0 end
		end
		h.Lift = h.U < 1 and sin(h.U * math.pi) or 0
		h.Reach0 += (h.Reach - h.Reach0) * math.min(1, dt * 16)
		h.Row0 += (h.Row - h.Row0) * math.min(1, dt * 16)
	end
	-- les touches s'enfoncent et s'illuminent sous les doigts
	if a.Keys then
		for _, list in a.Keys do
			for _, k in list do
				if k.T then
					k.T += dt
					local d = k.T < 0.05 and 1 or math.max(0, 1 - (k.T - 0.05) / 0.12)
					k.Part.CFrame = k.CF - Vector3.new(0, 0.08 * d, 0)
					k.Part.Color = k.Color:Lerp(WHITE, 0.55 * d)
					if d <= 0 then k.T = nil k.Part.CFrame = k.CF k.Part.Color = k.Color end
				end
			end
		end
	end
end

local function updateActor(a, dt, t)
	-- chaise qui pivote : l'avatar suit l'assise
	if a.Chair and a.Rel then a.Root.CFrame = a.Chair:GetPivot() * a.Rel end
	typingTick(a, dt)
	a.TypeW += ((a.Typing and 1 or 0) - a.TypeW) * math.min(1, dt * 5)
	local tw, ty = a.TypeW, a.Ty
	local hL, hR, mw, pw = ty.L, ty.R, ty.MouseW, ty.PauseW
	local animGait = a.GaitTrack ~= nil and a.GaitTrack.Length > 0
	-- bras tendu vers une cible (la tasse, la personne) : on calcule l'angle de l'épaule pour viser le point
	a.AimW = (a.AimW or 0) + ((a.Aim and 1 or 0) - (a.AimW or 0)) * math.min(1, dt * 5)
	if a.Aim then a.AimLast = a.Aim end
	local aim, aimX, aimZ = a.AimLast, nil, nil
	if aim and a.AimW > 0.01 then
		local upper = a.Rig:FindFirstChild("UpperTorso")
		local sj = a.Joints[aim.Side .. "Shoulder"]
		local tgt = typeof(aim.Target) == "Instance" and aim.Target.Position or aim.Target
		if upper and sj and tgt then
			local d = upper.CFrame:VectorToObjectSpace(tgt - (upper.CFrame * sj.Base).Position)
			if d.Magnitude > 0.05 then
				d = d.Unit
				aimX = math.deg(math.atan2(-d.Z, -d.Y))
				aimZ = math.deg(math.asin(clamp(d.X, -1, 1)))
			end
		end
	end
	local blend = math.min(1, dt * a.Speed)
	a.LookW += ((a.Look and 1 or 0) - a.LookW) * math.min(1, dt * 4)
	local lp, ly = lookAngles(a)
	local move, run = a.Move, a.Run
	local ph = a.Phase
	local s, c = sin(ph), cos(ph)
	local hipA, kneeA, armA, elbowA = run and 48 or 30, run and 85 or 48, run and 50 or 26, run and 75 or 14
	local breathe = sin(t * 1.6 + a.Seed) * 1.6
	local free = a.Target == POSES.Stand
	for name, j in a.Joints do
		local target = a.Target[name]
		local goal = target and Vector3.new(target[1], target[2], target[3]) or Vector3.zero
		local current = a.Angles[name]:Lerp(goal, blend)
		a.Angles[name] = current
		local x, y, z = 0, 0, 0
		-- marche / course : jambes, genoux, chevilles, bras opposés, torse qui se balance
		if move > 0.01 and animGait then
			-- l'animation Roblox gère les jambes et les bras : on ajoute juste l'inclinaison / les bras en panique
			if name == "Waist" then x = run and -8 or -1
			elseif name == "Neck" then x = run and 6 or 0
			elseif a.Flail and (name == "LeftShoulder" or name == "RightShoulder") then
				x, z = 120 + sin(t * 18 + (name == "LeftShoulder" and 0 or 2)) * 25, (name == "LeftShoulder" and -1 or 1) * 15
			end
			x, y, z = x * move, y * move, z * move
		elseif move > 0.01 then
			if name == "LeftHip" then x = s * hipA
			elseif name == "RightHip" then x = -s * hipA
			elseif name == "LeftKnee" then x = -math.max(0, c) * kneeA - 6
			elseif name == "RightKnee" then x = -math.max(0, -c) * kneeA - 6
			elseif name == "LeftAnkle" then x = s * 12
			elseif name == "RightAnkle" then x = -s * 12
			elseif name == "Waist" then x, y = (run and -12 or -3), s * (run and 9 or 6)
			elseif name == "Neck" then x, y = (run and 8 or 2), -s * 4
			elseif (not target or free) and (name == "LeftShoulder" or name == "RightShoulder") then
				if a.Flail then x, z = 150 + sin(t * 18 + (name == "LeftShoulder" and 0 or 2)) * 25, (name == "LeftShoulder" and -1 or 1) * 15
				else x = (name == "LeftShoulder" and -s or s) * armA end
			elseif (not target or free) and (name == "LeftElbow" or name == "RightElbow") then x = elbowA + (name == "LeftElbow" and math.max(0, -s) or math.max(0, s)) * 15
			end
			x, y, z = x * move, y * move, z * move
		end
		-- respiration
		if name == "Waist" then x += breathe * 0.6 end
		if name == "LeftShoulder" or name == "RightShoulder" then z += (name == "LeftShoulder" and -1 or 1) * breathe * 0.4 end
		-- frappe au clavier : poignets et avant-bras qui tapent vite, la tête suit l'écran
		if tw > 0.01 then
			local kw = 1 - mw -- main droite sur le clavier (0 = sur la souris)
			if name == "LeftShoulder" then
				x += (hL.Row0 * 7 + hL.Lift * 15) * tw
				y += hL.Reach0 * 14 * tw
			elseif name == "RightShoulder" then
				x += ((hR.Row0 * 7 + hR.Lift * 15) * kw - mw * 8) * tw
				y += hR.Reach0 * 14 * kw * tw
				z += mw * 16 * tw
			elseif name == "LeftElbow" then
				x += (hL.Lift * 42 + sin(t * 2.3 + a.Seed) * 4) * tw
			elseif name == "RightElbow" then
				x += (hR.Lift * 42 * kw - mw * 10 + sin(t * 2.1 + a.Seed) * 4) * tw
			elseif name == "LeftWrist" then
				x += (hL.Lift * 28 - 4 + sin(t * 37 + a.Seed) * 2.5 * (1 - pw)) * tw
				z += sin(t * 29 + a.Seed) * 3 * (1 - pw) * tw
			elseif name == "RightWrist" then
				x += (hR.Lift * 28 * kw - 4 + sin(t * 33 + a.Seed) * 2.5 * kw * (1 - pw)) * tw
				y += mw * sin(t * 4.5 + a.Seed) * 10 * tw -- petits mouvements de souris
				z += (sin(t * 31 + a.Seed) * 3 * kw * (1 - pw) + mw * math.noise(t * 2, a.Seed) * 8) * tw
			elseif name == "Waist" then
				x += ((hL.Lift + hR.Lift) * 0.9 + pw * 3) * tw
				y += -mw * 7 * tw
			elseif name == "Neck" then -- lit le code de gauche à droite, hoche la tête en tapant, se penche pour relire
				x += (sin(t * 0.9 + a.Seed) * 3 + (hL.Lift + hR.Lift) * 1.4 - pw * 6) * tw
				y += (sin(t * 0.55 + a.Seed) * 7 + mw * 10) * tw
			end
		end
		-- les pieds poussent le sol pour faire tourner la chaise
		if a.Pushing then
			if name == "LeftHip" then x += sin(t * 15) * 16
			elseif name == "RightHip" then x -= sin(t * 15) * 16
			elseif name == "LeftKnee" then x += math.max(0, sin(t * 15)) * 22
			elseif name == "RightKnee" then x += math.max(0, -sin(t * 15)) * 22 end
		end
		-- tient sa tasse : le bras bouge doucement, comme une vraie main qui tient un café chaud
		if a.Holding then
			local hs = sin(t * 1.4 + a.Seed)
			if name == "RightShoulder" then x += hs * 3 z += cos(t * 1.1 + a.Seed) * 2
			elseif name == "RightElbow" then x += sin(t * 1.4 + a.Seed + 0.7) * 5
			elseif name == "RightWrist" then x += hs * 4 end
		end
		-- essuie le clavier en panique avec les deux mains
		if a.Wiping then
			local w = sin(t * 16 + a.Seed)
			if name == "LeftShoulder" then y += w * 22 x += cos(t * 16) * 5
			elseif name == "RightShoulder" then y -= w * 22 x -= cos(t * 16) * 5
			elseif name == "Waist" then y += w * 6
			elseif name == "LeftElbow" or name == "RightElbow" then x += abs(w) * 12 end
		end
		if a.Waving and name == "RightShoulder" then z += sin(t * 9) * 28 end
		if a.Waving and name == "RightElbow" then x += sin(t * 9 + 0.5) * 15 end
		if a.Shake > 0 and (name == "LeftShoulder" or name == "RightShoulder" or name == "Neck" or name == "Waist") then
			x += sin(t * 31 + a.Seed) * 10 * a.Shake
			z += cos(t * 27 + a.Seed) * 8 * a.Shake
		end
		-- la tête (et un peu le torse) regarde la cible
		if a.LookW > 0.01 then
			if name == "Neck" then x += lp * a.LookW * 0.7 y += ly * a.LookW * 0.7
			elseif name == "Waist" then y += ly * a.LookW * 0.3 end
		end
		local v = current + Vector3.new(x, y, z)
		if aimX then
			if name == aim.Side .. "Shoulder" then v = v:Lerp(Vector3.new(aimX, 0, aimZ), a.AimW)
			elseif name == aim.Side .. "Elbow" then v = v:Lerp(Vector3.new(8, 0, 0), a.AimW)
			elseif name == aim.Side .. "Wrist" then v = v:Lerp(Vector3.new(-6, 0, 0), a.AimW) end
		end
		j.Motor.C0 = j.Base * CFrame.Angles(rad(v.X), rad(v.Y), rad(v.Z))
	end
end

-- marche / course le long de points (coordonnées locales du décor, au sol) ; virages en douceur
local function startGait(a, run, speed)
	local tr = a.Tracks[run and "Run" or "Walk"]
	if a.Tracks.Idle and a.Tracks.Idle.IsPlaying then a.Tracks.Idle:Stop(0.25) end
	if a.GaitTrack and a.GaitTrack ~= tr then a.GaitTrack:Stop(0.2) end
	if tr then
		if not tr.IsPlaying then tr:Play(0.25) end
		tr:AdjustSpeed(run and speed / 15 or speed / 8.5)
	end
	a.GaitTrack = tr
end
local function stopGait(a)
	if a.GaitTrack then a.GaitTrack:Stop(0.3) end
	a.GaitTrack = nil
	if not a.Chair and a.Tracks.Idle and not a.Tracks.Idle.IsPlaying then a.Tracks.Idle:Play(0.4) end
end

local function walk(a, points, speed, run, O)
	if not a then return end
	a.Chair = nil
	a.Run = run == true
	startGait(a, a.Run, speed)
	local stride = run and 6.2 or 4.4
	local pos = a.Root.Position
	local look = a.Root.CFrame.Rotation
	local walking = true
	task.spawn(function() -- démarrage progressif de l'animation
		while walking do a.Move = math.min(1, a.Move + RunService.RenderStepped:Wait() * 5) end
	end)
	for _, p in points do
		local goal = (O * CFrame.new(p.X, 0, p.Z)).Position + Vector3.new(0, a.StandOffset, 0)
		local start = pos
		local dist = (goal - start).Magnitude
		local wantLook = dist > 0.05 and CFrame.lookAt(start, Vector3.new(goal.X, start.Y, goal.Z)).Rotation or look
		local traveled = 0
		while traveled < dist do
			local dt = RunService.RenderStepped:Wait()
			local step = math.min(speed * dt * math.max(0.3, a.Move), dist - traveled) -- il accélère en partant
			traveled += step
			a.Phase += step / stride * math.pi * 2
			look = look:Lerp(wantLook, math.min(1, dt * 6)) -- virages plus ronds
			local bob = (0.5 - 0.5 * cos(a.Phase * 2)) * (run and 0.3 or 0.14) * ((a.GaitTrack and a.GaitTrack.Length > 0) and 0.35 or 1)
			a.Root.CFrame = CFrame.new(start:Lerp(goal, traveled / math.max(dist, 0.001)) + Vector3.new(0, bob, 0)) * look
		end
		pos = goal
	end
	walking = false
	stopGait(a)
	local s = os.clock()
	while os.clock() - s < 0.25 do -- dernier pas
		local dt = RunService.RenderStepped:Wait()
		a.Move = math.max(0, a.Move - dt * 4)
		a.Root.CFrame = CFrame.new(pos) * look
	end
	a.Move = 0
	a.Root.CFrame = CFrame.new(pos) * look
end

local function turnTo(a, point, t)
	if not a then return end
	local from = a.Root.CFrame
	local p = from.Position
	local to = CFrame.lookAt(p, Vector3.new(point.X, p.Y, point.Z))
	local s = os.clock()
	while os.clock() - s < t do
		a.Root.CFrame = from:Lerp(to, smooth((os.clock() - s) / t))
		RunService.RenderStepped:Wait()
	end
	a.Root.CFrame = to
end

---------------------------------------------------------------- tasses de café réalistes
local function cpart(model, size, cf, color, o)
	o = o or {}
	return new("Part", {Name = o.Name or "Cup", Size = size, CFrame = cf, Color = color, Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = o.Shadow ~= false,
		Material = o.Material or Enum.Material.SmoothPlastic, Reflectance = o.Reflectance or 0, Transparency = o.Transparency or 0, Shape = o.Shape or Enum.PartType.Block,
		TopSurface = Enum.SurfaceType.Smooth, BottomSurface = Enum.SurfaceType.Smooth}, model)
end
local UPRIGHT = CFrame.Angles(0, 0, math.pi / 2) -- un cylindre Roblox est couché sur X : on le met debout
local function cyl(model, height, diameter, y, color, o)
	o = o or {}
	o.Shape = Enum.PartType.Cylinder
	return cpart(model, Vector3.new(height, diameter, diameter), CFrame.new(0, y, 0) * UPRIGHT, color, o)
end
local function steam(parent, rate)
	return new("ParticleEmitter", {Name = "Steam", Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(rgb(255, 255, 255)), LightEmission = 0.15,
		Rate = rate or 5, Lifetime = NumberRange.new(1.2, 2), Speed = NumberRange.new(0.5, 1), Acceleration = Vector3.new(0, 0.6, 0), Drag = 1.5,
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.12), NumberSequenceKeypoint.new(1, 0.75)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.7), NumberSequenceKeypoint.new(1, 1)}),
		RotSpeed = NumberRange.new(-60, 60), Rotation = NumberRange.new(0, 360), SpreadAngle = Vector2.new(8, 8), EmissionDirection = Enum.NormalId.Top}, parent)
end
-- mug rouge en céramique : anse arrondie, bord blanc, café avec crème et un cœur de lait
local function makeMug()
	local m = new("Model", {Name = "Mug"})
	local base = cpart(m, Vector3.new(0.2, 0.2, 0.2), CFrame.new(), rgb(255, 255, 255), {Transparency = 1, Name = "Base"})
	m.PrimaryPart = base
	local RED, RED2 = rgb(205, 30, 45), rgb(165, 20, 35)
	cyl(m, 0.1, 0.62, 0.05, RED2, {Reflectance = 0.06})                                  -- pied
	cyl(m, 0.86, 0.78, 0.5, RED, {Reflectance = 0.08})                                    -- corps
	cyl(m, 0.06, 0.8, 0.9, rgb(245, 245, 245), {Reflectance = 0.1})                       -- bord émaillé
	cyl(m, 0.02, 0.68, 0.905, rgb(70, 38, 18), {Name = "Coffee"})                          -- café
	cyl(m, 0.022, 0.5, 0.91, rgb(185, 130, 80), {Name = "Coffee"})                         -- crème
	cyl(m, 0.024, 0.2, 0.915, rgb(250, 240, 225), {Name = "Coffee"})                       -- cœur de lait
	cpart(m, Vector3.new(0.12, 0.024, 0.12), CFrame.new(0.07, 0.916, 0) * CFrame.Angles(0, rad(45), 0), rgb(250, 240, 225), {Name = "Coffee"})
	for i = 0, 6 do -- anse en arc de cercle
		local ang = rad(-80 + i * 160 / 6)
		cpart(m, Vector3.new(0.1, 0.1, 0.1), CFrame.new(0.4 + cos(ang) * 0.2, 0.5 + sin(ang) * 0.24, 0), RED, {Shape = Enum.PartType.Ball, Reflectance = 0.08})
	end
	cpart(m, Vector3.new(0.03, 0.22, 0.22), CFrame.new(0.0, 0.52, -0.39) * CFrame.Angles(0, rad(90), 0), rgb(255, 255, 255), {Name = "Logo"})
	local top = cpart(m, Vector3.new(0.1, 0.1, 0.1), CFrame.new(0, 0.95, 0), rgb(255, 255, 255), {Transparency = 1, Name = "Mouth"})
	steam(top, 5)
	return m
end
-- gobelet à emporter : carton légèrement évasé, manchon kraft, couvercle avec rebord et trou
local function makeTakeaway()
	local m = new("Model", {Name = "Takeaway"})
	local base = cpart(m, Vector3.new(0.2, 0.2, 0.2), CFrame.new(), rgb(255, 255, 255), {Transparency = 1, Name = "Base"})
	m.PrimaryPart = base
	for i = 0, 5 do cyl(m, 0.2, 0.52 + i * 0.035, 0.1 + i * 0.19, rgb(248, 246, 240)) end  -- gobelet évasé
	cyl(m, 0.42, 0.66, 0.55, rgb(180, 132, 85))                                             -- manchon carton
	cyl(m, 0.04, 0.67, 0.36, rgb(150, 105, 65))
	cyl(m, 0.04, 0.67, 0.74, rgb(150, 105, 65))
	cpart(m, Vector3.new(0.03, 0.24, 0.24), CFrame.new(0, 0.55, -0.335) * CFrame.Angles(0, rad(90), 0), rgb(30, 130, 80), {Shape = Enum.PartType.Cylinder, Name = "Logo"})
	cpart(m, Vector3.new(0.035, 0.12, 0.12), CFrame.new(0, 0.55, -0.35) * CFrame.Angles(0, rad(90), 0), rgb(245, 245, 240), {Shape = Enum.PartType.Cylinder, Name = "Logo"})
	cyl(m, 0.07, 0.8, 1.2, rgb(240, 240, 238), {Reflectance = 0.05})                        -- rebord du couvercle
	cyl(m, 0.1, 0.66, 1.27, rgb(250, 250, 248), {Reflectance = 0.05})                       -- dôme
	cpart(m, Vector3.new(0.16, 0.04, 0.07), CFrame.new(0, 1.325, -0.2), rgb(40, 30, 25), {Name = "Mouth"}) -- trou pour boire
	steam(m:FindFirstChild("Mouth"), 3)
	return m
end

---------------------------------------------------------------- sons
local soundsFolder = folder:WaitForChild("Sounds", 10)
local activeSounds = {}
local function sfx(name, parent, props)
	local template = soundsFolder and soundsFolder:FindFirstChild(name)
	if not template then return nil end
	local s = template:Clone()
	s.RollOffMinDistance, s.RollOffMaxDistance = 10, 120
	for k, v in props or {} do s[k] = v end
	s.Parent = parent or SoundService
	s:Play()
	table.insert(activeSounds, s)
	if not s.Looped then Debris:AddItem(s, math.max(s.TimeLength, 12) + 1) end
	return s
end
local function fadeSound(s, volume, t)
	if s and s.Parent then TweenService:Create(s, TweenInfo.new(t or 1), {Volume = volume}):Play() end
end

---------------------------------------------------------------- la cutscene
local playing = false
local function run()
	if playing then return end
	local setTemplate, rigs = folder:WaitForChild("Set", 10), folder:WaitForChild("Rigs", 10)
	if not setTemplate or not rigs then return end
	playing = true

	-- état du joueur à remettre à la fin
	local camera = workspace.CurrentCamera
	local oldFov = camera.FieldOfView
	local hidden = {}
	for _, g in playerGui:GetChildren() do
		if g:IsA("ScreenGui") and g.Enabled and g ~= gui then g.Enabled = false table.insert(hidden, g) end
	end
	local coreState = {}
	for _, t in Enum.CoreGuiType:GetEnumItems() do
		if t ~= Enum.CoreGuiType.All then
			local ok, on = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, t)
			if ok then coreState[t] = on end
		end
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)
	local controls
	pcall(function()
		local module = player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("PlayerModule")
		if module then controls = require(module):GetControls() end
	end)
	if controls then controls:Disable() end
	local frozen = {}
	local myHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not controls and myHum then
		frozen = {Hum = myHum, Speed = myHum.WalkSpeed, Jump = myHum.JumpPower, JumpH = myHum.JumpHeight}
		myHum.WalkSpeed, myHum.JumpPower, myHum.JumpHeight = 0, 0, 0
	end
	local lightProps = {"ClockTime", "Brightness", "Ambient", "OutdoorAmbient", "ExposureCompensation"}
	local oldLight = {}
	for _, p in lightProps do oldLight[p] = Lighting[p] end
	local disabledFx = {}
	for _, e in Lighting:GetChildren() do
		if (e:IsA("DepthOfFieldEffect") or e:IsA("ColorCorrectionEffect")) and e.Enabled then e.Enabled = false table.insert(disabledFx, e) end
	end
	local music = SoundService:FindFirstChild("Days")
	local musicVolume = music and music.Volume
	if music then fadeSound(music, 0, 1.5) end

	-- effets de caméra (locaux)
	local cc = new("ColorCorrectionEffect", {Name = "CutsceneCC", TintColor = rgb(215, 215, 255), Contrast = 0.12, Saturation = 0.08, Brightness = 0.02}, Lighting)
	local dof = new("DepthOfFieldEffect", {Name = "CutsceneDOF", FarIntensity = 0.35, NearIntensity = 0.4, InFocusRadius = 7, FocusDistance = 12}, Lighting)
	local bloom = new("BloomEffect", {Name = "CutsceneBloom", Intensity = 0.6, Size = 30, Threshold = 1.6}, Lighting)
	local rays = new("SunRaysEffect", {Name = "CutsceneRays", Intensity = 0, Spread = 0.6}, Lighting)

	gui.Enabled = true
	fade.BackgroundTransparency = 0
	caption.Text = ""

	local set = setTemplate:Clone()
	set.Name = "CutsceneSet"
	set.Parent = workspace
	local O = set:WaitForChild("Origin").CFrame
	local function L(x, y, z) return (O * CFrame.new(x, y, z)).Position end
	local function mark(name) return set:FindFirstChild(name, true) end

	pcall(function() ContentProvider:PreloadAsync(rigs:GetChildren()) end)
	local function spawnActor(name, color)
		local template = rigs:FindFirstChild(name)
		if not template then return nil end
		local rig = template:Clone()
		rig.Parent = set
		return makeActor(rig, color, name)
	end
	local K = spawnActor("kinoshi112", KCOL)
	local R = spawnActor("rexydev1", RCOL)
	local N = spawnActor("Nono275er", NCOL)
	local actors = {}
	for _, a in {K, R, N} do table.insert(actors, a) end

	-- assis sur sa chaise (qui peut pivoter)
	local function seat(a, tag)
		local m, chair = mark("Seat" .. tag), set:FindFirstChild("Swivel" .. tag)
		if not a or not m then return end
		a.Rig:PivotTo(CFrame.new(m.Position + Vector3.new(0, a.SitOffset - 0.4, 0)) * m.CFrame.Rotation * CFrame.new(0, 0, -1.0))
		if chair then a.Chair, a.Rel = chair, chair:GetPivot():ToObjectSpace(a.Root.CFrame) end
		-- les touches de SON clavier, côté main gauche / main droite
		local kb = mark("Keyboard" .. tag .. "Top")
		a.Keys = {L = {}, R = {}}
		if kb then
			for _, d in set:GetDescendants() do
				if d:IsA("BasePart") and d.Name == "Key" and (d.Position - kb.Position).Magnitude < 2.6 then
					local rel = a.Root.CFrame:PointToObjectSpace(d.Position)
					table.insert(rel.X > 0 and a.Keys.R or a.Keys.L, {Part = d, CF = d.CFrame, Color = d.Color})
				end
			end
		end
		setPose(a, "Type")
		snapPose(a)
	end
	seat(K, "K")
	seat(R, "R")
	if K then K.Typing = true end
	if R then R.Typing = true end
	local nonoStart = mark("NonoStart")
	if N and nonoStart then
		N.Rig:PivotTo(CFrame.new(nonoStart.Position + Vector3.new(0, N.StandOffset - 0.25, 0)) * O.Rotation * CFrame.Angles(0, rad(90), 0))
		setPose(N, "Carry")
		snapPose(N)
		if N.Tracks.Idle then N.Tracks.Idle:Play(0) end
	end

	-- faire pivoter une chaise (avec l'avatar dessus) pour regarder un point
	local function swivelTo(a, point, duration)
		if not a or not a.Chair then return end
		local chair = a.Chair
		local p0 = chair:GetPivot()
		local pos = a.Root.Position
		local cur = CFrame.lookAt(pos, pos + a.Root.CFrame.LookVector * Vector3.new(1, 0, 1))
		local want = CFrame.lookAt(pos, Vector3.new(point.X, pos.Y, point.Z))
		local _, dy = cur:ToObjectSpace(want):ToEulerAnglesYXZ()
		a.Pushing = true
		local s = os.clock()
		while os.clock() - s < duration do
			chair:PivotTo(p0 * CFrame.Angles(0, dy * easeOutBack((os.clock() - s) / duration), 0))
			RunService.RenderStepped:Wait()
		end
		chair:PivotTo(p0 * CFrame.Angles(0, dy, 0))
		a.Pushing = false
	end

	-- tasses : Nono tient le mug (main gauche) et le gobelet (main droite)
	local mug, cup = makeMug(), makeTakeaway()
	mug.Parent, cup.Parent = set, set
	local cups = {
		{Model = mug, Holder = N, Hand = "LeftHand", Tilt = 0, TiltGoal = 0, Blend = 1},
		{Model = cup, Holder = N, Hand = "RightHand", Tilt = 0, TiltGoal = 0, Blend = 1},
	}
	local function cupCF(c)
		local a = c.Holder
		local hand = a and a.Rig:FindFirstChild(c.Hand)
		if not hand then return c.Model:GetPivot() end
		local side = c.Hand == "LeftHand" and 0.12 or -0.12
		return CFrame.new(hand.Position) * a.Root.CFrame.Rotation * CFrame.new(side, -0.05, -0.22) * CFrame.Angles(rad(-c.Tilt), 0, 0) * CFrame.new(0, -0.45, 0)
	end
	-- la tasse glisse de la main et tombe sur le clavier (couchée, l'ouverture vers l'écran)
	local function dropCup(c, topName)
		local top = mark(topName)
		if not c.Holder or not top then return end
		c.Holder.Holding = false
		c.Holder = nil
		c.Tilt, c.TiltGoal = 120, 120
		local start = c.Model:GetPivot()
		local land = CFrame.new(top.Position + O:VectorToWorldSpace(Vector3.new(0.8, 0.15, (math.random() - 0.5) * 0.8))) * O.Rotation * CFrame.Angles(0, rad(math.random(-25, 25)), rad(90))
		task.spawn(function()
			local s0 = os.clock()
			while os.clock() - s0 < 0.42 do
				local u = (os.clock() - s0) / 0.42
				c.Model:PivotTo(start:Lerp(land, u * u) + Vector3.new(0, sin(u * math.pi) * 0.5, 0))
				RunService.RenderStepped:Wait()
			end
			c.Model:PivotTo(land + Vector3.new(0, 0.12, 0))
			task.wait(0.06)
			c.Model:PivotTo(land)
		end)
	end
	local function give(c, a, hand)
		c.From = c.Model:GetPivot()
		c.Holder, c.Hand, c.Blend = a, hand, 0
	end

	-- caméra : plans écrits, suivi, tremblement « caméra à l'épaule », secousses, mise au point
	camera.CameraType = Enum.CameraType.Scriptable
	local camFn, focusFn
	local trauma = 0
	local fovGoal = 70
	local function shot(fromPos, fromLook, toPos, toLook, duration, fov)
		local s = os.clock()
		camFn = function()
			local u = smooth((os.clock() - s) / duration)
			return CFrame.lookAt(fromPos:Lerp(toPos, u), fromLook:Lerp(toLook, u))
		end
		focusFn = function() local u = smooth((os.clock() - s) / duration) return fromLook:Lerp(toLook, u) end
		fovGoal = fov or 70
	end
	local smoothCam
	local function follow(getPos, getLook, fov)
		smoothCam = nil
		camFn = function(dt)
			local target = CFrame.lookAt(getPos(), getLook())
			smoothCam = smoothCam and smoothCam:Lerp(target, math.min(1, dt * 5)) or target
			return smoothCam
		end
		focusFn = getLook
		fovGoal = fov or 70
	end
	local function shake(amount) trauma = math.min(1, trauma + amount) end
	local function cut() -- coupure franche entre deux plans
		fade.BackgroundTransparency = 0.1
		TweenService:Create(fade, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
	end

	-- décor animé : RGB, code qui s'écrit, lumières, écrans
	local rgbParts = {}
	for _, d in set:GetDescendants() do
		if CollectionService:HasTag(d, "CutsceneRGB") then table.insert(rgbParts, {Part = d, Phase = math.random() * 6}) end
	end
	local alarm = false
	local codeLines = {}
	for _, d in set:GetDescendants() do
		if d:IsA("TextLabel") and string.match(d.Name, "^Line%d+$") then
			d.MaxVisibleGraphemes = 0
			table.insert(codeLines, {Label = d, Index = tonumber(string.match(d.Name, "%d+")), Screen = d:FindFirstAncestorWhichIsA("BasePart").Name})
		end
	end
	for _, line in codeLines do
		line.Before = 0
		for _, other in codeLines do
			if other.Screen == line.Screen and other.Index < line.Index then line.Before += #other.Label.ContentText + 4 end
		end
	end
	local roomLights = {}
	for _, d in set:GetDescendants() do if d:IsA("PointLight") and d.Name == "RoomLight" then table.insert(roomLights, d) end end
	local screens = {}
	for _, d in set:GetDescendants() do if d:IsA("SurfaceGui") and d.Name == "Screen" then table.insert(screens, d) end end
	for _, s in screens do -- calque « parasites » pour le grésillement
		local glitch = new("Frame", {Name = "Glitch", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 9}, s)
		for _ = 1, 7 do
			new("Frame", {Position = UDim2.fromScale(0, math.random()), Size = UDim2.fromScale(1, 0.04 + math.random() * 0.1), BorderSizePixel = 0,
				BackgroundColor3 = ({rgb(255, 0, 80), rgb(0, 255, 200), rgb(255, 255, 255), rgb(80, 80, 255)})[math.random(1, 4)], BackgroundTransparency = 0.2, ZIndex = 9}, glitch)
		end
	end
	local typingStopped = false

	local t0 = os.clock()
	local conn = RunService.RenderStepped:Connect(function(dt)
		local t = os.clock() - t0
		for _, a in actors do updateActor(a, dt, t) end
		for _, c in cups do
			c.Tilt += (c.TiltGoal - c.Tilt) * math.min(1, dt * 6)
			if c.Holder then
				local goal = cupCF(c)
				if c.Blend < 1 then
					c.Blend = math.min(1, c.Blend + dt * 2)
					c.Model:PivotTo(c.From:Lerp(goal, smooth(c.Blend)))
				else
					c.Model:PivotTo(goal)
				end
			end
		end
		for _, r in rgbParts do
			r.Part.Color = alarm and (sin(t * 12) > 0 and rgb(255, 30, 30) or rgb(70, 0, 0)) or Color3.fromHSV((t * 0.1 + r.Phase) % 1, 0.85, 1)
		end
		if alarm then for _, l in roomLights do l.Color = sin(t * 12) > 0 and rgb(255, 30, 30) or rgb(120, 0, 0) end end
		if not typingStopped then
			local typed = t * 30
			for _, line in codeLines do line.Label.MaxVisibleGraphemes = math.max(0, math.floor(typed - line.Before)) end
		end
		-- caméra
		if camFn then
			local cf = camFn(dt)
			local hand = CFrame.Angles(rad(math.noise(t * 0.35, 1.3) * 0.9), rad(math.noise(t * 0.3, 7.1) * 0.9), rad(math.noise(t * 0.25, 4.2) * 0.5))
			local shk = trauma * trauma
			local jolt = CFrame.Angles(rad(math.noise(t * 18, 2) * 4 * shk), rad(math.noise(t * 18, 9) * 4 * shk), rad(math.noise(t * 18, 5) * 3 * shk))
			camera.CFrame = cf * hand * jolt
			trauma = math.max(0, trauma - dt * 1.2)
			camera.FieldOfView += (fovGoal - camera.FieldOfView) * math.min(1, dt * 3)
			if focusFn then dof.FocusDistance = clamp((focusFn() - camera.CFrame.Position).Magnitude, 2, 300) end
		end
	end)

	local function waitT(T) while os.clock() - t0 < T do RunService.RenderStepped:Wait() end end

	local typingK, typingR, fireSound, alarmSound
	local ok, err = pcall(function()
		-------------------------------------------------- 0 s : carton titre
		Lighting.ClockTime = 0.2
		Lighting.Brightness = 2
		Lighting.Ambient = rgb(125, 115, 160)
		Lighting.OutdoorAmbient = rgb(110, 100, 150)
		Lighting.ExposureCompensation = 0.1
		showText(cardBig, "DEV STUDIO", true, true)
		sfx("Typing", nil, {Volume = 0.6})
		task.wait(0.6)
		showText(cardSub, "3:00 AM  ·  THE NIGHT BEFORE THE UPDATE", true)
		waitT(2.6)
		showText(cardBig, nil, false)
		showText(cardSub, nil, false)

		-------------------------------------------------- 2.8 s : la pièce
		waitT(2.8)
		letterbox(true)
		shot(L(15, 10.5, 13), L(-16, 5, -1), L(5, 8.5, 11), L(-16, 5, -1), 6.5)
		fadeTo(1, 1.2)
		typingK = sfx("Typing", mark("KeyboardKTop"), {Looped = true, Volume = 0.5})
		typingR = sfx("Typing", mark("KeyboardRTop"), {Looped = true, Volume = 0.45, PlaybackSpeed = 1.08})
		say("kinoshi112 and rexydev1 are finishing the next update...")

		-------------------------------------------------- 5.3 s : gros plan sur les mains qui tapent
		waitT(5.3)
		cut()
		shot(L(-12.9, 7.5, -5.2), L(-17.3, 4.4, -6.9), L(-13.5, 7.1, -5.5), L(-17.3, 4.4, -6.7), 2.4, 48)

		-------------------------------------------------- 7.5 s : gros plans sur les écrans
		waitT(7.5)
		cut()
		shot(L(-11.8, 7.6, -10.5), L(-20.3, 6.9, -6.5), L(-13, 7.4, -9.4), L(-20.3, 6.9, -6.5), 4, 55)
		say("Dragons... done. Eggs... done. One more line...", KCOL, "kinoshi112")
		waitT(11.2)
		cut()
		shot(L(-12.8, 7.6, 10.2), L(-20.3, 6.9, 6.5), L(-13.8, 7.4, 9.0), L(-20.3, 6.9, 6.5), 3.6, 55)
		say("The Halloween zone looks SO good.", RCOL, "rexydev1")
		waitT(12.4)
		if R then R.Typing = false setPose(R, "Stretch", 4) end
		waitT(13.8)
		if R then setPose(R, "Type", 4) R.Typing = true end

		-------------------------------------------------- 15 s : on frappe à la porte
		waitT(15)
		cut()
		local door = set:FindFirstChild("DoorPanel")
		local hingeCF = door and door:GetPivot()
		shot(L(-9, 7.4, -1), L(22, 5, 0), L(-8, 7.4, -1), L(22, 5, 0), 3, 60)
		sfx("Knock", mark("Door"), {Volume = 1})
		say("*knock knock*")
		for _, a in {K, R} do if a then a.Typing = false a.Look = mark("Door") setPose(a, "SitRest", 4) end end -- ils arrêtent d'écrire
		fadeSound(typingK, 0, 0.4) fadeSound(typingR, 0, 0.4)
		waitT(16.2)
		task.spawn(function()
			if not door then return end
			local s = os.clock()
			while os.clock() - s < 1.2 do
				door:PivotTo(hingeCF * CFrame.Angles(0, rad(100 * easeOutBack((os.clock() - s) / 1.2)), 0))
				RunService.RenderStepped:Wait()
			end
		end)
		waitT(17)
		-- Nono entre avec ses deux cafés
		if N then
			follow(function() return N.Root.Position + O:VectorToWorldSpace(Vector3.new(-6.5, 2.4, -6)) end, function() return N.Root.Position + Vector3.new(0, 1.2, 0) end, 60)
			say("COFFEE DELIVERY for the best devs in the world!", NCOL, "Nono275er")
			for _, a in {K, R} do if a then a.Look = N.Head end end
			walk(N, {Vector3.new(14, 0, 0), Vector3.new(-6, 0, -1.2), Vector3.new(-10.2, 0, -2.4)}, 9, false, O)
		end

		-------------------------------------------------- kinoshi fait pivoter sa chaise et prend le mug
		cut()
		shot(L(-5.5, 6.6, -12), L(-12, 4.4, -4.5), L(-6.3, 6.4, -11.2), L(-12, 4.4, -4.5), 7.5, 52)
		if N and K then task.spawn(turnTo, N, K.Root.Position, 0.5) end
		swivelTo(K, N and N.Root.Position or L(-10, 0, -2), 1.1)
		say("NO WAY! Thanks bro!", KCOL, "kinoshi112")
		-- Nono tend le mug, kinoshi tend le bras pour l'attraper
		setPose(N, "GiveLeftOut", 4)
		if N and K then N.Look = K.Head N.Aim = {Side = "Left", Target = K.Rig:FindFirstChild("UpperTorso") or K.Head} end
		task.wait(0.45)
		setPose(K, "SitReachFar", 3.5)
		if K then K.Look = cups[1].Model.PrimaryPart K.Aim = {Side = "Right", Target = cups[1].Model.PrimaryPart} end
		task.wait(0.85)
		setPose(K, "SitGrab", 8)
		if K then give(cups[1], K, "RightHand") end
		task.wait(0.25)
		if K then K.Aim = nil end
		if N then N.Aim = nil end
		task.wait(0.1)
		-- il ramène le mug vers lui, le sent, puis remercie Nono
		setPose(N, "Carry", 4)
		setPose(K, "SitSniff", 3)
		if K then K.Holding = true end
		task.wait(0.8)
		setPose(K, "SitThanks", 4)
		if K and N then K.Look = N.Head end
		task.wait(0.5)
		setPose(K, "SitHold", 4)
		if K then K.Look = nil end
		task.spawn(swivelTo, K, L(-25, 0, -6.5), 1)
		-- puis rexy et le gobelet
		if N then task.spawn(walk, N, {Vector3.new(-10.2, 0, 2.4)}, 6, false, O) end
		task.wait(0.4)
		cut()
		shot(L(-5.5, 6.6, 12), L(-12, 4.4, 4.5), L(-6.3, 6.4, 11.2), L(-12, 4.4, 4.5), 7, 52)
		task.wait(0.6)
		if N and R then turnTo(N, R.Root.Position, 0.4) end
		swivelTo(R, N and N.Root.Position or L(-10, 0, 2), 1.1)
		say("You're literally the best!!", RCOL, "rexydev1")
		-- Nono tend le gobelet, rexy tend le bras pour le prendre
		setPose(N, "GiveRightOut", 4)
		if N and R then N.Look = R.Head N.Aim = {Side = "Right", Target = R.Rig:FindFirstChild("UpperTorso") or R.Head} end
		task.wait(0.45)
		setPose(R, "SitReachFar", 3.5)
		if R then R.Look = cups[2].Model.PrimaryPart R.Aim = {Side = "Right", Target = cups[2].Model.PrimaryPart} end
		task.wait(0.85)
		setPose(R, "SitGrab", 8)
		if R then give(cups[2], R, "RightHand") end
		task.wait(0.25)
		if R then R.Aim = nil end
		if N then N.Aim = nil end
		task.wait(0.1)
		setPose(N, "Proud", 4)
		setPose(R, "SitSniff", 3)
		if R then R.Holding = true end
		task.wait(0.8)
		setPose(R, "SitThanks", 4)
		if R and N then R.Look = N.Head end
		task.wait(0.5)
		setPose(R, "SitBlow", 3) -- souffle sur son café chaud
		if R then R.Look = nil end
		task.spawn(swivelTo, R, L(-25, 0, 6.5), 1)
		if N then task.spawn(walk, N, {Vector3.new(-6, 0, 0)}, 5, false, O) end
		task.wait(1.1)
		if N then turnTo(N, L(-14, 0, 0), 0.4) setPose(N, "Proud", 4) N.Look = nil end

		-------------------------------------------------- tchin !
		local T1 = os.clock() - t0
		cut()
		shot(L(-8.5, 5.2, 0), L(-15, 5.6, 0), L(-9.5, 5.4, 0), L(-15, 5.8, 0), 3, 62)
		for _, a in {K, R} do if a then a.Look = nil end end
		setPose(K, "Toast", 5) setPose(R, "Toast", 5)
		say("To the update!  *cheers*", NCOL, "Nono275er")
		waitT(T1 + 1.5)

		-------------------------------------------------- l'éternuement... et le café sur les claviers
		-- ils portent la tasse à la bouche pour boire...
		cut()
		shot(L(-13.2, 7.2, -13.2), L(-17, 4.6, -5.5), L(-14.2, 6.9, -12.3), L(-17, 4.5, -4.8), 6, 50)
		setPose(K, "Drink", 3) setPose(R, "Drink", 3)
		for _, c in cups do c.TiltGoal = -28 end
		say("*sip*...", KCOL, "kinoshi112")
		-- ...mais c'est brûlant : kinoshi lâche son mug, rexy sursaute et lâche son gobelet
		waitT(T1 + 3.0)
		say("AAAH!!! HOT HOT HOT!!!", KCOL, "kinoshi112")
		setPose(K, "Burn", 16)
		if K then K.Shake = 0.6 end
		shake(0.5)
		dropCup(cups[1], "KeyboardKTop")
		waitT(T1 + 3.35)
		setPose(R, "Startle", 16)
		if R and K then R.Look = K.Head end
		dropCup(cups[2], "KeyboardRTop")
		waitT(T1 + 3.6)
		fovGoal = 44
		-- coulée de café : filet, éclaboussures, flaques qui s'étalent, gouttes qui tombent du bureau
		sfx("Splash", mark("KeyboardKTop"), {Volume = 1})
		task.delay(0.25, function() sfx("Splash", mark("KeyboardRTop"), {Volume = 0.9, PlaybackSpeed = 1.1}) end)
		local COFFEE = rgb(78, 42, 18)
		for _, pair in {{cups[1], "KeyboardKTop"}, {cups[2], "KeyboardRTop"}} do
			local c, top = pair[1], mark(pair[2])
			if top then
				task.spawn(function()
					local stream = new("Part", {Name = "Stream", Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, Shape = Enum.PartType.Cylinder, Material = Enum.Material.Glass,
						Color = COFFEE, Transparency = 0.15, Size = Vector3.new(1, 0.16, 0.16)}, set)
					local splash = new("ParticleEmitter", {Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(rgb(95, 55, 25)), Rate = 45,
						Lifetime = NumberRange.new(0.3, 0.6), Speed = NumberRange.new(3, 7), SpreadAngle = Vector2.new(60, 60), Acceleration = Vector3.new(0, -35, 0),
						Size = NumberSequence.new(0.18, 0.05), EmissionDirection = Enum.NormalId.Top}, top)
					local puddles = {}
					for k = 1, 4 do
						table.insert(puddles, {Part = new("Part", {Name = "Puddle", Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, Shape = Enum.PartType.Cylinder,
							Material = Enum.Material.Glass, Color = COFFEE, Transparency = 0.08, Reflectance = 0.15, Size = Vector3.new(0.05, 0.1, 0.1),
							CFrame = top.CFrame * CFrame.new(math.random() * 0.6 - 0.3, -0.12, (k - 2.5) * 0.9) * UPRIGHT}, set), Max = 1.2 + math.random() * 1.1})
					end
					local s = os.clock()
					while os.clock() - s < 2.6 do
						local dt = RunService.RenderStepped:Wait()
						local mouth = c.Model:FindFirstChild("Mouth") or c.Model.PrimaryPart
						local from = mouth.Position
						local to = top.Position + Vector3.new(sin(os.clock() * 7) * 0.25, 0, cos(os.clock() * 5) * 0.6)
						local flow = clamp((c.Tilt - 60) / 40, 0, 1) * (1 - clamp((os.clock() - s - 2) / 0.6, 0, 1))
						stream.Size = Vector3.new((to - from).Magnitude, 0.05 + 0.13 * flow, 0.05 + 0.13 * flow)
						stream.Transparency = flow > 0.05 and 0.15 or 1
						stream.CFrame = CFrame.lookAt((from + to) / 2, to) * CFrame.Angles(0, math.pi / 2, 0)
						splash.Rate = 45 * flow
						for _, p in puddles do
							local d = math.min(p.Max, p.Part.Size.Y + dt * 1.1 * flow)
							p.Part.Size = Vector3.new(0.05, d, d)
						end
					end
					stream:Destroy()
					splash.Rate = 0
					-- gouttes qui tombent du bord du bureau jusqu'au sol
					local edge = top.Position + O:VectorToWorldSpace(Vector3.new(1.4, -0.4, 0))
					local floorY = O.Position.Y + 0.05
					local floorPuddle = new("Part", {Name = "Puddle", Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, Shape = Enum.PartType.Cylinder,
						Material = Enum.Material.Glass, Color = COFFEE, Transparency = 0.1, Reflectance = 0.15, Size = Vector3.new(0.04, 0.2, 0.2),
						CFrame = CFrame.new(edge.X, floorY, edge.Z) * UPRIGHT}, set)
					for d = 1, 10 do
						local drop = new("Part", {Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, Shape = Enum.PartType.Ball, Material = Enum.Material.Glass, Color = COFFEE,
							Size = Vector3.new(0.14, 0.14, 0.14), CFrame = CFrame.new(edge + Vector3.new(0, 0, (math.random() - 0.5) * 2))}, set)
						TweenService:Create(drop, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = Vector3.new(drop.Position.X, floorY, drop.Position.Z)}):Play()
						Debris:AddItem(drop, 0.5)
						floorPuddle.Size = Vector3.new(0.04, 0.2 + d * 0.16, 0.2 + d * 0.16)
						task.wait(0.22)
					end
				end)
			end
		end
		say("NOOOOO MY KEYBOARD!!!", RCOL, "rexydev1")
		waitT(T1 + 4.5)
		-- ils essuient le clavier en panique avec les mains
		for _, a in {K, R} do if a then a.Shake = 0 a.Look = nil setPose(a, "Wipe", 7) a.Wiping = true end end
		waitT(T1 + 7.3)
		for _, a in {K, R} do if a then a.Wiping = false a.Shake = 0.7 end end
		setPose(K, "Shock", 8) setPose(R, "Shock", 8)

		-------------------------------------------------- étincelles, écrans qui grésillent puis s'éteignent
		waitT(T1 + 7.6)
		cut()
		shot(L(-14.6, 6.4, 0), L(-17.2, 4.4, -6.5), L(-14.6, 6.4, 0), L(-17.2, 4.4, 6.5), 3.2, 58)
		typingStopped = true
		for _, name in {"KeyboardKTop", "KeyboardRTop"} do
			local top = mark(name)
			if top then
				local e = new("ParticleEmitter", {Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(rgb(255, 240, 140), rgb(255, 140, 30)), LightEmission = 1,
					Rate = 0, Lifetime = NumberRange.new(0.2, 0.55), Speed = NumberRange.new(7, 16), SpreadAngle = Vector2.new(75, 75), Size = NumberSequence.new(0.35, 0), Drag = 2,
					Acceleration = Vector3.new(0, -32, 0), EmissionDirection = Enum.NormalId.Top}, top)
				local light = new("PointLight", {Color = rgb(190, 220, 255), Range = 12, Brightness = 0}, top)
				task.spawn(function()
					for i = 1, 6 do
						e:Emit(25)
						light.Brightness = 5
						sfx(i % 2 == 0 and "Spark2" or "Spark", top, {Volume = 0.9, PlaybackSpeed = 0.9 + math.random() * 0.3})
						task.wait(0.06)
						light.Brightness = 0
						task.wait(0.15 + math.random() * 0.35)
					end
				end)
			end
		end
		shake(0.6)
		flashWhite(0.25)
		say("*BZZZT*  *BZZT*  *BZZZZZT*")
		for _ = 1, 14 do
			for _, s in screens do
				s.Glitch.Visible = math.random() < 0.6
				s.Off.Visible = math.random() < 0.35
				for _, bar in s.Glitch:GetChildren() do bar.Position = UDim2.fromScale(0, math.random()) end
			end
			task.wait(0.07)
		end
		for _, s in screens do s.Glitch.Visible = false s.Off.Visible = true end
		waitT(T1 + 11)
		cut()
		shot(L(3, 11.5, 0), L(-19, 6, 0), L(0, 10.5, 0), L(-19, 6.4, 0), 6, 72)
		say("...the PCs just shut down.")
		for _, a in {K, R} do if a then a.Shake = 0 a.Look = nil end end
		setPose(K, "SitHold", 3) setPose(R, "SitHold", 3)
		for _, name in {"TowerKTop", "TowerRTop"} do
			local top = mark(name)
			if top then
				new("ParticleEmitter", {Name = "Smoke", Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(rgb(90, 90, 95), rgb(25, 25, 30)), Rate = 22,
					Lifetime = NumberRange.new(2.5, 4), Speed = NumberRange.new(2, 4), Size = NumberSequence.new(1, 6), Transparency = NumberSequence.new(0.25, 1), SpreadAngle = Vector2.new(20, 20),
					EmissionDirection = Enum.NormalId.Top, RotSpeed = NumberRange.new(-40, 40), Acceleration = Vector3.new(0, 1.5, 0)}, top)
			end
		end

		-------------------------------------------------- le feu !
		waitT(T1 + 13.2)
		alarm = true
		shake(0.8)
		flashWhite(0.3)
		TweenService:Create(cc, TweenInfo.new(1), {TintColor = rgb(255, 200, 190), Contrast = 0.22, Saturation = 0.2}):Play()
		alarmSound = sfx("Alarm", nil, {Looped = true, Volume = 0.35})
		say("THE PC IS ON FIRE!!!", NCOL, "Nono275er")
		for _, name in {"TowerKTop", "TowerRTop"} do
			local top = mark(name)
			if top then
				fireSound = sfx("Fire", top, {Looped = true, Volume = 0.9})
				local fire = new("Fire", {Size = 3, Heat = 16, Color = rgb(255, 140, 30), SecondaryColor = rgb(255, 40, 0)}, top)
				TweenService:Create(fire, TweenInfo.new(2.5), {Size = 15}):Play()
				new("ParticleEmitter", {Texture = "rbxassetid://9968039364", FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot, LightEmission = 1,
					Rate = 28, Lifetime = NumberRange.new(0.7, 1.2), Speed = NumberRange.new(3, 6), Size = NumberSequence.new(2.5, 6.5), Transparency = NumberSequence.new(0.15, 1),
					EmissionDirection = Enum.NormalId.Top, SpreadAngle = Vector2.new(15, 15), Rotation = NumberRange.new(0, 360)}, top)
				new("ParticleEmitter", {Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(rgb(255, 200, 80), rgb(255, 80, 20)), LightEmission = 1,
					Rate = 20, Lifetime = NumberRange.new(1, 2), Speed = NumberRange.new(4, 9), Size = NumberSequence.new(0.25, 0), SpreadAngle = Vector2.new(30, 30),
					Acceleration = Vector3.new(0, 3, 0), EmissionDirection = Enum.NormalId.Top}, top)
				local fl = new("PointLight", {Color = rgb(255, 120, 30), Range = 22, Brightness = 2.5, Shadows = true}, top)
				task.spawn(function() while fl.Parent do fl.Brightness = 2 + math.random() * 2 task.wait(0.05) end end)
			end
		end
		-- ils bondissent de leur chaise, les tasses tombent sur le bureau
		for _, a in {K, R} do
			if a then
				a.Chair = nil
				a.Rig:PivotTo(a.Root.CFrame + Vector3.new(0, a.StandOffset - a.SitOffset + 0.5, 0) - a.Root.CFrame.LookVector * 2.4)
				setPose(a, "Panic", 10)
				a.Shake = 1
			end
		end
		setPose(N, "Facepalm", 6)
		for _, c in cups do
			if not c.Holder then continue end -- déjà tombée sur le bureau
			local from = c.Model:GetPivot()
			c.Holder = nil
			local to = CFrame.new(from.Position.X, (O * CFrame.new(0, 3.86, 0)).Position.Y, from.Position.Z) * CFrame.Angles(rad(90), 0, rad(math.random(0, 360)))
			task.spawn(function()
				local s = os.clock()
				while os.clock() - s < 0.35 do c.Model:PivotTo(from:Lerp(to, ((os.clock() - s) / 0.35) ^ 2)) RunService.RenderStepped:Wait() end
				c.Model:PivotTo(to)
			end)
		end
		waitT(T1 + 15.5)
		cut()
		shot(L(-4, 6, -9), L(-12, 5.5, 0), L(-5, 6.4, -8), L(-12, 5.8, 0), 3, 64)
		say("WE DIDN'T EVEN SAVE THE GAME!!!", KCOL, "kinoshi112")
		setPose(N, "Panic", 8) if N then N.Shake = 1 end

		-------------------------------------------------- tout le monde court dehors
		waitT(T1 + 17.8)
		say("RUN!!! EVERYBODY OUTSIDE!!!", RCOL, "rexydev1")
		for _, a in actors do setPose(a, "Stand", 8) a.Shake = 0 a.Flail = true end
		if K then
			follow(function() return K.Root.Position + O:VectorToWorldSpace(Vector3.new(-3, 3.2, 7.5)) end, function() return K.Root.Position + O:VectorToWorldSpace(Vector3.new(4, 1, 0)) end, 74)
		end
		local runs = {
			{K, {Vector3.new(-8, 0, -4), Vector3.new(10, 0, -1.2), Vector3.new(22.5, 0, -1), Vector3.new(34, 0, -3.2)}, 0.3, -3.2},
			{R, {Vector3.new(-8, 0, 4), Vector3.new(10, 0, 1.2), Vector3.new(22.5, 0, 1), Vector3.new(34, 0, 3.2)}, 0.1, 3.2},
			{N, {Vector3.new(14, 0, 0), Vector3.new(22.5, 0, 0), Vector3.new(32.6, 0, 0)}, 0, 0},
		}
		for _, r in runs do
			if r[1] then
				task.spawn(function()
					task.wait(r[3])
					walk(r[1], r[2], 14, true, O)
					r[1].Flail = false
					turnTo(r[1], L(200, 0, r[4]), 0.5)
				end)
			end
		end

		-------------------------------------------------- sur le balcon, au lever du soleil : la map !
		waitT(T1 + 22.5)
		cut()
		fadeSound(alarmSound, 0, 2.5)
		fadeSound(fireSound, 0, 2.5)
		TweenService:Create(Lighting, TweenInfo.new(6), {ClockTime = 6.5, Brightness = 2.6, Ambient = rgb(150, 125, 120), OutdoorAmbient = rgb(160, 135, 130), ExposureCompensation = 0.2}):Play()
		TweenService:Create(cc, TweenInfo.new(4), {TintColor = rgb(255, 238, 215), Contrast = 0.1, Saturation = 0.15}):Play()
		TweenService:Create(rays, TweenInfo.new(5), {Intensity = 0.12}):Play()
		shot(L(25.5, 6.2, 0), L(40, 4.5, 0), L(24.5, 7.2, 0), L(70, -8, 0), 4, 66)
		for _, a in actors do setPose(a, "Stand", 5) end
		say("*pant*  *pant*  ...")
		waitT(T1 + 25)
		for _, a in actors do setPose(a, "Lean", 4) end
		say("Wait... guys... LOOK AT THE MAP!!!", KCOL, "kinoshi112")
		if music then music.Volume = 0 fadeSound(music, musicVolume or 0.5, 4) end
		waitT(T1 + 27)
		if K then setPose(K, "Wave", 5) K.Waving = true end
		setPose(R, "Cheer", 5) setPose(N, "Cheer", 5)
		shot(L(24.5, 7.2, 0), L(70, -8, 0), L(70, 50, 0), L(900, -120, 0), 6.5, 78)
		say("They forgot about the PCs... and showed you the game instead!")
		waitT(T1 + 29.5)
		showText(titleBig, "VOLER COMME UN DRAGON", true, true)
		task.wait(0.35)
		showText(titleSub, "POUR OBTENIR DES OEUFS", true, true)
		waitT(T1 + 33.5)
		shot(L(70, 50, 0), L(900, -120, 0), L(270, 35, 0), L(2200, -130, 0), 5, 80)
		waitT(T1 + 36.5)
		fadeTo(0, 1.2)
		showText(titleBig, nil, false)
		showText(titleSub, nil, false)
		letterbox(false)
		waitT(T1 + 38)
	end)
	if not ok then warn("[CutsceneClient] " .. tostring(err)) end

	-------------------------------------------------- retour au jeu
	conn:Disconnect()
	camFn, focusFn = nil, nil
	for _, s in activeSounds do if s.Parent then s:Destroy() end end
	table.clear(activeSounds)
	for _, a in actors do if a.Tag then a.Tag:Destroy() end end
	set:Destroy()
	for _, e in {cc, dof, bloom, rays} do e:Destroy() end
	for _, e in disabledFx do if e.Parent then e.Enabled = true end end
	for _, p in lightProps do pcall(function() Lighting[p] = oldLight[p] end) end
	camera.CameraType = Enum.CameraType.Custom
	camera.FieldOfView = oldFov
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then camera.CameraSubject = hum end
	for _, g in hidden do if g.Parent then g.Enabled = true end end
	for t, on in coreState do pcall(StarterGui.SetCoreGuiEnabled, StarterGui, t, on) end
	if controls then controls:Enable() end
	if frozen.Hum and frozen.Hum.Parent then frozen.Hum.WalkSpeed, frozen.Hum.JumpPower, frozen.Hum.JumpHeight = frozen.Speed, frozen.Jump, frozen.JumpH end
	if music and musicVolume then music.Volume = musicVolume end
	caption.Text = ""
	fadeTo(1, 1)
	task.wait(1)
	gui.Enabled = false
	playing = false
end

-- préchargement des skins et des sons dès l'arrivée dans le jeu
task.spawn(function()
	local rigs = folder:WaitForChild("Rigs", 60)
	local function preload()
		local list = {}
		for _, r in rigs and rigs:GetChildren() or {} do table.insert(list, r) end
		if soundsFolder then for _, s in soundsFolder:GetChildren() do table.insert(list, s) end end
		for _, anim in ANIM_OBJS do table.insert(list, anim) end
		pcall(function() ContentProvider:PreloadAsync(list) end)
	end
	if rigs then rigs.ChildAdded:Connect(function() task.wait(1) preload() end) end
	preload()
end)

playRemote.OnClientEvent:Connect(function(startAt, which)
	if type(startAt) ~= "number" then return end
	if which ~= nil and which ~= "dev" then return end -- l'autre cutscene (SafeCutsceneClient)
	local delay = startAt - workspace:GetServerTimeNow()
	if delay < -2 then return end -- arrivé trop tard
	task.wait(math.max(0, delay))
	if not CutsceneLock.take("Dev", 240) then return end
	pcall(run)
	CutsceneLock.release("Dev")
end)
