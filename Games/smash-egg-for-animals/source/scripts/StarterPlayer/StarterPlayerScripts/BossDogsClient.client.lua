-- BossDogsClient : les chiens explosifs du combat contre le Headless (Workspace.BossDogs, BossArenaServer / BossDogBuilder).
--   * animation : trot (pattes en diagonale), le corps rebondit et roule, la queue est un ressort qui fouette, le moignon du cou
--     crache des flammes ; ils sortent du trou noir accroupis ; le Blast Hound a une foulée lourde et lente, le Fuse Pup nerveuse
--   * compte à rebours au-dessus de lui : icône de bombe + secondes restantes (attribut FuseEnd du serveur) ; il passe au jaune
--     puis au rouge, grossit, la mèche clignote et le chien clignote en rouge de plus en plus vite, un bip à chaque seconde
-- (Le serveur décide de tout : poursuite, contact, explosion. Ici ce n'est que l'affichage.)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

local BOMB_ICON = "rbxassetid://91946150079318"
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local rgb = Color3.fromRGB
local sin, cos, abs, max, min, clamp = math.sin, math.cos, math.abs, math.max, math.min, math.clamp
local A = CFrame.Angles
local TAU = math.pi * 2
local function now() return workspace:GetServerTimeNow() end
local function smooth(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function spring(sp, target, dt, k, damp)
	sp.v += ((target - sp.x) * k - sp.v * damp) * dt
	sp.x += sp.v * dt
	return sp.x
end

-- réglages par chien : longueur de foulée, amplitude, couleur de la flamme
local KIND = {
	Small = {Stride = 3.6, Swing = 0.75, Knee = 1.1, Bob = 0.28, Flame = {rgb(255, 230, 255), rgb(255, 90, 220), rgb(120, 30, 200)}, Tail = 1.3},
	Big = {Stride = 6.2, Swing = 0.55, Knee = 0.85, Bob = 0.4, Flame = {rgb(255, 240, 200), rgb(255, 140, 40), rgb(160, 40, 20)}, Tail = 0.6},
}

local function tick(pitch, at)
	local s = Instance.new("Sound")
	s.SoundId = "rbxasset://sounds/electronicpingshort.wav"
	s.Volume, s.PlaybackSpeed = 0.45, pitch
	s.RollOffMinDistance, s.RollOffMaxDistance = 15, 220
	s.Parent = at
	s:Play()
	Debris:AddItem(s, 2)
end

local dogs = {}
local function setup(model)
	if dogs[model] or model:GetAttribute("Rig") ~= "BossDog" then return end
	local J, count, stump, fuseTip = {}, 0, nil, nil
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("DJ") then
			J[d:GetAttribute("DJ")] = {Weld = d, Base = d.C0}
			count += 1
		elseif d:IsA("BasePart") and d:GetAttribute("Stump") then stump = d
		elseif d:IsA("BasePart") and d:GetAttribute("FuseTip") then fuseTip = d end
	end
	if count < (model:GetAttribute("DJoints") or math.huge) or not model.PrimaryPart then return end
	local kind = model:GetAttribute("DogKind") or "Small"
	local cfg = KIND[kind] or KIND.Small
	local root = model.PrimaryPart
	local height = model:GetAttribute("Height") or 5
	local big = kind == "Big"
	-- flammes du cou tranché
	if stump then
		local e = Instance.new("ParticleEmitter")
		e.Texture = "rbxasset://textures/particles/fire_main.dds"
		e.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, cfg.Flame[1]), ColorSequenceKeypoint.new(0.4, cfg.Flame[2]), ColorSequenceKeypoint.new(1, cfg.Flame[3])})
		e.LightEmission, e.LightInfluence = 1, 0
		e.Rate = big and 40 or 28
		e.Lifetime = NumberRange.new(0.3, 0.55)
		e.Speed = NumberRange.new(big and 5 or 3, big and 8 or 5)
		e.EmissionDirection = Enum.NormalId.Top
		e.SpreadAngle = Vector2.new(15, 15)
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, big and 1.4 or 0.8), NumberSequenceKeypoint.new(1, 0)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
		e.RotSpeed, e.Rotation = NumberRange.new(-120, 120), NumberRange.new(0, 360)
		e.Parent = stump
		local l = Instance.new("PointLight")
		l.Color, l.Range, l.Brightness, l.Shadows = cfg.Flame[2], big and 14 or 9, 1.5, false
		l.Parent = stump
	end
	-- étincelles de la mèche
	local sparks
	if fuseTip then
		sparks = Instance.new("ParticleEmitter")
		sparks.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		sparks.Color = ColorSequence.new(rgb(255, 250, 200), rgb(255, 150, 40))
		sparks.LightEmission, sparks.LightInfluence = 1, 0
		sparks.Rate, sparks.Lifetime, sparks.Speed = 14, NumberRange.new(0.25, 0.5), NumberRange.new(2, 5)
		sparks.SpreadAngle = Vector2.new(180, 180)
		sparks.Acceleration = Vector3.new(0, -8, 0)
		sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, big and 0.35 or 0.22), NumberSequenceKeypoint.new(1, 0)})
		sparks.Parent = fuseTip
	end
	-- contour qui clignote en rouge à la fin du compte à rebours
	local glow = Instance.new("Highlight")
	glow.FillColor, glow.OutlineColor = rgb(255, 40, 60), rgb(255, 120, 120)
	glow.FillTransparency, glow.OutlineTransparency = 1, 1
	glow.DepthMode = Enum.HighlightDepthMode.Occluded
	glow.Parent = model
	-- compte à rebours : bombe + secondes (taille fixe à l'écran : lisible de loin)
	local bb = Instance.new("BillboardGui")
	bb.Name = "Countdown"
	bb.Size = UDim2.fromOffset(big and 150 or 124, big and 64 or 54)
	bb.StudsOffsetWorldSpace = Vector3.new(0, height - (root.Position.Y - model:GetPivot().Position.Y) + (big and 3 or 2.2), 0)
	bb.LightInfluence = 0
	bb.MaxDistance = 600
	bb.Parent = root
	local scale = Instance.new("UIScale")
	scale.Parent = bb
	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.fromScale(1, 1)
	frame.Parent = bb
	local icon = Instance.new("ImageLabel")
	icon.BackgroundTransparency = 1
	icon.Image = BOMB_ICON
	icon.Size = UDim2.fromScale(0.42, 1)
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Parent = frame
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromScale(0.42, 0)
	label.Size = UDim2.fromScale(0.58, 1)
	label.FontFace = FONT
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = "15"
	label.Parent = frame
	local grad = Instance.new("UIGradient")
	grad.Rotation = 90
	grad.Parent = label
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = Color3.new(0, 0, 0)
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Parent = label
	dogs[model] = {J = J, cfg = cfg, root = root, big = big, phase = math.random(), stride = 0, label = label, grad = grad, scale = scale,
		icon = icon, glow = glow, fuseTip = fuseTip, sparks = sparks, lastSec = nil, yaw = nil, turn = 0, last = root.Position,
		tail = {{x = 0, v = 0}, {x = 0, v = 0}, {x = 0, v = 0}}, tailR = {{x = 0, v = 0}, {x = 0, v = 0}, {x = 0, v = 0}}}
	model.Destroying:Connect(function() dogs[model] = nil end)
end
task.spawn(function()
	while true do
		local folder = workspace:FindFirstChild("BossDogs")
		if folder then for _, m in folder:GetChildren() do if not dogs[m] then setup(m) end end end
		task.wait(0.25)
	end
end)

local function pose(joint, cf) if joint then joint.Weld.C0 = joint.Base * cf end end
local WHITE, YELLOW, RED = rgb(255, 255, 255), rgb(255, 220, 70), rgb(255, 50, 60)

RunService.RenderStepped:Connect(function(dt)
	dt = clamp(dt, 1 / 240, 0.05)
	local t = now()
	for model, d in dogs do
		local root = d.root
		if not root.Parent then continue end
		local J, cfg = d.J, d.cfg
		local pos = root.Position
		local vel = (pos - d.last) / dt
		d.last = pos
		local speed = Vector3.new(vel.X, 0, vel.Z).Magnitude
		d.stride += (clamp(speed / 12, 0, 1) - d.stride) * min(1, dt * 8)
		d.phase = (d.phase + dt * speed / cfg.Stride) % 1
		local ph = d.phase * TAU
		local _, yaw = root.CFrame:ToOrientation()
		local turn = d.yaw and ((yaw - d.yaw + math.pi) % TAU - math.pi) / dt or 0
		d.yaw = yaw
		d.turn += (clamp(turn, -4, 4) - d.turn) * min(1, dt * 6)
		local born = model:GetAttribute("Born") or t
		local emerge = 1 - smooth((t - born) / 0.7) -- il sort du trou noir accroupi
		local fuseEnd = model:GetAttribute("FuseEnd") or (t + 15)
		local left = max(0, fuseEnd - t)
		local panic = 1 - smooth(left / 5) -- les 5 dernières secondes : il s'affole
		local stride = d.stride

		-- corps : rebond à chaque foulée (deux par cycle au trot), roulis, il plonge le poitrail en avant, il penche dans les virages
		local bob = abs(sin(ph)) * cfg.Bob * stride - emerge * (d.big and 1.4 or 0.9)
		local pitch = 0.08 * stride + sin(ph * 2) * 0.04 * stride + 0.25 * emerge -- (positif = vers l'avant : tronc horizontal, axe Z)
		local roll = sin(ph) * 0.05 * stride - d.turn * 0.06
		local shiver = panic * sin(t * 60) * 0.03
		pose(J.Body, CFrame.new(0, bob, 0) * A(pitch + shiver, sin(ph) * 0.05 * stride, roll))

		-- pattes : trot (avant gauche avec arrière droite), le genou plie quand la patte revient vers l'avant
		for _, leg in {{"FL", 0, true}, {"BR", 0, false}, {"FR", 0.5, true}, {"BL", 0.5, false}} do
			local f = (d.phase + leg[2]) % 1
			local swing = sin(f * TAU)
			local lift = max(0, cos(f * TAU))
			local upper = -swing * cfg.Swing * stride + emerge * (leg[3] and -0.5 or 0.7)
			local lower = lift * cfg.Knee * stride * (leg[3] and 1 or -0.8) + emerge * (leg[3] and 0.9 or -1.1)
			pose(J["Leg" .. leg[1]], CFrame.new(0, bob * 0.6, 0) * A(upper, 0, 0))
			pose(J["Low" .. leg[1]], A(lower, 0, 0))
		end

		-- queue : ressorts qui traînent derrière les mouvements (fouette au trot, s'agite en panique)
		local wag = sin(t * (8 + 14 * panic)) * (0.25 + 0.4 * panic) * cfg.Tail
		local prev, prevR = 0, 0
		for i = 1, 3 do
			local joint = J["Tail" .. i]
			if joint then
				local p = spring(d.tail[i], -sin(ph * 2 - i * 0.6) * 0.2 * stride - 0.15 * stride + 0.1 * emerge, dt, 120 - i * 25, 9)
				local q = spring(d.tailR[i], wag * (1 + i * 0.3) - d.turn * 0.12, dt, 120 - i * 25, 9)
				pose(joint, A(p - prev * 0.4, q - prevR * 0.4, 0))
				prev, prevR = p, q
			end
		end

		-- compte à rebours
		local sec = math.ceil(left)
		d.label.Text = tostring(sec)
		local color = left > 10 and WHITE or (left > 5 and YELLOW or RED)
		d.grad.Color = ColorSequence.new(color:Lerp(WHITE, 0.45), color)
		local beat = left <= 5 and (1 + 0.18 * max(0, sin(t * (8 + 10 * panic)))) or 1
		d.scale.Scale = (1 + 0.25 * panic) * beat
		d.icon.Rotation = sin(t * (6 + 20 * panic)) * (6 + 10 * panic)
		if sec ~= d.lastSec then
			d.lastSec = sec
			if sec <= 15 and sec > 0 then tick(sec <= 5 and 1.6 or 1.1, root) end
		end
		-- clignote en rouge, de plus en plus vite
		local flash = left <= 5 and (sin(t * (6 + 22 * panic)) > 0 and 1 or 0) or 0
		d.glow.FillTransparency = 1 - 0.55 * flash
		d.glow.OutlineTransparency = left <= 5 and 0.2 or 1
		if d.fuseTip then d.fuseTip.Transparency = (sin(t * (10 + 30 * panic)) > 0) and 0 or 0.6 end
		if d.sparks then d.sparks.Rate = 14 + 60 * panic end
	end
end)
