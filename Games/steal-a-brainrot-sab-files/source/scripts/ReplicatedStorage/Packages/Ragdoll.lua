
local t1 = {}
local Ragdoll = script.Ragdoll

local ragdollEvent = Instance.new("BindableEvent")

function t1.Ragdoll(p1)
	local Humanoid = p1:WaitForChild("Humanoid")

	if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
		return
	end

	Humanoid.BreakJointsOnDeath = false

	for _, descendant in pairs(p1:GetDescendants()) do
		if not descendant:IsA("Motor6D") then
			continue
		end

		if not Ragdoll then
			return
		end

		local BallSocketConstraint = Instance.new("BallSocketConstraint")
		local Attachment = Instance.new("Attachment")
		local Attachment2 = Instance.new("Attachment")

		Attachment.Parent = descendant.Part0
		Attachment2.Parent = descendant.Part1
		BallSocketConstraint.Parent = descendant.Parent

		local player = game.Players:GetPlayerFromCharacter(p1)

		Ragdoll:FireClient(player, nil, "manualM")
		BallSocketConstraint.Attachment0 = Attachment
		BallSocketConstraint.Attachment1 = Attachment2
		Attachment.CFrame = descendant.C0
		Attachment2.CFrame = descendant.C1
		BallSocketConstraint.LimitsEnabled = true

		local NoCollisionConstraint = Instance.new("NoCollisionConstraint")

		NoCollisionConstraint.Part0 = descendant.Part0
		NoCollisionConstraint.Part1 = Humanoid.RootPart
		NoCollisionConstraint.Parent = descendant.Parent

		if descendant.Name == "Root" then
			BallSocketConstraint:Destroy()

			local HingeConstraint = Instance.new("HingeConstraint")

			HingeConstraint.Attachment0 = Attachment
			HingeConstraint.Attachment1 = Attachment2
			HingeConstraint.LimitsEnabled = true
			HingeConstraint.Parent = descendant.Parent
		end

		if descendant.Name == "Neck" then
			BallSocketConstraint:Destroy()

			local HingeConstraint = Instance.new("HingeConstraint")

			HingeConstraint.Attachment0 = Attachment
			HingeConstraint.Attachment1 = Attachment2
			HingeConstraint.LimitsEnabled = true
			HingeConstraint.Parent = descendant.Parent
		end

		BallSocketConstraint.TwistLimitsEnabled = true
		descendant.Enabled = false
	end

	ragdollEvent:Fire(p1, true)
end

function t1.Unragdoll(p2)
	for _, descendant in pairs(p2:GetDescendants()) do
		if not descendant:IsA("Motor6D") then
			continue
		end

		if not Ragdoll then
			return
		end

		if descendant.Part0 and descendant.Part1 then
			p2:WaitForChild("Humanoid")

			local v17 = descendant.Parent:FindFirstChild("BallSocketConstraint") or descendant.Parent:FindFirstChild("HingeConstraint")
			local NoCollisionConstraint = descendant.Parent:FindFirstChild("NoCollisionConstraint")
			local Attachment = descendant.Part0:FindFirstChild("Attachment")
			local Attachment3 = descendant.Part1:FindFirstChild("Attachment")

			if v17 then
				v17:Destroy()
			end

			if NoCollisionConstraint then
				NoCollisionConstraint:Destroy()
			end

			if Attachment then
				Attachment:Destroy()
			end

			if Attachment3 then
				Attachment3:Destroy()
			end

			local player = game.Players:GetPlayerFromCharacter(p2)

			Ragdoll:FireClient(player, nil, "manualD")
			descendant.Enabled = true
		end
	end

	ragdollEvent:Fire(p2, false)
end

t1.TimedRagdoll = function(character, duration)
	t1.Ragdoll(character)
	task.delay(duration, function()
		if character and character.Parent then
			t1.Unragdoll(character)
		end
	end)
end

function t1.OnRagdoll(callback)
	return ragdollEvent.Event:Connect(callback)
end

return t1