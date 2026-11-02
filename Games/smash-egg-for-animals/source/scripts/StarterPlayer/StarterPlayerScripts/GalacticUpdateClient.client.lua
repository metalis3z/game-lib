-- Update GALACTIC : quand un admin la sort (panneau admin, onglet Galactic), dans TOUS les serveurs, chaque joueur déjà en jeu
-- voit tout de suite un showcase en cinématique :
--   1. la nouvelle zone Galaxy (on entre par sa porte, puis on glisse au ras des œufs), son gardien Zorvex en contre-plongée ;
--   2. les deux nouveaux marteaux (cartes avec le marteau en 3D qui tourne) ;
--   3. le nouveau tapis Galactic, posé dans le ciel au-dessus de la zone (copie locale, juste pour le montrer : il disparaît) ;
--   4. final : feu d'artifice au-dessus de la zone et grand titre "GALACTIC UPDATE!" ; l'annonce globale tombe à ce moment-là
--      (GalacticUpdateServer). Puis retour au jeu.
-- Le personnage ne bouge pas (commandes coupées le temps du film) ; le décor filmé est chargé même si on est loin (CutsceneLock).
-- Ceux qui arrivent plus tard n'ont rien : l'update est simplement là.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock"))
local HammerConfig = require(ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("HammerConfig"))
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
local hammerModels = ReplicatedStorage.HammerSystem:WaitForChild("Models")

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
local CYAN, PINK, VIOLET, GOLD = rgb(80, 220, 255), rgb(255, 120, 235), rgb(150, 90, 255), rgb(255, 210, 90)
local GALAXY = ColorSequence.new({ColorSequenceKeypoint.new(0, VIOLET), ColorSequenceKeypoint.new(0.3, CYAN), ColorSequenceKeypoint.new(0.5, WHITE),
	ColorSequenceKeypoint.new(0.7, PINK), ColorSequenceKeypoint.new(1, VIOLET)})
local ZONE_CENTER = Vector3.new(3893.6, 0.13, -167.8) -- (centre de la zone Galaxy, carte agrandie x0,2)
local SHOWCASE_SPOT = CFrame.new(3893.6, 95, -167.8) * CFrame.Angles(0, math.rad(-90), 0) -- dans le ciel, au-dessus de la zone
local BOOM = "rbxassetid://83996729056576" -- explosion de feu d'artifice

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function smooth(u) u = math.clamp(u, 0, 1) return u * u * (3 - 2 * u) end
local function tween(o, t, props, style, dir) local tw = TweenService:Create(o, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props) tw:Play() return tw end
local function label(parent, text, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = text, FontFace = FONT, TextScaled = true, TextColor3 = WHITE}, parent)
	for k, v in props or {} do l[k] = v end
	new("UIStroke", {Thickness = 3, Color = BLACK}, l)
	return l
end

---------------------------------------------------------------- écran de la cinématique
local gui, fade, top, bottom, caption
local rainOn = false
local shines = {} -- dégradés galaxie qui défilent
local function buildGui()
	table.clear(shines)
	gui = new("ScreenGui", {Name = "GalacticUpdateGui", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000}, player:WaitForChild("PlayerGui"))
	top = new("Frame", {BackgroundColor3 = BLACK, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0), ZIndex = 5}, gui)
	bottom = new("Frame", {BackgroundColor3 = BLACK, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), ZIndex = 5}, gui)
	fade = new("Frame", {BackgroundColor3 = rgb(8, 4, 24), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 20}, gui)
	-- légende en bas à gauche : petit sur-titre + grand titre au dégradé galaxie (un CanvasGroup : il s'efface d'un bloc)
	caption = new("CanvasGroup", {BackgroundTransparency = 1, GroupTransparency = 1, Visible = false, Position = UDim2.new(0.05, 0, 0.7, 0), Size = UDim2.fromScale(0.6, 0.17), ZIndex = 6}, gui)
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
local captionToken = 0
local function say(kicker, title)
	captionToken += 1
	caption.Kicker.Text, caption.Title.Text = kicker, title
	local home = caption:GetAttribute("Home")
	caption.Visible = true
	caption.Position = home - UDim2.fromScale(0.2, 0)
	caption.GroupTransparency = 1
	tween(caption, 0.5, {GroupTransparency = 0})
	tween(caption, 0.6, {Position = home}, Enum.EasingStyle.Back)
end
local function unsay()
	captionToken += 1
	local token = captionToken
	tween(caption, 0.35, {GroupTransparency = 1})
	task.delay(0.4, function() if captionToken == token then caption.Visible = false end end)
end
-- pluie de petits losanges lumineux
local function rain(seconds)
	rainOn = true
	task.spawn(function()
		local stop = os.clock() + seconds
		while rainOn and os.clock() < stop and gui.Parent do
			local size = math.random(12, 30)
			local color = ({CYAN, PINK, VIOLET, WHITE, GOLD})[math.random(5)]
			local s = new("Frame", {BackgroundColor3 = WHITE, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(math.random(), 0, 0, -40),
				Size = UDim2.fromOffset(size, size), Rotation = 45, ZIndex = 8}, gui)
			new("UIGradient", {Rotation = 90, Color = ColorSequence.new(WHITE, color)}, s)
			new("UIStroke", {Thickness = 2, Color = BLACK}, s)
			tween(s, math.random(18, 30) / 10, {Position = s.Position + UDim2.fromScale(math.random(-10, 10) / 100, 1.15), Rotation = 45 + math.random(-260, 260)}, Enum.EasingStyle.Linear)
			Debris:AddItem(s, 3.2)
			task.wait(0.05)
		end
	end)
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
local shotId = 0
local function shot(seconds, fn)
	shotId += 1
	local id = shotId
	local start = os.clock()
	repeat
		if id ~= shotId then return end -- un autre plan a pris la main
		camCF = fn(math.clamp((os.clock() - start) / seconds, 0, 1))
		RunService.RenderStepped:Wait()
	until os.clock() - start >= seconds
end
local function cut(seconds) -- court fondu au noir entre deux plans
	tween(fade, seconds or 0.2, {BackgroundTransparency = 0})
	task.wait(seconds or 0.2)
end
local function uncut(seconds) tween(fade, seconds or 0.3, {BackgroundTransparency = 1}) end

---------------------------------------------------------------- plan des marteaux : deux cartes, le marteau en 3D qui tourne
local function hammerCards(seconds)
	local list = {}
	for index, info in HammerConfig.Tiers do if info.Rarity == "Galactic" then table.insert(list, {Index = index, Info = info}) end end
	local overlay = new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3}, gui)
	new("UIGradient", {Rotation = 35, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(20, 12, 60)), ColorSequenceKeypoint.new(0.5, rgb(60, 30, 140)), ColorSequenceKeypoint.new(1, rgb(10, 40, 90))})}, overlay)
	tween(overlay, 0.5, {BackgroundTransparency = 0.2})
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
		if scale then tween(scale, 0.4, {Scale = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.In) end
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
	-- tout s'efface dans un éclair
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

---------------------------------------------------------------- feu d'artifice (local)
local function emitter(parent, texture, colors, count, speed, size, life)
	local e = new("ParticleEmitter", {Texture = texture, Rate = 0, LightEmission = 1, LightInfluence = 0, Drag = 2.2, Acceleration = Vector3.new(0, -9, 0),
		Speed = NumberRange.new(speed[1], speed[2]), SpreadAngle = Vector2.new(180, 180), Lifetime = NumberRange.new(life[1], life[2]),
		Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-200, 200), Color = colors,
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size), NumberSequenceKeypoint.new(0.7, size * 0.7), NumberSequenceKeypoint.new(1, 0)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.1), NumberSequenceKeypoint.new(1, 1)})}, parent)
	e:Emit(count)
end
local function firework(from, apex, color)
	local rocket = new("Part", {Shape = Enum.PartType.Ball, Size = Vector3.one * 1.1, Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
		Material = Enum.Material.Neon, Color = color, CFrame = CFrame.new(from)}, workspace)
	local a0 = new("Attachment", {Position = Vector3.new(0, 0.4, 0)}, rocket)
	local a1 = new("Attachment", {Position = Vector3.new(0, -0.4, 0)}, rocket)
	new("Trail", {Attachment0 = a0, Attachment1 = a1, Lifetime = 0.5, LightEmission = 1, FaceCamera = true, Color = ColorSequence.new(WHITE, color),
		Transparency = NumberSequence.new(0, 1), WidthScale = NumberSequence.new(1, 0)}, rocket)
	tween(rocket, 0.9, {CFrame = CFrame.new(apex)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	task.delay(0.9, function()
		rocket.Transparency = 1
		local burst = new("Attachment", {}, rocket)
		local colors = ColorSequence.new(color:Lerp(WHITE, 0.5), color)
		emitter(burst, SpeedConfig.FxTextures.Flare, colors, 120, {34, 54}, 2.6, {1.2, 2})
		emitter(burst, SpeedConfig.FxTextures.Star, ColorSequence.new(WHITE, color), 40, {20, 36}, 3.6, {1.3, 2.1})
		emitter(burst, SpeedConfig.FxTextures.Glow, ColorSequence.new(color), 1, {0, 0}, 40, {0.35, 0.45})
		local light = new("PointLight", {Color = color, Range = 60, Brightness = 8, Shadows = false}, rocket)
		tween(light, 1.2, {Brightness = 0})
		local boom = new("Sound", {SoundId = BOOM, Volume = 0.9, PlaybackSpeed = 0.9 + math.random() * 0.25, RollOffMinDistance = 60, RollOffMaxDistance = 600}, rocket)
		boom:Play()
		Debris:AddItem(rocket, 3)
	end)
end
local function fireworkShow(seconds)
	task.spawn(function()
		local stop = os.clock() + seconds
		while os.clock() < stop and gui.Parent do
			local x, z = math.random(3815, 4089), math.random(-225, -110)
			firework(Vector3.new(x, 2, z), Vector3.new(x + math.random(-12, 12), math.random(55, 100), z + math.random(-12, 12)), ({CYAN, PINK, VIOLET, GOLD, WHITE})[math.random(5)])
			task.wait(0.15 + math.random() * 0.2)
		end
	end)
end
-- grand titre au milieu (le final)
local function bigTitle(text, sub, seconds)
	local holder = new("CanvasGroup", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.38), Size = UDim2.fromScale(0.8, 0.28), ZIndex = 9}, gui)
	local scale = new("UIScale", {Scale = 0.2}, holder)
	local title = label(holder, text, {Size = UDim2.fromScale(1, 0.66), ZIndex = 9})
	title.UIStroke.Thickness = 5
	table.insert(shines, new("UIGradient", {Color = GALAXY}, title))
	label(holder, sub, {Position = UDim2.fromScale(0.08, 0.68), Size = UDim2.fromScale(0.84, 0.3), ZIndex = 9})
	tween(scale, 0.7, {Scale = 1}, Enum.EasingStyle.Back)
	task.wait(seconds)
	tween(holder, 0.6, {GroupTransparency = 1})
	tween(scale, 0.6, {Scale = 1.3})
	task.delay(0.7, function() holder:Destroy() end)
end

---------------------------------------------------------------- la séquence
local playing = false
local hidden = {} -- écrans cachés pendant la cinématique
-- le personnage reste exactement où il est pendant le film (comme dans les autres cinématiques) : figé sur place, jamais déplacé
local frozenRoot
local function freeze(on)
	if on then
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if root and not root.Anchored then
			root.AssemblyLinearVelocity = Vector3.zero
			root.Anchored = true
			frozenRoot = root
		end
	elseif frozenRoot then
		if frozenRoot.Parent then frozenRoot.Anchored = false end
		frozenRoot = nil
	end
end
local function restore(oldFov)
	shotId += 1
	RunService:UnbindFromRenderStep("GalacticShowcaseCam")
	camera.CameraType = Enum.CameraType.Custom
	if oldFov then camera.FieldOfView = oldFov end
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then camera.CameraSubject = humanoid end
	freeze(false)
	for _, g in hidden do if g.Parent then g.Enabled = true end end
	table.clear(hidden)
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
	CutsceneLock.release("GalacticShowcase")
end

local function showcase()
	if playing then return end
	playing = true
	-- une seule cinématique à la fois : on attend que l'autre (ou l'arène du boss) soit finie
	local waited = 0
	while not CutsceneLock.take("GalacticShowcase", 90) do
		waited += task.wait(0.5)
		if waited >= 150 then playing = false return end -- (la cinématique d'arrivée peut durer un moment)
	end
	buildGui()
	local shineConnection = RunService.RenderStepped:Connect(function()
		local offset = Vector2.new((os.clock() * 0.6) % 2 - 1, 0)
		for _, g in shines do g.Offset = offset end
	end)
	table.clear(hidden)
	for _, g in player.PlayerGui:GetChildren() do
		if g:IsA("ScreenGui") and g ~= gui and g.Enabled then g.Enabled = false table.insert(hidden, g) end
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)
	freeze(true)
	local oldFov = camera.FieldOfView
	fade.BackgroundTransparency = 0
	bars(true)
	-- la zone est chargée avant le premier plan (même depuis l'autre bout de la carte)
	CutsceneLock.focus(Vector3.new(3769, 40, -167.8), 2.5)
	bindCamera()

	-- 1a. on arrive par la porte de la zone, en montant : toute la zone se découvre
	camFov = 58
	uncut(0.6)
	say("NEW ZONE", "GALAXY ZONE")
	shot(5.5, function(u)
		local s = smooth(u)
		local eye = Vector3.new(3586 + 107 * s, 18 + 52 * s, -167.8 + 20 * s)
		return CFrame.lookAt(eye, Vector3.new(3906 + 46 * s, 6 - 4 * s, -170)) * CFrame.Angles(0, 0, math.rad(-4 + 6 * s))
	end)
	-- 1b. au ras des œufs, en travelling latéral
	cut(0.2)
	camFov = 52
	uncut(0.25)
	shot(4.8, function(u)
		local s = smooth(u)
		local x = 3739 + 228 * s
		return CFrame.lookAt(Vector3.new(x, 11 + 2 * s, -112), Vector3.new(x + 28, 3, -185))
	end)
	unsay()
	-- 1c. le gardien Zorvex, en contre-plongée, la caméra avance vers lui
	local boss = workspace:FindFirstChild("ZORVEX") or workspace:WaitForChild("ZORVEX", 2)
	if boss then
		cut(0.2)
		camFov = 50
		uncut(0.25)
		say("NEW GUARDIAN", "ZORVEX")
		shot(5, function(u)
			local pivot = boss.Parent and boss:GetPivot() or CFrame.new(ZONE_CENTER)
			local front = -pivot.LookVector -- (les gardiens regardent vers +Z)
			front = Vector3.new(front.X, 0, front.Z).Unit
			local side = front:Cross(Vector3.yAxis)
			local s = smooth(u)
			local eye = pivot.Position + front * (40 - 14 * s) + side * (14 - 22 * s) + Vector3.new(0, 3 + 2 * s, 0)
			return CFrame.lookAt(eye, pivot.Position + Vector3.new(0, 15, 0))
		end)
		unsay()
	end
	-- 2. les marteaux (la caméra tourne lentement au-dessus de la zone, derrière les cartes)
	say("NEW HAMMERS", "PLANET & SUN HAMMERS")
	task.spawn(shot, 6.6, function(u)
		local s = smooth(u)
		return CFrame.lookAt(Vector3.new(3723 + 183 * s, 135, -110), ZONE_CENTER + Vector3.new(40 + 60 * s, 0, 0))
	end)
	hammerCards(6)
	unsay()
	-- 3. le tapis Galactic, dans le ciel : grue qui part de la planète, tourne autour, puis il disparaît
	local model = placeTreadmill()
	if model then
		cut(0.2)
		camFov = 55
		uncut(0.3)
		say("NEW TREADMILL", "GALACTIC TREADMILL")
		local center = (SHOWCASE_SPOT * CFrame.new(0, 3.5, 0)).Position
		shot(7, function(u)
			local s = smooth(u)
			local angle = math.rad(150) + math.rad(170) * s
			local radius = 12 + 16 * s
			local eye = center + Vector3.new(math.cos(angle) * radius, 13 - 4 * s, math.sin(angle) * radius)
			return CFrame.lookAt(eye, center + Vector3.new(0, 4 * (1 - s), 0))
		end)
		unsay()
		vanish(model)
		local last = camCF
		shot(1.2, function(u) return last * CFrame.new(0, 0, 5 * u) end)
	end
	-- 4. final : feu d'artifice au-dessus de la zone, "GALACTIC UPDATE!" (l'annonce globale tombe maintenant)
	cut(0.25)
	camFov = 70
	fireworkShow(6)
	uncut(0.4)
	rain(4.5)
	task.spawn(shot, 6, function(u)
		local s = smooth(u)
		return CFrame.lookAt(Vector3.new(3685 + 46 * s, 38 + 10 * s, -167.8 + 12 * s), Vector3.new(3952, 62 + 8 * s, -167.8))
	end)
	bigTitle("GALACTIC UPDATE!", "is now LIVE! Enjoy the new update!", 4.2)
	cut(0.6)
	-- retour au jeu
	restore(oldFov)
	bars(false)
	tween(fade, 0.6, {BackgroundTransparency = 1})
	task.wait(0.7)
	rainOn = false
	shineConnection:Disconnect()
	gui:Destroy()
	playing = false
end

ReplicatedStorage:GetAttributeChangedSignal("GalacticUpdate"):Connect(function()
	if ReplicatedStorage:GetAttribute("GalacticUpdate") ~= true then return end
	local at = ReplicatedStorage:GetAttribute("GalacticUpdateAt")
	if at and math.abs(workspace:GetServerTimeNow() - at) < 90 then
		local ok, err = pcall(showcase)
		if not ok then
			warn("[GalacticUpdateClient] " .. tostring(err))
			restore(nil)
			local leftover = player.PlayerGui:FindFirstChild("GalacticUpdateGui")
			if leftover then leftover:Destroy() end
			playing = false
		end
	end
end)
