-- PNJ R15 taggés "LookAtNpc" : ils respirent, suivent le joueur du regard (tête + buste) quand il approche,
-- le saluent de la main une fois, puis croisent un bras en attendant.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local TAG = "LookAtNpc"
local LOOK_RANGE = 26     -- distance à laquelle il commence à regarder
local WAVE_RANGE = 15     -- distance à laquelle il salue
local WAVE_TIME = 2.2
local rad, sin, clamp, min = math.rad, math.sin, math.clamp, math.min

local player = Players.LocalPlayer
local npcs = {}

local function track(model)
	task.spawn(function()
		local torso = model:WaitForChild("UpperTorso", 10)
		local head = model:WaitForChild("Head", 10)
		if not torso or not head or npcs[model] then return end
		local function joint(partName, jointName)
			local part = model:FindFirstChild(partName)
			local motor = part and part:FindFirstChild(jointName)
			return motor and {Motor = motor, Base = motor.C0} or nil
		end
		npcs[model] = {
			Torso = torso,
			Neck = joint("Head", "Neck"), Waist = joint("UpperTorso", "Waist"),
			RightShoulder = joint("RightUpperArm", "RightShoulder"), RightElbow = joint("RightLowerArm", "RightElbow"),
			LeftShoulder = joint("LeftUpperArm", "LeftShoulder"), LeftElbow = joint("LeftLowerArm", "LeftElbow"),
			Yaw = 0, Pitch = 0, Near = 0, Wave = 0, WaveStart = nil, Greeted = false, Time = math.random() * 10,
		}
	end)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(track)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(model) npcs[model] = nil end)
for _, model in CollectionService:GetTagged(TAG) do track(model) end

local function set(j, cf)
	if j then j.Motor.C0 = j.Base * cf end
end

RunService.RenderStepped:Connect(function(dt)
	local character = player.Character
	local target = character and character:FindFirstChild("Head")
	for model, s in npcs do
		if s.Torso.Parent then
			s.Time += dt
			local t = s.Time
			local wantYaw, wantPitch, near = 0, 0, 0
			if target then
				local root = model.PrimaryPart or s.Torso
				local toPlayer = target.Position - (root.Position + Vector3.new(0, 2.5, 0))
				local distance = toPlayer.Magnitude
				if distance < LOOK_RANGE then
					near = 1
					local localDir = root.CFrame:VectorToObjectSpace(toPlayer) -- l'avant du PNJ est -Z
					wantYaw = clamp(math.atan2(-localDir.X, -localDir.Z), rad(-85), rad(85))
					wantPitch = clamp(math.atan2(localDir.Y, math.sqrt(localDir.X ^ 2 + localDir.Z ^ 2)), rad(-25), rad(40))
				end
				if distance < WAVE_RANGE and not s.Greeted then
					s.Greeted, s.WaveStart = true, t
				elseif distance > LOOK_RANGE then
					s.Greeted = false -- il resaluera à la prochaine visite
				end
			end
			s.Near += (near - s.Near) * min(1, dt * 4)
			s.Yaw += (wantYaw - s.Yaw) * min(1, dt * 5)
			s.Pitch += (wantPitch - s.Pitch) * min(1, dt * 5)
			local waving = s.WaveStart and t - s.WaveStart < WAVE_TIME
			s.Wave += ((waving and 1 or 0) - s.Wave) * min(1, dt * 7)

			local breath = sin(t * 1.8)
			-- le buste prend une partie de la rotation, la tête le reste
			set(s.Waist, CFrame.Angles(rad(1.5) * breath, s.Yaw * 0.35, 0))
			set(s.Neck, CFrame.Angles(s.Pitch * 0.8 + rad(2) * sin(t * 0.9), s.Yaw * 0.65, rad(4) * sin(t * 0.6) * (1 - s.Near)))
			-- bras droit : salut de la main ; sinon, main sur la hanche
			local w = s.Wave
			set(s.RightShoulder, CFrame.Angles(rad(-10) * w, 0, rad(18) * (1 - w) + rad(158) * w))
			set(s.RightElbow, CFrame.Angles(0, 0, rad(-50) * (1 - w) + (rad(-20) + sin(t * 11) * rad(24)) * w))
			-- bras gauche : léger balancement
			set(s.LeftShoulder, CFrame.Angles(rad(4) * breath, 0, rad(-6) - rad(2) * breath))
			set(s.LeftElbow, CFrame.Angles(rad(8) + rad(3) * breath, 0, 0))
		end
	end
end)
