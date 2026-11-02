local CutsceneLock = require(game:GetService("ReplicatedStorage"):WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
-- AdminThrowClient : cinématique quand un admin fait apparaître un œuf dans une zone (EggZoneServer -> AdminThrow.Play)
-- Le skin GÉANT de l'admin arrive en VOLANT, freine, se redresse au-dessus de la zone, prend son élan et LANCE l'œuf,
-- fête l'impact puis repart en flèche dans le ciel.
--
-- MOTEUR D'ANIMATION (pour que ce soit fluide) :
--   1) images-clés par articulation, reliées par des courbes continues (splines de Hermite / Catmull-Rom) :
--      la vitesse ne retombe jamais à zéro entre deux poses (sauf sur les poses marquées "hold")
--   2) un RESSORT par articulation (amorti) qui suit la courbe : inertie, petit dépassement, retour en douceur ;
--      coudes et poignets plus souples = le bras part en fouet tout seul
--   3) mouvements ajoutés (jambes qui battent, respiration, coucou) qui s'enchaînent en fondu, sans à-coup
--   4) le corps entier suit sa trajectoire avec un lissage exponentiel
-- Le serveur pose le vrai œuf au moment de l'impact (info.Land secondes après le signal).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local folder = ReplicatedStorage:WaitForChild("AdminThrow")
local rigs = folder:WaitForChild("Rigs")
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local eggTemplates = eggSystem:WaitForChild("EggModels")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local rad = math.rad
local rgb = Color3.fromRGB
local V = Vector3.new

local GIANT = 6        -- taille du skin
local T_ARRIVE = 2.5   -- fin du vol d'arrivée
local T_RELEASE = 4.07 -- il lâche l'œuf

local function clamp01(x) return math.clamp(x, 0, 1) end
local function smooth(x) x = clamp01(x) return x * x * (3 - 2 * x) end
local function smoother(x) x = clamp01(x) return x * x * x * (x * (x * 6 - 15) + 10) end
local function outCubic(x) x = clamp01(x) return 1 - (1 - x) ^ 3 end
local function ramp(t, a, b) return smoother((t - a) / (b - a)) end

---------------------------------------------------------------- poses (degrés {x, y, z}, R15)
-- épaule/hanche +x = membre vers l'avant ; coude +x = plie ; genou -x = plie ; taille/cou +x = vers l'arrière ;
-- taille +y = le buste tourne vers sa gauche
local POSE = {}
POSE.Fly = { -- super-héros : poing droit (l'œuf) tendu devant, bras gauche le long du corps, jambes derrière
	Waist = {12, 0, 0}, Neck = {38, 0, 0},
	RightShoulder = {172, 0, 6}, RightElbow = {8, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {-14, 0, -12}, LeftElbow = {18, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {-6, 0, 4}, RightKnee = {-20, 0, 0}, RightAnkle = {-28, 0, 0},
	LeftHip = {-12, 0, -4}, LeftKnee = {-8, 0, 0}, LeftAnkle = {-28, 0, 0},
}
POSE.Brake = { -- freinage : les jambes passent devant, le buste se cambre, les bras s'ouvrent
	Waist = {18, 0, 0}, Neck = {6, 0, 0},
	RightShoulder = {95, 0, 30}, RightElbow = {45, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {40, 0, -60}, LeftElbow = {25, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {48, 0, 8}, RightKnee = {-52, 0, 0}, RightAnkle = {-8, 0, 0},
	LeftHip = {38, 0, -8}, LeftKnee = {-40, 0, 0}, LeftAnkle = {-8, 0, 0},
}
POSE.Hover = { -- redressé en l'air : l'œuf devant la poitrine, l'autre bras en balancier, jambes qui pendent
	Waist = {4, 0, 0}, Neck = {-6, 0, 0},
	RightShoulder = {72, 0, 18}, RightElbow = {72, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {22, 0, -36}, LeftElbow = {30, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {20, 0, 6}, RightKnee = {-36, 0, 0}, RightAnkle = {-18, 0, 0},
	LeftHip = {8, 0, -6}, LeftKnee = {-24, 0, 0}, LeftAnkle = {-15, 0, 0},
}
POSE.Gather = { -- il ramène l'œuf contre l'épaule et se ramasse
	Waist = {-4, -14, 0}, Neck = {-10, 10, 0},
	RightShoulder = {62, -8, 22}, RightElbow = {118, 0, 0}, RightWrist = {-10, 0, 0},
	LeftShoulder = {48, 14, -24}, LeftElbow = {40, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {34, 0, 6}, RightKnee = {-58, 0, 0}, RightAnkle = {-20, 0, 0},
	LeftHip = {22, 0, -6}, LeftKnee = {-44, 0, 0}, LeftAnkle = {-18, 0, 0},
}
POSE.Windup = { -- élan : cambré, buste tourné, bras loin derrière la tête, l'autre bras vise la zone, genou levé
	Waist = {16, -42, 0}, Neck = {-8, 32, 0},
	RightShoulder = {200, -12, 30}, RightElbow = {82, 0, 0}, RightWrist = {-32, 0, 0},
	LeftShoulder = {88, 32, -8}, LeftElbow = {8, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {38, 0, 6}, RightKnee = {-66, 0, 0}, RightAnkle = {-20, 0, 0},
	LeftHip = {-6, 0, -6}, LeftKnee = {-18, 0, 0}, LeftAnkle = {-12, 0, 0},
}
POSE.WindupPeak = { -- le point mort tout en haut de l'élan (on le sent "charger")
	Waist = {21, -50, 0}, Neck = {-10, 36, 0},
	RightShoulder = {212, -14, 34}, RightElbow = {92, 0, 0}, RightWrist = {-40, 0, 0},
	LeftShoulder = {92, 36, -6}, LeftElbow = {4, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {44, 0, 6}, RightKnee = {-72, 0, 0}, RightAnkle = {-22, 0, 0},
	LeftHip = {-8, 0, -6}, LeftKnee = {-16, 0, 0}, LeftAnkle = {-12, 0, 0},
}
POSE.Throw = { -- le lancer : le buste fouette vers l'avant, le bras déroule, la jambe droite part derrière
	Waist = {-22, 42, 0}, Neck = {-12, -26, 0},
	RightShoulder = {30, 22, -18}, RightElbow = {6, 0, 0}, RightWrist = {22, 0, 0},
	LeftShoulder = {-22, -22, -36}, LeftElbow = {46, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {-18, 0, 6}, RightKnee = {-14, 0, 0}, RightAnkle = {-10, 0, 0},
	LeftHip = {32, 0, -6}, LeftKnee = {-46, 0, 0}, LeftAnkle = {-14, 0, 0},
}
POSE.Follow = { -- au bout du geste
	Waist = {-28, 50, 0}, Neck = {-16, -30, 0},
	RightShoulder = {4, 28, -26}, RightElbow = {18, 0, 0}, RightWrist = {34, 0, 0},
	LeftShoulder = {-32, -22, -42}, LeftElbow = {54, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {-24, 0, 6}, RightKnee = {-10, 0, 0}, RightAnkle = {-8, 0, 0},
	LeftHip = {38, 0, -6}, LeftKnee = {-52, 0, 0}, LeftAnkle = {-14, 0, 0},
}
POSE.Settle = { -- il se relâche
	Waist = {-14, 26, 0}, Neck = {-16, -16, 0},
	RightShoulder = {20, 12, -6}, RightElbow = {26, 0, 0}, RightWrist = {10, 0, 0},
	LeftShoulder = {4, -8, -32}, LeftElbow = {38, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {4, 0, 6}, RightKnee = {-26, 0, 0}, RightAnkle = {-12, 0, 0},
	LeftHip = {24, 0, -6}, LeftKnee = {-38, 0, 0}, LeftAnkle = {-14, 0, 0},
}
POSE.Recover = { -- il regarde l'œuf tomber
	Waist = {-6, 10, 0}, Neck = {-16, -6, 0},
	RightShoulder = {30, 0, 12}, RightElbow = {32, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {18, 0, -28}, LeftElbow = {30, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {16, 0, 6}, RightKnee = {-34, 0, 0}, RightAnkle = {-16, 0, 0},
	LeftHip = {10, 0, -6}, LeftKnee = {-26, 0, 0}, LeftAnkle = {-14, 0, 0},
}
POSE.Cheer = { -- victoire : poing gauche levé, main droite qui fait coucou
	Waist = {8, 0, 0}, Neck = {10, 0, 0},
	RightShoulder = {158, 0, 28}, RightElbow = {30, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {168, 0, -18}, LeftElbow = {12, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {18, 0, 6}, RightKnee = {-42, 0, 0}, RightAnkle = {-18, 0, 0},
	LeftHip = {4, 0, -6}, LeftKnee = {-18, 0, 0}, LeftAnkle = {-14, 0, 0},
}
POSE.Crouch = { -- il se ramasse juste avant de décoller
	Waist = {-10, 0, 0}, Neck = {-12, 0, 0},
	RightShoulder = {30, 0, 30}, RightElbow = {60, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {30, 0, -30}, LeftElbow = {60, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {50, 0, 6}, RightKnee = {-80, 0, 0}, RightAnkle = {-20, 0, 0},
	LeftHip = {50, 0, -6}, LeftKnee = {-80, 0, 0}, LeftAnkle = {-20, 0, 0},
}
POSE.FlyUp = { -- décollage : les deux bras vers le ciel, jambes serrées et tendues
	Waist = {6, 0, 0}, Neck = {22, 0, 0},
	RightShoulder = {178, 0, 6}, RightElbow = {4, 0, 0}, RightWrist = {0, 0, 0},
	LeftShoulder = {178, 0, -6}, LeftElbow = {4, 0, 0}, LeftWrist = {0, 0, 0},
	RightHip = {-4, 0, 2}, RightKnee = {-8, 0, 0}, RightAnkle = {-32, 0, 0},
	LeftHip = {-4, 0, -2}, LeftKnee = {-8, 0, 0}, LeftAnkle = {-32, 0, 0},
}
local JOINTS = {
	Waist = {"UpperTorso", "Waist"}, Neck = {"Head", "Neck"},
	RightShoulder = {"RightUpperArm", "RightShoulder"}, RightElbow = {"RightLowerArm", "RightElbow"}, RightWrist = {"RightHand", "RightWrist"},
	LeftShoulder = {"LeftUpperArm", "LeftShoulder"}, LeftElbow = {"LeftLowerArm", "LeftElbow"}, LeftWrist = {"LeftHand", "LeftWrist"},
	RightHip = {"RightUpperLeg", "RightHip"}, RightKnee = {"RightLowerLeg", "RightKnee"}, RightAnkle = {"RightFoot", "RightAnkle"},
	LeftHip = {"LeftUpperLeg", "LeftHip"}, LeftKnee = {"LeftLowerLeg", "LeftKnee"}, LeftAnkle = {"LeftFoot", "LeftAnkle"},
}
-- ressort de chaque articulation : W = raideur (vitesse de réaction), Z = amortissement (< 1 : petit dépassement)
local SPRING = {
	Waist = {W = 17, Z = 0.85}, Neck = {W = 13, Z = 0.8},
	RightShoulder = {W = 26, Z = 0.78}, RightElbow = {W = 22, Z = 0.6}, RightWrist = {W = 18, Z = 0.5},
	LeftShoulder = {W = 18, Z = 0.75}, LeftElbow = {W = 15, Z = 0.62}, LeftWrist = {W = 13, Z = 0.55},
	RightHip = {W = 15, Z = 0.8}, RightKnee = {W = 13, Z = 0.7}, RightAnkle = {W = 11, Z = 0.6},
	LeftHip = {W = 15, Z = 0.8}, LeftKnee = {W = 13, Z = 0.7}, LeftAnkle = {W = 11, Z = 0.6},
}
-- le buste part un peu avant le bras (chaîne du lancer)
local LEAD = {Waist = 0.045, Neck = 0.03, LeftShoulder = 0.02}

---------------------------------------------------------------- courbes continues (Hermite / Catmull-Rom)
-- keys = {{temps, valeur(s), hold?}} ; hold = on s'arrête un instant sur cette pose (tangente nulle)
local function buildCurve(keys, get)
	local curve = {}
	for i, k in keys do curve[i] = {T = k[1], P = get(k[2]), Hold = k[3] == true} end
	for i, k in curve do
		local prev, nxt = curve[i - 1], curve[i + 1]
		if k.Hold or not prev or not nxt then
			k.M = table.create(#k.P, 0)
		else
			k.M = {}
			for c = 1, #k.P do
				local m = (nxt.P[c] - prev.P[c]) / (nxt.T - prev.T)
				-- pas de dépassement quand la courbe change de sens
				if (k.P[c] - prev.P[c]) * (nxt.P[c] - k.P[c]) <= 0 then m = 0 end
				k.M[c] = m
			end
		end
	end
	return curve
end
local function evalCurve(curve, t, out)
	local n = #curve
	if t <= curve[1].T then for c = 1, #curve[1].P do out[c] = curve[1].P[c] end return out end
	if t >= curve[n].T then for c = 1, #curve[n].P do out[c] = curve[n].P[c] end return out end
	local i = 1
	while curve[i + 1].T <= t do i += 1 end
	local a, b = curve[i], curve[i + 1]
	local h = b.T - a.T
	local s = (t - a.T) / h
	local s2, s3 = s * s, s * s * s
	local h00, h10, h01, h11 = 2 * s3 - 3 * s2 + 1, s3 - 2 * s2 + s, -2 * s3 + 3 * s2, s3 - s2
	for c = 1, #a.P do
		out[c] = h00 * a.P[c] + h10 * h * a.M[c] + h01 * b.P[c] + h11 * h * b.M[c]
	end
	return out
end

---------------------------------------------------------------- effets
local function fxPart(size, cf, color, material, transparency, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = material or Enum.Material.SmoothPlastic
	p.Transparency = transparency or 0
	if shape then p.Shape = shape end
	p.Parent = workspace
	return p
end
local function burst(position, props, count, life)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Rate = 0
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	for k, v in props do e[k] = v end
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, life or 3)
end
local function boom(position, axis, radius, color)
	local ring = fxPart(V(0.5, 2, 2), CFrame.lookAt(position, position + axis) * CFrame.Angles(0, rad(90), 0), color or Color3.new(1, 1, 1), Enum.Material.Neon, 0.25, Enum.PartType.Cylinder)
	TweenService:Create(ring, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = V(0.5, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(ring, 0.65)
	burst(position, {Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(Color3.new(1, 1, 1)), LightEmission = 0.2,
		Speed = NumberRange.new(14, 30), SpreadAngle = Vector2.new(180, 180), Drag = 4, Lifetime = NumberRange.new(0.5, 0.9),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 6), NumberSequenceKeypoint.new(1, 12)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})}, 16)
end
local function limbTrail(part, color)
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = V(0, part.Size.Y * 0.3, 0), V(0, -part.Size.Y * 0.3, 0)
	a0.Parent, a1.Parent = part, part
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Lifetime = 0.35
	trail.FaceCamera = true
	trail.LightEmission = 0.7
	trail.Color = ColorSequence.new(color)
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
	trail.Enabled = false
	trail.Parent = part
	return trail
end

-- bandes noires de cinéma + légende
local bars = Instance.new("ScreenGui")
bars.Name = "AdminThrowGui"
bars.ResetOnSpawn = false
bars.IgnoreGuiInset = true
bars.DisplayOrder = 40
bars.Parent = player:WaitForChild("PlayerGui")
local top = Instance.new("Frame")
top.BorderSizePixel = 0
top.BackgroundColor3 = Color3.new(0, 0, 0)
top.Size = UDim2.new(1, 0, 0.12, 0)
top.Position = UDim2.fromScale(0, -0.12)
top.Parent = bars
local bottom = top:Clone()
bottom.Position = UDim2.fromScale(0, 1)
bottom.Parent = bars
local caption = Instance.new("TextLabel")
caption.BackgroundTransparency = 1
caption.AnchorPoint = Vector2.new(0.5, 0.5)
caption.Position = UDim2.fromScale(0.5, 0.45)
caption.Size = UDim2.fromScale(0.9, 0.55)
caption.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
caption.TextScaled = true
caption.TextColor3 = Color3.new(1, 1, 1)
caption.Text = ""
caption.Parent = bottom
local captionStroke = Instance.new("UIStroke")
captionStroke.Thickness = 3
captionStroke.Parent = caption
local captionScale = Instance.new("UIScale")
captionScale.Parent = caption
local function showBars(on)
	local info = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	TweenService:Create(top, info, {Position = UDim2.fromScale(0, on and 0 or -0.12)}):Play()
	TweenService:Create(bottom, info, {Position = UDim2.fromScale(0, on and 0.88 or 1)}):Play()
end
local function say(text)
	caption.Text = text
	caption.TextTransparency, captionStroke.Transparency = 0, 0
	captionScale.Scale = 1.2
	TweenService:Create(captionScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local function bezier(a, b, c, k) return a:Lerp(b, k):Lerp(b:Lerp(c, k), k) end

---------------------------------------------------------------- la cinématique
local busy = 0
local function play(info, received)
	if type(info) ~= "table" or typeof(info.Landing) ~= "CFrame" then return end
	local LAND = math.max(tonumber(info.Land) or 5.5, 5.3)
	local LEAVE = LAND + 1.6        -- il se ramasse puis décolle
	local LIFTOFF = LEAVE + 0.32
	local FINISH = LIFTOFF + 1.6
	local landing = info.Landing.Position
	local height = tonumber(info.Height) or 6
	local center = typeof(info.ZoneCenter) == "Vector3" and info.ZoneCenter or landing
	local floorY = tonumber(info.ZoneTop) or (landing.Y - height / 2)

	-- où il s'arrête : au-dessus de la zone, un peu à l'écart de l'endroit où l'œuf tombe
	local away = V(center.X - landing.X, 0, center.Z - landing.Z)
	away = away.Magnitude > 4 and away.Unit or V(0, 0, 1)
	local side = away:Cross(Vector3.yAxis).Unit
	local hoverPos = V(center.X, floorY + 64, center.Z) + away * 30
	local faceRot = CFrame.lookAt(hoverPos, V(landing.X, hoverPos.Y, landing.Z)).Rotation
	local flyFrom = hoverPos + away * 240 + side * 100 + V(0, 125, 0)
	local flyMid = hoverPos + away * 80 + side * 18 + V(0, 62, 0)

	-- courbes de chaque articulation
	local KEYS = {
		{0, POSE.Fly}, {1.55, POSE.Fly},
		{2.15, POSE.Brake},                          -- freinage
		{2.75, POSE.Hover}, {3.15, POSE.Hover},
		{3.45, POSE.Gather},                         -- il se ramasse
		{3.82, POSE.Windup}, {3.95, POSE.WindupPeak, true}, -- point mort de l'élan
		{4.13, POSE.Throw},                          -- lancer très rapide
		{4.36, POSE.Follow},
		{4.75, POSE.Settle},
		{5.2, POSE.Recover}, {LAND + 0.12, POSE.Recover},
		{LAND + 0.6, POSE.Cheer}, {LEAVE - 0.05, POSE.Cheer},
		{LEAVE + 0.22, POSE.Crouch, true},           -- il se ramasse...
		{LIFTOFF + 0.25, POSE.FlyUp},                -- ...et s'envole
		{FINISH + 5, POSE.FlyUp},
	}
	local curves = {}
	for name in JOINTS do
		curves[name] = buildCurve(KEYS, function(pose) local a = pose[name] or {0, 0, 0} return {a[1], a[2], a[3]} end)
	end
	-- le corps avance / recule / plonge pendant le lancer (tailles de géant, repère du géant)
	local lunge = buildCurve({
		{3.15, {0, 0}}, {3.45, {-0.25, 0.3}}, {3.95, {-0.6, 0.9}, true}, {4.15, {0.3, -1.3}}, {4.4, {0.15, -1.5}},
		{5.0, {0, -0.3}}, {LAND + 0.1, {0, 0}}, {LAND + 0.6, {0.45, 0}}, {LEAVE - 0.05, {0.2, 0}}, {LEAVE + 0.22, {-0.5, 0}, true}, {LIFTOFF, {0, 0}},
	}, function(v) return v end)

	-- le skin géant
	local rig
	if info.Token then
		local template = rigs:WaitForChild(info.Token, 4)
		if template then rig = template:Clone() end
	end
	local t0 = received or os.clock() -- calé sur la réception du signal : l'œuf touche le sol en même temps que celui du serveur
	local root, hand
	local joints, springs = {}, {}
	local trails = {}
	local wind
	if rig then
		pcall(function() rig:ScaleTo(GIANT) end)
		-- avatars récents : AnimationConstraint -> Motor6D, sinon les bras et les jambes ne s'animent pas de façon fiable
		-- (même méthode que SafeCutsceneClient / HackerCutsceneClient)
		for _, d in rig:GetDescendants() do
			if d:IsA("AnimationConstraint") and d.Attachment0 and d.Attachment1 then
				local m = Instance.new("Motor6D")
				m.Name = d.Name
				m.Part0, m.Part1 = d.Attachment0.Parent, d.Attachment1.Parent
				m.C0, m.C1 = d.Attachment0.CFrame, d.Attachment1.CFrame
				local parent = d.Parent
				d:Destroy()
				m.Parent = parent
			elseif d:IsA("BallSocketConstraint") or d:IsA("HingeConstraint") then
				d:Destroy()
			end
		end
		local humanoid = rig:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.EvaluateStateMachine = false
		end
		for _, p in rig:GetDescendants() do
			if p:IsA("BasePart") then p.CanCollide, p.CanQuery, p.CanTouch, p.Anchored = false, false, false, false end
		end
		root = rig:FindFirstChild("HumanoidRootPart")
		if root then root.Anchored = true end
		hand = rig:FindFirstChild("RightHand")
		for name, path in JOINTS do
			local p = rig:FindFirstChild(path[1])
			local j = p and p:FindFirstChild(path[2])
			if j and j:IsA("Motor6D") then
				joints[name] = {Motor = j, Base = j.C0}
				local start = evalCurve(curves[name], 0, {})
				springs[name] = {P = {start[1], start[2], start[3]}, Vel = {0, 0, 0}}
			end
		end
		for _, name in {"RightFoot", "LeftFoot", "LeftHand"} do
			local p = rig:FindFirstChild(name)
			if p then table.insert(trails, limbTrail(p, rgb(220, 240, 255))) end
		end
		if root then
			wind = Instance.new("ParticleEmitter")
			wind.Texture = "rbxasset://textures/particles/sparkles_main.dds"
			wind.Color = ColorSequence.new(Color3.new(1, 1, 1))
			wind.LightEmission = 0.5
			wind.Shape = Enum.ParticleEmitterShape.Box
			wind.Rate = 0
			wind.Lifetime = NumberRange.new(0.25, 0.4)
			wind.Speed = NumberRange.new(0, 0)
			wind.Squash = NumberSequence.new(2.5)
			wind.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
			wind.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
			wind.Parent = root
		end
		rig.Parent = workspace
	end
	local flyingFx = nil
	local function setFlying(on)
		if flyingFx == on then return end
		flyingFx = on
		for _, tr in trails do tr.Enabled = on end
		if wind then wind.Rate = on and 70 or 0 end
	end

	-- l'œuf
	local eggTemplate = eggTemplates:FindFirstChild(info.EggKey or "")
	local egg, unitHeight, realScale, heldScale, eggTrail
	if eggTemplate then
		egg = eggTemplate:Clone()
		for _, p in egg:GetDescendants() do
			if p:IsA("BasePart") then p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch = true, false, false, false end
			if p:IsA("BillboardGui") or p:IsA("ProximityPrompt") then p:Destroy() end
		end
		local _, size = egg:GetBoundingBox()
		unitHeight = size.Y / egg:GetScale()
		realScale = tonumber(info.Scale) or egg:GetScale()
		heldScale = math.min(realScale, 8 / unitHeight)
		egg:ScaleTo(heldScale)
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.Position, a1.Position = V(0, 1, 0), V(0, -1, 0)
		a0.Parent, a1.Parent = egg.PrimaryPart, egg.PrimaryPart
		eggTrail = Instance.new("Trail")
		eggTrail.Attachment0, eggTrail.Attachment1 = a0, a1
		eggTrail.Lifetime = 0.5
		eggTrail.LightEmission = 0.8
		eggTrail.FaceCamera = true
		eggTrail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 4), NumberSequenceKeypoint.new(1, 0.4)})
		eggTrail.Color = ColorSequence.new(rgb(255, 245, 190), rgb(255, 170, 60))
		eggTrail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
		eggTrail.Enabled = false
		eggTrail.Parent = egg.PrimaryPart
		egg.Parent = workspace
	end

	-- caméra
	local camera = workspace.CurrentCamera
	local carrying = (player:GetAttribute("Carrying") or 0) > 0
	local useCamera = camera and camera.CameraType == Enum.CameraType.Custom and not carrying and busy == 0
	if useCamera then
		busy += 1
		camera.CameraType = Enum.CameraType.Scriptable
		showBars(true)
	end
	local eggName = Config.Eggs[info.EggKey or ""] and Config.Eggs[info.EggKey].Name or "an egg"
	local who = info.Name or "Admin"
	say(who .. " is flying in with a " .. eggName .. "!")

	local st = {arrived = false, released = false, landed = false, eggGone = false, left = false}
	local smoothBody
	local legPhase, wavePhase = 0, 0
	local handPrev, handVel = nil, Vector3.zero
	local flight -- {From, Ctrl, To}
	local camLook
	local shake = 0
	local liftPos
	local target = {}
	local conn
	conn = RunService.RenderStepped:Connect(function(dt)
		dt = math.min(dt, 1 / 20)
		local t = os.clock() - t0

		-- part de vol (1 = vole, 0 = flotte) : sert à enchaîner les petits mouvements en fondu
		local flyAmt = (1 - ramp(t, 1.7, 2.6)) + ramp(t, LIFTOFF - 0.05, LIFTOFF + 0.35)

		---------------- trajectoire du corps
		local body
		if t < T_ARRIVE then
			local k = outCubic(t / T_ARRIVE)
			local p = bezier(flyFrom, flyMid, hoverPos, k)
			local dir = bezier(flyFrom, flyMid, hoverPos, math.min(k + 0.03, 1)) - p
			if dir.Magnitude < 0.05 then dir = hoverPos - flyMid end
			local flying = CFrame.lookAt(p, p + dir.Unit) * CFrame.Angles(rad(-80), 0, 0) * CFrame.Angles(0, math.sin(t * 1.7) * 0.1, math.sin(t * 1.3) * 0.14)
			body = flying:Lerp(CFrame.new(p) * faceRot, smoother((t - 1.5) / (T_ARRIVE - 1.5)))
		elseif t < LIFTOFF then
			if not st.arrived then
				st.arrived = true
				boom(hoverPos, faceRot.LookVector, 30)
			end
			local off = evalCurve(lunge, t, {})
			local bob = math.sin(t * 1.9) * 1.2 * (1 - ramp(t, LEAVE - 0.2, LEAVE + 0.1))
			body = CFrame.new(hoverPos + V(0, bob, 0)) * faceRot * CFrame.new(0, off[1] * GIANT, off[2] * GIANT)
			body *= CFrame.Angles(math.sin(t * 1.3) * 0.025, 0, math.sin(t * 1.05) * 0.025)
		else
			local s = t - LIFTOFF
			liftPos = liftPos or (smoothBody and smoothBody.Position or hoverPos)
			local dirUp = (V(0, 2, 0) + away * 0.8 - side * 0.4).Unit
			local p = liftPos + dirUp * (20 * s + 170 * s * s)
			local launch = CFrame.lookAt(p, p + dirUp) * CFrame.Angles(rad(-80), 0, 0) * CFrame.Angles(0, (s * s) * 7, 0)
			body = (CFrame.new(p) * faceRot):Lerp(launch, smoother(s / 0.4))
			if not st.left then
				st.left = true
				boom(liftPos, dirUp, 34)
			end
		end
		setFlying(flyAmt > 0.5)
		-- lissage exponentiel du corps (aucun à-coup, même quand la trajectoire change de mode)
		smoothBody = smoothBody and smoothBody:Lerp(body, 1 - math.exp(-dt * 14)) or body
		if rig and root then rig:PivotTo(smoothBody) end

		---------------- articulations : courbe -> petits mouvements -> ressort
		legPhase += dt * (3.0 + 5.2 * flyAmt)
		local waveAmt = ramp(t, LAND + 0.55, LAND + 0.9) * (1 - ramp(t, LEAVE - 0.25, LEAVE))
		wavePhase += dt * 10
		local breathe = math.sin(t * 1.9)
		for name, j in joints do
			evalCurve(curves[name], t + (LEAD[name] or 0), target)
			local x, y, z = target[1], target[2], target[3]
			if name == "RightHip" or name == "LeftHip" then
				local sgn = name == "RightHip" and 1 or -1
				x += math.sin(legPhase) * (6 + 3 * flyAmt) * sgn
			elseif name == "RightKnee" or name == "LeftKnee" then
				local sgn = name == "RightKnee" and 0 or math.pi
				x -= (0.5 + 0.5 * math.sin(legPhase + sgn + 0.9)) * (8 + 3 * flyAmt)
			elseif name == "RightAnkle" or name == "LeftAnkle" then
				x += math.sin(legPhase + (name == "RightAnkle" and 1.6 or 1.6 + math.pi)) * 6
			elseif name == "Waist" then
				x += breathe * 2
			elseif name == "Neck" then
				x -= breathe * 1.2
			elseif name == "LeftShoulder" then
				x += math.sin(t * 4.2) * 5 * flyAmt + breathe * 1.5
			elseif name == "RightShoulder" then
				z += math.sin(wavePhase) * 12 * waveAmt
			elseif name == "RightElbow" then
				z += math.sin(wavePhase - 0.6) * 26 * waveAmt
			elseif name == "RightWrist" then
				z += math.sin(wavePhase - 1.1) * 18 * waveAmt
			end
			-- ressort amorti (sous-pas pour rester stable quel que soit le FPS)
			local sp, cfg = springs[name], SPRING[name]
			local goal = {x, y, z}
			local steps = math.max(1, math.ceil(dt / (1 / 240)))
			local h = dt / steps
			local w, zeta = cfg.W, cfg.Z
			for _ = 1, steps do
				for c = 1, 3 do
					local acc = w * w * (goal[c] - sp.P[c]) - 2 * zeta * w * sp.Vel[c]
					sp.Vel[c] += acc * h
					sp.P[c] += sp.Vel[c] * h
				end
			end
			j.Motor.C0 = j.Base * CFrame.Angles(rad(sp.P[1]), rad(sp.P[2]), rad(sp.P[3]))
		end

		---------------- l'œuf
		if hand then
			local hp = hand.Position
			if handPrev then handVel = handVel:Lerp((hp - handPrev) / math.max(dt, 1e-3), 0.5) end
			handPrev = hp
		end
		if egg and not st.eggGone then
			if t < T_RELEASE then
				local at
				if hand then
					at = (hand.CFrame * CFrame.new(0, -(hand.Size.Y * 0.5 + unitHeight * heldScale * 0.35), 0)).Position
				else
					at = smoothBody.Position + V(0, 4 * GIANT, 0)
				end
				egg:PivotTo(CFrame.new(at) * (hand and hand.CFrame.Rotation or CFrame.identity))
			elseif t < LAND then
				if not st.released then
					st.released = true
					-- trajectoire : elle part dans la direction où la main allait, puis retombe sur la zone
					local from = egg:GetPivot().Position
					local duration = LAND - T_RELEASE
					local launchDir = handVel.Magnitude > 1 and handVel.Unit or (landing - from).Unit
					local dist = (landing - from).Magnitude
					local ctrl = from + launchDir * math.clamp(dist * 0.45, 15, 70)
					ctrl = V(ctrl.X, math.max(ctrl.Y, math.max(from.Y, landing.Y) + 10), ctrl.Z)
					flight = {From = from, Ctrl = ctrl, Duration = duration}
					if eggTrail then eggTrail.Enabled = true end
					boom(from, launchDir, 14, rgb(255, 235, 170))
					say(who .. " threw the " .. eggName .. "!")
				end
				local f = clamp01((t - T_RELEASE) / flight.Duration)
				local g = f * (0.75 + 0.25 * f) -- légère accélération en retombant
				local scale = heldScale + (realScale - heldScale) * smooth(f)
				if math.abs(egg:GetScale() - scale) > 0.01 then egg:ScaleTo(scale) end
				egg:PivotTo(CFrame.new(bezier(flight.From, flight.Ctrl, landing, g)) * CFrame.Angles(f * 10, f * 4, f * 2))
			elseif not st.landed then
				st.landed = true
				if egg:GetScale() ~= realScale then egg:ScaleTo(realScale) end
				egg:PivotTo(info.Landing)
				if eggTrail then eggTrail.Enabled = false end
				local ground = V(landing.X, floorY + 0.3, landing.Z)
				local ring = fxPart(V(0.4, 2, 2), CFrame.new(ground) * CFrame.Angles(0, 0, rad(90)), rgb(255, 235, 170), Enum.Material.Neon, 0.2, Enum.PartType.Cylinder)
				TweenService:Create(ring, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = V(0.4, 44 + height * 4, 44 + height * 4), Transparency = 1}):Play()
				Debris:AddItem(ring, 0.85)
				burst(ground, {Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(rgb(200, 180, 150), rgb(140, 120, 100)), LightEmission = 0,
					Speed = NumberRange.new(15, 35), SpreadAngle = Vector2.new(80, 80), EmissionDirection = Enum.NormalId.Top, Drag = 3, Lifetime = NumberRange.new(0.8, 1.6),
					RotSpeed = NumberRange.new(-50, 50), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4 + height * 0.3), NumberSequenceKeypoint.new(1, 9 + height * 0.5)}),
					Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})}, 30, 4)
				burst(ground + V(0, 2, 0), {Color = ColorSequence.new(rgb(255, 245, 190), rgb(255, 190, 70)), LightEmission = 1, Speed = NumberRange.new(25, 50),
					SpreadAngle = Vector2.new(70, 70), EmissionDirection = Enum.NormalId.Top, Acceleration = V(0, -40, 0), Lifetime = NumberRange.new(0.6, 1.1),
					Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})}, 50)
				if camera then shake = math.clamp(1.4 - (camera.CFrame.Position - ground).Magnitude / 200, 0.25, 1.2) end
				say(eggName .. " landed in the zone!")
			elseif t > LAND + 0.25 then
				st.eggGone = true
				egg:Destroy()
			end
		end

		---------------- caméra (cible et position lissées)
		if useCamera then
			local torso = smoothBody.Position + smoothBody.UpVector * 2 * GIANT
			local base = landing - away * 48 + side * 34 + V(0, 28, 0)
			base = base:Lerp(hoverPos - away * 15 + side * 62 + V(0, 8, 0), 0.4 * (1 - ramp(t, 1.8, 3.2)))
			local want
			if t < T_RELEASE + 0.05 then
				want = torso
			elseif t < LAND and egg and egg.Parent then
				want = egg:GetPivot().Position
			elseif t < LAND + 0.6 then
				want = landing
			else
				want = torso
			end
			camLook = camLook and camLook:Lerp(want, 1 - math.exp(-dt * 6)) or want
			camera.CFrame = camera.CFrame:Lerp(CFrame.lookAt(base, camLook), 1 - math.exp(-dt * 5))
		end
		if shake > 0 and camera then
			shake = math.max(0, shake - dt * 1.6)
			local n = os.clock() * 40
			camera.CFrame *= CFrame.new(math.noise(n, 0) * shake * 2.4, math.noise(0, n) * shake * 2.4, 0)
		end
	end)

	-- fin : la caméra est rendue quand il décolle, le géant finit son envol
	task.wait(math.max(0, LIFTOFF + 0.7 - (os.clock() - t0)))
	TweenService:Create(caption, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(captionStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
	if useCamera then
		showBars(false)
		useCamera = false
		camera.CameraType = Enum.CameraType.Custom
		busy -= 1
	end
	task.wait(math.max(0, FINISH - (os.clock() - t0)))
	conn:Disconnect()
	if rig then rig:Destroy() end
	if egg and egg.Parent then egg:Destroy() end
end

folder:WaitForChild("Play").OnClientEvent:Connect(function(info)
	local received = os.clock()
	if not CutsceneLock.take("Throw", 25) then return end -- (l'œuf, lui, tombe quand même dans la zone : c'est le serveur qui le pose)
	task.spawn(function()
		local ok, err = pcall(play, info, received)
		CutsceneLock.release("Throw")
		if not ok then
			warn("[AdminThrowClient] " .. tostring(err))
			local camera = workspace.CurrentCamera
			if camera and camera.CameraType == Enum.CameraType.Scriptable and busy > 0 then camera.CameraType = Enum.CameraType.Custom end
			busy = 0
			showBars(false)
		end
	end)
end)
