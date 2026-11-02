-- Dragons à chevaucher : apparition, montée (ProximityPrompt), descente, feu.
-- Le cavalier pilote son dragon côté client (il en a la propriété réseau) ; voir StarterPlayerScripts.DragonClient.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local templates = ReplicatedStorage:WaitForChild("Dragons")
local action = ReplicatedStorage:WaitForChild("DragonSystem"):WaitForChild("DragonAction")
local DragonConfig = require(ReplicatedStorage.DragonSystem:WaitForChild("DragonConfig"))
local UpgradeConfig = require(ReplicatedStorage.DragonSystem:WaitForChild("UpgradeConfig"))

local PhysicsService = game:GetService("PhysicsService")
local TAG = "RideDragon"

-- collisions : le corps du dragon bute contre le sol et les murs, mais pas contre les joueurs ni les autres dragons
local BODY_GROUP, RIDER_GROUP = "DragonBody", "DragonRider"
pcall(function() PhysicsService:RegisterCollisionGroup(BODY_GROUP) end)
pcall(function() PhysicsService:RegisterCollisionGroup(RIDER_GROUP) end)
PhysicsService:CollisionGroupSetCollidable(BODY_GROUP, RIDER_GROUP, false)
PhysicsService:CollisionGroupSetCollidable(BODY_GROUP, BODY_GROUP, false)
-- les PNJ des boutiques se traversent : un Humanoid remet ses collisions, on passe donc par le groupe de collision
task.spawn(function()
	for _, shopName in {"dragon shop", "egg shop"} do
		local shop = workspace:WaitForChild(shopName, 15)
		for _, part in shop and shop:GetDescendants() or {} do
			if part:IsA("BasePart") then
				local model = part:FindFirstAncestorWhichIsA("Model")
				while model and not model:FindFirstChildOfClass("Humanoid") and model.Parent and model.Parent ~= workspace do model = model.Parent:FindFirstAncestorWhichIsA("Model") or nil end
				if (model and model:FindFirstChildOfClass("Humanoid")) or part.Parent:FindFirstChildOfClass("Humanoid") or (part.Parent.Parent and part.Parent.Parent:FindFirstChildOfClass("Humanoid")) then
					part.CollisionGroup = BODY_GROUP
				end
			end
		end
	end
end)

local function setRiderGroup(character)
	local function apply(part)
		if part:IsA("BasePart") then part.CollisionGroup = RIDER_GROUP end
	end
	for _, d in character:GetDescendants() do apply(d) end
	character.DescendantAdded:Connect(apply)
end
local FIRE_TEXTURE = "rbxasset://textures/particles/fire_main.dds"
local SMOKE_TEXTURE = "rbxasset://textures/particles/smoke_main.dds"
local SPARK_TEXTURE = "rbxasset://textures/particles/sparkles_main.dds"
local LAND_SPEED = 14 -- studs/s : vitesse à laquelle un dragon sans cavalier redescend se poser

local folder = Instance.new("Folder")
folder.Name = "Dragons"
folder.Parent = workspace

local function seq(...) -- NumberSequence depuis des paires {temps, valeur}
	local points = {}
	for _, p in {...} do table.insert(points, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(points)
end

local STAR_TEXTURE = "rbxasset://textures/particles/sparkles_main.dds"
local BLACK = Color3.new(0, 0, 0)
local WHITE = Color3.new(1, 1, 1)
local rgb = Color3.fromRGB
local function colors(...)
	local list, points = {...}, {}
	for i, c in list do table.insert(points, ColorSequenceKeypoint.new((i - 1) / (#list - 1), c)) end
	return ColorSequence.new(points)
end

-- textures animées (flipbooks 4x4) : vraies flammes et volutes de fumée
local FLIP_FIRE = "rbxassetid://9968039364"   -- feu orange (sur fond noir : toujours en LightEmission 1)
local FLIP_FLAME = "rbxassetid://17703378809" -- flamme blanche à teinter (glace, ombre, lumière...)
local FLIP_PUFF = "rbxassetid://13346862770"  -- volute de fumée / brume à teinter
local DROP_TEXTURE = "rbxassetid://16939835586" -- goutte (bave du Zombie, sang du Vampire)
local SPLAT_TEXTURE = "rbxassetid://16664856199" -- éclaboussure animée 4x4

-- souffle propre à chaque dragon. Jet = flammes principales, Core = dard clair près de la gueule, Puff = fumée/brume en bout de jet, Sparks = éclats
local BREATH = {
	Fire = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FIRE, Colors = colors(WHITE, WHITE, rgb(255, 170, 110)), LE = 1, Rate = 75},
		Core = {Colors = colors(rgb(255, 245, 190), rgb(255, 170, 50)), LE = 1},
		Puff = {Colors = colors(rgb(70, 60, 58), rgb(26, 24, 26)), Opacity = 0.5},
		Sparks = {Colors = colors(rgb(255, 230, 140), rgb(255, 120, 30)), Gravity = 18, Rate = 45, Size = 0.3},
	} end,
	Ice = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(215, 242, 255), rgb(130, 205, 255), rgb(70, 140, 235)), LE = 0.35, Gravity = -3},
		Core = {Colors = colors(rgb(235, 250, 255), rgb(150, 220, 255)), LE = 0.3},
		Puff = {Colors = colors(rgb(225, 242, 255), rgb(165, 210, 250)), Opacity = 0.4, Accel = -6, Rate = 22, LE = 0.1},
		Sparks = {Tex = STAR_TEXTURE, Colors = colors(WHITE, rgb(150, 220, 255)), Gravity = 12, Rate = 70, Size = 0.55},
	} end,
	Forest = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(215, 255, 130), rgb(110, 220, 70), rgb(40, 130, 50)), LE = 0.55},
		Core = {Colors = colors(rgb(240, 255, 170), rgb(150, 235, 80)), LE = 0.7},
		Puff = {Colors = colors(rgb(110, 160, 70), rgb(40, 75, 35)), Opacity = 0.5, Rate = 20},
		Sparks = {Colors = colors(rgb(200, 255, 120), rgb(70, 170, 60)), Gravity = 6, Rate = 40, Size = 0.4},
	} end,
	Ocean = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_PUFF, Colors = colors(rgb(225, 248, 255), rgb(90, 190, 240), rgb(30, 120, 215)), LE = 0.15, Gravity = -20, Speed = 1.3, Spread = 5, Rate = 90, Opacity = 0.8},
		Core = {Colors = colors(WHITE, rgb(140, 220, 255)), LE = 0.3, Gravity = -20},
		Puff = {Colors = colors(WHITE, rgb(190, 232, 255)), Opacity = 0.35, Accel = -14, Rate = 18, LE = 0.1},
		Sparks = {Colors = colors(WHITE, rgb(110, 200, 255)), Gravity = 42, Rate = 90, Size = 0.3},
	} end,
	Thunder = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(255, 250, 200), rgb(255, 225, 90), rgb(110, 200, 255)), LE = 1, Rate = 26, Life = 0.6, Opacity = 0.55},
		Core = false,
		Puff = false,
		Sparks = {Colors = colors(WHITE, rgb(255, 230, 90), rgb(110, 200, 255)), Gravity = 0, Rate = 130, Size = 0.32, Fast = true},
	} end,
	Lava = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FIRE, Colors = colors(WHITE, rgb(255, 200, 150), rgb(255, 120, 80)), LE = 1, Gravity = -14, Speed = 0.8, Rate = 80, Scale = 1.25},
		Core = {Colors = colors(rgb(255, 235, 150), rgb(255, 130, 30)), LE = 1, Gravity = -10},
		Puff = {Colors = colors(rgb(52, 38, 34), rgb(12, 10, 10)), Opacity = 0.65, Rate = 26},
		Sparks = {Colors = colors(rgb(255, 220, 110), rgb(255, 90, 20)), Gravity = 34, Rate = 80, Size = 0.55},
	} end,
	Crystal = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(255, 150, 230), rgb(150, 235, 255), rgb(190, 150, 255), rgb(255, 225, 130)), LE = 0.75, Rate = 80},
		Core = {Colors = colors(rgb(255, 240, 252), rgb(210, 190, 255)), LE = 0.8},
		Puff = {Colors = colors(rgb(255, 200, 240), rgb(190, 160, 255)), Opacity = 0.3, LE = 0.4, Rate = 14},
		Sparks = {Tex = STAR_TEXTURE, Colors = colors(WHITE, rgb(255, 170, 235), rgb(170, 235, 255)), Gravity = 0, Rate = 110, Size = 0.65},
	} end,
	Shadow = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(150, 80, 235), rgb(70, 35, 120), rgb(14, 10, 24)), LE = 0.15},
		Core = {Colors = colors(rgb(215, 160, 255), rgb(140, 70, 230)), LE = 0.85},
		Puff = {Colors = colors(rgb(44, 22, 70), BLACK), Opacity = 0.7, Rate = 28},
		Sparks = {Colors = colors(rgb(210, 150, 255), rgb(120, 60, 200)), Gravity = -4, Rate = 35, Size = 0.3},
	} end,
	Void = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(120, 70, 225), rgb(50, 24, 110), BLACK), LE = 0.1, Spin = 260},
		Core = {Colors = colors(rgb(255, 150, 240), rgb(150, 90, 255)), LE = 0.9},
		Puff = {Colors = colors(rgb(24, 12, 48), BLACK), Opacity = 0.7, Rate = 22},
		Sparks = {Tex = STAR_TEXTURE, Colors = colors(WHITE, rgb(255, 150, 240), rgb(140, 220, 255)), Gravity = 0, Rate = 80, Size = 0.5},
	} end,
	Celestial = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(255, 246, 200), rgb(255, 215, 100), rgb(255, 165, 40)), LE = 1, Gravity = 0, Speed = 1.15, Spread = 6, Opacity = 0.8},
		Core = {Colors = colors(rgb(255, 252, 230), rgb(255, 225, 130)), LE = 1},
		Puff = {Colors = colors(rgb(255, 240, 190), rgb(255, 205, 110)), Opacity = 0.25, LE = 0.6, Rate = 12},
		Sparks = {Tex = STAR_TEXTURE, Colors = colors(WHITE, rgb(255, 220, 110)), Gravity = -8, Rate = 100, Size = 0.7},
	} end,
	-- dragons d'Halloween. Extra = émetteurs en plus : chaque fonction reçoit l'échelle et rend les propriétés d'un ParticleEmitter
	Halloween = function(c1, c2, c3) return {
		Jet = {Tex = FLIP_FLAME, Colors = colors(rgb(255, 170, 50), rgb(255, 96, 16), rgb(170, 60, 245), rgb(90, 30, 170)), LE = 0.45, Rate = 85, Spin = 90},
		Core = {Colors = colors(rgb(235, 255, 160), rgb(150, 255, 60)), LE = 0.85},
		Puff = {Colors = colors(rgb(96, 52, 140), rgb(18, 10, 28)), Opacity = 0.55, Rate = 22},
		Sparks = {Tex = STAR_TEXTURE, Colors = colors(rgb(255, 220, 120), rgb(255, 130, 30), rgb(170, 80, 255)), Gravity = 4, Rate = 80, Size = 0.6},
	} end,
	Zombie = function(c1, c2, c3) return { -- nuage toxique et bave
		Jet = {Tex = FLIP_PUFF, Colors = colors(rgb(215, 255, 130), rgb(120, 225, 50), rgb(50, 120, 30)), LE = 0.4, Gravity = 1, Speed = 0.95, Spread = 9, Rate = 85, Opacity = 0.85},
		Core = {Colors = colors(rgb(235, 255, 170), rgb(150, 255, 60)), LE = 0.8},
		Puff = {Colors = colors(rgb(110, 150, 50), rgb(34, 48, 20)), Opacity = 0.6, Rate = 28, Accel = 5},
		Sparks = {Colors = colors(rgb(220, 255, 130), rgb(110, 230, 50)), Gravity = -6, Rate = 50, Size = 0.45},
		Extra = {function(s) return {
			Name = "Slime", Texture = DROP_TEXTURE, Rate = 60, Lifetime = NumberRange.new(0.6, 1.1), Speed = NumberRange.new(26 * s, 42 * s), SpreadAngle = Vector2.new(14, 14),
			Orientation = Enum.ParticleOrientation.VelocityParallel, Size = seq({0, 0.5 * s}, {1, 0.9 * s}), Transparency = seq({0, 0.05}, {0.8, 0.15}, {1, 1}),
			Color = colors(rgb(170, 255, 70), rgb(60, 170, 40)), LightEmission = 0.3, LightInfluence = 0.5, Acceleration = Vector3.new(0, -40 * s, 0), Drag = 0.5,
		} end},
	} end,
	Vampire = function(c1, c2, c3) return { -- il crache du sang : jet épais qui retombe, gouttes, éclaboussures
		Jet = {Tex = FLIP_PUFF, Colors = colors(rgb(235, 30, 44), rgb(150, 6, 20), rgb(60, 0, 8)), LE = 0.12, Gravity = -22, Speed = 1.25, Spread = 5, Rate = 95, Opacity = 0.92},
		Core = {Colors = colors(rgb(255, 70, 80), rgb(170, 0, 20)), LE = 0.35, Gravity = -16},
		Puff = {Colors = colors(rgb(140, 8, 20), rgb(34, 0, 6)), Opacity = 0.45, Accel = -12, Rate = 20},
		Sparks = false,
		Extra = {
			function(s) return {
				Name = "Blood", Texture = DROP_TEXTURE, Rate = 120, Lifetime = NumberRange.new(0.6, 1.1), Speed = NumberRange.new(30 * s, 52 * s), SpreadAngle = Vector2.new(11, 11),
				Orientation = Enum.ParticleOrientation.VelocityParallel, Size = seq({0, 0.45 * s}, {1, 0.85 * s}), Transparency = seq({0, 0}, {0.85, 0.1}, {1, 1}),
				Color = colors(rgb(235, 20, 36), rgb(110, 0, 14)), LightEmission = 0.15, LightInfluence = 0.6, Acceleration = Vector3.new(0, -48 * s, 0), Drag = 0.4,
			} end,
			function(s) return {
				Name = "Splat", Texture = SPLAT_TEXTURE, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot, Rate = 9,
				Lifetime = NumberRange.new(0.5, 0.7), Speed = NumberRange.new(22 * s, 34 * s), SpreadAngle = Vector2.new(8, 8), Size = seq({0, 1.6 * s}, {1, 3.4 * s}),
				Transparency = seq({0, 0.05}, {0.7, 0.2}, {1, 1}), Color = colors(rgb(200, 10, 26), rgb(90, 0, 10)), LightEmission = 0.1, LightInfluence = 0.6,
				Rotation = NumberRange.new(0, 360), Acceleration = Vector3.new(0, -20 * s, 0), Drag = 0.8,
			} end,
		},
	} end,
}

local function flipbook(e)
	e.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
	e.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
end

-- souffle : jet de flammes animées, dard clair, fumée en bout de jet, éclats, lumière. Tailles proportionnelles au dragon.
local function addFire(mouth, s, dragon)
	local c1 = dragon:GetAttribute("Fire1") or Color3.fromRGB(255, 240, 150)
	local c2 = dragon:GetAttribute("Fire2") or Color3.fromRGB(255, 150, 40)
	local c3 = dragon:GetAttribute("Fire3") or Color3.fromRGB(220, 50, 20)
	local style = (BREATH[dragon:GetAttribute("Element")] or BREATH.Fire)(c1, c2, c3)
	local function emitter(name, props)
		local e = Instance.new("ParticleEmitter")
		e.Name = name
		e.Enabled = false
		e.EmissionDirection = Enum.NormalId.Front
		for k, v in props do e[k] = v end
		e.Parent = mouth
		return e
	end
	local jet = style.Jet
	local k, speed, opacity = jet.Scale or 1, jet.Speed or 1, jet.Opacity or 1
	-- les flammes lumineuses s'additionnent : moins nombreuses et plus transparentes, sinon le centre devient blanc (bloom)
	local bright = jet.LE >= 0.7
	local rate = (jet.Rate or 65) * (bright and 0.45 or 1)
	if bright then opacity *= 0.45 end
	flipbook(emitter("Flame", {
		Texture = jet.Tex, Rate = rate, Lifetime = NumberRange.new((jet.Life or 1) * 0.55, (jet.Life or 1) * 0.85),
		Speed = NumberRange.new(34 * s * speed, 46 * s * speed), SpreadAngle = Vector2.new(jet.Spread or 8, jet.Spread or 8),
		Size = seq({0, 1 * s * k}, {0.3, 3.2 * s * k}, {1, 5.4 * s * k}),
		Transparency = seq({0, 1 - 0.85 * opacity}, {0.5, 1 - 0.65 * opacity}, {1, 1}),
		Color = jet.Colors, LightEmission = jet.LE, Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-(jet.Spin or 40), jet.Spin or 40),
		Drag = 1.1, Acceleration = Vector3.new(0, (jet.Gravity or 4) * s, 0), ZOffset = 0.5,
	}))
	local core = style.Core
	if core then
		flipbook(emitter("Core", {
			Texture = FLIP_FLAME, Rate = core.LE >= 0.7 and 14 or 30, Lifetime = NumberRange.new(0.25, 0.4), Speed = NumberRange.new(40 * s * speed, 50 * s * speed), SpreadAngle = Vector2.new(4, 4),
			Size = seq({0, 0.7 * s}, {1, 2.1 * s}), Transparency = seq({0, core.LE >= 0.7 and 0.6 or 0.3}, {1, 1}), Color = core.Colors, LightEmission = core.LE,
			Rotation = NumberRange.new(0, 360), Acceleration = Vector3.new(0, (core.Gravity or 0) * s, 0), ZOffset = 1,
		}))
	end
	local puff = style.Puff
	if puff then
		flipbook(emitter("Smoke", {
			Texture = FLIP_PUFF, Rate = puff.Rate or 16, Lifetime = NumberRange.new(1, 1.7), Speed = NumberRange.new(18 * s, 26 * s), SpreadAngle = Vector2.new(12, 12),
			Size = seq({0, 1.5 * s}, {1, 7.5 * s}), Transparency = seq({0, 1}, {0.3, 1 - (puff.Opacity or 0.45)}, {1, 1}), Color = puff.Colors, LightEmission = puff.LE or 0,
			Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-30, 30), Drag = 1.6, Acceleration = Vector3.new(0, (puff.Accel or 8) * s, 0), ZOffset = -0.5,
		}))
	end
	local sparks = style.Sparks
	if sparks then
		emitter("Embers", {
			Texture = sparks.Tex or SPARK_TEXTURE, Rate = sparks.Rate, Lifetime = sparks.Fast and NumberRange.new(0.15, 0.4) or NumberRange.new(0.5, 1.1),
			Speed = NumberRange.new(24 * s, (sparks.Fast and 62 or 44) * s), SpreadAngle = sparks.Fast and Vector2.new(34, 34) or Vector2.new(20, 20),
			Size = seq({0, sparks.Size * s}, {1, 0}), Color = sparks.Colors, LightEmission = sparks.LE or 1, Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-200, 200),
			Acceleration = Vector3.new(0, -sparks.Gravity * s, 0), Drag = 0.6,
		})
	end
	for _, extra in style.Extra or {} do -- émetteurs propres à un dragon (gouttes de sang, bave...)
		local props = extra(s)
		emitter(props.Name, props)
	end
	local light = Instance.new("PointLight")
	light.Name = "FireLight"
	light.Color = c2
	light.Range = 12 * s + 8
	light.Brightness = 1.2
	light.Enabled = false
	light.Parent = mouth
end

-- aura permanente autour du corps, propre à chaque élément
local AURA = {
	Fire = {Texture = "Spark", Rate = 8, Speed = {1, 3}, Size = 0.3, Accel = 4, Light = 1},
	Ice = {Texture = "Star", Rate = 10, Speed = {0.5, 2}, Size = 0.4, Accel = -3, Light = 0.8},
	Forest = {Texture = "Spark", Rate = 7, Speed = {1, 3}, Size = 0.4, Accel = -1.5, Light = 0.2, Spin = 260},
	Ocean = {Texture = "Spark", Rate = 10, Speed = {1, 2.5}, Size = 0.3, Accel = 5, Light = 0.6},
	Thunder = {Texture = "Spark", Rate = 26, Speed = {6, 14}, Size = 0.32, Accel = 0, Light = 1, Life = {0.15, 0.4}},
	Lava = {Texture = "Spark", Rate = 12, Speed = {1, 3}, Size = 0.45, Accel = -9, Light = 1},
	Crystal = {Texture = "Star", Rate = 14, Speed = {0.5, 2}, Size = 0.55, Accel = 0, Light = 1, Spin = 200},
	Shadow = {Texture = "Smoke", Rate = 9, Speed = {0.5, 2}, Size = 1.6, Accel = 2, Light = 0, Fade = 0.55},
	Void = {Texture = "Star", Rate = 14, Speed = {0.5, 2}, Size = 0.45, Accel = 0, Light = 1, Spin = 300},
	Celestial = {Texture = "Star", Rate = 18, Speed = {1, 3}, Size = 0.6, Accel = 3, Light = 1, Spin = 160, Glow = true},
	Halloween = {Texture = "Spark", Rate = 12, Speed = {1, 3}, Size = 0.45, Accel = 3, Light = 1},
	Zombie = {Texture = "Smoke", Rate = 8, Speed = {0.5, 2}, Size = 1.8, Accel = 3, Light = 0, Fade = 0.6},
	Vampire = {Texture = "Smoke", Rate = 8, Speed = {0.5, 2}, Size = 1.7, Accel = -1, Light = 0, Fade = 0.6},
}
local function addAura(attachment, s, dragon)
	local a = AURA[dragon:GetAttribute("Element")] or AURA.Fire
	local c1 = dragon:GetAttribute("Fire1") or Color3.fromRGB(255, 210, 110)
	local c2 = dragon:GetAttribute("Fire2") or Color3.fromRGB(255, 100, 30)
	local c3 = dragon:GetAttribute("Fire3") or c2
	local aura = Instance.new("ParticleEmitter")
	aura.Name = "Aura"
	aura.Texture = a.Texture == "Star" and STAR_TEXTURE or a.Texture == "Smoke" and SMOKE_TEXTURE or SPARK_TEXTURE
	aura.Rate = a.Rate
	aura.Lifetime = a.Life and NumberRange.new(a.Life[1], a.Life[2]) or NumberRange.new(1.2, 2.2)
	aura.Speed = NumberRange.new(a.Speed[1] * s, a.Speed[2] * s)
	aura.SpreadAngle = Vector2.new(180, 180)
	aura.Size = a.Texture == "Smoke" and seq({0, a.Size * s * 0.5}, {1, a.Size * s}) or seq({0, a.Size * s}, {1, 0})
	aura.Transparency = a.Fade and seq({0, 1}, {0.3, a.Fade}, {1, 1}) or seq({0, 0}, {0.8, 0.2}, {1, 1})
	aura.Color = a.Light == 0 and colors(c3, BLACK) or colors(c1, c2)
	aura.LightEmission = a.Light
	aura.Acceleration = Vector3.new(0, a.Accel * s, 0)
	aura.Rotation = NumberRange.new(0, 360)
	if a.Spin then aura.RotSpeed = NumberRange.new(-a.Spin, a.Spin) end
	aura.Parent = attachment
	if a.Glow then
		local glow = Instance.new("PointLight")
		glow.Name = "AuraGlow"
		glow.Color = c2
		glow.Range = 10 * s + 8
		glow.Brightness = 1.2
		glow.Parent = attachment
	end
end

local function setFire(dragon, on)
	if dragon:GetAttribute("Firing") == on then return end
	dragon:SetAttribute("Firing", on)
	local mouth = dragon:FindFirstChild("Mouth", true)
	if mouth then
		for _, d in mouth:GetChildren() do
			if d:IsA("ParticleEmitter") or d:IsA("PointLight") then d.Enabled = on end
			if on and d:IsA("ParticleEmitter") then d:Emit(math.ceil(d.Rate * 0.18)) end -- bouffée de départ
		end
	end
end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local function groundBelow(dragon, position)
	local ignore = {folder}
	for _, player in Players:GetPlayers() do
		if player.Character then table.insert(ignore, player.Character) end
	end
	rayParams.FilterDescendantsInstances = ignore
	-- on part d'un peu plus haut que le dragon pour retrouver le sol même s'il s'y est enfoncé
	local lift = dragon and ((dragon:GetAttribute("GroundOffset") or 1) + 2) or 3
	local hit = workspace:Raycast(position + Vector3.new(0, lift, 0), Vector3.new(0, -2000, 0), rayParams)
	return hit and hit.Position.Y or nil
end

-- sans cavalier : le dragon redescend doucement puis se fige au sol
local function land(dragon)
	local root = dragon.PrimaryPart
	local drive, steer = root:FindFirstChild("Drive"), root:FindFirstChild("Steer")
	task.spawn(function()
		pcall(function() root:SetNetworkOwner(nil) end)
		local _, yaw = root.CFrame:ToOrientation()
		steer.CFrame = CFrame.Angles(0, yaw, 0)
		while dragon.Parent and not dragon:GetAttribute("Rider") do
			local groundY = groundBelow(dragon, root.Position)
			local targetY = (groundY or (root.Position.Y - 50)) + dragon:GetAttribute("GroundOffset")
			local gap = root.Position.Y - targetY
			if groundY and gap <= 0.25 then
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
				root.Anchored = true
				root.CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z) * CFrame.Angles(0, yaw, 0)
				drive.Enabled, steer.Enabled = false, false
				break
			end
			drive.VectorVelocity = Vector3.new(0, -math.min(LAND_SPEED, gap * 4 + 1), 0)
			task.wait(0.05)
		end
	end)
end

local function riderOf(player)
	for _, dragon in folder:GetChildren() do
		if dragon:GetAttribute("Rider") == player.UserId then return dragon end
	end
	return nil
end

---------------------------------------------------------------- perchoir : dans la zone sûre, le dragon d'un joueur dort sur l'arbre de sa base
-- * quand on rejoint le jeu, quand on descend du dragon dans la zone sûre ou qu'on y rentre à pied : il va se coucher sur son arbre ;
-- * le bouton RIDE (RideButtonClient) le fait venir sous son joueur, qui monte dessus ;
-- * hors de la zone sûre rien ne change : sans cavalier, il suit son joueur.
-- L'arbre d'une base n'existe que tant que son joueur est là. Attributs du dragon : GoPerch (CFrame du nid, pendant qu'il y vole)
-- puis Perched (il dort : DragonClient joue la pose de sommeil).
local perchTemplate = game:GetService("ServerStorage"):WaitForChild("DragonPerch")
local PERCH_OFFSET = Vector3.new(10, 0, 20) -- place de l'arbre par rapport au Spawn de la base
local SLEEP_HEIGHT = 0.6                    -- part de GroundOffset gardée quand il est couché (le ventre touche la paille)
local safeZone = workspace:FindFirstChild("safe zone")
local perchFolder = Instance.new("Folder")
perchFolder.Name = "DragonPerches"
perchFolder.Parent = workspace
local perches = {}  -- [joueur] = arbre
local personal = {} -- [joueur] = dragon personnel

local function inSafeZone(position)
	if not safeZone then return false end
	local p = safeZone.CFrame:PointToObjectSpace(position)
	return math.abs(p.X) <= safeZone.Size.X / 2 and math.abs(p.Z) <= safeZone.Size.Z / 2
end

-- arbre de la base du joueur (créé à la demande ; nil tant que le joueur n'a pas de base)
local function perchOf(player)
	local perch = perches[player]
	if perch and perch.Parent then return perch end
	local bases = workspace:FindFirstChild("all base")
	local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
	local spawn = base and base:FindFirstChild("Spawn")
	if not spawn then return nil end
	perch = perchTemplate:Clone()
	local groundY = safeZone and (safeZone.Position.Y + safeZone.Size.Y / 2) or (spawn.Position.Y - spawn.Size.Y / 2)
	local at = Vector3.new(spawn.Position.X + PERCH_OFFSET.X, groundY, spawn.Position.Z + PERCH_OFFSET.Z)
	-- le nid regarde le Spawn : le dragon dort la tête tournée vers son joueur
	perch:PivotTo(CFrame.lookAt(at, Vector3.new(spawn.Position.X, groundY, spawn.Position.Z)) * CFrame.Angles(0, math.pi, 0))
	perch.Parent = perchFolder
	perches[player] = perch
	return perch
end
Players.PlayerRemoving:Connect(function(player)
	local perch = perches[player]
	perches[player] = nil
	if perch then perch:Destroy() end
end)

-- le dragon est arrivé sur son nid : il se fige et s'endort
local function settle(dragon)
	local goal = dragon and dragon.Parent and dragon:GetAttribute("GoPerch")
	local root = dragon and dragon.PrimaryPart
	if not goal or not root or dragon:GetAttribute("Rider") then return end
	dragon:SetAttribute("GoPerch", nil)
	dragon:SetAttribute("Perched", true)
	local drive, steer = root:FindFirstChild("Drive"), root:FindFirstChild("Steer")
	if drive and steer then drive.Enabled, steer.Enabled = false, false end
	root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
	root.Anchored = true
	root.CFrame = goal
end

-- envoie le dragon dormir sur l'arbre de son joueur. instant = il y est déjà (arrivée dans le jeu) ;
-- sinon son joueur l'y fait voler (DragonClient) puis prévient le serveur ("Perched")
local function park(player, dragon, instant)
	local root = dragon.PrimaryPart
	if not root or dragon:GetAttribute("Rider") or dragon:GetAttribute("Perched") or dragon:GetAttribute("GoPerch") then return end
	local perch = perchOf(player)
	local nest = perch and perch:FindFirstChild("Nest")
	if not nest then return end
	local goal = nest.CFrame * CFrame.new(0, (dragon:GetAttribute("GroundOffset") or 3.4) * SLEEP_HEIGHT, 0)
	setFire(dragon, false)
	local prompt = root:FindFirstChild("RidePrompt")
	if prompt then prompt.Enabled = false end
	local collider = dragon:FindFirstChild("Collider")
	if collider then collider.CanCollide = false end
	dragon:SetAttribute("GoPerch", goal)
	if instant then
		settle(dragon)
	else
		task.delay(3.5, function() -- filet de sécurité : s'il n'est pas arrivé, on le pose
			if dragon.Parent and dragon:GetAttribute("GoPerch") == goal then settle(dragon) end
		end)
	end
end

local function dismount(dragon)
	if not dragon:GetAttribute("Rider") then return end
	if not dragon.Parent or not dragon.PrimaryPart then return end -- dragon déjà supprimé (réapparition du joueur)
	dragon:SetAttribute("Rider", nil)
	setFire(dragon, false)
	local prompt = dragon.PrimaryPart:FindFirstChild("RidePrompt")
	if prompt then prompt.Enabled = false end
	local collider = dragon:FindFirstChild("Collider")
	if collider then collider.CanCollide = false end -- sans cavalier, on passe à travers le dragon
	dragon:SetAttribute("Exhausted", nil)
	if dragon:GetAttribute("Owner") then
		-- dragon personnel : dans la zone sûre il rentre dormir sur son arbre, ailleurs son joueur en reprend le contrôle (boucle plus bas)
		local owner = Players:GetPlayerByUserId(dragon:GetAttribute("Owner"))
		if owner and inSafeZone(dragon.PrimaryPart.Position) then park(owner, dragon) end
	else
		land(dragon)
	end
end

local function mount(player, dragon)
	if dragon:GetAttribute("Rider") or riderOf(player) then return end
	local owner = dragon:GetAttribute("Owner")
	if owner and owner ~= player.UserId then return end -- un dragon personnel ne se prête pas
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local seat = dragon:FindFirstChild("Seat")
	if not humanoid or humanoid.Health <= 0 or not seat then return end
	local root = dragon.PrimaryPart
	dragon:SetAttribute("GoPerch", nil) -- on le réveille
	dragon:SetAttribute("Perched", nil)
	dragon:SetAttribute("Rider", player.UserId)
	local _, yaw = root.CFrame:ToOrientation()
	root.Steer.CFrame = CFrame.Angles(0, yaw, 0)
	root.Drive.VectorVelocity = Vector3.zero
	root.Drive.Enabled, root.Steer.Enabled = true, true
	root.Anchored = false
	local collider = dragon:FindFirstChild("Collider")
	if collider then collider.CanCollide = true end
	seat:Sit(humanoid)
	root.RidePrompt.Enabled = false
	pcall(function() root:SetNetworkOwner(player) end)
end

-- bouton RIDE : le dragon du joueur vient se poser sous lui (même s'il dormait sur son arbre) et le joueur monte dessus
local function rideRequest(player)
	local dragon = personal[player]
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = dragon and dragon.Parent and dragon.PrimaryPart
	if not root or not hrp or not humanoid or humanoid.Health <= 0 then return end
	if dragon:GetAttribute("Rider") or riderOf(player) then return end
	dragon:SetAttribute("GoPerch", nil)
	dragon:SetAttribute("Perched", nil)
	local groundY = groundBelow(nil, hrp.Position) or (hrp.Position.Y - 3)
	local _, yaw = hrp.CFrame:ToOrientation()
	root.Anchored = false
	root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
	-- le modèle regarde vers +Z : on l'oriente comme le joueur
	root.CFrame = CFrame.new(hrp.Position.X, groundY + (dragon:GetAttribute("GroundOffset") or 3.4), hrp.Position.Z) * CFrame.Angles(0, yaw + math.pi, 0)
	mount(player, dragon)
end

local function spawnDragon(level, cframe, templateName)
	local template = templates:FindFirstChild(templateName or ("Dragon Level " .. level))
	if not template then return end
	local dragon = template:Clone()
	local root = dragon.PrimaryPart
	local scale = dragon:GetAttribute("Height") / 2.5
	local s = scale ^ 0.75 -- les effets grandissent un peu moins vite que le dragon

	local attachment = Instance.new("Attachment")
	attachment.Name = "DriveAttachment"
	attachment.Parent = root
	local drive = Instance.new("LinearVelocity")
	drive.Name = "Drive"
	drive.Attachment0 = attachment
	drive.RelativeTo = Enum.ActuatorRelativeTo.World
	drive.MaxForce = 4e5 -- très fort, mais pas infini : le sol et les murs arrêtent le dragon
	drive.VectorVelocity = Vector3.zero
	drive.Enabled = false
	drive.Parent = root
	local steer = Instance.new("AlignOrientation")
	steer.Name = "Steer"
	steer.Mode = Enum.OrientationAlignmentMode.OneAttachment
	steer.Attachment0 = attachment
	steer.MaxTorque = math.huge
	steer.Responsiveness = 60
	steer.Enabled = false
	steer.Parent = root

	-- boîte de collision autour du corps (invisible) : elle repose au-dessus du sol, les pattes passent dessous
	local height = dragon:GetAttribute("Height")
	local groundOffset = dragon:GetAttribute("GroundOffset")
	local collider = Instance.new("Part")
	collider.Name = "Collider"
	collider.Size = Vector3.new(height * 0.55, groundOffset * 1.1, height * 0.8)
	collider.CFrame = root.CFrame * CFrame.new(0, -groundOffset * 0.1, 0)
	collider.Transparency = 1
	collider.Massless = true
	collider.CanCollide = true
	collider.CanQuery, collider.CanTouch = false, false
	collider.CollisionGroup = BODY_GROUP
	local colliderWeld = Instance.new("WeldConstraint")
	colliderWeld.Part0, colliderWeld.Part1 = root, collider
	colliderWeld.Parent = collider
	collider.Parent = dragon

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "RidePrompt"
	prompt.ActionText = "Ride"
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.ObjectText = "Dragon Lv." .. level
	prompt.HoldDuration = 0.25
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 9 + dragon:GetAttribute("Height") * 0.9
	prompt.Enabled = false -- plus de "Ride" sur le dragon : on monte avec le bouton RIDE (RideButtonClient)
	prompt.Parent = root
	prompt.Triggered:Connect(function(player) mount(player, dragon) end)

	dragon:SetAttribute("Element", string.match(tostring(templateName or dragon.Name), "^(%a+)") or "Fire")
	local mouth = dragon:FindFirstChild("Mouth", true)
	if mouth then addFire(mouth, s, dragon) end
	addAura(attachment, s, dragon)

	local seat = dragon:FindFirstChild("Seat")
	seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		if not seat.Occupant then dismount(dragon) end
	end)

	dragon:PivotTo(cframe)
	dragon.Parent = folder
	CollectionService:AddTag(dragon, TAG)
	return dragon
end

action.OnServerEvent:Connect(function(player, what, value)
	if what == "Ride" then rideRequest(player) return end
	if what == "Perched" then settle(personal[player]) return end -- son joueur l'a fait voler jusqu'au nid
	local dragon = riderOf(player)
	if not dragon then return end
	if what == "Fire" then
		setFire(dragon, value == true)
	elseif what == "Exhausted" then
		dragon:SetAttribute("Exhausted", value == true or nil) -- à bout de forces : les autres joueurs le voient s'écrouler aussi
	elseif what == "Dismount" then
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local seat = dragon:FindFirstChild("Seat")
		if humanoid and seat then
			local weld = seat:FindFirstChild("SeatWeld")
			if weld then weld:Destroy() end
			humanoid.Sit = false
			local root = dragon.PrimaryPart
			character:PivotTo(root.CFrame * CFrame.new(-((dragon:GetAttribute("Height") or 8.8) * 0.5 + 3), 2, 0))
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	local dragon = riderOf(player)
	if dragon then dismount(dragon) end
end)

---------------------------------------------------------------- dragon personnel : on apparaît dessus
local FOOT_SPEED = 24 -- vitesse du joueur à pied
local SPAWN_DELAY = 2 -- laisse BaseServer placer le joueur sur le Spawn de sa base
-- (personal, [joueur] = dragon personnel, est déclaré plus haut avec le perchoir)

local function removePersonal(player)
	local dragon = personal[player]
	personal[player] = nil
	if dragon then dragon:Destroy() end
end

local function giveDragon(player, character, instant)
	if not instant then
		setRiderGroup(character)
		task.wait(SPAWN_DELAY)
	end
	if player.Character ~= character or not character.Parent then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not hrp or not humanoid or humanoid.Health <= 0 then return end
	humanoid.WalkSpeed = FOOT_SPEED
	-- changement de dragon : le nouveau prend la place et l'orientation de l'ancien
	local previous = personal[player]
	local place
	if previous and previous.Parent and previous.PrimaryPart then
		local _, oldYaw = previous.PrimaryPart.CFrame:ToOrientation()
		place = CFrame.new(previous:GetPivot().Position) * CFrame.Angles(0, oldYaw, 0)
	else
		local groundY = groundBelow(nil, hrp.Position) or (hrp.Position.Y - 3)
		local _, yaw = hrp.CFrame:ToOrientation()
		-- le modèle regarde vers +Z : on l'oriente comme le joueur
		local side = hrp.Position + hrp.CFrame.RightVector * 8 -- le dragon apparaît à côté du joueur
		place = CFrame.new(side.X, groundY, side.Z) * CFrame.Angles(0, yaw + math.pi, 0)
	end
	local wasRiding = previous ~= nil and previous:GetAttribute("Rider") == player.UserId
	removePersonal(player)
	local dragon = spawnDragon(1, place, DragonConfig.Equipped(player))
	if not dragon then return end
	dragon:SetAttribute("Owner", player.UserId)
	local root = dragon.PrimaryPart
	root.RidePrompt.ObjectText = dragon.Name
	root.RidePrompt.Enabled = false
	dragon.Collider.CanCollide = false -- on ne se cogne pas dans un dragon sans cavalier
	root.Anchored = false
	root.Drive.Enabled, root.Steer.Enabled = true, true
	pcall(function() root:SetNetworkOwner(nil) end)
	personal[player] = dragon
	dragon:SetAttribute("Born", os.clock())
	if wasRiding then -- changement de dragon en selle : on remonte dès que l'ancien siège a lâché le joueur
		dragon:SetAttribute("Remount", true) -- pas de retour au nid pendant qu'il change de monture
		task.spawn(function()
			local waited = 0
			while humanoid.SeatPart and waited < 1 do waited += task.wait() end
			humanoid.Sit = false
			task.wait(0.15)
			if personal[player] ~= dragon or not dragon.Parent then return end
			mount(player, dragon)
			task.wait(0.7)
			local seat = dragon:FindFirstChild("Seat")
			if dragon.Parent and dragon:GetAttribute("Rider") == player.UserId and seat and seat.Occupant ~= humanoid then
				dismount(dragon) -- il n'a pas réussi à s'asseoir : le dragon redevient libre (il suit, on peut remonter)
			end
			dragon:SetAttribute("Remount", nil)
		end)
	elseif inSafeZone(hrp.Position) then
		park(player, dragon, true) -- dans la zone sûre, il apparaît endormi sur son arbre
	end
end

local function onPlayer(player)
	player.CharacterAdded:Connect(function(character) giveDragon(player, character) end)
	-- dragon équipé à la boutique : on remplace celui du joueur tout de suite
	player:GetAttributeChangedSignal("Dragon"):Connect(function()
		local current = personal[player]
		if player.Character and current and current.Name ~= DragonConfig.Equipped(player) then
			giveDragon(player, player.Character, true)
		end
	end)
	player:GetAttributeChangedSignal("Up_Speed"):Connect(function()
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then humanoid.WalkSpeed = FOOT_SPEED end
	end)
	if player.Character then task.spawn(giveDragon, player, player.Character) end
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end
Players.PlayerRemoving:Connect(removePersonal)

-- le dragon personnel est "ancré" à son joueur : si le joueur n'est plus assis dessus (chute, bug, siège perdu...),
-- on le remet en selle. Après une mort, giveDragon en recrée un dès la réapparition.
task.spawn(function()
	while true do
		task.wait(0.4)
		for player, dragon in personal do
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local seat = dragon.Parent and dragon:FindFirstChild("Seat")
			-- son joueur est à pied dans la zone sûre : le dragon rentre dormir sur son arbre
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if dragon.Parent and hrp and not dragon:GetAttribute("Rider") and not dragon:GetAttribute("Perched") and not dragon:GetAttribute("GoPerch")
				and not dragon:GetAttribute("Remount") and inSafeZone(hrp.Position) then
				park(player, dragon, os.clock() - (dragon:GetAttribute("Born") or 0) < 6)
			end
			-- filet de sécurité : un dragon tombé très bas sous la map est ramené au spawn de la base de son joueur
			local dragonRoot = dragon.Parent and dragon.PrimaryPart
			if dragonRoot and dragonRoot.Position.Y < -60 then
				local bases = workspace:FindFirstChild("all base")
				local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
				local spawn = base and base:FindFirstChild("Spawn")
				if spawn then
					dragonRoot.AssemblyLinearVelocity = Vector3.zero
					dragon:PivotTo(CFrame.new(spawn.Position) * dragon:GetPivot().Rotation)
				end
			end
			-- (le joueur n'est plus remis en selle de force : il monte et descend quand il veut)
			-- filet de sécurité : un dragon marqué "monté" alors que personne n'est assis dessus est libéré
			if seat and dragon:GetAttribute("Rider") and not seat.Occupant then
				local empty = (dragon:GetAttribute("EmptySeat") or 0) + 0.4
				if empty > 1.2 then
					dragon:SetAttribute("EmptySeat", nil)
					dismount(dragon)
				else
					dragon:SetAttribute("EmptySeat", empty)
				end
			elseif dragon.Parent and dragon:GetAttribute("EmptySeat") then
				dragon:SetAttribute("EmptySeat", nil)
			end
		end
	end
end)

-- dragons de test : un par marqueur de Workspace.DragonSpawns (attribut Level)
local spawns = workspace:FindFirstChild("DragonSpawns")
if spawns then
	for _, marker in spawns:GetChildren() do
		if marker:IsA("BasePart") then spawnDragon(marker:GetAttribute("Level") or 1, marker.CFrame) end
	end
end

-- sans cavalier, le dragon personnel reste collé à la droite de son joueur. C'est le client du joueur qui le place à chaque
-- image (script DragonClient) : aucun retard, même quand il tourne vite ou saute. Le serveur lui en donne juste le contrôle.
game:GetService("RunService").Heartbeat:Connect(function()
	for player, dragon in personal do
		local root = dragon.Parent and dragon.PrimaryPart
		if root and player.Character and not dragon:GetAttribute("Rider") and not dragon:GetAttribute("Perched") then
			if root.Anchored then root.Anchored = false end
			local drive, steer = root:FindFirstChild("Drive"), root:FindFirstChild("Steer")
			if drive and steer then drive.Enabled, steer.Enabled = true, true end
			local ok, owner = pcall(function() return root:GetNetworkOwner() end)
			if ok and owner ~= player then pcall(function() root:SetNetworkOwner(player) end) end
		end
	end
end)
