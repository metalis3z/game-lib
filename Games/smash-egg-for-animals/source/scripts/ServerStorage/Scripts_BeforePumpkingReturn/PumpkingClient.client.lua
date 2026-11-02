-- Pumpking, boss de la zone Halloween : animation de son squelette (repos, marche, course, rugissement, saut, vol, atterrissage).
-- Le serveur (ZoneBossServer) le déplace et pose les attributs Chasing / Jump / Flying ; ici on ne fait que bouger les articulations.
-- Le modèle regarde vers +Z. Articulations (Weld avec l'attribut PK) : Body, Neck, Head, Jaw, ArmR/L, ForeR/L, HindR/L, ShankR/L, WingR/L, Tail1..8.
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local TAG = "ZoneBoss"
local WINDUP = 0.9        -- durée du rugissement avant la charge (même valeur que ZoneBossServer)
local JUMP_CROUCH = 0.4   -- durée accroupi avant le saut d'envol (même valeur que ZoneBossServer)
local STRIDE_LENGTH = 17  -- studs parcourus pendant un cycle complet des quatre pattes
local MAX_CADENCE = 220   -- au-delà de cette vitesse les pattes ne vont pas plus vite (il court à ~117 dans la dernière zone)
local VIEW_DISTANCE = 700 -- plus loin que ça, on n'anime pas
local TAU = math.pi * 2
local sin, cos, abs, max, min, clamp, sqrt, asin = math.sin, math.cos, math.abs, math.max, math.min, math.clamp, math.sqrt, math.asin
local A = CFrame.Angles
local rng = Random.new()

-- cycle des pattes : marche (une patte à la fois, comme un lion) -> galop (les deux arrière, puis les deux avant)
local LEGS = {
	{Top = "HindL", Low = "ShankL", Front = false, Walk = 0, Gallop = 0},
	{Top = "ArmL", Low = "ForeL", Front = true, Walk = 0.25, Gallop = 0.5},
	{Top = "HindR", Low = "ShankR", Front = false, Walk = 0.5, Gallop = 0.12},
	{Top = "ArmR", Low = "ForeR", Front = true, Walk = 0.75, Gallop = 0.62},
}

local rigs = {}
local function setup(model)
	if rigs[model] or model:GetAttribute("Rig") ~= "Pumpking" then return end
	local J, count, lights = {}, 0, {}
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("PK") then
			J[d:GetAttribute("PK")] = {Weld = d, Base = d.C0}
			count += 1
		elseif d:IsA("PointLight") and d.Name == "Ember" then
			table.insert(lights, {Light = d, Base = d.Brightness})
		end
	end
	if count < (model:GetAttribute("PKJoints") or math.huge) then return end -- pas encore entièrement chargé
	rigs[model] = {
		J = J, Lights = lights, Angry = false, WasFlying = false,
		Phase = 0, Stride = 0, Charge = 0, Windup = 0, Fly = 0, Flap = 0, Turn = 0, Yaw = nil, JumpTime = nil, Land = nil,
		LookTimer = 0, LookYaw = 0, LookTilt = 0, HeadYaw = 0, HeadTilt = 0,
		GrowlTimer = rng:NextNumber(5, 9), Growl = nil, RoarTimer = rng:NextNumber(12, 20), Roar = nil,
	}
	model.Destroying:Connect(function() rigs[model] = nil end)
end
-- le modèle arrive morceau par morceau côté client : on réessaie tant que le squelette n'est pas complet
task.spawn(function()
	while true do
		for _, m in CollectionService:GetTagged(TAG) do
			if not rigs[m] and m:IsDescendantOf(workspace) then setup(m) end
		end
		task.wait(0.5)
	end
end)

local function pose(joint, cf)
	if joint then joint.Weld.C0 = joint.Base * cf end
end
local function smooth(x)
	x = clamp(x, 0, 1)
	return x * x * (3 - 2 * x)
end
-- une patte dans son cycle (f de 0 à 1) : en appui elle recule sous le corps, puis elle se lève et revient vers l'avant.
-- Renvoie le balancement (-1 = patte en avant, 1 = patte en arrière) et la hauteur du pied (0..1).
local function step(f, stance)
	if f < stance then return -1 + 2 * f / stance, 0 end
	local k = (f - stance) / (1 - stance)
	return 1 - 2 * smooth(k), sin(k * math.pi)
end
-- quand le corps descend de d studs, les pattes avant plient pour que la patte reste posée au même endroit
local function foldFront(d)
	local a = 0.65 * sqrt(max(d, 0) / 1.36)
	return a, a + asin(min(1, 0.75 * sin(a)))
end

RunService.RenderStepped:Connect(function(dt)
	dt = min(dt, 0.1)
	local t = os.clock()
	local camera = workspace.CurrentCamera
	for model, r in rigs do
		local root = model.PrimaryPart
		if not root or (camera and (camera.CFrame.Position - root.Position).Magnitude > VIEW_DISTANCE) then continue end
		local J = r.J
		local velocity = root.AssemblyLinearVelocity
		local speed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
		local chasing = model:GetAttribute("Chasing") == true
		local flying = model:GetAttribute("Flying") == true

		-- états fondus : colère, rugissement (1 -> 0), course, vol, foulée, virage
		if chasing and not r.Angry then r.Windup = WINDUP end
		r.Angry = chasing
		r.Windup = max(0, r.Windup - dt)
		r.Charge += ((chasing and 1 or 0) - r.Charge) * min(1, dt * 6)
		local rage = r.Charge
		local windup = chasing and smooth(r.Windup / WINDUP) or 0
		local run = rage * (1 - windup)
		r.Fly += ((flying and 1 or 0) - r.Fly) * min(1, dt * 4)
		local fly = r.Fly
		r.Stride += (clamp(speed / 10, 0, 1) - r.Stride) * min(1, dt * 8)
		local stride = r.Stride * (1 - fly)
		r.Phase = (r.Phase + dt * min(speed, MAX_CADENCE) / STRIDE_LENGTH) % 1
		local phase = r.Phase
		local climb = clamp(velocity.Y / 25, -1, 1)
		local _, yaw = root.CFrame:ToOrientation()
		local turn = r.Yaw and ((yaw - r.Yaw + math.pi) % TAU - math.pi) / dt or 0
		r.Yaw = yaw
		r.Turn += (clamp(turn, -3, 3) - r.Turn) * min(1, dt * 5)
		local idle = (1 - r.Stride) * (1 - rage) * (1 - fly)

		-- au repos : il regarde lentement autour de lui, grogne de temps en temps, et parfois rugit
		r.LookTimer -= dt
		if r.LookTimer <= 0 then
			r.LookTimer = rng:NextNumber(1.8, 4.5)
			r.LookYaw, r.LookTilt = rng:NextNumber(-0.6, 0.6), rng:NextNumber(-0.12, 0.12)
		end
		r.HeadYaw += (r.LookYaw - r.HeadYaw) * min(1, dt * 2.5)
		r.HeadTilt += (r.LookTilt - r.HeadTilt) * min(1, dt * 2.5)
		if idle > 0.8 then
			r.GrowlTimer -= dt
			r.RoarTimer -= dt
			if r.GrowlTimer <= 0 then r.GrowlTimer, r.Growl = rng:NextNumber(6, 11), 0 end
			if r.RoarTimer <= 0 then r.RoarTimer, r.Roar = rng:NextNumber(16, 28), 0 end
		end
		local growl = 0
		if r.Growl then
			r.Growl += dt
			if r.Growl > 1.6 then r.Growl = nil else growl = sin(r.Growl / 1.6 * math.pi) * idle end
		end
		local roar = windup * rage -- rugissement : avant la charge, ou de lui-même quand il s'ennuie
		if r.Roar then
			r.Roar += dt
			if r.Roar > 2.2 then r.Roar = nil else roar = max(roar, smooth(min(r.Roar, 2.2 - r.Roar) * 2.5) * idle) end
		end

		-- saut d'envol (il s'accroupit puis se détend) et atterrissage (il s'écrase sur ses pattes puis se relève)
		if model:GetAttribute("Jump") then r.JumpTime = (r.JumpTime or 0) + dt else r.JumpTime = nil end
		local crouch = 0
		if r.JumpTime then
			if r.JumpTime < JUMP_CROUCH then
				crouch = (r.JumpTime / JUMP_CROUCH) ^ 0.6
				r.Flap = math.pi * 0.5 -- ailes en haut, prêtes pour le premier grand coup d'aile
			else
				crouch = max(0, 1 - (r.JumpTime - JUMP_CROUCH) / 0.12)
			end
		end
		if r.WasFlying and not flying then r.Land = 0 end
		r.WasFlying = flying
		local squash = 0
		if r.Land then
			r.Land += dt
			if r.Land > 0.7 then r.Land = nil else
				local k = r.Land / 0.7
				squash = sin(min(1, k * 5) * math.pi / 2) * (1 - k) ^ 2
			end
		end
		r.Flap += dt * (2 + 3.4 * fly) * (crouch > 0.5 and 0 or 1) -- un peu moins d'un grand battement par seconde en vol
		local flap = r.Flap
		local breathe = sin(t * 1.3)
		local sink = (1.3 * crouch + 1.5 * squash) * (1 - fly) -- de combien le corps descend, pattes pliées

		-- corps : respiration, rebond à chaque foulée, se cabre pour rugir, pique en charge, s'incline en vol
		local bodyY = 0.07 * breathe * idle + cos(phase * TAU * 2) * 0.12 * stride * (1 + run) - sink + cos(flap + 0.5) * 0.4 * fly
		local bodyPitch = 0.006 * breathe * idle - 0.22 * roar + 0.03 * run * (1 - fly) + 0.08 * crouch
			+ sin(phase * TAU * 2 + 0.8) * 0.03 * stride * run + (-0.07 - 0.22 * climb) * fly
		local bodyRoll = sin(phase * TAU) * 0.025 * stride - r.Turn * (0.03 + 0.1 * fly)
		local bodyYaw = sin(phase * TAU) * 0.03 * stride
		pose(J.Body, CFrame.new(0, bodyY, 0) * A(bodyPitch, bodyYaw, bodyRoll))

		-- cou, tête, mâchoire
		local neckPitch = -0.26 * roar + 0.16 * run + sin(phase * TAU * 2 + 0.6) * 0.035 * stride + 0.12 * growl - 0.08 * fly + 0.1 * squash
		local turn = model:GetAttribute("HeadTurn") or 0 -- la tête tournée de l'extérieur (cinématique : il balaie en crachant le feu)
		local breath = model:GetAttribute("Breath") and 0.55 or 0
		pose(J.Neck, A(neckPitch, r.HeadYaw * 0.4 * idle - bodyYaw * 0.6 + turn * 0.45, 0))
		local headPitch = sin(t * 0.9) * 0.03 * idle - 0.2 * roar + 0.05 * run - sin(phase * TAU * 2 + 0.6) * 0.03 * stride + 0.1 * growl
		local headYaw = r.HeadYaw * 0.6 * idle + sin(t * 31) * 0.04 * roar + sin(t * 23) * 0.03 * growl
		local headRoll = r.HeadTilt * idle + sin(t * 27) * 0.03 * roar - bodyRoll * 0.6
		pose(J.Head, A(headPitch, headYaw + turn * 0.55, headRoll))
		pose(J.Jaw, A(0.03 + breath + 0.6 * roar + (0.12 + 0.1 * abs(sin(t * 7))) * run + 0.28 * growl + max(0, sin(t * 0.8)) * 0.04 * idle, 0, 0))

		-- pattes
		local stance = 0.62 - 0.2 * run
		local foldA, foldB = foldFront(sink)
		for index, leg in LEGS do
			local swing, lift = step((phase + leg.Walk + (leg.Gallop - leg.Walk) * run) % 1, stance)
			local side = (leg.Top == "ArmR" or leg.Top == "HindR") and 1 or -1
			local top, low, drop
			if leg.Front then
				top = swing * (0.2 + 0.22 * run) * stride - lift * (0.2 + 0.15 * run) * stride
				low = lift * (0.7 + 0.4 * run) * stride
				-- rugissement : il se cabre, pattes avant ramenées, la droite griffe l'air
				top += (-0.3 + (side == 1 and sin(t * 9) * 0.18 or 0)) * roar
				low += (0.55 + (side == 1 and sin(t * 9 + 1) * 0.2 or 0)) * roar
				top += foldA
				low -= foldB
				-- en vol : pattes avant repliées sous le poitrail
				top = top * (1 - fly) + (-0.5 + sin(flap + side) * 0.05) * fly
				low = low * (1 - fly) + 1.2 * fly
				drop = 0
			else
				top = swing * (0.17 + 0.2 * run) * stride - lift * 0.1 * stride
				low = lift * (0.5 + 0.3 * run) * stride
				top -= 0.29 * sink
				low += 0.56 * sink
				-- en vol : pattes arrière qui traînent derrière lui
				top = top * (1 - fly) + (0.75 + sin(flap + side) * 0.06) * fly
				low = low * (1 - fly) + 0.25 * fly
				drop = sink -- les hanches descendent avec le bassin
			end
			pose(J[leg.Top], CFrame.new(0, -drop, 0) * A(top, 0, 0))
			pose(J[leg.Low], A(low, 0, 0))
		end

		-- ailes : ramenées vers l'arrière au sol, grandes ouvertes pour rugir, larges battements en vol
		local spread = max(fly, roar)
		local back = (0.55 + 0.2 * run) * (1 - spread) - 0.05 * spread
		local up = (-0.12 + 0.03 * breathe + sin(phase * TAU * 2) * 0.03 * stride) * (1 - spread) + (0.35 + sin(t * 20) * 0.03) * roar
			+ 0.5 * crouch * (1 - fly) + (0.1 + sin(flap) * 0.6) * fly
		local twist = -cos(flap) * 0.2 * fly
		pose(J.WingR, A(twist, back, up))
		pose(J.WingL, A(twist, -back, -up))

		-- queue : ondule lentement, fouette quand il est en colère, flotte derrière lui en vol
		for i = 1, 8 do
			local joint = J["Tail" .. i]
			local pitch = sin(t * 1.1 - i * 0.5) * 0.035 + cos(phase * TAU * 2 - i * 0.4) * 0.03 * stride + sin(flap - i * 0.5) * 0.07 * fly + (i == 1 and 0.25 * fly or 0)
			local sway = sin(t * 1.4 - i * 0.55) * 0.07 * (1 - rage) + sin(phase * TAU - i * 0.5) * 0.06 * stride + sin(t * 9 - i * 0.6) * 0.05 * rage - r.Turn * 0.04
			pose(joint, A(pitch, sway, 0))
		end

		-- braises : la lueur de la gueule, du poitrail et de la queue vacille, plus fort quand il est en colère
		for i, ember in r.Lights do
			ember.Light.Brightness = ember.Base * (0.85 + 0.15 * sin(t * 7 + i * 2)) * (1 + 0.7 * rage + 0.6 * roar)
		end
	end
end)
