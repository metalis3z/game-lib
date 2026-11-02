-- THE REAPER, gardien de la zone Phantom (et le Grim Reaper, sa version animal) : animation de son squelette en blocs.
-- Le serveur (ZoneBossServer) déplace le gardien et pose Chasing / SmashAt ; ici on ne bouge que les articulations (Weld, attribut RP) :
--   Body, Head, Robe, Cape, ArmR, ForeR, Scythe, ArmL, ForeL, Lantern, Souls (voir ServerStorage.ReaperBuilder).
-- Il flotte et ondule, la robe et la cape traînent derrière lui quand il file, la lanterne se balance, les âmes tournent autour de lui.
-- En poursuite : yeux rouges, faux levée, âmes qui s'affolent. Quand il touche un voleur : grand coup de faux + onde fantôme.
-- Conventions (rotation autour de X) : pour ce qui MONTE (tronc, tête, faux) positif = vers l'avant ; pour ce qui PEND (bras,
-- robe, cape, lanterne) positif = vers l'arrière.
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local VIEW_BOSS, VIEW_PET = 700, 220
local SLASH_TIME = 0.75
local sin, cos, abs, max, min, clamp = math.sin, math.cos, math.abs, math.max, math.min, math.clamp
local A = CFrame.Angles
local TAU = math.pi * 2
local rng = Random.new()
local SOUL, RAGE = Color3.fromRGB(90, 255, 225), Color3.fromRGB(255, 45, 95)

local function spring(sp, target, dt, k, damp)
	local accel = (target - sp.x) * k - sp.v * damp
	sp.v += accel * dt
	sp.x += sp.v * dt
	return sp.x
end
local function newSpring() return {x = 0, v = 0} end
local function smooth(x)
	x = clamp(x, 0, 1)
	return x * x * (3 - 2 * x)
end

-- coup de faux : un croissant fantôme devant lui et une onde au sol là où le voleur a été touché
local function slashFx(model, at)
	local root = model.PrimaryPart
	if not root then return end
	local s = model:GetScale()
	local base = root.CFrame * CFrame.new(0, 2 * s, 6 * s)
	for i = 0, 8 do
		local a = math.rad(-70 + i * 17.5)
		local p = Instance.new("Part")
		p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
		p.Material = Enum.Material.Neon
		p.Color = i % 2 == 0 and SOUL or Color3.fromRGB(175, 115, 255)
		p.Size = Vector3.new(0.5, 2.6 * s, 0.6) * (1 - abs(i - 4) * 0.12)
		p.CFrame = base * A(0, 0, a) * CFrame.new(0, 9 * s, 0) * A(0, 0, math.rad(90))
		p.Transparency = 0.1
		p.Parent = workspace
		TweenService:Create(p, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1, Size = p.Size * Vector3.new(1, 1.6, 1)}):Play()
		Debris:AddItem(p, 0.45)
	end
	if typeof(at) == "Vector3" then
		local ring = Instance.new("Part")
		ring.Shape = Enum.PartType.Cylinder
		ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch, ring.CastShadow = true, false, false, false, false
		ring.Material = Enum.Material.Neon
		ring.Color = SOUL
		ring.Transparency = 0.3
		ring.Size = Vector3.new(0.4, 6, 6)
		ring.CFrame = CFrame.new(at - Vector3.new(0, 2.6, 0)) * A(0, 0, math.rad(90))
		ring.Parent = workspace
		TweenService:Create(ring, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.4, 60, 60), Transparency = 1}):Play()
		Debris:AddItem(ring, 0.65)
		local holder = Instance.new("Attachment")
		holder.WorldPosition = at
		holder.Parent = workspace.Terrain
		local burst = Instance.new("ParticleEmitter")
		burst.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		burst.Color = ColorSequence.new(SOUL, Color3.fromRGB(175, 115, 255))
		burst.LightEmission, burst.LightInfluence = 1, 0
		burst.Rate = 0
		burst.Lifetime = NumberRange.new(0.5, 0.9)
		burst.Speed = NumberRange.new(12, 24)
		burst.SpreadAngle = Vector2.new(180, 180)
		burst.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})
		burst.Parent = holder
		burst:Emit(40)
		Debris:AddItem(holder, 1.2)
	end
end

local rigs = {}
local function setup(model)
	if rigs[model] or model:GetAttribute("Rig") ~= "Reaper" then return end
	local J, count = {}, 0
	local eyes, lights = {}, {}
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("RP") then
			J[d:GetAttribute("RP")] = {Weld = d, Base = d.C0}
			count += 1
		elseif d:IsA("BasePart") and d.Name == "Eye" then
			table.insert(eyes, d)
		elseif d:IsA("PointLight") then
			lights[d.Name] = {Light = d, Brightness = d.Brightness}
		end
	end
	if count < (model:GetAttribute("RPJoints") or math.huge) then return end -- pas encore entièrement chargé
	local root = model.PrimaryPart
	if not root then return end
	local r = {J = J, Eyes = eyes, Lights = lights, Boss = CollectionService:HasTag(model, "ZoneBoss"), Scale = model:GetScale(),
		Seed = rng:NextNumber(0, 100), LastPos = root.Position, Vel = Vector3.zero, Accel = 0, Turn = 0, Yaw = nil, Rage = 0,
		LookTimer = 0, LookYaw = 0, LookTilt = 0, HeadYaw = 0, HeadTilt = 0, SoulAngle = rng:NextNumber(0, TAU), Slash = nil,
		RobeP = newSpring(), RobeR = newSpring(), CapeP = newSpring(), CapeR = newSpring(), LampP = newSpring(), LampR = newSpring(), ArmLag = newSpring(),
		Gesture = nil, GestureT = 0, GestureLen = 1, NextGesture = rng:NextNumber(3, 7), Spin = 0}
	rigs[model] = r
	model:GetAttributeChangedSignal("SmashAt"):Connect(function()
		r.Slash = 0
		local ok, e = pcall(slashFx, model, model:GetAttribute("SmashAt"))
		if not ok then warn("[ReaperClient] " .. tostring(e)) end
	end)
	model.Destroying:Connect(function() rigs[model] = nil end)
end
task.spawn(function()
	while true do
		for _, tag in {"ZoneBoss", "ReaperRig"} do
			for _, m in CollectionService:GetTagged(tag) do
				-- (pas l'animal tenu en main : PetServer le soude d'un bloc dans l'outil)
				if not rigs[m] and m:IsA("Model") and m:IsDescendantOf(workspace) and not m:FindFirstAncestorWhichIsA("Tool") then setup(m) end
			end
		end
		for m in rigs do if not m:IsDescendantOf(workspace) then rigs[m] = nil end end
		task.wait(0.5)
	end
end)

local function pose(joint, cf)
	if joint then joint.Weld.C0 = joint.Base * cf end
end

RunService.RenderStepped:Connect(function(dt)
	dt = clamp(dt, 1 / 240, 0.05)
	local camera = workspace.CurrentCamera
	for model, r in rigs do
		local root = model.PrimaryPart
		if not root then continue end
		local pos = root.Position
		if camera and (camera.CFrame.Position - pos).Magnitude > (r.Boss and VIEW_BOSS or VIEW_PET) then r.LastPos = pos continue end
		local J, s = r.J, r.Scale
		local t = os.clock() + r.Seed
		-- vitesse mesurée par le déplacement (marche aussi pour l'animal, dont la racine est ancrée)
		local raw = (pos - r.LastPos) / dt
		r.LastPos = pos
		if raw.Magnitude > 400 * s then raw = Vector3.zero end -- téléportation
		local flat = Vector3.new(raw.X, 0, raw.Z)
		local prev = r.Vel
		r.Vel = prev:Lerp(flat, min(1, dt * 8))
		local speed = r.Vel.Magnitude / s
		local fwd = root.CFrame.LookVector * -1
		local accel = (r.Vel - prev):Dot(fwd) / dt / s
		r.Accel += (clamp(accel / 50, -1, 1) - r.Accel) * min(1, dt * 6)
		local _, yaw = root.CFrame:ToOrientation()
		local turn = r.Yaw and ((yaw - r.Yaw + math.pi) % TAU - math.pi) / dt or 0
		r.Yaw = yaw
		r.Turn += (clamp(turn, -3, 3) - r.Turn) * min(1, dt * 5)
		local go = clamp(speed / 40, 0, 1)
		local chasing = model:GetAttribute("Chasing") == true
		r.Rage += ((chasing and 1 or 0) - r.Rage) * min(1, dt * 5)
		local rage = r.Rage
		local idle = (1 - go) * (1 - rage)

		-- coup de faux (SmashAt) : on arme (0 -> 0,25 s), on frappe (-> 0,45 s), on revient (-> 0,75 s)
		local raise, strike = 0, 0
		if r.Slash then
			r.Slash += dt
			local k = r.Slash
			if k > SLASH_TIME then r.Slash = nil
			elseif k < 0.25 then raise = smooth(k / 0.25)
			elseif k < 0.45 then raise = 1 - smooth((k - 0.25) / 0.2) strike = smooth((k - 0.25) / 0.2)
			else strike = 1 - smooth((k - 0.45) / 0.3) end
		end

		-- GESTES au repos (toutes les 6 à 11 s) : "Twirl" il fait tourner sa faux, "Lantern" il lève sa lanterne et la regarde,
		-- "Stare" il tourne brusquement la tête vers le joueur le plus proche, "Rise" il monte un peu puis redescend
		local g = 0 -- force du geste en cours (0 -> 1 -> 0)
		if r.Gesture then
			r.GestureT += dt
			local k = r.GestureT / r.GestureLen
			if k >= 1 or rage > 0.3 or r.Slash then r.Gesture = nil else g = math.sin(k * math.pi) end
		elseif idle > 0.7 then
			r.NextGesture -= dt
			if r.NextGesture <= 0 then
				r.NextGesture = rng:NextNumber(6, 11)
				local list = {"Twirl", "Lantern", "Stare", "Rise"}
				r.Gesture = list[rng:NextInteger(1, #list)]
				r.GestureT, r.GestureLen = 0, ({Twirl = 1.6, Lantern = 2.4, Stare = 2.2, Rise = 2.6})[r.Gesture]
			end
		end
		local twirl = r.Gesture == "Twirl" and g or 0
		local lamp = r.Gesture == "Lantern" and g or 0
		local stare = r.Gesture == "Stare" and g or 0
		local rise = r.Gesture == "Rise" and g or 0

		-- regard : il scrute les alentours, fixe le joueur proche (de temps en temps ou en poursuite)
		r.LookTimer -= dt
		if r.LookTimer <= 0 then
			r.LookTimer = rng:NextNumber(2, 4.5)
			r.LookYaw, r.LookTilt = rng:NextNumber(-0.6, 0.6), rng:NextNumber(-0.12, 0.12)
		end
		local cam = camera and camera.CFrame.Position
		local toCam = cam and root.CFrame:PointToObjectSpace(cam)
		local camYaw = toCam and math.clamp(math.atan2(toCam.X, toCam.Z), -1.1, 1.1) or 0
		local wantYaw = r.LookYaw * (1 - stare) + camYaw * stare
		if lamp > 0 then wantYaw = wantYaw * (1 - lamp) - 0.45 * lamp end
		r.HeadYaw += (wantYaw - r.HeadYaw) * min(1, dt * (stare > 0.2 and 9 or 2.5))
		r.HeadTilt += (r.LookTilt - r.HeadTilt) * min(1, dt * 2.5)

		-- TRONC : il flotte (ondulation lente + petite dérive de côté), respire, se penche quand il file, roule dans les virages
		local bob = (sin(t * 1.7) * 0.55 + sin(t * 0.63) * 0.25 + rise * 2.2) * s
		local drift = sin(t * 0.8) * 0.35 * s * idle
		local breath = sin(t * 2.1) * 0.02
		local bodyPitch = 0.2 * go + 0.12 * rage + 0.05 * max(0, r.Accel) + 0.32 * strike - 0.1 * raise + sin(t * 1.1) * 0.025 * idle + breath - 0.08 * rise + 0.06 * lamp
		local bodyYaw = sin(t * 0.7) * 0.05 * idle - 0.25 * raise + 0.3 * strike + 0.12 * twirl - 0.1 * lamp
		local bodyRoll = -r.Turn * 0.08 + sin(t * 0.9) * 0.03 + sin(t * 0.8 + 1) * 0.03 * idle
		pose(J.Body, CFrame.new(drift, bob, 0) * A(bodyPitch, bodyYaw, bodyRoll))
		-- TÊTE : stabilisée, petit hochement avec la respiration, inclinée de côté quand il fixe quelqu'un (inquiétant)
		pose(J.Head, A(-bodyPitch * 0.6 + 0.12 * rage + r.HeadTilt * idle + sin(t * 0.9) * 0.03 * idle - breath * 1.5 + 0.18 * lamp,
			r.HeadYaw - bodyYaw * 0.7, -bodyRoll * 0.5 + sin(t * 0.5) * 0.04 * idle + 0.22 * stare))

		-- ROBE : elle traîne derrière lui, ondule, se gonfle quand il monte ; CAPE : elle se soulève avec la vitesse et claque
		local robeP = spring(r.RobeP, 0.32 * go + 0.25 * max(0, r.Accel) + 0.1 * rage + sin(t * 1.3) * 0.05 - 0.12 * rise, dt, 40, 6)
		local robeR = spring(r.RobeR, r.Turn * 0.14 + sin(t * 1.05) * 0.05 - drift * 0.08 / s, dt, 40, 6)
		pose(J.Robe, CFrame.new(drift, bob * 0.85, 0) * A(robeP, sin(t * 0.8) * 0.06 + bodyYaw * 0.4, robeR))
		local capeP = spring(r.CapeP, 0.08 + 0.75 * go + 0.2 * rage + 0.35 * max(0, r.Accel) + sin(t * 2.3) * (0.04 + 0.08 * go) + 0.15 * rise, dt, 30, 4.5)
		local capeR = spring(r.CapeR, r.Turn * 0.2 + sin(t * 1.7) * 0.05, dt, 30, 4.5)
		pose(J.Cape, A(capeP, sin(t * 1.3) * 0.04, capeR))

		-- BRAS : ils traînent un peu derrière le corps (ressorts) ; bras droit + faux : levée en poursuite, abattue au coup,
		-- moulinet au repos (la faux tourne sur elle-même autour du manche)
		local armLag = spring(r.ArmLag, -0.25 * r.Accel - 0.15 * go, dt, 25, 5)
		local lift = 0.35 * rage
		pose(J.ArmR, A(-lift - 1.1 * raise + 0.55 * strike + sin(t * 1.2) * 0.04 * idle - 0.35 * twirl + armLag, 0, -0.05 - 0.25 * raise + 0.1 * strike - 0.1 * twirl))
		pose(J.ForeR, A(-0.25 * rage - 0.5 * raise + 0.2 * strike + sin(t * 1.2 + 0.6) * 0.04 * idle - 0.3 * twirl, 0, 0))
		r.Spin = (r.Spin + dt * 7 * twirl) % TAU
		if twirl == 0 then r.Spin += ((r.Spin > math.pi and TAU or 0) - r.Spin) * min(1, dt * 6) end
		pose(J.Scythe, A(sin(t * 0.9) * 0.05 * idle - 0.45 * raise + 1.0 * strike + 0.12 * rage, r.Spin, sin(t * 0.7) * 0.04))
		-- bras gauche : il tend la lanterne en poursuite, la lève devant son visage pendant le geste "Lantern"
		pose(J.ArmL, A(-0.25 * rage + sin(t * 1.15) * 0.05 * idle + 0.15 * raise - 0.9 * lamp + armLag * 0.8, 0, 0.05 + 0.1 * raise - 0.25 * lamp))
		pose(J.ForeL, A(-0.2 * rage + sin(t * 1.15 + 0.5) * 0.05 * idle - 0.6 * lamp, 0, 0))
		-- LANTERNE : balancier qui réagit aux accélérations, aux virages et aux gestes du bras
		local lampP = spring(r.LampP, 0.25 * go + 0.6 * r.Accel + sin(t * 2.1) * 0.06 + 0.5 * lamp, dt, 22, 2.4)
		local lampR = spring(r.LampR, r.Turn * 0.25 + sin(t * 1.6) * 0.05 + drift * 0.1 / s, dt, 22, 2.4)
		pose(J.Lantern, A(lampP, sin(t * 0.9) * 0.3, lampR))

		-- ÂMES : elles tournent autour de lui (plus vite en colère), l'orbite penche et respire
		r.SoulAngle = (r.SoulAngle + dt * (0.9 + 2.6 * rage + 1.5 * twirl)) % TAU
		pose(J.Souls, CFrame.new(0, (sin(t * 1.9) * 0.8 + rise * 1.5) * s, 0) * A(sin(t * 0.8) * 0.12, r.SoulAngle, cos(t * 0.6) * 0.1))

		-- yeux : cyan au calme, rouge en poursuite ; cœur et lanterne qui pulsent
		local eyeColor = SOUL:Lerp(RAGE, rage)
		for _, eye in r.Eyes do eye.Color = eyeColor end
		local pulse = 1 + 0.25 * sin(t * 4) + 0.6 * rage
		for name, l in r.Lights do
			if name == "EyeGlow" then l.Light.Color = eyeColor l.Light.Brightness = l.Brightness * (1 + rage)
			elseif name == "Core" then l.Light.Brightness = l.Brightness * pulse
			elseif name == "LanternLight" then l.Light.Brightness = l.Brightness * (pulse + 0.25 * sin(t * 17) * sin(t * 7.3)) end
		end
	end
end)
