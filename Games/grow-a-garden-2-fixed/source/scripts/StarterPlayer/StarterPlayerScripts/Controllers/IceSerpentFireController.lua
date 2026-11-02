--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local t = {}
local t2 = {}

local function GetAssets() --[[ GetAssets | Line: 23 | Upvalues: ReplicatedStorage (copy) ]]
	return ReplicatedStorage:FindFirstChild("Assets")
end

local function FindDragonModel(p1) --[[ FindDragonModel | Line: 30 ]]
	local _PetVisualClient = workspace:FindFirstChild("_PetVisualClient")
	local v1 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else _PetVisualClient

	if not v1 then
		return nil
	end

	local v2 = p1.Parent and p1.Parent.Name

	for k, v in pairs(v1:GetChildren()) do
		if v:IsA("Model") and (v:GetAttribute("OwnerSlot") == p1.Name and (not v2 or v:GetAttribute("Owner") == v2)) then
			return v
		end
	end

	return nil
end

local function FindMouthPart(p1) --[[ FindMouthPart | Line: 46 ]]
	for k, v in pairs({ "Mouth", "FireOrigin", "Head" }) do
		local v1 = p1:FindFirstChild(v, true)

		if v1 and v1:IsA("BasePart") then
			return v1
		end
	end

	return p1.PrimaryPart
end

local function FindFireEmitterTemplate() --[[ FindFireEmitterTemplate | Line: 54 | Upvalues: ReplicatedStorage (copy) ]]
	local Assets = ReplicatedStorage:FindFirstChild("Assets")
	local v1 = if Assets then Assets:FindFirstChild("VFX") else Assets

	if not v1 then
		return nil
	end

	local OtherStorage = v1:FindFirstChild("OtherStorage")
	local v2 = if OtherStorage then OtherStorage:FindFirstChild("IceFireEmitter") else OtherStorage

	if v2 and v2:IsA("Attachment") then
		return v2
	end

	local StatusVFX = v1:FindFirstChild("StatusVFX")
	local v3 = if StatusVFX then StatusVFX:FindFirstChild("BurningVFX") else StatusVFX
	local v4 = if v3 then v3:FindFirstChild("fire") else v3

	if v4 and v4:IsA("ParticleEmitter") then
		return v4
	end

	return nil
end

local function GetHRP(p1) --[[ GetHRP | Line: 71 ]]
	if not p1 then
		return nil
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart
	end

	return nil
end

local function GetModelScale(p1) --[[ GetModelScale | Line: 82 ]]
	local ok, result = pcall(function() --[[ Line: 83 | Upvalues: p1 (copy) ]]
		return p1:GetScale()
	end)

	if ok and (type(result) == "number" and result > 0) then
		return result
	end

	return 1
end

local function ScaleNumberSequence(p1, p2) --[[ ScaleNumberSequence | Line: 90 ]]
	local t = {}

	for k, v in pairs(p1.Keypoints) do
		table.insert(t, NumberSequenceKeypoint.new(v.Time, v.Value * p2, v.Envelope * p2))
	end

	return NumberSequence.new(t)
end

local function ScaleBreathVFX(p1, p2) --[[ ScaleBreathVFX | Line: 100 | Upvalues: ScaleNumberSequence (copy) ]]
	if p2 == 1 then
		return
	end

	local v1 = p1:GetDescendants()

	table.insert(v1, p1)

	for k, v in pairs(v1) do
		if v:IsA("Beam") then
			v.Width0 = v.Width0 * p2
			v.Width1 = v.Width1 * p2

			continue
		end

		if v:IsA("ParticleEmitter") then
			v.Size = ScaleNumberSequence(v.Size, p2)
		end
	end
end

local function PlayBreathe(p1, p2) --[[ PlayBreathe | Line: 115 ]]
	local AnimationController = p1:FindFirstChildOfClass("AnimationController")
	local v1 = AnimationController and AnimationController:FindFirstChildOfClass("Animator")

	if not v1 then
		return
	end

	local Animations = p1:FindFirstChild("Animations")
	local v2 = p1:FindFirstChild("Animations") and Animations:FindFirstChild("Breathe") or p1:FindFirstChild("Breathe")

	if not (v2 and v2:IsA("Animation")) then
		return
	end

	local ok, result = pcall(function() --[[ Line: 125 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1:LoadAnimation(v2)
	end)

	if ok and result then
		result.Looped = true
		result.Priority = Enum.AnimationPriority.Action
		result:Play(0.15)
		task.delay(p2, function() --[[ Line: 132 | Upvalues: result (copy) ]]
			if not (result and result.IsPlaying) then
				return
			end

			result:Stop(0.2)
		end)
	end
end

local function StartBeam(p1, p2, p3, p4) --[[ StartBeam | Line: 138 | Upvalues: FindMouthPart (copy), FindFireEmitterTemplate (copy), ScaleBreathVFX (copy), t2 (copy), PlayBreathe (copy), RunService (copy), Debris (copy) ]]
	local v1 = FindMouthPart(p2)

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 83 | Upvalues: p2 (copy) ]]
		return p2:GetScale()
	end)
	local v2 = if ok and (type(result) == "number" and result > 0) then result else 1
	local IceSerpentFireBeam = Instance.new("Part")

	IceSerpentFireBeam.Name = "IceSerpentFireBeam"
	IceSerpentFireBeam.Anchored = true
	IceSerpentFireBeam.CanCollide = false
	IceSerpentFireBeam.CanQuery = false
	IceSerpentFireBeam.CanTouch = false
	IceSerpentFireBeam.Massless = true
	IceSerpentFireBeam.Transparency = 1
	IceSerpentFireBeam.Size = Vector3.new(v2 * 0.2, v2 * 0.2, 1)
	IceSerpentFireBeam.Parent = workspace

	local v3 = nil
	local v4 = nil
	local v5 = FindFireEmitterTemplate()

	if v5 then
		local v6 = v5:Clone()

		v6.Parent = IceSerpentFireBeam
		ScaleBreathVFX(v6, v2)

		if v6:IsA("Attachment") then
			v6.Position = Vector3.new(0, 0, -0.5)

			local Attachment = Instance.new("Attachment")

			Attachment.Parent = IceSerpentFireBeam
			v3 = v6
			v4 = Attachment

			for k, v in pairs(v6:GetDescendants()) do
				if v:IsA("Beam") then
					v.Attachment0 = v6
					v.Attachment1 = Attachment
					v.Enabled = true
				end
			end
		end
	end

	local t = {}
	local v7 = t2[p1]

	if v7 and v7.Beam then
		v7.Token = t

		if v7.Beam.Parent then
			v7.Beam:Destroy()
		end
	end

	t2[p1] = {
		Token = t,
		Beam = IceSerpentFireBeam
	}
	PlayBreathe(p2, p4)

	local v8 = os.clock() + p4
	local v9 = nil

	v9 = RunService.RenderStepped:Connect(function() --[[ Line: 197 | Upvalues: t2 (ref), p1 (copy), t (copy), v8 (copy), IceSerpentFireBeam (copy), v1 (copy), v9 (ref), p3 (copy), v2 (copy), v3 (ref), v4 (ref) ]]
		local v12 = t2[p1]

		if v12 and (v12.Token == t and (not (v8 <= os.clock()) and (IceSerpentFireBeam.Parent and v1.Parent))) then
			local Position = v1.Position
			local v22 = p3
			local v32

			if v22 then
				local HumanoidRootPart = v22:FindFirstChild("HumanoidRootPart")

				v32 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
			else
				v32 = nil
			end

			local v42 = if v32 then v32.Position else Position + v1.CFrame.LookVector * 10
			local v5 = math.min((v42 - Position).Magnitude, 60)

			if v5 < 0.1 then
				v5 = 0.1
			end

			IceSerpentFireBeam.Size = Vector3.new(v2 * 0.2, v2 * 0.2, v5)
			IceSerpentFireBeam.CFrame = CFrame.lookAt(Position, v42) * CFrame.new(0, 0, -v5 * 0.5)

			if v3 then
				v3.WorldCFrame = CFrame.lookAt(Position, v42)
			end

			if not v4 then
				return
			end

			v4.WorldPosition = v42
		else
			if not v9 then
				return
			end

			v9:Disconnect()
		end
	end)
	task.delay(p4, function() --[[ Line: 219 | Upvalues: v9 (ref), t2 (ref), p1 (copy), t (copy), IceSerpentFireBeam (copy), Debris (ref) ]]
		if v9 then
			v9:Disconnect()
		end

		local v1 = t2[p1]

		if v1 and v1.Token ~= t then
			return
		end

		t2[p1] = nil

		for k, v in pairs(IceSerpentFireBeam:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false

				continue
			end

			if v:IsA("Beam") then
				v.Enabled = false
			end
		end

		Debris:AddItem(IceSerpentFireBeam, 2)
	end)
end

function t.Init(p1) --[[ Init | Line: 239 ]] end
function t.Start(p1) --[[ Start | Line: 241 | Upvalues: Networking (copy), FindDragonModel (copy), StartBeam (copy) ]]
	Networking.IceSerpent.BreathStart.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 242 | Upvalues: FindDragonModel (ref), StartBeam (ref) ]]
		if typeof(p1) ~= "Instance" then
			return
		end

		if type(p3) ~= "number" or p3 <= 0 then
			return
		end

		local v1 = FindDragonModel(p1)

		if v1 then
			StartBeam(p1, v1, p2, p3)
		end
	end)
end

return t