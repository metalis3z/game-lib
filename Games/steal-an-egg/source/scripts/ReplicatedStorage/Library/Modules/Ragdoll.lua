-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = if RunService:IsServer() then require(ServerScriptService.Library.Modules.ClientCharacterAction) else nil
local t = {}
local v2 = 0
local t2 = {
	ClientRagdollRemote = script.Ragdoll
}

local function clearRagdollAttachments(p1, p2) --[[ clearRagdollAttachments | Line: 39 ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetChildren() do
		if v2.ClassName == "Attachment" then
			local v3 = v2:GetAttribute("RagdollAttachment")

			if v3 and (not p2 or v3 == p2) then
				v2:Destroy()
			end
		end
	end
end

local function clearRagdollConstraints(p1, p2) --[[ clearRagdollConstraints | Line: 56 ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetChildren() do
		local v3 = v2:GetAttribute("RagdollConstraint")

		if v3 and (not p2 or v3 == p2) and (v2.ClassName == "BallSocketConstraint" or v2.ClassName == "HingeConstraint") then
			v2:Destroy()
		end
	end
end

local function applyServerRagdollState(p1, p2) --[[ applyServerRagdollState | Line: 71 ]]
	local RootPart = p1.RootPart

	if not RootPart then
		return
	end

	p1:ChangeState(Enum.HumanoidStateType.Physics)

	if not p2 or typeof(p2) ~= "Vector3" then
		return
	end

	RootPart:ApplyImpulse(p2)
end

local function clearServerRagdollState(p1) --[[ clearServerRagdollState | Line: 85 ]]
	local RootPart = p1.RootPart

	if RootPart then
		p1:ChangeState(Enum.HumanoidStateType.GettingUp)
		RootPart.CanCollide = true
	end
end

local function createConstraintFromMotor6D(p1) --[[ createConstraintFromMotor6D | Line: 95 | Upvalues: clearRagdollConstraints (copy), clearRagdollAttachments (copy) ]]
	local Part0 = p1.Part0
	local Part1 = p1.Part1

	if not (Part0 and Part1) then
		return nil
	end

	clearRagdollConstraints(p1.Parent, p1.Name)
	clearRagdollAttachments(Part0, p1.Name)
	clearRagdollAttachments(Part1, p1.Name)

	local BallSocketConstraint = Instance.new("BallSocketConstraint")
	local Attachment = Instance.new("Attachment")
	local Attachment2 = Instance.new("Attachment")

	Attachment.Name = "RagdollAttachment_" .. p1.Name .. "_A"
	Attachment2.Name = "RagdollAttachment_" .. p1.Name .. "_B"
	Attachment:SetAttribute("RagdollAttachment", p1.Name)
	Attachment2:SetAttribute("RagdollAttachment", p1.Name)
	Attachment.Parent = Part0
	Attachment2.Parent = Part1
	BallSocketConstraint.Name = "RagdollConstraint_" .. p1.Name
	BallSocketConstraint:SetAttribute("RagdollConstraint", p1.Name)
	BallSocketConstraint.Parent = p1.Parent
	BallSocketConstraint.Attachment0 = Attachment
	BallSocketConstraint.Attachment1 = Attachment2
	Attachment.CFrame = p1.C0
	Attachment2.CFrame = p1.C1
	BallSocketConstraint.LimitsEnabled = true
	BallSocketConstraint.TwistLimitsEnabled = true

	if p1.Name ~= "Root" and p1.Name ~= "Neck" then
		return BallSocketConstraint
	end

	BallSocketConstraint:Destroy()

	local HingeConstraint = Instance.new("HingeConstraint")

	HingeConstraint.Name = "RagdollConstraint_" .. p1.Name
	HingeConstraint:SetAttribute("RagdollConstraint", p1.Name)
	HingeConstraint.Parent = p1.Parent
	HingeConstraint.Attachment0 = Attachment
	HingeConstraint.Attachment1 = Attachment2
	HingeConstraint.LimitsEnabled = true

	return HingeConstraint
end

local function destroyRagdollConstraints(p1) --[[ destroyRagdollConstraints | Line: 142 | Upvalues: clearRagdollConstraints (copy), clearRagdollAttachments (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("Motor6D") then
			local v3 = v2.Parent

			if v3 then
				clearRagdollConstraints(v3, v2.Name)
				clearRagdollAttachments(v2.Part0, v2.Name)
				clearRagdollAttachments(v2.Part1, v2.Name)
				v2.Enabled = true
			end
		end
	end
end

local function createRagdollConstraints(p1) --[[ createRagdollConstraints | Line: 159 | Upvalues: createConstraintFromMotor6D (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("Motor6D") then
			createConstraintFromMotor6D(v2)
			v2.Enabled = false
		end
	end
end

function t2.IsRagdolled(p1) --[[ IsRagdolled | Line: 172 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)

	if t[p1] ~= nil then
		return true
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	return if Humanoid == nil then false else Humanoid:GetState() == Enum.HumanoidStateType.Physics
end
function t2.Ragdoll(p1) --[[ Ragdoll | Line: 182 | Upvalues: Players (copy), v1 (copy), createRagdollConstraints (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
		return
	end

	Humanoid.BreakJointsOnDeath = false

	local v12 = Players:GetPlayerFromCharacter(p1)

	if v12 == nil then
		if Humanoid.RootPart then
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
	else
		assert(v1, "ClientCharacterAction must exist on the server").BeginRagdoll(v12, p1, 5, nil)
	end

	createRagdollConstraints(p1)
end
function t2.NpcRagdoll(p1, p2) --[[ NpcRagdoll | Line: 202 | Upvalues: createRagdollConstraints (copy), destroyRagdollConstraints (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid.BreakJointsOnDeath = false

	if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
		return
	end

	Humanoid.PlatformStand = true
	Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	createRagdollConstraints(p1)
	task.wait(p2)

	if p1 and p1.Parent then
		Humanoid.PlatformStand = false
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		destroyRagdollConstraints(p1)
	end
end
function t2.TimedRagdoll(p1, p2, p3) --[[ TimedRagdoll | Line: 230 | Upvalues: t (copy), v2 (ref), Players (copy), createRagdollConstraints (copy), v1 (copy), destroyRagdollConstraints (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	Humanoid.BreakJointsOnDeath = false

	local v12 = if Humanoid:GetState() == Enum.HumanoidStateType.Physics then true else false
	local v22 = t[p1]

	v2 = v2 + 1

	local v3 = v2

	t[p1] = {
		Token = v3,
		OwnsConstraints = if v22 then v22.OwnsConstraints else not v12
	}

	local v5 = Players:GetPlayerFromCharacter(p1)

	if v22 == nil and not v12 then
		createRagdollConstraints(p1)
	end

	if v5 == nil then
		local RootPart = Humanoid.RootPart

		if RootPart then
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)

			if p3 and typeof(p3) == "Vector3" then
				RootPart:ApplyImpulse(p3)
			end
		end
	else
		assert(v1, "ClientCharacterAction must exist on the server").BeginRagdoll(v5, p1, p2, p3)
	end

	task.wait(p2)

	local v7 = t[p1]

	if not v7 or v7.Token ~= v3 then
		return
	end

	t[p1] = nil

	local v8 = Players:GetPlayerFromCharacter(p1)

	if v8 == nil then
		local RootPart = Humanoid.RootPart

		if RootPart then
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			RootPart.CanCollide = true
		end
	else
		assert(v1, "ClientCharacterAction must exist on the server").EndRagdoll(v8, p1)
	end

	if not v7.OwnsConstraints then
		return
	end

	destroyRagdollConstraints(p1)
end
function t2.TimedRagdollAsync(p1, p2, p3) --[[ TimedRagdollAsync | Line: 278 | Upvalues: t2 (copy) ]]
	task.spawn(t2.TimedRagdoll, p1, p2, p3)
end
function t2.ApplyClientRagdoll(p1, p2) --[[ ApplyClientRagdoll | Line: 282 | Upvalues: createRagdollConstraints (copy) ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	assert(if Humanoid == nil then false else true, (("Character %* is missing Humanoid"):format((p1:GetFullName()))))
	Humanoid.BreakJointsOnDeath = false

	local v3 = if Humanoid:GetState() == Enum.HumanoidStateType.Physics then true else false
	local RootPart = Humanoid.RootPart

	if RootPart then
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)

		if p2 and typeof(p2) == "Vector3" then
			RootPart:ApplyImpulse(p2)
		end
	end

	if v3 then
		return
	end

	createRagdollConstraints(p1)
end
function t2.ClearClientRagdoll(p1) --[[ ClearClientRagdoll | Line: 295 | Upvalues: destroyRagdollConstraints (copy) ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	assert(Humanoid ~= nil, (("Character %* is missing Humanoid"):format((p1:GetFullName()))))

	local RootPart = Humanoid.RootPart

	if RootPart then
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		RootPart.CanCollide = true
	end

	destroyRagdollConstraints(p1)
end
function t2.Unragdoll(p1) --[[ Unragdoll | Line: 302 | Upvalues: Players (copy), v1 (copy), destroyRagdollConstraints (copy) ]]
	local v12 = Players:GetPlayerFromCharacter(p1)

	if v12 == nil then
		local Humanoid = p1:FindFirstChildOfClass("Humanoid")

		if Humanoid ~= nil then
			local RootPart = Humanoid.RootPart

			if RootPart then
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				RootPart.CanCollide = true
			end
		end
	else
		assert(v1, "ClientCharacterAction must exist on the server").EndRagdoll(v12, p1)
	end

	destroyRagdollConstraints(p1)
end

return t2