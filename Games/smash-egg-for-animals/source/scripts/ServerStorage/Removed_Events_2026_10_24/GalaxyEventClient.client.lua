-- GalaxyEventClient : côté joueur du GALAXY EVENT (le serveur, SkyEventsServer, décide de tout : œufs choisis, tirage 20 %, mutation).
--   * CIEL : pendant l'event, le ciel devient un ciel cosmique (étoiles, nébuleuses roses / violettes / cyan). Les Sky d'origine
--     sont mis de côté (pas détruits) et remis EXACTEMENT tels quels à la fin. Aucune propriété de Lighting n'est modifiée :
--     la carte reste aussi lisible qu'en journée (la teinte légère est gérée par SkyEventsClient, comme les autres events).
--   * ŒUFS (tag "GalaxyAbsorb" posé par le serveur) : l'œuf réel ne bouge JAMAIS côté serveur. Ici on le cache (localement)
--     et une copie visuelle joue l'animation, calée sur l'horloge du serveur :
--       A attraction (rayon + particules qui convergent)  B lévitation en spirale, rotation sur 3 axes, vortex
--       C disparition (éclat, flash, onde)  D absent exactement 3 s  E retour en spirale avec traînée + atterrissage
--     À la fin, l'œuf réel réapparaît (avec sa mutation GALAXY s'il l'a gagnée) et tout ce qui a été changé est remis.
--   * GALAXIE : lueur qui s'intensifie quand elle aspire, fondu pendant le saut (vortex) et au départ.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")

local rgb = Color3.fromRGB
local PURPLE, PINK, CYAN, WHITE, INDIGO = rgb(165, 110, 255), rgb(255, 140, 230), rgb(100, 225, 255), rgb(255, 255, 255), rgb(90, 60, 210)
local TEX = {Star = "rbxassetid://1084970835", Glow = "rbxassetid://4509687978", Rays = "rbxassetid://1084975295",
	Ring = "rbxassetid://8271495905", Sparkle = "rbxasset://textures/particles/sparkles_main.dds"}
local TAG = "GalaxyAbsorb"
local FAR = 450 -- au-delà, l'œuf est caché / rendu mais sans particules (optimisation)

local function now() return workspace:GetServerTimeNow() end
local function clamp01(x) return math.clamp(x, 0, 1) end

local fxFolder = Instance.new("Folder")
fxFolder.Name = "GalaxyClientFx" -- (local à ce joueur)
fxFolder.Parent = workspace

local function fxPart(size, cf, color, transparency, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Material = Enum.Material.Neon
	p.Color = color
	p.Transparency = transparency or 0
	p.Size = size
	p.CFrame = cf
	if shape then p.Shape = shape end
	return p
end

local function burst(position, props, count, life)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Rate = 0
	e.Texture = TEX.Sparkle
	e.LightEmission, e.LightInfluence = 1, 0
	for k, v in props do e[k] = v end
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, life or 3)
end

local function lightPulse(position, color, range, brightness, time)
	local p = fxPart(Vector3.one * 0.2, CFrame.new(position), color, 1)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = color, range, brightness, false
	light.Parent = p
	p.Parent = fxFolder
	TweenService:Create(light, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
	Debris:AddItem(p, time + 0.1)
end

-- anneau d'énergie à plat qui s'élargit (texture "light ring")
local function ringPulse(position, radius, color, time)
	local ring = fxPart(Vector3.new(2, 0.1, 2), CFrame.new(position), color, 1)
	local decal = Instance.new("Decal")
	decal.Face, decal.Texture, decal.Color3, decal.Transparency = Enum.NormalId.Top, TEX.Ring, color, 0.1
	decal.Parent = ring
	local under = decal:Clone()
	under.Face = Enum.NormalId.Bottom
	under.Parent = ring
	ring.Parent = fxFolder
	local info = TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	TweenService:Create(ring, info, {Size = Vector3.new(radius * 2, 0.1, radius * 2), CFrame = ring.CFrame * CFrame.Angles(0, math.rad(140), 0)}):Play()
	TweenService:Create(decal, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	TweenService:Create(under, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	Debris:AddItem(ring, time + 0.1)
end

local STARDUST = ColorSequence.new({ColorSequenceKeypoint.new(0, WHITE), ColorSequenceKeypoint.new(0.4, PINK), ColorSequenceKeypoint.new(0.75, PURPLE), ColorSequenceKeypoint.new(1, CYAN)})
local function cosmicBurst(position, scale, count)
	burst(position, {Color = STARDUST, Speed = NumberRange.new(8 * scale, 22 * scale), SpreadAngle = Vector2.new(180, 180), Drag = 2.5,
		Lifetime = NumberRange.new(0.5, 1.1), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1 * scale), NumberSequenceKeypoint.new(1, 0)})}, count)
	burst(position, {Texture = TEX.Star, Color = ColorSequence.new(WHITE, CYAN), Speed = NumberRange.new(3 * scale, 9 * scale), SpreadAngle = Vector2.new(180, 180), Drag = 2,
		RotSpeed = NumberRange.new(-180, 180), Rotation = NumberRange.new(0, 360), Lifetime = NumberRange.new(0.7, 1.2),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6 * scale), NumberSequenceKeypoint.new(1, 0)})}, math.max(4, math.floor(count / 5)))
end

---------------------------------------------------------------- galaxie (modèle serveur : workspace.SkyEventFx.Galaxy.Galaxy)
local function findGalaxy()
	local fx = workspace:FindFirstChild("SkyEventFx")
	local f = fx and fx:FindFirstChild("Galaxy")
	return f and f:FindFirstChild("Galaxy")
end
local function galaxyCore()
	local g = findGalaxy()
	local core = g and g:FindFirstChild("Core")
	return core and core.Position or nil
end

---------------------------------------------------------------- CIEL COSMIQUE
local skyTemplate
task.spawn(function()
	local skies = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Skies", 30)
	skyTemplate = skies and skies:WaitForChild("GalaxySky", 30)
	if not skyTemplate then warn("[GalaxyEventClient] ciel GalaxySky introuvable : le ciel normal est gardé") end
end)
local skyOn, mySky = false, nil
local stashed = {}                       -- Sky d'origine mis de côté (remis tels quels)
local stash = Instance.new("Folder")     -- (jamais dans le jeu)
local skyFade = Instance.new("ColorCorrectionEffect")
skyFade.Name = "GalaxySkyFade"
skyFade.Parent = Lighting
local skyToken = 0
local function setSky(on)
	if on == skyOn then return end
	if on and not skyTemplate then return end -- (le modèle arrive : on réessaiera au prochain tour)
	skyOn = on
	skyToken += 1
	local token = skyToken
	-- petit fondu (très léger, jamais aveuglant) pour masquer le changement de ciel
	TweenService:Create(skyFade, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {Brightness = -0.06}):Play()
	task.delay(0.45, function()
		if token ~= skyToken then return end
		if skyOn then
			if not mySky then
				for _, child in Lighting:GetChildren() do
					if child:IsA("Sky") then table.insert(stashed, child) child.Parent = stash end
				end
				mySky = skyTemplate:Clone()
				mySky.Name = "GalaxyEventSky"
				mySky.Parent = Lighting
			end
		else
			if mySky then mySky:Destroy() mySky = nil end
			for _, sky in stashed do
				if sky.Parent == stash then sky.Parent = Lighting end
			end
			table.clear(stashed)
		end
		TweenService:Create(skyFade, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {Brightness = 0}):Play()
	end)
end

---------------------------------------------------------------- ŒUFS ABSORBÉS
local controllers = {} -- [œuf] = état de l'animation

local STRIP = {"LayerCollector", "ProximityPrompt", "ParticleEmitter", "Beam", "Trail", "Light", "Highlight", "Sound", "LuaSourceContainer", "Fire", "Smoke", "Sparkles"}
local function stripped(d)
	for _, class in STRIP do if d:IsA(class) then return true end end
	return false
end

-- copie visuelle de l'œuf : seulement sa forme (pas d'étiquettes, de scripts, de tags, d'attributs)
local function makeVisual(egg)
	local clone
	pcall(function()
		local was = egg.Archivable
		egg.Archivable = true
		clone = egg:Clone()
		egg.Archivable = was
	end)
	if clone and clone.PrimaryPart then
		for _, d in clone:GetDescendants() do
			if stripped(d) then d:Destroy() end
		end
		for _, d in clone:GetDescendants() do
			for _, tag in d:GetTags() do d:RemoveTag(tag) end
			if d:IsA("BasePart") then
				d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = true, false, false, false, false
				d.LocalTransparencyModifier = 0
			elseif d:IsA("Decal") then
				d.LocalTransparencyModifier = 0
			end
		end
		for _, tag in clone:GetTags() do clone:RemoveTag(tag) end
		for key in clone:GetAttributes() do clone:SetAttribute(key, nil) end
		clone.Name = "GalaxyEggVisual"
		return clone
	end
	if clone then clone:Destroy() end
	-- (copie impossible) : un œuf lumineux de la même taille
	local h = egg:GetAttribute("Height") or 3 -- (pas GetExtentsSize : l'icône de mutation de l'étiquette fausserait la taille)
	local size = Vector3.new(h * 0.8, h, h * 0.8)
	local model = Instance.new("Model")
	model.Name = "GalaxyEggVisual"
	local p = fxPart(size, egg:GetPivot(), PURPLE, 0.2)
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Sphere
	mesh.Parent = p
	p.Parent = model
	model.PrimaryPart = p
	return model
end

-- cacher l'œuf réel chez ce joueur (et tout ce qui s'y ajoute pendant ce temps) ; chaque valeur d'origine est notée
local function hideOne(store, d)
	if store[d] ~= nil then return end
	if d:IsA("BasePart") or d:IsA("Decal") then
		store[d] = d.LocalTransparencyModifier
		d.LocalTransparencyModifier = 1
	elseif d:IsA("LayerCollector") or d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail") or d:IsA("Light") or d:IsA("Highlight") then
		store[d] = d.Enabled
		d.Enabled = false
		if d:IsA("ParticleEmitter") then d:Clear() end
	end
end
local function restoreAll(store)
	for d, value in store do
		pcall(function()
			if d:IsA("BasePart") or d:IsA("Decal") then d.LocalTransparencyModifier = value else d.Enabled = value end
		end)
	end
	table.clear(store)
end

local function newBeam(a0, a1, texture, speed, widthScale, transparency)
	local b = Instance.new("Beam")
	b.Attachment0, b.Attachment1 = a0, a1
	b.Texture, b.TextureMode, b.TextureSpeed, b.TextureLength = texture, Enum.TextureMode.Stretch, speed, 1
	b.FaceCamera, b.Segments, b.LightEmission, b.LightInfluence, b.Brightness = true, 20, 1, 0, 2
	b.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, PINK), ColorSequenceKeypoint.new(0.5, PURPLE), ColorSequenceKeypoint.new(1, CYAN)})
	b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, transparency), NumberSequenceKeypoint.new(0.8, transparency + 0.15), NumberSequenceKeypoint.new(1, 0.6)})
	b.Width0, b.Width1 = 0, 0
	b:SetAttribute("WidthScale", widthScale)
	b.Parent = a0
	return b
end

local finish
local function start(egg)
	if controllers[egg] or not egg:IsA("Model") then return end
	if not egg.PrimaryPart then -- (streaming : la pièce centrale peut arriver une image plus tard)
		local t0 = os.clock()
		while not egg.PrimaryPart and egg.Parent and os.clock() - t0 < 2 do task.wait() end
	end
	if controllers[egg] or not egg.Parent or not egg.PrimaryPart or not CollectionService:HasTag(egg, TAG) then return end
	local home = egg:GetPivot()
	local height = math.max(egg:GetAttribute("Height") or 3, 1)
	local camera = workspace.CurrentCamera
	local near = camera and (camera.CFrame.Position - home.Position).Magnitude < FAR
	local ctrl = {Egg = egg, Home = home, HomePos = home.Position, HomeRot = home.Rotation, H = height, Near = near, Store = {}, Conns = {},
		Scale = 1, Visible = true, CurPos = home.Position}
	controllers[egg] = ctrl
	-- copie visuelle posée exactement sur l'œuf, puis l'œuf réel est caché dans la même image : aucun saut
	local visual = makeVisual(egg)
	visual:PivotTo(home)
	visual.Parent = fxFolder
	ctrl.Visual = visual
	ctrl.BaseScale = visual:GetScale()
	for _, d in egg:GetDescendants() do hideOne(ctrl.Store, d) end
	table.insert(ctrl.Conns, egg.DescendantAdded:Connect(function(d) if controllers[egg] == ctrl then hideOne(ctrl.Store, d) end end))
	table.insert(ctrl.Conns, egg.AncestryChanged:Connect(function(_, parent) if not parent then finish(ctrl, "gone") end end))
	if not near then return end
	-- rayon gravitationnel galaxie -> œuf (deux Beams : rayons + tourbillon courbé)
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Parent, a1.Parent = workspace.Terrain, workspace.Terrain
	a0.WorldPosition, a1.WorldPosition = galaxyCore() or (ctrl.HomePos + Vector3.new(0, 62, 0)), ctrl.HomePos
	ctrl.A0, ctrl.A1 = a0, a1
	ctrl.Beams = {newBeam(a0, a1, TEX.Rays, 1.2, 1, 0.15), newBeam(a0, a1, TEX.Glow, -0.6, 2.2, 0.45)}
	-- sphère d'émission autour de l'œuf : particules qui convergent (attraction), puis vortex qui tourne (lévitation)
	local shell = fxPart(Vector3.one * (height * 2.6 + 8), CFrame.new(ctrl.HomePos), PURPLE, 1, Enum.PartType.Ball)
	shell.Parent = fxFolder
	ctrl.Shell = shell
	local converge = Instance.new("ParticleEmitter")
	converge.Texture, converge.LightEmission, converge.LightInfluence = TEX.Star, 1, 0
	converge.Color = ColorSequence.new(WHITE, PURPLE)
	converge.Shape, converge.ShapeInOut, converge.ShapeStyle = Enum.ParticleEmitterShape.Sphere, Enum.ParticleEmitterShapeInOut.Inward, Enum.ParticleEmitterShapeStyle.Surface
	converge.Rate, converge.Lifetime, converge.Speed = 28, NumberRange.new(0.45, 0.55), NumberRange.new(height * 2.4 + 8, height * 2.4 + 10)
	converge.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0.8 + height * 0.08)})
	converge.RotSpeed = NumberRange.new(-120, 120)
	converge.Parent = shell
	ctrl.Converge = converge
	local vortex = Instance.new("ParticleEmitter")
	vortex.Texture, vortex.LightEmission, vortex.LightInfluence = TEX.Sparkle, 1, 0
	vortex.Color = STARDUST
	vortex.Rate, vortex.Lifetime, vortex.Speed = 0, NumberRange.new(0.5, 0.9), NumberRange.new(1, 3)
	vortex.SpreadAngle = Vector2.new(180, 180)
	vortex.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5 + height * 0.1), NumberSequenceKeypoint.new(1, 0)})
	vortex.Parent = shell
	ctrl.Vortex = vortex
	local swirl = Instance.new("ParticleEmitter") -- anneau qui tourne à plat sous l'œuf pendant qu'il monte
	swirl.Texture, swirl.LightEmission, swirl.LightInfluence = TEX.Ring, 1, 0
	swirl.Color = ColorSequence.new(PINK, CYAN)
	swirl.Orientation, swirl.EmissionDirection = Enum.ParticleOrientation.VelocityPerpendicular, Enum.NormalId.Top
	swirl.Speed, swirl.Rate, swirl.Lifetime = NumberRange.new(0.01, 0.01), 0, NumberRange.new(0.9, 0.9)
	swirl.RotSpeed, swirl.Rotation, swirl.LockedToPart = NumberRange.new(220, 220), NumberRange.new(0, 360), true
	swirl.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, height * 0.8 + 2), NumberSequenceKeypoint.new(1, height * 1.8 + 4)})
	swirl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.35), NumberSequenceKeypoint.new(1, 1)})
	swirl.Parent = shell
	ctrl.Swirl = swirl
	-- traînée lumineuse (pendant le retour)
	local t0, t1 = Instance.new("Attachment"), Instance.new("Attachment")
	t0.Position, t1.Position = Vector3.new(0, height * 0.35, 0), Vector3.new(0, -height * 0.35, 0)
	t0.Parent, t1.Parent = shell, shell
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = t0, t1
	trail.Lifetime, trail.LightEmission, trail.LightInfluence, trail.FaceCamera = 0.45, 1, 0, true
	trail.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, WHITE), ColorSequenceKeypoint.new(0.4, PINK), ColorSequenceKeypoint.new(1, PURPLE)})
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
	trail.Enabled = false
	trail.Parent = shell
	ctrl.Trail = trail
end

local function setVisual(ctrl, pos, rot, scale)
	local visual = ctrl.Visual
	if not visual or not visual.Parent then return end
	-- (mise à l'échelle par paliers de 5 % : ScaleTo à chaque image coûterait cher)
	local q = math.max(0.05, math.floor(scale * 20 + 0.5) / 20)
	if q ~= ctrl.Scale then
		ctrl.Scale = q
		pcall(function() visual:ScaleTo(ctrl.BaseScale * q) end)
	end
	visual:PivotTo(CFrame.new(pos) * rot)
	ctrl.CurPos = pos
	if ctrl.Shell then ctrl.Shell.CFrame = CFrame.new(pos) end
	if ctrl.A1 then ctrl.A1.WorldPosition = pos end
end

local function setVisible(ctrl, on)
	if ctrl.Visible == on then return end
	ctrl.Visible = on
	if ctrl.Visual then ctrl.Visual.Parent = on and fxFolder or nil end
end

local function setBeam(ctrl, k)
	if not ctrl.Beams then return end
	for _, b in ctrl.Beams do
		local w = (ctrl.H * 0.9 + 2) * (b:GetAttribute("WidthScale") or 1) * k
		b.Width0, b.Width1 = w * 0.35, w
		b.Enabled = k > 0.01
	end
end

function finish(ctrl, mode)
	if controllers[ctrl.Egg] ~= ctrl then return end
	controllers[ctrl.Egg] = nil
	for _, c in ctrl.Conns do c:Disconnect() end
	local egg = ctrl.Egg
	if ctrl.Near and mode == "land" and egg.Parent then
		local ground = ctrl.HomePos - Vector3.new(0, ctrl.H * 0.5 - 0.3, 0)
		ringPulse(ground, ctrl.H * 1.6 + 6, PURPLE, 0.8)
		cosmicBurst(ctrl.HomePos, 0.6 + ctrl.H * 0.06, 40)
		lightPulse(ctrl.HomePos, PINK, 18 + ctrl.H * 2, 2.5, 0.5)
		if table.find(string.split(egg:GetAttribute("EventMutation") or "", "+"), "Galaxy") then
			-- MUTATION GALAXY : grande révélation (deux anneaux, gerbe d'étoiles, colonne de lumière)
			ringPulse(ground, ctrl.H * 2.6 + 10, CYAN, 1.1)
			cosmicBurst(ctrl.HomePos + Vector3.new(0, ctrl.H * 0.3, 0), 1 + ctrl.H * 0.08, 90)
			lightPulse(ctrl.HomePos, PURPLE, 35 + ctrl.H * 3, 4, 0.9)
			local column = fxPart(Vector3.new(ctrl.H * 0.6 + 1, 70, ctrl.H * 0.6 + 1), CFrame.new(ctrl.HomePos + Vector3.new(0, 35, 0)), PURPLE, 0.35, Enum.PartType.Cylinder)
			column.CFrame = column.CFrame * CFrame.Angles(0, 0, math.pi / 2)
			column.Size = Vector3.new(70, ctrl.H * 0.6 + 1, ctrl.H * 0.6 + 1)
			column.Parent = fxFolder
			TweenService:Create(column, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(90, 0.1, 0.1), Transparency = 1}):Play()
			Debris:AddItem(column, 1.1)
		end
	elseif ctrl.Near and ctrl.Visible and ctrl.Visual and ctrl.Visual.Parent then
		cosmicBurst(ctrl.CurPos, 0.5 + ctrl.H * 0.05, 25) -- (œuf cassé / retiré par le jeu pendant l'animation : petit éclat, rien n'est recréé)
	end
	if ctrl.Visual then ctrl.Visual:Destroy() end
	if ctrl.Shell then ctrl.Shell:Destroy() end
	if ctrl.A0 then ctrl.A0:Destroy() end
	if ctrl.A1 then ctrl.A1:Destroy() end
	restoreAll(ctrl.Store) -- l'œuf réel réapparaît, tout est remis comme avant
end

local pulling = 0 -- œufs en train d'être aspirés (la galaxie s'illumine)
local function update(ctrl, T)
	local egg = ctrl.Egg
	local absorbAt, hideAt = egg:GetAttribute("GalaxyAbsorbAt"), egg:GetAttribute("GalaxyHideAt")
	local returnAt, landAt = egg:GetAttribute("GalaxyReturnAt"), egg:GetAttribute("GalaxyLandAt")
	if not (absorbAt and hideAt and returnAt and landAt) or not egg.Parent then finish(ctrl, "released") return end
	if T >= landAt then
		setVisual(ctrl, ctrl.HomePos, ctrl.HomeRot, 1)
		finish(ctrl, "land")
		return
	end
	local core = galaxyCore() or (ctrl.HomePos + Vector3.new(0, 62, 0))
	if ctrl.A0 then ctrl.A0.WorldPosition = core end
	local H = ctrl.H
	local attractEnd = absorbAt + math.min(1.3, (hideAt - absorbAt) * 0.37)
	if T >= returnAt then
		-- E : retour à sa place, en spirale qui se resserre, rotation qui ralentit, traînée lumineuse
		if not ctrl.Returning then
			ctrl.Returning = true
			if ctrl.Visible then
				ctrl.From, ctrl.FromScale = ctrl.CurPos, ctrl.Scale -- (event arrêté avant la disparition : il redescend d'où il est)
			else
				ctrl.From, ctrl.FromScale = core, 0.3
				if ctrl.Near and T - returnAt < 0.4 then cosmicBurst(core, 0.8, 30) lightPulse(core, CYAN, 30, 3, 0.4) end
			end
			setVisible(ctrl, true)
			if ctrl.Trail then ctrl.Trail.Enabled = true end
			if ctrl.Vortex then ctrl.Vortex.Rate = 25 end
			if ctrl.Converge then ctrl.Converge.Enabled = false end
		end
		local u = clamp01((T - returnAt) / math.max(landAt - returnAt, 0.05))
		local e = 1 - (1 - u) ^ 3
		local angle = u * math.pi * 3
		local r = (1 - e) * (H * 1.2 + 3)
		local pos = ctrl.From:Lerp(ctrl.HomePos, e) + Vector3.new(math.cos(angle) * r, 0, math.sin(angle) * r)
		local spin = (1 - e) ^ 2 * 14
		local free = CFrame.Angles(spin * 0.9, spin * 1.7, spin * 0.5) * ctrl.HomeRot
		local rot = free:Lerp(ctrl.HomeRot, e ^ 2)
		local back = 2.2 -- (petit dépassement à l'arrivée : il se pose avec un léger rebond)
		local grow = 1 + back * (u - 1) ^ 3 + (back - 1) * (u - 1) ^ 2
		setVisual(ctrl, pos, rot, ctrl.FromScale + (1 - ctrl.FromScale) * math.clamp(grow, 0, 1.08))
		setBeam(ctrl, (1 - u) * 0.6)
		if ctrl.Vortex then ctrl.Vortex.Rate = 25 * (1 - u) end
	elseif T >= hideAt then
		-- C / D : il disparaît dans un éclat cosmique, puis reste absent (3 s)
		if ctrl.Visible then
			if ctrl.Near and T - hideAt < 0.4 then
				cosmicBurst(ctrl.CurPos, 0.7 + H * 0.05, 60)
				lightPulse(ctrl.CurPos, PINK, 30 + H * 2, 3.5, 0.45)
				ringPulse(ctrl.CurPos, H * 1.5 + 8, CYAN, 0.6)
			end
			setVisible(ctrl, false)
			if ctrl.Vortex then ctrl.Vortex.Rate = 0 end
			if ctrl.Swirl then ctrl.Swirl.Rate = 0 end
			if ctrl.Converge then ctrl.Converge.Enabled = false end
		end
		setBeam(ctrl, math.max(0, 1 - (T - hideAt) / 0.4))
	elseif T >= attractEnd then
		-- B : lévitation en spirale vers le cœur de la galaxie, rotation sur plusieurs axes qui accélère, vortex
		pulling += 1
		local u = clamp01((T - attractEnd) / math.max(hideAt - attractEnd, 0.05))
		local e = u * u * (3 - 2 * u)
		local target = core - (core - ctrl.HomePos).Unit * (H * 0.5 + 4) -- point d'absorption, juste sous le cœur
		local angle = u * math.pi * 5
		local r = math.sin(u * math.pi) * (H * 1.4 + 4)
		local pos = ctrl.HomePos:Lerp(target, e) + Vector3.new(math.cos(angle) * r, H * 0.2 * (1 - e), math.sin(angle) * r)
		local a = 2 * u + 11 * u * u
		local rot = CFrame.Angles(a * 0.9, a * 1.6, a * 0.55) * ctrl.HomeRot
		setVisual(ctrl, pos, rot, 1 - 0.65 * clamp01((u - 0.4) / 0.6) ^ 1.5)
		setBeam(ctrl, 1)
		if ctrl.Converge then ctrl.Converge.Enabled = false end
		if ctrl.Vortex then ctrl.Vortex.Rate = 40 end
		if ctrl.Swirl then ctrl.Swirl.Rate = 3 end
	else
		-- A : attraction. Le rayon s'ouvre, des particules convergent, l'œuf frissonne et décolle à peine
		pulling += 1
		local u = clamp01((T - absorbAt) / math.max(attractEnd - absorbAt, 0.05))
		local shake = 0.03 * u
		local pos = ctrl.HomePos + Vector3.new(math.sin(T * 41) * shake * H, H * 0.12 * u * u, math.cos(T * 37) * shake * H)
		local rot = CFrame.Angles(math.sin(T * 23) * 0.06 * u, 0, math.cos(T * 19) * 0.06 * u) * ctrl.HomeRot
		setVisual(ctrl, pos, rot, 1)
		setBeam(ctrl, u)
	end
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(function(egg) task.spawn(start, egg) end)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(egg)
	local ctrl = controllers[egg]
	if ctrl then finish(ctrl, "released") end
end)
for _, egg in CollectionService:GetTagged(TAG) do task.spawn(start, egg) end

---------------------------------------------------------------- GALAXIE : lueur d'aspiration, fondus (saut / départ)
local pullGlow = fxPart(Vector3.one * 12, CFrame.new(0, -500, 0), PINK, 1, Enum.PartType.Ball)
pullGlow.Name = "GalaxyPullGlow"
pullGlow.Parent = fxFolder
local glowLevel = 0
local galaxyState = {Model = nil, Alpha = 1, Saved = {}}
local function galaxyAlpha(g, T)
	local out, inn, depart = g:GetAttribute("WarpOut"), g:GetAttribute("WarpIn"), g:GetAttribute("Depart")
	local alpha = 1
	if out and (not inn or out > inn) then alpha = 1 - clamp01((T - out) / 0.9)
	elseif inn then alpha = clamp01((T - inn) / 0.9) end
	if depart then alpha = math.min(alpha, 1 - clamp01((T - depart) / 1.6)) end
	return alpha
end
local function applyGalaxyAlpha(g, alpha)
	local saved = galaxyState.Saved
	for _, d in g:GetDescendants() do
		if d:IsA("BasePart") then
			d.LocalTransparencyModifier = 1 - alpha
		elseif d:IsA("ParticleEmitter") or d:IsA("Light") then
			if saved[d] == nil then saved[d] = d.Enabled end
			d.Enabled = saved[d] and alpha > 0.5
		end
	end
end
local lastWarp = {}

local skyCheck = 0
RunService.RenderStepped:Connect(function(dt)
	local T = now()
	-- ciel : actif tant que l'event dure (attribut posé par SkyEventsServer)
	skyCheck += dt
	if skyCheck > 0.25 then
		skyCheck = 0
		local endAt = ReplicatedStorage:GetAttribute("GalaxyEventEnd")
		setSky(type(endAt) == "number" and endAt > T)
	end
	-- œufs
	pulling = 0
	for _, ctrl in controllers do
		local ok, err = pcall(update, ctrl, T)
		if not ok then
			warn("[GalaxyEventClient] " .. tostring(err))
			pcall(finish, ctrl, "error") -- en cas de problème, l'œuf réel est quand même remis
		end
	end
	-- galaxie
	local g = findGalaxy()
	if g ~= galaxyState.Model then galaxyState.Model, galaxyState.Alpha, galaxyState.Saved = g, 1, {} end
	local core = g and g:FindFirstChild("Core")
	if g and core then
		local alpha = galaxyAlpha(g, T)
		if math.abs(alpha - galaxyState.Alpha) > 0.001 then
			galaxyState.Alpha = alpha
			applyGalaxyAlpha(g, alpha)
		end
		for _, key in {"WarpOut", "WarpIn"} do -- vortex au moment du saut
			local at = g:GetAttribute(key)
			if at and lastWarp[key] ~= at then
				lastWarp[key] = at
				if T - at < 0.5 then
					cosmicBurst(core.Position, 3, 120)
					burst(core.Position, {Texture = TEX.Ring, Color = ColorSequence.new(PINK, CYAN), Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
						EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new(0.01, 0.01), RotSpeed = NumberRange.new(300, 300), Lifetime = NumberRange.new(0.9, 0.9),
						Size = NumberSequence.new({NumberSequenceKeypoint.new(0, key == "WarpOut" and 110 or 10), NumberSequenceKeypoint.new(1, key == "WarpOut" and 5 or 120)}),
						Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})}, 3, 1.5)
				end
			end
		end
		-- lueur du cœur qui s'intensifie quand elle aspire des œufs
		glowLevel += ((pulling > 0 and 1 or 0) - glowLevel) * math.min(dt * 3, 1)
		local pulse = 1 + math.sin(os.clock() * 6) * 0.12
		pullGlow.CFrame = CFrame.new(core.Position)
		pullGlow.Size = Vector3.one * (9 + 5 * glowLevel * pulse)
		pullGlow.Transparency = 1 - (0.22 * glowLevel * galaxyState.Alpha)
	else
		glowLevel = 0
		if pullGlow.Transparency < 1 then pullGlow.Transparency = 1 end
	end
end)
