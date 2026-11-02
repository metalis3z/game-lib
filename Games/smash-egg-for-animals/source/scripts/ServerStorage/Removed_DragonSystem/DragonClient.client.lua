-- Dragons à chevaucher, côté joueur :
--   1) anime tous les dragons (pattes, ailes, cou, tête, mâchoire, queue) et leurs effets d'air ;
--   2) pilote le dragon du joueur : se déplacer, ESPACE maintenu = monter (tant qu'il reste de l'endurance),
--      relâché = redescendre. Feu : clic gauche (PC), toucher l'écran (mobile), R2 (manette) ou F. On ne descend jamais de son dragon.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local dragonSystem = ReplicatedStorage:WaitForChild("DragonSystem")
local action = dragonSystem:WaitForChild("DragonAction")
local UpgradeConfig = require(dragonSystem:WaitForChild("UpgradeConfig")) -- endurance et vitesse améliorables
local DragonConfig = require(dragonSystem:WaitForChild("DragonConfig"))   -- bonus d'endurance du dragon équipé

local TAG = "RideDragon"
local rad, sin, cos, clamp, max, min = math.rad, math.sin, math.cos, math.clamp, math.max, math.min

---------------------------------------------------------------- réglages
local TURN_SPEED = rad(475)          -- vitesse de virage maximale : un demi-tour prend un peu moins d'une demi-seconde
local BASE_FOV = 70
local LEG_SWING = rad(34)
local WING_REST, WINGTIP_REST = rad(16), rad(-18)   -- au sol : ailes relevées, bout légèrement replié
local FLAP, FLAP_TIP = rad(42), rad(34)
local JAW_FIRE, JAW_YAWN = rad(34), rad(18)
local YAWN_EVERY, YAWN_TIME = 7, 0.9
local GROUND_TURN = 2.25                               -- au sol, le dragon tourne 1,5 fois plus vite qu'en vol
local LOOK_YAW, LOOK_PITCH = rad(70), rad(32)        -- jusqu'où la tête suit le regard du cavalier
local SMOKE_TEXTURE = "rbxasset://textures/particles/smoke_main.dds"
local SPARK_TEXTURE = "rbxasset://textures/particles/sparkles_main.dds"
local STUD_TEXTURE = "rbxassetid://7447638591"
local INK = Color3.fromRGB(36, 23, 51)

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
-- hauteur du sol sous un point ; on part d'un peu plus haut pour retrouver le sol même si on s'est enfoncé dedans
local function groundBelow(position, lift)
	-- les œufs des zones sont des obstacles solides, pas du sol : le dragon bute dessus au lieu de grimper
	local ignore = {workspace:FindFirstChild("Dragons"), workspace:FindFirstChild("ZoneEggs"), workspace:FindFirstChild("DragonVfx")}
	for _, p in Players:GetPlayers() do
		if p.Character then table.insert(ignore, p.Character) end
	end
	rayParams.FilterDescendantsInstances = ignore
	local hit = workspace:Raycast(position + Vector3.new(0, lift or 0, 0), Vector3.new(0, -2000, 0), rayParams)
	return hit and hit.Position.Y or nil
end

local function seq(...)
	local points = {}
	for _, p in {...} do table.insert(points, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(points)
end

---------------------------------------------------------------- 1) animation et effets de tous les dragons
local TRAIL_STRONG = seq({0, 0.35}, {0.5, 0.7}, {1, 1})   -- pendant le battement vers le bas : un large ruban d'air
local TRAIL_SOFT = seq({0, 0.82}, {1, 1})

local dragons = {} -- [model] = état

-- point le plus éloigné parmi les pièces soudées à une articulation (dans le repère de cette articulation)
local function farthestPoint(model, jointPart)
	local farthest, best = nil, 0
	for _, d in model:GetChildren() do
		local wc = d:IsA("BasePart") and d:FindFirstChildOfClass("WeldConstraint")
		if wc and wc.Part0 == jointPart then
			local offset = jointPart.CFrame:PointToObjectSpace(d.Position)
			if offset.Magnitude > best then farthest, best = offset, offset.Magnitude end
		end
	end
	return farthest
end

local function track(model)
	task.spawn(function()
		local root = model.PrimaryPart or model:WaitForChild("Root", 10)
		if not root or dragons[model] then return end
		task.wait(0.2) -- laisse le temps aux pièces d'arriver
		local height = model:GetAttribute("Height") or 2.5
		local scale = height / 2.5
		local fx = scale ^ 0.65
		local joints, tips = {}, {}
		for _, d in model:GetDescendants() do
			if d:IsA("Weld") and d:GetAttribute("Anim") then
				table.insert(joints, {
					Weld = d, Base = d.C0, Kind = d:GetAttribute("Anim"),
					Phase = d:GetAttribute("Phase") or 0, Side = d:GetAttribute("Side") or 1,
					Front = d.Part0 == root and d.C0.Position.Z > 0,
					SideX = d.C0.Position.X >= 0 and 1 or -1,
				})
			end
		end
		-- ailes : un large ruban d'air doux derrière chaque aile, des volutes et des éclats aux couleurs du dragon à chaque battement
		local accent = model:GetAttribute("Fire2") or Color3.fromRGB(255, 190, 90)
		local bright = model:GetAttribute("Fire1") or Color3.fromRGB(255, 240, 180)
		for _, j in joints do
			if j.Kind == "WingTip" then
				local part = j.Weld.Part1
				local far = farthestPoint(model, part)
				if far then
					-- le ruban va du bout de l'aile jusqu'à son articulation : une vraie surface d'air, pas un trait
					local a0 = Instance.new("Attachment")
					a0.Position = far
					a0.Parent = part
					local a1 = Instance.new("Attachment")
					a1.Position = Vector3.new(-far.X * 0.9, 0, far.Z * 0.3)
					a1.Parent = part
					local trail = Instance.new("Trail")
					trail.Attachment0, trail.Attachment1 = a0, a1
					trail.Texture = SMOKE_TEXTURE
					trail.TextureMode = Enum.TextureMode.Stretch
					trail.TextureLength = 1
					trail.Lifetime = 0.42
					trail.MinLength = 0.05
					trail.LightEmission = 0.35
					trail.LightInfluence = 0.4
					trail.Color = ColorSequence.new(Color3.new(1, 1, 1), accent:Lerp(Color3.new(1, 1, 1), 0.55))
					trail.Transparency = TRAIL_SOFT
					trail.WidthScale = seq({0, 1}, {1, 0.35})
					trail.Enabled = false
					trail.Parent = part
					-- volutes d'air qui tournent
					local gust = Instance.new("ParticleEmitter")
					gust.Texture = SMOKE_TEXTURE
					gust.Enabled = false
					gust.Lifetime = NumberRange.new(0.45, 0.8)
					gust.Speed = NumberRange.new(7 * fx, 16 * fx)
					gust.SpreadAngle = Vector2.new(50, 50)
					gust.EmissionDirection = Enum.NormalId.Bottom
					gust.Size = seq({0, 1.2 * fx}, {0.4, 3.4 * fx}, {1, 5 * fx})
					gust.Transparency = seq({0, 0.5}, {0.5, 0.75}, {1, 1})
					gust.Color = ColorSequence.new(Color3.new(1, 1, 1), accent:Lerp(Color3.new(1, 1, 1), 0.7))
					gust.Rotation = NumberRange.new(0, 360)
					gust.RotSpeed = NumberRange.new(-220, 220)
					gust.Drag = 3.5
					gust.Parent = a0
					-- éclats lumineux de la couleur du dragon
					local sparks = Instance.new("ParticleEmitter")
					sparks.Texture = SPARK_TEXTURE
					sparks.Enabled = false
					sparks.Lifetime = NumberRange.new(0.5, 1.0)
					sparks.Speed = NumberRange.new(6 * fx, 16 * fx)
					sparks.SpreadAngle = Vector2.new(70, 70)
					sparks.EmissionDirection = Enum.NormalId.Bottom
					sparks.Size = seq({0, 0.55 * fx}, {1, 0})
					sparks.Color = ColorSequence.new(bright, accent)
					sparks.LightEmission = 1
					sparks.Rotation = NumberRange.new(0, 360)
					sparks.RotSpeed = NumberRange.new(-180, 180)
					sparks.Drag = 2
					sparks.Acceleration = Vector3.new(0, -6 * fx, 0)
					sparks.Parent = a0
					table.insert(tips, {Trail = trail, Gust = gust, Sparks = sparks})
				end
			end
		end
		-- poussière au décollage et à l'atterrissage
		local dustAttachment = Instance.new("Attachment")
		dustAttachment.Position = Vector3.new(0, -(model:GetAttribute("GroundOffset") or 1), 0)
		dustAttachment.Parent = root
		local dust = Instance.new("ParticleEmitter")
		dust.Texture = SMOKE_TEXTURE
		dust.Enabled = false
		dust.Lifetime = NumberRange.new(0.7, 1.2)
		dust.Speed = NumberRange.new(6 * fx, 12 * fx)
		dust.SpreadAngle = Vector2.new(180, 20)
		dust.EmissionDirection = Enum.NormalId.Right
		dust.Size = seq({0, 1 * fx}, {1, 4 * fx})
		dust.Transparency = seq({0, 0.5}, {1, 1})
		dust.Color = ColorSequence.new(Color3.fromRGB(210, 200, 180))
		dust.Drag = 3
		dust.Parent = dustAttachment
		-- filets d'air le long du corps à grande vitesse
		local streamAttachment = Instance.new("Attachment")
		streamAttachment.Position = Vector3.new(0, 0.5 * scale, 0)
		streamAttachment.Parent = root
		local stream = Instance.new("ParticleEmitter")
		stream.Texture = SMOKE_TEXTURE
		stream.Rate = 0
		stream.Lifetime = NumberRange.new(0.25, 0.4)
		stream.Speed = NumberRange.new(40 * scale ^ 0.5, 60 * scale ^ 0.5)
		stream.SpreadAngle = Vector2.new(8, 8)
		stream.EmissionDirection = Enum.NormalId.Front -- le Root regarde vers +Z : "Front" (-Z) part vers l'arrière du dragon
		stream.Orientation = Enum.ParticleOrientation.VelocityParallel
		stream.Squash = NumberSequence.new(2.6)
		stream.Size = seq({0, 0.4 * fx}, {1, 0.1})
		stream.Transparency = seq({0, 0.55}, {1, 1})
		stream.Color = ColorSequence.new(Color3.fromRGB(235, 245, 255))
		stream.Parent = streamAttachment

		dragons[model] = {
			Root = root, Joints = joints, Scale = scale, Dust = dust, Tips = tips, Stream = stream,
			GroundOffset = model:GetAttribute("GroundOffset") or 1,
			Time = math.random() * 10, Cycle = 0, Seed = math.random() * 10, FlapPhase = 0,
			Air = 0, Walk = 0, Fire = 0, Turn = 0, Tuck = 0, LookYaw = 0, LookPitch = 0,
			LastYaw = nil, WasAir = false, LastFlap = 0,
			FlapSpeed = 12 / scale ^ 0.4,          -- les grands dragons battent des ailes plus lentement
			CycleSpeed = 14 / scale ^ 0.45,
		}
	end)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(track)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(model) dragons[model] = nil end)
for _, model in CollectionService:GetTagged(TAG) do track(model) end

-- "Z z z" au-dessus de la tête d'un dragon endormi sur son arbre
local function makeZzz(s)
	local head
	for _, j in s.Joints do
		if j.Kind == "Head" then head = j.Weld.Part1 break end
	end
	if not head then return nil end
	local board = Instance.new("BillboardGui")
	board.Name = "Zzz"
	board.Size = UDim2.fromScale(2.2 * s.Scale, 2.2 * s.Scale)
	board.StudsOffsetWorldSpace = Vector3.new(0, 1.7 * s.Scale, 0)
	board.LightInfluence = 0
	board.MaxDistance = 220
	board.Enabled = false
	local labels = {}
	for i = 1, 3 do
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.AnchorPoint = Vector2.new(0.5, 0.5)
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.Text = "Z"
		label.TextScaled = true
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Rotation = -12 + i * 8
		local outline = Instance.new("UIStroke")
		outline.Thickness = 2.5
		outline.Color = Color3.new(0, 0, 0)
		outline.Parent = label
		label.Parent = board
		labels[i] = {Label = label, Stroke = outline}
	end
	board.Parent = head
	return {Gui = board, Labels = labels}
end

RunService.RenderStepped:Connect(function(dt)
	local camera = workspace.CurrentCamera
	for model, s in dragons do
		local root = s.Root
		if root.Parent then
			s.Time += dt
			local t = s.Time
			local velocity = root.AssemblyLinearVelocity
			local speed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
			local airborne, heightAbove = false, 0
			if not root.Anchored then
				local groundY = groundBelow(root.Position, s.GroundOffset + 2)
				heightAbove = groundY and (root.Position.Y - groundY - s.GroundOffset) or 1000
				airborne = heightAbove > 0.5 * s.Scale
			end
			local _, yaw = root.CFrame:ToOrientation()
			if s.LastYaw then
				local diff = (yaw - s.LastYaw + math.pi) % (2 * math.pi) - math.pi
				s.Turn += (clamp(diff / max(dt, 0.001) * 0.2, -1, 1) - s.Turn) * min(1, dt * 8)
			end
			s.LastYaw = yaw
			s.Air += ((airborne and 1 or 0) - s.Air) * min(1, dt * 7)
			s.Walk += (((speed > 1 and not airborne) and 1 or 0) - s.Walk) * min(1, dt * 14)
			s.Fire += ((model:GetAttribute("Firing") and 1 or 0) - s.Fire) * min(1, dt * 10)
			s.Tired = (s.Tired or 0) + ((model:GetAttribute("Exhausted") and 1 or 0) - (s.Tired or 0)) * min(1, dt * 6)
			s.Sleep = (s.Sleep or 0) + ((model:GetAttribute("Perched") and 1 or 0) - (s.Sleep or 0)) * min(1, dt * 2.5) -- endormi sur son arbre
			-- les pattes se replient en prenant de la hauteur et se déplient à l'approche du sol
			s.Tuck += (clamp(heightAbove / (4 * s.Scale), 0, 1) - s.Tuck) * min(1, dt * 6)
			s.Cycle += dt * s.CycleSpeed * clamp(speed / (10 * s.Scale ^ 0.5), 0.5, 1.6)
			if airborne ~= s.WasAir then
				s.WasAir = airborne
				s.Dust:Emit(s.Tired > 0.5 and 90 or 26) -- gros nuage quand il s'écrase épuisé
			end

			-- la tête suit le regard du cavalier (dragon du joueur local)
			local wantYaw, wantPitch = 0, 0
			if model:GetAttribute("Rider") == player.UserId then
				local localLook = root.CFrame:VectorToObjectSpace(camera.CFrame.LookVector)
				wantYaw = clamp(math.atan2(localLook.X, localLook.Z), -LOOK_YAW, LOOK_YAW)
				wantPitch = clamp(math.asin(clamp(localLook.Y, -1, 1)), -LOOK_PITCH, LOOK_PITCH)
			end
			s.LookYaw += (wantYaw - s.LookYaw) * min(1, dt * 7)
			s.LookPitch += (wantPitch - s.LookPitch) * min(1, dt * 7)

			local air, ground, walk, fire = s.Air, 1 - s.Air, s.Walk, s.Fire
			-- battement : la descente de l'aile est plus vive que la remontée
			local gliding = clamp(speed / (30 * s.Scale ^ 0.5), 0, 1)
			s.FlapPhase += dt * s.FlapSpeed * (1 + 0.25 * gliding)
			local phase = s.FlapPhase
			local flap = sin(phase + 0.45 * sin(phase))
			local flapLate = sin(phase - 0.9 + 0.45 * sin(phase - 0.9))
			local feather = cos(phase)

			for _, j in s.Joints do
				local rx, ry, rz = 0, 0, 0
				local kind = j.Kind
				if kind == "Leg" then
					local tucked = j.Front and rad(-34) or rad(46)
					rx = sin(s.Cycle + j.Phase) * LEG_SWING * walk                       -- marche
						+ air * s.Tuck * (tucked + sin(phase + j.Phase) * rad(9))         -- en vol : repliées, elles pédalent avec les ailes
						+ air * (1 - s.Tuck) * rad(j.Front and -10 or 12)                 -- près du sol : prêtes à se poser
						+ sin(t * 1.1 + j.Phase) * rad(2) * ground * (1 - walk)           -- à l'arrêt : petit balancement
					rz = -s.Turn * rad(12) * air + j.SideX * air * s.Tuck * rad(6)        -- s'écartent et penchent dans les virages
				elseif kind == "Wing" then
					rz = j.Side * (ground * (WING_REST + sin(t * 1.4 + s.Seed) * rad(3)) + air * (rad(10) + flap * FLAP * (1 + 0.3 * gliding)))
					rx = air * (rad(-6) + feather * rad(10))                               -- l'aile vrille à chaque battement
					ry = j.Side * air * s.Turn * rad(-8)
				elseif kind == "WingTip" then
					rz = j.Side * (ground * WINGTIP_REST + air * flapLate * FLAP_TIP)
					rx = air * feather * rad(8)
				elseif kind == "Tail" then
					ry = sin(t * 3.2 - j.Phase) * rad(10) * (1 + air * 0.5) - s.Turn * rad(22)
					rx = sin(t * 2.1 - j.Phase) * rad(4) - air * rad(5) + flap * rad(3) * air
				elseif kind == "Neck" then
					rx = sin(t * 2.0 + s.Seed) * rad(3) + air * rad(12) + fire * rad(8) - s.LookPitch * 0.4 - flap * rad(2) * air
					ry = s.Turn * rad(8) + s.LookYaw * 0.4
				elseif kind == "Head" then
					rx = sin(t * 2.6 + s.Seed) * rad(2.5) - air * rad(9) - fire * rad(8) + sin(s.Cycle * 2) * rad(2) * walk - s.LookPitch * 0.6
					ry = s.LookYaw * 0.6 + s.Turn * rad(10)
					rz = -s.Turn * rad(8) - s.LookYaw * 0.12
				elseif kind == "Jaw" then
					local y = (t + s.Seed) % YAWN_EVERY
					if y < YAWN_TIME then rx = sin(y / YAWN_TIME * math.pi) * JAW_YAWN end
					rx = rx * (1 - fire) + fire * (JAW_FIRE + sin(t * 34) * rad(2.5))
				end
				-- à bout de forces : en l'air les ailes partent vers le haut et les pattes battent dans le vide ;
				-- au sol il s'écroule, pattes écartées, ailes tombantes, tête par terre, et il halète
				local tired = s.Tired
				if tired > 0.01 then
					local tx, ty, tz = 0, 0, 0
					if kind == "Leg" then
						tx = ground * (j.Front and rad(-62) or rad(58)) + air * sin(t * 9 + j.Phase) * rad(22)
						tz = j.SideX * rad(28) * ground
					elseif kind == "Wing" then
						tz = j.Side * (air * (rad(72) + sin(t * 17) * rad(8)) + ground * (WING_REST * 1.5 + sin(t * 2.2) * rad(3)))
					elseif kind == "WingTip" then
						tz = j.Side * (air * rad(36) + ground * WINGTIP_REST * 1.4)
					elseif kind == "Tail" then
						ty = sin(t * 1.2 - j.Phase) * rad(3)
						tx = ground * rad(8)
					elseif kind == "Neck" then
						tx = ground * (rad(34) + sin(t * 2.2) * rad(3)) - air * rad(20)
					elseif kind == "Head" then
						tx = ground * rad(14) - air * rad(15)
						tz = ground * rad(16)
					elseif kind == "Jaw" then
						tx = JAW_YAWN * 0.5 + sin(t * 8) * rad(5)
					end
					rx += (tx - rx) * tired
					ry += (ty - ry) * tired
					rz += (tz - rz) * tired
				end
				-- il dort sur son arbre : pattes repliées, ailes rabattues sur le dos, queue enroulée, tête posée de côté ; il respire doucement
				local sleep = s.Sleep
				if sleep > 0.01 then
					local sx, sy, sz = 0, 0, 0
					local breath = sin(t * 1.5 + s.Seed)
					if kind == "Leg" then
						sx = j.Front and rad(-72) or rad(68)
						sz = j.SideX * rad(18)
					elseif kind == "Wing" then
						sy = j.Side * rad(58)
						sz = j.Side * (rad(22) + breath * rad(2))
					elseif kind == "WingTip" then
						sy = j.Side * rad(26)
						sz = j.Side * rad(-30)
					elseif kind == "Tail" then
						sy = rad(38) + breath * rad(1.5)
						sx = rad(3)
					elseif kind == "Neck" then
						sx = rad(26) + breath * rad(2.5)
						sy = rad(-24)
					elseif kind == "Head" then
						sx = rad(12) - breath * rad(1.5)
						sy = rad(-30)
						sz = rad(-12)
					elseif kind == "Jaw" then
						sx = (breath * 0.5 + 0.5) * rad(6)
					end
					rx += (sx - rx) * sleep
					ry += (sy - ry) * sleep
					rz += (sz - rz) * sleep
				end
				j.Weld.C0 = j.Base * CFrame.Angles(rx, ry, rz)
			end

			-- Zzz qui montent au-dessus de sa tête pendant qu'il dort
			if s.Sleep > 0.5 and not s.Zzz then s.Zzz = makeZzz(s) or false end
			if s.Zzz then
				s.Zzz.Gui.Enabled = s.Sleep > 0.5
				if s.Sleep > 0.5 then
					for i, z in s.Zzz.Labels do
						local k = (t * 0.4 + i / 3) % 1
						local size = 0.16 + k * 0.24
						z.Label.Position = UDim2.fromScale(0.3 + k * 0.42 + sin(k * 7) * 0.04, 0.88 - k * 0.76)
						z.Label.Size = UDim2.fromScale(size, size)
						local fade = k < 0.15 and 1 - k / 0.15 or (k > 0.7 and (k - 0.7) / 0.3 or 0)
						z.Label.TextTransparency = fade
						z.Stroke.Transparency = fade
					end
				end
			end
			-- effets d'air
			local flying = air > 0.5
			local downstroke = flap < s.LastFlap
			for _, tip in s.Tips do
				tip.Trail.Enabled = flying
				tip.Trail.Transparency = downstroke and TRAIL_STRONG or TRAIL_SOFT
			end
			if flying and flap < 0.2 and s.LastFlap >= 0.2 then -- l'aile passe sous l'horizontale : coup de vent
				for _, tip in s.Tips do
					tip.Gust:Emit(6)
					tip.Sparks:Emit(7)
				end
			end
			s.LastFlap = flap
			s.Stream.Rate = flying and gliding * 30 or 0
		end
	end
end)

---------------------------------------------------------------- 2) pilotage du dragon chevauché
local riding -- état du pilotage
local lastJumpRequest = 0
local flyHeld = false -- bouton "Fly" tenu (écrans tactiles : le bouton de saut de Roblox disparaît en selle)

local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
end
local function stroke(parent, thickness, border)
	local s = Instance.new("UIStroke")
	s.Thickness = thickness
	s.Color = INK
	if border then s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border end
	s.Parent = parent
end
local function gradient(parent, ...)
	local g = Instance.new("UIGradient")
	g.Rotation = 90
	local points = {}
	for _, p in {...} do table.insert(points, ColorSequenceKeypoint.new(p[1], p[2])) end
	g.Color = ColorSequence.new(points)
	g.Parent = parent
	return g
end

local FILL_NORMAL = {{0, Color3.fromRGB(196, 240, 255)}, {0.45, Color3.fromRGB(120, 206, 255)}, {1, Color3.fromRGB(58, 146, 244)}}
local FILL_EMPTY = {{0, Color3.fromRGB(214, 222, 236)}, {1, Color3.fromRGB(150, 164, 190)}}

local function buildHud()
	local gui = Instance.new("ScreenGui")
	gui.Name = "DragonHud"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 1

	-- barre d'endurance des ailes : piste sombre, remplissage en dégradé bleu ciel à studs, contour noir, sans autre effet
	local holder = Instance.new("Frame")
	holder.Name = "Stamina"
	holder.AnchorPoint = Vector2.new(0.5, 1)
	holder.Position = UDim2.new(0.5, 0, 1, -146)
	holder.Size = UDim2.fromOffset(460, 44)
	holder.BackgroundColor3 = Color3.new(1, 1, 1)
	corner(holder, 16)
	gradient(holder, {0, Color3.fromRGB(255, 255, 255)}, {1, Color3.fromRGB(228, 232, 242)})
	local trackOutline = Instance.new("UIStroke") -- contour noir de la piste sombre, même épaisseur que celui de la partie bleue
	trackOutline.Thickness = 4
	trackOutline.Color = Color3.new(0, 0, 0)
	trackOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	trackOutline.Parent = holder
	local trackTexture = Instance.new("ImageLabel") -- texture de la piste sombre, teintée comme elle
	trackTexture.Name = "TrackTexture"
	trackTexture.BackgroundTransparency = 1
	trackTexture.Size = UDim2.fromScale(1, 1)
	trackTexture.Image = "rbxassetid://128018369481245"
	trackTexture.ImageTransparency = 0
	trackTexture.ScaleType = Enum.ScaleType.Tile
	trackTexture.TileSize = UDim2.fromOffset(44, 44)
	trackTexture.ZIndex = 1
	corner(trackTexture, 16)
	gradient(trackTexture, {0, Color3.fromRGB(150, 158, 178)}, {1, Color3.fromRGB(110, 118, 140)})
	trackTexture.Parent = holder
	holder.Parent = gui
	CollectionService:AddTag(holder, "AutoScale")

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.fromScale(1, 1)
	fill.BackgroundColor3 = Color3.new(1, 1, 1)
	fill.BorderSizePixel = 0
	fill.ClipsDescendants = true
	fill.ZIndex = 2
	corner(fill, 16)
	local outline = Instance.new("UIStroke") -- contour noir de la partie bleue
	outline.Thickness = 4
	outline.Color = Color3.new(0, 0, 0)
	outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	outline.Parent = fill
	local fillGradient = gradient(fill, table.unpack(FILL_NORMAL))
	fill.Parent = holder
	local studs = Instance.new("ImageLabel")
	studs.BackgroundTransparency = 1
	studs.Size = UDim2.fromOffset(460, 44)
	studs.Image = STUD_TEXTURE
	studs.ImageTransparency = 0.2
	studs.ScaleType = Enum.ScaleType.Tile
	studs.TileSize = UDim2.fromOffset(22, 22)
	local studTint = gradient(studs, table.unpack(FILL_NORMAL)) -- la texture prend la couleur de la barre
	studs.ZIndex = 2
	corner(studs, 16)
	studs.Parent = fill
	local name = Instance.new("TextLabel")
	name.BackgroundTransparency = 1
	name.Position = UDim2.fromOffset(20, 0)
	name.Size = UDim2.new(0.6, 0, 1, 0)
	name.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	name.Text = "Dragon Stamina"
	name.TextSize = 23
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.TextColor3 = Color3.new(1, 1, 1)
	name.ZIndex = 5
	stroke(name, 3)
	name.Parent = holder
	local value = Instance.new("TextLabel")
	value.Name = "Value"
	value.BackgroundTransparency = 1
	value.AnchorPoint = Vector2.new(1, 0)
	value.Position = UDim2.new(1, -18, 0, 0)
	value.Size = UDim2.new(0.4, 0, 1, 0)
	value.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	value.Text = "12/12"
	value.TextSize = 28
	value.TextXAlignment = Enum.TextXAlignment.Right
	value.TextColor3 = Color3.new(1, 1, 1)
	value.ZIndex = 5
	stroke(value, 3)
	value.Parent = holder

	-- bouton Dismount : descendre du dragon (il suit ensuite son joueur à pied)
	local dismount = Instance.new("TextButton")
	dismount.Name = "Dismount"
	dismount.Text = ""
	dismount.AutoButtonColor = false
	dismount.AnchorPoint = Vector2.new(0.5, 1)
	dismount.Position = UDim2.new(0.5, 0, 0, -42)
	dismount.Size = UDim2.fromOffset(170, 44)
	dismount.BackgroundColor3 = Color3.new(1, 1, 1)
	dismount.BorderSizePixel = 0
	dismount.ZIndex = 3
	corner(dismount, 2)
	gradient(dismount, {0, Color3.fromRGB(255, 80, 80)}, {1, Color3.fromRGB(205, 16, 36)})
	local dismountOutline = Instance.new("UIStroke")
	dismountOutline.Thickness = 4
	dismountOutline.Color = Color3.new(0, 0, 0)
	dismountOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dismountOutline.Parent = dismount
	local dismountStuds = Instance.new("ImageLabel")
	dismountStuds.Name = "Studs"
	dismountStuds.BackgroundTransparency = 1
	dismountStuds.Size = UDim2.fromScale(1, 1)
	dismountStuds.Image = STUD_TEXTURE
	dismountStuds.ImageTransparency = 0.2
	dismountStuds.ScaleType = Enum.ScaleType.Tile
	dismountStuds.TileSize = UDim2.fromOffset(22, 22)
	dismountStuds.ZIndex = 3
	dismountStuds.Parent = dismount
	local dismountLabel = Instance.new("TextLabel")
	dismountLabel.Name = "Label"
	dismountLabel.BackgroundTransparency = 1
	dismountLabel.Size = UDim2.fromScale(1, 1)
	dismountLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	dismountLabel.Text = "Dismount"
	dismountLabel.TextSize = 24
	dismountLabel.TextColor3 = Color3.new(1, 1, 1)
	dismountLabel.ZIndex = 5
	stroke(dismountLabel, 3)
	dismountLabel.Parent = dismount
	dismount.Parent = holder
	dismount.Activated:Connect(function() action:FireServer("Dismount") end)

	-- bouton Fly (écrans tactiles seulement) : on le garde appuyé pour monter, à la place du bouton de saut
	flyHeld = false
	if UserInputService.TouchEnabled then
		local fly = Instance.new("TextButton")
		fly.Name = "Fly"
		fly.Text = ""
		fly.AutoButtonColor = false
		fly.AnchorPoint = Vector2.new(1, 1)
		fly.Position = UDim2.new(1, -28, 1, -96)
		fly.Size = UDim2.fromOffset(104, 104)
		fly.BackgroundColor3 = Color3.new(1, 1, 1)
		fly.BorderSizePixel = 0
		fly.ZIndex = 3
		fly:SetAttribute("NoFx", true) -- pas d'inclinaison : on le tient appuyé
		corner(fly, 2)
		gradient(fly, {0, Color3.fromRGB(120, 215, 255)}, {1, Color3.fromRGB(30, 120, 240)})
		local flyOutline = Instance.new("UIStroke")
		flyOutline.Thickness = 4
		flyOutline.Color = Color3.new(0, 0, 0)
		flyOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		flyOutline.Parent = fly
		local flyStuds = Instance.new("ImageLabel")
		flyStuds.Name = "Studs"
		flyStuds.BackgroundTransparency = 1
		flyStuds.Size = UDim2.fromScale(1, 1)
		flyStuds.Image = STUD_TEXTURE
		flyStuds.ImageTransparency = 0.2
		flyStuds.ScaleType = Enum.ScaleType.Tile
		flyStuds.TileSize = UDim2.fromOffset(26, 26)
		flyStuds.ZIndex = 3
		flyStuds.Parent = fly
		local flyLabel = Instance.new("TextLabel")
		flyLabel.Name = "Label"
		flyLabel.BackgroundTransparency = 1
		flyLabel.Position = UDim2.fromScale(0.08, 0.22)
		flyLabel.Size = UDim2.fromScale(0.84, 0.56)
		flyLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		flyLabel.Text = "FLY"
		flyLabel.TextScaled = true
		flyLabel.TextColor3 = Color3.new(1, 1, 1)
		flyLabel.ZIndex = 5
		stroke(flyLabel, 3.5)
		flyLabel.Parent = fly
		fly.Parent = gui
		CollectionService:AddTag(fly, "AutoScale")
		fly.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then flyHeld = true end
		end)
		fly.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then flyHeld = false end
		end)
		gui.Destroying:Connect(function() flyHeld = false end)
	end

	-- bouton Drop : lâche le dernier œuf pris (visible seulement quand on porte un œuf)
	local drop = Instance.new("TextButton")
	drop.Name = "Drop"
	drop.Text = ""
	drop.AutoButtonColor = false
	drop.AnchorPoint = Vector2.new(0.5, 0)
	drop.Position = UDim2.new(0.5, 0, 1, 10) -- sous la barre d'endurance
	drop.Size = UDim2.fromOffset(112, 44)
	drop.BackgroundColor3 = Color3.new(1, 1, 1)
	drop.BorderSizePixel = 0
	drop.ZIndex = 3
	corner(drop, 2)
	gradient(drop, {0, Color3.fromRGB(255, 70, 70)}, {1, Color3.fromRGB(215, 20, 40)})
	local dropOutline = Instance.new("UIStroke")
	dropOutline.Thickness = 4
	dropOutline.Color = Color3.new(0, 0, 0)
	dropOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dropOutline.Parent = drop
	local dropStuds = Instance.new("ImageLabel")
	dropStuds.Name = "Studs"
	dropStuds.BackgroundTransparency = 1
	dropStuds.Size = UDim2.fromScale(1, 1)
	dropStuds.Image = STUD_TEXTURE
	dropStuds.ImageTransparency = 0.2
	dropStuds.ScaleType = Enum.ScaleType.Tile
	dropStuds.TileSize = UDim2.fromOffset(22, 22)
	dropStuds.ZIndex = 3
	dropStuds.Parent = drop
	local dropLabel = Instance.new("TextLabel")
	dropLabel.Name = "Label"
	dropLabel.BackgroundTransparency = 1
	dropLabel.Size = UDim2.fromScale(1, 1)
	dropLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	dropLabel.Text = "Drop"
	dropLabel.TextSize = 24
	dropLabel.TextColor3 = Color3.new(1, 1, 1)
	dropLabel.ZIndex = 5
	stroke(dropLabel, 3)
	dropLabel.Parent = drop
	drop.Visible = (player:GetAttribute("Carrying") or 0) > 0
	drop.Parent = holder
	local carryingChanged = player:GetAttributeChangedSignal("Carrying"):Connect(function()
		drop.Visible = (player:GetAttribute("Carrying") or 0) > 0
	end)
	gui.Destroying:Connect(function() carryingChanged:Disconnect() end)
	drop.Activated:Connect(function()
		ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("DropEgg"):FireServer()
	end)

	-- oeufs portés par le dragon (à ramener dans la zone sûre)
	local carry = Instance.new("TextLabel")
	carry.Name = "Carry"
	carry.BackgroundTransparency = 1
	carry.AnchorPoint = Vector2.new(0.5, 1)
	carry.Position = UDim2.new(0.5, 0, 0, -6)
	carry.ZIndex = 4
	carry.Size = UDim2.new(1, 0, 0, 26)
	carry.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	carry.Text = "Animals carried: 0/1"
	carry.TextSize = 20
	carry.TextColor3 = Color3.new(1, 1, 1)
	stroke(carry, 2.5)
	carry.Parent = holder

	local wind = Instance.new("Frame") -- calque des traits de vent
	wind.Name = "Wind"
	wind.Size = UDim2.fromScale(1, 1)
	wind.BackgroundTransparency = 1
	wind.ZIndex = 0
	wind.Parent = gui

	gui.Parent = player:WaitForChild("PlayerGui")
	return {Gui = gui, Fill = fill, FillGradient = fillGradient, StudTint = studTint, Value = value, Wind = wind, Carry = carry}
end

-- œuf visé pendant qu'on crache : il suffit de pointer la caméra à peu près dessus (pas besoin d'être précis)
local function aimedEgg(root, camera)
	local eggs = workspace:FindFirstChild("ZoneEggs")
	if not eggs then return nil end
	local origin, look = camera.CFrame.Position, camera.CFrame.LookVector
	local best, bestOff
	for _, zone in eggs:GetChildren() do
		for _, egg in zone:GetChildren() do
			local height = egg:GetAttribute("Height")
			if height and not egg:GetAttribute("Hatching") then
				local center = egg:GetPivot().Position
				if (center - root.Position).Magnitude < 70 + height then
					local along = (center - origin):Dot(look)
					if along > 0 then
						local off = ((center - origin) - look * along).Magnitude
						if off < height * 0.6 + 4 + along * 0.07 and (not best or off < bestOff) then best, bestOff = egg, off end
					end
				end
			end
		end
	end
	return best
end

local savedStamina, savedExhausted -- endurance gardée quand on descend du dragon : elle ne se recharge pas à pied
local applyZoom
local fireInput -- l'entrée qui tient le feu allumé
local function stopRiding()
	if not riding then return end
	local r = riding
	riding = nil
	savedStamina, savedExhausted = r.Stamina, r.Exhausted
	if fireInput then
		fireInput = nil
		action:FireServer("Fire", false)
	end
	r.Hud.Gui:Destroy()
	workspace.CurrentCamera.FieldOfView = BASE_FOV
	if r.Humanoid and r.Humanoid.Parent then r.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
	player.CameraMinZoomDistance = r.OldMinZoom
	player.CameraMaxZoomDistance = r.OldMaxZoom
end

-- recul de la caméra selon la taille du dragon et du plus gros œuf porté (affiché en taille réelle)
applyZoom = function()
	local r = riding
	if not r then return end
	local egg = player:GetAttribute("CarrySize") or 0
	local minZoom = 8 + r.Height * 1.6
	if egg > 8 then minZoom = max(minZoom, egg * 1.5 + 12) end
	player.CameraMaxZoomDistance = max(r.OldMaxZoom, 40 + r.Height * 5, minZoom + 60)
	player.CameraMinZoomDistance = minZoom
end

local function startRiding(model, humanoid)
	stopRiding()
	local root = model.PrimaryPart
	local level = model:GetAttribute("Level") or 1
	local height = model:GetAttribute("Height") or 2.5
	local _, yaw = root.CFrame:ToOrientation()
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false) -- ESPACE sert à voler, pas à quitter le siège
	local steer = root:WaitForChild("Steer")
	steer.Responsiveness = 34 -- rotation souple
	local maxStamina = math.floor(UpgradeConfig.Value(player, "Stamina") * DragonConfig.StaminaMult(player) + 0.5)
	riding = {
		Model = model, Root = root, Drive = root:WaitForChild("Drive"), Steer = steer, Humanoid = humanoid, Hud = buildHud(),
		Yaw = yaw, Speed = 0, TurnRate = 0, Flight = 0, Vertical = 0, WindTimer = 0, Lean = 0, Seat = model:FindFirstChild("Seat"),
		Stamina = math.min(savedStamina or maxStamina, maxStamina), Exhausted = savedExhausted == true, ShownRatio = 1, LagRatio = 1, WasExhausted = false,
		RiseSpeed = 16 + level * 3, SinkSpeed = 26 + level * 4,   -- on descend plus vite qu'on ne monte
		GroundOffset = model:GetAttribute("GroundOffset") or 1, Scale = height / 2.5,
		FlapSpeed = 12 / (height / 2.5) ^ 0.4,
		OldMinZoom = player.CameraMinZoomDistance, OldMaxZoom = player.CameraMaxZoomDistance,
	}
	riding.Height = height
	applyZoom()
end
player:GetAttributeChangedSignal("CarrySize"):Connect(function() applyZoom() end)

-- détecte quand le personnage est assis sur un dragon
local function watchCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	local function seatChanged()
		local seat = humanoid.SeatPart
		local model = seat and seat.Parent
		if model and CollectionService:HasTag(model, TAG) then
			startRiding(model, humanoid)
		else
			stopRiding()
		end
	end
	humanoid:GetPropertyChangedSignal("SeatPart"):Connect(seatChanged)
	humanoid.Died:Connect(stopRiding)
	seatChanged()
end
player.CharacterAdded:Connect(watchCharacter)
if player.Character then task.spawn(watchCharacter, player.Character) end

UserInputService.JumpRequest:Connect(function() lastJumpRequest = os.clock() end)
-- feu : clic gauche (PC), doigt posé sur l'écran hors des boutons (mobile), gâchette R2 (manette) ou touche F
local function isFireInput(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
		or input.KeyCode == Enum.KeyCode.ButtonR2 or input.KeyCode == Enum.KeyCode.F
end
UserInputService.InputBegan:Connect(function(input, processed)
	if riding and not processed and not fireInput and isFireInput(input) then
		fireInput = input
		action:FireServer("Fire", true)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if fireInput and (input == fireInput or (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode == fireInput.KeyCode)) then
		fireInput = nil
		action:FireServer("Fire", false)
	end
end)

RunService.Heartbeat:Connect(function(dt)
	local r = riding
	if not r then return end
	local root = r.Root
	if not root.Parent or root.Anchored then return end
	local camera = workspace.CurrentCamera
	-- brûler un œuf : tant qu'on crache en le visant, on prévient le serveur plusieurs fois par seconde
	if fireInput then
		r.BurnTick = (r.BurnTick or 0) - dt
		if r.BurnTick <= 0 then
			r.BurnTick = 0.15
			local target = aimedEgg(root, camera)
			if target then ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("BurnEgg"):FireServer(target) end
		end
	end
	-- direction voulue : celle du personnage (clavier, manette, stick mobile), sinon ZQSD / WASD / flèches lus directement
	local wanted = r.Humanoid.MoveDirection
	local dir = Vector3.new(wanted.X, 0, wanted.Z)
	if dir.Magnitude < 0.1 then
		local look = camera.CFrame.LookVector
		local forward = Vector3.new(look.X, 0, look.Z)
		forward = forward.Magnitude > 0.01 and forward.Unit or Vector3.new(0, 0, -1)
		local right = Vector3.new(-forward.Z, 0, forward.X)
		local function down(...)
			for _, key in {...} do if UserInputService:IsKeyDown(key) then return 1 end end
			return 0
		end
		local x = down(Enum.KeyCode.D, Enum.KeyCode.Right) - down(Enum.KeyCode.A, Enum.KeyCode.Q, Enum.KeyCode.Left)
		local z = down(Enum.KeyCode.W, Enum.KeyCode.Z, Enum.KeyCode.Up) - down(Enum.KeyCode.S, Enum.KeyCode.Down)
		if UserInputService:GetFocusedTextBox() then x, z = 0, 0 end
		dir = right * x + forward * z
	end
	local moving = dir.Magnitude > 0.1
	if moving then dir = dir.Unit end
	if r.Exhausted then moving = false end -- à bout de forces : il ne répond plus

	local groundY = groundBelow(root.Position, r.GroundOffset + 2)
	local targetY = groundY and (groundY + r.GroundOffset * (r.Exhausted and 0.72 or 1)) or nil -- épuisé : il s'affale, le ventre au sol
	local gap = targetY and (root.Position.Y - targetY) or math.huge
	local flying = gap > 0.6 * r.Scale
	-- il s'écrase épuisé : l'écran tremble
	if r.Exhausted and r.WasFlying and not flying then r.Shake = 0.6 end
	r.WasFlying = flying
	if r.Shake then
		r.Shake -= dt
		if r.Shake > 0 then
			r.Humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, 0) * r.Shake * 3
		else
			r.Shake = nil
			r.Humanoid.CameraOffset = Vector3.zero
		end
	end
	local wantsUp = (UserInputService:IsKeyDown(Enum.KeyCode.Space) and not UserInputService:GetFocusedTextBox()) or os.clock() - lastJumpRequest < 0.2 or flyHeld

	-- endurance des ailes : monter en consomme, voler un peu ; elle revient au sol. Le maximum s'améliore au stand Upgrades.
	local maxStamina = math.floor(UpgradeConfig.Value(player, "Stamina") * DragonConfig.StaminaMult(player) + 0.5) -- le dragon équipé multiplie l'endurance
	if r.Exhausted and r.Stamina >= maxStamina then r.Exhausted = false end -- il ne se relève qu'une fois l'endurance entièrement revenue
	local rising = wantsUp and not r.Exhausted
	if rising then
		r.Stamina -= UpgradeConfig.StaminaRise * dt
	elseif flying then
		r.Stamina -= UpgradeConfig.StaminaFly * dt
	else
		r.Stamina += maxStamina / 3 * dt -- recharge complète en 3 secondes, quelle que soit l'endurance maximale
	end
	r.Stamina = clamp(r.Stamina, 0, maxStamina)
	if r.Stamina <= 0 then r.Exhausted = true end
	-- affichage : le remplissage glisse doucement vers sa valeur
	local hud = r.Hud
	local ratio = r.Stamina / maxStamina
	r.ShownRatio += (ratio - r.ShownRatio) * min(1, dt * 14)
	hud.Fill.Size = UDim2.fromScale(max(r.ShownRatio, 0.001), 1)
	hud.Fill.Visible = r.ShownRatio > 0.015
	if r.Exhausted ~= r.WasExhausted then
		r.WasExhausted = r.Exhausted
		action:FireServer("Exhausted", r.Exhausted)
		local points = {}
		for _, p in (r.Exhausted and FILL_EMPTY or FILL_NORMAL) do table.insert(points, ColorSequenceKeypoint.new(p[1], p[2])) end
		hud.FillGradient.Color = ColorSequence.new(points)
		hud.StudTint.Color = hud.FillGradient.Color
	end
	hud.Value.Text = r.Exhausted and "EXHAUSTED!" or (math.floor(r.Stamina + 0.5) .. "/" .. maxStamina)
	local carrying = player:GetAttribute("Carrying") or 0
	hud.Carry.Text = "Animals carried: " .. carrying .. "/" .. UpgradeConfig.Value(player, "Carry")
	hud.Carry.TextColor3 = carrying > 0 and Color3.fromRGB(255, 226, 110) or Color3.new(1, 1, 1)

	-- vertical : on monte, sinon on redescend vite (en freinant près du sol), sinon on reste posé
	local wantVertical
	if rising then
		wantVertical = r.RiseSpeed
	elseif flying then
		-- sans ESPACE on tombe, y compris au-dessus du vide (gap est alors infini : chute à pleine vitesse)
		wantVertical = r.Exhausted and -min(170, gap * 12 + 4) or -min(r.SinkSpeed, gap * 4 + 2) -- épuisé : il tombe comme une pierre
	else
		wantVertical = clamp(-gap * 12, -40, 40)
	end
	r.Vertical += (wantVertical - r.Vertical) * min(1, dt * 9)

	-- cap : le dragon vire progressivement vers la direction voulue
	local turnRate = 0
	if moving then
		local wantYaw = math.atan2(dir.X, dir.Z)
		local diff = (wantYaw - r.Yaw + math.pi) % (2 * math.pi) - math.pi
		local maxStep = TURN_SPEED * dt * ((flying or rising) and 1 or GROUND_TURN)
		local step = clamp(diff * min(1, dt * 12.5), -maxStep, maxStep)
		r.Yaw += step
		turnRate = step / max(dt, 0.001)
	end
	r.TurnRate += (turnRate - r.TurnRate) * min(1, dt * 6)

	-- vitesse : accélération et freinage doux, toujours vers l'avant du dragon
	local speedStat = UpgradeConfig.Value(player, "Speed") / (player:GetAttribute("CarryHeavy") and 1.25 or 1) -- s'améliore au stand Upgrades
	-- en vol : la vraie vitesse ; au sol : plafonnée
	local topSpeed = (flying or rising) and speedStat or math.min(speedStat, UpgradeConfig.GroundSpeedCap)
	r.Speed += ((moving and topSpeed or 0) - r.Speed) * min(1, dt * (moving and 3.6 or 2.6))
	if r.Exhausted then r.Speed *= max(0, 1 - dt * 8) end -- plus aucune commande : il tombe à la verticale
	local heading = Vector3.new(sin(r.Yaw), 0, cos(r.Yaw))
	local airborne = flying or rising
	r.Flight += ((airborne and 1 or 0) - r.Flight) * min(1, dt * 4)
	local bob = sin(os.clock() * r.FlapSpeed) * 1.6 * r.Scale ^ 0.5 * r.Flight -- le corps ondule au rythme des ailes
	r.Drive.VectorVelocity = heading * r.Speed + Vector3.new(0, r.Vertical + bob, 0)

	-- attitude : se cabre en montant, pique en descendant, s'incline dans les virages
	local pitch = (-clamp(r.Vertical / r.RiseSpeed, -1, 1) * rad(18) + rad(10) * clamp(r.Speed / (math.max(speedStat, 1)), 0, 1)) * r.Flight -- pique du nez en pleine vitesse
	local bank = clamp(-r.TurnRate / TURN_SPEED, -1, 1) * rad(34) * (0.35 + 0.65 * r.Flight)
	r.Steer.CFrame = CFrame.Angles(0, r.Yaw, 0) * CFrame.Angles(pitch, 0, bank)
	if r.Exhausted and flying then -- chute : il pique du nez en vrillant
		r.Steer.CFrame = CFrame.Angles(0, r.Yaw, 0) * CFrame.Angles(rad(66), 0, 0) * CFrame.Angles(0, 0, (os.clock() * 5.5) % (2 * math.pi)) -- piqué en vrille
	end

	-- effets d'écran : le champ de vision s'ouvre avec la vitesse, des traits de vent filent sur les bords
	local rush = clamp(r.Speed / (math.max(speedStat, 1)), 0, 1) * r.Flight

	-- le cavalier se couche sur l'encolure quand le dragon vole vite, et se penche dans les virages
	local seatWeld = r.Seat and r.Seat:FindFirstChild("SeatWeld")
	if seatWeld then
		if not r.SeatBase or r.SeatWeldRef ~= seatWeld then r.SeatBase, r.SeatWeldRef = seatWeld.C0, seatWeld end
		r.Lean += ((rad(8) * r.Flight + rad(26) * rush) - r.Lean) * min(1, dt * 5)
		seatWeld.C0 = r.SeatBase * CFrame.Angles(-r.Lean, 0, clamp(r.TurnRate / TURN_SPEED, -1, 1) * rad(14) * r.Flight)
	end
	camera.FieldOfView += ((BASE_FOV + 16 * rush) - camera.FieldOfView) * min(1, dt * 5)
	r.WindTimer -= dt
	if rush > 0.35 and r.WindTimer <= 0 then
		r.WindTimer = 0.085 - 0.06 * rush
		local view = camera.ViewportSize
		local angle = math.random() * math.pi * 2
		local radius = math.min(view.X, view.Y) * (0.34 + math.random() * 0.2)
		local streak = Instance.new("Frame")
		streak.AnchorPoint = Vector2.new(0.5, 0.5)
		streak.BorderSizePixel = 0
		streak.BackgroundColor3 = Color3.new(1, 1, 1)
		streak.BackgroundTransparency = 0.5
		streak.Size = UDim2.fromOffset(40 + 90 * rush, 2)
		streak.Rotation = math.deg(angle)
		streak.Position = UDim2.fromOffset(view.X / 2 + cos(angle) * radius, view.Y / 2 + sin(angle) * radius)
		streak.Parent = hud.Wind
		local far = radius * 1.7
		TweenService:Create(streak, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.fromOffset(view.X / 2 + cos(angle) * far, view.Y / 2 + sin(angle) * far),
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(120 + 160 * rush, 2),
		}):Play()
		Debris:AddItem(streak, 0.3)
	end
end)

---------------------------------------------------------------- Dragon sans cavalier : à la droite de son joueur, avec du retard
-- Sa place est toujours à droite du joueur, mais il la rejoint en douceur : il lui faut environ 1 seconde pour rattraper.
local FOLLOW_LAG = 1 -- secondes pour rejoindre sa place
local followPosition, followYaw
local glide -- vol de retour vers le nid (le serveur pose l'attribut GoPerch = CFrame du nid)
RunService.RenderStepped:Connect(function(dt)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _, dragon in CollectionService:GetTagged(TAG) do
		if dragon:GetAttribute("Owner") == player.UserId then
			local root = dragon.PrimaryPart
			if dragon:GetAttribute("Rider") or not root or root.Anchored then
				followPosition, followYaw = nil, nil -- en selle : on repartira de sa position actuelle
				glide = nil
			elseif dragon:GetAttribute("GoPerch") then -- il rentre dormir : un vol en arc jusqu'à son nid, puis on prévient le serveur
				local goal = dragon:GetAttribute("GoPerch")
				if not glide or glide.Goal ~= goal then
					local distance = (goal.Position - root.Position).Magnitude
					glide = {Goal = goal, From = root.CFrame, T = 0, Duration = clamp(distance / 50, 0.9, 2.2), Lift = clamp(distance * 0.2, 5, 16)}
				end
				glide.T += dt
				local a = min(glide.T / glide.Duration, 1)
				local e = a * a * (3 - 2 * a)
				local from, to = glide.From.Position, goal.Position
				local position = from:Lerp(to, e) + Vector3.new(0, sin(e * math.pi) * glide.Lift, 0)
				local flat = Vector3.new(to.X - from.X, 0, to.Z - from.Z)
				local travel = flat.Magnitude > 1 and CFrame.Angles(0, math.atan2(flat.X, flat.Z), 0) or goal.Rotation
				local facing = travel:Lerp(goal.Rotation, clamp((a - 0.65) / 0.35, 0, 1)) -- il se tourne dans le sens du nid en arrivant
				local previous = root.Position
				root.CFrame = CFrame.new(position) * facing
				root.AssemblyAngularVelocity = Vector3.zero
				local velocity = (position - previous) / max(dt, 0.001)
				root.AssemblyLinearVelocity = velocity
				local drive, steer = root:FindFirstChild("Drive"), root:FindFirstChild("Steer")
				if drive then drive.VectorVelocity = velocity end
				if steer then steer.CFrame = facing end
				if a >= 1 and not glide.Sent then
					glide.Sent = true
					action:FireServer("Perched")
				end
				followPosition, followYaw = nil, nil
			else
				glide = nil
				local height = dragon:GetAttribute("Height") or 8.8
				local offset = dragon:GetAttribute("GroundOffset") or 3.4
				local look = hrp.CFrame.LookVector
				local wantYaw = math.atan2(look.X, look.Z)
				local right = Vector3.new(-look.Z, 0, look.X)
				if right.Magnitude > 0.01 then right = right.Unit end
				local want = hrp.Position + right * (3 + height * 0.5) + Vector3.new(0, offset - 3, 0)
				if not followPosition or (followPosition - want).Magnitude > 150 then
					local _, yaw = root.CFrame:ToOrientation()
					followPosition, followYaw = (followPosition and want) or root.Position, yaw
				end
				local alpha = 1 - math.exp(-dt * 3 / FOLLOW_LAG)
				local previous = followPosition
				followPosition = followPosition:Lerp(want, alpha)
				followYaw += ((wantYaw - followYaw + math.pi) % (2 * math.pi) - math.pi) * alpha
				root.CFrame = CFrame.new(followPosition) * CFrame.Angles(0, followYaw, 0)
				root.AssemblyAngularVelocity = Vector3.zero
				local velocity = (followPosition - previous) / math.max(dt, 0.001) -- sa vraie vitesse : garde l'animation de marche
				root.AssemblyLinearVelocity = velocity
				local drive, steer = root:FindFirstChild("Drive"), root:FindFirstChild("Steer")
				if drive then drive.VectorVelocity = velocity end
				if steer then steer.CFrame = CFrame.Angles(0, followYaw, 0) end
			end
		end
	end
end)
