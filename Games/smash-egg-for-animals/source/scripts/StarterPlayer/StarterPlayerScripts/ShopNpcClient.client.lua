-- Animations des vendeurs (modèles taggés "ShopNpc") : poses et mouvements joués en bougeant leurs articulations.
--   Anim = "Straw"  : fermier accoudé au comptoir qui mâchouille un brin de paille et soulève son chapeau
--   Anim = "Tomato" : jardinière qui croque dans une tomate, mâche, puis en reprend une
-- Les deux respirent, se balancent, suivent le joueur du regard et le saluent quand il s'approche.
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local TAG = "ShopNpc"
local LOOK_RANGE = 22        -- distance à laquelle le vendeur regarde le joueur
local WAVE_RANGE = 14        -- distance à laquelle il le salue
local WAVE_TIME = 1.6
local MAX_HEAD_YAW = math.rad(60)
local BLEND = 9              -- vitesse à laquelle une pose rejoint la suivante

local player = Players.LocalPlayer
local rad, sin = math.rad, math.sin
local A = CFrame.Angles
local npcs = {} -- [model] = état

local function findJoints(model)
	local joints = {}
	for _, d in model:GetDescendants() do
		if d:IsA("Motor6D") then
			joints[d.Name] = {Motor = d, Base = d.C0, Current = CFrame.new()}
		end
	end
	return joints
end

local function track(model)
	if npcs[model] then return end
	task.spawn(function()
		local root = model.PrimaryPart or model:WaitForChild("HumanoidRootPart", 10)
		if not root then return end
		local tomato = model:FindFirstChild("Tomato")
		npcs[model] = {
			Root = root,
			Joints = findJoints(model),
			Anim = model:GetAttribute("Anim"),
			Time = math.random() * 10,
			WaveLeft = 0,
			WasNear = false,
			Tomato = tomato,
			TomatoSize = tomato and tomato.Size,
			Bites = 0,
			LastCycle = -1,
		}
	end)
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(track)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(model) npcs[model] = nil end)
for _, model in CollectionService:GetTagged(TAG) do track(model) end

-- 0 -> 1 -> 0 en douceur entre t0 et t1
local function pulse(t, t0, t1)
	if t < t0 or t > t1 then return 0 end
	return sin((t - t0) / (t1 - t0) * math.pi)
end
local function smooth(a) return a * a * (3 - 2 * a) end

-- Fermier : main gauche sur la hanche, avant-bras droit posé sur le comptoir, paille qui gigote
local function strawPose(s, t, pose)
	local cycle = t % 9
	local tip = pulse(cycle, 0, 1.4) -- soulève son chapeau au début de chaque cycle
	pose["Left Shoulder"] = A(rad(8), 0, rad(-26))
	pose["Right Shoulder"] = A(rad(80), 0, rad(6)):Lerp(A(rad(158), 0, rad(-20)), tip)
	pose.Root = A(rad(4), sin(t * 0.6) * rad(3), sin(t * 0.9) * rad(1.5)) -- légèrement penché vers le comptoir
	pose.Neck = A(rad(-4) + tip * rad(10), sin(t * 0.45) * rad(18), sin(t * 0.7) * rad(4))
	-- mâchouille par à-coups : la paille monte, descend et tourne
	local chew = 0.5 + 0.5 * sin(t * 0.8)
	pose.Straw = A(sin(t * 7) * rad(9) * chew + sin(t * 1.3) * rad(5), sin(t * 3.1) * rad(12), 0)
end

-- Jardinière : porte la tomate à la bouche, croque, mâche ; la tomate rapetisse puis une nouvelle apparaît
local BITE_CYCLE = 6
local function tomatoPose(s, t, pose)
	local cycle = t % BITE_CYCLE
	local raise = cycle < 1 and smooth(cycle) or (cycle < 1.7 and 1 or (cycle < 2.6 and 1 - smooth((cycle - 1.7) / 0.9) or 0))
	local chewing = cycle > 1.6 and cycle < 5 and 1 or 0
	pose["Left Shoulder"] = A(rad(8), 0, rad(-26))
	pose["Right Shoulder"] = A(rad(32), 0, rad(-4)):Lerp(A(rad(128), 0, rad(-40)), raise)
	pose.Root = A(0, sin(t * 0.5) * rad(4), sin(t * 0.8) * rad(1.5))
	pose.Neck = A(raise * rad(12) + chewing * sin(t * 11) * rad(3), sin(t * 0.4) * rad(14) * (1 - raise) - raise * rad(14), 0)

	if s.Tomato then
		local index = math.floor(t / BITE_CYCLE)
		if index ~= s.LastCycle and cycle > 1.2 then -- la bouchée est prise quand la main est à la bouche
			s.LastCycle = index
			s.Bites = (s.Bites + 1) % 4
			s.Tomato.Size = s.TomatoSize * (1 - s.Bites * 0.2) -- 3 bouchées, puis une tomate entière
		end
	end
end

RunService.RenderStepped:Connect(function(dt)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	for model, s in npcs do
		if not model.Parent then
			npcs[model] = nil
			continue
		end
		s.Time += dt
		local t = s.Time
		local pose = {}
		if s.Anim == "Tomato" then tomatoPose(s, t, pose) else strawPose(s, t, pose) end

		-- respiration
		pose.Root = CFrame.new(0, sin(t * 1.8) * 0.03, 0) * (pose.Root or CFrame.new())

		-- regarde et salue le joueur
		if hrp then
			local lp = s.Root.CFrame:PointToObjectSpace(hrp.Position)
			local distance = Vector3.new(lp.X, 0, lp.Z).Magnitude
			local near = distance < WAVE_RANGE
			if near and not s.WasNear then s.WaveLeft = WAVE_TIME end
			s.WasNear = near
			if distance < LOOK_RANGE and lp.Z < 2 then
				local yaw = math.clamp(math.atan2(-lp.X, -lp.Z), -MAX_HEAD_YAW, MAX_HEAD_YAW)
				pose.Neck = A(rad(-3), yaw, 0)
			end
		end
		if s.WaveLeft > 0 then
			s.WaveLeft -= dt
			pose["Left Shoulder"] = A(rad(165), 0, rad(-18) + sin(t * 12) * rad(16)) -- bras levé qui s'agite
		end

		for name, joint in s.Joints do
			local target = pose[name] or CFrame.new()
			joint.Current = joint.Current:Lerp(target, math.min(1, dt * BLEND))
			joint.Motor.C0 = joint.Base * joint.Current
		end
	end
end)
