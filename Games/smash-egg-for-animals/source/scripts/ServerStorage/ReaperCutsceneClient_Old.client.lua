-- Cinématique "The Hollow Reaper" (lancée par ReaperCutsceneServer). Tout est joué ici, côté client :
-- décor de forêt construit loin de la carte, 3 avatars animés (CutscenePoses), Faucheuse géante animée par ses propres "os",
-- katana + fourreau, caméras, effets, sons, sous-titres. À la fin, tout est supprimé et l'éclairage du jeu est remis.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local folder = ReplicatedStorage:WaitForChild("ReaperCutscene")
local assets = ReplicatedStorage:WaitForChild("CutsceneAssets")
local Poses = require(assets:WaitForChild("CutscenePoses"))

local MUSIC_CALM, MUSIC_FIGHT = 1848159364, 1838626086
local ORIGIN = Vector3.new(-4000, 700, 9000) -- le décor est construit ici, loin de la carte
local rad, sin, cos, clamp, exp = math.rad, math.sin, math.cos, math.clamp, math.exp
local rgb = Color3.fromRGB
local rng = Random.new(42)
local playing = false
local scene
local savedLighting, hiddenAtmospheres, hiddenGuis, effects = {}, {}, {}, {}

local function V(x, y, z) return ORIGIN + Vector3.new(x, y, z) end
local function A(v) return CFrame.Angles(rad(v[1] or 0), rad(v[2] or 0), rad(v[3] or 0)) end
local function ease(u) return u * u * (3 - 2 * u) end
local function outQuad(u) return 1 - (1 - u) ^ 2 end
local function P(props)
	local p = Instance.new(props.Class or "Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.TopSurface, p.BottomSurface, p.Material = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth, Enum.Material.SmoothPlastic
	for k, v in props do
		if k ~= "Class" and k ~= "Parent" then p[k] = v end
	end
	p.Parent = props.Parent or scene
	return p
end
local function snd(id, volume, speed, looped)
	local s
	if type(id) == "string" and assets:FindFirstChild(id) then
		s = assets[id]:Clone()
	else
		s = Instance.new("Sound")
		s.SoundId = type(id) == "number" and ("rbxassetid://" .. id) or id
	end
	s.Volume, s.PlaybackSpeed, s.Looped = volume or 0.6, speed or 1, looped == true
	s.Parent = SoundService
	s:Play()
	if not looped then Debris:AddItem(s, 12) end
	return s
end

---------------------------------------------------------------- état de la scène
local tracks, actors = {}, {}
local camFn, camStart, shakeAmp = nil, 0, 0
local reaper, fireLight, gui, bars, fade, flash, subtitle, titleCard, blur
local function now() return os.clock() end
local function track(duration, fn) table.insert(tracks, {s = now(), d = duration, fn = fn}) end
local function setCam(fn) camFn, camStart = fn, now() end
local function hold(duration)
	if duration > 1 then duration *= 0.72 end -- scène plus nerveuse (moins d'1 min 30 au total)
	local finish = now() + duration
	while now() < finish and playing do RunService.RenderStepped:Wait() end
end
local function shake(amount) shakeAmp = math.max(shakeAmp, amount) end
local function look(from, to, fov) return CFrame.lookAt(from, to), fov end

local function say(who, text, duration, color)
	subtitle.Text = who and ('<font color="#' .. (color or "FFD84A") .. '">' .. who .. '</font>  ' .. text) or text
	subtitle.Visible = true
	local id = now()
	subtitle:SetAttribute("Id", id)
	task.delay(duration or 3, function() if subtitle:GetAttribute("Id") == id then subtitle.Visible = false end end)
end
local function fadeTo(alpha, t) TweenService:Create(fade, TweenInfo.new(t or 0.6), {BackgroundTransparency = alpha}):Play() end
local function whiteFlash(t)
	flash.BackgroundTransparency = 0
	TweenService:Create(flash, TweenInfo.new(t or 0.5), {BackgroundTransparency = 1}):Play()
end

local function speedLines(duration, strength)
	local finish = now() + duration
	task.spawn(function()
		while now() < finish and playing and gui and gui.Parent do
			for _ = 1, strength or 3 do
				local a = rng:NextNumber(0, math.pi * 2)
				local r0 = rng:NextNumber(0.26, 0.42)
				local line = Instance.new("Frame")
				line.AnchorPoint = Vector2.new(0.5, 0.5)
				line.BorderSizePixel = 0
				line.BackgroundColor3 = Color3.new(1, 1, 1)
				line.BackgroundTransparency = 0.3
				line.Rotation = math.deg(a)
				line.Position = UDim2.fromScale(0.5 + cos(a) * r0, 0.5 + sin(a) * r0 * 1.5)
				line.Size = UDim2.new(rng:NextNumber(0.05, 0.15), 0, 0, rng:NextInteger(1, 3))
				line.ZIndex = 2
				line.Parent = gui
				TweenService:Create(line, TweenInfo.new(0.2), {Position = UDim2.fromScale(0.5 + cos(a) * (r0 + 0.3), 0.5 + sin(a) * (r0 + 0.3) * 1.5), BackgroundTransparency = 1}):Play()
				Debris:AddItem(line, 0.22)
			end
			task.wait(0.03)
		end
	end)
end

---------------------------------------------------------------- effets
local function burst(position, texture, count, color, size, speed, life)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Texture = texture
	e.Rate = 0
	e.Color = ColorSequence.new(color, color)
	e.Lifetime = NumberRange.new(life * 0.6, life)
	e.Speed = NumberRange.new(speed * 0.4, speed)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 3
	e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-120, 120)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size), NumberSequenceKeypoint.new(1, size * (texture:find("smoke") and 2.2 or 0))})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, texture:find("smoke") and 0.45 or 0), NumberSequenceKeypoint.new(1, 1)})
	e.LightEmission = texture:find("smoke") and 0 or 1
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, life + 0.5)
end
local SPARK, SMOKE = "rbxasset://textures/particles/sparkles_main.dds", "rbxasset://textures/particles/smoke_main.dds"
local function sparks(position, count)
	burst(position, SPARK, count or 24, rgb(255, 225, 150), 0.7, 34, 0.5)
	local glow = P({Shape = Enum.PartType.Ball, Material = Enum.Material.Neon, Color = rgb(255, 245, 210), Size = Vector3.one * 0.6, Position = position})
	TweenService:Create(glow, TweenInfo.new(0.18), {Size = Vector3.one * 4.5, Transparency = 1}):Play()
	Debris:AddItem(glow, 0.25)
end
local function dust(position, size, count) burst(position, SMOKE, count or 12, rgb(120, 112, 100), size or 3, 14, 2.2) end
local function ring(position, radius, color, t)
	local r = P({Shape = Enum.PartType.Cylinder, Material = Enum.Material.Neon, Color = color, Transparency = 0.7, Size = Vector3.new(0.3, 2, 2),
		CFrame = CFrame.new(position) * CFrame.Angles(0, 0, rad(90))})
	TweenService:Create(r, TweenInfo.new(t or 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.3, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(r, (t or 0.7) + 0.1)
end
local function slashArc(cf, radius, color) -- croissant lumineux : la lame fend l'air
	local tilt = cf * CFrame.Angles(0, 0, rad(rng:NextNumber(-75, 75)))
	for i = -5, 5 do
		local a = rad(i * 11)
		local w = (1 - math.abs(i) / 6) * 0.95 + 0.1
		local p = P({Material = Enum.Material.Neon, Color = color or rgb(210, 240, 255), Transparency = 0.05, Size = Vector3.new(radius * 0.22, w, 0.12), CFrame = tilt * CFrame.Angles(0, a, 0) * CFrame.new(0, 0, -radius)})
		TweenService:Create(p, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = tilt * CFrame.Angles(0, a * 1.2, 0) * CFrame.new(0, 0, -radius * 1.7), Transparency = 1, Size = Vector3.new(radius * 0.36, w * 0.25, 0.1)}):Play()
		Debris:AddItem(p, 0.26)
	end
end
local function ghost(a) -- image fantôme laissée derrière un déplacement éclair
	local g = P({Material = Enum.Material.Neon, Color = rgb(150, 215, 255), Transparency = 0.45, Size = Vector3.new(2, 4.6, 1), CFrame = a.cf})
	TweenService:Create(g, TweenInfo.new(0.28), {Transparency = 1, Size = Vector3.new(0.4, 4.2, 0.4)}):Play()
	Debris:AddItem(g, 0.3)
end

---------------------------------------------------------------- acteurs
local function yawTo(from, to)
	local d = to - from
	return math.deg(math.atan2(-d.X, -d.Z))
end
local function place(a, x, z, yaw, y) a.cf = CFrame.new(V(x, y or a.standY, z)) * CFrame.Angles(0, rad(yaw or 0), 0) end
local function moveTo(a, x, z, duration, yaw, y, easing)
	local from
	local to = CFrame.new(V(x, y or a.standY, z)) * CFrame.Angles(0, rad(yaw or 0), 0)
	track(duration, function(u)
		from = from or a.cf
		a.cf = from:Lerp(to, (easing or ease)(u))
	end)
end
local function walkTo(a, x, z, duration, amp, forceRun)
	-- vraies animations Roblox de marche / course quand l'avatar le permet ; sinon marche calculée, sans roulis
	local from, to = a.cf.Position, V(x, a.standY, z)
	local dist = (to - from).Magnitude
	local running = forceRun or dist / math.max(duration, 0.01) > 9
	duration = math.min(duration, dist / (running and 17 or 6.5)) -- jamais plus lent qu'une vraie marche (6,5 studs/s) ou une vraie course (17 studs/s)
	local speed = dist / math.max(duration, 0.01)
	if dist < 1.6 then -- trop près pour marcher : un simple pas de côté en se tournant
		moveTo(a, x, z, 0.35, yawTo(from, to))
		return
	end
	local _, yaw0 = a.cf:ToOrientation()
	local turnBy = ((rad(yawTo(from, to)) - yaw0 + math.pi) % (2 * math.pi)) - math.pi
	local animation = a.tracks and a.tracks[running and "Run" or "Walk"]
	if animation then
		Poses.set(a, {}, true)
		a.animating = true -- pendant la marche, c'est l'animation Roblox qui bouge les articulations
		animation:Play(0.15)
		animation:AdjustSpeed(speed / (running and 15 or 8.5))
	end
	if running then speedLines(duration, 1) end -- course : il fonce penché en avant, poussière sous les pieds
	local puff = 0
	track(duration, function(u, dt)
		local e = u - 0.4 * sin(2 * math.pi * u) / (2 * math.pi)
		local pace = (1 - 0.4 * cos(2 * math.pi * u)) / 1.4
		local phase = e * dist / (running and 7 or 4.6) * math.pi * 2
		local bounce = animation and 0 or (0.5 - 0.5 * cos(phase * 2)) * (running and 0.22 or 0.07) * pace
		a.cf = CFrame.new(from:Lerp(to, e) + Vector3.new(0, bounce, 0))
			* CFrame.Angles(0, yaw0 + turnBy * ease(clamp(u / 0.2, 0, 1)), 0) * CFrame.Angles(rad((running and -20 or -2) * pace), 0, 0)
		if running then
			puff += dt
			if puff > 0.09 then puff = 0 dust(a.cf.Position - Vector3.new(0, a.standY - 0.3, 0), 1.3, 2) end
		end
		if u >= 1 then
			if animation then animation:Stop(0.15) a.animating = false else Poses.set(a, {}) end
		elseif not animation then
			if running and Poses.run then Poses.set(a, Poses.run(phase, clamp(pace * 1.2, 0.5, 1.05))) else Poses.set(a, Poses.walk(phase, (amp or 1) * clamp(pace * 1.25, 0.4, 1.1))) end
		end
	end)
end
local function liven(a, dt)
	local t = now() + (a.seed or 0)
	local yaw, pitch = 0, 0
	local target = a.look
	if type(target) == "function" then target = target() end
	local torso = a.rig:FindFirstChild("UpperTorso")
	if target and torso then
		local l = torso.CFrame:PointToObjectSpace(target)
		yaw = clamp(math.atan2(-l.X, -l.Z), -1.2, 1.2)
		pitch = clamp(math.atan2(l.Y - 1, math.sqrt(l.X * l.X + l.Z * l.Z)), -0.6, 0.75)
	end
	local k = 1 - exp(-6 * dt)
	a.headYaw = (a.headYaw or 0) + (yaw - (a.headYaw or 0)) * k
	a.headPitch = (a.headPitch or 0) + (pitch - (a.headPitch or 0)) * k
	local function apply(name, extra)
		local j = a.joints[name]
		if not j then return end
		if j.constraint then j.motor.Transform = j.cur * extra else j.motor.C0 = j.base * j.cur * extra end
	end
	local breath = sin(t * 1.9)
	apply("Neck", CFrame.Angles(a.headPitch + sin(t * 1.3) * 0.025, a.headYaw * 0.75, sin(t * 0.9) * 0.02))
	apply("Waist", CFrame.Angles(breath * 0.025, a.headYaw * 0.25, sin(t * 0.7) * 0.014))
	apply("RightShoulder", CFrame.Angles(breath * 0.03, 0, 0.02 + breath * 0.015))
	apply("LeftShoulder", CFrame.Angles(sin(t * 1.9 + 0.6) * 0.03, 0, -0.02 - breath * 0.015))
	apply("RightElbow", CFrame.Angles(sin(t * 1.1 + 2) * 0.03, 0, 0))
	apply("LeftElbow", CFrame.Angles(sin(t * 1.2 + 4) * 0.03, 0, 0))
end
local function headOf(a) return a.rig.Head.Position end

local SIT = {RightHip = {88, 0, 6}, LeftHip = {88, 0, -6}, RightKnee = {-88}, LeftKnee = {-88}, RightShoulder = {32, 0, 8}, LeftShoulder = {32, 0, -8}, RightElbow = {48}, LeftElbow = {48}, Waist = {-10}}
local SIT_TALK = {RightHip = {88, 0, 6}, LeftHip = {88, 0, -6}, RightKnee = {-88}, LeftKnee = {-88}, RightShoulder = {70, 0, 22}, LeftShoulder = {30, 0, -8}, RightElbow = {70}, LeftElbow = {48}, Waist = {-4}, Neck = {6}}
local SHOCK = {RightHip = {-8}, LeftHip = {14}, RightKnee = {-14}, LeftKnee = {-20}, RightShoulder = {40, 0, 45}, LeftShoulder = {40, 0, -45}, RightElbow = {80}, LeftElbow = {80}, Waist = {10}, Neck = {-6}}
local GRABBED = {RightShoulder = {170, 0, 20}, LeftShoulder = {170, 0, -20}, RightElbow = {20}, LeftElbow = {20}, Waist = {12}, Neck = {30}, RightHip = {10}, LeftHip = {10}}
local STAND = {RightShoulder = {4, 0, 5}, LeftShoulder = {4, 0, -5}, RightElbow = {8}, LeftElbow = {8}}
local REACH = {RightShoulder = {175, 0, -8}, RightElbow = {125}, LeftShoulder = {6, 0, -6}, LeftElbow = {12}, Waist = {-4, -8}, RightHip = {-6}, LeftHip = {8}}
local DRAWN = {RightShoulder = {120, 0, 25}, RightElbow = {35}, LeftShoulder = {10, 0, -8}, LeftElbow = {15}, Waist = {0, -18}, RightHip = {-10}, LeftHip = {14}, RightKnee = {-10}, LeftKnee = {-16}}
local GUARD = {RightShoulder = {72, 0, -14}, RightElbow = {62}, LeftShoulder = {78, 0, 30}, LeftElbow = {72}, Waist = {-10, -16}, RightHip = {-22}, LeftHip = {30}, RightKnee = {-22}, LeftKnee = {-34}, Neck = {6}}
local DASH = {RightShoulder = {-35, 0, 28}, RightElbow = {25}, LeftShoulder = {55, 0, -10}, LeftElbow = {85}, Waist = {-34}, RightHip = {-40}, LeftHip = {62}, RightKnee = {-30}, LeftKnee = {-78}, Neck = {28}}
local WIND = {
	right = {RightShoulder = {105, 0, 78}, RightElbow = {40}, LeftShoulder = {50, 0, -20}, LeftElbow = {60}, Waist = {-4, -42}, RightHip = {-18}, LeftHip = {26}, RightKnee = {-20}, LeftKnee = {-30}},
	left = {RightShoulder = {95, 0, -70}, RightElbow = {85}, LeftShoulder = {20, 0, -30}, LeftElbow = {40}, Waist = {-4, 42}, RightHip = {24}, LeftHip = {-18}, RightKnee = {-28}, LeftKnee = {-18}},
	high = {RightShoulder = {178, 0, 6}, RightElbow = {35}, LeftShoulder = {172, 0, -6}, LeftElbow = {40}, Waist = {14}, RightHip = {20}, LeftHip = {-25}, RightKnee = {-60}, LeftKnee = {-40}, Neck = {-10}},
	low = {RightShoulder = {35, 0, 70}, RightElbow = {30}, LeftShoulder = {40, 0, -30}, LeftElbow = {70}, Waist = {-30, -30}, RightHip = {75, 0, 14}, LeftHip = {60, 0, -14}, RightKnee = {-110}, LeftKnee = {-100}},
}
local HIT = {
	right = {RightShoulder = {62, 0, -62}, RightElbow = {12}, LeftShoulder = {-20, 0, -35}, LeftElbow = {30}, Waist = {-14, 48}, RightHip = {30}, LeftHip = {-22}, RightKnee = {-34}, LeftKnee = {-16}},
	left = {RightShoulder = {70, 0, 74}, RightElbow = {10}, LeftShoulder = {30, 0, -40}, LeftElbow = {50}, Waist = {-12, -46}, RightHip = {-22}, LeftHip = {30}, RightKnee = {-16}, LeftKnee = {-34}},
	high = {RightShoulder = {22, 0, -6}, RightElbow = {6}, LeftShoulder = {28, 0, 6}, LeftElbow = {20}, Waist = {-30}, RightHip = {40}, LeftHip = {20}, RightKnee = {-70}, LeftKnee = {-50}, Neck = {18}},
	low = {RightShoulder = {30, 0, -58}, RightElbow = {8}, LeftShoulder = {10, 0, -45}, LeftElbow = {40}, Waist = {-26, 44}, RightHip = {75, 0, 14}, LeftHip = {60, 0, -14}, RightKnee = {-110}, LeftKnee = {-100}},
}
local BLOCK = {RightShoulder = {150, 0, -22}, RightElbow = {72}, LeftShoulder = {150, 0, 22}, LeftElbow = {72}, Waist = {8}, RightHip = {-26}, LeftHip = {34}, RightKnee = {-30}, LeftKnee = {-44}, Neck = {12}}
local KNEEL = {RightHip = {4}, RightKnee = {-92}, LeftHip = {84}, LeftKnee = {-84}, RightShoulder = {58, 0, 4}, RightElbow = {32}, LeftShoulder = {30, 0, -10}, LeftElbow = {70}, Waist = {-20}, Neck = {-16}}
local DIVE = {RightShoulder = {176, 0, 8}, RightElbow = {20}, LeftShoulder = {176, 0, -8}, LeftElbow = {24}, Waist = {10}, RightHip = {-20}, LeftHip = {-35}, RightKnee = {-50}, LeftKnee = {-70}, Neck = {-20}}
local LANDED = {RightShoulder = {28, 0, -4}, RightElbow = {6}, LeftShoulder = {34, 0, 6}, LeftElbow = {20}, Waist = {-32}, RightHip = {70, 0, 12}, LeftHip = {30, 0, -12}, RightKnee = {-100}, LeftKnee = {-95}, Neck = {14}}

---------------------------------------------------------------- katana et fourreau
local function buildKatana(rex, accent)
	local torso, hand = rex.rig:WaitForChild("UpperTorso"), rex.rig:WaitForChild("RightHand")
	local function kp(size, color, material, shape)
		local p = P({Size = size, Color = color, Material = material or Enum.Material.SmoothPlastic, Anchored = false, Massless = true, Parent = rex.rig})
		if shape then p.Shape = shape end
		return p
	end
	local function fix(part, to, offset)
		local w = Instance.new("Weld")
		w.Part0, w.Part1, w.C0 = to, part, offset
		w.Parent = part
		return w
	end
	local saya = kp(Vector3.new(0.34, 4.6, 0.42), rgb(16, 18, 40))
	saya.Reflectance = 0.15
	fix(saya, torso, CFrame.new(-0.1, 0.25, 0.66) * CFrame.Angles(0, 0, rad(-36)))
	for _, y in {-2.1, -0.4, 1.9} do fix(kp(Vector3.new(0.4, 0.16, 0.48), rgb(235, 190, 70), Enum.Material.Metal), saya, CFrame.new(0, y, 0)) end
	fix(kp(Vector3.new(0.08, 1.5, 0.46), rgb(190, 30, 40)), saya, CFrame.new(0, 0.9, 0) * CFrame.Angles(0, 0, rad(24)))
	local handle = kp(Vector3.new(0.22, 1.3, 0.22), rgb(26, 22, 28))
	for i = -1, 1 do fix(kp(Vector3.new(0.25, 0.12, 0.25), rgb(190, 30, 40)), handle, CFrame.new(0, i * 0.36, 0) * CFrame.Angles(0, rad(45), 0)) end
	fix(kp(Vector3.new(0.26, 0.14, 0.26), rgb(235, 190, 70), Enum.Material.Metal), handle, CFrame.new(0, -0.7, 0))
	fix(kp(Vector3.new(0.1, 0.62, 0.62), rgb(235, 190, 70), Enum.Material.Metal, Enum.PartType.Cylinder), handle, CFrame.new(0, 0.7, 0) * CFrame.Angles(0, 0, rad(90)))
	local blade = kp(Vector3.new(0.07, 4.1, 0.3), rgb(215, 225, 240), Enum.Material.Metal)
	blade.Reflectance = 0.45
	fix(blade, handle, CFrame.new(0, 2.8, 0))
	fix(kp(Vector3.new(0.03, 4.05, 0.06), accent or rgb(190, 235, 255), Enum.Material.Neon), blade, CFrame.new(0, 0, -0.14))
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = Vector3.new(0, -2, 0), Vector3.new(0, 2.05, 0)
	a0.Parent, a1.Parent = blade, blade
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Lifetime, trail.LightEmission, trail.Enabled = 0.22, 1, false
	trail.Color = ColorSequence.new(rgb(235, 250, 255), accent or rgb(90, 170, 255))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
	trail.Parent = blade
	local SHEATHED, HELD = CFrame.new(0, 3.05, 0) * CFrame.Angles(rad(180), 0, 0), CFrame.new(0, -0.12, -0.1) * CFrame.Angles(rad(-90), 0, 0)
	local grip = fix(handle, saya, SHEATHED)
	local k = {blade = blade, handle = handle, trail = trail}
	function k.draw() handle.Anchored = false grip.Parent = handle grip.Part0, grip.C0 = hand, HELD end
	function k.sheath() handle.Anchored = false grip.Parent = handle grip.Part0, grip.C0 = saya, SHEATHED end
	function k.plant(cf) -- détaché de la main, puis fixé dans le sol (on repose sa place une fois la soudure vraiment rompue)
		grip:Destroy()
		handle.Anchored = true
		handle.CFrame = cf
		for _, delay in {0.03, 0.1, 0.25} do task.delay(delay, function() if handle.Parent then handle.CFrame = cf end end) end
	end
	function k.tip() return blade.CFrame * Vector3.new(0, 2, 0) end
	return k
end

---------------------------------------------------------------- la Faucheuse (environ 4 fois la taille d'un joueur)
local R_IDLE = {B = {0, 0, 0}, H = {-8, 0, 0}, UR = {18, 0, 10}, ER = 28, UL = {8, 0, -12}, EL = 20, S = {-12, 0, 0}}
local R_BLOCK = {
	front = {B = {-6, 0, 0}, H = {-18, 0, 0}, UR = {55, 0, -18}, ER = 55, UL = {50, 0, 20}, EL = 60, S = {-35, 0, -55}},
	right = {B = {0, -25, -6}, H = {-10, -30, 0}, UR = {40, 0, 55}, ER = 35, UL = {10, 0, -10}, EL = 20, S = {-10, 0, -25}},
	left = {B = {0, 25, 6}, H = {-10, 30, 0}, UR = {65, 0, -50}, ER = 60, UL = {15, 0, -15}, EL = 25, S = {-15, 0, 50}},
	high = {B = {8, 0, 0}, H = {25, 0, 0}, UR = {150, 0, 12}, ER = 40, UL = {140, 0, -12}, EL = 45, S = {-80, 0, -75}},
	low = {B = {-22, 0, 0}, H = {-30, 0, 0}, UR = {25, 0, 5}, ER = 10, UL = {20, 0, -8}, EL = 15, S = {-150, 0, 10}},
}
local R_WIND = {B = {12, 0, 0}, H = {-15, 0, 0}, UR = {165, 0, 18}, ER = 25, UL = {30, 0, -20}, EL = 30, S = {-25, 0, 0}}
local R_STRIKE = {B = {-28, 0, 0}, H = {-20, 0, 0}, UR = {48, 0, -8}, ER = 8, UL = {-20, 0, -25}, EL = 15, S = {-95, 0, 0}}
local R_FALL = {B = {-78, 0, 0}, H = {-25, 0, 0}, UR = {120, 0, 30}, ER = 20, UL = {110, 0, -30}, EL = 25, S = {-60, 0, 40}}

local function buildReaper()
	local R = {pos = V(0, 12.5, -95), yaw = 180, yawT = 180, turn = 3, speed = 6, pose = R_IDLE, parts = {}, lights = {}, fx = {}, t = 0}
	local cur = {B = {0, 0, 0}, H = {0, 0, 0}, UR = {0, 0, 0}, UL = {0, 0, 0}, S = {0, 0, 0}, ER = 0, EL = 0}
	local BLACK, BLACK2, BONE, BONE2, STEEL, VIOLET, SOUL = rgb(11, 9, 16), rgb(20, 16, 28), rgb(128, 124, 114), rgb(92, 88, 82), rgb(86, 90, 106), rgb(180, 80, 255), rgb(120, 225, 255)
	local CYL, BALL, NEON, FABRIC, METAL = Enum.PartType.Cylinder, Enum.PartType.Ball, Enum.Material.Neon, Enum.Material.Fabric, Enum.Material.Metal
	local UP = CFrame.Angles(0, 0, rad(90)) -- met l'axe d'un cylindre à la verticale
	local function add(bone, size, offset, color, extra)
		local props = {Size = size, Color = color}
		for k, v in extra or {} do props[k] = v end
		local p = P(props)
		table.insert(R.parts, {p = p, b = bone, o = offset, t = p.Transparency})
		return p
	end
	local function free(props) -- pièce animée à la main (rubans, âmes, runes...)
		local p = P(props)
		table.insert(R.parts, {p = p, t = p.Transparency})
		return p
	end
	local function glow(part, color, range, brightness)
		local l = Instance.new("PointLight")
		l.Color, l.Range, l.Brightness = color, range, brightness or 2.2
		l.Parent = part
		table.insert(R.lights, l)
	end
	local function trail(part, a, b, color, life)
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.Position, a1.Position = a, b
		a0.Parent, a1.Parent = part, part
		local tr = Instance.new("Trail")
		tr.Attachment0, tr.Attachment1, tr.Lifetime, tr.LightEmission = a0, a1, life, 1
		tr.Color = ColorSequence.new(color, color)
		tr.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
		tr.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
		tr.Parent = part
		table.insert(R.fx, tr)
	end
	local function chain(bone, start, count, len, r0, r1, bend, color, tipColor) -- suite de cylindres qui se courbe (cornes, griffes, pointes)
		local cf = start
		for i = 1, count do
			local r = r0 + (r1 - r0) * (i - 1) / math.max(count - 1, 1)
			cf = cf * bend
			local tip = i == count and tipColor
			add(bone, Vector3.new(len * 1.15, r * 2, r * 2), cf * CFrame.new(0, len / 2, 0) * UP, tip or color, {Shape = CYL, Material = tip and NEON or Enum.Material.SmoothPlastic})
			cf = cf * CFrame.new(0, len, 0)
		end
		return cf
	end

	-- robe : cylindres empilés en cloche (ronde), épaules arrondies, col en lambeaux
	local profile = {2.5, 2.9, 3.0, 3.2, 3.6, 4.1, 4.7, 5.3}
	for i, r in profile do
		add("B", Vector3.new(2.25, r * 2, r * 2), CFrame.new(0, 5.2 - i * 1.9, 0) * UP, i % 2 == 0 and BLACK or BLACK2, {Shape = CYL, Material = FABRIC})
	end
	add("B", Vector3.new(1.4, 8.6, 8.6), CFrame.new(0, 4.9, 0.2) * UP, BLACK2, {Shape = CYL, Material = FABRIC})
	for i = 1, 14 do -- col déchiré qui retombe sur les épaules
		local a = i / 14 * math.pi * 2
		add("B", Vector3.new(1.5, rng:NextNumber(1.6, 3), 0.3), CFrame.new(sin(a) * 4.2, 4.5, cos(a) * 4.2 + 0.2) * CFrame.Angles(0, a, 0) * CFrame.Angles(rad(22), 0, 0) * CFrame.new(0, -1, 0), i % 2 == 0 and BLACK or BLACK2, {Class = "WedgePart", Material = FABRIC})
	end
	-- cage thoracique ouverte : colonne, côtes rondes, cœur d'âmes qui bat
	add("B", Vector3.new(3.4, 0.42, 0.42), CFrame.new(0, 2.6, -2.75) * UP, BONE2, {Shape = CYL})
	for i = 0, 4 do
		for _, s in {1, -1} do
			add("B", Vector3.new(1.5 - i * 0.12, 0.24, 0.24), CFrame.new(s * (0.8 - i * 0.05), 3.9 - i * 0.6, -2.8) * CFrame.Angles(0, rad(s * 24), rad(s * 10)), BONE, {Shape = CYL})
		end
	end
	local heart = add("B", Vector3.one * 1.3, CFrame.new(0, 2.9, -2.3), VIOLET, {Shape = BALL, Material = NEON, Transparency = 0.1})
	glow(heart, VIOLET, 20, 3)
	for _, s in {1, -1} do -- épaulières : crâne + pointes d'os recourbées
		add("B", Vector3.one * 3.3, CFrame.new(s * 4.4, 5.0, 0), rgb(30, 30, 40), {Shape = BALL, Material = METAL})
		add("B", Vector3.one * 1.25, CFrame.new(s * 5.0, 5.3, -1.5), BONE, {Shape = BALL})
		for _, e in {0.28, -0.28} do add("B", Vector3.one * 0.34, CFrame.new(s * 5.0 + e, 5.4, -2.02), rgb(0, 0, 0), {Shape = BALL}) end
		for j = -1, 1 do chain("B", CFrame.new(s * 4.9, 6.1, j * 1.0) * CFrame.Angles(rad(j * 20), 0, rad(-s * 30)), 4, 0.6, 0.3, 0.05, CFrame.Angles(0, 0, rad(s * 12)), BONE2, BONE) end
	end
	-- capuche ronde et profonde, crâne à l'intérieur : orbites noires, pupilles d'âme, mâchoire qui bouge
	add("H", Vector3.one * 4.9, CFrame.new(0, 0.5, 0.7), BLACK, {Shape = BALL, Material = FABRIC})
	add("H", Vector3.new(3.6, 4.6, 4.6), CFrame.new(0, 0.9, 0.1) * CFrame.Angles(0, rad(90), 0), BLACK2, {Shape = CYL, Material = FABRIC})
	for _, s in {1, -1} do add("H", Vector3.new(4.4, 1.5, 1.5), CFrame.new(s * 1.9, 0.2, -0.7) * UP, BLACK, {Shape = CYL, Material = FABRIC}) end
	chain("H", CFrame.new(0, 2.6, 1.6) * CFrame.Angles(rad(55), 0, 0), 5, 0.9, 0.9, 0.12, CFrame.Angles(rad(16), 0, 0), BLACK2)
	add("H", Vector3.one * 2.5, CFrame.new(0, 0.25, -0.75), BONE, {Shape = BALL})
	add("H", Vector3.new(1.5, 1.3, 1.3), CFrame.new(0, -0.75, -1.0) * UP, BONE, {Shape = CYL})
	for _, s in {1, -1} do
		add("H", Vector3.one * 1.02, CFrame.new(s * 0.58, 0.4, -1.62), rgb(0, 0, 0), {Shape = BALL})
		local eye = add("H", Vector3.one * 0.2, CFrame.new(s * 0.58, 0.36, -2.08), SOUL, {Shape = BALL, Material = NEON})
		glow(eye, SOUL, 9, 3)
		trail(eye, Vector3.new(0, 0.12, 0), Vector3.new(0, -0.12, 0), SOUL, 0.5)
		add("H", Vector3.new(1.0, 0.16, 0.2), CFrame.new(s * 0.62, 0.92, -1.9) * CFrame.Angles(0, 0, rad(s * 30)), rgb(40, 38, 36)) -- arcade sourcilière : regard mauvais
		chain("H", CFrame.new(s * 1.9, 2.1, -0.3) * CFrame.Angles(rad(-12), 0, rad(-s * 58)), 7, 0.8, 0.36, 0.05, CFrame.Angles(rad(-9), 0, rad(s * 13)), rgb(46, 42, 54), VIOLET)
	end
	add("H", Vector3.new(0.3, 0.42, 0.2), CFrame.new(0, -0.08, -2.0) * CFrame.Angles(0, 0, rad(180)), rgb(0, 0, 0), {Class = "WedgePart"})
	for i = -2, 2 do add("H", Vector3.new(0.2, 0.3, 0.14), CFrame.new(i * 0.24, -0.82, -1.66), rgb(170, 166, 150)) end
	add("J", Vector3.new(1.5, 0.45, 1.2), CFrame.new(0, -0.3, -0.55), BONE2)
	for i = -2, 2 do add("J", Vector3.new(0.2, 0.28, 0.14), CFrame.new(i * 0.24, 0.05, -1.12), rgb(170, 166, 150)) end
	-- bras : manches rondes évasées, os, longues griffes
	for _, side in {{"UR", "LR"}, {"UL", "LL"}} do
		add(side[1], Vector3.new(5.6, 2.1, 2.1), CFrame.new(0, -2.6, 0) * UP, BLACK, {Shape = CYL, Material = FABRIC})
		add(side[1], Vector3.one * 2.3, CFrame.new(0, -5.2, 0), BLACK2, {Shape = BALL, Material = FABRIC})
		add(side[2], Vector3.new(2.6, 2.7, 2.7), CFrame.new(0, -1.3, 0) * UP, BLACK2, {Shape = CYL, Material = FABRIC})
		for i = 1, 6 do add(side[2], Vector3.new(0.9, rng:NextNumber(1, 2.2), 0.25), CFrame.new(sin(i) * 1.2, -2.7, cos(i) * 1.2) * CFrame.Angles(0, i, 0) * CFrame.new(0, -0.7, 0), BLACK, {Class = "WedgePart", Material = FABRIC}) end
		for _, x in {0.22, -0.22} do add(side[2], Vector3.new(3, 0.3, 0.3), CFrame.new(x, -3.6, 0) * UP, BONE, {Shape = CYL}) end
		add(side[2], Vector3.one * 0.95, CFrame.new(0, -5.2, 0), BONE2, {Shape = BALL})
		for f = -1.5, 1.5 do
			chain(side[2], CFrame.new(f * 0.26, -5.4, -0.1) * CFrame.Angles(rad(165 + math.abs(f) * 4), 0, rad(f * 7)), 3, 0.62, 0.11, 0.04, CFrame.Angles(rad(-20), 0, 0), BONE, rgb(20, 16, 24))
		end
	end
	local orb = add("LL", Vector3.one * 1.5, CFrame.new(0, -7.4, -0.6), rgb(30, 6, 60), {Shape = BALL, Material = NEON})
	glow(orb, VIOLET, 14, 2.5)
	-- faux : manche torsadé, crâne à la base de la lame, grande lame lisse à fil lumineux, chaîne et lanterne d'âme
	add("S", Vector3.new(27, 0.6, 0.6), CFrame.new(0, 5, 0) * UP, rgb(26, 20, 26), {Shape = CYL, Material = Enum.Material.Wood})
	for i = 0, 9 do add("S", Vector3.new(0.3, 0.78, 0.78), CFrame.new(0, -7 + i * 0.75, 0) * UP, i % 2 == 0 and rgb(70, 16, 24) or rgb(40, 12, 18), {Shape = CYL, Material = FABRIC}) end
	for _, y in {-8.2, 0.4, 16.6, 18.4} do add("S", Vector3.new(0.4, 0.95, 0.95), CFrame.new(0, y, 0) * UP, rgb(205, 165, 60), {Shape = CYL, Material = METAL}) end
	add("S", Vector3.one * 1.5, CFrame.new(0, 17.5, -0.2), BONE, {Shape = BALL})
	for _, e in {0.32, -0.32} do glow(add("S", Vector3.one * 0.36, CFrame.new(e, 17.6, -0.82), VIOLET, {Shape = BALL, Material = NEON}), VIOLET, 5, 1.5) end
	local edge
	for i = 0, 15 do
		local th = rad(2 + i * 6)
		local w = 3.0 * (1 - i / 17) ^ 1.3 + 0.3
		local cf = CFrame.new(0, 8.4 + 10 * cos(th), -10 * sin(th)) * CFrame.Angles(-th, 0, 0)
		add("S", Vector3.new(0.14, w, 1.25), cf, STEEL, {Material = METAL, Reflectance = 0.35})
		add("S", Vector3.new(0.3, 0.3, 1.25), cf * CFrame.new(0, w / 2, 0) * CFrame.Angles(0, rad(90), 0) * UP, rgb(46, 46, 58), {Shape = CYL, Material = METAL})
		local glowing = add("S", Vector3.new(0.18, 0.1, 1.25), cf * CFrame.new(0, -w / 2, 0), VIOLET, {Material = NEON})
		if i == 8 then edge = glowing end
	end
	trail(edge, Vector3.new(0, 0, -6), Vector3.new(0, 0, 6), VIOLET, 0.35)
	chain("S", CFrame.new(0, 18.8, 0.6) * CFrame.Angles(rad(150), 0, 0), 4, 0.6, 0.3, 0.04, CFrame.Angles(rad(-14), 0, 0), STEEL)
	add("S", Vector3.new(2.6, 0.09, 0.09), CFrame.new(0, 15.2, -0.9) * UP, STEEL, {Shape = CYL})
	add("S", Vector3.new(1.3, 1.0, 1.0), CFrame.new(0, 13.4, -0.9) * UP, rgb(16, 16, 22), {Shape = CYL, Transparency = 0.4})
	local lantern = add("S", Vector3.one * 0.6, CFrame.new(0, 13.4, -0.9), SOUL, {Shape = BALL, Material = NEON})
	glow(lantern, SOUL, 18, 2.6)

	-- pièces libres : lambeaux du bas, rubans spectraux dans le dos, auréole brisée, âmes en orbite, cercle de runes au sol
	local tatters, ribbons, halo, souls, runes = {}, {}, {}, {}, {}
	for i = 1, 22 do
		local a = i / 22 * math.pi * 2
		local len = rng:NextNumber(2.5, 5.5)
		tatters[i] = {p = free({Class = "WedgePart", Size = Vector3.new(1.5, len, 0.25), Color = i % 2 == 0 and BLACK or BLACK2, Material = FABRIC}), base = CFrame.new(sin(a) * 5.0, -10.6, cos(a) * 5.0) * CFrame.Angles(0, a, 0), phase = i * 0.9, len = len}
	end
	for i = 1, 7 do
		local segs = {}
		for j = 1, 7 do segs[j] = free({Size = Vector3.new(1.1 - j * 0.1, 1.9, 0.12), Color = j > 5 and VIOLET or BLACK2, Material = j > 5 and NEON or FABRIC, Transparency = j > 5 and 0.35 or 0}) end
		ribbons[i] = {segs = segs, x = (i - 4) * 1.15, phase = i * 1.7}
	end
	for i = 1, 11 do halo[i] = {p = free({Size = Vector3.new(0.45, rng:NextNumber(0.9, 2.2), 0.16), Color = VIOLET, Material = NEON}), a = i / 11 * math.pi * 2} end
	for i = 1, 7 do
		local p = free({Shape = BALL, Size = Vector3.one * 0.55, Color = SOUL, Material = NEON})
		trail(p, Vector3.new(0, 0.25, 0), Vector3.new(0, -0.25, 0), SOUL, 0.9)
		souls[i] = {p = p, r = rng:NextNumber(6, 9), h = rng:NextNumber(-8, 7), w = rng:NextNumber(0.7, 1.5) * (i % 2 == 0 and 1 or -1), phase = i * 2.1}
	end
	for i = 1, 16 do runes[i] = {p = free({Size = Vector3.new(0.35, 0.08, i % 2 == 0 and 2.6 or 1.2), Color = VIOLET, Material = NEON, Transparency = 0.25}), a = i / 16 * math.pi * 2} end
	-- brume noire épaisse sous elle, braises violettes
	local mist = free({Size = Vector3.new(10, 1, 10), Transparency = 1})
	for _, spec in {{SMOKE, rgb(6, 4, 12), 8, 34, 3, 0.25, 0}, {SMOKE, rgb(40, 14, 70), 5, 10, 5, 0.6, 0}, {SPARK, VIOLET, 0.55, 20, 8, 0, 1}} do
		local e = Instance.new("ParticleEmitter")
		e.Texture, e.Rate, e.Lifetime = spec[1], spec[4], NumberRange.new(1.8, 3.2)
		e.Color = ColorSequence.new(spec[2], spec[2])
		e.Speed, e.SpreadAngle = NumberRange.new(1, spec[5]), Vector2.new(75, 75)
		e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-40, 40)
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, spec[3] * 0.5), NumberSequenceKeypoint.new(1, spec[3])})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, spec[6]), NumberSequenceKeypoint.new(1, 1)})
		e.LightEmission = spec[7]
		e.Parent = mist
		table.insert(R.fx, e)
	end
	glow(mist, VIOLET, 26, 1.6)
	R.mist = mist

	local lastPos, drift, jaw = R.pos, 0, 0
	function R.update(dt)
		if R.dead then return end
		R.t += dt
		local t = R.t
		local k = 1 - exp(-R.speed * dt)
		for name, value in cur do
			local goal = R.pose[name]
			if type(value) == "number" then
				cur[name] = value + (goal - value) * k
			else
				for i = 1, 3 do value[i] += ((goal[i] or 0) - value[i]) * k end
			end
		end
		R.yaw += (((R.yawT - R.yaw + 180) % 360) - 180) * (1 - exp(-R.turn * dt))
		-- elle flotte : lent va-et-vient vertical, léger roulis, et elle se penche dans le sens où elle glisse
		local speed = ((R.pos - lastPos) * Vector3.new(1, 0, 1)).Magnitude / math.max(dt, 0.001)
		lastPos = R.pos
		drift += (clamp(speed * 0.9, 0, 20) - drift) * (1 - exp(-4 * dt))
		local root = CFrame.new(R.pos + Vector3.new(0, sin(t * 1.1) * 0.9 + sin(t * 2.7) * 0.2, 0)) * CFrame.Angles(0, rad(R.yaw), 0)
		local B = root * CFrame.Angles(rad(-drift) + sin(t * 0.8) * 0.03, 0, sin(t * 0.6) * 0.04) * A(cur.B)
		local bones = {B = B}
		bones.H = B * CFrame.new(0, 7.6, -0.4) * A(cur.H) * CFrame.Angles(sin(t * 0.9) * 0.04, sin(t * 0.5) * 0.06, 0)
		jaw += ((R.speed > 20 and 34 or 7 + 5 * sin(t * 1.4)) - jaw) * (1 - exp(-10 * dt)) -- la mâchoire s'ouvre quand elle frappe
		bones.J = bones.H * CFrame.new(0, -1.1, -0.45) * CFrame.Angles(rad(jaw), 0, 0)
		bones.UR = B * CFrame.new(4.3, 4.7, 0) * A(cur.UR)
		bones.LR = bones.UR * CFrame.new(0, -5.2, 0) * CFrame.Angles(rad(cur.ER), 0, 0)
		bones.UL = B * CFrame.new(-4.3, 4.7, 0) * A(cur.UL) * CFrame.Angles(sin(t * 1.2) * 0.05, 0, 0)
		bones.LL = bones.UL * CFrame.new(0, -5.2, 0) * CFrame.Angles(rad(cur.EL), 0, 0)
		bones.S = bones.LR * CFrame.new(0, -5.3, 0) * A(cur.S)
		R.root, R.head, R.blade = root, bones.H, bones.S * Vector3.new(0, 13, -8)
		for _, e in R.parts do
			if e.o then e.p.CFrame = bones[e.b] * e.o end
		end
		heart.Size = Vector3.one * (1.3 + 0.25 * math.max(0, sin(t * 4.2)) ^ 3)
		local back = drift / 20
		for _, tt in tatters do
			tt.p.CFrame = B * tt.base * CFrame.Angles(sin(t * 2.2 + tt.phase) * 0.3 + 0.2 + back * 0.4, 0, sin(t * 1.7 + tt.phase) * 0.14) * CFrame.new(0, -tt.len / 2, 0)
		end
		for _, rb in ribbons do -- rubans qui ondulent derrière elle comme des ailes en lambeaux
			local cf = B * CFrame.new(rb.x, 4.2, 2.6) * CFrame.Angles(rad(62 + back * 18), 0, rad(rb.x * 7))
			for j, seg in rb.segs do
				cf = cf * CFrame.Angles(sin(t * 2 + rb.phase + j * 0.7) * 0.2 - 0.07, 0, sin(t * 1.3 + rb.phase + j) * 0.09)
				seg.CFrame = cf * CFrame.new(0, -0.95, 0)
				cf = cf * CFrame.new(0, -1.9, 0)
			end
		end
		for _, h in halo do
			h.p.CFrame = bones.H * CFrame.new(0, 1, 2.9) * CFrame.Angles(0, 0, h.a + t * 0.6) * CFrame.new(0, 3.9 + sin(t * 2 + h.a * 3) * 0.2, 0)
		end
		for _, s in souls do
			local a = t * s.w + s.phase
			s.p.Position = R.pos + Vector3.new(sin(a) * s.r, s.h + sin(t * 1.9 + s.phase) * 1.5, cos(a) * s.r)
		end
		local ground = Vector3.new(R.pos.X, ORIGIN.Y + 0.12, R.pos.Z)
		for i, rn in runes do
			local a = rn.a + t * (i % 2 == 0 and 0.5 or -0.35)
			local radius = (i % 2 == 0 and 7.5 or 5.6) + sin(t * 2) * 0.2
			rn.p.CFrame = CFrame.new(ground + Vector3.new(sin(a) * radius, 0, cos(a) * radius)) * CFrame.Angles(0, a + math.pi / 2, 0)
		end
		mist.CFrame = CFrame.new(ground + Vector3.new(0, 0.8, 0))
	end
	function R.setAlpha(alpha) -- 1 = invisible
		for _, e in R.parts do e.p.Transparency = e.t + (1 - e.t) * alpha end
		for _, l in R.lights do l.Enabled = alpha < 0.5 end
		for _, f in R.fx do f.Enabled = alpha < 0.5 end
	end
	function R.die() -- coupée en deux : les deux moitiés glissent, basculent et se dissipent ; ses âmes s'envolent
		R.dead = true
		for _, f in R.fx do if f:IsA("ParticleEmitter") then f.Enabled = false end end
		for _, e in R.parts do
			local p = e.p
			local side = R.root:PointToObjectSpace(p.Position).X >= 0 and 1 or -1
			local goal = (p.CFrame + R.root.RightVector * side * rng:NextNumber(3, 6) + Vector3.new(0, -rng:NextNumber(2, 7), 0)) * CFrame.Angles(rng:NextNumber(-1, 1), rng:NextNumber(-1, 1), side * rng:NextNumber(0.4, 1.4))
			TweenService:Create(p, TweenInfo.new(rng:NextNumber(1.8, 2.8), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {CFrame = goal, Transparency = 1}):Play()
		end
		for _, s in souls do
			TweenService:Create(s.p, TweenInfo.new(2.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = s.p.Position + Vector3.new(rng:NextNumber(-6, 6), 60, rng:NextNumber(-6, 6)), Transparency = 1}):Play()
		end
		for _, l in R.lights do TweenService:Create(l, TweenInfo.new(1.5), {Brightness = 0}):Play() end
	end
	return R
end

---------------------------------------------------------------- décor : forêt de nuit, clairière, feu de camp
local function buildSet()
	P({Size = Vector3.new(700, 6, 700), Position = V(0, -3, 0), Color = rgb(22, 38, 30), Material = Enum.Material.Grass})
	P({Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.3, 30, 30), CFrame = CFrame.new(V(0, 0.05, 0)) * CFrame.Angles(0, 0, rad(90)), Color = rgb(54, 44, 36), Material = Enum.Material.Ground})
	for _ = 1, 95 do
		local a, d = rng:NextNumber(0, math.pi * 2), rng:NextNumber(24, 190)
		local x, z = sin(a) * d, cos(a) * d
		if not (math.abs(x) < 16 and z < 4) then -- le couloir d'où vient la Faucheuse reste dégagé
			local h, w = rng:NextNumber(9, 16), rng:NextNumber(1.5, 2.6)
			P({Shape = Enum.PartType.Cylinder, Size = Vector3.new(h, w, w), CFrame = CFrame.new(V(x, h / 2, z)) * CFrame.Angles(0, 0, rad(90)), Color = rgb(46, 34, 28), Material = Enum.Material.Wood})
			for i = 0, 2 do
				local s = (9.5 - i * 2.6) * rng:NextNumber(0.85, 1.15)
				P({Size = Vector3.new(s, 4.4, s), CFrame = CFrame.new(V(x, h + i * 3.4, z)) * CFrame.Angles(0, rng:NextNumber(0, 1.5), 0), Color = rgb(16 + i * 5, 52 + i * 9, 36 + i * 4), Material = Enum.Material.Grass})
			end
		end
	end
	for _ = 1, 40 do -- rochers et buissons
		local a, d = rng:NextNumber(0, math.pi * 2), rng:NextNumber(17, 120)
		local s = rng:NextNumber(1, 3.2)
		local bush = rng:NextNumber() < 0.5
		P({Size = Vector3.new(s * 1.4, s, s * 1.2), CFrame = CFrame.new(V(sin(a) * d, s * 0.3, cos(a) * d)) * CFrame.Angles(rng:NextNumber(-0.3, 0.3), rng:NextNumber(0, 3), 0), Color = bush and rgb(20, 60, 38) or rgb(70, 72, 80), Material = bush and Enum.Material.Grass or Enum.Material.Slate})
	end
	for i = 1, 8 do
		local a = i / 8 * math.pi * 2
		P({Size = Vector3.new(0.9, 0.7, 0.8), CFrame = CFrame.new(V(sin(a) * 1.9, 0.3, cos(a) * 1.9)) * CFrame.Angles(0, a, 0.2), Color = rgb(88, 88, 96), Material = Enum.Material.Slate})
	end
	for i = 1, 4 do
		P({Shape = Enum.PartType.Cylinder, Size = Vector3.new(2.6, 0.5, 0.5), CFrame = CFrame.new(V(0, 0.55, 0)) * CFrame.Angles(0, i * 0.8, rad(28)), Color = rgb(40, 26, 18), Material = Enum.Material.Wood})
	end
	for _, seat in {{0, 5.2, 90}, {-4.6, -2.4, 30}, {4.6, -2.2, -30}} do
		P({Shape = Enum.PartType.Cylinder, Size = Vector3.new(4.4, 1.1, 1.1), CFrame = CFrame.new(V(seat[1], 0.5, seat[2])) * CFrame.Angles(0, rad(seat[3] + 90), 0), Color = rgb(72, 50, 34), Material = Enum.Material.Wood})
	end
	local core = P({Size = Vector3.new(1.4, 0.4, 1.4), Position = V(0, 0.7, 0), Transparency = 1})
	for _, spec in {{"rbxasset://textures/particles/fire_main.dds", 42, 1.9, rgb(255, 170, 60), 5, 0.9}, {SPARK, 9, 0.35, rgb(255, 200, 110), 9, 2}, {SMOKE, 6, 2.4, rgb(60, 60, 66), 4, 3.5}} do
		local e = Instance.new("ParticleEmitter")
		e.Texture, e.Rate = spec[1], spec[2]
		e.Color = ColorSequence.new(spec[4], spec[1] == SMOKE and spec[4] or rgb(255, 70, 20))
		e.Lifetime, e.Speed = NumberRange.new(spec[6] * 0.6, spec[6]), NumberRange.new(spec[5] * 0.5, spec[5])
		e.SpreadAngle, e.Rotation, e.RotSpeed = Vector2.new(16, 16), NumberRange.new(0, 360), NumberRange.new(-60, 60)
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, spec[3]), NumberSequenceKeypoint.new(1, spec[1] == SMOKE and spec[3] * 2 or spec[3] * 0.2)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, spec[1] == SMOKE and 0.8 or 0.1), NumberSequenceKeypoint.new(1, 1)})
		e.LightEmission = spec[1] == SMOKE and 0 or 0.9
		e.Parent = core
	end
	fireLight = Instance.new("PointLight")
	fireLight.Color, fireLight.Range, fireLight.Brightness, fireLight.Shadows = rgb(255, 150, 60), 46, 3.2, true
	fireLight.Parent = core
end

---------------------------------------------------------------- interface (bandes noires, fondu, sous-titres, nom du boss)
local function buildGui()
	gui = Instance.new("ScreenGui")
	gui.Name, gui.IgnoreGuiInset, gui.DisplayOrder, gui.ResetOnSpawn = "ReaperCutsceneGui", true, 900, false
	local function frame(props)
		local f = Instance.new(props.Class or "Frame")
		f.BorderSizePixel = 0
		for k, v in props do if k ~= "Class" then f[k] = v end end
		f.Parent = gui
		return f
	end
	bars = {frame({BackgroundColor3 = Color3.new(), Size = UDim2.new(1, 0, 0.11, 0)}), frame({BackgroundColor3 = Color3.new(), Size = UDim2.new(1, 0, 0.11, 0), Position = UDim2.fromScale(0, 0.89)})}
	local font = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	subtitle = frame({Class = "TextLabel", BackgroundTransparency = 1, Position = UDim2.fromScale(0.1, 0.78), Size = UDim2.fromScale(0.8, 0.09), FontFace = font, TextScaled = true, RichText = true, TextColor3 = Color3.new(1, 1, 1), Visible = false, Text = ""})
	local s1 = Instance.new("UIStroke") s1.Thickness = 3.5 s1.Parent = subtitle
	subtitle:SetAttribute("No3D", true)
	titleCard = frame({Class = "TextLabel", BackgroundTransparency = 1, Position = UDim2.fromScale(0.1, 0.6), Size = UDim2.fromScale(0.8, 0.13), FontFace = font, TextScaled = true, TextColor3 = rgb(225, 215, 255), TextTransparency = 1, Text = "THE HOLLOW REAPER"})
	local s2 = Instance.new("UIStroke") s2.Thickness = 4 s2.Transparency = 1 s2.Parent = titleCard
	titleCard:SetAttribute("No3D", true)
	flash = frame({BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5})
	fade = frame({BackgroundColor3 = Color3.new(), BackgroundTransparency = 0, Size = UDim2.fromScale(1, 1), ZIndex = 6})
	gui.Parent = player:WaitForChild("PlayerGui")
end

---------------------------------------------------------------- la scène
local function run()
	local rigs = folder:WaitForChild("Rigs")
	for _ = 1, 60 do
		if #rigs:GetChildren() >= 3 then break end
		task.wait(0.25)
	end
	local camera = workspace.CurrentCamera
	scene = Instance.new("Folder")
	scene.Name = "ReaperCutsceneScene"
	scene.Parent = workspace

	-- ce qu'on change dans le jeu, pour tout remettre à la fin
	table.clear(savedLighting) table.clear(hiddenAtmospheres) table.clear(hiddenGuis) table.clear(effects)
	for _, prop in {"ClockTime", "Brightness", "Ambient", "OutdoorAmbient", "ExposureCompensation", "FogEnd", "FogStart", "FogColor"} do savedLighting[prop] = Lighting[prop] end
	for _, child in Lighting:GetChildren() do
		if child:IsA("Atmosphere") then hiddenAtmospheres[child] = true child.Parent = nil end
	end
	for _, g in player.PlayerGui:GetChildren() do
		if g:IsA("ScreenGui") and g.Enabled then hiddenGuis[g] = true g.Enabled = false end
	end
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
	local controls = true
	game:GetService("ContextActionService"):BindActionAtPriority("ReaperCutsceneFreeze", function() return Enum.ContextActionResult.Sink end, false, 10000, unpack(Enum.PlayerActions:GetEnumItems()))
	Lighting.ClockTime, Lighting.Brightness, Lighting.ExposureCompensation = 0, 1.8, 0.45
	Lighting.Ambient, Lighting.OutdoorAmbient = rgb(50, 56, 88), rgb(66, 74, 112)
	local atmosphere = Instance.new("Atmosphere")
	atmosphere.Density, atmosphere.Offset, atmosphere.Haze, atmosphere.Glare = 0.42, 0.1, 2.4, 0
	atmosphere.Color, atmosphere.Decay = rgb(42, 52, 74), rgb(10, 12, 22)
	atmosphere.Parent = Lighting
	local grade = Instance.new("ColorCorrectionEffect")
	grade.Contrast, grade.Saturation, grade.TintColor = 0.14, -0.1, rgb(214, 224, 255)
	grade.Parent = Lighting
	blur = Instance.new("BlurEffect")
	blur.Size = 0
	blur.Parent = Lighting
	effects[1], effects[2], effects[3] = atmosphere, grade, blur
	local oldType, oldFov = camera.CameraType, camera.FieldOfView
	camera.CameraType = Enum.CameraType.Scriptable

	buildGui()
	buildSet()
	local function actor(role)
		local rig = rigs[role]:Clone()
		rig.Parent = scene
		rig:PivotTo(CFrame.new(V(0, 4, 0)))
		local a = Poses.setup(rig)
		a.standY, a.speed, a.seed = a.standY, 10, #actors * 1.7
		local hum, classic = rig:FindFirstChildOfClass("Humanoid"), true
		for _, j in a.joints do if j.constraint then classic = false end end
		if hum then -- vraies animations Roblox de marche et de course
			local animator = Instance.new("Animator")
			animator.Parent = hum
			a.tracks = {}
			for name, id in {Walk = 507777826, Run = 507767714} do
				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://" .. id
				local ok, loaded = pcall(function() return animator:LoadAnimation(animation) end)
				if ok and loaded then
					loaded.Looped, loaded.Priority = true, Enum.AnimationPriority.Movement
					a.tracks[name] = loaded
				end
			end
		end
		table.insert(actors, a)
		return a
	end
	local rex, kino, nono = actor("Rex"), actor("Kino"), actor("Nono")
	local katana = buildKatana(rex)
	local kinoKatana, nonoKatana = buildKatana(kino, rgb(255, 90, 90)), buildKatana(nono, rgb(120, 255, 150))
	local katanas = {katana, kinoKatana, nonoKatana}
	local trio = {rex, kino, nono}
	local FIRE = V(0, 2, 0)
	local function seat(a, x, z)
		place(a, x, z, yawTo(V(x, 0, z), FIRE), 1.05 + a.sitY)
		Poses.set(a, SIT, true)
	end
	seat(rex, 0, 5.2)
	seat(kino, -4.6, -2.4)
	seat(nono, 4.6, -2.2)
	reaper = buildReaper()
	reaper.setAlpha(1)
	local R = reaper

	local music = snd(MUSIC_CALM, 0.25, 1, true)
	local wind = snd("rbxasset://sounds/HalloweenGhost.wav", 0.05, 0.5, true)
	local frame = RunService.RenderStepped:Connect(function(dt)
		for i = #tracks, 1, -1 do
			local tr = tracks[i]
			local u = clamp((now() - tr.s) / tr.d, 0, 1)
			tr.fn(u, dt)
			if u >= 1 then table.remove(tracks, i) end
		end
		for _, a in actors do
			if a.animating then a.hrp.CFrame = a.cf else Poses.step(a, dt, a.speed) liven(a, dt) end
		end
		R.update(dt)
		if fireLight then fireLight.Brightness = (fireLight:GetAttribute("Base") or 3.2) * (0.86 + 0.14 * math.noise(now() * 7, 3)) end
		if camFn then
			local cf, fov = camFn(now() - camStart)
			if shakeAmp > 0.01 then
				cf = cf * CFrame.new(rng:NextNumber(-1, 1) * shakeAmp, rng:NextNumber(-1, 1) * shakeAmp, 0) * CFrame.Angles(0, 0, rng:NextNumber(-1, 1) * shakeAmp * 0.02)
			end
			if camera.CameraType ~= Enum.CameraType.Scriptable then camera.CameraType = Enum.CameraType.Scriptable end -- si un autre script reprend la caméra
			cf = cf * CFrame.Angles(math.noise(now() * 0.5, 1.3) * 0.007, math.noise(now() * 0.45, 7.1) * 0.009, 0)
			camera.CFrame, camera.FieldOfView = cf, (fov or 60) + math.min(shakeAmp * 2.5, 9)
		end
		shakeAmp *= exp(-dt * 6)
	end)

	---------------- 1. le feu de camp
	setCam(function(t) local u = ease(clamp(t / 6.5, 0, 1)) return look(V(40 - 14 * u, 17 - 7 * u, 48 - 14 * u), V(0, 3, 0), 55) end)
	fadeTo(1, 2.5)
	hold(6.3)
	setCam(function(t) local a = 0.6 + t * 0.11 return look(V(sin(a) * 13, 4.2, cos(a) * 13), V(0, 2.6, 0), 50) end)
	Poses.set(nono, SIT_TALK) say("Nono275er", "This update is going to be huge.", 3)
	hold(3.2)
	Poses.set(nono, SIT) Poses.set(kino, SIT_TALK)
	setCam(function(t) return look(V(2.3 - t * 0.15, 1.7, 3.1), V(0, 1.5 + t * 0.05, 0), 30) end)
	say("kinoshi112", "Only if Rexy stops breaking the build.", 3)
	hold(3.2)
	Poses.set(kino, SIT) Poses.set(rex, SIT_TALK)
	setCam(function(t) return look(V(-1.6, 2.7, -6.8 + t * 0.25), headOf(rex) + Vector3.new(0, -0.6, 0), 42) end)
	say("rexydev1", "No promises.", 2.4)
	hold(3)
	Poses.set(rex, SIT)

	---------------- 2. kinoshi112 est attrapé... et Rex le rattrape sous terre
	local hole = V(-6.6, 0, -3.6)
	for _, a in trio do a.look = FIRE end
	setCam(function(t) return look(V(-11.5, 0.9, -7.2 + t * 0.2), V(-5, 2.2, -2.8), 48) end)
	fireLight:SetAttribute("Base", 1.9)
	snd("rbxasset://sounds/HalloweenGhost.wav", 0.5, 0.7)
	local mounds = {}
	for i = 1, 5 do mounds[i] = P({Size = Vector3.new(1.2, 0.5, 1.1), Position = hole + Vector3.new(rng:NextNumber(-1, 1), -0.3, rng:NextNumber(-1, 1)), Color = rgb(46, 36, 28), Material = Enum.Material.Ground}) end
	track(3.6, function(u) for i, m in mounds do m.CFrame = CFrame.new(m.Position.X, ORIGIN.Y - 0.3 + 0.45 * u + sin(now() * 14 + i) * 0.06, m.Position.Z) * CFrame.Angles(sin(now() * 9 + i) * 0.2, i, 0) end end)
	hold(1.6)
	kino.look = hole
	Poses.patch(kino, {Waist = {-6, 30, 0}, RightShoulder = {20, 0, 30}})
	say("kinoshi112", "...Did you hear that?", 2)
	rex.look, nono.look = function() return headOf(kino) end, function() return headOf(kino) end
	hold(2.1)
	setCam(function(t) return look(V(-1.5, 2.3, -10.5), kino.cf.Position, 46) end)
	local from = kino.cf
	local tendrils = {}
	for i = 1, 6 do
		local a = i / 6 * math.pi * 2
		tendrils[i] = P({Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.2, 0.45, 0.45), Color = rgb(6, 4, 10), Material = Enum.Material.Neon,
			CFrame = CFrame.new(from.Position + Vector3.new(sin(a) * 1.1, -3.2, cos(a) * 1.1)) * CFrame.Angles(0, 0, rad(90))})
		TweenService:Create(tendrils[i], TweenInfo.new(0.16), {Size = Vector3.new(5, 0.45, 0.45), CFrame = CFrame.new(from.Position + Vector3.new(sin(a) * 0.7, -1.4, cos(a) * 0.7)) * CFrame.Angles(0, 0, rad(90 + sin(a) * 14))}):Play()
	end
	snd("rbxasset://sounds/swordlunge.wav", 0.7, 0.6)
	dust(from.Position - Vector3.new(0, 2, 0), 3, 16)
	Poses.set(kino, GRABBED) kino.speed = 30
	kino.look = nil
	shake(0.5)
	hold(0.22)
	track(0.45, function(u) kino.cf = from * CFrame.new(0, -3.6 * u * u, 0) * CFrame.Angles(rad(-10 * u), 0, 0) for _, td in tendrils do td.CFrame = td.CFrame - Vector3.new(0, 0.12, 0) end end)
	snd("BoomSound", 0.5, 1.4)
	shake(0.9)
	TweenService:Create(music, TweenInfo.new(0.4), {Volume = 0}):Play()
	Poses.set(nono, SHOCK) nono.speed = 22
	moveTo(nono, 7.5, -0.5, 0.5, yawTo(V(7.5, 0, -0.5), from.Position))
	say("Nono275er", "KINOSHI!!", 1.6)
	-- Rex bondit de son rondin, plonge et lui attrape le bras juste avant qu'il disparaisse
	Poses.set(rex, DASH) rex.speed = 30
	local grabSpot = from.Position + Vector3.new(2.3, 0, 0.9) - Vector3.new(0, from.Position.Y - ORIGIN.Y, 0)
	local gx, gz = grabSpot.X - ORIGIN.X, grabSpot.Z - ORIGIN.Z
	moveTo(rex, gx, gz, 0.3, yawTo(grabSpot, from.Position), rex.squatY, outQuad)
	track(0.3, function() ghost(rex) end)
	speedLines(0.35, 3)
	setCam(function(t) return look(V(-9.5, 1.1, 1.5 - t * 0.3), from.Position + Vector3.new(0.8, -1.2, 0.3), 54) end)
	hold(0.32)
	Poses.set(rex, {RightShoulder = {58, 0, -34}, RightElbow = {18}, LeftShoulder = {66, 0, 30}, LeftElbow = {24}, Waist = {-44, -10}, RightHip = {80, 0, 14}, LeftHip = {30, 0, -12}, RightKnee = {-105}, LeftKnee = {-95}, Neck = {20}})
	rex.speed = 26
	dust(grabSpot + Vector3.new(0, 0.5, 0), 2, 10)
	shake(0.6)
	say("rexydev1", "I've got you!", 1.6)
	track(0.9, function(u) kino.cf = from * CFrame.new(sin(now() * 26) * 0.07, -3.6 + sin(now() * 9) * 0.12, 0) * CFrame.Angles(rad(-10), 0, sin(now() * 20) * 0.05) shake(0.12) end) -- il résiste, la chose tire
	hold(0.95)
	-- il l'arrache du sol : les tentacules cèdent
	setCam(function(t) return look(V(-1.2, 1.6, -11), from.Position + Vector3.new(1, 0.5, 0), 56) end)
	Poses.set(rex, {RightShoulder = {150, 0, -10}, RightElbow = {40}, LeftShoulder = {140, 0, 14}, LeftElbow = {45}, Waist = {18}, RightHip = {-20}, LeftHip = {26}, RightKnee = {-24}, LeftKnee = {-40}, Neck = {-10}})
	rex.speed = 30
	moveTo(rex, -0.5, -5, 0.5, yawTo(V(-0.5, 0, -5), hole), rex.standY, outQuad)
	local sunk = kino.cf
	local land = CFrame.new(V(-3.5, kino.standY, -6)) * CFrame.Angles(0, rad(yawTo(V(-3.5, 0, -6), hole)), 0)
	track(0.55, function(u) kino.cf = sunk:Lerp(land, outQuad(u)) + Vector3.new(0, sin(u * math.pi) * 3.2, 0) end)
	for _, td in tendrils do
		sparks(td.Position + Vector3.new(0, 1.5, 0), 6)
		TweenService:Create(td, TweenInfo.new(0.35), {Size = Vector3.new(0.2, 0.3, 0.3), Transparency = 1}):Play()
		Debris:AddItem(td, 0.4)
	end
	snd("SlashSound", 0.7, 1.3)
	dust(from.Position - Vector3.new(0, 2.4, 0), 4, 24)
	shake(1)
	hold(0.6)
	Poses.set(kino, KNEEL) kino.speed = 10
	moveTo(kino, -3.5, -6, 0.25, yawTo(V(-3.5, 0, -6), hole), kino.kneelY)
	Poses.set(rex, GUARD) rex.speed = 9
	rex.look, kino.look, nono.look = hole, hole, hole
	setCam(function(t) return look(V(4.5, 1.3, -11.5 - t * 0.15), V(-2.2, 3, -5), 50) end)
	say("kinoshi112", "Something grabbed my legs...!", 2.4)
	hold(2.6)
	Poses.set(kino, STAND) kino.speed = 6
	moveTo(kino, -3.5, -6, 0.6, yawTo(V(-3.5, 0, -6), hole))
	hold(0.5)
	fireLight:SetAttribute("Base", 2.6)

	---------------- 3. la Faucheuse sort de l'obscurité
	Poses.set(rex, STAND) rex.speed, nono.speed = 9, 9
	local reaperHead = function() return R.head and R.head.Position or V(0, 18, -90) end
	for _, a in trio do a.look = reaperHead end
	setCam(function(t) local u = ease(clamp(t / 5, 0, 1)) return look(V(2.2, 5.2, 11.5), from.Position:Lerp(V(0, 12, -95), u), 50 - 12 * u) end)
	hold(1.6)
	track(3.5, function(u) R.setAlpha(1 - u) end)
	local rumble = snd("rbxasset://sounds/HalloweenThunder.wav", 0.45, 0.45)
	hold(3.6)
	R.setAlpha(0)
	walkTo(kino, -4.5, -6.5, 1.6, 0.8)
	walkTo(nono, 4.5, -6.5, 2.8, 0.9)
	local start = R.pos
	local stepTimer = 0
	track(8.5, function(u, dt)
		R.pos = start:Lerp(V(0, 12.5, -46), u)
		stepTimer += dt
		if stepTimer > 0.95 then stepTimer = 0 shake(0.35 + u * 0.4) snd("rbxasset://sounds/collide.wav", 0.35 + u * 0.3, 0.35) dust(Vector3.new(R.pos.X, ORIGIN.Y + 0.5, R.pos.Z), 4, 6) end
	end)
	setCam(function(t) return look(V(1.5, 7 + t * 0.25, -14 - t * 0.6), R.head.Position, 30) end)
	hold(1.8)
	walkTo(rex, 0, -8, 1.9, 0.8)
	hold(2.3)
	Poses.set(rex, STAND) place(rex, 0, -8, 0)
	Poses.set(kino, STAND) place(kino, -4.5, -6.5, 0)
	Poses.set(nono, STAND) place(nono, 4.5, -6.5, 0)
	setCam(function(t) return look(V(2.1, 0.45, -3.6 - t * 0.12), R.head.Position + Vector3.new(0, -3, 0), 58) end) -- contre-plongée : elle est gigantesque
	TweenService:Create(titleCard, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
	TweenService:Create(titleCard.UIStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
	hold(4.4)
	TweenService:Create(titleCard, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
	TweenService:Create(titleCard.UIStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()

	---------------- 4. les trois dégainent en même temps
	setCam(function(t) return look(headOf(rex) + Vector3.new(0.7 - t * 0.05, 0.1, -2.6), headOf(rex), 26) end)
	hold(2)
	setCam(function(t) return look(V(0.6, 1.5, -19 + t * 0.35), V(0, 3.6, -7), 48) end) -- les trois de face, la main part vers le fourreau
	for _, a in trio do a.speed = 4 Poses.set(a, REACH) end
	hold(2.2)
	for i, k in katanas do
		k.draw()
		task.delay((i - 1) * 0.06, sparks, k.tip(), 12)
	end
	snd("rbxasset://sounds/unsheath.wav", 0.95, 0.85)
	snd("rbxasset://sounds/unsheath.wav", 0.7, 1.05)
	for _, a in trio do a.speed = 3.4 Poses.set(a, DRAWN) end
	whiteFlash(0.35)
	music:Stop()
	music.SoundId, music.Volume, music.Looped = "rbxassetid://" .. MUSIC_FIGHT, 0.55, true
	music:Play()
	hold(0.7)
	setCam(function(t) return look(katana.blade.Position + Vector3.new(1.5, 0.3, -1.4 + t * 0.2), katana.blade.Position, 30) end)
	hold(1.3)
	for _, a in trio do a.speed = 12 Poses.set(a, GUARD) end
	setCam(function(t) return look(V(15 - t * 0.5, 2.4, -20), V(0, 6, -27), 62) end)
	hold(1.5)

	---------------- 5. chacun part de son côté, puis tous foncent sur elle
	for _, k in katanas do k.trail.Enabled = true end
	local hero, heroKatana = rex, katana -- celui qui attaque en ce moment
	local function dash(x, z, yaw, y, duration)
		local a, steps = hero, 0
		moveTo(a, x, z, duration, yaw, y, outQuad)
		track(duration, function() steps += 1 if steps % 2 == 0 then ghost(a) end end)
		blur.Size = 14
		speedLines(duration + 0.12, 3)
		TweenService:Create(blur, TweenInfo.new(duration + 0.2), {Size = 0}):Play()
	end
	-- kinoshi112 à gauche, Nono275er à droite, Rex au centre
	setCam(function(t) return look(V(0, 15 - t * 2, 1 - t * 3), V(0, 3, -24), 60) end)
	for _, a in trio do a.speed = 16 end
	walkTo(kino, -15, -30, 1.25, 1, true)
	walkTo(nono, 15, -30, 1.25, 1, true)
	walkTo(rex, 0, -17, 1.0, 1, true)
	snd("rbxasset://sounds/action_footsteps_plastic.mp3", 0.7, 1.5)
	hold(1.0)
	Poses.set(rex, DASH) rex.speed = 30
	setCam(function(t) local p = rex.cf.Position return look(p + Vector3.new(11, 1.5, 3), p + Vector3.new(0, 1, -4), 74 - clamp(t, 0, 0.5) * 16) end)
	snd("rbxasset://sounds/swordlunge.wav", 0.9, 1.3)
	dash(0, -37.5, 0, nil, 0.4)
	hold(0.4)
	local function strike(theta, kind, block, opts)
		opts = opts or {}
		local a, k = opts.who or rex, opts.blade or katana
		hero, heroKatana = a, k
		local center = Vector3.new(R.pos.X, ORIGIN.Y, R.pos.Z)
		local ang = rad(theta)
		local spot = center + Vector3.new(sin(ang) * 8.5, 0, cos(ang) * 8.5)
		local y = (opts.low and a.squatY or a.standY) + (opts.y or 0)
		Poses.set(a, WIND[kind]) a.speed = 34
		dash(spot.X - ORIGIN.X, spot.Z - ORIGIN.Z, yawTo(spot, center), y, opts.fast and 0.09 or 0.14)
		hold(opts.fast and 0.09 or 0.14)
		Poses.set(a, HIT[kind]) a.speed = 48
		R.pose, R.speed, R.turn = R_BLOCK[block], 24, opts.turn or 5
		R.yawT = yawTo(center, spot)
		hold(0.05)
		local contact = k.tip():Lerp(R.blade, 0.25)
		slashArc(a.cf * CFrame.new(0, 0.8, 0), opts.fast and 4 or 5.5, k == kinoKatana and rgb(255, 150, 150) or k == nonoKatana and rgb(170, 255, 190) or nil)
		sparks(contact, opts.fast and 12 or 26)
		ring(contact, opts.fast and 3 or 6, rgb(255, 235, 190), 0.3)
		snd("SlashSound", opts.fast and 0.45 or 0.8, rng:NextNumber(0.9, 1.25))
		shake(opts.fast and 0.25 or 0.6)
		hold(opts.hold or 0.42)
		hero, heroKatana = rex, katana
	end
	local K, N = {who = kino, blade = kinoKatana}, {who = nono, blade = nonoKatana}
	local function with(base, extra) local o = table.clone(base) for key, v in extra or {} do o[key] = v end return o end
	local function orbitCam(radius, height, speed, fov)
		local a0 = rng:NextNumber(0, 6)
		setCam(function(t) local c = Vector3.new(R.pos.X, ORIGIN.Y + 7, R.pos.Z) local a = a0 + t * speed return look(c + Vector3.new(sin(a) * radius, height - 7, cos(a) * radius), c, fov) end)
	end
	local function followCam(fov)
		setCam(function() local p = rex.cf.Position local away = (p - R.pos) * Vector3.new(1, 0, 1) return look(p + away.Unit * 7 + Vector3.new(2.5, 2.2, 0), R.head.Position + Vector3.new(0, -5, 0), fov or 66) end)
	end
	local function bladeCam()
		setCam(function() local b = katana.blade.Position return look(b + (b - R.pos).Unit * 4 + Vector3.new(1.2, 0.6, 0), b:Lerp(R.blade, 0.4), 40) end)
	end
	-- trois attaques presque en même temps : gauche, droite, puis Rex par le haut
	orbitCam(26, 7, 0.45, 62)
	strike(-90, "right", "left", with(K, {hold = 0.12}))
	strike(90, "left", "right", with(N, {hold = 0.12}))
	strike(0, "high", "high", {y = 9, hold = 0.45})
	followCam()
	strike(180, "left", "right", with(K, {turn = 9, hold = 0.2}))
	strike(-40, "low", "low", {low = true})
	strike(120, "right", "left", with(N, {hold = 0.3}))
	bladeCam()
	strike(20, "high", "high", {y = 9, hold = 0.5})
	setCam(function() return look(V(R.pos.X - ORIGIN.X + 14, 0.8, R.pos.Z - ORIGIN.Z + 14), V(0, 5, -44), 64) end)
	strike(-130, "low", "low", with(K, {low = true, hold = 0.25}))
	strike(60, "high", "high", with(N, {y = 8, hold = 0.3}))
	orbitCam(18, 4, 1.5, 68)
	local kinds = {"right", "left", "high", "low"}
	for i = 1, 18 do -- rafale à trois : ils tournent autour d'elle, elle pare tout sans reculer
		local kind = kinds[i % 4 + 1]
		local who = i % 3 == 0 and K or (i % 3 == 1 and N or {})
		strike(i * 47, kind, ({right = "right", left = "left", high = "high", low = "low"})[kind], with(who, {fast = true, hold = 0.06, y = kind == "high" and 7 or 0, low = kind == "low", turn = 12}))
	end
	followCam(58)
	strike(0, "high", "high", {y = 10, hold = 0.3})
	-- elle en a assez : un grand coup de faux circulaire balaie kinoshi112 et Nono275er
	R.pose, R.speed, R.turn = R_WIND, 14, 6
	setCam(function(t) return look(V(3, 3.2, -14 + t * 0.4), V(0, 9, -44), 58) end)
	Poses.set(kino, GUARD) Poses.set(nono, GUARD) Poses.set(rex, GUARD)
	moveTo(kino, -8, -40, 0.3, yawTo(V(-8, 0, -40), R.pos))
	moveTo(nono, 8, -40, 0.3, yawTo(V(8, 0, -40), R.pos))
	moveTo(rex, 0, -37, 0.3, 0)
	hold(0.5)
	R.pose, R.speed = R_STRIKE, 34
	R.yawT = R.yaw + 359
	R.turn = 9
	hold(0.14)
	local sweep = Vector3.new(R.pos.X, ORIGIN.Y + 2.5, R.pos.Z)
	ring(sweep, 30, rgb(200, 130, 255), 0.55)
	ring(sweep, 20, rgb(255, 255, 255), 0.4)
	snd("BoomSound", 0.9, 0.9)
	snd("SlashSound", 1, 0.6)
	whiteFlash(0.2)
	shake(1.8)
	for _, pair in {{kino, kinoKatana, -9, -5}, {nono, nonoKatana, 9, -5}} do
		local a = pair[1]
		Poses.set(a, GRABBED) a.speed = 30
		local start, goal = a.cf, CFrame.new(V(pair[3], a.kneelY, pair[4])) * CFrame.Angles(0, rad(yawTo(V(pair[3], 0, pair[4]), R.pos)), 0)
		track(0.75, function(u) a.cf = start:Lerp(goal, outQuad(u)) * CFrame.Angles(rad(-40 * (1 - u)), 0, 0) + Vector3.new(0, sin(u * math.pi) * 7, 0) if u < 0.9 then ghost(a) end end)
		task.delay(0.75, function() Poses.set(a, KNEEL) a.speed = 10 dust(a.cf.Position - Vector3.new(0, 2, 0), 3, 14) pair[2].trail.Enabled = false end)
	end
	Poses.set(rex, BLOCK) rex.speed = 30
	hold(0.85)
	R.yawT, R.yaw = 180, 180
	setCam(function(t) return look(V(0, 2, 3.5), V(0, 3, -6), 56) end)
	say("kinoshi112", "It's too strong...", 2)
	hold(1.6)
	kino.look, nono.look = function() return headOf(rex) end, function() return headOf(rex) end

	---------------- 6. à bout de souffle
	R.pose, R.speed, R.turn, R.yawT = R_IDLE, 3, 2, 180
	Poses.set(rex, GUARD) rex.speed = 14
	dash(0, -22, 0, nil, 0.35)
	setCam(function(t) return look(V(8, 2, -15 + t * 0.2), V(0, 3.5, -25), 56) end)
	hold(0.6)
	TweenService:Create(music, TweenInfo.new(1.2), {Volume = 0.22}):Play()
	katana.trail.Enabled = false
	Poses.set(rex, KNEEL) rex.speed = 6
	moveTo(rex, 0, -22, 0.5, 0, rex.kneelY)
	snd("rbxasset://sounds/collide.wav", 0.3, 1.6)
	track(7.2, function() Poses.patch(rex, {Waist = {-20 + sin(now() * 5.5) * 5}, Neck = {-16 + sin(now() * 5.5) * 4}}) end) -- il respire fort
	hold(1.2)
	setCam(function(t) return look(rex.cf.Position + Vector3.new(3.2 - t * 0.2, 0.6, -3.6), headOf(rex) + Vector3.new(0, -0.5, 0), 34) end)
	hold(2.2)
	setCam(function(t) return look(R.head.Position + Vector3.new(0.8, -0.6, 9 - t * 0.5), R.head.Position, 24) end)
	hold(2)
	setCam(function(t) return look(headOf(rex) + Vector3.new(0.25, 0.25, -2.1 + t * 0.12), headOf(rex) + Vector3.new(0, 0.2, 0), 15) end)
	hold(1.5)

	---------------- 7. la contre-attaque
	TweenService:Create(music, TweenInfo.new(0.5), {Volume = 0.6}):Play()
	snd("rbxasset://sounds/HalloweenGhost.wav", 0.6, 1.5)
	dust(Vector3.new(R.pos.X, ORIGIN.Y + 2, R.pos.Z), 6, 20)
	track(0.25, function(u) R.setAlpha(u) end)
	local function duelCam(side, height, dist, fov) -- plan large de profil : on voit les deux, la faux qui s'abat et le recul de Rex
		setCam(function(t)
			local mid = rex.cf.Position:Lerp(Vector3.new(R.pos.X, ORIGIN.Y + 6, R.pos.Z), 0.45)
			return look(Vector3.new(mid.X + side * dist, ORIGIN.Y + height, mid.Z + 5 - t * 0.6), mid + Vector3.new(0, 1.5, 0), fov)
		end)
	end
	duelCam(1, 5, 27, 60)
	hold(0.45)
	local function reaperStrike(zReaper, zRex)
		R.pos, R.yaw, R.yawT = V(0, 12.5, zReaper), 180, 180
		dust(V(0, 2, zReaper), 6, 16)
		R.setAlpha(0)
		R.pose, R.speed = R_WIND, 16
		Poses.set(rex, BLOCK) rex.speed = 26
		moveTo(rex, 0, rex.cf.Position.Z - ORIGIN.Z, 0.15, 0)
		hold(0.34)
		R.pose, R.speed = R_STRIKE, 34
		hold(0.11)
		local contact = katana.blade.Position + Vector3.new(0, 1.2, -0.6)
		sparks(contact, 46)
		ring(contact, 13, rgb(200, 150, 255), 0.45)
		snd("BoomSound", 0.75, 1.15)
		snd("SlashSound", 0.9, 0.7)
		shake(1.5)
		whiteFlash(0.18)
		moveTo(rex, 0, zRex, 0.55, 0, nil, outQuad)
		track(0.55, function() dust(rex.cf.Position - Vector3.new(0, 2.6, 0), 1.6, 2) end)
		hold(0.85)
	end
	reaperStrike(-33, -11)
	duelCam(-1, 3, 24, 62)
	track(0.5, function(u) R.pos = V(0, 12.5, -33 + 11 * ease(u)) end)
	hold(0.5)
	reaperStrike(-22, -4.5)
	-- troisième coup : il se baisse, passe sous la lame et frappe
	duelCam(1, 2.2, 21, 60)
	track(0.45, function(u) R.pos = V(0, 12.5, -22 + 6.5 * ease(u)) end)
	R.pose, R.speed = R_WIND, 16
	hold(0.45)
	R.pose, R.speed = R_STRIKE, 34
	Poses.set(rex, WIND.low) rex.speed = 40
	katana.trail.Enabled = true
	dash(1.2, -10.5, 0, rex.squatY, 0.16)
	hold(0.2)
	Poses.set(rex, HIT.high) rex.speed = 50
	moveTo(rex, 0.6, -12.5, 0.12, 0, rex.standY + 3.5, outQuad)
	hold(0.1)
	sparks(katana.tip(), 50)
	ring(katana.tip(), 12, rgb(160, 220, 255), 0.4)
	snd("SlashSound", 1, 0.8)
	snd("BoomSound", 0.7, 1)
	whiteFlash(0.25)
	shake(1.3)
	R.pose, R.speed = R_FALL, 5
	local fallFrom = R.pos
	track(0.9, function(u) R.pos = fallFrom:Lerp(V(0, 4.6, -18), u * u) end)
	moveTo(rex, 4.5, -8, 0.45, yawTo(V(4.5, 0, -8), V(0, 0, -16)))
	Poses.set(rex, GUARD)
	setCam(function(t) return look(V(8.5, 0.6, -3 - t * 0.15), V(0, 2.2, -11), 52) end)
	hold(0.9)
	snd("BoomSound", 0.9, 0.7)
	shake(2)
	dust(V(0, 1, -11), 7, 30)
	hold(1.4)
	setCam(function(t) return look(V(10.5, 0.7, -2.5), rex.cf.Position + Vector3.new(0, 1, 0), 56) end)
	Poses.set(rex, LANDED) rex.speed = 12
	rex.look = nil
	moveTo(rex, 4.5, -8, 0.35, yawTo(V(4.5, 0, -8), V(0, 0, -16)), rex.squatY)
	hold(0.6)
	Poses.set(rex, DIVE) rex.speed = 30
	local liftFrom, over = rex.cf.Position, V(0, 34, -17)
	local steps = 0
	track(1.5, function(u)
		-- arc par-dessus elle avec un salto, puis il monte tout droit de plus en plus vite
		local p = u < 0.45 and liftFrom:Lerp(over, outQuad(u / 0.45)) + Vector3.new(0, sin(u / 0.45 * math.pi) * 6, 0) or over + Vector3.new(0, ((u - 0.45) / 0.55) ^ 2 * 190, 0)
		rex.cf = CFrame.new(p) * CFrame.Angles(0, rad(yawTo(liftFrom, over)), 0) * CFrame.Angles(rad(u < 0.45 and -360 * (u / 0.45) or 20), 0, 0)
		steps += 1
		if steps % 2 == 0 then ghost(rex) end
	end)
	setCam(function(t) local p = rex.cf.Position return look(p + Vector3.new(9 - t * 2, -5 - t * 3, 11), p + Vector3.new(0, 1.5, 0), 62 + clamp(t, 0, 1.5) * 10) end) -- la caméra le suit
	ring(V(4.5, 0.3, -8), 15, rgb(220, 235, 255), 0.5)
	dust(V(4.5, 1, -8), 4, 26)
	snd("rbxasset://sounds/swordlunge.wav", 0.9, 0.7)
	snd("BoomSound", 0.5, 1.5)
	shake(1.3)
	speedLines(1.5, 3)
	task.delay(0.68, function() ring(over, 16, rgb(215, 235, 255), 0.45) slashArc(CFrame.new(over), 7) snd("rbxasset://sounds/swordlunge.wav", 0.8, 1.2) end)
	hold(1.15)

	---------------- 8. il tombe du ciel
	fade.BackgroundTransparency = 0
	TweenService:Create(music, TweenInfo.new(0.3), {Volume = 0}):Play()
	hold(0.35)
	fade.BackgroundTransparency = 1
	Poses.set(rex, DIVE, true) rex.speed = 20
	local target = V(0, 0, -15)
	local top = target + Vector3.new(0, 250, 0)
	rex.cf = CFrame.new(top) * CFrame.Angles(rad(-150), 0, 0)
	local falling = snd("rbxasset://sounds/Rocket shot.wav", 0.25, 0.5)
	task.delay(1.2, speedLines, 3.2, 2)
	katana.trail.Enabled, katana.trail.Lifetime = true, 0.6
	local cutTimer = 0
	track(3.4, function(u, dt) -- il fend l'air : anneaux qu'il traverse, croissants de lame, images fantômes
		rex.cf = CFrame.new(top:Lerp(target + Vector3.new(0, 34, 0), u * u)) * CFrame.Angles(rad(-150), 0, 0)
		cutTimer += dt
		if cutTimer > 0.16 and u > 0.25 then
			cutTimer = 0
			ring(rex.cf.Position, 5 + u * 9, rgb(215, 238, 255), 0.35)
			slashArc(CFrame.new(rex.cf.Position) * CFrame.Angles(rad(90), 0, 0), 4 + u * 4)
			ghost(rex)
		end
	end)
	setCam(function(t) local u = clamp(t / 3.4, 0, 1) return look(V(6, 1.1, -4), rex.cf.Position, 70 - 54 * ease(u)) end)
	hold(3.4)
	track(1.0, function(u) rex.cf = CFrame.new(target + Vector3.new(0, 34 - 5 * u, 0)) * CFrame.Angles(rad(-150), 0, 0) end) -- ralenti sur ses yeux
	setCam(function() local h = rex.rig.Head.CFrame return look((h * CFrame.new(0.15, 0.1, -2.3)).Position, h.Position + Vector3.new(0, 0.1, 0), 17) end)
	hold(1.0)
	setCam(function(t) return look(V(21, 4.5, 2), V(0, 4, -15), 62) end)
	Poses.set(rex, HIT.high) rex.speed = 60
	local dropFrom = rex.cf.Position
	track(0.12, function(u) rex.cf = CFrame.new(dropFrom:Lerp(target + Vector3.new(0, rex.squatY, 0), u)) ghost(rex) end)
	hold(0.12)
	Poses.set(rex, LANDED)
	place(rex, 0, -15, 0, rex.squatY)
	whiteFlash(1.1)
	snd("BoomSound", 1, 0.55)
	snd("rbxasset://sounds/HalloweenThunder.wav", 0.8, 1)
	shake(3.2)
	for i = 1, 3 do task.delay(i * 0.12, ring, target + Vector3.new(0, 0.4, 0), 26 + i * 16, rgb(215, 235, 255), 0.9) end
	dust(target + Vector3.new(0, 1.5, 0), 9, 46)
	for i = 1, 14 do -- fissures dans le sol + bord du cratère
		local a = i / 14 * math.pi * 2 + rng:NextNumber(-0.2, 0.2)
		local len = rng:NextNumber(7, 17)
		P({Size = Vector3.new(0.5, 0.12, len), CFrame = CFrame.new(target + Vector3.new(sin(a) * len / 2, 0.08, cos(a) * len / 2)) * CFrame.Angles(0, a + rng:NextNumber(-0.15, 0.15), 0), Color = rgb(6, 5, 8)})
		P({Size = Vector3.new(rng:NextNumber(1.5, 3), rng:NextNumber(0.8, 1.8), rng:NextNumber(1.5, 3)), CFrame = CFrame.new(target + Vector3.new(sin(a) * 7.5, 0.3, cos(a) * 7.5)) * CFrame.Angles(rng:NextNumber(-0.6, 0.6), a, rng:NextNumber(-0.6, 0.6)), Color = rgb(60, 52, 46), Material = Enum.Material.Slate})
	end
	for _ = 1, 22 do -- débris projetés
		local d = P({Size = Vector3.one * rng:NextNumber(0.4, 1.2), Position = target + Vector3.new(rng:NextNumber(-3, 3), 1, rng:NextNumber(-3, 3)), Color = rgb(64, 54, 46), Material = Enum.Material.Slate, Anchored = false})
		d.AssemblyLinearVelocity = Vector3.new(rng:NextNumber(-40, 40), rng:NextNumber(40, 85), rng:NextNumber(-40, 40))
		d.AssemblyAngularVelocity = Vector3.new(rng:NextNumber(-9, 9), rng:NextNumber(-9, 9), rng:NextNumber(-9, 9))
		Debris:AddItem(d, 3.5)
	end
	local cut = P({Size = Vector3.new(0.35, 60, 0.35), Position = target + Vector3.new(0, 14, 0), Color = rgb(235, 245, 255), Material = Enum.Material.Neon}) -- trait de coupe
	TweenService:Create(cut, TweenInfo.new(0.7), {Size = Vector3.new(0.02, 60, 0.02), Transparency = 1}):Play()
	R.die()
	falling:Stop()
	hold(2.2)

	---------------- 9. le silence, puis « on rentre »
	katana.trail.Enabled = false
	rex.speed = 3
	Poses.set(rex, STAND)
	moveTo(rex, 0, -15, 1.4, 20)
	rex.look = nil
	for _, pair in {{kino, kinoKatana, -9}, {nono, nonoKatana, 9}} do
		local a = pair[1]
		a.speed = 4
		Poses.set(a, STAND)
		moveTo(a, pair[3], -5, 1, yawTo(V(pair[3], 0, -5), V(0, 0, -15)))
		task.delay(2.5, function() Poses.set(a, REACH) end)
		task.delay(4.4, function() pair[2].sheath() Poses.set(a, STAND) end)
	end
	setCam(function(t) return look(V(11 - t * 0.4, 3.2, -4), V(0, 3.4, -15), 50) end)
	hold(4)
	local camSpot = V(3.1, 5.1, -11.6)
	setCam(function(t) return look(camSpot:Lerp(V(2.3, 5.05, -12.6), ease(clamp(t / 3, 0, 1))), headOf(rex), 26) end)
	Poses.patch(rex, {Neck = {0, -60, 0}, Waist = {0, -18, 0}}) -- il tourne la tête et regarde la caméra
	hold(3.2)
	Poses.set(rex, DRAWN) rex.speed = 8 -- il lève la lame une dernière fois, puis la plante (il ne la rengaine plus avant)
	setCam(function(t) return look(V(6.5, 2.2, -21), V(0.6, 2.6, -15), 48) end)
	slashArc(rex.cf * CFrame.new(0, 1, 0), 4)
	snd("rbxasset://sounds/swordlunge.wav", 0.6, 1.4)
	hold(0.7)
	Poses.set(rex, {RightShoulder = {35, 0, 30}, RightElbow = {10}, LeftShoulder = {4, 0, -5}, Waist = {-8, -10}})
	hold(0.35)
	-- planté dans le sol à côté de lui : la pointe s'enfonce dans la terre, un petit tas de terre et des fissures autour
	local plantAt = rex.cf.Position * Vector3.new(1, 0, 1) + Vector3.new(2.1, ORIGIN.Y, -0.5)
	katana.plant(CFrame.new(plantAt + Vector3.new(0, 3.45, 0)) * CFrame.Angles(rad(180), 0, rad(9)))
	for i = 1, 6 do
		local a = i / 6 * math.pi * 2
		P({Size = Vector3.new(0.7, 0.35, 0.6), CFrame = CFrame.new(plantAt + Vector3.new(sin(a) * 0.45, 0.12, cos(a) * 0.45)) * CFrame.Angles(0.3, a, 0.2), Color = rgb(52, 42, 34), Material = Enum.Material.Ground})
		P({Size = Vector3.new(0.14, 0.06, 1.6), CFrame = CFrame.new(plantAt + Vector3.new(sin(a) * 1.1, 0.05, cos(a) * 1.1)) * CFrame.Angles(0, a, 0), Color = rgb(6, 5, 8)})
	end
	dust(plantAt + Vector3.new(0, 0.5, 0), 1.5, 8)
	workspace:SetAttribute("ReaperKatanaPlanted", os.clock())
	sparks(V(1.9, 0.3, -15.4), 16)
	snd("rbxasset://sounds/collide.wav", 0.6, 1.3)
	shake(0.3)
	Poses.set(rex, STAND) rex.speed = 4
	hold(1.4)
	moveTo(rex, 0, -15, 1, yawTo(V(0, 0, -15), hole) )
	setCam(function(t) return look(V(4.5, 2.6, -27 + t * 0.2), V(0, 3, 0), 44) end) -- le feu de camp brille encore au loin
	hold(1.8)
	say("rexydev1", "Let's go home.", 2.6)
	hold(2.8)
	local watcher = {}
	local wp = V(-21, 0, -1)
	table.insert(watcher, P({Size = Vector3.new(1.8, 4.2, 1.2), Position = wp + Vector3.new(0, 2.1, 0), Color = rgb(4, 4, 6)}))
	table.insert(watcher, P({Size = Vector3.new(1.7, 1.6, 1.6), Position = wp + Vector3.new(0, 4.9, 0), Color = rgb(4, 4, 6)}))
	local eyes = {}
	for _, s in {0.3, -0.3} do table.insert(eyes, P({Shape = Enum.PartType.Ball, Size = Vector3.one * 0.24, Position = wp + Vector3.new(s, 5, -0.82), Color = rgb(255, 40, 40), Material = Enum.Material.Neon, Transparency = 1})) end
	walkTo(rex, -4.5, 3, 6, 0.75) -- il rentre vers le feu de camp, à allure normale
	setCam(function(t) return look(V(1.2, 3.2, -27 + t * 0.35), V(-3 - t * 1.2, 3.4, -4), 46 - t * 1.5) end)
	hold(2.6)
	for _, e in eyes do TweenService:Create(e, TweenInfo.new(0.5), {Transparency = 0}):Play() end
	snd("rbxasset://sounds/HalloweenGhost.wav", 0.5, 0.6)
	hold(1.7)
	fade.BackgroundTransparency = 0 -- coupure nette au noir
	music:Stop()
	hold(1.8)

	---------------- remise en état
	frame:Disconnect()
	music:Destroy() wind:Destroy() rumble:Destroy()
	camFn, reaper, fireLight = nil, nil, nil
	table.clear(tracks) table.clear(actors)
	scene:Destroy()
	atmosphere:Destroy() grade:Destroy() blur:Destroy()
	for prop, value in savedLighting do Lighting[prop] = value end
	for a in hiddenAtmospheres do a.Parent = Lighting end
	for g in hiddenGuis do if g.Parent then g.Enabled = true end end
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
	game:GetService("ContextActionService"):UnbindAction("ReaperCutsceneFreeze")
	camera.CameraType, camera.FieldOfView = oldType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or oldType, oldFov
	TweenService:Create(fade, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	task.wait(1.1)
	gui:Destroy()
end

folder:WaitForChild("Play").OnClientEvent:Connect(function()
	if playing then return end
	playing = true
	local ok, err = pcall(run)
	if not ok then
		warn("[ReaperCutscene] " .. tostring(err))
		-- en cas d'erreur, on rend la main au joueur
		local camera = workspace.CurrentCamera
		camera.CameraType = Enum.CameraType.Custom
		if scene then scene:Destroy() end
		if gui then gui:Destroy() end
		for _, effect in effects do effect:Destroy() end
		for prop, value in savedLighting do Lighting[prop] = value end
		for a in hiddenAtmospheres do a.Parent = Lighting end
		table.clear(tracks) table.clear(actors)
		camFn, reaper, fireLight = nil, nil, nil
		pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
		for g in hiddenGuis do if g.Parent then g.Enabled = true end end
		game:GetService("ContextActionService"):UnbindAction("ReaperCutsceneFreeze")
	end
	playing = false
end)
