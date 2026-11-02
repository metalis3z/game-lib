local CutsceneLock = require(game:GetService("ReplicatedStorage"):WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
-- SafeCutsceneClient : cutscene "Halloween Talk" (panneau admin F2 > Events > Cutscene : Halloween Talk)
-- Nono275er, kinoshi112 et rexydev1 (vrais skins, sans pseudo) sont assis par terre dans la safe zone,
-- boivent un verre d'eau et se mettent d'accord pour faire une update Halloween avec une nouvelle zone.
-- Tout est local : les avatars viennent de ReplicatedStorage.Cutscene.Rigs (préparés par CutsceneServer).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local playRemote = remotes:WaitForChild("PlayCutscene")
local folder = ReplicatedStorage:WaitForChild("Cutscene")

local rad, sin, cos, clamp = math.rad, math.sin, math.cos, math.clamp
local rgb = Color3.fromRGB
local CENTER = Vector3.new(-178, 0, -205) -- herbe de la safe zone, endroit dégagé
local HEAVY = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)

local function new(class, props, parent)
	local i = Instance.new(class)
	for k, v in props or {} do i[k] = v end
	if parent then i.Parent = parent end
	return i
end
local function smooth(u) u = clamp(u, 0, 1) return u * u * (3 - 2 * u) end

---------------------------------------------------------------- interface : bandes noires, sous-titres, titre
local gui = new("ScreenGui", {Name = "SafeCutsceneGui", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 1000, Enabled = false}, playerGui)
local topBar = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.11, 0), Position = UDim2.new(0, 0, -0.11, 0)}, gui)
local botBar = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.15, 0), Position = UDim2.new(0, 0, 1, 0)}, gui)
local caption = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.new(0.9, 0, 0.7, 0), Position = UDim2.new(0.05, 0, 0.15, 0), FontFace = BOLD, TextScaled = true,
	TextColor3 = rgb(255, 255, 255), Text = "", TextWrapped = true}, botBar)
new("UITextSizeConstraint", {MaxTextSize = 34}, caption)
local fade = new("Frame", {BackgroundColor3 = rgb(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 20}, gui)
local title = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.new(0.8, 0, 0.13, 0), Position = UDim2.new(0.1, 0, 0.33, 0), FontFace = HEAVY, TextScaled = true,
	TextColor3 = rgb(255, 140, 30), Text = "UPDATE HALLOWEEN", TextTransparency = 1, ZIndex = 10}, gui)
local titleStroke = new("UIStroke", {Thickness = 4, Color = rgb(60, 10, 70), Transparency = 1}, title)
local subtitle = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.new(0.6, 0, 0.06, 0), Position = UDim2.new(0.2, 0, 0.47, 0), FontFace = BOLD, TextScaled = true,
	TextColor3 = rgb(255, 255, 255), Text = "NOUVELLE ZONE  ·  BIENTÔT", TextTransparency = 1, ZIndex = 10}, gui)
local subStroke = new("UIStroke", {Thickness = 2.5, Transparency = 1}, subtitle)

local captionToken = 0
local function say(text, color)
	captionToken += 1
	local token = captionToken
	caption.Text = text or ""
	caption.TextColor3 = color or rgb(255, 255, 255)
	caption.MaxVisibleGraphemes = 0
	task.spawn(function()
		for i = 1, utf8.len(text or "") or 0 do
			if token ~= captionToken then return end
			caption.MaxVisibleGraphemes = i
			task.wait(0.028)
		end
		caption.MaxVisibleGraphemes = -1
	end)
end
local function bars(on)
	local info = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(topBar, info, {Position = on and UDim2.new() or UDim2.new(0, 0, -0.11, 0)}):Play()
	TweenService:Create(botBar, info, {Position = on and UDim2.new(0, 0, 0.85, 0) or UDim2.new(0, 0, 1, 0)}):Play()
end
local function fadeTo(alpha, t) TweenService:Create(fade, TweenInfo.new(t or 0.8), {BackgroundTransparency = alpha}):Play() end
local function showTitle(on)
	local info = TweenInfo.new(0.8)
	for _, o in {title, subtitle} do TweenService:Create(o, info, {TextTransparency = on and 0 or 1}):Play() end
	for _, o in {titleStroke, subStroke} do TweenService:Create(o, info, {Transparency = on and 0 or 1}):Play() end
end

---------------------------------------------------------------- avatars assis par terre : poses + animations procédurales
local JOINTS = {"Neck", "Waist", "Root", "LeftShoulder", "RightShoulder", "LeftElbow", "RightElbow", "LeftWrist", "RightWrist",
	"LeftHip", "RightHip", "LeftKnee", "RightKnee", "LeftAnkle", "RightAnkle"}
local FLOOR_SIT = {LeftHip = {82, 0, -34}, RightHip = {82, 0, 34}, LeftKnee = {-122, 0, 0}, RightKnee = {-122, 0, 0}, LeftAnkle = {18, 0, 0}, RightAnkle = {18, 0, 0}}
local function sit(extra)
	local p = table.clone(FLOOR_SIT)
	for k, v in extra do p[k] = v end
	return p
end
local POSES = {
	Rest = sit({RightShoulder = {36, 0, -6}, RightElbow = {74, 0, 0}, LeftShoulder = {26, 0, 8}, LeftElbow = {42, 0, 0}, Waist = {-4, 0, 0}}),
	Talk = sit({RightShoulder = {36, 0, -6}, RightElbow = {74, 0, 0}, LeftShoulder = {52, 0, 22}, LeftElbow = {68, 0, 0}, Waist = {-6, 0, 0}}),
	Drink = sit({RightShoulder = {94, 0, 14}, RightElbow = {120, 0, 0}, RightWrist = {-10, 0, 0}, LeftShoulder = {26, 0, 8}, LeftElbow = {42, 0, 0}, Neck = {24, 0, 0}, Waist = {8, 0, 0}}),
	Toast = sit({RightShoulder = {138, 0, -12}, RightElbow = {28, 0, 0}, LeftShoulder = {40, 0, 10}, LeftElbow = {50, 0, 0}, Neck = {10, 0, 0}, Waist = {4, 0, 0}}),
}

local function convertJoints(rig) -- avatars récents : AnimationConstraint -> Motor6D (sinon impossible de les animer)
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

local function makeActor(rig)
	convertJoints(rig)
	local a = {Rig = rig, Root = rig:WaitForChild("HumanoidRootPart"), Head = rig:FindFirstChild("Head"), Upper = rig:FindFirstChild("UpperTorso"),
		Joints = {}, Angles = {}, Target = POSES.Rest, Speed = 6, Look = nil, LookW = 0, Talking = false, Nod = 0, Seed = math.random() * 40}
	for _, d in rig:GetDescendants() do
		if d:IsA("Motor6D") and table.find(JOINTS, d.Name) then
			a.Joints[d.Name] = {Motor = d, Base = d.C0}
			a.Angles[d.Name] = Vector3.zero
		end
	end
	a.Root.Anchored = true
	local humanoid = rig:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None -- pas de pseudo au-dessus de la tête
		pcall(function() humanoid.EvaluateStateMachine = false end)
	end
	return a
end
local function setPose(a, name, speed) if a then a.Target = POSES[name] or POSES.Rest a.Speed = speed or 6 end end
local function snapPose(a)
	for name in a.Joints do
		local t = a.Target[name]
		a.Angles[name] = t and Vector3.new(t[1], t[2], t[3]) or Vector3.zero
	end
end

-- angles pour que la tête regarde l'autre droit dans les yeux
local function lookAngles(a)
	if not a.Look or not a.Head or not a.Upper then return 0, 0 end
	local target = typeof(a.Look) == "Instance" and a.Look.Position or a.Look
	local dir = a.Upper.CFrame:VectorToObjectSpace((target - a.Head.Position).Unit)
	return clamp(math.deg(math.asin(clamp(dir.Y, -1, 1))), -35, 35), clamp(math.deg(math.atan2(-dir.X, -dir.Z)), -80, 80)
end

local function updateActor(a, dt, t)
	local blend = math.min(1, dt * a.Speed)
	a.LookW += ((a.Look and 1 or 0) - a.LookW) * math.min(1, dt * 5)
	local lp, ly = lookAngles(a)
	a.Nod = math.max(0, a.Nod - dt)
	local breathe = sin(t * 1.5 + a.Seed)
	for name, j in a.Joints do
		local target = a.Target[name]
		local goal = target and Vector3.new(target[1], target[2], target[3]) or Vector3.zero
		local current = a.Angles[name]:Lerp(goal, blend)
		a.Angles[name] = current
		local x, y, z = 0, 0, 0
		-- respiration
		if name == "Waist" then x += breathe * 1.2 end
		if name == "LeftShoulder" or name == "RightShoulder" then z += (name == "LeftShoulder" and -1 or 1) * breathe * 0.6 end
		-- il parle : la main gauche accompagne la phrase, petits hochements de tête
		if a.Talking then
			if name == "LeftShoulder" then x += sin(t * 5.3 + a.Seed) * 9 y += sin(t * 3.1 + a.Seed) * 14
			elseif name == "LeftElbow" then x += sin(t * 6.1 + a.Seed) * 14
			elseif name == "LeftWrist" then z += sin(t * 7 + a.Seed) * 12
			elseif name == "Neck" then x += sin(t * 8.5) * 3 y += sin(t * 2.3) * 3
			elseif name == "Waist" then y += sin(t * 2.1 + a.Seed) * 3 end
		end
		-- il acquiesce (oui de la tête)
		if a.Nod > 0 and name == "Neck" then x += sin(a.Nod * 14) * 13 * math.min(1, a.Nod) end
		-- la tête (et un peu le buste) se tourne vers celui à qui il parle / qu'il écoute
		if a.LookW > 0.01 then
			if name == "Neck" then x += lp * a.LookW * 0.8 y += ly * a.LookW * 0.75
			elseif name == "Waist" then y += ly * a.LookW * 0.3 end
		end
		local v = current + Vector3.new(x, y, z)
		j.Motor.C0 = j.Base * CFrame.Angles(rad(v.X), rad(v.Y), rad(v.Z))
	end
end

---------------------------------------------------------------- verre d'eau réaliste
local UPRIGHT = CFrame.Angles(0, 0, math.pi / 2) -- un cylindre Roblox est couché sur X : on le met debout
local function gpart(model, name, size, color, props)
	local p = new("Part", {Name = name, Size = size, Color = color, Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false,
		Shape = Enum.PartType.Cylinder, TopSurface = Enum.SurfaceType.Smooth, BottomSurface = Enum.SurfaceType.Smooth}, model)
	for k, v in props or {} do p[k] = v end
	return p
end
local function makeGlass()
	local m = new("Model", {Name = "WaterGlass"})
	local g = {Model = m, Level = 0.62, Tilt = 0, TiltGoal = 0, Parts = {}}
	-- verre : paroi fine transparente, fond épais, bord brillant
	table.insert(g.Parts, {gpart(m, "Wall", Vector3.new(0.9, 0.56, 0.56), rgb(225, 240, 255), {Material = Enum.Material.Glass, Transparency = 0.62, Reflectance = 0.25}), 0.45})
	table.insert(g.Parts, {gpart(m, "Bottom", Vector3.new(0.1, 0.5, 0.5), rgb(210, 235, 255), {Material = Enum.Material.Glass, Transparency = 0.35, Reflectance = 0.3}), 0.05})
	table.insert(g.Parts, {gpart(m, "Rim", Vector3.new(0.03, 0.58, 0.58), rgb(255, 255, 255), {Material = Enum.Material.Glass, Transparency = 0.3, Reflectance = 0.4}), 0.9})
	g.Water = gpart(m, "Water", Vector3.new(g.Level, 0.48, 0.48), rgb(110, 185, 255), {Material = Enum.Material.Glass, Transparency = 0.3, Reflectance = 0.15})
	g.Surface = gpart(m, "Surface", Vector3.new(0.02, 0.47, 0.47), rgb(190, 230, 255), {Material = Enum.Material.Neon, Transparency = 0.55})
	return g
end
local function placeGlass(g, cf) -- cf = base du verre (debout)
	for _, entry in g.Parts do entry[1].CFrame = cf * CFrame.new(0, entry[2], 0) * UPRIGHT end
	g.Water.Size = Vector3.new(math.max(0.02, g.Level), 0.48, 0.48)
	g.Water.CFrame = cf * CFrame.new(0, 0.1 + g.Level / 2, 0) * UPRIGHT
	g.Surface.CFrame = cf * CFrame.new(0, 0.1 + g.Level, 0) * UPRIGHT
	g.Surface.Transparency = g.Level > 0.03 and 0.55 or 1
end

---------------------------------------------------------------- la cutscene
local playing = false
local function run()
	if playing then return end
	local rigs = folder:FindFirstChild("Rigs")
	if not rigs then return end
	playing = true
	local camera = workspace.CurrentCamera

	-- cache l'interface du jeu, bloque le joueur
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
	if hum and not controls then hum.WalkSpeed = 0 hum.JumpPower = 0 end
	local oldFov = camera.FieldOfView

	gui.Enabled = true
	fade.BackgroundTransparency = 0
	caption.Text = ""

	-- sol de la safe zone
	local scene = new("Model", {Name = "SafeCutsceneSet"}, workspace)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local ignore = {scene}
	for _, p in Players:GetPlayers() do if p.Character then table.insert(ignore, p.Character) end end
	params.FilterDescendantsInstances = ignore
	local hit = workspace:Raycast(CENTER + Vector3.new(0, 60, 0), Vector3.new(0, -120, 0), params)
	local floorY = hit and hit.Position.Y or CENTER.Y
	local C = Vector3.new(CENTER.X, floorY, CENTER.Z)

	pcall(function() ContentProvider:PreloadAsync(rigs:GetChildren()) end)
	local actors = {}
	-- assis en cercle, face au centre : Nono, kinoshi, rexy
	local function spawn(name, angle)
		local template = rigs:FindFirstChild(name)
		if not template then return nil end
		local rig = template:Clone()
		rig.Parent = scene
		local a = makeActor(rig)
		local pos = C + Vector3.new(cos(rad(angle)), 0, sin(rad(angle))) * 2.7
		local face = CFrame.lookAt(pos, Vector3.new(C.X, pos.Y, C.Z))
		rig:PivotTo(face + Vector3.new(0, 3, 0))
		local hip = a.Joints.LeftHip
		local lower = rig:FindFirstChild("LowerTorso")
		local hipY = (lower and hip) and ((lower.CFrame * hip.Base).Position.Y - a.Root.Position.Y) or -1
		rig:PivotTo(face + Vector3.new(0, floorY + 0.55 - hipY - pos.Y, 0))
		setPose(a, "Rest")
		snapPose(a)
		a.Glass = makeGlass()
		a.Glass.Model.Parent = scene
		table.insert(actors, a)
		return a
	end
	local N = spawn("Nono275er", 90)
	local K = spawn("kinoshi112", 210)
	local R = spawn("rexydev1", 330)

	local function glassCF(a)
		local hand = a.Rig:FindFirstChild("RightHand")
		if not hand then return a.Root.CFrame end
		return CFrame.new(hand.Position) * a.Root.CFrame.Rotation * CFrame.new(0.05, -0.05, -0.2) * CFrame.Angles(rad(a.Glass.Tilt), 0, 0) * CFrame.new(0, -0.3, 0)
	end

	-- caméra
	camera.CameraType = Enum.CameraType.Scriptable
	local camFn
	local function shot(fromPos, fromLook, toPos, toLook, duration, fov)
		local s = os.clock()
		camFn = function()
			local u = smooth((os.clock() - s) / duration)
			return CFrame.lookAt(fromPos:Lerp(toPos, u), fromLook:Lerp(toLook, u)), fov
		end
	end
	-- plan par-dessus l'épaule de celui qui écoute, cadré sur le visage de celui qui parle
	local function overShoulder(speaker, listener, duration)
		if not speaker or not listener or not speaker.Head or not listener.Head then return end
		local sh, lh = speaker.Head.Position, listener.Head.Position
		local back = (lh - sh) * Vector3.new(1, 0, 1)
		back = back.Magnitude > 0 and back.Unit or Vector3.xAxis
		local side = back:Cross(Vector3.yAxis)
		local p1 = lh + back * 2.4 + side * 1.1 + Vector3.new(0, 0.5, 0)
		local p2 = lh + back * 1.9 + side * 0.9 + Vector3.new(0, 0.4, 0)
		shot(p1, sh, p2, sh + Vector3.new(0, 0.05, 0), duration, 50)
	end
	local function closeUp(a, duration)
		if not a or not a.Head then return end
		local fwd = a.Root.CFrame.LookVector
		local h = a.Head.Position
		local side = fwd:Cross(Vector3.yAxis)
		shot(h + fwd * 4 + side * 1.2 + Vector3.new(0, 0.2, 0), h - Vector3.new(0, 0.5, 0), h + fwd * 3.2 + side * 0.9, h - Vector3.new(0, 0.4, 0), duration, 45)
	end

	local t0 = os.clock()
	local conn = RunService.RenderStepped:Connect(function(dt)
		local t = os.clock() - t0
		for _, a in actors do
			updateActor(a, dt, t)
			local g = a.Glass
			g.Tilt += (g.TiltGoal - g.Tilt) * math.min(1, dt * 5)
			placeGlass(g, glassCF(a))
		end
		if camFn then
			local cf, fov = camFn()
			local hand = CFrame.Angles(rad(math.noise(t * 0.4, 1.3) * 0.8), rad(math.noise(t * 0.35, 7.1) * 0.8), 0)
			camera.CFrame = cf * hand
			camera.FieldOfView += ((fov or 60) - camera.FieldOfView) * math.min(1, dt * 3)
		end
	end)
	local function waitT(T) while os.clock() - t0 < T do RunService.RenderStepped:Wait() end end

	-- boire une gorgée : le bras monte le verre à la bouche, la tête part en arrière, le niveau d'eau baisse
	local function drink(a, amount)
		if not a then return end
		local look = a.Look
		a.Look = nil
		a.Talking = false
		setPose(a, "Drink", 4.5)
		task.wait(0.45)
		a.Glass.TiltGoal = 62
		local s = os.clock()
		local start = a.Glass.Level
		while os.clock() - s < 1.1 do
			a.Glass.Level = start - (amount or 0.14) * smooth((os.clock() - s) / 1.1)
			RunService.RenderStepped:Wait()
		end
		a.Glass.TiltGoal = 0
		setPose(a, "Rest", 4)
		task.wait(0.35)
		a.Look = look
	end
	-- une réplique : celui qui parle regarde celui à qui il s'adresse, les autres le regardent
	local function line(speaker, to, text, color)
		for _, a in actors do
			a.Talking = false
			if a ~= speaker then a.Look = speaker and speaker.Head end
			if a ~= speaker and a.Target == POSES.Talk then setPose(a, "Rest", 5) end
		end
		if speaker then
			speaker.Look = to and to.Head
			speaker.Talking = true
			setPose(speaker, "Talk", 5)
		end
		say(text, color)
	end
	local ORANGE, WHITE = rgb(255, 170, 70), rgb(255, 255, 255)

	local ok, err = pcall(function()
		-------------------------------------------- 0 s : plan large, ils boivent tranquillement
		bars(true)
		local orbit = os.clock()
		camFn = function()
			local u = (os.clock() - orbit) * 0.12
			local p = C + Vector3.new(cos(u + 0.6) * 13, 5.5, sin(u + 0.6) * 13)
			return CFrame.lookAt(p, C + Vector3.new(0, 1.2, 0)), 55
		end
		fadeTo(1, 1.4)
		for _, a in actors do a.Look = nil end
		if K and N then K.Look = N.Head end
		if N and R then N.Look = R.Head end
		if R and K then R.Look = K.Head end
		say("Safe zone, fin de journée...", rgb(200, 200, 200))
		task.delay(1.6, drink, R, 0.1)

		-------------------------------------------- 3.5 s : Nono lance l'idée
		waitT(3.6)
		overShoulder(N, K, 3.6)
		line(N, K, "Les gars... et si on faisait une update Halloween ?", WHITE)
		waitT(5.6)
		if N and R then N.Look = R.Head end

		-------------------------------------------- 7.3 s : kinoshi boit puis répond
		waitT(7.3)
		closeUp(K, 3.6)
		say("")
		for _, a in actors do a.Talking = false end
		drink(K, 0.16)
		line(K, N, "Une update Halloween... avec une nouvelle zone ?", WHITE)

		-------------------------------------------- 12 s : rexy s'enflamme
		waitT(12.4)
		overShoulder(R, N, 4)
		line(R, K, "Ouais ! Une zone hantée, avec des citrouilles partout et des tombes !", ORANGE)
		waitT(14.4)
		if R and N then R.Look = N.Head end

		-------------------------------------------- 16.5 s : Nono boit et ajoute les œufs
		waitT(16.6)
		closeUp(N, 4.2)
		say("")
		for _, a in actors do a.Talking = false end
		drink(N, 0.14)
		line(N, R, "Et des œufs Halloween exclusifs... les joueurs vont adorer.", WHITE)
		waitT(19.8)
		if N and K then N.Look = K.Head end

		-------------------------------------------- 21.5 s : ils se mettent d'accord
		waitT(21.5)
		overShoulder(K, R, 3.2)
		line(K, R, "Franchement... c'est une super idée.", WHITE)
		if R then R.Nod = 1.2 end
		waitT(24.7)
		overShoulder(R, N, 3)
		line(R, N, "Alors... c'est d'accord ?", ORANGE)
		waitT(27.4)

		-------------------------------------------- 27.5 s : D'ACCORD ! ils lèvent leurs verres
		shot(C + Vector3.new(6, 1.6, 6), C + Vector3.new(0, 1.4, 0), C + Vector3.new(4.5, 1.2, 4.5), C + Vector3.new(0, 1.6, 0), 3.5, 60)
		for _, a in actors do
			a.Talking = false
			a.Look = C + Vector3.new(0, 2.2, 0)
			a.Nod = 1.2
			setPose(a, "Toast", 5)
		end
		say("D'ACCORD !!!", ORANGE)
		waitT(29.6)
		-- et ils boivent tous ensemble
		for _, a in actors do task.spawn(drink, a, 0.2) end
		waitT(31.2)

		-------------------------------------------- 31.5 s : la caméra s'envole, titre
		shot(C + Vector3.new(4.5, 2, 4.5), C + Vector3.new(0, 1, 0), C + Vector3.new(16, 22, 16), C, 4.5, 62)
		say("")
		showTitle(true)
		waitT(35.5)
		showTitle(false)
		fadeTo(0, 0.9)
		waitT(36.6)
	end)
	if not ok then warn("[SafeCutscene] " .. tostring(err)) end

	-- on remet tout comme avant
	conn:Disconnect()
	scene:Destroy()
	bars(false)
	caption.Text = ""
	title.TextTransparency, subtitle.TextTransparency = 1, 1
	titleStroke.Transparency, subStroke.Transparency = 1, 1
	camera.CameraType = Enum.CameraType.Custom
	camera.FieldOfView = oldFov
	local c = player.Character
	if c then camera.CameraSubject = c:FindFirstChildOfClass("Humanoid") end
	for _, g in hidden do if g.Parent then g.Enabled = true end end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
	if controls then pcall(function() controls:Enable() end) end
	if hum and not controls then hum.WalkSpeed = oldSpeed or 16 hum.JumpPower = oldJump or 50 end
	fadeTo(1, 0.8)
	task.wait(0.85)
	gui.Enabled = false
	playing = false
end

playRemote.OnClientEvent:Connect(function(startAt, which)
	if which ~= "safe" or type(startAt) ~= "number" then return end
	local delay = startAt - workspace:GetServerTimeNow()
	if delay < -2 then return end
	task.wait(math.max(0, delay))
	if not CutsceneLock.take("Safe", 240) then return end
	pcall(run)
	CutsceneLock.release("Safe")
end)
