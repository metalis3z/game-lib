-- DiscoFxClient : les moments forts de la mutation DISCO, joués par chaque joueur (remote EggSystem.Remotes.DiscoFx,
-- envoyé seulement par le serveur : rien ne remonte vers le serveur).
--   "mutate" (un œuf vient de prendre une mutation d'event, SkyEventsServer) : l'icône de la mutation jaillit au-dessus de l'œuf
--            (rayons qui tournent, halo) - pas de texte. DISCO en plus : une boule à facettes tombe sur l'œuf et lance des
--            faisceaux, confettis, piste de danse lumineuse, notes de musique ; les autres : éclats et anneau à leurs couleurs
--   "hatch"  (un œuf DISCO éclot, EggZoneServer) : explosion disco autour de l'animal : piste de danse qui s'ouvre, projecteurs
--            qui tombent sur lui, fontaine de confettis, notes, reflets et "DISCO!"
-- Seulement si la scène est près de la caméra ; tout est enlevé tout seul à la fin.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local remote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("DiscoFx")
local rgb = Color3.fromRGB
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local NEAR = 400
local TEX = {
	Sheet = "rbxassetid://83726142184589", Glint = "rbxassetid://113227300445053", Note = "rbxassetid://127232527864959",
	Floor = "rbxassetid://71245072274787", Tile = "rbxassetid://78961726782405", Glow = "rbxassetid://4509687978", Rays = "rbxassetid://1084975295",
}
local COLORS = {rgb(255, 70, 215), rgb(70, 220, 255), rgb(150, 90, 255), rgb(255, 230, 80), rgb(80, 130, 255), rgb(60, 255, 200)}
local RAINBOW = ColorSequence.new({
	ColorSequenceKeypoint.new(0, rgb(255, 70, 215)), ColorSequenceKeypoint.new(0.2, rgb(255, 230, 80)), ColorSequenceKeypoint.new(0.4, rgb(60, 255, 200)),
	ColorSequenceKeypoint.new(0.6, rgb(70, 200, 255)), ColorSequenceKeypoint.new(0.8, rgb(150, 90, 255)), ColorSequenceKeypoint.new(1, rgb(255, 70, 215))})
local CONFETTI = ColorSequence.new({
	ColorSequenceKeypoint.new(0, rgb(255, 70, 215)), ColorSequenceKeypoint.new(0.25, rgb(255, 230, 80)), ColorSequenceKeypoint.new(0.5, rgb(70, 220, 255)),
	ColorSequenceKeypoint.new(0.75, rgb(150, 90, 255)), ColorSequenceKeypoint.new(1, rgb(60, 255, 200))})

local folder = Instance.new("Folder")
folder.Name = "DiscoMomentFx" -- (local à ce joueur)
folder.Parent = workspace
local active = {} -- effets en cours, animés par la boucle

local function near(pos)
	local cam = workspace.CurrentCamera
	return cam and (cam.CFrame.Position - pos).Magnitude < NEAR
end
local function anchor(pos)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Transparency = 1
	p.Size = Vector3.one * 0.2
	p.CFrame = CFrame.new(pos)
	p.Parent = folder
	return p
end
local function emitter(parent, props)
	local e = Instance.new("ParticleEmitter")
	e.Rate = 0
	e.LightEmission, e.LightInfluence = 1, 0
	for k, v in props do e[k] = v end
	e.Parent = parent
	return e
end
local function stroke(o, t)
	local s = Instance.new("UIStroke")
	s.Thickness = t
	s.Color = Color3.new(0, 0, 0)
	s.Parent = o
	return s
end

---------------------------------------------------------------- icône de la mutation qui jaillit (pas de texte)
-- l'icône surgit en rebondissant, des rayons de lumière tournent derrière elle (aux couleurs de la mutation, arc-en-ciel pour
-- Disco), elle flotte en se balançant puis monte et s'efface
local EggConfig = require(ReplicatedStorage.EggSystem:WaitForChild("EggConfig"))
local function iconPop(pos, h, mutation, life)
	local holder = anchor(pos)
	local side = 4 + h * 0.55
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.new(side * 1.9, 0, side * 1.9, 0)
	bb.LightInfluence = 0
	bb.MaxDistance = NEAR
	bb.Parent = holder
	local scale = Instance.new("UIScale")
	scale.Scale = 0
	scale.Parent = bb
	local info = EggConfig.GetMutation(mutation)
	local color = info and info.Color or Color3.new(1, 1, 1)
	local rays = Instance.new("ImageLabel")
	rays.BackgroundTransparency = 1
	rays.AnchorPoint = Vector2.new(0.5, 0.5)
	rays.Position = UDim2.fromScale(0.5, 0.5)
	rays.Size = UDim2.fromScale(1, 1)
	rays.Image = TEX.Rays
	rays.ImageColor3 = color
	rays.ImageTransparency = 0.25
	rays.Parent = bb
	local glowImg = Instance.new("ImageLabel")
	glowImg.BackgroundTransparency = 1
	glowImg.AnchorPoint = Vector2.new(0.5, 0.5)
	glowImg.Position = UDim2.fromScale(0.5, 0.5)
	glowImg.Size = UDim2.fromScale(0.85, 0.85)
	glowImg.Image = TEX.Glow
	glowImg.ImageColor3 = color
	glowImg.ImageTransparency = 0.3
	glowImg.Parent = bb
	local icon = Instance.new("ImageLabel")
	icon.BackgroundTransparency = 1
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.Position = UDim2.fromScale(0.5, 0.5)
	icon.Size = UDim2.fromScale(0.52, 0.52)
	icon.Image = EggConfig.MutationIcons[mutation] or ""
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Parent = bb
	TweenService:Create(scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	table.insert(active, {Kind = "icon", Holder = holder, Rays = rays, Glow = glowImg, Icon = icon, Scale = scale, From = pos, Born = os.clock(), Life = life,
		Rainbow = mutation == "Disco", Color = color})
	Debris:AddItem(holder, life + 0.2)
end

---------------------------------------------------------------- petite piste de danse au sol + confettis + notes + reflets
local function groundBurst(pos, h, big)
	local base = anchor(pos + Vector3.new(0, 0.3, 0))
	local k = big and 1.5 or 1
	emitter(base, {Texture = TEX.Floor, Color = ColorSequence.new(Color3.new(1, 1, 1)), Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
		EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new(0.01), Lifetime = NumberRange.new(1.6), RotSpeed = NumberRange.new(60), Rotation = NumberRange.new(0, 360),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, h * 0.8), NumberSequenceKeypoint.new(1, (h * 3 + 10) * k)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(0.6, 0.6), NumberSequenceKeypoint.new(1, 1)})}):Emit(1)
	-- confettis : un émetteur par couleur (chaque confetti garde sa couleur)
	for _, c in COLORS do
		emitter(base, {Texture = TEX.Tile, Color = ColorSequence.new(c), LightEmission = 0.3, Speed = NumberRange.new(h * 3 + 14, h * 5 + 24), SpreadAngle = Vector2.new(35, 35),
			EmissionDirection = Enum.NormalId.Top, Acceleration = Vector3.new(0, -(h * 4 + 30), 0), Drag = 0.8, Lifetime = NumberRange.new(1.4, 2.4),
			RotSpeed = NumberRange.new(-400, 400), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new(0.22 + h * 0.04)}):Emit(math.floor(11 * k))
	end
	emitter(base, {Texture = TEX.Note, Color = CONFETTI, Speed = NumberRange.new(h + 4, h * 2 + 8), SpreadAngle = Vector2.new(60, 60), EmissionDirection = Enum.NormalId.Top,
		Acceleration = Vector3.new(0, 2, 0), Drag = 1, Lifetime = NumberRange.new(1.4, 2.2), RotSpeed = NumberRange.new(-60, 60),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 0.8 + h * 0.18), NumberSequenceKeypoint.new(1, 0)})}):Emit(math.floor(10 * k))
	emitter(base, {Texture = TEX.Glint, Color = ColorSequence.new(Color3.new(1, 1, 1), rgb(255, 170, 245)), Shape = Enum.ParticleEmitterShape.Sphere,
		Speed = NumberRange.new(h * 2, h * 4 + 6), Drag = 4, Lifetime = NumberRange.new(0.4, 0.8), RotSpeed = NumberRange.new(-180, 180),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.8 + h * 0.2), NumberSequenceKeypoint.new(1, 0)})}):Emit(math.floor(24 * k))
	local light = Instance.new("PointLight")
	light.Range, light.Brightness, light.Shadows = 18 + h * 3, 5, false
	light.Color = COLORS[1]
	light.Parent = base
	table.insert(active, {Kind = "light", Light = light, Born = os.clock(), Life = 1.6})
	Debris:AddItem(base, 3)
end

---------------------------------------------------------------- boule à facettes qui tombe au-dessus de l'œuf et lance des faisceaux
local function ballDrop(top, h, life)
	local size = 2.5 + h * 0.55
	local stopAt = top + Vector3.new(0, size * 0.6 + 1.5, 0)
	local holder = anchor(stopAt + Vector3.new(0, 16 + h, 0))
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.new(size, 0, size, 0)
	bb.LightInfluence = 0
	bb.MaxDistance = NEAR
	local img = Instance.new("ImageLabel")
	img.BackgroundTransparency = 1
	img.Size = UDim2.fromScale(1, 1)
	img.Image = TEX.Sheet
	img.ImageRectSize = Vector2.new(128, 128)
	img.Parent = bb
	bb.Parent = holder
	local ballAt = Instance.new("Attachment")
	ballAt.Parent = holder
	-- faisceaux : de la boule vers des taches qui tournent au sol autour de l'œuf
	local spots = {}
	for i = 1, 6 do
		local spot = Instance.new("Attachment")
		spot.Parent = workspace.Terrain
		local b = Instance.new("Beam")
		b.Attachment0, b.Attachment1 = ballAt, spot
		b.Texture, b.TextureMode = TEX.Glow, Enum.TextureMode.Stretch
		b.FaceCamera, b.LightEmission, b.LightInfluence, b.Segments = true, 1, 0, 1
		b.Color = ColorSequence.new(Color3.new(1, 1, 1), COLORS[i])
		b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.75)})
		b.Width0, b.Width1 = 0.3, 0
		b.Parent = spot
		table.insert(spots, {At = spot, Beam = b, Phase = i * math.pi / 3})
		Debris:AddItem(spot, life + 0.3)
	end
	table.insert(active, {Kind = "ball", Holder = holder, Image = img, Spots = spots, From = holder.Position, To = stopAt, Ground = top - Vector3.new(0, h, 0),
		H = h, Size = size, Born = os.clock(), Life = life, Bb = bb})
	Debris:AddItem(holder, life + 0.3)
end

---------------------------------------------------------------- projecteurs qui tombent du ciel sur l'animal (éclosion)
local function spotlights(ground, h, life)
	local hit = Instance.new("Attachment")
	hit.WorldPosition = ground + Vector3.new(0, 0.2, 0)
	hit.Parent = workspace.Terrain
	local list = {}
	for i = 1, 4 do
		local a = Instance.new("Attachment")
		local angle = i * math.pi / 2
		a.WorldPosition = ground + Vector3.new(math.cos(angle) * (h * 4 + 14), h * 5 + 30, math.sin(angle) * (h * 4 + 14))
		a.Parent = workspace.Terrain
		local b = Instance.new("Beam")
		b.Attachment0, b.Attachment1 = a, hit
		b.Texture, b.TextureMode, b.TextureSpeed = TEX.Rays, Enum.TextureMode.Stretch, 1
		b.FaceCamera, b.LightEmission, b.LightInfluence, b.Segments = true, 1, 0, 1
		b.Color = ColorSequence.new(Color3.new(1, 1, 1), COLORS[i])
		b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 0.25)})
		b.Width0, b.Width1 = 1, 0
		b.Parent = a
		table.insert(list, {At = a, Beam = b, Angle = angle})
		Debris:AddItem(a, life + 0.3)
	end
	Debris:AddItem(hit, life + 0.3)
	table.insert(active, {Kind = "spots", List = list, Ground = ground, H = h, Born = os.clock(), Life = life})
end

---------------------------------------------------------------- éclats aux couleurs d'une mutation (autres events)
local function sparkBurst(pos, h, color)
	local base = anchor(pos)
	emitter(base, {Texture = TEX.Glint, Color = ColorSequence.new(Color3.new(1, 1, 1), color), Speed = NumberRange.new(h * 2 + 6, h * 4 + 12), SpreadAngle = Vector2.new(180, 180),
		Drag = 3, Lifetime = NumberRange.new(0.5, 1), RotSpeed = NumberRange.new(-180, 180), Rotation = NumberRange.new(0, 360),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.9 + h * 0.2), NumberSequenceKeypoint.new(1, 0)})}):Emit(40)
	emitter(base, {Texture = "rbxassetid://8271495905", Color = ColorSequence.new(color), Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
		EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new(0.01), Lifetime = NumberRange.new(0.9), RotSpeed = NumberRange.new(120),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, h), NumberSequenceKeypoint.new(1, h * 3 + 8)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})}):Emit(2)
	local light = Instance.new("PointLight")
	light.Range, light.Brightness, light.Shadows, light.Color = 16 + h * 3, 4, false, color
	light.Parent = base
	TweenService:Create(light, TweenInfo.new(1.2), {Brightness = 0}):Play()
	Debris:AddItem(base, 2)
end

---------------------------------------------------------------- animations
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for i = #active, 1, -1 do
		local fx = active[i]
		local age = t - fx.Born
		local u = age / fx.Life
		if u >= 1 or (fx.Holder and not fx.Holder.Parent) then
			table.remove(active, i)
		elseif fx.Kind == "icon" then
			-- rayons qui tournent, halo qui pulse, icône qui se balance ; arc-en-ciel qui défile pour Disco ; puis monte et s'efface
			fx.Rays.Rotation = (age * 70) % 360
			fx.Icon.Rotation = math.sin(t * 3) * 8
			fx.Scale.Scale = age > 0.5 and (1 + math.sin(t * 6) * 0.05) or fx.Scale.Scale
			if fx.Rainbow then
				local c = Color3.fromHSV((t * 0.6) % 1, 0.75, 1)
				fx.Rays.ImageColor3, fx.Glow.ImageColor3 = c, Color3.fromHSV((t * 0.6 + 0.5) % 1, 0.7, 1)
			end
			fx.Holder.CFrame = CFrame.new(fx.From + Vector3.new(0, u * 3.5, 0))
			local fade = math.clamp((u - 0.78) / 0.22, 0, 1)
			fx.Icon.ImageTransparency = fade
			fx.Rays.ImageTransparency = 0.25 + 0.75 * fade
			fx.Glow.ImageTransparency = 0.3 + 0.7 * fade
		elseif fx.Kind == "ball" then
			-- chute avec rebond, rotation (feuille de 16 images), faisceaux qui tournent autour de l'œuf, puis elle remonte
			local fall = math.clamp(age / 0.55, 0, 1)
			local c1, c3 = 1.70158, 2.70158
			local e = 1 + c3 * (fall - 1) ^ 3 + c1 * (fall - 1) ^ 2
			local pos = fx.From:Lerp(fx.To, e)
			if u > 0.82 then pos = fx.To + Vector3.new(0, ((u - 0.82) / 0.18) ^ 2 * 18, 0) end
			fx.Holder.CFrame = CFrame.new(pos + Vector3.new(0, math.sin(t * 3) * 0.25, 0))
			local frame = math.floor(t * 14) % 16
			fx.Image.ImageRectOffset = Vector2.new(frame % 4 * 128, frame // 4 * 128)
			local open = math.clamp((age - 0.5) / 0.3, 0, 1) * (1 - math.clamp((u - 0.82) / 0.1, 0, 1))
			for _, s in fx.Spots do
				local a = s.Phase + t * 1.8
				s.At.WorldPosition = fx.Ground + Vector3.new(math.cos(a) * (fx.H * 1.2 + 4), 0.2, math.sin(a) * (fx.H * 1.2 + 4))
				s.Beam.Width0, s.Beam.Width1 = 0.4 * open, (fx.H * 0.9 + 3) * open
			end
		elseif fx.Kind == "spots" then
			local open = math.clamp(age / 0.4, 0, 1) * (1 - math.clamp((u - 0.75) / 0.25, 0, 1))
			for _, s in fx.List do
				local a = s.Angle + t * 0.9
				s.At.WorldPosition = fx.Ground + Vector3.new(math.cos(a) * (fx.H * 4 + 14), fx.H * 5 + 30, math.sin(a) * (fx.H * 4 + 14))
				s.Beam.Width0, s.Beam.Width1 = (fx.H * 1.5 + 6) * open, (fx.H * 0.6 + 2) * open
			end
		elseif fx.Kind == "light" then
			fx.Light.Color = COLORS[math.floor(t * 10) % #COLORS + 1]
			fx.Light.Brightness = 5 * (1 - u)
		end
	end
end)

---------------------------------------------------------------- les deux moments
remote.OnClientEvent:Connect(function(kind, pos, height, mult, mutationName)
	if typeof(pos) ~= "Vector3" or not near(pos) then return end
	local h = math.clamp(tonumber(height) or 3, 1, 40)
	if kind == "mutate" then
		local mutation = typeof(mutationName) == "string" and mutationName or "Disco"
		iconPop(pos + Vector3.new(0, h * 0.6 + 5, 0), h, mutation, 3.4)
		if mutation == "Disco" then
			ballDrop(pos, h, 3.4)
			groundBurst(pos - Vector3.new(0, h, 0), h, false)
		else
			local info = EggConfig.GetMutation(mutation)
			sparkBurst(pos, h, info and info.Color or Color3.new(1, 1, 1))
		end
	elseif kind == "hatch" then
		spotlights(pos, h, 3)
		groundBurst(pos, h, true)
		task.delay(0.15, groundBurst, pos, h, false)
		iconPop(pos + Vector3.new(0, h * 1.6 + 6, 0), h, "Disco", 3.2)
	end
end)
