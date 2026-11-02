-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local v1 = t.union(t.instanceIsA("Model"), t.table)

return {
	SetCollisionGroup = function(p1, p2) --[[ SetCollisionGroup | Line: 20 | Upvalues: v1 (copy), Asserts (copy) ]]
		assert(v1(p1))
		Asserts.string(p2)

		local function setCollisionGroup(p1) --[[ setCollisionGroup | Line: 24 | Upvalues: p2 (copy) ]]
			if p1:IsA("BasePart") then
				p1.CollisionGroup = p2
			end
		end

		if typeof(p1) == "table" then
			for i, v in ipairs(p1) do
				if v:IsA("BasePart") then
					v.CollisionGroup = p2
				end
			end
		else
			for v2, v3 in p1:GetDescendants() do
				if v3:IsA("BasePart") then
					v3.CollisionGroup = p2
				end
			end
		end
	end,
	DisableAllPhysics = function(p1, p2, p3) --[[ DisableAllPhysics | Line: 41 | Upvalues: Asserts (copy) ]]
		Asserts.Instance(p1)
		Asserts.optional.string(p2)

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") then
				v2.CanCollide = false
				v2.CanQuery = p3 or false
				v2.CanTouch = false
				v2.Massless = true
			end
		end
	end,
	DisableCollisions = function(p1) --[[ DisableCollisions | Line: 57 | Upvalues: Asserts (copy) ]]
		Asserts.Instance(p1)

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") then
				v2.CanCollide = false
			end
		end
	end,
	SetAnchored = function(p1, p2) --[[ SetAnchored | Line: 69 | Upvalues: Asserts (copy) ]]
		Asserts.Model(p1)
		Asserts.boolean(p2)

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") then
				v2.Anchored = p2
			end
		end
	end,
	DisableHumanoidStates = function(p1) --[[ DisableHumanoidStates | Line: 82 ]]
		if not p1 then
			return
		end

		for v1, v2 in {
			Enum.HumanoidStateType.FallingDown,
			Enum.HumanoidStateType.Ragdoll,
			Enum.HumanoidStateType.GettingUp,
			Enum.HumanoidStateType.Jumping,
			Enum.HumanoidStateType.Freefall,
			Enum.HumanoidStateType.Climbing,
			Enum.HumanoidStateType.Flying,
			Enum.HumanoidStateType.Seated,
			Enum.HumanoidStateType.PlatformStanding,
			Enum.HumanoidStateType.Swimming,
			Enum.HumanoidStateType.Physics
		} do
			p1:SetStateEnabled(v2, false)
		end
	end,
	ApplyTemporaryLinearVelocity = function(p1, p2, p3, p4) --[[ ApplyTemporaryLinearVelocity | Line: 106 | Upvalues: Asserts (copy) ]]
		Asserts.BasePart(p1)
		Asserts.string(p2)
		Asserts.Vector3(p3)
		Asserts.number(p4)
		assert(p2 ~= "", "Physics.ApplyTemporaryLinearVelocity expected non-empty name")
		assert(if p4 >= 0 then true else false, "Physics.ApplyTemporaryLinearVelocity expected non-negative duration")

		local Attachment = Instance.new("Attachment")

		Attachment.Name = ("%*Attachment"):format(p2)
		Attachment.Parent = p1

		local LinearVelocity = Instance.new("LinearVelocity")

		LinearVelocity.Name = p2
		LinearVelocity.Attachment0 = Attachment
		LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
		LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		LinearVelocity.ForceLimitsEnabled = true
		LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf)
		LinearVelocity.VectorVelocity = p3
		LinearVelocity.Parent = p1
		task.delay(p4, function() --[[ Line: 134 | Upvalues: LinearVelocity (copy), Attachment (copy) ]]
			if LinearVelocity.Parent then
				LinearVelocity:Destroy()
			end

			if not Attachment.Parent then
				return
			end

			Attachment:Destroy()
		end)

		return function() --[[ Line: 143 | Upvalues: LinearVelocity (copy), Attachment (copy) ]]
			if LinearVelocity.Parent then
				LinearVelocity:Destroy()
			end

			if not Attachment.Parent then
				return
			end

			Attachment:Destroy()
		end
	end
}