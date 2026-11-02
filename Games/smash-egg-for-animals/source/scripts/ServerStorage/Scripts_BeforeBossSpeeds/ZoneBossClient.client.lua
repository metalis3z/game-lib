-- Gardiens des zones : animation complète du squelette (marche, repos, intimidation, charge) et message rouge à l'écran.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local TAG = "ZoneBoss"
local player = Players.LocalPlayer
local rad, sin, cos, abs, max, min, clamp = math.rad, math.sin, math.cos, math.abs, math.max, math.min, math.clamp
local A = CFrame.Angles
local TAU = math.pi * 2
local JUMP_CROUCH = 0.4     -- durée accroupi avant le saut d'envol (même valeur que le serveur)
local WINDUP = 0.9         -- durée de l'intimidation avant la charge (même valeur que le serveur)
local STRIDE_LENGTH = 11   -- studs parcourus pendant un cycle de deux pas : les pieds ne glissent pas
local rng = Random.new()

---------------------------------------------------------------- animation
local bosses = {}
local function setup(model)
	if bosses[model] or model:GetAttribute("Rig") then return end -- Rig : squelette à part (Pumpking -> PumpkingClient)
	local J, legs, count = {}, {}, 0
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("Anim") then
			count += 1
			local entry = {Weld = d, Base = d.C0}
			local anim, side = d:GetAttribute("Anim"), d:GetAttribute("Side")
			if anim == "Hip" or anim == "Knee" or anim == "Foot" then
				-- pattes : une paire (bipède) ou deux (quadrupède : Pair = 2 pour les pattes avant)
				local pair = d:GetAttribute("Pair") or 1
				local key = pair .. ":" .. side
				legs[key] = legs[key] or {Side = side, Pair = pair, Phase = (side == 1 and 0 or math.pi) + (pair == 2 and math.pi or 0)}
				legs[key][anim] = entry
			elseif side then
				J[d:GetAttribute("Anim")] = J[d:GetAttribute("Anim")] or {}
				J[d:GetAttribute("Anim")][side] = entry
			else
				J[d:GetAttribute("Anim")] = entry
			end
		end
	end
	if count < (model:GetAttribute("Joints") or math.huge) then return end -- pas encore entièrement chargé
	J.Legs = {}
	for _, leg in legs do table.insert(J.Legs, leg) end
	table.sort(J.Legs, function(a, b) if a.Pair ~= b.Pair then return a.Pair < b.Pair end return a.Side > b.Side end)
	-- pièces qui changent quand il s'énerve : pupilles rouges lumineuses, plumage qui rougit
	local pupils, blocks = {}, {}
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") and d.Name == "Pupil" then
			table.insert(pupils, d)
		elseif d:IsA("BasePart") and d.Name == "Block" and d.Material ~= Enum.Material.Neon and d.Transparency == 0 then
			table.insert(blocks, {Part = d, Color = d.Color})
		end
	end
	bosses[model] = {
		J = J, Pupils = pupils, Blocks = blocks, Angry = false,
		Lean = model:GetAttribute("Lean") or 1,                  -- à quel point le corps bascule (faible pour les quadrupèdes)
		FlapGround = model:GetAttribute("FlapGround") or 13,     -- vitesse des battements au sol / en vol
		FlapFly = model:GetAttribute("FlapFly") or 5,
		PupilColor = pupils[1] and pupils[1].Color or Color3.fromRGB(26, 22, 28),
		PupilMaterial = pupils[1] and pupils[1].Material or Enum.Material.SmoothPlastic,
		Phase = 0, Charge = 0, Windup = 0, Stride = 0, Turn = 0, Yaw = nil, Fly = 0, Flap = 0, JumpTime = nil,
		LookTimer = 0, LookYaw = 0, LookTilt = 0, HeadYaw = 0, HeadTilt = 0,
		PeckTimer = rng:NextNumber(3, 6), Peck = nil, RuffleTimer = rng:NextNumber(4, 8), Ruffle = nil,
	}
	model.Destroying:Connect(function() bosses[model] = nil end)
end
-- le modèle arrive morceau par morceau côté client : on réessaie tant que le squelette n'est pas complet
task.spawn(function()
	while true do
		for _, m in CollectionService:GetTagged(TAG) do
			if not bosses[m] and m:IsDescendantOf(workspace) then setup(m) end
		end
		task.wait(0.5)
	end
end)

local function pose(joint, cf)
	if joint then joint.Weld.C0 = joint.Base * cf end
end

RunService.RenderStepped:Connect(function(dt)
	dt = min(dt, 0.1)
	local t = os.clock()
	for model, b in bosses do
		local root = model.PrimaryPart
		if not root then continue end
		local J = b.J
		local velocity = root.AssemblyLinearVelocity
		local speed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
		local chasing = model:GetAttribute("Chasing") == true

		-- états fondus : charge (0..1), intimidation (1 -> 0), foulée (0..1), virage
		if chasing and not b.Angry then b.Windup = WINDUP end
		b.Windup = max(0, b.Windup - dt)
		b.Charge += ((chasing and 1 or 0) - b.Charge) * min(1, dt * 6)
		local rage = b.Charge
		local w = chasing and (b.Windup / WINDUP) or 0
		w = w * w * (3 - 2 * w)                    -- intimidation, adoucie
		local c = rage * (1 - w)                   -- pose de charge
		b.Stride += (clamp(speed / 12, 0, 1) - b.Stride) * min(1, dt * 8)
		-- vol : fondu vers la pose de vol (pattes repliées vers l'arrière, grands battements lents et puissants)
		b.Fly += ((model:GetAttribute("Flying") and 1 or 0) - b.Fly) * min(1, dt * 4)
		local fly = b.Fly
		local stride = b.Stride * (1 - fly)
		local climb = clamp(velocity.Y / 20, -1, 1)
		b.Phase = (b.Phase + dt * min(speed, 100) / STRIDE_LENGTH * TAU) % TAU -- les pattes s'emballent quand il charge vite
		local phase = b.Phase
		local _, yaw = root.CFrame:ToOrientation()
		local turn = b.Yaw and ((yaw - b.Yaw + math.pi) % TAU - math.pi) / dt or 0
		b.Yaw = yaw
		b.Turn += (clamp(turn, -3, 3) - b.Turn) * min(1, dt * 5)
		local idle = (1 - stride) * (1 - rage)

		-- au repos : regarde autour de lui par à-coups, picore, s'ébroue
		b.LookTimer -= dt
		if b.LookTimer <= 0 then
			b.LookTimer = rng:NextNumber(0.9, 2.8)
			b.LookYaw, b.LookTilt = rad(rng:NextNumber(-55, 55)), rad(rng:NextNumber(-14, 14))
		end
		b.HeadYaw += (b.LookYaw - b.HeadYaw) * min(1, dt * 16)   -- mouvement vif, comme un vrai poulet
		b.HeadTilt += (b.LookTilt - b.HeadTilt) * min(1, dt * 16)
		if idle > 0.8 then
			b.PeckTimer -= dt
			b.RuffleTimer -= dt
			if b.PeckTimer <= 0 then b.PeckTimer, b.Peck = rng:NextNumber(4, 8), 0 end
			if b.RuffleTimer <= 0 then b.RuffleTimer, b.Ruffle = rng:NextNumber(6, 11), 0 end
		end
		local peck = 0
		if b.Peck then
			b.Peck += dt
			if b.Peck > 1.2 then b.Peck = nil else peck = abs(sin(b.Peck / 0.4 * math.pi)) ^ 0.7 * idle end
		end
		local ruffle = 0
		if b.Ruffle then
			b.Ruffle += dt
			if b.Ruffle > 0.7 then b.Ruffle = nil else ruffle = sin(b.Ruffle / 0.7 * math.pi) * idle end
		end

		-- corps : rebond à chaque pas, balancement vers la patte d'appui, penché dans les virages et en charge
		local breathe = sin(t * 1.7) * idle
		local bodyPitch = (rad(5) * stride + rad(27) * c - rad(17) * w * rage + rad(1.5) * breathe + rad(14) * peck) * b.Lean
		local bodyRoll = sin(phase) * rad(5) * stride * (1 + c * 0.6) - b.Turn * rad(4)
		local bodyYaw = sin(phase) * rad(6) * stride
		local bodyY = -abs(sin(phase)) * 0.45 * stride + 0.12 * breathe + 0.5 * w * rage
		-- saut d'envol : il s'accroupit (corps bas, genoux pliés, ailes levées), puis se détend d'un coup
		if model:GetAttribute("Jump") then
			b.JumpTime = (b.JumpTime or 0) + dt
		else
			b.JumpTime = nil
		end
		local crouch = 0
		if b.JumpTime then
			if b.JumpTime < JUMP_CROUCH then
				crouch = (b.JumpTime / JUMP_CROUCH) ^ 0.6
				b.Flap = math.pi * 0.5        -- ailes en haut, prêtes pour le premier grand coup d'aile
			else
				crouch = max(0, 1 - (b.JumpTime - JUMP_CROUCH) / 0.12)
			end
		end
		b.Flap += dt * (b.FlapGround + (b.FlapFly - b.FlapGround) * fly) * (crouch > 0.5 and 0 or 1) -- battements lents : environ 2 par seconde au sol, moins d'un par seconde en vol
		local flap = b.Flap
		bodyY -= 1.7 * crouch
		bodyPitch += rad(16) * crouch
		bodyPitch += (rad(-10) * c - rad(16) * climb) * fly    -- se cabre en montant, pique en descendant
		bodyRoll -= b.Turn * rad(9) * fly                       -- s'incline dans les virages
		bodyY -= sin(flap) * 0.9 * fly                          -- le corps monte à chaque coup d'aile
		pose(J.Body, CFrame.new(0, bodyY, 0) * A(bodyPitch, bodyYaw, bodyRoll))

		-- cou et tête : la tête avance puis recule à chaque pas et reste droite pendant que le corps bouge
		local neckPitch = rad(32) * c - rad(22) * w * rage + sin(phase * 2 + 0.6) * rad(9) * stride * (1 - c) + rad(62) * peck
		pose(J.Neck, A(neckPitch, b.HeadYaw * 0.4 * idle - bodyYaw * 0.6, 0))
		local headPitch = -(bodyPitch + neckPitch) * 0.85 + rad(8) * c + rad(38) * peck + sin(phase * 2 - 0.4) * rad(4) * stride
		local headYaw = b.HeadYaw * 0.6 * idle + sin(t * 23) * rad(9) * rage * (0.5 + w)
		local headRoll = b.HeadTilt * idle - bodyRoll * 0.8 + sin(t * 17) * rad(5) * rage
		pose(J.Head, A(headPitch, headYaw, headRoll))
		-- bec qui s'ouvre pour crier, crête et barbillon qui ballottent
		pose(J.Jaw, A(rad(5 + 22 * abs(sin(t * 9))) * c + rad(34) * w * rage + rad(10) * peck, 0, 0))
		pose(J.Comb, A(0, 0, sin(phase * 2 - 1) * rad(9) * stride + sin(t * 12) * rad(15) * rage + b.HeadTilt * 0.5 * idle))
		pose(J.Wattle, A(sin(phase * 2 - 1.4) * rad(14) * stride + sin(t * 13) * rad(20) * rage + rad(-20) * peck, 0, sin(t * 11) * rad(8) * rage))

		-- ailes : repliées et qui rebondissent en marchant ; grandes ouvertes en intimidation ; battements avec le bout en retard en charge
		local wc = max(c, fly)
		for _, side in {1, -1} do
			local spread = rad(55) * crouch * (1 - wc) + rad(8) * stride + rad(72) * wc + rad(92) * w * rage + rad(20) * ruffle
			local beat = sin(flap) * rad(30 + 30 * fly) * wc + sin(t * 34 + side) * rad(11) * ruffle + sin(phase * 2 + 1) * rad(4) * stride + sin(t * 20) * rad(6) * w * rage
			pose(J.Wing and J.Wing[side], A(-rad(14) * c + cos(flap) * rad(16) * fly, side * (rad(10) * c + rad(18) * w * rage), side * (spread + beat)))
			local tipLag = sin(flap - 1.1) * rad(40 + 12 * fly) * wc + sin(t * 34 + side - 1) * rad(14) * ruffle
			pose(J.WingTip and J.WingTip[side], A(0, 0, side * (rad(24) * wc * (1 - fly * 0.6) + rad(30) * w * rage + tipLag)))
		end

		-- queue : remue à chaque pas, se dresse en éventail quand il s'énerve
		pose(J.Tail1, A(rad(20) * rage * (1 - fly) - rad(18) * fly - sin(flap) * rad(8) * fly + cos(phase * 2) * rad(6) * stride + rad(-10) * peck + rad(8) * ruffle, sin(phase) * rad(10) * stride + sin(t * 15) * rad(7) * rage + sin(t * 30) * rad(8) * ruffle, 0))
		pose(J.Tail2, A(rad(14) * rage + cos(phase * 2 - 0.9) * rad(8) * stride, sin(phase - 0.8) * rad(10) * stride + sin(t * 15 - 0.8) * rad(8) * rage, 0))

		-- pattes : vrai pas (la cuisse avance, le genou plie pour lever le pied, le pied reste à plat puis se pose) ; grandes foulées en charge
		local swingAmount = rad(26 + 26 * rage) * stride
		local kneeAmount = rad(50 + 34 * rage) * stride
		for index, leg in J.Legs do
			local side = leg.Side
			local p = phase + leg.Phase
			local lift = max(0, cos(p))               -- le pied est en l'air pendant qu'il revient vers l'avant
			local hip = -swingAmount * sin(p)
			local knee = kneeAmount * lift ^ 1.3
			local toes = rad(26) * lift * stride       -- orteils qui pendent quand le pied est levé
			if index == 1 and w > 0 then                -- intimidation : gratte le sol d'une patte, comme un taureau
				hip += (rad(-18) + sin(t * 15) * rad(24)) * w * rage
				knee += rad(42) * w * rage * (0.6 + 0.4 * sin(t * 15 + 1))
			end
			hip -= rad(40) * crouch
			knee += rad(80) * crouch
			-- en vol : pattes repliées vers l'arrière, qui pendent et se balancent un peu
			hip = hip * (1 - fly) + (rad(52) + sin(flap + side) * rad(6)) * fly
			knee = knee * (1 - fly) + rad(28) * fly
			pose(leg.Hip, A(hip - bodyPitch * 0.25 * (1 - fly), 0, 0))
			pose(leg.Knee, A(knee, 0, 0))
			pose(leg.Foot, A((-(hip + knee) + toes) * (1 - fly) + rad(35) * fly, 0, 0))
		end

		-- colère : pupilles rouges, plumage qui rougit avec une pulsation
		if chasing ~= b.Angry then
			b.Angry = chasing
			for _, pupil in b.Pupils do
				pupil.Color = chasing and Color3.fromRGB(255, 20, 20) or b.PupilColor
				pupil.Material = chasing and Enum.Material.Neon or b.PupilMaterial
			end
		end
		if rage > 0.01 or b.Tinted then
			local amount = rage * (0.3 + 0.12 * sin(t * 12))
			for _, block in b.Blocks do block.Part.Color = block.Color:Lerp(Color3.fromRGB(255, 70, 60), amount) end
			b.Tinted = rage > 0.01
		end
	end
end)

---------------------------------------------------------------- message rouge
local gui = Instance.new("ScreenGui")
gui.Name = "BossAlertGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 40
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")
local label = Instance.new("TextLabel")
label.Name = "Alert"
label.BackgroundTransparency = 1
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.fromScale(0.5, 0.4) -- sous le bandeau de zone
label.Size = UDim2.new(0.7, 0, 0, 64)
label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
label.TextScaled = true
label.TextColor3 = Color3.fromRGB(255, 50, 50)
label.Text = ""
label.Visible = false
local stroke = Instance.new("UIStroke")
stroke.Thickness = 5
stroke.Parent = label
local scale = Instance.new("UIScale")
scale.Parent = label
label.Parent = gui
local flash = Instance.new("Frame")
flash.Name = "Flash"
flash.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
flash.BackgroundTransparency = 1
flash.BorderSizePixel = 0
flash.Size = UDim2.fromScale(1, 1)
flash.Parent = gui

local shown = 0
ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("BossAlert").OnClientEvent:Connect(function(text, hit)
	shown += 1
	local id = shown
	label.Text = text
	label.Visible = true
	scale.Scale = 0.4
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	if hit then -- éclair rouge sur tout l'écran
		flash.BackgroundTransparency = 0.45
		TweenService:Create(flash, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()
	end
	for i = 1, 10 do -- tremblement
		if shown ~= id then return end
		label.Rotation = (i % 2 == 0 and 1 or -1) * (10 - i) * 0.5
		task.wait(0.04)
	end
	label.Rotation = 0
	task.wait(hit and 3.5 or 2.5)
	if shown == id then label.Visible = false end
end)
