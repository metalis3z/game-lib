-- Zorvex, gardien de la zone Galaxy (robot de l'espace) : animation de son squelette.
-- Le serveur (ZoneBossServer) le déplace et pose les attributs Chasing / Jump / Flying ; ici on ne bouge que les articulations.
-- Le modèle regarde vers +Z. Articulations (Weld, attribut ZV) : Body, Head, Eye, Ant1-3, FinR/L, ArmR/L, ForeR/L, LegR/L, ShinR/L.
-- Conventions d'angle (rotation autour de X) : pour un membre qui PEND (bras, jambes), négatif = vers l'avant ;
-- pour ce qui MONTE (tronc, tête, antenne, ailerons), positif = vers l'avant.
-- Mouvements secondaires "réalistes" : l'antenne (3 segments) et les ailerons dorsaux sont des ressorts amortis qui traînent
-- derrière les mouvements du corps (pas, virages, accélérations), comme la queue du Kitsune.
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local TAG = "ZoneBoss"
local WINDUP = 0.35
local JUMP_CROUCH = 0.4
local STRIDE_LENGTH = 15   -- studs parcourus pendant un cycle (deux pas)
local MAX_CADENCE = 120
local VIEW_DISTANCE = 700
local TAU = math.pi * 2
local sin, cos, abs, max, min, clamp = math.sin, math.cos, math.abs, math.max, math.min, math.clamp
local A = CFrame.Angles
local rng = Random.new()
local CYAN, ANGRY = Color3.fromRGB(90, 235, 255), Color3.fromRGB(255, 60, 120)

-- ressort amorti : la valeur suit sa cible avec du retard et un petit rebond
local function spring(sp, target, dt, k, damp)
	local accel = (target - sp.x) * k - sp.v * damp
	sp.v += accel * dt
	sp.x += sp.v * dt
	return sp.x
end
local function newSpring() return {x = 0, v = 0} end

local rigs = {}
local function setup(model)
	if rigs[model] or model:GetAttribute("Rig") ~= "Zorvex" then return end
	local J, count, thrusters, core = {}, 0, {}, nil
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("ZV") then
			J[d:GetAttribute("ZV")] = {Weld = d, Base = d.C0}
			count += 1
		elseif d:IsA("ParticleEmitter") and d.Name == "Thruster" then
			table.insert(thrusters, d)
		elseif d:IsA("PointLight") and d.Name == "Core" then
			core = d
		end
	end
	if count < (model:GetAttribute("ZVJoints") or math.huge) then return end -- pas encore entièrement chargé
	local eyeModel = model:FindFirstChild("Eye")
	rigs[model] = {J = J, Thrusters = thrusters, Core = core, Eye = eyeModel and eyeModel:FindFirstChild("EyeGlow"),
		Angry = false, WasFlying = false, Phase = 0, Stride = 0, Charge = 0, Windup = 0, Fly = 0, Turn = 0, Yaw = nil,
		JumpTime = nil, Land = nil, LastVel = Vector3.zero, Accel = 0,
		LookTimer = 0, LookYaw = 0, LookTilt = 0, HeadYaw = 0, HeadTilt = 0, PoseTimer = rng:NextNumber(8, 14), Flex = nil,
		AntP = {newSpring(), newSpring(), newSpring()}, AntR = {newSpring(), newSpring(), newSpring()}, FinP = newSpring(), FinR = newSpring()}
	model.Destroying:Connect(function() rigs[model] = nil end)
end
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

RunService.RenderStepped:Connect(function(dt)
	dt = clamp(dt, 1 / 240, 0.05)
	local t = os.clock()
	local camera = workspace.CurrentCamera
	for model, r in rigs do
		local root = model.PrimaryPart
		if not root or (camera and (camera.CFrame.Position - root.Position).Magnitude > VIEW_DISTANCE) then continue end
		local J = r.J
		local velocity = root.AssemblyLinearVelocity
		local flatVel = Vector3.new(velocity.X, 0, velocity.Z)
		local speed = flatVel.Magnitude
		local chasing = model:GetAttribute("Chasing") == true
		local flying = model:GetAttribute("Flying") == true
		-- accélération vers l'avant (dans son repère) : ressorts et inclinaison
		local fwd = root.CFrame.LookVector * -1 -- (+Z du modèle)
		local accel = (flatVel - r.LastVel):Dot(fwd) / dt
		r.LastVel = flatVel
		r.Accel += (clamp(accel / 60, -1, 1) - r.Accel) * min(1, dt * 6)

		-- états fondus
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
		local phase = r.Phase * TAU
		local _, yaw = root.CFrame:ToOrientation()
		local turn = r.Yaw and ((yaw - r.Yaw + math.pi) % TAU - math.pi) / dt or 0
		r.Yaw = yaw
		r.Turn += (clamp(turn, -3, 3) - r.Turn) * min(1, dt * 5)
		local idle = (1 - r.Stride) * (1 - rage) * (1 - fly)

		-- repos : il scanne les alentours, et parfois une pose de puissance (bras écartés, le cœur s'allume)
		r.LookTimer -= dt
		if r.LookTimer <= 0 then
			r.LookTimer = rng:NextNumber(1.8, 4.5)
			r.LookYaw, r.LookTilt = rng:NextNumber(-0.7, 0.7), rng:NextNumber(-0.12, 0.12)
		end
		r.HeadYaw += (r.LookYaw - r.HeadYaw) * min(1, dt * 3)
		r.HeadTilt += (r.LookTilt - r.HeadTilt) * min(1, dt * 3)
		if idle > 0.8 then
			r.PoseTimer -= dt
			if r.PoseTimer <= 0 then r.PoseTimer, r.Flex = rng:NextNumber(10, 18), 0 end
		end
		local flex = 0
		if r.Flex then
			r.Flex += dt
			if r.Flex > 2 then r.Flex = nil else flex = smooth(min(r.Flex, 2 - r.Flex) * 2.5) * idle end
		end
		local roar = max(windup * rage, flex)

		-- saut et atterrissage
		if model:GetAttribute("Jump") then r.JumpTime = (r.JumpTime or 0) + dt else r.JumpTime = nil end
		local crouch = 0
		if r.JumpTime then
			crouch = r.JumpTime < JUMP_CROUCH and (r.JumpTime / JUMP_CROUCH) ^ 0.6 or max(0, 1 - (r.JumpTime - JUMP_CROUCH) / 0.12)
		end
		if r.WasFlying and not flying then r.Land = 0 end
		r.WasFlying = flying
		local squash = 0
		if r.Land then
			r.Land += dt
			if r.Land > 0.6 then r.Land = nil else
				local k = r.Land / 0.6
				squash = sin(min(1, k * 5) * math.pi / 2) * (1 - k) ^ 2
			end
		end
		local bend = max(crouch, squash)
		local breathe = sin(t * 1.4)

		-- TRONC : penché EN AVANT en marche (un peu) et en course (plus), torse bombé pour crier, en avant en vol.
		-- Il descend au moment où le pied se pose (pas lourd) et remonte au milieu du pas ; léger roulis des hanches.
		local stepDip = (1 - abs(sin(phase))) * 0.45 * stride * (1 + 0.5 * run) -- le plus bas à la pose du pied
		local bodyY = 0.08 * breathe * idle - stepDip - bend * 2.4 + sin(t * 2) * 0.3 * fly
		local lean = 0.07 * stride + 0.16 * run + 0.06 * max(0, r.Accel) -- positif = en avant
		local bodyPitch = (lean - 0.2 * roar + 0.3 * bend + 0.45 * fly) + 0.012 * breathe * idle
		local bodyYaw = -sin(phase) * 0.09 * stride -- les épaules tournent à l'inverse des hanches
		local bodyRoll = sin(phase) * 0.035 * stride - r.Turn * 0.05 - r.Turn * 0.1 * fly
		pose(J.Body, CFrame.new(0, bodyY, 0) * A(bodyPitch, bodyYaw, bodyRoll))
		-- tête : stabilisée (elle compense le tronc), scanne au repos, droit devant en course, relevée pour crier
		local headPitch = -bodyPitch * 0.7 + sin(t * 0.9) * 0.04 * idle + 0.22 * roar * -1
		pose(J.Head, A(headPitch, r.HeadYaw * idle - bodyYaw * 0.8 + sin(t * 29) * 0.05 * windup * rage, r.HeadTilt * idle - bodyRoll * 0.5))
		-- œil : il balaie la visière au repos, se fixe au centre et vire au rose en poursuite
		local scan = sin(t * 1.6) * 0.95 * (1 - rage)
		pose(J.Eye, CFrame.new(scan, 0, 0))
		if r.Eye then r.Eye.Color = CYAN:Lerp(ANGRY, rage) end

		-- JAMBES : elles suivent le bassin ; pas alternés, genou plié quand la jambe revient vers l'avant
		for _, side in {{"R", 1}, {"L", -1}} do
			local s = side[2]
			local swing = sin(phase) * s
			local lift = max(0, cos(phase) * s * -1) -- (jambe qui revient)
			local hip = -swing * (0.42 + 0.25 * run) * stride - lift * 0.2 * stride - 0.95 * bend - 0.35 * fly
			local knee = lift * (0.8 + 0.5 * run) * stride + 1.7 * bend + 0.5 * fly + 0.06 * stride
			pose(J["Leg" .. side[1]], CFrame.new(0, bodyY, 0) * A(hip, 0, s * (0.05 * roar + 0.03 * fly)))
			pose(J["Shin" .. side[1]], A(knee, 0, 0))
		end

		-- BRAS : balancés à l'opposé des jambes, l'avant-bras suit avec un peu de retard ; course : coudes pliés ;
		-- cri : bras écartés, poings levés ; vol : bras le long du corps vers l'arrière
		for _, side in {{"R", 1}, {"L", -1}} do
			local s = side[2]
			local swing = sin(phase) * s
			local shoulder = swing * (0.4 + 0.3 * run) * stride + 0.03 * breathe * idle
			local out = 0.06 + 0.02 * breathe * idle + 0.05 * run
			local elbow = -0.18 - (0.25 + 0.9 * run) * stride - max(0, -sin(phase - 0.6) * s) * 0.25 * stride
			shoulder = shoulder * (1 - roar) - 0.6 * roar
			out = out * (1 - roar) + 1.05 * roar
			elbow = elbow * (1 - roar) - 1.5 * roar
			shoulder = shoulder * (1 - fly) + 0.55 * fly
			out = out * (1 - fly) + 0.22 * fly
			elbow = elbow * (1 - fly) - 0.1 * fly
			shoulder += 0.35 * bend
			pose(J["Arm" .. side[1]], A(shoulder, 0, s * out))
			pose(J["Fore" .. side[1]], A(elbow, 0, 0))
		end

		-- RESSORTS : l'antenne fouette à chaque pas et dans les virages, les ailerons vibrent et se couchent en vitesse
		local kick = cos(phase * 2) * 0.12 * stride + r.Accel * 0.35 + bend * 0.4
		local sideKick = r.Turn * 0.25 + sin(phase) * 0.05 * stride
		local prevP, prevR = 0, 0
		for i = 1, 3 do
			local p = spring(r.AntP[i], kick * (1 + i * 0.4) + sin(t * 1.2 + i) * 0.04, dt, 90 - i * 15, 7)
			local q = spring(r.AntR[i], sideKick * (1 + i * 0.4), dt, 90 - i * 15, 7)
			pose(J["Ant" .. i], A(-(p - prevP * 0.5), 0, q - prevR * 0.5)) -- (la pointe traîne vers l'arrière quand il accélère)
			prevP, prevR = p, q
		end
		local finP = spring(r.FinP, 0.25 * min(speed / 40, 1) + r.Accel * 0.3 + 0.35 * fly + bend * 0.2, dt, 70, 6)
		local finR = spring(r.FinR, sin(t * 3) * 0.04 * rage + r.Turn * 0.15, dt, 70, 6)
		pose(J.FinR, A(-finP, 0, -0.1 * roar + finR)) -- (couchés vers l'arrière en vitesse)
		pose(J.FinL, A(-finP, 0, 0.1 * roar + finR))

		-- réacteurs allumés en vol, cœur qui pulse (plus fort en colère)
		for _, e in r.Thrusters do e.Enabled = fly > 0.3 or crouch > 0.6 end
		if r.Core then r.Core.Brightness = (2.2 + 0.6 * sin(t * 4)) * (1 + rage + roar) end
	end
end)
