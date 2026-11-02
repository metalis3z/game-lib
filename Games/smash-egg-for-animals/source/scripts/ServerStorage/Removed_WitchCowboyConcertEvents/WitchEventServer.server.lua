-- WitchEventServer : event "SORCIERE TIME" (commande admin StartWitchEvent, tous les serveurs)
-- La sorciere du Workspace (Workspace.Sorciere) grandit, decolle et survole toutes les zones d'oeufs
-- pendant la duree choisie par l'admin, puis rentre se poser a sa place d'origine.
-- Toutes les 5 secondes elle jette un sort sur un oeuf : il fonctionne a tous les coups (100 %),
-- son poids (Kg) est alors multiplie et l'etiquette "SORCIERE TRAIT" s'affiche au-dessus de l'oeuf.
-- Pendant l'event l'ecran devient sombre et un HUD (image de sorciere + timer) s'affiche en bas a droite (WitchEventClient).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartWitchEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

------------------------------------------------------------------ REGLAGES
local TOPIC = "AdminWitchEvent"
local TRAIT_CHANCE = 0.2                    -- 100 % : chaque sort lance sur un oeuf fonctionne
local TRAIT_MULTS = {{2, 50}, {3, 30}, {5, 15}, {10, 5}} -- {multiplicateur de poids, poids du tirage en %}
local SCALE = 3                           -- taille de la sorciere en vol
local FLY_HEIGHT = 120                    -- hauteur au-dessus du sol des zones
local TRANSIT_SPEED = 320                 -- studs/s entre deux zones
local RETURN_SPEED = 600                  -- studs/s pour rentrer a sa place a la fin
local SWEEP_TIME = 26                     -- secondes passees a balayer chaque zone
local BOLT_MIN, BOLT_MAX = 0.85, 0.85           -- un sort toutes les 5 secondes
local INTRO_TIME = 4                      -- l'ecran s'assombrit avant que la sorciere bouge
local GROW_TIME = 1.5                     -- temps pour qu'elle grandisse
local MIN_DURATION, MAX_DURATION = 10, 86400
local TIP_OFFSET = Vector3.new(8.7, -2.75, -2.15) -- bout du balai par rapport a la tete (avant mise a l'echelle)

local running, stopRequested = false, false
local endAt = 0
local clockTime, curYaw, targetYaw = 0, 0, 0
local R0 = CFrame.new()

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

local function rollMult()
	local total = 0
	for _, e in TRAIT_MULTS do total += e[2] end
	local roll = math.random() * total
	for _, e in TRAIT_MULTS do
		roll -= e[2]
		if roll <= 0 then return e[1] end
	end
	return TRAIT_MULTS[1][1]
end

------------------------------------------------------------------ IMAGE DE LA TETE DE LA SORCIERE (au-dessus d'un oeuf qui prend le trait)
local headTemplate -- nil = pas encore cree, false = impossible
local function getHeadTemplate()
	if headTemplate ~= nil then return headTemplate or nil end
	headTemplate = false
	local icon = ReplicatedStorage:FindFirstChild("SorciereIcon")
	if icon and icon:IsA("Model") and icon.PrimaryPart then
		pcall(function()
			local m = icon:Clone()
			local head = m.PrimaryPart
			local hy = head.Position.Y
			for _, d in m:GetDescendants() do
				if d:IsA("BasePart") and d ~= head and d.Position.Y - hy < -2.5 then d:Destroy() end -- on ne garde que la tete et le chapeau
			end
			headTemplate = m
		end)
	end
	return headTemplate or nil
end

function addHeadIcon(root, offsetY, size)
	local tpl = getHeadTemplate()
	if not tpl then return end
	local bb = Instance.new("BillboardGui")
	bb.Name = "WitchHeadIcon"
	bb.Size = UDim2.new(size, 0, size, 0)
	bb.StudsOffsetWorldSpace = Vector3.new(0, offsetY, 0)
	bb.MaxDistance = 300
	bb.LightInfluence = 0
	local vp = Instance.new("ViewportFrame")
	vp.BackgroundColor3 = Color3.fromRGB(45, 20, 70)
	vp.BackgroundTransparency = 0.25
	vp.Size = UDim2.fromScale(1, 1)
	vp.Ambient = Color3.fromRGB(190, 160, 220)
	vp.LightColor = Color3.fromRGB(255, 235, 255)
	vp.LightDirection = Vector3.new(-0.4, -0.6, 0.7)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.5, 0)
	corner.Parent = vp
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(190, 90, 255)
	stroke.Thickness = 3
	stroke.Parent = vp
	local m = tpl:Clone()
	m.Parent = vp
	local head = m.PrimaryPart
	local cf = head.CFrame
	local target = head.Position + Vector3.new(0, 1.7, 0)
	local camPos = target + cf.LookVector * 8.5 + cf.RightVector * 0.8 + Vector3.new(0, 0.5, 0)
	local cam = Instance.new("Camera")
	cam.FieldOfView = 50
	cam.CFrame = CFrame.lookAt(camPos, target)
	cam.Parent = vp
	vp.CurrentCamera = cam
	vp.Parent = bb
	bb.Parent = root
end

------------------------------------------------------------------ EFFETS (aura, entree, trainee, impact)
local PURPLE, PINK, DEEP = Color3.fromRGB(190, 90, 255), Color3.fromRGB(255, 130, 230), Color3.fromRGB(70, 20, 120)
local PUFF = "rbxassetid://13346862770" -- volute de fumee animee (4x4)

local function fxPart(size, cf, color, material, transparency, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if shape then p.Shape = shape end
	p.Material = material or Enum.Material.Neon
	p.Color = color
	p.Transparency = transparency or 0
	p.Size = size
	p.CFrame = cf
	return p
end

-- eclair violet en zigzag entre deux points
local function lightning(from, to, thickness, life)
	local previous, steps = from, 9
	for i = 1, steps do
		local point = from:Lerp(to, i / steps)
		if i < steps then point += Vector3.new(math.random() - 0.5, 0, math.random() - 0.5) * 22 end
		local seg = fxPart(Vector3.new(thickness, thickness, (point - previous).Magnitude), CFrame.lookAt((previous + point) / 2, point), i % 2 == 0 and PURPLE or Color3.new(1, 1, 1))
		seg.Parent = workspace
		TweenService:Create(seg, TweenInfo.new(life), {Transparency = 1, Size = Vector3.new(thickness * 0.2, thickness * 0.2, seg.Size.Z)}):Play()
		Debris:AddItem(seg, life + 0.05)
		previous = point
	end
end

-- onde de choc a plat qui s'elargit
local function shockwave(position, radius, color, time)
	local ring = fxPart(Vector3.new(0.6, 4, 4), CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90)), color, Enum.Material.Neon, 0.3, Enum.PartType.Cylinder)
	ring.Parent = workspace
	TweenService:Create(ring, TweenInfo.new(time or 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.6, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(ring, (time or 0.7) + 0.1)
end

local function smokeBurst(position, size, count)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Texture = PUFF
	e.FlipbookLayout, e.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	e.Rate = 0
	e.Lifetime = NumberRange.new(1.2, 2.2)
	e.Speed = NumberRange.new(size * 0.6, size * 1.6)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.4), NumberSequenceKeypoint.new(1, size * 1.3)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
	e.Color = ColorSequence.new(PURPLE, DEEP)
	e.Drag = 2
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, 3)
end

-- ENTREE : le ciel la frappe de trois eclairs, fumee violette, ondes de choc, colonne de lumiere
local function entranceFx(position, feetY)
	local ground = Vector3.new(position.X, feetY + 0.3, position.Z)
	local pillar = fxPart(Vector3.new(14, 400, 14), CFrame.new(ground + Vector3.new(0, 200, 0)), PURPLE, Enum.Material.Neon, 0.55)
	pillar.Parent = workspace
	TweenService:Create(pillar, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = Vector3.new(0.5, 400, 0.5), Transparency = 1}):Play()
	Debris:AddItem(pillar, 1.7)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = PURPLE, 60, 8
	local holder = fxPart(Vector3.one, CFrame.new(ground + Vector3.new(0, 8, 0)), PURPLE, Enum.Material.Neon, 1)
	light.Parent = holder
	holder.Parent = workspace
	TweenService:Create(light, TweenInfo.new(1.8), {Brightness = 0}):Play()
	Debris:AddItem(holder, 2)
	for i = 1, 3 do
		lightning(ground + Vector3.new((math.random() - 0.5) * 60, 260, (math.random() - 0.5) * 60), ground, 2.2, 0.35)
		shockwave(ground, 30 + i * 22, i % 2 == 0 and PINK or PURPLE, 0.8)
		smokeBurst(ground + Vector3.new(0, 4, 0), 9, 14)
		task.wait(0.3)
	end
end

-- TRAINEE DE VOL : etoiles et fumee violette qui s'echappent du balai, halo violet autour d'elle
local function addFlightFx(root)
	local at = Instance.new("Attachment")
	at.Name = "WitchFlightFx"
	at.Parent = root
	local stars = Instance.new("ParticleEmitter")
	stars.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	stars.Rate = 60
	stars.Lifetime = NumberRange.new(1.2, 2.4)
	stars.Speed = NumberRange.new(2, 8)
	stars.SpreadAngle = Vector2.new(180, 180)
	stars.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3.2), NumberSequenceKeypoint.new(1, 0)})
	stars.Color = ColorSequence.new(PINK, PURPLE)
	stars.LightEmission = 1
	stars.RotSpeed = NumberRange.new(-180, 180)
	stars.Parent = at
	local smoke = Instance.new("ParticleEmitter")
	smoke.Texture = PUFF
	smoke.FlipbookLayout, smoke.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	smoke.Rate = 14
	smoke.Lifetime = NumberRange.new(1.5, 2.5)
	smoke.Speed = NumberRange.new(1, 4)
	smoke.SpreadAngle = Vector2.new(180, 180)
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5), NumberSequenceKeypoint.new(1, 14)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1)})
	smoke.Color = ColorSequence.new(PURPLE, DEEP)
	smoke.Parent = at
	local halo = Instance.new("PointLight")
	halo.Color, halo.Range, halo.Brightness = PURPLE, 70, 3
	halo.Parent = at
	return at
end

-- IMPACT d'un sort reussi : colonne de lumiere, onde de choc, eclair, fumee
local function impactFx(position, height)
	local pillar = fxPart(Vector3.new(height * 0.9 + 3, 120, height * 0.9 + 3), CFrame.new(position + Vector3.new(0, 60, 0)), PURPLE, Enum.Material.Neon, 0.5)
	pillar.Parent = workspace
	TweenService:Create(pillar, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = Vector3.new(0.3, 120, 0.3), Transparency = 1}):Play()
	Debris:AddItem(pillar, 1)
	-- (onde de choc retirée)
	lightning(position + Vector3.new(0, 150, 0), position, 1.4, 0.3)
	smokeBurst(position, 3 + height * 0.5, 10)
end

-- AURA d'un oeuf ensorcele : bulle magique qui pulse, cercle de runes au sol, orbes qui tournent (animees par WitchEventClient),
-- fumee violette qui monte et lueur violette
local function addAura(egg, root, height)
	local folder = Instance.new("Folder")
	folder.Name = "WitchAura"
	local center = egg:GetPivot().Position
	local feet = center - Vector3.new(0, height / 2 - 0.2, 0)
	for i, spec in {} do
		local circle = fxPart(Vector3.new(0.15, height * spec[1] * 2, height * spec[1] * 2), CFrame.new(feet + Vector3.new(0, i * 0.04, 0)) * CFrame.Angles(0, 0, math.rad(90)), spec[2], Enum.Material.Neon, spec[3], Enum.PartType.Cylinder)
		circle.Name = "Circle"
		circle.Parent = folder
	end
	for i = 1, 6 do -- orbes : petits losanges lumineux en orbite
		local orb = fxPart(Vector3.one * (0.35 + height * 0.07), CFrame.new(center), i % 2 == 0 and PINK or PURPLE)
		orb.Name = "Orb"
		orb:SetAttribute("Center", center)
		orb:SetAttribute("Radius", height * (0.85 + (i % 3) * 0.12))
		orb:SetAttribute("Phase", i / 6 * math.pi * 2)
		orb:SetAttribute("Lift", (i % 2 == 0 and 0.25 or -0.15) * height)
		orb:SetAttribute("Speed", i % 2 == 0 and 2.2 or -1.6)
		CollectionService:AddTag(orb, "WitchOrb")
		orb.Parent = folder
	end
	local at = Instance.new("Attachment")
	at.Name = "WitchAuraFx"
	at.Position = Vector3.new(0, -height / 2 + 0.3, 0)
	at.Parent = root
	local smoke = Instance.new("ParticleEmitter")
	smoke.Texture = PUFF
	smoke.FlipbookLayout, smoke.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	smoke.Rate = 5
	smoke.Lifetime = NumberRange.new(1.6, 2.6)
	smoke.Speed = NumberRange.new(height * 0.3, height * 0.7)
	smoke.EmissionDirection = Enum.NormalId.Top
	smoke.SpreadAngle = Vector2.new(25, 25)
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, height * 0.5), NumberSequenceKeypoint.new(1, height * 1.1)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.6), NumberSequenceKeypoint.new(1, 1)})
	smoke.Color = ColorSequence.new(PURPLE, DEEP)
	smoke.Parent = at
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = PURPLE, 14 + height * 2, 2.5
	light.Parent = at
	folder.Parent = egg
end

------------------------------------------------------------------ TRAIT SUR UN OEUF
local function applyTrait(egg)
	local root = egg.PrimaryPart
	if not root then return end
	local oldKg = egg:GetAttribute("Kg") or 1
	local mult = rollMult()
	local newKg = oldKg * mult
	egg:SetAttribute("WitchTrait", mult)
	egg:SetAttribute("Kg", newKg)
	local height = egg:GetAttribute("Height") or 3

	-- l'etiquette du poids affiche le nouveau poids
	local gui = root:FindFirstChild("EggLabel")
	if gui then
		local oldText = Config.FormatKg(oldKg)
		for _, l in gui:GetChildren() do
			if l:IsA("TextLabel") and l.Text == oldText then
				l.Text = Config.FormatKg(newKg)
				l.TextColor3 = Color3.fromRGB(215, 150, 255)
				break
			end
		end
	end

	-- etiquette "SORCIERE TRAIT" au-dessus de l'etiquette de l'oeuf
	local base = height * 0.98 + 1.5
	local labelH = 1.5 + height * 0.14
	local bb = Instance.new("BillboardGui")
	bb.Name = "WitchTraitLabel"
	bb.Size = UDim2.new(5.5 + height * 0.5, 0, labelH, 0)
	bb.StudsOffsetWorldSpace = Vector3.new(0, base + (3 + height * 0.3) / 2 + 0.4 + labelH / 2, 0)
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
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label
		CollectionService:AddTag(label, "Text3D")
		label.Parent = bb
		return label
	end
	text("WITCH TRAIT", UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.62), Color3.fromRGB(190, 90, 255))
	text("x" .. mult .. " WEIGHT", UDim2.fromScale(0, 0.62), UDim2.fromScale(1, 0.38), Color3.fromRGB(120, 255, 140))
	bb.Parent = root

	-- image de la tete de la sorciere au-dessus de l'etiquette
	local labelCenter = base + (3 + height * 0.3) / 2 + 0.4 + labelH / 2
	local iconSize = 5 + height * 0.4
	local okIcon, errIcon = true, nil -- (plus de rond avec la tête de la sorcière au-dessus de l'œuf)
	if not okIcon then warn("[WitchEvent] head icon failed: " .. tostring(errIcon)) end

	-- etincelles violettes sur l'oeuf qui a le trait
	local att = Instance.new("Attachment")
	att.Name = "WitchTraitFx"
	att.Parent = root
	local fx = Instance.new("ParticleEmitter")
	fx.Color = ColorSequence.new(Color3.fromRGB(190, 90, 255), Color3.fromRGB(255, 130, 230))
	fx.LightEmission = 1
	fx.Rate = 8 + math.min(height, 20)
	fx.Lifetime = NumberRange.new(1, 2)
	fx.Speed = NumberRange.new(1, 3)
	fx.SpreadAngle = Vector2.new(180, 180)
	fx.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6 + height * 0.05), NumberSequenceKeypoint.new(1, 0)})
	fx.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
	fx.Parent = att
	-- chapeau de sorcière posé sur l'œuf : on voit tout de suite qu'il a la mutation
	pcall(function() require(game:GetService("ReplicatedStorage").EggSystem.TraitDeco).Hat(egg, "Witch", {Name = "WitchHat"}) end) -- posé sur le haut de la coquille
	local okAura, errAura = pcall(addAura, egg, root, height)
	if not okAura then warn("[WitchEvent] aura failed: " .. tostring(errAura)) end
end

------------------------------------------------------------------ TRAIT MAGIQUE (projectile)
local function pickEgg(zonePart)
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	local folder = zoneEggs and zoneEggs:FindFirstChild(zonePart.Name)
	if not folder then return nil end
	local list = {}
	for _, e in folder:GetChildren() do
		if e:IsA("Model") and e:GetAttribute("EggKey") and e.PrimaryPart and not e:GetAttribute("WitchTrait") and not e:GetAttribute("Hatching") then
			table.insert(list, e)
		end
	end
	if #list == 0 then return nil end
	return list[math.random(#list)]
end

-- lance un trait magique depuis 'from' (la main de la sorciere) vers l'oeuf
local function launchBolt(egg, from)
	if not egg or not egg.Parent then return end
	local height = egg:GetAttribute("Height") or 3
	local target = egg:GetPivot().Position + Vector3.new(0, height * 0.4, 0)

	local ball = Instance.new("Part")
	ball.Name = "WitchBolt"
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(7, 7, 7)
	ball.Material = Enum.Material.Neon
	ball.Color = Color3.fromRGB(190, 90, 255)
	ball.Anchored, ball.CanCollide, ball.CanQuery, ball.CanTouch = true, false, false, false
	ball.Position = from
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = Vector3.new(0, 3, 0), Vector3.new(0, -3, 0)
	a0.Parent, a1.Parent = ball, ball
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Lifetime = 0.6
	trail.Color = ColorSequence.new(Color3.fromRGB(190, 90, 255), Color3.fromRGB(255, 130, 230))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
	trail.LightEmission = 1
	trail.Parent = ball
	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(190, 90, 255)
	light.Range = 30
	light.Brightness = 3
	light.Parent = ball
	ball.Parent = workspace

	local dur = math.clamp((target - from).Magnitude / 220, 0.5, 1.4)
	local tween = TweenService:Create(ball, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = target})
	tween:Play()
	tween.Completed:Wait()

	-- impact : 10 % de chance que l'oeuf prenne le trait
	local success = egg.Parent ~= nil and not egg:GetAttribute("WitchTrait") and not egg:GetAttribute("Hatching") and math.random() < TRAIT_CHANCE
	local att = Instance.new("Attachment")
	att.Parent = ball
	local burst = Instance.new("ParticleEmitter")
	burst.Rate = 0
	burst.LightEmission = 1
	burst.Speed = NumberRange.new(15, 40)
	burst.SpreadAngle = Vector2.new(180, 180)
	burst.Lifetime = NumberRange.new(0.5, 1)
	burst.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 0)})
	burst.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
	burst.Color = success and ColorSequence.new(Color3.fromRGB(120, 255, 140), Color3.fromRGB(190, 90, 255)) or ColorSequence.new(Color3.fromRGB(110, 110, 130))
	burst.Parent = att
	burst:Emit(success and 70 or 15)
	if success then
		task.spawn(impactFx, target, height)
		ball.Color = Color3.fromRGB(120, 255, 140)
		light.Color = Color3.fromRGB(120, 255, 140)
		applyTrait(egg)
	else
		ball.Color = Color3.fromRGB(110, 110, 130)
		light.Color = Color3.fromRGB(110, 110, 130)
	end
	trail.Enabled = false
	TweenService:Create(ball, TweenInfo.new(0.5), {Size = Vector3.new(success and 24 or 10, success and 24 or 10, success and 24 or 10), Transparency = 1}):Play()
	Debris:AddItem(ball, 1.5)
end


------------------------------------------------------------------ ANIMATION DE LA SORCIERE
-- Les pieces sont regroupees (bras qui lance, balai + autre bras, chapeau, cheveux, jupe, bottes).
-- Chaque groupe est relie a la tete par un Weld dont on anime le C0 a chaque image :
--  * en vol : chapeau, cheveux et jupe flottent vers l'arriere, les jambes se balancent, le balai tangue
--  * a chaque trait : le bras se leve (une boule magique grossit dans la main), lance vers l'oeuf vise, puis revient
local WINDUP, THROW_T, HOLD_T, RETURN_T = 0.3, 0.12, 0.15, 0.25
local anim = {ready = false, groups = {}, t = 0, wind = 0.6, throw = nil, orb = nil, hand = nil, shoulder = nil, restDir = nil}

local HAT_NAMES = {Bord = true, BordDessus = true, Bandeau = true, BoucleChapeau = true, BoucleChapeauCreux = true, PointeChapeau = true, PompomChapeau = true}
local ARM_NAMES = {Epaule = true, HautBras = true, Manche = true, Poignet = true, AvantBras = true, Poing = true, Pouce = true, Baguette = true, BaguetteAnneau = true, BaguetteEtoile = true}
local BOOT_NAMES = {SemelleBotte = true, Botte = true, PointeBotte = true, BoucleBotte = true, ReversBotte = true, Bas = true}
local HAIR_BACK = {CheveuxDos = true, CheveuxLongs1 = true, CheveuxLongs2 = true, CheveuxPointe = true}
local HAIR_SIDE = {CheveuxCote = true, MecheCote = true}
local ROBE_LAYERS = {"Robe1", "Robe2", "Robe3", "Robe4"}

local function ease(a)
	a = math.clamp(a, 0, 1)
	return a * a * (3 - 2 * a)
end

-- rotation autour d'un point (dans le repere de la tete)
local function rotAbout(pivot, rotation)
	return CFrame.new(pivot) * rotation * CFrame.new(-pivot)
end

-- rotation qui amene la direction 'from' sur la direction 'to'
local function aimRotation(from, to)
	local dot = math.clamp(from:Dot(to), -1, 1)
	local axis = from:Cross(to)
	if axis.Magnitude < 1e-4 then
		if dot > 0 then return CFrame.identity end
		local perp = math.abs(from.Y) < 0.9 and Vector3.yAxis or Vector3.xAxis
		return CFrame.fromAxisAngle(from:Cross(perp).Unit, math.pi)
	end
	return CFrame.fromAxisAngle(axis.Unit, math.acos(dot))
end

-- classe les pieces de la sorciere en groupes et les relie a la tete (appele une seule fois, sans yield)
local function buildGroups(witch, root, welds)
	local balai = witch:FindFirstChild("Balai")
	local cf = root.CFrame
	local groups, order, rigid, robeStars, refs = {}, {}, {}, {}, {}
	local function add(name, part)
		local g = groups[name]
		if not g then
			g = {parts = {}}
			groups[name] = g
			table.insert(order, name)
		end
		table.insert(g.parts, part)
	end

	for _, d in witch:GetDescendants() do
		if d:IsA("BasePart") and d ~= root then
			local n = d.Name
			local r = cf:PointToObjectSpace(d.Position)
			local group
			if balai and d:IsDescendantOf(balai) then
				group = "Broom"
			elseif HAT_NAMES[n] or string.sub(n, 1, 7) == "Chapeau" then
				group = "Hat"
			elseif n == "Etoile" then
				if r.Y > 0 then
					group = "Hat"
				else
					table.insert(robeStars, {part = d, y = r.Y})
					group = "skip"
				end
			elseif ARM_NAMES[n] then
				group = (r.X > 0) and "ArmR" or "Broom" -- l'autre bras tient le balai
			elseif BOOT_NAMES[n] then
				group = (r.X > 0) and "BootR" or "BootL"
			elseif HAIR_BACK[n] then
				group = "HairBack"
			elseif HAIR_SIDE[n] then
				group = (r.X > 0) and "HairR" or "HairL"
			elseif n == "OurletOr" or n == "Robe1" then
				group = "Robe1"
			elseif n == "Robe2" or n == "Robe3" or n == "Robe4" then
				group = n
			end
			if n == "Bord" then refs.Bord = r
			elseif n == "Ceinture" then refs.Waist = r
			elseif n == "OurletOr" then refs.HemY = r.Y
			elseif n == "Epaule" and r.X > 0 then refs.Shoulder = r
			elseif n == "Poing" and group == "ArmR" then refs.Fist, refs.Hand = r, d
			end
			if n == "Robe1" or n == "Robe2" or n == "Robe3" or n == "Robe4" then refs[n] = r.Y end

			if group == "skip" then
				-- etoile de la jupe : ajoutee plus bas a la couche la plus proche
			elseif group then
				add(group, d)
			else
				table.insert(rigid, d)
			end
		end
	end
	for _, s in robeStars do
		local best, bestDist = "Robe1", math.huge
		for _, name in ROBE_LAYERS do
			local y = refs[name]
			if y and math.abs(y - s.y) < bestDist then best, bestDist = name, math.abs(y - s.y) end
		end
		add(best, s.part)
	end

	-- chaque groupe : pieces soudees entre elles + un Weld anime vers la tete
	for _, name in order do
		local g = groups[name]
		local anchor = g.parts[1]
		for i = 2, #g.parts do
			local w = Instance.new("WeldConstraint")
			w.Part0, w.Part1 = anchor, g.parts[i]
			w.Parent = anchor
			table.insert(welds, w)
		end
		g.base = cf:ToObjectSpace(anchor.CFrame)
		local joint = Instance.new("Weld")
		joint.Part0, joint.Part1 = root, anchor
		joint.C0 = g.base
		joint.Parent = root
		table.insert(welds, joint)
		g.joint = joint
	end
	for _, part in rigid do
		local w = Instance.new("WeldConstraint")
		w.Part0, w.Part1 = root, part
		w.Parent = root
		table.insert(welds, w)
	end

	-- points autour desquels chaque groupe bouge
	local function pivotOf(name, value)
		if groups[name] then groups[name].pivot = value end
	end
	local headTop = Vector3.new(0, 1.1 * SCALE, 0)
	local waist = refs.Waist or Vector3.new(0, -2 * SCALE, 0)
	pivotOf("Hat", refs.Bord or Vector3.new(0, 4 * SCALE, 0))
	pivotOf("HairBack", headTop)
	pivotOf("HairR", headTop)
	pivotOf("HairL", headTop)
	for _, name in ROBE_LAYERS do pivotOf(name, waist) end
	for _, name in {"BootR", "BootL"} do
		local g = groups[name]
		if g then g.pivot = Vector3.new(cf:PointToObjectSpace(g.parts[1].Position).X, refs.HemY or waist.Y, 0) end
	end
	if groups.Broom then groups.Broom.pivot = cf:PointToObjectSpace(groups.Broom.parts[1].Position) end

	anim.groups, anim.t, anim.throw, anim.orb = groups, 0, nil, nil
	anim.hand, anim.shoulder, anim.restDir = nil, nil, nil -- c'est le BALAI qui lance les traits (plus le bras)
	-- bout du balai (cote des poils, +X) : c'est de la que part chaque trait magique
	anim.tipPart, anim.broomPivot, anim.broomDir = nil, nil, nil
	local bg = groups.Broom
	if bg and bg.pivot then
		local best = -math.huge
		for _, p in bg.parts do
			local x = cf:PointToObjectSpace(p.Position).X
			if x > best then best, anim.tipPart = x, p end
		end
		if anim.tipPart then
			anim.broomPivot = bg.pivot
			local v = cf:PointToObjectSpace(anim.tipPart.Position) - bg.pivot
			anim.broomDir = v.Magnitude > 0.1 and v.Unit or Vector3.xAxis
		end
	end
	-- baguette magique (main droite) : c'est elle qui lance les sorts, le bras vise l'œuf
	local wandTip = witch:FindFirstChild("BaguetteEtoile", true)
	anim.useWand = false
	if wandTip and refs.Shoulder then
		anim.useWand = true
		anim.hand, anim.shoulder = wandTip, refs.Shoulder
		local v = cf:PointToObjectSpace(wandTip.Position) - refs.Shoulder
		anim.restDir = v.Magnitude > 0.1 and v.Unit or Vector3.new(0, 0, -1)
		anim.tipPart = wandTip
	end
	anim.mount = 0
	anim.ready = true
end

-- remet toutes les pieces dans leur pose normale
local function neutralizeAnim()
	anim.ready = false
	anim.mount = 0
	anim.throw = nil
	if anim.orb then
		anim.orb:Destroy()
		anim.orb = nil
	end
	for _, g in anim.groups do
		if g.joint and g.joint.Parent then g.joint.C0 = g.base end
	end
	anim.groups = {}
end

-- boule de magie qui grossit dans la main pendant que la sorciere arme son bras
local function startThrow(egg)
	anim.throw = {t = 0, egg = egg, released = false}
	local orb = Instance.new("Part")
	orb.Name = "WitchOrb"
	orb.Shape = Enum.PartType.Ball
	orb.Material = Enum.Material.Neon
	orb.Color = Color3.fromRGB(190, 90, 255)
	orb.Size = Vector3.one * SCALE * 0.4
	orb.Massless = true
	orb.CanCollide, orb.CanQuery, orb.CanTouch = false, false, false
	orb.CFrame = anim.tipPart.CFrame
	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(190, 90, 255)
	light.Range = 30
	light.Brightness = 4
	light.Parent = orb
	orb.Parent = workspace
	local w = Instance.new("WeldConstraint")
	w.Part0, w.Part1 = anim.tipPart, orb
	w.Parent = orb
	anim.orb = orb
end

local function updateAnim(dt, root)
	local G = anim.groups
	anim.t += dt
	local t, wind = anim.t, anim.wind
	local function set(name, offset)
		local g = G[name]
		if g and g.joint.Parent then g.joint.C0 = offset * g.base end
	end
	local function swing(phase, base, amp, speed)
		return math.rad(base + amp * math.sin(t * speed + phase))
	end

	-- balai (tenu par l'autre bras) : rebond et petit tangage
	local broomT = CFrame.new(0, math.sin(t * 2.6) * 0.35 * SCALE, 0)
	if G.Broom and G.Broom.pivot then
		broomT = broomT * rotAbout(G.Broom.pivot, CFrame.Angles(0, 0, math.rad(2.5 * math.sin(t * 2.1))))
	end
	-- lancer : le balai se leve (une boule magique grossit au bout), fouette vers l'oeuf vise, puis revient
	local flick = CFrame.identity
	local th = anim.throw
	if th and anim.tipPart and anim.broomPivot and not anim.useWand then
		th.t += dt
		local egg = th.egg
		if egg and egg.Parent then
			th.target = egg:GetPivot().Position + Vector3.new(0, (egg:GetAttribute("Height") or 3) * 0.4, 0)
		end
		if th.target then
			local pivot, restDir = anim.broomPivot, anim.broomDir
			local d1 = root.CFrame:PointToObjectSpace(th.target) - pivot
			d1 = d1.Magnitude > 0.1 and d1.Unit or restDir
			local dWind = (restDir * 0.3 + Vector3.new(0, 1, 0) * 0.95).Unit -- bout du balai vers le haut
			local rAim = aimRotation(restDir, d1)
			local rWind = aimRotation(restDir, dWind)
			local tt = th.t
			local rot
			if tt < WINDUP then
				rot = CFrame.identity:Lerp(rWind, ease(tt / WINDUP))
			elseif tt < WINDUP + THROW_T then
				rot = rWind:Lerp(rAim, ease((tt - WINDUP) / THROW_T))
			elseif tt < WINDUP + THROW_T + HOLD_T then
				rot = rAim
			else
				rot = rAim:Lerp(CFrame.identity, ease((tt - WINDUP - THROW_T - HOLD_T) / RETURN_T))
			end
			flick = rotAbout(pivot, rot)
		end
		local orb = anim.orb
		if orb and orb.Parent and not th.released then
			orb.Size = Vector3.one * SCALE * (0.4 + 1.8 * ease(th.t / WINDUP))
		end
		if not th.released and th.t >= WINDUP + THROW_T then
			th.released = true
			if orb then
				TweenService:Create(orb, TweenInfo.new(0.35), {Size = orb.Size * 2, Transparency = 1}):Play()
				Debris:AddItem(orb, 0.6)
				anim.orb = nil
			end
			task.spawn(launchBolt, th.egg, anim.tipPart.Position) -- le trait part du bout du balai
		end
		if th.t >= WINDUP + THROW_T + HOLD_T + RETURN_T then anim.throw = nil end
	end
	-- quand elle est montee sur son balai, il glisse de sa main a sous elle
	local mountK = anim.mount or 0
	local shift = CFrame.identity
	if mountK > 0 and anim.broomPivot then
		shift = CFrame.new(0, -0.7 * SCALE * mountK, -anim.broomPivot.Z * mountK)
	end
	set("Broom", broomT * shift * flick)

	-- bras qui lance : arme vers le haut, projette vers l'oeuf, revient
	local armT = CFrame.identity
	local th = anim.throw
	if th and anim.hand then
		th.t += dt
		local egg = th.egg
		if egg and egg.Parent then
			th.target = egg:GetPivot().Position + Vector3.new(0, (egg:GetAttribute("Height") or 3) * 0.4, 0)
		end
		if th.target then
			local d1 = (root.CFrame:PointToObjectSpace(th.target) - anim.shoulder).Unit
			local dWind = (d1 * -0.4 + Vector3.new(0, 1, 0) * 0.9 + Vector3.new(0, 0, 0.3)).Unit -- vers le haut, un peu en arriere
			local rAim = aimRotation(anim.restDir, d1)
			local rWind = aimRotation(anim.restDir, dWind)
			local tt = th.t
			local rot
			if tt < WINDUP then
				rot = CFrame.identity:Lerp(rWind, ease(tt / WINDUP))
			elseif tt < WINDUP + THROW_T then
				rot = rWind:Lerp(rAim, ease((tt - WINDUP) / THROW_T))
			elseif tt < WINDUP + THROW_T + HOLD_T then
				rot = rAim
			else
				rot = rAim:Lerp(CFrame.identity, ease((tt - WINDUP - THROW_T - HOLD_T) / RETURN_T))
			end
			armT = rotAbout(anim.shoulder, rot)
		end
		local orb = anim.orb
		if orb and orb.Parent and not th.released then
			orb.Size = Vector3.one * SCALE * (0.4 + 1.8 * ease(th.t / WINDUP))
		end
		if not th.released and th.t >= WINDUP + THROW_T then
			th.released = true
			if orb then
				TweenService:Create(orb, TweenInfo.new(0.35), {Size = orb.Size * 2, Transparency = 1}):Play()
				Debris:AddItem(orb, 0.6)
				anim.orb = nil
			end
			task.spawn(launchBolt, th.egg, anim.hand.Position) -- le trait part de la main
		end
		if th.t >= WINDUP + THROW_T + HOLD_T + RETURN_T then anim.throw = nil end
	end
	if not anim.throw and anim.useWand and anim.shoulder then -- en vol, la baguette dessine de petits cercles
		armT = rotAbout(anim.shoulder, CFrame.Angles(math.rad(12 * math.sin(t * 1.7)), 0, math.rad(9 * math.sin(t * 1.1))))
	end
	set("ArmR", broomT * armT)

	-- chapeau, cheveux, jupe : flottent vers l'arriere (le balai va toujours vers -X dans le repere de la sorciere)
	if G.Hat and G.Hat.pivot then
		set("Hat", rotAbout(G.Hat.pivot, CFrame.Angles(0, 0, -swing(0, 6 + 14 * wind, 6, 5.5))))
	end
	for _, name in {"HairBack", "HairR", "HairL"} do
		local g = G[name]
		if g and g.pivot then
			local phase = (name == "HairBack" and 0) or (name == "HairR" and 1.2) or 2.4
			set(name, rotAbout(g.pivot, CFrame.Angles(0, 0, swing(phase, 8 + 16 * wind, 5, 6))))
		end
	end
	for i, name in ROBE_LAYERS do
		local g = G[name]
		if g and g.pivot then
			set(name, rotAbout(g.pivot, CFrame.Angles(0, 0, swing(i * 0.7, (4 + 9 * wind) * (0.5 + i * 0.25) * (1 - mountK) - 9 * i * mountK, 3 + i * (1 - 0.6 * mountK), 4))))
		end
	end
	-- jambes qui se balancent (une apres l'autre)
	for i, name in {"BootR", "BootL"} do
		local g = G[name]
		if g and g.pivot then
			set(name, rotAbout(g.pivot, CFrame.Angles(0, 0, swing(i == 1 and 0 or math.pi, (10 + 14 * wind) * (1 - mountK) - 72 * mountK, 12 - 7 * mountK, 4.2 - 1.6 * mountK))))
		end
	end
end

-- la sorciere lance un trait sur un oeuf : animation du bras puis trait depuis la main (ou depuis le balai si pas d'animation)
local function throwBolt(root, zonePart)
	if not root.Parent then return end
	local egg = pickEgg(zonePart)
	if not egg then return end
	if anim.ready and anim.tipPart then
		if anim.throw then -- geste déjà en cours : le sort part quand même de la baguette
			launchBolt(egg, anim.tipPart.Position)
			return
		end -- le balai est encore en train de lancer
		startThrow(egg)
	else
		launchBolt(egg, root.CFrame:PointToWorldSpace(TIP_OFFSET * SCALE))
	end
end


------------------------------------------------------------------ VOL DE LA SORCIERE
local function pose(root, pos, dt)
	curYaw += (targetYaw - curYaw) * math.min(dt * 3, 1)
	local bob = math.sin(clockTime * 2.2) * 4
	local tilt = math.rad(math.sin(clockTime * 1.7) * 6)
	root.CFrame = CFrame.new(pos + Vector3.new(0, bob, 0)) * R0 * CFrame.Angles(0, curYaw, 0) * CFrame.Angles(0, 0, tilt)
	if anim.ready then updateAnim(dt, root) end -- chapeau, cheveux, jupe, jambes, balai : animation en vol
end

-- vol en ligne droite ; renvoie la position atteinte
local function fly(root, from, to, speed, abortable)
	if math.abs(to.X - from.X) > 1 then targetYaw = (to.X > from.X) and math.pi or 0 end
	local dur = math.max((to - from).Magnitude / speed, 0.05)
	local t, cur = 0, from
	while t < dur and (not abortable or alive()) do
		local dt = RunService.Heartbeat:Wait()
		t += dt
		clockTime += dt
		cur = from:Lerp(to, math.min(t / dur, 1))
		pose(root, cur, dt)
	end
	return cur
end

-- balayage en zigzag d'une zone (dir = 1 : vers +X, dir = -1 : vers -X), avec un trait toutes les ~1 s
local function sweepZone(root, zonePart, dir)
	local cx, cz = zonePart.Position.X, zonePart.Position.Z
	local x0, x1 = cx - zonePart.Size.X / 2 - 20, cx + zonePart.Size.X / 2 + 20
	local amp = math.max(zonePart.Size.Z / 2 - 20, 20)
	local y = zonePart.Position.Y + zonePart.Size.Y / 2 + FLY_HEIGHT
	targetYaw = dir == 1 and math.pi or 0
	local t, nextBolt, cur = 0, 0.6, nil
	local bolts = 0 -- 5 œufs ensorcelés par zone
	while t < SWEEP_TIME and alive() do
		local dt = RunService.Heartbeat:Wait()
		t += dt
		clockTime += dt
		local u = math.min(t / SWEEP_TIME, 1)
		local x = dir == 1 and (x0 + (x1 - x0) * u) or (x1 - (x1 - x0) * u)
		cur = Vector3.new(x, y, cz + amp * math.sin(u * math.pi * 3))
		pose(root, cur, dt)
		nextBolt -= dt
		if nextBolt <= 0 and bolts < 30 then -- 30 sorts par zone
			bolts += 1
			nextBolt = BOLT_MIN + math.random() * (BOLT_MAX - BOLT_MIN)
			task.spawn(throwBolt, root, zonePart)
		end
	end
	return cur or root.Position
end

local function getZones()
	local zones = {}
	for _, c in workspace:GetChildren() do
		if c:IsA("BasePart") and string.find(string.lower(c.Name), "egg zone", 1, true) then table.insert(zones, c) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	return zones
end

------------------------------------------------------------------ PLANNING AUTOMATIQUE (timer de 2 h au-dessus de la sorciere)
local MemoryStoreService = game:GetService("MemoryStoreService")
local AUTO_INTERVAL = 7200 -- 2 h entre la fin d'un event et le suivant
local AUTO_DURATION = 600  -- duree (secondes) de l'event lance automatiquement par le timer
local nextAt = workspace:GetServerTimeNow() + AUTO_INTERVAL -- moment du prochain event automatique
local scheduleMap
pcall(function() scheduleMap = MemoryStoreService:GetHashMap("WitchSchedule") end)

-- partage le moment du prochain event entre tous les serveurs (la valeur la plus tardive gagne)
local function shareNext(proposed)
	if not scheduleMap then return end
	local ok, value = pcall(function()
		return scheduleMap:UpdateAsync("nextAt", function(old)
			if type(old) == "number" and old >= proposed then return old end
			return proposed
		end, 172800)
	end)
	if ok and type(value) == "number" then nextAt = value end
end

-- au demarrage du serveur : on reprend le timer des autres serveurs, ou on le cree
task.spawn(function()
	if not scheduleMap then return end
	local ok, value = pcall(function() return scheduleMap:GetAsync("nextAt") end)
	local now = workspace:GetServerTimeNow()
	if ok and type(value) == "number" and value > now - AUTO_DURATION then
		nextAt = value
	else
		shareNext(now + AUTO_INTERVAL)
	end
end)

------------------------------------------------------------------ ELLE MONTE SUR SON BALAI
-- petit accroupissement, saut, le balai glisse sous elle pendant qu'elle retombe assise dessus
local MOUNT_TIME = 1.6
local function mountBroom(root, pos)
	local t = 0
	while t < MOUNT_TIME and alive() do
		local dt = RunService.Heartbeat:Wait()
		t += dt
		clockTime += dt
		local k = math.min(t / MOUNT_TIME, 1)
		anim.mount = ease((k - 0.15) / 0.6)
		local crouch = -2.5 * math.sin(math.clamp(k / 0.3, 0, 1) * math.pi)
		local jump = 9 * math.sin(math.clamp((k - 0.3) / 0.7, 0, 1) * math.pi)
		pose(root, pos + Vector3.new(0, crouch + jump, 0), dt)
	end
	anim.mount = 1
end

------------------------------------------------------------------ EVENT
local function runEvent(duration)
	if running then return end
	local witch = workspace:FindFirstChild("Sorciere")
	local zones = getZones()
	if not (witch and witch:IsA("Model") and witch.PrimaryPart) or #zones == 0 then
		warn("[WitchEvent] Workspace.Sorciere (with PrimaryPart) or egg zones not found")
		return
	end
	running, stopRequested = true, false
	witch:SetAttribute("Busy", true) -- les clients arrêtent son animation de repos
	endAt = workspace:GetServerTimeNow() + duration
	ReplicatedStorage:SetAttribute("WitchEventEnd", endAt)
	ReplicatedStorage:SetAttribute("WitchTime", true) -- les clients assombrissent l'ecran + HUD

	local root = witch.PrimaryPart
	local homeCF = witch:GetPivot()
	R0 = homeCF.Rotation
	local bbCF, bbSize = witch:GetBoundingBox()
	local feetY = bbCF.Position.Y - bbSize.Y / 2
	local headOffset = homeCF.Position.Y - feetY

	local saved, welds, origCF = {}, {}, {}
	for _, d in witch:GetDescendants() do
		if d:IsA("BasePart") then
			saved[d] = {d.Anchored, d.CanCollide, d.CanTouch, d.CanQuery}
			origCF[d] = d.CFrame
		end
	end

	local function setScale(s)
		witch:ScaleTo(s)
		witch:PivotTo(CFrame.new(homeCF.X, feetY + headOffset * s, homeCF.Z) * R0)
	end
	local function animateScale(from, to, duration)
		local t = 0
		while t < duration do
			t += RunService.Heartbeat:Wait()
			local a = math.min(t / duration, 1)
			setScale(from + (to - from) * (a * a * (3 - 2 * a)))
		end
		setScale(to)
	end

	local grown = false
	local flightFx
	local ok, err = pcall(function()
		local waited = 0
		while waited < INTRO_TIME and alive() do waited += task.wait(0.1) end
		if not alive() then return end

		entranceFx(homeCF.Position, feetY) -- eclairs, fumee, ondes de choc
		animateScale(1, SCALE, GROW_TIME)
		grown = true
		flightFx = addFlightFx(root)

		-- la sorciere est soudee a sa tete : on deplace seulement la tete
		for part in saved do
			part.CanCollide, part.CanTouch, part.CanQuery = false, false, false
			if part ~= root then part.Anchored = false end
		end
		-- groupes animes (chapeau, cheveux, jupe, jambes, balai...) relies a la tete
		local okB, errB = pcall(buildGroups, witch, root, welds)
		if not okB then
			warn("[WitchEvent] animation failed: " .. tostring(errB))
			anim.ready = false
			for part in saved do
				if part ~= root then
					local w = Instance.new("WeldConstraint")
					w.Part0, w.Part1 = root, part
					w.Parent = root
					table.insert(welds, w)
				end
			end
		end
		root.Anchored = true
		curYaw, targetYaw = 0, 0

		-- elle survole les zones dans un sens puis dans l'autre, jusqu'a la fin du temps
		local pos = root.Position
		-- elle saute sur son balai
		if anim.ready then mountBroom(root, pos) end
		-- decollage : elle s'eleve doucement, le chapeau, les cheveux, la jupe et les jambes bougent deja
		pos = fly(root, pos, pos + Vector3.new(0, 30, 0), 35, true)
		local dir = 1
		while alive() do
			local n = #zones
			for i = 1, n do
				if not alive() then break end
				local zone = dir == 1 and zones[i] or zones[n - i + 1]
				local x0 = zone.Position.X - zone.Size.X / 2 - 20
				local x1 = zone.Position.X + zone.Size.X / 2 + 20
				local y = zone.Position.Y + zone.Size.Y / 2 + FLY_HEIGHT
				pos = fly(root, pos, Vector3.new(dir == 1 and x0 or x1, y, zone.Position.Z), TRANSIT_SPEED, true)
				if not alive() then break end
				pos = sweepZone(root, zone, dir)
			end
			dir = -dir
		end

		-- fin du temps : l'ambiance revient a la normale, la sorciere rentre se poser
		ReplicatedStorage:SetAttribute("WitchTime", nil)
		ReplicatedStorage:SetAttribute("WitchEventEnd", nil)
		fly(root, pos, Vector3.new(homeCF.X, feetY + headOffset * SCALE, homeCF.Z), RETURN_SPEED, false)
	end)
	if not ok then warn("[WitchEvent] error: " .. tostring(err)) end

	-- remise en place (toujours, meme en cas d'erreur)
	ReplicatedStorage:SetAttribute("WitchTime", nil)
	ReplicatedStorage:SetAttribute("WitchEventEnd", nil)
	if flightFx then flightFx:Destroy() end
	pcall(function() -- elle se pose : fumee et onde de choc
		smokeBurst(Vector3.new(homeCF.X, feetY + 4, homeCF.Z), 8, 16)
		shockwave(Vector3.new(homeCF.X, feetY + 0.3, homeCF.Z), 50, PURPLE, 0.8)
	end)
	neutralizeAnim() -- chaque morceau reprend sa pose normale
	RunService.Heartbeat:Wait()
	for part in saved do part.Anchored = true end
	for _, w in welds do w:Destroy() end
	if grown then
		local okShrink = pcall(animateScale, SCALE, 1, GROW_TIME)
		if not okShrink then witch:ScaleTo(1) end
	end
	witch:ScaleTo(1)
	witch:PivotTo(homeCF)
	for part, cf in origCF do part.CFrame = cf end -- remet exactement chaque piece a sa place d'origine
	for part, s in saved do
		part.Anchored, part.CanCollide, part.CanTouch, part.CanQuery = s[1], s[2], s[3], s[4]
	end
	-- l'event est fini (ou arrete) : le timer de 2 h repart de zero, pour tous les serveurs
	nextAt = workspace:GetServerTimeNow() + AUTO_INTERVAL
	task.spawn(shareNext, nextAt)
	witch:SetAttribute("Busy", nil)
	running, stopRequested = false, false
end

------------------------------------------------------------------ COMMANDE ADMIN + TOUS LES SERVEURS
local function handle(action, duration)
	if action == "start" then
		if running then return end
		announceRemote:FireAllClients("EVENT", "WITCH TIME! The witch is flying over the zones for " .. describe(duration), 0)
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
		notifyRemote:FireClient(player, "Witch Time is already running")
		return
	end
	local ok = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {action = action, duration = duration}) end)
	if not ok then handle(action, duration) end -- Studio : ce serveur seulement
	notifyRemote:FireClient(player, action == "start" and ("Witch Time started (" .. describe(duration) .. ")") or "Witch Time stopped")
end)

------------------------------------------------------------------ TIMER AU-DESSUS DE LA SORCIERE
-- Le timer est accroche a une piece fixe : il reste a la meme place meme quand la sorciere vole.
-- A 0 : l'event se lance tout seul ; quand il se termine, le timer repart a 2 h.
task.spawn(function()
	local witch = workspace:WaitForChild("Sorciere", 30)
	if not witch or not witch:IsA("Model") then return end
	local bbCF, bbSize = witch:GetBoundingBox()
	local anchor = Instance.new("Part")
	anchor.Name = "WitchTimerAnchor"
	anchor.Anchored, anchor.CanCollide, anchor.CanQuery, anchor.CanTouch, anchor.CastShadow = true, false, false, false, false
	anchor.Transparency = 1
	anchor.Size = Vector3.one
	anchor.Position = bbCF.Position + Vector3.new(0, bbSize.Y / 2 + 6, 0)
	anchor.Parent = workspace

	local bb = Instance.new("BillboardGui")
	bb.Name = "WitchTimer"
	bb.Size = UDim2.new(16, 0, 6, 0)
	bb.LightInfluence = 0
	bb.MaxDistance = 600
	local function makeText(pos, size, color)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = pos, size
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.TextScaled = true
		label.TextColor3 = color
		label.Text = ""
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 3
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label
		CollectionService:AddTag(label, "Text3D")
		label.Parent = bb
		return label
	end
	local topLabel = makeText(UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.38), Color3.fromRGB(190, 90, 255))
	local mainLabel = makeText(UDim2.fromScale(0, 0.38), UDim2.fromScale(1, 0.62), Color3.fromRGB(255, 255, 255))
	bb.Parent = anchor

	local function fmt(s)
		s = math.max(0, math.ceil(s))
		return string.format("%d:%02d:%02d", s // 3600, (s % 3600) // 60, s % 60)
	end

	local lastTrigger, lastSync = nil, 0
	while true do
		local now = workspace:GetServerTimeNow()
		if running then
			topLabel.Text = "WITCH TIME!"
			mainLabel.Text = fmt(endAt - now)
		else
			topLabel.Text = "WITCH TIME IN"
			if now >= nextAt then
				mainLabel.Text = "STARTING..."
				if lastTrigger ~= nextAt then
					lastTrigger = nextAt
					handle("start", AUTO_DURATION) -- tous les serveurs partagent le meme timer : ils la lancent ensemble
				end
			else
				mainLabel.Text = fmt(nextAt - now)
			end
			-- de temps en temps on reprend la valeur partagee par les autres serveurs
			if now - lastSync > 20 then
				lastSync = now
				task.spawn(function()
					if not scheduleMap then return end
					local ok, value = pcall(function() return scheduleMap:GetAsync("nextAt") end)
					if ok and type(value) == "number" and value > workspace:GetServerTimeNow() and not running then nextAt = value end
				end)
			end
		end
		task.wait(0.25)
	end
end)
