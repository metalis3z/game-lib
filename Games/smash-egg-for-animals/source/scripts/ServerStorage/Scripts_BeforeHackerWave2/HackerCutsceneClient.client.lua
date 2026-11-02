-- HackerCutsceneClient : cinématique "Hacker Infiltration" (lancée par HackerCutsceneServer via ReplicatedStorage.HackerCutscene.Play)
--   1. la porte de la salle serveur s'ouvre, le hacker (capuche, lunettes vertes, sac à dos) entre en marchant jusqu'à la table
--   2. il passe la main par-dessus son épaule, sort l'ordinateur de son sac, le prend à deux mains, se penche et le pose
--   3. il ouvre l'écran, pose les mains sur le clavier et tape (terminal qui défile, barre de progression)
--   4. l'écran bug puis affiche SYSTEM HACKED !!!!! (les LED des serveurs passent au rouge)
--   5. il se redresse, se retourne et repart par la porte, qui se referme ; la salle reste vide un instant
-- L'ordinateur reste sur la table (avec le message) : c'est la preuve du piratage.
--
-- Animation : chaque articulation suit des images-clés reliées par des courbes continues + un ressort (inertie) ;
-- la marche est un cycle procédural calé sur la vitesse réelle (les pieds ne glissent pas) ; la frappe au clavier
-- est une couche procédurale qui s'ajoute en fondu. Avatars récents : AnimationConstraint -> Motor6D (comme SafeCutsceneClient).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local folder = ReplicatedStorage:WaitForChild("HackerCutscene")
local playRemote = folder:WaitForChild("Play")
local sounds = ReplicatedStorage:WaitForChild("Cutscene"):WaitForChild("Sounds")

local rad, sin, cos, clamp = math.rad, math.sin, math.cos, math.clamp
local V = Vector3.new
local rgb = Color3.fromRGB
local GREEN = rgb(40, 255, 110)

---------------------------------------------------------------- MINUTAGE (secondes depuis le début)
local T = {
	doorOpen = {1.4, 2.2},
	walkIn = {1.2, 7.6},
	reach = 8.05, grab = 8.45, pull = 8.95, front = 9.5, frontHold = 9.85,
	lean = 10.45, release = 10.65, leanHold = 10.75,
	lidOpen = {10.95, 11.55},
	typeStart = 12.1, typeEnd = 18.3,
	hacked = 18.65, lift = 18.8, straighten = 20.9,
	walkOut = {21.3, 28.3},
	doorClose = {28.6, 29.4},
	fadeOut = 31.8, finish = 32.6,
}
local STAND = V(6, 0, -1.15)          -- où il se tient devant la table (repère de la salle)
local TABLE_LAPTOP = CFrame.new(6, 3.76, 0.45) -- ordinateur posé (base) au bord de la table
local SCREEN = V(6, 4.58, 1.5)        -- centre de l'écran ouvert
local LID_OPEN = 105
local PATH_IN = {V(-25, 0, -7), V(-21, 0, -7), V(-12, 0, -7), V(-2, 0, -6.6), V(4.2, 0, -4.8), V(6, 0, -1.15)}
local PATH_OUT = {V(6, 0, -1.15), V(4.4, 0, -3.6), V(-3, 0, -6.4), V(-12, 0, -7), V(-21, 0, -7), V(-31, 0, -7)}

---------------------------------------------------------------- outils
local function new(class, props, parent)
	local i = Instance.new(class)
	for k, v in props or {} do i[k] = v end
	if parent then i.Parent = parent end
	return i
end
local function smooth(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function smoother(x) x = clamp(x, 0, 1) return x * x * x * (x * (x * 6 - 15) + 10) end
local function ramp(t, a, b) return smoother((t - a) / (b - a)) end
local function angleDiff(a, b) return (b - a + math.pi) % (2 * math.pi) - math.pi end

-- courbes continues entre images-clés (Hermite / Catmull-Rom ; "hold" = on marque un temps d'arrêt)
local function buildCurve(keys, get)
	local curve = {}
	for i, k in keys do curve[i] = {T = k[1], P = get(k[2]), Hold = k[3] == true} end
	for i, k in curve do
		local prev, nxt = curve[i - 1], curve[i + 1]
		k.M = {}
		for c = 1, #k.P do
			local m = 0
			if not k.Hold and prev and nxt then
				m = (nxt.P[c] - prev.P[c]) / (nxt.T - prev.T)
				if (k.P[c] - prev.P[c]) * (nxt.P[c] - k.P[c]) <= 0 then m = 0 end
			end
			k.M[c] = m
		end
	end
	return curve
end
local function evalCurve(curve, t, out)
	local n = #curve
	local a, b
	if t <= curve[1].T then a = curve[1] for c = 1, #a.P do out[c] = a.P[c] end return out end
	if t >= curve[n].T then a = curve[n] for c = 1, #a.P do out[c] = a.P[c] end return out end
	local i = 1
	while curve[i + 1].T <= t do i += 1 end
	a, b = curve[i], curve[i + 1]
	local h = b.T - a.T
	local s = (t - a.T) / h
	local s2, s3 = s * s, s * s * s
	local h00, h10, h01, h11 = 2 * s3 - 3 * s2 + 1, s3 - 2 * s2 + s, -2 * s3 + 3 * s2, s3 - s2
	for c = 1, #a.P do out[c] = h00 * a.P[c] + h10 * h * a.M[c] + h01 * b.P[c] + h11 * h * b.M[c] end
	return out
end

-- chemin de marche : courbe de Catmull-Rom échantillonnée, parcourue à la distance voulue
local function buildPath(points)
	local samples = {}
	for i = 1, #points - 1 do
		local p0, p1, p2, p3 = points[math.max(i - 1, 1)], points[i], points[i + 1], points[math.min(i + 2, #points)]
		for s = 0, 23 do
			local u = s / 24
			local u2, u3 = u * u, u * u * u
			table.insert(samples, 0.5 * ((2 * p1) + (-p0 + p2) * u + (2 * p0 - 5 * p1 + 4 * p2 - p3) * u2 + (-p0 + 3 * p1 - 3 * p2 + p3) * u3))
		end
	end
	table.insert(samples, points[#points])
	local dist = {0}
	for i = 2, #samples do dist[i] = dist[i - 1] + (samples[i] - samples[i - 1]).Magnitude end
	return {S = samples, D = dist, L = dist[#dist]}
end
local function pathAt(path, d)
	d = clamp(d, 0, path.L)
	local i = 1
	while i < #path.S - 1 and path.D[i + 1] < d do i += 1 end
	local seg = path.D[i + 1] - path.D[i]
	local k = seg > 0 and (d - path.D[i]) / seg or 0
	return path.S[i]:Lerp(path.S[i + 1], k), (path.S[i + 1] - path.S[i])
end
-- démarrage progressif, vitesse de croisière, arrêt en douceur
local function travel(t, t0, t1, L, accel, decel)
	local total = t1 - t0
	local s = clamp(t - t0, 0, total)
	local vmax = L / (total - accel / 2 - decel / 2)
	if s < accel then return 0.5 * vmax / accel * s * s, vmax * s / accel end
	if s < total - decel then return 0.5 * vmax * accel + vmax * (s - accel), vmax end
	local r = total - s
	return L - 0.5 * vmax / decel * r * r, vmax * r / decel
end

---------------------------------------------------------------- poses (degrés {x, y, z}, R15)
-- épaule/hanche +x = vers l'avant ; coude +x = plie ; genou -x = plie ; taille/cou +x = vers l'arrière ;
-- taille/cou +y = tourne vers sa gauche ; épaule droite +z = bras vers l'extérieur (gauche : -z)
local P = {}
P.Stand = {RightShoulder = {2, 0, 5}, RightElbow = {14, 0, 0}, LeftShoulder = {2, 0, -5}, LeftElbow = {14, 0, 0}, RightKnee = {-3, 0, 0}, LeftKnee = {-3, 0, 0}}
P.Push = {RightShoulder = {78, 0, 6}, RightElbow = {22, 0, 0}, RightWrist = {-30, 0, 0}, LeftShoulder = {4, 0, -6}, LeftElbow = {16, 0, 0}, Waist = {-4, 4, 0}}
-- (angles des bras calculés sur le vrai squelette R15 pour que les mains tombent pile sur le sac, l'ordinateur et le clavier)
P.Reach = {RightShoulder = {166, 31, -43}, RightElbow = {72, 0, 0}, RightWrist = {-20, 0, 0}, LeftShoulder = {8, 0, -10}, LeftElbow = {20, 0, 0}, Waist = {3, -18, 0}, Neck = {-4, -30, 0}}
P.Grab = {RightShoulder = {198, 37, -51}, RightElbow = {84, 0, 0}, RightWrist = {-30, 0, 0}, LeftShoulder = {10, 0, -12}, LeftElbow = {22, 0, 0}, Waist = {5, -22, 0}, Neck = {-6, -34, 0}}
P.Pull = {RightShoulder = {80, 35, -10}, RightElbow = {106, 0, 0}, LeftShoulder = {40, 0, -6}, LeftElbow = {60, 0, 0}, Waist = {2, -8, 0}, Neck = {-6, -10, 0}}
P.Front = {RightShoulder = {31, 21, -6}, RightElbow = {127, 0, 0}, LeftShoulder = {31, -21, 6}, LeftElbow = {127, 0, 0}, Neck = {-14, 0, 0}}
P.Lean = {Waist = {-24, 0, 0}, Neck = {-12, 0, 0}, RightShoulder = {31, 19, -3}, RightElbow = {127, 0, 0}, LeftShoulder = {31, -19, 3}, LeftElbow = {127, 0, 0},
	RightHip = {8, 0, 0}, RightKnee = {-10, 0, 0}, LeftHip = {8, 0, 0}, LeftKnee = {-10, 0, 0}}
P.Open = {Waist = {-18, 0, 0}, Neck = {-14, 0, 0}, RightShoulder = {114, 17, -37}, RightElbow = {48, 0, 0}, RightWrist = {-20, 0, 0}, LeftShoulder = {68, -24, 29}, LeftElbow = {72, 0, 0},
	RightHip = {5, 0, 0}, RightKnee = {-8, 0, 0}, LeftHip = {5, 0, 0}, LeftKnee = {-8, 0, 0}}
P.Type = {Waist = {-15, 0, 0}, Neck = {-25, 0, 0}, RightShoulder = {68, 24, -29}, RightElbow = {72, 0, 0}, RightWrist = {-18, 0, 0},
	LeftShoulder = {68, -24, 29}, LeftElbow = {72, 0, 0}, LeftWrist = {-18, 0, 0}, RightHip = {6, 0, 0}, RightKnee = {-9, 0, 0}, LeftHip = {6, 0, 0}, LeftKnee = {-9, 0, 0}}
P.Lift = {Waist = {-6, 0, 0}, Neck = {-12, 0, 0}, RightShoulder = {56, 39, -20}, RightElbow = {98, 0, 0}, RightWrist = {12, 0, 0},
	LeftShoulder = {56, -39, 20}, LeftElbow = {98, 0, 0}, LeftWrist = {12, 0, 0}, RightHip = {3, 0, 0}, RightKnee = {-6, 0, 0}, LeftHip = {3, 0, 0}, LeftKnee = {-6, 0, 0}}
P.Proud = {Waist = {5, 0, 0}, Neck = {-4, 8, 0}, RightShoulder = {12, 0, 14}, RightElbow = {30, 0, 0}, LeftShoulder = {12, 0, -14}, LeftElbow = {30, 0, 0}}
-- la dernière touche (Entrée) : la main droite se lève... puis frappe, et ne bouge plus
P.EnterUp = table.clone(P.Type)
P.EnterUp.RightShoulder, P.EnterUp.RightElbow, P.EnterUp.RightWrist = {84, 24, -29}, {96, 0, 0}, {18, 0, 0}
P.EnterUp.Neck = {-18, 0, 0}
P.EnterHit = table.clone(P.Type)
P.EnterHit.RightShoulder, P.EnterHit.RightElbow, P.EnterHit.RightWrist = {66, 24, -29}, {70, 0, 0}, {-26, 0, 0}
P.EnterHit.Neck = {-20, 0, 0}
-- un dernier regard sur l'ordinateur avant de partir
P.Glance = {Waist = {-6, 0, 0}, Neck = {-30, 6, 0}, RightShoulder = {6, 0, 8}, RightElbow = {20, 0, 0}, LeftShoulder = {6, 0, -8}, LeftElbow = {20, 0, 0}}

local KEYS = {
	{0, P.Stand}, {1.6, P.Stand}, {1.95, P.Push}, {2.45, P.Push}, {3.1, P.Stand}, {T.walkIn[2], P.Stand},
	{T.reach, P.Reach}, {T.grab, P.Grab, true}, {T.pull, P.Pull}, {T.front, P.Front}, {T.frontHold, P.Front, true},
	{T.lean, P.Lean}, {T.leanHold, P.Lean, true}, {T.lidOpen[1] + 0.3, P.Open}, {T.lidOpen[2], P.Open}, {T.typeStart, P.Type},
	{T.typeEnd - 0.55, P.Type}, {T.typeEnd - 0.3, P.EnterUp}, {T.typeEnd - 0.12, P.EnterHit}, {T.typeEnd + 0.35, P.EnterHit, true}, -- dernière touche, mains immobiles
	{T.lift, P.Lift}, {T.lift + 1.1, P.Lift}, {T.lift + 1.6, P.Proud}, {T.straighten - 0.25, P.Glance}, {T.straighten + 0.2, P.Stand}, {T.walkOut[1], P.Stand}, {99, P.Stand},
}
local JOINTS = {"Waist", "Neck", "RightShoulder", "RightElbow", "RightWrist", "LeftShoulder", "LeftElbow", "LeftWrist",
	"RightHip", "RightKnee", "RightAnkle", "LeftHip", "LeftKnee", "LeftAnkle"}
local SPRING = {
	Waist = {16, 0.85}, Neck = {13, 0.8}, RightShoulder = {20, 0.8}, RightElbow = {18, 0.7}, RightWrist = {16, 0.65},
	LeftShoulder = {18, 0.8}, LeftElbow = {16, 0.7}, LeftWrist = {15, 0.65},
	RightHip = {18, 0.9}, RightKnee = {18, 0.85}, RightAnkle = {15, 0.8}, LeftHip = {18, 0.9}, LeftKnee = {18, 0.85}, LeftAnkle = {15, 0.8},
}
local CURVES = {}
for _, name in JOINTS do
	CURVES[name] = buildCurve(KEYS, function(pose) local a = pose[name] or {0, 0, 0} return {a[1], a[2], a[3]} end)
end

-- avatars récents : AnimationConstraint -> Motor6D (sinon on ne peut pas les animer de façon fiable)
local function convertJoints(rig)
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
end

---------------------------------------------------------------- écran du jeu : bandes noires + fondu
local gui = new("ScreenGui", {Name = "HackerCutsceneGui", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 1000, Enabled = false}, playerGui)
local topBar = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.1, 0), Position = UDim2.new(0, 0, -0.1, 0)}, gui)
local botBar = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.1, 0), Position = UDim2.new(0, 0, 1, 0)}, gui)
local fade = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 20}, gui)
local function bars(on)
	local info = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(topBar, info, {Position = on and UDim2.new() or UDim2.new(0, 0, -0.1, 0)}):Play()
	TweenService:Create(botBar, info, {Position = on and UDim2.new(0, 0, 0.9, 0) or UDim2.new(0, 0, 1, 0)}):Play()
end
local function fadeTo(alpha, t) TweenService:Create(fade, TweenInfo.new(t or 0.8), {BackgroundTransparency = alpha}):Play() end

---------------------------------------------------------------- écran de l'ordinateur : terminal
local TERMINAL = {
	"root@shadow:~# ssh admin@egg-mainframe",
	"> connecting to 10.0.66.13:22 ........ OK",
	"> bypassing firewall [rule 0x5A] ...... OK",
	"> brute-force admin password ...",
	"  trying: dragon123   [FAIL]",
	"  trying: eggs4life   [FAIL]",
	"  trying: hammer2026  [ OK ]",
	"> privilege escalation ............ ROOT",
	"> injecting payload virus.lua",
	"> disabling security cameras ...... OK",
	"> downloading /eggs/database.db",
	"> erasing logs .................... OK",
	"> overriding mainframe ...",
}
local function buildDisplay(display)
	local bg = display:FindFirstChild("Bg")
	bg:ClearAllChildren()
	local ui = {}
	ui.Boot = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.Code, TextScaled = true, TextColor3 = GREEN,
		Text = "", TextTransparency = 0}, bg)
	new("UITextSizeConstraint", {MaxTextSize = 34}, ui.Boot)
	ui.Lines = new("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromScale(0.03, 0.03), Size = UDim2.fromScale(0.94, 0.74), Font = Enum.Font.Code, TextSize = 17,
		TextColor3 = GREEN, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Text = "", Visible = false}, bg)
	ui.Bar = new("Frame", {BackgroundColor3 = rgb(0, 40, 14), BorderSizePixel = 0, Position = UDim2.fromScale(0.03, 0.84), Size = UDim2.fromScale(0.94, 0.09), Visible = false}, bg)
	new("UIStroke", {Color = GREEN, Thickness = 2}, ui.Bar)
	ui.Fill = new("Frame", {BackgroundColor3 = GREEN, BorderSizePixel = 0, Size = UDim2.fromScale(0, 1)}, ui.Bar)
	ui.Pct = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.Code, TextScaled = true, TextColor3 = rgb(220, 255, 230),
		Text = "ACCESS 0%", ZIndex = 3}, ui.Bar)
	new("UIStroke", {Thickness = 1.5, Color = rgb(0, 30, 10)}, ui.Pct)
	ui.Glitch = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5, Visible = false}, bg)
	for i = 1, 7 do
		new("Frame", {Name = "G" .. i, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.05), ZIndex = 5}, ui.Glitch)
	end
	ui.Hacked = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Size = UDim2.fromScale(0.94, 0.34),
		Font = Enum.Font.Code, TextScaled = true, TextColor3 = GREEN, Text = "SYSTEM HACKED !!!!!", Visible = false, ZIndex = 4}, bg)
	new("UIStroke", {Thickness = 3, Color = rgb(0, 60, 20)}, ui.Hacked)
	ui.Sub = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.66), Size = UDim2.fromScale(0.8, 0.1),
		Font = Enum.Font.Code, TextScaled = true, TextColor3 = rgb(180, 255, 200), Text = "root access granted  //  mainframe offline", Visible = false, ZIndex = 4}, bg)
	return ui
end

---------------------------------------------------------------- la cinématique
local playing = false
local function run()
	if playing then return end -- jamais deux en même temps
	local setTemplate, rigTemplate = folder:FindFirstChild("Set"), folder:FindFirstChild("Rig")
	if not setTemplate or not rigTemplate then warn("[HackerCutscene] décor ou avatar manquant") return end
	playing = true
	local camera = workspace.CurrentCamera

	-- le joueur ne bouge plus, l'interface du jeu est cachée (tout est remis à la fin, même en cas d'erreur)
	local hidden = {}
	for _, g in playerGui:GetChildren() do
		if g:IsA("ScreenGui") and g ~= gui and g.Enabled then g.Enabled = false table.insert(hidden, g) end
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)
	local controls
	local pm = player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("PlayerModule")
	if pm then pcall(function() controls = require(pm):GetControls() controls:Disable() end) end
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local oldSpeed, oldJump = hum and hum.WalkSpeed, hum and hum.JumpPower
	if hum then hum.WalkSpeed = 0 hum.JumpPower = 0 end
	local oldFov = camera.FieldOfView
	gui.Enabled = true
	fade.BackgroundTransparency = 0
	-- la musique du jeu baisse puis se coupe pendant la scène (elle reprend à la fin) : on entend le silence avant la réussite
	local music = game:GetService("SoundService"):FindFirstChild("Days", true) or workspace:FindFirstChild("Days", true)
	local musicVolume = music and music.Volume
	local musicWasPlaying = music and music.IsPlaying
	if music and musicWasPlaying then
		TweenService:Create(music, TweenInfo.new(1.2), {Volume = 0}):Play()
		task.delay(1.25, function() if playing and music.Parent then music:Pause() end end)
	end

	local scene, conn, typing
	local ok, err = pcall(function()
		-------------------------------------------- décor
		scene = setTemplate:Clone()
		scene.Name = "HackerCutsceneSet"
		scene.Parent = workspace
		local floor = scene:WaitForChild("Origin").CFrame * CFrame.new(0, -0.5, 0) -- sol de la salle
		local function W(p) return floor:PointToWorldSpace(p) end
		local door = scene:FindFirstChild("Door")
		local doorClosed = door and door:GetPivot()
		local leds, wallScreen = {}, scene:FindFirstChild("WallScreen")
		for _, p in scene:GetChildren() do if p.Name == "Led" then table.insert(leds, p) end end

		local laptop = folder.Laptop:Clone()
		local base, lid, logo, screen = laptop.Base, laptop.Lid, laptop.Logo, laptop.Screen
		local lidRel = base.CFrame:ToObjectSpace(lid.CFrame)      -- couvercle fermé, relatif à la base
		local screenRel = lid.CFrame:ToObjectSpace(screen.CFrame) -- dalle relative au couvercle
		local logoRel = lid.CFrame:ToObjectSpace(logo.CFrame)
		local fixed = {}                                         -- les autres pièces suivent la base
		for _, p in laptop:GetChildren() do
			if p:IsA("BasePart") and p ~= base and p ~= lid and p ~= logo and p ~= screen then fixed[p] = base.CFrame:ToObjectSpace(p.CFrame) end
		end
		laptop.Parent = scene
		local ui = buildDisplay(screen:WaitForChild("Display"))
		local screenLight = screen:FindFirstChild("ScreenLight")
		local keyGlow = laptop:FindFirstChild("KeyGlow")
		local function placeLaptop(cf, lidAngle)
			base.CFrame = cf
			for p, rel in fixed do p.CFrame = cf * rel end
			-- le couvercle tourne autour de la charnière arrière (+Z de la base)
			local hinge = cf * CFrame.new(0, 0.06, 0.8)
			local lidCF = hinge * CFrame.Angles(rad(lidAngle), 0, 0) * hinge:ToObjectSpace(cf * lidRel)
			lid.CFrame = lidCF
			screen.CFrame = lidCF * screenRel
			logo.CFrame = lidCF * logoRel
		end

		local bag = folder.Backpack:Clone()
		bag.Parent = scene

		-------------------------------------------- le hacker
		local rig = rigTemplate:Clone()
		convertJoints(rig)
		local humanoid = rig:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			pcall(function() humanoid.EvaluateStateMachine = false end)
		end
		local root = rig:WaitForChild("HumanoidRootPart")
		for _, p in rig:GetDescendants() do
			if p:IsA("BasePart") then p.Anchored = false p.CanCollide, p.CanQuery, p.CanTouch = false, false, false end
		end
		root.Anchored = true
		local motors = {}
		for _, d in rig:GetDescendants() do
			if d:IsA("Motor6D") and table.find(JOINTS, d.Name) then motors[d.Name] = {Motor = d, Base = d.C0} end
		end
		-- hauteur du bassin pour que les pieds touchent le sol
		rig:PivotTo(CFrame.new(0, 100, 0))
		rig.Parent = scene
		local lowest = math.huge
		for _, name in {"LeftFoot", "RightFoot"} do
			local f = rig:FindFirstChild(name)
			if f then lowest = math.min(lowest, f.Position.Y - f.Size.Y / 2) end
		end
		local rootHeight = lowest < math.huge and (root.Position.Y - lowest) or 3
		local upper, rightHand, leftHand, head = rig:FindFirstChild("UpperTorso"), rig:FindFirstChild("RightHand"), rig:FindFirstChild("LeftHand"), rig:FindFirstChild("Head")
		local springs = {}
		for name in motors do
			local a = evalCurve(CURVES[name], 0, {})
			springs[name] = {P = {a[1], a[2], a[3]}, V = {0, 0, 0}}
		end
		pcall(function() ContentProvider:PreloadAsync({rig, scene}) end)

		local pathIn, pathOut = buildPath(PATH_IN), buildPath(PATH_OUT)

		-------------------------------------------- sons
		typing = sounds:FindFirstChild("Typing") and sounds.Typing:Clone()
		if typing then typing.Looped = true typing.Volume = 0 typing.Parent = scene end
		-- bruits de pas (son intégré de Roblox, le même que celui des personnages)
		local footsteps = new("Sound", {Name = "Footsteps", SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true, Volume = 0, PlaybackSpeed = 0.85}, scene)
		local function engineSound(id, volume, speed)
			local s = new("Sound", {SoundId = id, Volume = volume, PlaybackSpeed = speed or 1}, scene)
			s:Play()
			s.Ended:Connect(function() s:Destroy() end)
		end
		-- sons déclenchés à un instant précis de la scène
		local CUES = {
			{T.lidOpen[1] + 0.1, function() engineSound("rbxasset://sounds/clickfast.wav", 0.6, 0.8) end},          -- l'écran s'ouvre
			{T.lidOpen[2], function() engineSound("rbxasset://sounds/electronicpingshort.wav", 0.35, 1.2) end},     -- démarrage
			{T.typeEnd - 0.12, function() engineSound("rbxasset://sounds/clickfast.wav", 1, 0.7) end},              -- la dernière touche
			{T.hacked, function() engineSound("rbxasset://sounds/electronicpingshort.wav", 0.9, 0.75) end},         -- confirmation
		}
		local function oneShot(name, volume, speed)
			local s = sounds:FindFirstChild(name)
			if not s then return nil end
			s = s:Clone()
			s.Volume = volume
			s.PlaybackSpeed = speed or 1
			s.Parent = scene
			s:Play()
			return s
		end

		-------------------------------------------- caméra : plans enchaînés en douceur (repère de la salle)
		camera.CameraType = Enum.CameraType.Scriptable
		local function shotLerp(a, b, t0, t1, t) return a:Lerp(b, smooth((t - t0) / (t1 - t0))) end
		local state = {pos = V(6, 0, -1.15), torso = W(V(-24, 4.6, -7))}
		local function cameraGoal(t)
			local torso = state.torso
			if t < 1.7 then -- plan d'ensemble : la porte
				return W(shotLerp(V(13, 8.5, -12), V(11.5, 7.5, -12.4), 0, 1.7, t)), W(V(-20, 4.5, -7)), 58
			elseif t < T.walkIn[2] then -- on suit le hacker jusqu'à la table
				local hx = floor:PointToObjectSpace(torso).X
				return W(V(clamp(hx + 6, -13, 13), 6.5, -12.6)), torso, 56
			elseif t < T.lidOpen[1] - 0.05 then -- 3/4 face, de l'autre côté de la table : il sort et pose l'ordinateur
				return W(shotLerp(V(10.6, 6.2, 5.6), V(9.8, 5.8, 4.8), T.walkIn[2], T.lidOpen[1], t)), W(V(6, 5.0, -0.6)), 52
			elseif t < T.typeStart + 1.4 then -- par-dessus l'épaule : le hacker, la table, l'écran
				return W(shotLerp(V(8.2, 7.0, -4.2), V(7.7, 6.6, -3.6), T.lidOpen[1], T.typeStart + 1.4, t)), W(V(6, 4.4, 1.05)), 50
			elseif t < T.typeStart + 3.0 then -- gros plan sur les mains qui tapent
				return W(shotLerp(V(8.8, 4.7, 0.7), V(8.4, 4.55, 0.55), T.typeStart + 1.4, T.typeStart + 3.0, t)), W(V(6, 3.95, 0.75)), 38
			elseif t < T.typeStart + 4.6 then -- son visage éclairé en vert, vu de derrière l'écran
				return W(shotLerp(V(6.7, 5.6, 3.1), V(6.45, 5.65, 2.6), T.typeStart + 3.0, T.typeStart + 4.6, t)), W(V(6, 5.0, -0.75)), 46
			elseif t < T.typeEnd then -- on s'approche de l'écran (à côté de sa tête, jamais dedans)
				return W(shotLerp(V(7.6, 6.7, -3.0), V(7.3, 5.0, 0.1), T.typeStart + 4.6, T.typeEnd, t)), W(SCREEN), 42
			elseif t < T.straighten - 0.1 then -- gros plan : SYSTEM HACKED
				local back = ramp(t, T.straighten - 1.2, T.straighten - 0.1)
				return W(V(6.95, 5.35, 0.5):Lerp(V(7.6, 6.6, -4.4), back)), W(SCREEN):Lerp(torso, back * 0.5), 40 + back * 14
			elseif t < T.doorClose[2] + 0.2 then -- plan large : il repart
				return W(V(15.5, 9, 10)), torso, 58
			else -- la salle vide, le message brille encore
				return W(shotLerp(V(12.5, 6.6, -10), V(9, 5.6, -4.5), T.doorClose[2] + 0.2, T.finish, t)), W(SCREEN), 52
			end
		end

		-------------------------------------------- boucle d'animation
		local t0 = os.clock()
		local yaw = math.atan2(-1, 0) -- (vers +X, en entrant)
		local walkPhase, walkAmt = 0, 0
		local laptopCF, lidAngle = nil, 0
		local camCF, camLook
		local shake = 0
		local hackedShown, glitchDone, ledsRed = false, false, false
		local shownLines, lastLine = 0, 0
		local target = {}
		local visible = true
		conn = RunService.RenderStepped:Connect(function(dt)
			dt = math.min(dt, 1 / 20)
			local t = os.clock() - t0

			---------------- position et orientation du corps
			local pos, dir, speed
			if t < T.walkIn[2] then
				local d, v = travel(t, T.walkIn[1], T.walkIn[2], pathIn.L, 0.7, 0.9)
				pos, dir = pathAt(pathIn, d)
				speed = t < T.walkIn[1] and 0 or v
			elseif t < T.walkOut[1] then
				pos, dir, speed = STAND, V(0, 0, 1), 0
			else
				local d, v = travel(t, T.walkOut[1], T.walkOut[2], pathOut.L, 0.8, 0.4)
				pos, dir = pathAt(pathOut, d)
				speed = t > T.walkOut[2] and 0 or v
			end
			local wantYaw = yaw
			if speed > 0.3 and dir.Magnitude > 1e-3 then wantYaw = math.atan2(-dir.X, -dir.Z)
			elseif t >= T.walkIn[2] - 0.3 and t < T.walkOut[1] then wantYaw = math.atan2(0, -1) end -- face à la table (+Z)
			local yawRate = angleDiff(yaw, wantYaw) * (1 - math.exp(-dt * 6))
			yaw += yawRate
			yawRate /= math.max(dt, 1e-3)

			-- cycle de marche calé sur la vitesse (et petits pas quand il tourne sur place)
			local STEP = 1.9 -- longueur d'un pas (studs)
			walkPhase += dt * (speed / STEP * math.pi + math.min(math.abs(yawRate), 3) * 1.4)
			local wantAmt = clamp(speed / 5, 0, 1)
			wantAmt = math.max(wantAmt, clamp(math.abs(yawRate) / 3, 0, 0.45))
			walkAmt += (wantAmt - walkAmt) * (1 - math.exp(-dt * 8))
			local sp = math.sin(walkPhase)
			local bob = 0.13 * (math.abs(math.cos(walkPhase)) - 0.64) * walkAmt
			local sway = 0.06 * sp * walkAmt
			local bodyCF = floor * CFrame.new(pos.X, rootHeight + bob, pos.Z) * CFrame.Angles(0, yaw, 0) * CFrame.new(sway, 0, 0)
			root.CFrame = bodyCF
			if upper then state.torso = upper.Position end
			-- il disparaît derrière la porte une fois sorti
			local shouldShow = not (t > T.doorClose[2] or (t < T.walkIn[1]))
			if shouldShow ~= visible then
				visible = shouldShow
				rig.Parent = visible and scene or nil
				bag.Parent = visible and scene or nil
			end

			---------------- articulations : courbe + ressort, puis marche et frappe par-dessus
			local typeAmt = ramp(t, T.typeStart - 0.15, T.typeStart + 0.25) * (1 - ramp(t, T.typeEnd - 0.7, T.typeEnd - 0.45)) -- il s'arrête pour la dernière touche
			local cp = math.cos(walkPhase)
			for name, m in motors do
				evalCurve(CURVES[name], t, target)
				local s, cfg = springs[name], SPRING[name]
				local steps = math.max(1, math.ceil(dt / (1 / 240)))
				local h = dt / steps
				for _ = 1, steps do
					for c = 1, 3 do
						local acc = cfg[1] * cfg[1] * (target[c] - s.P[c]) - 2 * cfg[2] * cfg[1] * s.V[c]
						s.V[c] += acc * h
						s.P[c] += s.V[c] * h
					end
				end
				local x, y, z = s.P[1], s.P[2], s.P[3]
				-- marche
				if walkAmt > 0.001 then
					local a = walkAmt
					if name == "RightHip" then x += 30 * sp * a
					elseif name == "LeftHip" then x -= 30 * sp * a
					elseif name == "RightKnee" then x -= (6 + 45 * math.max(0, cp)) * a
					elseif name == "LeftKnee" then x -= (6 + 45 * math.max(0, -cp)) * a
					elseif name == "RightAnkle" then x += 12 * math.sin(walkPhase - 0.6) * a
					elseif name == "LeftAnkle" then x -= 12 * math.sin(walkPhase - 0.6) * a
					elseif name == "RightShoulder" then x -= 20 * sp * a
					elseif name == "LeftShoulder" then x += 20 * sp * a
					elseif name == "RightElbow" then x += (8 + 12 * math.max(0, sp)) * a
					elseif name == "LeftElbow" then x += (8 + 12 * math.max(0, -sp)) * a
					elseif name == "Waist" then y += 7 * sp * a x -= 3 * a
					elseif name == "Neck" then y -= 5 * sp * a
					end
				end
				-- frappe au clavier : poignets et doigts qui tapent, mains qui se déplacent sur le clavier, tête qui lit
				if typeAmt > 0.001 then
					local k = typeAmt
					local burst = 0.6 + 0.4 * math.sin(t * 1.3) -- il accélère et ralentit
					if name == "RightWrist" then x += (math.sin(t * 23) * 9 + math.noise(t * 9, 1) * 8) * k * burst
					elseif name == "LeftWrist" then x += (math.sin(t * 19 + 1.7) * 9 + math.noise(t * 9, 2) * 8) * k * burst
					elseif name == "RightElbow" then x += math.sin(t * 11) * 4 * k * burst
					elseif name == "LeftElbow" then x += math.sin(t * 13 + 2) * 4 * k * burst
					elseif name == "RightShoulder" then y += math.noise(t * 1.6, 3) * 12 * k z += math.sin(t * 2.3) * 3 * k
					elseif name == "LeftShoulder" then y += math.noise(t * 1.4, 4) * 12 * k z += math.sin(t * 2.7 + 1) * 3 * k
					elseif name == "Neck" then y += math.noise(t * 0.7, 5) * 14 * k x += math.sin(t * 1.7) * 2 * k
					elseif name == "Waist" then x += math.sin(t * 0.6) * 1.5 * k
					end
				end
				-- respiration
				if name == "Waist" then x += math.sin(t * 1.8) * 1.2 end
				m.Motor.C0 = m.Base * CFrame.Angles(rad(x), rad(y), rad(z))
			end

			---------------- sac à dos (sur le dos)
			if upper then bag:PivotTo(upper.CFrame * CFrame.new(0, -0.05, upper.Size.Z / 2 + 0.43)) end

			---------------- l'ordinateur : dans le sac -> main droite -> deux mains -> posé sur la table
			local goal
			if t < T.grab then
				goal = bag:GetPivot() * CFrame.new(0, 0.55, -0.05) * CFrame.Angles(rad(90), 0, 0)
			elseif t < T.front - 0.2 and rightHand then
				goal = rightHand.CFrame * CFrame.new(0, -0.75, 0) * CFrame.Angles(rad(90), 0, 0)
			elseif t < T.release and rightHand and leftHand then
				local mid = (rightHand.Position + leftHand.Position) / 2
				local flat = ramp(t, T.frontHold, T.lean) -- debout contre la poitrine -> à plat
				local facing = floor.Rotation * CFrame.Angles(0, yaw, 0)
				-- l'avant de l'ordinateur (clavier) tourné vers lui ; il le tient d'abord droit comme un livre, puis à plat
				local rot = facing * CFrame.Angles(0, math.pi, 0) * CFrame.Angles(rad(-70 * (1 - flat)), 0, 0)
				goal = CFrame.new(mid + facing.LookVector * 0.05 - V(0, 0.05, 0)) * rot -- les mains le tiennent par les côtés
			else
				goal = floor * TABLE_LAPTOP
			end
			if not laptopCF then laptopCF = goal end
			local follow = t < T.release and 30 or 14
			laptopCF = laptopCF:Lerp(goal, 1 - math.exp(-dt * follow))
			lidAngle = LID_OPEN * smoother((t - T.lidOpen[1]) / (T.lidOpen[2] - T.lidOpen[1]))
			placeLaptop(laptopCF, lidAngle)

			---------------- écran de l'ordinateur
			if t >= T.lidOpen[1] + 0.2 and t < T.typeStart then
				ui.Boot.Text = "> booting shadow.os" .. string.rep(".", math.floor((t * 4) % 4))
				if screenLight then screenLight.Brightness = 0.6 * ramp(t, T.lidOpen[1], T.lidOpen[2]) end
			elseif t >= T.typeStart and t < T.typeEnd then
				ui.Boot.Visible = false
				ui.Lines.Visible, ui.Bar.Visible = true, true
				local n = math.min(#TERMINAL, math.floor((t - T.typeStart) / ((T.typeEnd - T.typeStart - 0.4) / #TERMINAL)) + 1)
				if n ~= shownLines then
					shownLines = n
					local from = math.max(1, n - 8)
					ui.Lines.Text = table.concat(TERMINAL, "\n", from, n)
				end
				local pct = math.floor(smooth((t - T.typeStart) / (T.typeEnd - T.typeStart)) * 100)
				ui.Fill.Size = UDim2.fromScale(pct / 100, 1)
				ui.Pct.Text = "ACCESS " .. pct .. "%" .. ((t * 3) % 1 < 0.5 and " _" or "")
				if screenLight then screenLight.Brightness = 0.8 + 0.15 * math.sin(t * 9) end
				if keyGlow then keyGlow.Transparency = 0.7 + 0.15 * math.sin(t * 17) end
			elseif t >= T.typeEnd and t < T.hacked then
				-- le bug juste avant le message
				if not glitchDone then glitchDone = true oneShot("Spark2", 0.8, 0.9) end
				ui.Glitch.Visible = true
				for _, g in ui.Glitch:GetChildren() do
					g.Visible = math.random() < 0.7
					g.BackgroundColor3 = ({GREEN, rgb(255, 40, 80), rgb(40, 220, 255), rgb(255, 255, 255)})[math.random(4)]
					g.Position = UDim2.fromScale(math.random() * 0.3 - 0.15, math.random())
					g.Size = UDim2.fromScale(0.6 + math.random() * 0.6, 0.02 + math.random() * 0.08)
				end
				ui.Lines.TextColor3 = math.random() < 0.5 and GREEN or rgb(255, 60, 90)
				if screenLight then screenLight.Brightness = math.random() * 1.5 end
			elseif t >= T.hacked then
				if not hackedShown then
					hackedShown = true
					ui.Glitch.Visible = false
					ui.Lines.Visible, ui.Bar.Visible = false, false
					ui.Hacked.Visible, ui.Sub.Visible = true, true
					shake = 0.5
					local alarm = oneShot("Alarm", 0.35, 1.05)
					if alarm then task.delay(2.6, function() TweenService:Create(alarm, TweenInfo.new(1), {Volume = 0}):Play() end) end
					oneShot("Spark", 0.7, 0.8)
				end
				-- le message clignote et tremble un peu
				local blink = (t * 2.2) % 1 < 0.72
				ui.Hacked.TextTransparency = blink and 0 or 0.65
				ui.Hacked.Position = UDim2.new(0.5, (math.random() < 0.06) and math.random(-8, 8) or 0, 0.44, 0)
				if screenLight then screenLight.Brightness = blink and 1.3 or 0.6 end
				-- les serveurs passent en alerte
				if not ledsRed then
					ledsRed = true
					for _, led in leds do led.Color = rgb(255, 40, 50) end
					if wallScreen then wallScreen.Color = rgb(90, 0, 10) local l = wallScreen:FindFirstChildOfClass("PointLight") if l then l.Color = rgb(255, 40, 50) end end
				end
			end
			if typing then typing.Volume = 0.6 * typeAmt if typeAmt > 0.01 and not typing.IsPlaying then typing:Play() end end
			-- pas : au rythme de la marche
			local stepVol = 0.55 * clamp(speed / 4, 0, 1)
			footsteps.Volume = stepVol
			if stepVol > 0.02 and not footsteps.IsPlaying and visible then footsteps:Play() elseif (stepVol <= 0.02 or not visible) and footsteps.IsPlaying then footsteps:Stop() end
			for _, cue in CUES do
				if not cue.Done and t >= cue[1] then cue.Done = true pcall(cue[2]) end
			end

			---------------- LED des serveurs qui clignotent
			for _, led in leds do
				local ph = led:GetAttribute("Phase") or 0
				led.Transparency = ((t * (ledsRed and 6 or 3) + ph * 0.37) % 1) < (ledsRed and 0.5 or 0.75) and 0 or 0.7
			end

			---------------- la porte : elle s'ouvre devant lui, se referme derrière lui
			if door and doorClosed then
				-- ouverte quand il entre (refermée derrière lui), rouverte quand il repart (refermée derrière lui)
				local open = ramp(t, T.doorOpen[1], T.doorOpen[2]) * (1 - ramp(t, 4.6, 5.4)) + ramp(t, 24.4, 25.2) * (1 - ramp(t, T.doorClose[1], T.doorClose[2]))
				door:PivotTo(doorClosed * CFrame.Angles(0, rad(92) * open, 0))
			end

			---------------- caméra
			local pos2, look, fov = cameraGoal(t)
			if not camCF then camCF, camLook = pos2, look end
			local k = 1 - math.exp(-dt * 3.2)
			camCF = camCF:Lerp(pos2, k)
			camLook = camLook:Lerp(look, 1 - math.exp(-dt * 4.5))
			local cf = CFrame.lookAt(camCF, camLook)
			-- léger tremblement de caméra à l'épaule + secousse au moment du message
			shake = math.max(0, shake - dt * 0.9)
			cf *= CFrame.Angles(rad(math.noise(t * 0.4, 1.3) * 0.7 + math.noise(t * 25, 9) * shake * 2), rad(math.noise(t * 0.35, 7.1) * 0.7 + math.noise(9, t * 25) * shake * 2), 0)
			camera.CFrame = cf
			camera.FieldOfView += (fov - camera.FieldOfView) * math.min(1, dt * 3)
		end)

		-------------------------------------------- déroulement
		fadeTo(1, 0.9)
		bars(true)
		local function waitT(x) while os.clock() - t0 < x do RunService.RenderStepped:Wait() end end
		waitT(T.fadeOut)
		fadeTo(0, 0.7)
		waitT(T.finish)
	end)
	if not ok then warn("[HackerCutscene] " .. tostring(err)) end

	-------------------------------------------- tout est remis comme avant (même si quelque chose a échoué)
	if conn then conn:Disconnect() end
	if typing then typing:Stop() end
	if scene then scene:Destroy() end
	bars(false)
	camera.CameraType = Enum.CameraType.Custom
	camera.FieldOfView = oldFov
	local c = player.Character
	if c then camera.CameraSubject = c:FindFirstChildOfClass("Humanoid") end
	for _, g in hidden do if g.Parent then g.Enabled = true end end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
	if controls then pcall(function() controls:Enable() end) end
	if hum and hum.Parent then hum.WalkSpeed = oldSpeed or 16 hum.JumpPower = oldJump or 50 end
	if music and musicWasPlaying and music.Parent then
		music.Volume = 0
		music:Resume()
		TweenService:Create(music, TweenInfo.new(2), {Volume = musicVolume or 0.5}):Play()
	end
	fade.BackgroundTransparency = 0
	fadeTo(1, 0.8)
	task.wait(0.85)
	gui.Enabled = false
	playing = false
end

playRemote.OnClientEvent:Connect(function(startAt)
	if type(startAt) ~= "number" then return end
	local delay = startAt - workspace:GetServerTimeNow()
	if delay < -2 then return end -- arrivé en retard : on ne la montre pas
	task.wait(math.max(0, delay))
	run()
end)
