-- Effets des oeufs (pose, ouverture), balade et animations des animaux posés, minuteurs, gradients des labels
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local remotes = system:WaitForChild("Remotes")
local templates = system:WaitForChild("Pets")

local GRADIENT_TAG = "AnimatedGradient"
local GRADIENT_SPEED = 120 -- degrés / seconde
local SPARKLE_TEXTURE = "rbxasset://textures/particles/sparkles_main.dds"
local EGG_HALF_HEIGHT = 6.5

local RARITY_COLORS = {
	Common = Color3.fromRGB(235, 235, 235),
	Uncommon = Color3.fromRGB(110, 230, 120),
	Rare = Color3.fromRGB(90, 170, 255),
	Epic = Color3.fromRGB(190, 110, 255),
	Legendary = Color3.fromRGB(255, 200, 60),
	Mythic = Color3.fromRGB(255, 110, 210),
	Secret = Color3.fromRGB(255, 60, 80),
	Ancient = Color3.fromRGB(150, 220, 90),
	OG = Color3.fromRGB(255, 190, 60),
	Divine = Color3.fromRGB(255, 240, 170),
	Prismatic = Color3.fromRGB(255, 120, 220),
	Galactic = Color3.fromRGB(130, 170, 255),
	Phantom = Color3.fromRGB(110, 255, 225),
}

---------------------------------------------------------------- Gradients animés
RunService.RenderStepped:Connect(function(dt)
	for _, gradient in CollectionService:GetTagged(GRADIENT_TAG) do
		gradient.Rotation = (gradient.Rotation + GRADIENT_SPEED * dt) % 360
	end
end)

---------------------------------------------------------------- Boîte à effets (tout est local au joueur)
local fxFolder = Instance.new("Folder")
fxFolder.Name = "ClientFx"
fxFolder.Parent = workspace

local function fxPart(size, cframe)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
	part.Size = size
	part.CFrame = cframe
	part.Parent = fxFolder
	return part
end

-- couleur principale d'un effet : la mutation si elle a une couleur, sinon la rareté
local function fxColor(rarity, mutationName)
	local mutation = mutationName and Config.GetMutation(mutationName)
	if mutation and mutation.Color then return mutation.Color end
	return RARITY_COLORS[rarity] or Color3.new(1, 1, 1)
end

-- dégradé des particules : arc-en-ciel pour Rainbow, sinon blanc -> couleur
local function fxSequence(rarity, mutationName)
	local mutation = mutationName and Config.GetMutation(mutationName)
	if mutation and not mutation.Color then return Config.Gradients[mutationName] end
	return ColorSequence.new(Color3.new(1, 1, 1), fxColor(rarity, mutationName))
end

local function burst(position, sequence, count, speed, size)
	local part = fxPart(Vector3.new(0.5, 0.5, 0.5), CFrame.new(position))
	part.Transparency = 1
	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = SPARKLE_TEXTURE
	emitter.Rate = 0
	emitter.Lifetime = NumberRange.new(0.5, 1.1)
	emitter.Speed = NumberRange.new(speed * 0.5, speed)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Drag = 2
	emitter.Size = NumberSequence.new(size, 0)
	emitter.Color = sequence
	emitter.LightEmission = 0.4
	emitter.Parent = part
	emitter:Emit(count)
	Debris:AddItem(part, 2)
end

-- anneau lumineux au sol qui s'agrandit en s'effaçant
local function ring(position, color, fromSize, toSize, duration)
	local part = fxPart(Vector3.new(0.2, fromSize, fromSize), CFrame.new(position) * CFrame.Angles(0, 0, math.pi / 2))
	part.Shape = Enum.PartType.Cylinder
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Transparency = 0.55
	TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = Vector3.new(0.2, toSize, toSize), Transparency = 1}):Play()
	Debris:AddItem(part, duration + 0.1)
end

-- colonne de lumière qui s'affine en s'effaçant
local function beam(position, color, height, width, duration)
	local part = fxPart(Vector3.new(height, width, width), CFrame.new(position + Vector3.new(0, height / 2, 0)) * CFrame.Angles(0, 0, math.pi / 2))
	part.Shape = Enum.PartType.Cylinder
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Transparency = 0.65
	TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = Vector3.new(height, 0.1, 0.1), Transparency = 1}):Play()
	Debris:AddItem(part, duration + 0.1)
end

-- surbrillance qui s'efface (flash sur un modèle)
local function flash(model, color, duration)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = model
	highlight.FillColor = color
	highlight.FillTransparency = 0.5
	highlight.OutlineColor = color
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.Parent = fxFolder
	TweenService:Create(highlight, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{FillTransparency = 1, OutlineTransparency = 1}):Play()
	Debris:AddItem(highlight, duration + 0.1)
	return highlight
end

-- éclats de coquille : petits cubes projetés qui retombent
local SHARD_GRAVITY = Vector3.new(0, -60, 0)
local SHARD_LIFE = 0.9
local shards = {}

local function spawnShards(position, colors, count, power, size)
	for index = 1, count do
		local edge = size * (0.6 + math.random() * 0.8)
		local part = fxPart(Vector3.new(edge, edge, edge), CFrame.new(position) * CFrame.Angles(math.random() * 6, math.random() * 6, 0))
		part.Color = colors[index % #colors + 1]
		part.TopSurface, part.BottomSurface = Enum.SurfaceType.Studs, Enum.SurfaceType.Inlet
		table.insert(shards, {
			Part = part,
			Velocity = Vector3.new(math.random() * 2 - 1, 0.7 + math.random() * 1.2, math.random() * 2 - 1) * power,
			Spin = CFrame.Angles(math.random() * 0.4 - 0.2, math.random() * 0.4 - 0.2, math.random() * 0.4 - 0.2),
			Life = 0,
		})
	end
end

RunService.RenderStepped:Connect(function(dt)
	for index = #shards, 1, -1 do
		local shard = shards[index]
		shard.Life += dt
		if shard.Life >= SHARD_LIFE then
			shard.Part:Destroy()
			table.remove(shards, index)
		else
			shard.Velocity += SHARD_GRAVITY * dt
			shard.Part.CFrame = (shard.Part.CFrame + shard.Velocity * dt) * shard.Spin
			shard.Part.Transparency = (shard.Life / SHARD_LIFE) ^ 2
		end
	end
end)

local function sampleColors(model, max)
	local colors, seen = {}, {}
	for _, part in model:GetChildren() do
		if part:IsA("BasePart") and part.Transparency < 1 then
			local key = part.Color:ToHex()
			if not seen[key] then
				seen[key] = true
				table.insert(colors, part.Color)
				if #colors >= max then break end
			end
		end
	end
	if #colors == 0 then colors[1] = Color3.new(1, 1, 1) end
	return colors
end

local function shakeCamera(duration, strength)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	task.spawn(function()
		local t = 0
		while t < duration do
			t += RunService.RenderStepped:Wait()
			local fade = 1 - t / duration
			humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * strength * fade
		end
		humanoid.CameraOffset = Vector3.zero
	end)
end

---------------------------------------------------------------- Pose d'un oeuf : effet bien visible si l'oeuf a une mutation
local PLACE_FX_WINDOW = 3 -- on ne rejoue pas l'effet pour un oeuf posé il y a longtemps

local placedEggs = workspace:WaitForChild("PlacedEggs")

local function onEggPlaced(egg)
	local placedAt = egg:GetAttribute("PlacedAt")
	if not placedAt or workspace:GetServerTimeNow() - placedAt > PLACE_FX_WINDOW then return end
	local root = egg.PrimaryPart or egg:WaitForChild("Root", 5)
	if not root then return end
	local half = EGG_HALF_HEIGHT * egg:GetScale()
	local ground = root.Position - Vector3.new(0, half, 0)
	local mutationName = egg:GetAttribute("Mutation")

	-- petit nuage de pose pour tous les oeufs
	ring(ground + Vector3.new(0, 0.15, 0), Color3.new(1, 1, 1), half, half * 4, 0.45)
	burst(ground, ColorSequence.new(Color3.new(1, 1, 1)), 10, 6, 0.5)

	if mutationName then
		local color = fxColor(nil, mutationName)
		local sequence = fxSequence(nil, mutationName)
		flash(egg, color, 1.4)
		beam(ground, color, 18, half * 1.3, 0.9)
		ring(ground + Vector3.new(0, 0.2, 0), color, half, half * 9, 0.8)
		burst(root.Position, sequence, 28, 14, 0.8)
		task.delay(0.25, burst, root.Position + Vector3.new(0, half, 0), sequence, 10, 10, 0.6)
		if egg:GetAttribute("Owner") == player.UserId then shakeCamera(0.3, 0.5) end
	end
end

placedEggs.ChildAdded:Connect(function(egg) task.defer(onEggPlaced, egg) end)

---------------------------------------------------------------- Ouverture d'un oeuf
local CIRCLE_RADIUS = 2.5
local CIRCLE_TURNS = 2
local CIRCLE_RISE = 3
local POCKET_OFFSET = Vector3.new(0.9, -0.6, 0) -- hanche droite du personnage
local POCKET_ARC = 7       -- hauteur de la cloche avant de redescendre
local MIN_SCALE = 0.08
local GLOW_START = 0.75    -- l'oeuf devient blanc sur la fin du tremblement

local function easeOutBack(a)
	return 1 + 2.7 * (a - 1) ^ 3 + 1.7 * (a - 1) ^ 2
end

-- Clone d'animal purement visuel : tout ancré, sans soudures (pour ScaleTo / PivotTo chaque frame)
local function makeVisualPet(template, info, kg, mutation)
	local pet = template:Clone()
	Config.ApplyMutation(pet, mutation)
	for _, d in pet:GetDescendants() do
		if d:IsA("WeldConstraint") or d:IsA("Weld") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = true, false, false, false, false
		end
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "HatchLabel"
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.Size = UDim2.new(7, 0, 2.4, 0)
	local function text(txt, pos, size)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = pos, size
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.Text = txt
		label.TextScaled = true
		label.TextColor3 = Color3.new(1, 1, 1)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Thickness = 2
		stroke.Parent = label
		local gradientColor = Config.Gradients[info.Rarity]
		if gradientColor then
			local gradient = Instance.new("UIGradient")
			gradient.Color = gradientColor
			gradient.Parent = label
			CollectionService:AddTag(gradient, GRADIENT_TAG)
		end
		label.Parent = billboard
	end
	text(mutation and (mutation .. " " .. info.Name) or info.Name, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.58))
	text(kg and (info.Rarity .. "  ·  " .. Config.FormatKg(kg)) or info.Rarity, UDim2.fromScale(0, 0.6), UDim2.fromScale(1, 0.4))
	billboard.Parent = pet.PrimaryPart
	return pet, billboard
end

local activeHatches = 0 -- plusieurs oeufs peuvent s'ouvrir en même temps (Tout ouvrir)

local function playHatch(eggName, petName, egg, petKg, mutation)
	local info = Config.Pets[petName]
	local template = templates:FindFirstChild(petName)
	if not info or not template or not egg or not egg.PrimaryPart then return end
	activeHatches += 1
	ProximityPromptService.Enabled = false

	local T = Config.Hatch
	local eggPivot = egg:GetPivot()
	local half = EGG_HALF_HEIGHT * egg:GetScale()
	local eggPos = eggPivot.Position
	local ground = eggPos - Vector3.new(0, half, 0)
	local color = fxColor(info.Rarity, mutation)
	local sequence = fxSequence(info.Rarity, mutation)
	local shellColors = sampleColors(egg, 8)
	local pet, billboard

	local ok, err = pcall(function()
		-- 1) l'oeuf tremble en 3 secousses de plus en plus fortes, lâche des étincelles puis devient blanc
		local glow = Instance.new("Highlight")
		glow.Adornee = egg
		glow.FillColor = Color3.new(1, 1, 1)
		glow.FillTransparency = 1
		glow.OutlineColor = color
		glow.OutlineTransparency = 1
		glow.DepthMode = Enum.HighlightDepthMode.Occluded
		glow.Parent = fxFolder
		local light = Instance.new("PointLight")
		light.Color = color
		light.Range = 9
		light.Brightness = 0
		light.Parent = egg.PrimaryPart

		local t, lastBurst = 0, -1
		while t < T.Wobble do
			t += RunService.RenderStepped:Wait()
			local u = math.min(t / T.Wobble, 1)
			local shake = math.sin(u * math.pi * 3) ^ 2
			local roll = math.sin(t * (18 + 14 * u)) * math.rad(8 + 22 * u) * shake
			local hop = math.abs(math.sin(t * (18 + 14 * u))) * 0.15 * half * shake
			egg:PivotTo(eggPivot * CFrame.new(0, hop - half, 0) * CFrame.Angles(0, 0, roll) * CFrame.new(0, half, 0))
			light.Brightness = u * 1.5
			glow.OutlineTransparency = 1 - u
			if u > GLOW_START then glow.FillTransparency = 1 - 0.6 * (u - GLOW_START) / (1 - GLOW_START) end -- blanchit sans éblouir
			local burstIndex = math.floor(u * 3)
			if burstIndex ~= lastBurst and burstIndex < 3 then -- au début de chaque secousse
				lastBurst = burstIndex
				burst(eggPos, sequence, 4 + burstIndex * 3, 5 + burstIndex * 3, 0.45)
				spawnShards(eggPos, shellColors, 2 + burstIndex, 6 + burstIndex * 3, half * 0.14)
			end
		end
		glow:Destroy()

		-- 2) explosion de la coquille, l'animal sort en grossissant
		spawnShards(eggPos, shellColors, 10, 16, half * 0.2)
		burst(eggPos, sequence, 28, 18, 0.9)
		ring(ground + Vector3.new(0, 0.2, 0), color, half, half * 10, 0.7)
		beam(ground, color, 20, half * 1.3, 0.7)
		shakeCamera(0.25, 0.3)
		for _, part in egg:GetDescendants() do -- la coquille disparaît (le serveur supprime l'oeuf juste après)
			if part:IsA("BasePart") then part.Transparency = 1 elseif part:IsA("BillboardGui") then part.Enabled = false end
		end

		pet, billboard = makeVisualPet(template, info, petKg, mutation)
		local size = Config.SizeScale(petKg or info.Kg, info.Kg) * Config.PetSize -- plus lourd = plus gros (x1,8 : EggConfig.PetSize)
		local fullScale = pet:GetScale() * size
		local _, bounds = pet:GetBoundingBox()
		local petHalf = bounds.Y / 2 * size
		billboard.StudsOffsetWorldSpace = Vector3.new(0, petHalf + 1.8, 0)
		local function setPet(pos, yaw, scale)
			pet:ScaleTo(fullScale * math.max(scale, MIN_SCALE))
			pet:PivotTo(CFrame.new(pos) * CFrame.Angles(0, yaw, 0))
		end

		local center = eggPos + Vector3.new(0, half + petHalf + 1.5, 0)
		setPet(eggPos, 0, MIN_SCALE)
		pet.Parent = workspace
		flash(pet, Color3.new(1, 1, 1), T.Pop + 0.5)

		local trail = Instance.new("ParticleEmitter")
		trail.Texture = SPARKLE_TEXTURE
		trail.Rate = 14
		trail.Lifetime = NumberRange.new(0.4, 0.8)
		trail.Speed = NumberRange.new(0.5, 1.5)
		trail.SpreadAngle = Vector2.new(180, 180)
		trail.Size = NumberSequence.new(0.8, 0)
		trail.Color = sequence
		trail.LightEmission = 0.35
		trail.Parent = pet.PrimaryPart

		t = 0
		while t < T.Pop do
			t += RunService.RenderStepped:Wait()
			local a = math.min(t / T.Pop, 1)
			setPet(eggPos:Lerp(center, easeOutBack(a)), a * math.pi * 2, easeOutBack(a))
		end

		-- 3) l'animal va directement dans les mains du joueur (bras levés, pas de tourbillon)
		local from = center
		local pocket = from
		local yaw = 0
		t = 0

		-- sauvegarder les Motor6D des bras pour les lever
		local character = player.Character
		local leftArm, rightArm
		if character then
			for _, motor in character:GetDescendants() do
				if motor:IsA("Motor6D") then
					if motor.Name == "Left Shoulder" then leftArm = motor
					elseif motor.Name == "Right Shoulder" then rightArm = motor end
				end
			end
		end
		local leftBase = leftArm and leftArm.C0
		local rightBase = rightArm and rightArm.C0
		local RAISE_TIME = 0.6

		while t < RAISE_TIME do
			local dt = RunService.RenderStepped:Wait()
			t += dt
			local u = math.min(t / RAISE_TIME, 1)
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if hrp then pocket = hrp.CFrame:PointToWorldSpace(Vector3.new(0, 1.2, -1.2)) end
			local a = u * u * (3 - 2 * u)
			local p = from:Lerp(pocket, a)
			yaw += dt * 2
			billboard.Enabled = u < 0.5
			setPet(p, yaw, 1 - (1 - 0.4) * u)
			-- monter les bras progressivement
			if leftArm and leftBase then
				leftArm.C0 = leftBase * CFrame.Angles(math.rad(-80) * u, 0, math.rad(-25) * u)
			end
			if rightArm and rightBase then
				rightArm.C0 = rightBase * CFrame.Angles(math.rad(-80) * u, 0, math.rad(25) * u)
			end
		end

		burst(pocket, sequence, 10, 8, 0.6)
		ring(pocket - Vector3.new(0, 1.8, 0), color, 1, 6, 0.4)

		-- les bras reviennent en douceur
		task.delay(0.8, function()
			if leftArm and leftArm.Parent then
				TweenService:Create(leftArm, TweenInfo.new(0.5), {C0 = leftBase}):Play()
			end
			if rightArm and rightArm.Parent then
				TweenService:Create(rightArm, TweenInfo.new(0.5), {C0 = rightBase}):Play()
			end
		end)
	end)
	if not ok then warn("[PetClient] animation de sortie d'oeuf : " .. tostring(err)) end

	if pet then pet:Destroy() end
	activeHatches -= 1
	ProximityPromptService.Enabled = activeHatches == 0
end

remotes:WaitForChild("EggHatched").OnClientEvent:Connect(playHatch)

---------------------------------------------------------------- Balade + animations des animaux posés
-- Le serveur donne juste la destination (attribut MoveTo) ; trajet et animations sont joués ici.
-- Chaque animal a des articulations (Weld avec l'attribut Anim), parfois en chaîne (cou -> tête, queue en 3 morceaux...).
local WALK_CYCLE = 10          -- vitesse du cycle de marche d'un animal de taille normale
local LEG_SWING = math.rad(34)
local LEG_TUCK = math.rad(30)  -- pattes repliées en vol
local STEP_BOB = 0.08
local BODY_ROLL = math.rad(3)
local BODY_NOD = math.rad(1.5) -- le corps tangue un peu à chaque pas
local BREATH = 0.05
local FLY_PITCH = math.rad(10) -- penche vers l'avant en volant
local BANK = 0.5               -- se penche dans les virages en vol
local FLY_CHANCE = 0.45        -- "Sometimes" : chance de faire le trajet en volant
local WING_FOLD = math.rad(-10)     -- ailes baissées au sol
local WINGTIP_FOLD = math.rad(-38)  -- bout d'aile replié au sol
local WING_RAISE = math.rad(14)
local WINGTIP_LAG = 0.9        -- le bout de l'aile bat avec un temps de retard
local TAIL_WAG = math.rad(13)
local TAIL_DRAG = math.rad(22) -- la queue traîne à l'extérieur des virages
local NECK_BOB = math.rad(4)
local HEAD_BOB = math.rad(3)
local HEAD_LOOK = math.rad(22) -- regarde à gauche / à droite à l'arrêt
local HEAD_TILT = math.rad(9)  -- penche la tête dans les virages
local PECK_ANGLE = math.rad(42)
local PECK_EVERY, PECK_TIME = 3, 0.6
local JAW_OPEN = math.rad(24)
local JAW_EVERY, JAW_TIME = 6, 0.9
local ARM_SWING = math.rad(22)      -- bras libre en marchant
local ARM_SWING_HELD = math.rad(7)  -- bras qui tient un objet : bouge moins
local WATCH_RANGE = 18              -- l'animal à l'arrêt regarde le joueur quand il est à cette distance
local WATCH_YAW, WATCH_PITCH = math.rad(60), math.rad(20)
local ACTION_EVERY = {3, 7}         -- secondes entre deux petites actions à l'arrêt

-- Petites actions jouées de temps en temps à l'arrêt. Needs = articulations nécessaires.
local ACTIONS = {
	{Name = "Hop", Time = 0.6},
	{Name = "Shake", Time = 0.8},
	{Name = "Look", Time = 1.8, Needs = "Head"},
	{Name = "Graze", Time = 2.6, Needs = "Neck", Ground = true},
	{Name = "Rear", Time = 1.3, Needs = "FrontLegs", Ground = true},
	{Name = "Stretch", Time = 1.6, Needs = "Wing", Ground = true},
	{Name = "Wag", Time = 1.2, Needs = "Tail"},
	{Name = "Cheer", Time = 1.4, Needs = "Arm"},
	{Name = "Spin", Time = 1.0, Air = true},
	{Name = "Roar", Time = 1.4, Needs = "Jaw"},
	-- animations propres aux animaux Halloween (Special dans EggConfig.Pets)
	{Name = "PumpkinRoll", Time = 1.4, Special = "Pumpkin", Ground = true},  -- roule sur lui-même et rebondit
	{Name = "Boo", Time = 1.8, Special = "Ghost"},                            -- disparaît à moitié, tourne et fait "BOO"
	{Name = "Magic", Time = 1.8, Special = "WitchCat"},                       -- dos rond, queue en l'air, étincelles magiques
	{Name = "Rattle", Time = 1.2, Special = "SkeletonDog"},                   -- ses os s'entrechoquent
	{Name = "Loop", Time = 1.2, Special = "VampireBat", Air = true},          -- looping en plein vol
}

-- effets visuels des animaux Halloween (créés sur ce client seulement)
local HALLOWEEN_FX = {
	Pumpkin = {Light = Color3.fromRGB(255, 150, 40)},
	Ghost = {Light = Color3.fromRGB(190, 220, 255), Sparkle = Color3.fromRGB(220, 235, 255)},
	WitchCat = {Light = Color3.fromRGB(170, 90, 255), Sparkle = Color3.fromRGB(190, 110, 255)},
	SkeletonDog = {Sparkle = Color3.fromRGB(240, 240, 220)},
	VampireBat = {Light = Color3.fromRGB(255, 40, 60), Sparkle = Color3.fromRGB(200, 20, 50)},
}
local function addHalloweenFx(model, root, special, size)
	local fx = HALLOWEEN_FX[special]
	if not fx then return nil end
	local out = {}
	if fx.Light then
		local l = Instance.new("PointLight")
		l.Name = "HalloweenGlow"
		l.Color, l.Range, l.Brightness = fx.Light, 7 * size, 1.2
		l.Parent = root
		out.Light = l
	end
	if fx.Sparkle then
		local e = Instance.new("ParticleEmitter")
		e.Name = "HalloweenSparkle"
		e.Texture = SPARKLE_TEXTURE
		e.Color = ColorSequence.new(fx.Sparkle)
		e.LightEmission = 1
		e.Rate = 0
		e.Lifetime = NumberRange.new(0.6, 1.2)
		e.Speed = NumberRange.new(2 * size, 5 * size)
		e.SpreadAngle = Vector2.new(180, 180)
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5 * size), NumberSequenceKeypoint.new(1, 0)})
		e.Parent = root
		out.Sparkle = e
	end
	-- pièces visibles (pour le fantôme qui devient transparent)
	out.Parts = {}
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") and d.Transparency < 1 then table.insert(out.Parts, d) end
	end
	return out
end

local placedFolder = workspace:WaitForChild("PlacedPets")
local walking = {} -- [model] = état

local function track(model)
	task.spawn(function()
		local root = model.PrimaryPart or model:WaitForChild("Root", 10)
		if not root or walking[model] or not model.Parent then return end
		local info = Config.Pets[model.Name] or {}
		local joints, has = {}, {}
		for _, d in model:GetDescendants() do
			if d:IsA("Weld") and d:GetAttribute("Anim") then
				local kind = d:GetAttribute("Anim")
				local front = d.Part0 == root and d.C0.Position.Z > 0 -- l'avant de l'animal est en +Z
				table.insert(joints, {
					Weld = d,
					Base = d.C0,
					Kind = kind,
					Phase = d:GetAttribute("Phase") or 0,
					Side = d:GetAttribute("Side") or 1,
					Held = d:GetAttribute("Held") == true,
					Front = front,
				})
				has[kind] = true
				if kind == "Leg" and front then has.FrontLegs = true end
			end
		end
		local legs = 0
		for _, j in joints do if j.Kind == "Leg" then legs += 1 end end
		if legs < 4 then has.FrontLegs = nil end -- seuls les quadrupèdes se cabrent
		-- allure : les quadrupèdes marchent à quatre temps (arrière gauche, avant gauche, arrière droit, avant droit) ;
		-- la cadence est calculée d'après la longueur des pattes pour que les pieds ne glissent pas sur le sol
		local quad = legs >= 4
		local groundOffset = model:GetAttribute("GroundOffset") or 1
		local hipHeight = 0
		for _, j in joints do
			if j.Kind == "Leg" then
				if quad then
					local left, front = j.Base.Position.X < 0, j.Base.Position.Z > 0
					j.Gait = ((left and 0 or 0.5) + (front and 0.25 or 0)) * math.pi * 2
				else
					j.Gait = j.Phase
				end
				hipHeight += groundOffset + j.Base.Position.Y
			end
		end
		local legLength = legs > 0 and math.max(hipHeight / legs, groundOffset * 0.3) or groundOffset
		local legCycle = legs > 0 and math.clamp(2 * math.pi * Config.WanderSpeed * 0.62 / (2 * legLength * math.sin(math.rad(24))), 2.5, 18) or nil
		local template = templates:FindFirstChild(model.Name)
		local size = template and model:GetScale() / template:GetScale() or 1
		walking[model] = {
			Root = root,
			Joints = joints,
			Has = has,
			X = root.Position.X,
			Z = root.Position.Z,
			Yaw = math.random() * math.pi * 2,
			Turn = 0,
			Cycle = math.random() * 6,
			Time = math.random() * 10,
			Seed = math.random() * 10,
			Quad = quad,
			LegLift = legLength * 0.17,
			Walk = 0, -- 0 = à l'arrêt, 1 = en marche
			Air = info.Fly == "Always" and 1 or 0, -- 0 = au sol, 1 = en vol
			Airborne = false,
			Size = size,
			CycleSpeed = legCycle or WALK_CYCLE / math.sqrt(size), -- cadence des pas (calée sur la longueur des pattes)
			Offset = model:GetAttribute("GroundOffset") or 1,
			FlyMode = info.Fly,
			FlyHeight = (info.FlyHeight or 2) * size,
			FlapSpeed = info.FlapSpeed or 10,
			FlapAngle = math.rad(info.FlapAngle or 30),
			Idle = info.Idle,
			Special = info.Special,
			Fx = info.Special and addHalloweenFx(model, root, info.Special, size) or nil,
			NextAction = 2 + math.random() * 5,
			LookYaw = 0,
			LookPitch = 0,
		}
	end)
end

placedFolder.ChildAdded:Connect(track)
placedFolder.ChildRemoved:Connect(function(model) walking[model] = nil end)
for _, model in placedFolder:GetChildren() do track(model) end

-- choisit une action que cet animal peut jouer maintenant
local function pickAction(s)
	local flying = s.Air > 0.5
	local choices = {}
	for _, action in ACTIONS do
		if (not action.Needs or s.Has[action.Needs]) and not (action.Ground and flying) and not (action.Air and not flying)
			and (not action.Special or action.Special == s.Special) then
			table.insert(choices, action)
			-- l'animation propre à l'animal revient plus souvent que les autres
			if action.Special then table.insert(choices, action) table.insert(choices, action) end
		end
	end
	return #choices > 0 and choices[math.random(#choices)] or nil
end

-- 0 -> 1 -> 0 en douceur sur la durée de l'action
local function bell(u) return math.sin(math.clamp(u, 0, 1) * math.pi) end
-- monte vite, tient, redescend
local function hold(u) return math.clamp(math.min(u, 1 - u) * 5, 0, 1) end

RunService.RenderStepped:Connect(function(dt)
	local character = player.Character
	local watched = character and character:FindFirstChild("Head")
	for model, s in walking do
		local target = model:GetAttribute("MoveTo")
		local groundY = model:GetAttribute("GroundY")
		if target and groundY and s.Root.Parent then
			-- nouvelle destination : les "Sometimes" décident s'ils y vont en volant
			if target ~= s.LastTarget then
				s.LastTarget = target
				s.Airborne = s.FlyMode == "Sometimes" and math.random() < FLY_CHANCE
			end

			local dx, dz = target.X - s.X, target.Z - s.Z
			local dist = math.sqrt(dx * dx + dz * dz)
			local moving = dist > 0.05
			local turn = 0
			if moving then
				local step = math.min(dist, Config.WanderSpeed * dt)
				s.X += dx / dist * step
				s.Z += dz / dist * step
				local diff = (math.atan2(dx, dz) - s.Yaw + math.pi) % (2 * math.pi) - math.pi
				turn = diff * math.min(1, dt * 6)
				s.Yaw += turn
			end
			s.Turn += (math.clamp(turn / math.max(dt, 0.001) * 0.12, -1, 1) - s.Turn) * math.min(1, dt * 6)

			local wantAir = (s.FlyMode == "Always" or (s.Airborne and moving)) and 1 or 0
			s.Air += (wantAir - s.Air) * math.min(1, dt * 2.5)
			s.Walk += ((moving and 1 or 0) - s.Walk) * math.min(1, dt * 8)
			s.Cycle += dt * s.CycleSpeed
			s.Time += dt
			local ground = 1 - s.Air
			local stride = s.Walk * ground
			local idle = (1 - s.Walk) * ground

			-- petites actions à l'arrêt
			if moving then
				s.Action = nil
				s.NextAction = s.Time + ACTION_EVERY[1] * math.random()
			elseif s.Action then
				s.ActionU += dt / s.Action.Time
				if s.ActionU >= 1 then
					s.Action = nil
					s.NextAction = s.Time + ACTION_EVERY[1] + math.random() * (ACTION_EVERY[2] - ACTION_EVERY[1])
				end
			elseif s.Time >= s.NextAction then
				s.Action, s.ActionU = pickAction(s), 0
				s.ActionSide = math.random() < 0.5 and -1 or 1
				if not s.Action then s.NextAction = s.Time + ACTION_EVERY[2] end
			end
			local act = s.Action and s.Action.Name
			local u = s.ActionU or 0
			local e = act and bell(u) or 0 -- intensité de l'action

			-- à l'arrêt, la tête suit le joueur quand il est proche
			local wantYaw, wantPitch = 0, 0
			if watched and not moving and not act then
				local toPlayer = watched.Position - s.Root.Position
				if toPlayer.Magnitude < WATCH_RANGE * math.max(1, s.Size) then
					local localDir = s.Root.CFrame:VectorToObjectSpace(toPlayer)
					wantYaw = math.clamp(math.atan2(localDir.X, localDir.Z), -WATCH_YAW, WATCH_YAW)
					wantPitch = math.clamp(-math.atan2(localDir.Y, math.sqrt(localDir.X ^ 2 + localDir.Z ^ 2)), -WATCH_PITCH, WATCH_PITCH)
				end
			end
			s.LookYaw += (wantYaw - s.LookYaw) * math.min(1, dt * 4)
			s.LookPitch += (wantPitch - s.LookPitch) * math.min(1, dt * 4)
			local watching = math.min(1, math.abs(s.LookYaw) * 4 + math.abs(s.LookPitch) * 4)

			local lift = s.Air * (s.FlyHeight + math.sin(s.Time * 2.6) * 0.3 * s.Size)
				+ stride * (0.5 - 0.5 * math.cos(s.Cycle * 2)) * STEP_BOB * s.Size * (s.Quad and 0.4 or 0.8)
				+ idle * math.sin(s.Time * 2) * BREATH * s.Size
			local pitch = FLY_PITCH * s.Air * s.Walk + math.sin(s.Cycle * 2) * BODY_NOD * stride
			local roll = math.sin(s.Cycle) * BODY_ROLL * stride - s.Turn * BANK * s.Air
			local yaw = s.Yaw + (s.Quad and math.sin(s.Cycle) * math.rad(2.5) * stride or 0)
			if act == "Hop" then
				lift += bell(u) * 1.3 * s.Size
				pitch -= math.sin(u * math.pi * 2) * math.rad(8)
			elseif act == "Shake" then
				roll += math.sin(u * 38) * math.rad(9) * e
			elseif act == "Rear" then
				pitch -= hold(u) * math.rad(26)
				lift += hold(u) * 0.35 * s.Size
			elseif act == "Graze" then
				pitch += hold(u) * math.rad(6)
			elseif act == "Spin" then
				local t = u * u * (3 - 2 * u)
				yaw += t * math.pi * 2
				lift += bell(u) * 0.6 * s.Size
			elseif act == "Cheer" then
				lift += math.abs(math.sin(u * math.pi * 3)) * 0.25 * s.Size
			elseif act == "Roar" then
				pitch -= hold(u) * math.rad(10)
			end

			-- animaux Halloween : leur façon de bouger à eux
			local sp = s.Special
			if sp == "Pumpkin" then
				-- avance en rebondissant, se dandine à l'arrêt, ses yeux brillent comme une bougie
				lift += stride * math.abs(math.sin(s.Cycle * 0.8)) * 0.9 * s.Size
				roll += math.sin(s.Time * 2.4) * math.rad(5) * idle
				if act == "PumpkinRoll" then
					roll += (u * u * (3 - 2 * u)) * math.pi * 2 * s.ActionSide
					lift += bell(u) * 1.6 * s.Size
				end
				if s.Fx and s.Fx.Light then s.Fx.Light.Brightness = 1 + math.sin(s.Time * 9) * 0.25 + math.random() * 0.3 end
			elseif sp == "Ghost" then
				-- flotte en ondulant doucement
				lift += math.sin(s.Time * 1.8) * 0.35 * s.Size
				roll += math.sin(s.Time * 1.3) * math.rad(8)
				pitch += math.sin(s.Time * 1.1) * math.rad(5)
				if act == "Boo" then
					yaw += (u * u * (3 - 2 * u)) * math.pi * 2
					lift += bell(u) * 1.2 * s.Size
					if s.Fx and s.Fx.Sparkle and u < 0.05 then s.Fx.Sparkle:Emit(12) end
				end
			elseif sp == "WitchCat" then
				if act == "Magic" then
					pitch += hold(u) * math.rad(10) -- dos rond
					lift += hold(u) * 0.25 * s.Size
					if s.Fx and s.Fx.Sparkle and math.random() < 0.5 then s.Fx.Sparkle:Emit(2) end
				end
				if s.Fx and s.Fx.Light then s.Fx.Light.Brightness = 0.6 + (act == "Magic" and e * 2.5 or 0) end
			elseif sp == "SkeletonDog" then
				-- trot sautillant
				lift += stride * math.abs(math.sin(s.Cycle * 1.5)) * 0.15 * s.Size
				if act == "Rattle" then
					roll += math.sin(u * 60) * math.rad(10) * e
					yaw += math.sin(u * 47) * math.rad(6) * e
					lift += math.abs(math.sin(u * 30)) * 0.2 * s.Size * e
					if s.Fx and s.Fx.Sparkle and math.random() < 0.3 then s.Fx.Sparkle:Emit(1) end
				end
			elseif sp == "VampireBat" then
				-- vol en 8, yeux rouges qui pulsent
				roll += math.sin(s.Time * 1.6) * math.rad(14)
				lift += math.sin(s.Time * 3.2) * 0.4 * s.Size
				if act == "Loop" then
					local k = u * u * (3 - 2 * u)
					pitch -= k * math.pi * 2
					lift += math.sin(k * math.pi) * 2.2 * s.Size
					if s.Fx and s.Fx.Sparkle and math.random() < 0.4 then s.Fx.Sparkle:Emit(1) end
				end
				if s.Fx and s.Fx.Light then s.Fx.Light.Brightness = 0.8 + math.sin(s.Time * 4) * 0.4 end
			end
			s.Root.CFrame = CFrame.new(s.X, groundY + s.Offset + lift, s.Z)
				* CFrame.Angles(0, yaw, 0)
				* CFrame.Angles(pitch, 0, roll)

			local flap = math.sin(s.Time * s.FlapSpeed)
			local flapLate = math.sin(s.Time * s.FlapSpeed - WINGTIP_LAG)
			for _, j in s.Joints do
				local rx, ry, rz = 0, 0, 0
				local legLift = 0
				local kind = j.Kind
				if kind == "Leg" then
					local f = ((s.Cycle + (j.Gait or j.Phase)) / (2 * math.pi)) % 1
					local swing
					if f < 0.62 then
						swing = -1 + 2 * f / 0.62 -- pied au sol : il recule à vitesse constante sous le corps
					else
						local k = (f - 0.62) / 0.38
						swing = 1 - 2 * (k * k * (3 - 2 * k)) -- pied en l'air : il revient vite vers l'avant
						legLift = math.sin(k * math.pi) * stride
					end
					rx = swing * math.rad(24) * stride + LEG_TUCK * s.Air
					if act == "Hop" then
						rx += bell(u) * math.rad(28) * (j.Front and -1 or 1)
					elseif act == "Rear" and j.Front then
						rx += hold(u) * (math.rad(-40) + math.sin(u * 22 + j.Phase) * math.rad(18))
					elseif act == "Rear" then
						rx += hold(u) * math.rad(22) -- les pattes arrière restent plantées
					end
				elseif kind == "Arm" then
					local swing = j.Held and ARM_SWING_HELD or ARM_SWING
					rx = math.sin(s.Cycle + j.Phase) * swing * stride + math.sin(s.Time * 1.3 + j.Phase) * math.rad(j.Held and 2 or 5)
					rz = j.Side * math.sin(s.Time * 1.1 + s.Seed) * math.rad(2)
					if act == "Cheer" then
						if j.Held then
							rx -= hold(u) * math.rad(34) -- brandit ce qu'il tient
						else
							rx -= hold(u) * math.rad(120)
							rz += j.Side * hold(u) * math.sin(u * 26) * math.rad(18) -- fait coucou
						end
					elseif act == "Hop" then
						rx -= bell(u) * math.rad(j.Held and 12 or 40)
					elseif act == "Shake" then
						rz += math.sin(u * 38 + j.Phase) * math.rad(8) * e
					end
				elseif kind == "Wing" then
					-- au sol : les ailes rebondissent à chaque pas et, de temps en temps, s'ébrouent en battant vite
					local flutter = math.max(0, math.sin(s.Time * 0.8 + s.Seed * 3) - 0.84) / 0.16
					rz = j.Side * (s.Air * (WING_RAISE + flap * s.FlapAngle)
						+ ground * (WING_FOLD + math.sin(s.Time * 2) * math.rad(2) + math.abs(math.sin(s.Cycle)) * math.rad(7) * stride
							+ flutter * (math.rad(24) + math.sin(s.Time * 30) * math.rad(18))))
					rx = ground * flutter * math.sin(s.Time * 30) * math.rad(6)
					if act == "Stretch" then
						rz += j.Side * hold(u) * (math.rad(30) + math.sin(u * 20) * math.rad(14))
					elseif act == "Hop" or act == "Shake" then
						rz += j.Side * e * math.rad(22) * ground
					end
				elseif kind == "WingTip" then
					local flutter = math.max(0, math.sin(s.Time * 0.8 + s.Seed * 3) - 0.84) / 0.16
					rz = j.Side * (s.Air * flapLate * s.FlapAngle * 0.8 + ground * (WINGTIP_FOLD + flutter * math.sin(s.Time * 30 - 1) * math.rad(20)))
					if act == "Stretch" then rz += j.Side * hold(u) * math.rad(34) end
				elseif kind == "Tail" then
					ry = math.sin(s.Time * 3.5 - j.Phase) * TAIL_WAG * (0.6 + 0.6 * s.Walk) - s.Turn * TAIL_DRAG
					rx = math.sin(s.Time * 1.7 - j.Phase) * math.rad(3)
					if act == "Wag" then
						ry += math.sin(u * 44 - j.Phase) * math.rad(24) * e
						rx -= e * math.rad(10)
					elseif act == "Rear" or act == "Roar" then
						rx -= hold(u) * math.rad(12)
					end
				elseif kind == "Neck" then
					rx = math.sin(s.Time * 1.6 + s.Seed) * NECK_BOB + math.sin(s.Cycle * 2) * math.rad(3) * stride - math.rad(10) * s.Air
					ry = s.LookYaw * 0.4
					if act == "Graze" then
						rx += hold(u) * math.rad(38)
					elseif act == "Rear" or act == "Roar" then
						rx -= hold(u) * math.rad(14)
					elseif act == "Look" then
						ry += hold(u) * s.ActionSide * math.rad(18)
					end
				elseif kind == "Head" then
					local share = s.Has.Neck and 0.6 or 1 -- le cou fait déjà une partie du mouvement
					rx = math.sin(s.Time * 2 + s.Seed) * HEAD_BOB - math.sin(s.Cycle * 2) * math.rad(2) * stride + s.LookPitch
					ry = math.sin(s.Time * 0.7 + s.Seed) * HEAD_LOOK * idle * (1 - watching) + s.LookYaw * share
					rz = -s.Turn * HEAD_TILT + math.sin(s.Time * 0.9 + s.Seed * 2) * math.rad(3) * idle
					if s.Idle == "Peck" and not act then
						if moving then
							rx += math.sin(s.Cycle * 2) * math.rad(8) * stride -- la tête avance / recule en marchant
						elseif watching < 0.2 then
							local t = s.Time % PECK_EVERY
							if t < PECK_TIME then rx += math.sin(t / PECK_TIME * math.pi) * PECK_ANGLE end
						end
					end
					if act == "Look" then
						ry = hold(u) * s.ActionSide * math.rad(48)
						rz += hold(u) * s.ActionSide * math.rad(14) -- penche la tête, curieux
					elseif act == "Shake" then
						ry += math.sin(u * 38) * math.rad(16) * e
					elseif act == "Graze" then
						rx += hold(u) * (math.rad(16) + math.sin(u * 30) * math.rad(5)) -- broute
					elseif act == "Hop" then
						rx -= bell(u) * math.rad(12)
					elseif act == "Roar" or act == "Rear" then
						rx -= hold(u) * math.rad(20)
					elseif act == "Cheer" then
						rx -= hold(u) * math.rad(10)
					end
				elseif kind == "Jaw" then
					local t = (s.Time + s.Seed) % JAW_EVERY
					if t < JAW_TIME then rx = math.sin(t / JAW_TIME * math.pi) * JAW_OPEN end
					if act == "Roar" then
						rx = hold(u) * (JAW_OPEN * 1.3 + math.sin(u * 40) * math.rad(3))
					elseif act == "Graze" then
						rx = hold(u) * math.abs(math.sin(u * 30)) * math.rad(12)
					end
				end
				-- retouches des animaux Halloween
				if sp then
					if sp == "Ghost" and kind == "Arm" then
						-- bras de fantôme qui ondulent, levés pour le "BOO"
						rx += math.sin(s.Time * 2.2 + j.Phase) * math.rad(14)
						if act == "Boo" then rx -= hold(u) * math.rad(110) rz += j.Side * hold(u) * math.rad(25) end
					elseif sp == "Ghost" and kind == "Tail" then
						ry += math.sin(s.Time * 2.5) * math.rad(18)
					elseif sp == "Pumpkin" and kind == "Arm" then
						if act == "PumpkinRoll" then rx -= bell(u) * math.rad(90) end
					elseif sp == "WitchCat" and kind == "Tail" then
						-- queue qui ondule lentement en S, dressée pendant la magie
						ry = math.sin(s.Time * 1.6 - j.Phase * 1.5) * math.rad(20)
						if act == "Magic" then rx -= hold(u) * math.rad(25) end
					elseif sp == "WitchCat" and kind == "Head" and act == "Magic" then
						rx -= hold(u) * math.rad(15)
					elseif sp == "SkeletonDog" and kind == "Tail" then
						ry = math.sin(s.Time * 9 - j.Phase) * math.rad(28) -- remue la queue très vite
					elseif sp == "SkeletonDog" and act == "Rattle" then
						rx += math.sin(u * 55 + j.Phase * 3) * math.rad(12) * e
						rz += math.cos(u * 61 + j.Phase * 2) * math.rad(8) * e
					elseif sp == "VampireBat" and act == "Loop" and (kind == "Wing" or kind == "WingTip") then
						rz = j.Side * math.rad(55) * bell(u) -- ailes grandes ouvertes pendant le looping
					end
				end
				if legLift > 0 then
					j.Weld.C0 = j.Base * CFrame.new(0, legLift * s.LegLift, 0) * CFrame.Angles(rx - legLift * math.rad(10), ry, rz)
				else
					j.Weld.C0 = j.Base * CFrame.Angles(rx, ry, rz)
				end
			end
			-- le fantôme devient à moitié invisible pendant son "BOO" et fait un peu transparent le reste du temps
			if sp == "Ghost" and s.Fx then
				local fade = 0.15 + math.sin(s.Time * 1.4) * 0.08 + (act == "Boo" and hold(u) * 0.55 or 0)
				for _, p in s.Fx.Parts do p.LocalTransparencyModifier = fade end
			end
		end
	end
end)

---------------------------------------------------------------- Minuteurs des oeufs posés
local TIMER_REFRESH = 0.25
local READY_TEXT = "Ready!"
local READY_COLOR = Color3.fromRGB(110, 255, 130)

task.spawn(function()
	while true do
		local now = workspace:GetServerTimeNow()
		for _, egg in placedEggs:GetChildren() do
			local readyAt = egg:GetAttribute("ReadyAt")
			local label = egg:FindFirstChild("Timer", true)
			if readyAt and label then
				local remaining = readyAt - now
				label.Text = remaining > 0 and Config.FormatTime(remaining) or READY_TEXT
				label.TextColor3 = remaining > 0 and Color3.new(1, 1, 1) or READY_COLOR
			end
		end
		task.wait(TIMER_REFRESH)
	end
end)

---------------------------------------------------------------- Animal nourri : "+XP" qui monte, gros effet si niveau gagné
local XP_COLOR = Color3.fromRGB(140, 220, 255)
local LEVEL_COLOR = Color3.fromRGB(255, 220, 80)
local XP_POPUP_TIME = 1.3

local function popup(position, text, color)
	local anchor = fxPart(Vector3.new(0.2, 0.2, 0.2), CFrame.new(position))
	anchor.Transparency = 1
	local billboard = Instance.new("BillboardGui")
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.Size = UDim2.new(7, 0, 1.6, 0)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.Text = text
	label.TextScaled = true
	label.TextColor3 = color
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Thickness = 2.5
	stroke.Parent = label
	label.Parent = billboard
	billboard.Parent = anchor
	local info = TweenInfo.new(XP_POPUP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(anchor, info, {CFrame = anchor.CFrame + Vector3.new(0, 4, 0)}):Play()
	TweenService:Create(label, info, {TextTransparency = 1}):Play()
	TweenService:Create(stroke, info, {Transparency = 1}):Play()
	Debris:AddItem(anchor, XP_POPUP_TIME + 0.1)
end

remotes:WaitForChild("PetFed").OnClientEvent:Connect(function(model, xp, newLevel)
	local root = model and model.PrimaryPart
	if not root then return end
	local position = root.Position
	burst(position, ColorSequence.new(Color3.new(1, 1, 1), XP_COLOR), 24, 9, 0.6)
	popup(position + Vector3.new(0, 3, 0), "+" .. xp .. " XP", XP_COLOR)
	if newLevel then
		local ground = Vector3.new(position.X, model:GetAttribute("GroundY") or position.Y, position.Z)
		ring(ground + Vector3.new(0, 0.2, 0), LEVEL_COLOR, 1, 12, 0.8)
		beam(ground, LEVEL_COLOR, 24, 2.5, 1)
		burst(position, ColorSequence.new(Color3.new(1, 1, 1), LEVEL_COLOR), 60, 16, 0.9)
		task.delay(0.35, popup, position + Vector3.new(0, 5, 0), "Level " .. newLevel .. "!", LEVEL_COLOR)
	end
end)
