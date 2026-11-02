-- CowboyEventServer : event "COWBOY" (commande admin StartCowboyEvent, ce serveur ou tous les serveurs)
-- Un cow-boy GEANT en studs (ServerStorage.Cowboy) apparait sur la piece invisible Workspace.CowboySpawn, dans le vide
-- derriere le mur sud de la map (les joueurs ne peuvent pas y aller, mais le voient par-dessus le mur).
-- Il marche dans le vide le long du mur, en face de chaque zone d'oeufs (jambes et bras animes, revolver dans la main droite),
-- s'arrete en face de la zone, leve son revolver, vise par-dessus le mur et tire sur 2 ou 3 oeufs.
-- Pour changer l'endroit ou il marche : deplacer la piece CowboySpawn (il marche sur la ligne de cette piece).
-- Chaque oeuf touche a 10 % de chance de recevoir le COWBOY TRAIT : son poids (Kg) est multiplie par 4.
-- A la fin du temps choisi par l'admin (ou sur Stop), il disparait dans un nuage de poussiere.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartCowboyEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

------------------------------------------------------------------ REGLAGES
local TOPIC = "AdminCowboyEvent"
local TRAIT_CHANCE = 0.10      -- 10 % : chance qu'un oeuf touche recoive le trait
local TRAIT_MULT = 4           -- le poids de l'oeuf est multiplie par 4
local SHOTS_MIN, SHOTS_MAX = 2, 3 -- oeufs vises par zone
local SCALE = 45               -- taille du cow-boy (1 = taille d'un personnage normal) : geant pour qu'on le voie par-dessus le mur
local FX = SCALE / 3           -- taille des effets (poussiere, eclair du tir...)
local WALK_SPEED = 5 * SCALE   -- studs/s quand il marche (grands pas)
local DEFAULT_LANE = Vector3.new(118, 50, -490) -- si CowboySpawn n'existe pas
local TRIP_TIME = 9           -- un trajet entre deux zones dure au plus ~14 s (il accelere si la zone est loin)
local MIN_DURATION, MAX_DURATION = 10, 86400
local FEET = 3 * SCALE         -- hauteur du centre du corps au-dessus des pieds

local BROWN, GOLD, DUST = Color3.fromRGB(140, 92, 48), Color3.fromRGB(255, 205, 60), Color3.fromRGB(196, 160, 110)

local running, stopRequested = false, false
local endAt = 0

local function alive()
	return not stopRequested and workspace:GetServerTimeNow() < endAt
end

local function describe(secs)
	secs = math.floor(secs)
	local h, m, s = secs // 3600, (secs % 3600) // 60, secs % 60
	if h > 0 then return string.format("%dh%02dm", h, m) end
	if m > 0 then return string.format("%dm%02ds", m, s) end
	return s .. "s"
end

local function sleep(seconds)
	local t = 0
	while t < seconds and alive() do t += task.wait() end
end

------------------------------------------------------------------ EFFETS
local function fxPart(size, cf, color, material, transparency, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	if shape then p.Shape = shape end
	p.Material = material or Enum.Material.Neon
	p.Color = color
	p.Transparency = transparency or 0
	p.Size = size
	p.CFrame = cf
	return p
end

local function dustBurst(position, size, count)
	size *= FX
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxassetid://13346862770"
	e.FlipbookLayout, e.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	e.Rate = 0
	e.Lifetime = NumberRange.new(1, 1.8)
	e.Speed = NumberRange.new(size * 0.5, size * 1.4)
	e.SpreadAngle = Vector2.new(180, 40)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.5), NumberSequenceKeypoint.new(1, size * 1.4)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
	e.Color = ColorSequence.new(DUST, Color3.fromRGB(150, 120, 80))
	e.Drag = 2
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, 3)
end

local function shockwave(position, radius, color)
	local ring = fxPart(Vector3.new(0.5, 4, 4), CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90)), color, Enum.Material.Neon, 0.3, Enum.PartType.Cylinder)
	ring.Parent = workspace
	TweenService:Create(ring, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.5, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(ring, 0.8)
end

-- petit texte qui monte et s'efface au-dessus d'un oeuf
local function floatText(position, text, color)
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(position), color, Enum.Material.Neon, 1)
	holder.Parent = workspace
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(220, 50)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.MaxDistance = 250
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.TextScaled = true
	label.Text = text
	label.TextColor3 = color
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = label
	label.Parent = bb
	bb.Parent = holder
	TweenService:Create(holder, TweenInfo.new(1.4), {CFrame = CFrame.new(position + Vector3.new(0, 8, 0))}):Play()
	TweenService:Create(label, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
	TweenService:Create(stroke, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	Debris:AddItem(holder, 1.5)
end

------------------------------------------------------------------ COWBOY TRAIT SUR UN OEUF
local function studs(p)
	p.TopSurface, p.FrontSurface, p.BackSurface, p.LeftSurface, p.RightSurface = Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs
	p.BottomSurface = Enum.SurfaceType.Inlet
end

local function applyTrait(egg)
	local root = egg.PrimaryPart
	if not root then return end
	local oldKg = egg:GetAttribute("Kg") or 1
	local newKg = oldKg * TRAIT_MULT
	egg:SetAttribute("CowboyTrait", TRAIT_MULT)
	egg:SetAttribute("Kg", newKg)
	local height = egg:GetAttribute("Height") or 3

	-- l'etiquette du poids affiche le nouveau poids
	local gui = root:FindFirstChild("EggLabel")
	if gui then
		local oldText = Config.FormatKg(oldKg)
		for _, l in gui:GetChildren() do
			if l:IsA("TextLabel") and l.Text == oldText then
				l.Text = Config.FormatKg(newKg)
				l.TextColor3 = GOLD
				break
			end
		end
	end

	-- etiquette "COWBOY TRAIT" (au-dessus de celle de la sorciere si l'oeuf a deja le trait de la sorciere)
	local base = height * 0.98 + 1.5
	local labelH = 1.5 + height * 0.14
	local y = base + (3 + height * 0.3) / 2 + 0.4 + labelH / 2
	if root:FindFirstChild("WitchTraitLabel") then y += labelH + 0.3 end
	local bb = Instance.new("BillboardGui")
	bb.Name = "CowboyTraitLabel"
	bb.Size = UDim2.new(5.5 + height * 0.5, 0, labelH, 0)
	bb.StudsOffsetWorldSpace = Vector3.new(0, y, 0)
	bb.MaxDistance = 120 + height * 6
	bb.LightInfluence = 0
	local function text(str, pos, size, color)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = pos, size
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.Text = str
		label.TextScaled = true
		label.TextColor3 = color
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 3
		stroke.Parent = label
		CollectionService:AddTag(label, "Text3D")
		label.Parent = bb
	end
	text("COWBOY TRAIT", UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.62), GOLD)
	text("x" .. TRAIT_MULT .. " WEIGHT", UDim2.fromScale(0, 0.62), UDim2.fromScale(1, 0.38), Color3.fromRGB(120, 255, 140))
	bb.Parent = root

	-- petit chapeau de cow-boy en studs pose sur l'oeuf (seulement s'il n'a pas deja le chapeau de la sorciere)
	if not egg:FindFirstChild("WitchHat") then
		pcall(function() require(game:GetService("ReplicatedStorage").EggSystem.TraitDeco).Hat(egg, "Cowboy", {Name = "CowboyHat"}) end)
	end

	-- etincelles dorees + lueur
	local att = Instance.new("Attachment")
	att.Name = "CowboyTraitFx"
	att.Parent = root
	local fx = Instance.new("ParticleEmitter")
	fx.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	fx.Color = ColorSequence.new(GOLD, Color3.fromRGB(255, 150, 40))
	fx.LightEmission = 1
	fx.Rate = 8 + math.min(height, 20)
	fx.Lifetime = NumberRange.new(1, 2)
	fx.Speed = NumberRange.new(1, 3)
	fx.SpreadAngle = Vector2.new(180, 180)
	fx.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6 + height * 0.05), NumberSequenceKeypoint.new(1, 0)})
	fx.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
	fx.Parent = att
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = GOLD, 12 + height * 2, 2
	light.Parent = att
end

------------------------------------------------------------------ ZONES ET OEUFS
local function getZones()
	local zones = {}
	for _, c in workspace:GetChildren() do
		if c:IsA("BasePart") and string.find(string.lower(c.Name), "egg zone", 1, true) then table.insert(zones, c) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	return zones
end

local function validEgg(e)
	return e and e.Parent and e:IsA("Model") and e:GetAttribute("EggKey") and e.PrimaryPart and not e:GetAttribute("Hatching") and not e:GetAttribute("CowboyTrait")
end

-- 2 ou 3 oeufs au hasard dans la zone
local function pickEggs(zonePart)
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	local folder = zoneEggs and zoneEggs:FindFirstChild(zonePart.Name)
	if not folder then return {} end
	local list = {}
	for _, e in folder:GetChildren() do
		if validEgg(e) then table.insert(list, e) end
	end
	local picked = {}
	for _ = 1, math.random(SHOTS_MIN, SHOTS_MAX) do
		if #list == 0 then break end
		table.insert(picked, table.remove(list, math.random(#list)))
	end
	return picked
end

------------------------------------------------------------------ LE COW-BOY (animation : jambes, bras, revolver)
local function aimRotation(from, to)
	local dot = math.clamp(from:Dot(to), -1, 1)
	local axis = from:Cross(to)
	if axis.Magnitude < 1e-4 then
		if dot > 0 then return CFrame.identity end
		return CFrame.fromAxisAngle(Vector3.xAxis, math.pi)
	end
	return CFrame.fromAxisAngle(axis.Unit, math.acos(dot))
end

local function angleLerp(a, b, k)
	local d = (b - a + math.pi) % (2 * math.pi) - math.pi
	return a + d * k
end

local cowboy -- etat du cow-boy en jeu

local function spawnCowboy(position)
	local template = ServerStorage:FindFirstChild("Cowboy")
	if not template then return nil end
	local model = template:Clone()
	model.Name = "CowboyNPC"
	model:ScaleTo(SCALE)
	local root = model.PrimaryPart
	local torso = model:FindFirstChild("Torso")
	local joints = {}
	for _, name in {"LeftShoulder", "RightShoulder", "LeftHip", "RightHip", "Neck"} do
		local j = torso:FindFirstChild(name)
		joints[name] = {joint = j, base = j.C0}
	end
	local muzzle = model:FindFirstChild("Muzzle", true)
	-- poussiere sous les bottes quand il marche vite
	local feetAt = Instance.new("Attachment")
	feetAt.Position = Vector3.new(0, -FEET + 0.5, 0)
	feetAt.Parent = root
	local dust = Instance.new("ParticleEmitter")
	dust.Texture = "rbxassetid://13346862770"
	dust.FlipbookLayout, dust.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	dust.Rate = 0
	dust.Lifetime = NumberRange.new(0.8, 1.4)
	dust.Speed = NumberRange.new(2 * FX, 6 * FX)
	dust.SpreadAngle = Vector2.new(60, 20)
	dust.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2 * FX), NumberSequenceKeypoint.new(1, 6 * FX)})
	dust.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1)})
	dust.Color = ColorSequence.new(DUST)
	dust.Parent = feetAt

	cowboy = {
		model = model, root = root, torso = torso, joints = joints, muzzle = muzzle, dust = dust,
		pos = position, groundY = position.Y, yaw = 0, targetYaw = 0,
		walk = 0, walkGoal = 0, speed = WALK_SPEED, phase = 0,
		aim = 0, aimGoal = 0, aimTarget = nil, recoil = 0,
	}
	model:PivotTo(CFrame.new(position + Vector3.new(0, FEET, 0)) * CFrame.Angles(0, math.pi, 0)) -- on deplace TOUTES les pieces ensemble avant de le poser
	model.ModelStreamingMode = Enum.ModelStreamingMode.Persistent -- toujours visible, meme de loin
	model.Parent = workspace

	-- une seule boucle anime tout le corps a chaque image
	cowboy.conn = RunService.Heartbeat:Connect(function(dt)
		local c = cowboy
		if not c or not c.root.Parent then return end
		c.walk += (c.walkGoal - c.walk) * math.min(dt * 6, 1)
		c.aim += (c.aimGoal - c.aim) * math.min(dt * 7, 1)
		c.recoil = math.max(0, c.recoil - dt * 4)
		c.yaw = angleLerp(c.yaw, c.targetYaw, math.min(dt * 8, 1))
		local stepFreq = math.clamp(c.speed / (SCALE * 1.6), 1.5, 16)
		c.phase += dt * stepFreq * c.walk
		local s = math.sin(c.phase)
		local bob = c.walk * math.abs(math.cos(c.phase)) * 0.12 * SCALE
		c.root.CFrame = CFrame.new(c.pos + Vector3.new(0, FEET + bob, 0)) * CFrame.Angles(0, c.yaw, 0)

		local swing = c.walk * math.rad(38) * s
		local J = c.joints
		J.LeftHip.joint.C0 = J.LeftHip.base * CFrame.Angles(swing, 0, 0)
		J.RightHip.joint.C0 = J.RightHip.base * CFrame.Angles(-swing, 0, 0)
		J.LeftShoulder.joint.C0 = J.LeftShoulder.base * CFrame.Angles(-swing * 0.9, 0, math.rad(-6))
		-- bras droit : revolver tenu canon vers le sol devant lui en marchant, leve vers l'oeuf pour viser
		local low = CFrame.Angles(math.rad(40) + c.walk * math.rad(10) * s, 0, 0)
		local rot = low
		if c.aimTarget and c.aim > 0.01 then
			local shoulderWorld = (c.torso.CFrame * J.RightShoulder.base).Position
			local dir = c.torso.CFrame:VectorToObjectSpace(c.aimTarget - shoulderWorld)
			if dir.Magnitude > 0.1 then
				rot = low:Lerp(aimRotation(Vector3.new(0, -1, 0), dir.Unit), c.aim)
			end
		end
		rot = rot * CFrame.Angles(math.rad(24) * c.recoil, 0, 0) -- recul : le canon remonte
		J.RightShoulder.joint.C0 = CFrame.new(J.RightShoulder.base.Position) * rot
		-- la tete regarde la cible quand il vise
		J.Neck.joint.C0 = J.Neck.base * CFrame.Angles(-math.rad(8) * c.aim, 0, 0)
		c.dust.Rate = c.walk > 0.5 and 6 or 0
	end)
	return cowboy
end

local function despawnCowboy()
	local c = cowboy
	cowboy = nil
	if not c then return end
	if c.conn then c.conn:Disconnect() end
	if c.model.Parent then
		pcall(function()
			dustBurst(c.pos + Vector3.new(0, 3 * FX, 0), 6, 24)
			shockwave(c.pos + Vector3.new(0, 0.3, 0), 30 * FX, DUST)
		end)
		c.model:Destroy()
	end
end

------------------------------------------------------------------ DEPLACEMENT
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.RespectCanCollide = true

local function groundAt(x, z, fallback)
	local ignore = {}
	if cowboy then table.insert(ignore, cowboy.model) end
	for _, name in {"ZoneEggs", "Dragons", "PlacedPets", "PlacedEggs"} do
		local f = workspace:FindFirstChild(name)
		if f then table.insert(ignore, f) end
	end
	for _, p in Players:GetPlayers() do
		if p.Character then table.insert(ignore, p.Character) end
	end
	rayParams.FilterDescendantsInstances = ignore
	-- on cherche le sol seulement un peu au-dessus de la hauteur prevue : il ne grimpe jamais sur les murs
	local hit = workspace:Raycast(Vector3.new(x, fallback + 6, z), Vector3.new(0, -20, 0), rayParams)
	return hit and hit.Position.Y or fallback
end

local function faceTowards(point)
	local c = cowboy
	local d = point - c.pos
	if Vector3.new(d.X, 0, d.Z).Magnitude > 0.5 then c.targetYaw = math.atan2(-d.X, -d.Z) end
end

-- marche jusqu'a 'dest' (meme hauteur que le sol)
local function walkTo(dest)
	local c = cowboy
	if not c then return end
	local flat = Vector3.new(dest.X - c.pos.X, 0, dest.Z - c.pos.Z)
	local dist = flat.Magnitude
	if dist < 1 then return end
	c.speed = math.max(WALK_SPEED, dist / TRIP_TIME)
	faceTowards(dest)
	c.walkGoal = 1
	local nextGround = 0
	local startY = c.pos.Y
	while alive() and cowboy == c do
		local dt = RunService.Heartbeat:Wait()
		local left = Vector3.new(dest.X - c.pos.X, 0, dest.Z - c.pos.Z)
		local step = c.speed * dt
		local y = c.groundY
		nextGround -= dt
		if nextGround <= 0 then
			nextGround = 0.1
			local done = 1 - Vector3.new(dest.X - c.pos.X, 0, dest.Z - c.pos.Z).Magnitude / dist
			c.groundY = groundAt(c.pos.X, c.pos.Z, startY + (dest.Y - startY) * math.clamp(done, 0, 1))
		end
		y += (c.groundY - y) * math.min(dt * 10, 1)
		if left.Magnitude <= step then
			c.pos = Vector3.new(dest.X, y, dest.Z)
			break
		end
		local move = left.Unit * step
		c.pos = Vector3.new(c.pos.X + move.X, y, c.pos.Z + move.Z)
		faceTowards(dest)
	end
	c.walkGoal = 0
	c.speed = WALK_SPEED
end

------------------------------------------------------------------ TIR
local function fire(egg)
	local c = cowboy
	if not c or not validEgg(egg) then return end
	local height = egg:GetAttribute("Height") or 3
	local target = egg:GetPivot().Position
	-- il se tourne vers l'oeuf, leve son revolver, vise
	faceTowards(target)
	sleep(0.35)
	c.aimTarget = target
	c.aimGoal = 1
	sleep(0.9)
	if not alive() or cowboy ~= c then return end

	-- PAN !
	local from = c.muzzle and c.muzzle.WorldPosition or (c.root.Position + Vector3.new(0, SCALE, 0))
	c.recoil = 1
	local sound = ServerStorage:FindFirstChild("CowboyGunshot")
	if sound and c.muzzle then
		local s = sound:Clone()
		s.RollOffMinDistance = 60
		s.RollOffMaxDistance = 2500
		s.Volume = 2
		s.Parent = c.muzzle
		s:Play()
		Debris:AddItem(s, 4)
	end
	local flash = fxPart(Vector3.one * 2.2 * FX * 0.5, CFrame.new(from), Color3.fromRGB(255, 220, 120), Enum.Material.Neon, 0.1, Enum.PartType.Ball)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = Color3.fromRGB(255, 200, 100), 60, 6
	light.Parent = flash
	flash.Parent = workspace
	TweenService:Create(flash, TweenInfo.new(0.15), {Size = Vector3.one * 4 * FX * 0.5, Transparency = 1}):Play()
	Debris:AddItem(flash, 0.2)
	dustBurst(from, 1.5, 4)

	-- balle tracante jusqu'a l'oeuf
	local dist = (target - from).Magnitude
	local tracer = fxPart(Vector3.new(1.2, 1.2, 18), CFrame.lookAt(from, target), Color3.fromRGB(255, 230, 120), Enum.Material.Neon, 0)
	tracer.Parent = workspace
	local travel = math.clamp(dist / 500, 0.06, 0.3)
	local tw = TweenService:Create(tracer, TweenInfo.new(travel, Enum.EasingStyle.Linear), {CFrame = CFrame.lookAt(target, target + (target - from))})
	tw:Play()
	tw.Completed:Wait()
	tracer:Destroy()

	-- impact : 10 % de chance d'avoir le COWBOY TRAIT x4
	if validEgg(egg) then
		local sparks = Instance.new("Attachment")
		sparks.WorldPosition = target
		sparks.Parent = workspace.Terrain
		local e = Instance.new("ParticleEmitter")
		e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		e.Rate = 0
		e.LightEmission = 1
		e.Speed = NumberRange.new(10, 30)
		e.SpreadAngle = Vector2.new(180, 180)
		e.Lifetime = NumberRange.new(0.4, 0.9)
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
		e.Parent = sparks
		Debris:AddItem(sparks, 1.5)
		if math.random() < TRAIT_CHANCE then
			e.Color = ColorSequence.new(GOLD, Color3.fromRGB(120, 255, 140))
			e:Emit(70)
			shockwave(target - Vector3.new(0, height / 2 - 0.3, 0), 10 + height * 2, GOLD)
			local pillar = fxPart(Vector3.new(height * 0.9 + 3, 120, height * 0.9 + 3), CFrame.new(target + Vector3.new(0, 60, 0)), GOLD, Enum.Material.Neon, 0.5)
			pillar.Parent = workspace
			TweenService:Create(pillar, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = Vector3.new(0.3, 120, 0.3), Transparency = 1}):Play()
			Debris:AddItem(pillar, 1)
			local info = Config.Eggs[egg:GetAttribute("EggKey")]
			applyTrait(egg)
			floatText(target + Vector3.new(0, height, 0), "x" .. TRAIT_MULT .. " COWBOY TRAIT!", GOLD)
			local zone = egg.Parent and egg.Parent.Name or "a zone"
			notifyRemote:FireAllClients("COWBOY TRAIT! A " .. (info and info.Name or "egg") .. " got x" .. TRAIT_MULT .. " weight in the " .. zone .. "!")
		else
			e.Color = ColorSequence.new(Color3.fromRGB(200, 200, 200), Color3.fromRGB(130, 130, 130))
			e:Emit(18)
			floatText(target + Vector3.new(0, height * 0.7, 0), "No luck...", Color3.fromRGB(220, 220, 220))
		end
	end
	sleep(0.45)
	c.aimGoal = 0
	sleep(0.35)
	c.aimTarget = nil
end

------------------------------------------------------------------ EVENT
local function runEvent(duration)
	if running then return end
	local zones = getZones()
	if #zones == 0 or not ServerStorage:FindFirstChild("Cowboy") then
		warn("[CowboyEvent] ServerStorage.Cowboy or egg zones not found")
		return
	end
	running, stopRequested = true, false
	endAt = workspace:GetServerTimeNow() + duration
	ReplicatedStorage:SetAttribute("CowboyEventEnd", endAt)

	local ok, err = pcall(function()
		-- point d'apparition : la piece Workspace.CowboySpawn (dans le vide derriere le mur sud)
		local spawnPart = workspace:FindFirstChild("CowboySpawn")
		local startPos = DEFAULT_LANE
		if spawnPart and spawnPart:IsA("BasePart") then
			startPos = spawnPart.Position + Vector3.new(0, spawnPart.Size.Y / 2, 0)
		end
		local laneY, laneZ = startPos.Y, startPos.Z -- il marche toujours sur cette ligne, le long du mur
		local index, best = 1, math.huge
		for i, z in zones do
			local d = math.abs(z.Position.X - startPos.X)
			if d < best then best, index = d, i end
		end

		-- entree : nuage de poussiere et onde de choc
		dustBurst(startPos + Vector3.new(0, 3 * FX, 0), 7, 28)
		shockwave(startPos + Vector3.new(0, 0.3, 0), 35 * FX, DUST)
		local c = spawnCowboy(startPos)
		if not c then return end
		c.targetYaw = math.atan2(0, -1) -- il regarde vers la map
		c.yaw = c.targetYaw
		sleep(2)

		local dir = 1
		while alive() do
			local zone = zones[index]
			if zone and zone.Parent then
				-- il marche (dans le vide, le long du mur) jusqu'en face de la zone, puis se tourne vers elle
				local dest = Vector3.new(zone.Position.X + (math.random() - 0.5) * zone.Size.X * 0.4, laneY, laneZ)
				walkTo(dest)
				if cowboy then faceTowards(zone.Position) end
				if not alive() then break end
				sleep(0.4)
				for _, egg in pickEggs(zone) do
					if not alive() then break end
					fire(egg)
				end
				sleep(0.6)
			end
			-- zone suivante (il fait demi-tour au bout de la map)
			if #zones > 1 then
				if not zones[index + dir] then dir = -dir end
				index += dir
			end
		end
	end)
	if not ok then warn("[CowboyEvent] error: " .. tostring(err)) end

	despawnCowboy()
	ReplicatedStorage:SetAttribute("CowboyEventEnd", nil)
	running, stopRequested = false, false
end

------------------------------------------------------------------ COMMANDE ADMIN + TOUS LES SERVEURS
local function handle(action, duration)
	if action == "start" then
		if running then return end
		announceRemote:FireAllClients("EVENT", "COWBOY TIME! A cowboy is shooting eggs in the zones for " .. describe(duration) .. " (x" .. TRAIT_MULT .. " weight trait!)", 0)
		task.spawn(runEvent, duration)
	elseif action == "stop" then
		stopRequested = true
	end
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" then
			handle(data.action, math.clamp(tonumber(data.duration) or 600, MIN_DURATION, MAX_DURATION))
		end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, action, duration, scope) -- scope "server" = ce serveur seulement
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if action ~= "start" and action ~= "stop" then return end
	duration = math.clamp(tonumber(duration) or 600, MIN_DURATION, MAX_DURATION)
	if action == "start" and running then
		notifyRemote:FireClient(player, "The cowboy is already here")
		return
	end
	local ok = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {action = action, duration = duration}) end)
	if not ok then handle(action, duration) end -- Studio : ce serveur seulement
	notifyRemote:FireClient(player, action == "start" and ("Cowboy event started (" .. describe(duration) .. ")") or "Cowboy event stopped")
end)
