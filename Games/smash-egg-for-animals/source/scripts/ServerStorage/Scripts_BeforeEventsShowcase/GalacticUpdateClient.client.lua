-- Update GALACTIC : quand un admin la sort (panneau admin, onglet Galactic), dans TOUS les serveurs, chaque joueur déjà en jeu voit :
--   1. l'annonce globale (GlobalAnnounceClient, envoyée par GalacticUpdateServer) et le grand titre "GALACTIC UPDATE!" ;
--   2. un showcase en cinématique : survol de la nouvelle zone Galaxy, son gardien Zorvex, les deux nouveaux marteaux (cartes avec
--      le marteau en 3D qui tourne), puis le nouveau tapis Galactic posé dans le ciel au-dessus de la zone (une copie locale,
--      juste pour le montrer : elle disparaît à la fin du plan) ;
--   3. "ENJOY THE UPDATE!" et retour au jeu.
-- Ceux qui arrivent plus tard n'ont rien : l'update est simplement là. Une seule cinématique à la fois (CutsceneLock).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock"))
local HammerConfig = require(ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("HammerConfig"))
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local hammerModels = ReplicatedStorage.HammerSystem:WaitForChild("Models")

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
local CYAN, PINK, VIOLET = rgb(80, 220, 255), rgb(255, 120, 235), rgb(150, 90, 255)
local GALAXY = ColorSequence.new({ColorSequenceKeypoint.new(0, VIOLET), ColorSequenceKeypoint.new(0.3, CYAN), ColorSequenceKeypoint.new(0.5, WHITE),
	ColorSequenceKeypoint.new(0.7, PINK), ColorSequenceKeypoint.new(1, VIOLET)})
local ZONE_CENTER = Vector3.new(2981.7, 0.13, -167.8)
local SHOWCASE_SPOT = CFrame.new(2981.7, 95, -167.8) * CFrame.Angles(0, math.rad(-90), 0) -- dans le ciel, au-dessus de la zone

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function smooth(u) u = math.clamp(u, 0, 1) return u * u * (3 - 2 * u) end
local function tween(o, t, props, style) local tw = TweenService:Create(o, TweenInfo.new(t, style or Enum.EasingStyle.Quad), props) tw:Play() return tw end
local function label(parent, text, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = text, FontFace = FONT, TextScaled = true, TextColor3 = WHITE}, parent)
	for k, v in props or {} do l[k] = v end
	new("UIStroke", {Thickness = 3, Color = BLACK}, l)
	return l
end

---------------------------------------------------------------- écran de la cinématique
local gui, fade, top, bottom, caption, rainOn
local shines = {} -- dégradés galaxie qui défilent
local function buildGui()
	gui = new("ScreenGui", {Name = "GalacticUpdateGui", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000}, player:WaitForChild("PlayerGui"))
	top = new("Frame", {BackgroundColor3 = BLACK, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0), ZIndex = 5}, gui)
	bottom = new("Frame", {BackgroundColor3 = BLACK, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), ZIndex = 5}, gui)
	fade = new("Frame", {BackgroundColor3 = rgb(10, 6, 30), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 20}, gui)
	-- légende en bas à gauche : petit sur-titre + grand titre au dégradé galaxie
	caption = new("CanvasGroup", {BackgroundTransparency = 1, GroupTransparency = 1, Position = UDim2.new(0.05, 0, 0.7, 0), Size = UDim2.fromScale(0.6, 0.17), ZIndex = 6}, gui)
	caption:SetAttribute("Home", caption.Position)
	label(caption, "", {Name = "Kicker", Size = UDim2.fromScale(1, 0.32), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = CYAN, ZIndex = 6})
	local title = label(caption, "", {Name = "Title", Position = UDim2.fromScale(0, 0.3), Size = UDim2.fromScale(1, 0.7), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6})
	title.UIStroke.Thickness = 4
	table.insert(shines, new("UIGradient", {Color = GALAXY}, title))
end
local function bars(on)
	tween(top, 0.6, {Size = UDim2.fromScale(1, on and 0.1 or 0)})
	tween(bottom, 0.6, {Size = UDim2.fromScale(1, on and 0.1 or 0)})
end
local function say(kicker, title)
	caption.Kicker.Text, caption.Title.Text = kicker, title
	local home = caption:GetAttribute("Home")
	caption:SetAttribute("Token", (caption:GetAttribute("Token") or 0) + 1)
	caption.Visible = true
	caption.Position = home - UDim2.fromScale(0.2, 0)
	caption.GroupTransparency = 1
	tween(caption, 0.5, {GroupTransparency = 0})
	tween(caption, 0.6, {Position = home}, Enum.EasingStyle.Back)
end
local function unsay()
	tween(caption, 0.35, {GroupTransparency = 1})
	local token = caption:GetAttribute("Token")
	task.delay(0.4, function() if caption:GetAttribute("Token") == token then caption.Visible = false end end) -- bien caché, même si un autre script y touche
end
-- pluie de petits losanges lumineux
local function rain(seconds)
	rainOn = true
	task.spawn(function()
		local stop = os.clock() + seconds
		while rainOn and os.clock() < stop and gui.Parent do
			local size = math.random(12, 30)
			local color = ({CYAN, PINK, VIOLET, WHITE})[math.random(4)]
			local s = new("Frame", {BackgroundColor3 = WHITE, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(math.random(), 0, 0, -40),
				Size = UDim2.fromOffset(size, size), Rotation = 45, ZIndex = 8}, gui)
			new("UIGradient", {Rotation = 90, Color = ColorSequence.new(WHITE, color)}, s)
			new("UIStroke", {Thickness = 2, Color = BLACK}, s)
			tween(s, math.random(18, 30) / 10, {Position = s.Position + UDim2.fromScale(math.random(-10, 10) / 100, 1.15), Rotation = 45 + math.random(-260, 260)}, Enum.EasingStyle.Linear)
			game:GetService("Debris"):AddItem(s, 3.2)
			task.wait(0.05)
		end
	end)
end
-- grand titre au milieu (l'ouverture et la fin)
local function bigTitle(text, sub, seconds)
	local holder = new("CanvasGroup", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.8, 0.26), ZIndex = 9}, gui)
	local scale = new("UIScale", {Scale = 0.2}, holder)
	local title = label(holder, text, {Size = UDim2.fromScale(1, 0.68), ZIndex = 9})
	title.UIStroke.Thickness = 5
	table.insert(shines, new("UIGradient", {Color = GALAXY}, title))
	local subLabel = label(holder, sub, {Position = UDim2.fromScale(0.08, 0.7), Size = UDim2.fromScale(0.84, 0.3), ZIndex = 9})
	tween(scale, 0.7, {Scale = 1}, Enum.EasingStyle.Back)
	task.wait(seconds)
	tween(holder, 0.6, {GroupTransparency = 1})
	tween(scale, 0.6, {Scale = 1.3})
	task.delay(0.7, function() holder:Destroy() end)
end

---------------------------------------------------------------- caméra
local camera = workspace.CurrentCamera
local camCF, camFov = nil, 60
local function bindCamera()
	RunService:BindToRenderStep("GalacticShowcaseCam", Enum.RenderPriority.Camera.Value + 10, function()
		camera.CameraType = Enum.CameraType.Scriptable
		if camCF then camera.CFrame = camCF end
		camera.FieldOfView = camFov
	end)
end
-- un plan : fn(u) avec u de 0 à 1 pendant "seconds" secondes, renvoie le CFrame de la caméra
local function shot(seconds, fn)
	local start = os.clock()
	repeat
		camCF = fn(math.clamp((os.clock() - start) / seconds, 0, 1))
		RunService.RenderStepped:Wait()
	until os.clock() - start >= seconds
end
local function stream(position)
	pcall(function() player:RequestStreamAroundAsync(position, 4) end)
end

---------------------------------------------------------------- plan des marteaux : deux cartes, le marteau en 3D qui tourne
local function hammerCards(seconds)
	local list = {}
	for index, info in HammerConfig.Tiers do if info.Rarity == "Galactic" then table.insert(list, {Index = index, Info = info}) end end
	local overlay = new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3}, gui)
	new("UIGradient", {Rotation = 35, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(20, 12, 60)), ColorSequenceKeypoint.new(0.5, rgb(60, 30, 140)), ColorSequenceKeypoint.new(1, rgb(10, 40, 90))})}, overlay)
	tween(overlay, 0.5, {BackgroundTransparency = 0.15})
	local row = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.42), Size = UDim2.fromScale(0.7, 0.5), ZIndex = 4}, gui)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.04, 0)}, row)
	local spinning = {}
	for i, entry in list do
		local info = entry.Info
		local card = new("Frame", {BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(0.4, 1), ZIndex = 4, LayoutOrder = i}, row)
		new("UIAspectRatioConstraint", {AspectRatio = 0.72}, card)
		new("UICorner", {CornerRadius = UDim.new(0.06, 0)}, card)
		new("UIStroke", {Thickness = 4, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new((info.Glow or CYAN):Lerp(WHITE, 0.3), (info.Head or VIOLET):Lerp(BLACK, 0.2))}, card)
		local scale = new("UIScale", {Scale = 0}, card)
		task.delay(0.25 + i * 0.35, function() tween(scale, 0.6, {Scale = 1}, Enum.EasingStyle.Back) end)
		label(card, info.Name, {Position = UDim2.fromScale(0.06, 0.04), Size = UDim2.fromScale(0.88, 0.13), ZIndex = 6})
		label(card, "Galactic", {Position = UDim2.fromScale(0.2, 0.17), Size = UDim2.fromScale(0.6, 0.08), TextColor3 = CYAN, ZIndex = 6})
		local view = new("ViewportFrame", {BackgroundTransparency = 1, Position = UDim2.fromScale(0.05, 0.25), Size = UDim2.fromScale(0.9, 0.5), ZIndex = 5,
			Ambient = rgb(220, 220, 230), LightColor = WHITE, LightDirection = Vector3.new(-1, -1, -1)}, card)
		local template = hammerModels:FindFirstChild("Tier" .. entry.Index)
		if template then
			local model = template:Clone()
			model:PivotTo(CFrame.new())
			model.Parent = view
			local cf, size = model:GetBoundingBox()
			local cam = new("Camera", {FieldOfView = 36}, view)
			cam.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0, 0.1, 1) * math.max(size.X, size.Y, size.Z) * 1.6, cf.Position)
			view.CurrentCamera = cam
			table.insert(spinning, {Model = model, Center = cf, Phase = i})
		end
		local power = string.sub(EggConfig.FormatMoney(info.Damage), 2)
		label(card, power .. " Power", {Position = UDim2.fromScale(0.08, 0.76), Size = UDim2.fromScale(0.84, 0.1), TextColor3 = rgb(120, 230, 255), ZIndex = 6})
		label(card, EggConfig.FormatMoney(info.Price), {Position = UDim2.fromScale(0.15, 0.87), Size = UDim2.fromScale(0.7, 0.09), TextColor3 = rgb(150, 255, 90), ZIndex = 6})
	end
	local connection = RunService.RenderStepped:Connect(function()
		local t = os.clock()
		for _, s in spinning do -- tourne autour de son milieu, penché
			local c = CFrame.new(s.Center.Position)
			s.Model:PivotTo(c * CFrame.Angles(0, t * 1.6 + s.Phase, 0) * CFrame.Angles(0, 0, math.rad(-25)) * c:Inverse())
		end
	end)
	task.wait(seconds)
	tween(overlay, 0.5, {BackgroundTransparency = 1})
	for _, card in row:GetChildren() do
		local scale = card:IsA("Frame") and card:FindFirstChildOfClass("UIScale")
		if scale then tween(scale, 0.4, {Scale = 0}, Enum.EasingStyle.Back) end
	end
	task.wait(0.5)
	connection:Disconnect()
	overlay:Destroy()
	row:Destroy()
end

---------------------------------------------------------------- tapis de démonstration (copie locale, disparaît à la fin)
local function placeTreadmill()
	local template = ReplicatedStorage:WaitForChild("GalacticShowcaseTreadmill", 5)
	if not template then return nil end
	local model = template:Clone()
	model.Name = "GalacticShowcaseTreadmill"
	model:PivotTo(SHOWCASE_SPOT)
	-- disque lumineux sous le tapis
	local disc = new("Part", {Name = "ShowcaseDisc", Shape = Enum.PartType.Cylinder, Size = Vector3.new(1, 26, 26), Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
		Material = Enum.Material.Plastic, Color = rgb(36, 24, 92), CFrame = SHOWCASE_SPOT * CFrame.new(0, -0.5, 0) * CFrame.Angles(0, 0, math.rad(90))}, model)
	pcall(function() disc.MaterialVariant = "Studs" end)
	new("Part", {Name = "ShowcaseRing", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.8, 28, 28), Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
		Material = Enum.Material.Neon, Color = CYAN, CFrame = disc.CFrame * CFrame.new(-0.2, 0, 0)}, model)
	new("Part", {Name = "ShowcaseGlow", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.3, 34, 34), Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
		Material = Enum.Material.Neon, Color = PINK, Transparency = 0.7, CFrame = disc.CFrame * CFrame.new(-0.4, 0, 0)}, model)
	model.Parent = workspace
	return model
end
local function vanish(model)
	-- tout s'efface dans un éclair (les étincelles restent un instant)
	local flash = new("Part", {Shape = Enum.PartType.Ball, Size = Vector3.one * 2, Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
		Material = Enum.Material.Neon, Color = rgb(220, 200, 255), Transparency = 0.1, CFrame = SHOWCASE_SPOT * CFrame.new(0, 3, 0)}, workspace)
	tween(flash, 0.9, {Size = Vector3.one * 34, Transparency = 1})
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") then tween(d, 0.7, {Transparency = 1})
		elseif d:IsA("ParticleEmitter") then d.Enabled = false
		elseif d:IsA("Decal") or d:IsA("Texture") then tween(d, 0.7, {Transparency = 1})
		elseif d:IsA("Light") then tween(d, 0.7, {Brightness = 0}) end
	end
	task.delay(1, function() model:Destroy() flash:Destroy() end)
end

---------------------------------------------------------------- la séquence
local playing = false
local hidden = {} -- écrans cachés pendant la cinématique
local function showcase()
	if playing then return end
	playing = true
	buildGui()
	local shineConnection = RunService.RenderStepped:Connect(function()
		local offset = Vector2.new((os.clock() * 0.6) % 2 - 1, 0)
		for _, g in shines do g.Offset = offset end
	end)
	-- 1. le titre, pendant que l'annonce globale s'affiche en haut
	rain(3.5)
	bigTitle("GALACTIC UPDATE!", "A whole new galaxy just opened...", 3)
	-- une seule cinématique à la fois : on attend que l'autre (ou l'arène du boss) soit finie
	local waited = 0
	while not CutsceneLock.take("GalacticShowcase", 90) and waited < 60 do waited += task.wait(0.5) end
	if waited >= 60 then
		gui:Destroy()
		shineConnection:Disconnect()
		playing = false
		return
	end
	-- 2. cinématique
	table.clear(hidden)
	for _, g in player.PlayerGui:GetChildren() do
		if g:IsA("ScreenGui") and g ~= gui and g.Enabled then g.Enabled = false table.insert(hidden, g) end
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then root.Anchored = true end
	local oldFov = camera.FieldOfView
	tween(fade, 0.4, {BackgroundTransparency = 0})
	task.wait(0.45)
	stream(ZONE_CENTER + Vector3.new(0, 20, 0))
	bindCamera()
	bars(true)
	-- a. la zone : survol du nord vers le fond
	camFov = 62
	tween(fade, 0.6, {BackgroundTransparency = 1})
	say("NEW ZONE", "GALAXY ZONE")
	shot(6.5, function(u)
		local s = smooth(u)
		local eye = Vector3.new(2805 + 290 * s, 72 - 18 * s, -100 - 10 * s)
		return CFrame.lookAt(eye, Vector3.new(2900 + 160 * s, 0, -172))
	end)
	unsay()
	-- b. le gardien
	local boss = workspace:FindFirstChild("ZORVEX") or workspace:WaitForChild("ZORVEX", 3)
	if boss then
		stream(boss:GetPivot().Position)
		say("NEW GUARDIAN", "ZORVEX")
		shot(5, function(u)
			local at = boss.Parent and boss:GetPivot().Position or ZONE_CENTER
			local angle = 0.4 + 1.1 * smooth(u)
			return CFrame.lookAt(at + Vector3.new(math.cos(angle) * 46, 22 - 6 * u, math.sin(angle) * 46), at + Vector3.new(0, 13, 0))
		end)
		unsay()
	end
	-- c. les marteaux
	say("NEW HAMMERS", "PLANET & SUN HAMMERS")
	local keep = camCF
	task.spawn(shot, 6.4, function(u) return keep * CFrame.Angles(0, -0.15 * u, 0) end)
	hammerCards(6)
	unsay()
	-- d. le tapis Galactic, dans le ciel : on tourne autour, puis il disparaît
	local model = placeTreadmill()
	if model then
		say("NEW TREADMILL", "GALACTIC TREADMILL")
		local center = (SHOWCASE_SPOT * CFrame.new(0, 3.5, 0)).Position
		shot(7, function(u)
			local angle = math.rad(130) + math.rad(200) * smooth(u)
			local radius = 30 - 6 * u
			return CFrame.lookAt(center + Vector3.new(math.cos(angle) * radius, 10 - 3 * u, math.sin(angle) * radius), center)
		end)
		unsay()
		vanish(model)
		local last = camCF
		shot(1.2, function(u) return last * CFrame.new(0, 0, 4 * u) end)
	end
	-- e. bonne update !
	tween(fade, 0.25, {BackgroundTransparency = 0})
	task.wait(0.3)
	camCF = CFrame.lookAt(Vector3.new(2860, 115, -40), ZONE_CENTER + Vector3.new(60, 0, 0))
	tween(fade, 0.35, {BackgroundTransparency = 1})
	rain(4)
	task.spawn(shot, 4.6, function(u)
		local s = smooth(u)
		return CFrame.lookAt(Vector3.new(2860 + 60 * s, 115 + 10 * s, -40 + 8 * s), ZONE_CENTER + Vector3.new(60 + 20 * s, 0, 0))
	end)
	bigTitle("ENJOY THE UPDATE!", "Go explore the Galaxy Zone!", 3.6)
	tween(fade, 0.5, {BackgroundTransparency = 0})
	task.wait(0.6)
	-- retour au jeu
	RunService:UnbindFromRenderStep("GalacticShowcaseCam")
	camera.CameraType = Enum.CameraType.Custom
	camera.FieldOfView = oldFov
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then camera.CameraSubject = humanoid end
	if root and root.Parent then root.Anchored = false end
	for _, g in hidden do if g.Parent then g.Enabled = true end end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
	bars(false)
	tween(fade, 0.6, {BackgroundTransparency = 1})
	task.wait(0.7)
	rainOn = false
	shineConnection:Disconnect()
	gui:Destroy()
	CutsceneLock.release("GalacticShowcase")
	playing = false
end

ReplicatedStorage:GetAttributeChangedSignal("GalacticUpdate"):Connect(function()
	if ReplicatedStorage:GetAttribute("GalacticUpdate") ~= true then return end
	local at = ReplicatedStorage:GetAttribute("GalacticUpdateAt")
	if at and math.abs(workspace:GetServerTimeNow() - at) < 90 then
		local ok, err = pcall(showcase)
		if not ok then
			warn("[GalacticUpdateClient] " .. tostring(err))
			for _, g in hidden do if g.Parent then g.Enabled = true end end
			pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
			local leftover = player.PlayerGui:FindFirstChild("GalacticUpdateGui")
			if leftover then leftover:Destroy() end
			playing = false
			RunService:UnbindFromRenderStep("GalacticShowcaseCam")
			camera.CameraType = Enum.CameraType.Custom
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root then root.Anchored = false end
			CutsceneLock.release("GalacticShowcase")
		end
	end
end)
