local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local Assets = ReplicatedStorage:WaitForChild("Assets")

local Network = require(Assets.Modules.Network)
local Ragdoll = require(Assets.Modules.Ragdoll)

local hurtAnims = {
	10120476653,
	10120477583
}

function getDistance(p1, p2)
	return ((typeof(p1) == "Instance" and p1.Position or p1) - (typeof(p2) == "Instance" and p2.Position or p2)).magnitude
end

function getClampedVel(curVel, maxVel)
	local v3 = curVel.unit * math.min(maxVel, curVel.magnitude)
	if (string.find(tostring(v3), "nan")) then
		v3 = Vector3.new(1, 1, 1)
	end
	return v3
end

function isInFront(p1, pos)
	local angle = math.acos(p1.CFrame.LookVector:Dot((pos - p1.Position).unit))
	return angle < math.pi / 2
end

function playAnim(h, id)
	local animTrack = Instance.new("Animation")
	animTrack.AnimationId = "rbxassetid://" .. id
	local anim = h.Animator:LoadAnimation(animTrack)
	animTrack:Destroy()
	return anim
end

Network:BindEvents({
	["hit"] = function(client, target, part, dir, objectSpace, data)
		local character = client.Character
		local humanoid = character:FindFirstChild("Humanoid")
		if (humanoid.Health > 0 and humanoid.RootPart and typeof(target) == "Instance" and target:IsDescendantOf(workspace.Peds) and target:IsA("Model")) then
			local death = false
			if (target.Humanoid.Health > 0) then
				playAnim(target.Humanoid, hurtAnims[math.random(#hurtAnims)]):Play()
			end
			local lastHealth = target.Humanoid.Health
			local damageHit = part.Name == "Head" and data.damage * data.critical or data.damage
			if (data.shotgun.enabled) then
				damageHit = damageHit / data.shotgun.amount
			end
			target.Humanoid:SetAttribute("LastHit", tick())
			target.Humanoid:TakeDamage(damageHit)
			if (part == target.Humanoid.RootPart) then
				part = target.Torso
			end
			if (target.Humanoid.Health <= 0 and lastHealth > 0) then
				death = true
			end
			--[[if (part.Name == "Head") then
				for _,handle in pairs(target:GetDescendants()) do
					if (handle:IsA("Part") and (handle:FindFirstChild("HatAttachment") or handle:FindFirstChild("FaceFrontAttachment")) and math.random(2) == 1) then
						for _,stuff in pairs(handle:GetChildren()) do
							if (stuff:IsA("Attachment") or stuff:IsA("Weld")) then
								stuff:Destroy()
							end
						end
						handle:BreakJoints()
						handle.CanCollide = true
						handle.CollisionGroupId = 3
						local accessory = handle.Parent
						handle.Velocity = dir.unit * math.random(15, 20)
						handle.Parent = workspace.Ignored
						local connection
						connection = target.Destroying:Connect(function()
							connection:Disconnect()
							handle:Destroy()
						end)
						accessory:Destroy()
					end
				end
			end]]
			if (not death and target.Humanoid.Health <= 0 and not target.Humanoid:FindFirstChild("killed")) then
				local kill = Instance.new("StringValue")
				kill.Name = "killed"
				kill.Parent = target.Humanoid
			end
			if ((target.Humanoid.Health / target.Humanoid.MaxHealth) * 100 < 50 or math.random(2) == 1) then
				part.Velocity = dir.unit * (part.Name == "Head" and data.force + 50 or data.force)
				if (not data.forceForward) then
					for _,limb in pairs(target:GetChildren()) do
						if (limb:IsA("BasePart") and limb ~= part) then
							limb.Velocity = getClampedVel(part.Velocity, 0)
						end
					end
				end
				--[[Ragdoll.setGlobal(target, "set", true, math.random(2, 3))]]
				
				if (target:FindFirstChild("hurt")) then
					task.wait(1 / 15)
				end
				if (not target:FindFirstChild("hurt") and (target.Humanoid.Health > 0 or death)) then
					local isLeg = string.find(part.Name, "Leg")
					local force
					if (not data.forceForward) then
						force = Instance.new("BodyVelocity")
						force.MaxForce = Vector3.new(8e4, 8e4, 8e4)
						force.Velocity = dir.unit * 10
						force.Parent = part
						Debris:AddItem(force, 0.15)
					end
					
					local gyro
					--[[if (not isLeg) then
						gyro = Instance.new("BodyGyro")
						gyro.P = 100
						gyro.Parent = target.Torso
						Debris:AddItem(gyro, math.random(1, 2))
					end]]
					gyro = Instance.new("BodyGyro")
					gyro.P = 100
					gyro.Parent = target.Torso
					Debris:AddItem(gyro, isLeg and 0.8 or math.random(1, 2))
					local hurt = Instance.new("StringValue")
					hurt.Name = "hurt"
					hurt.Parent = target
					
					local collisionGroup = target.Torso.CollisionGroupId
					target.Torso.CollisionGroupId = 3
					local forceForward = Instance.new("BodyVelocity")
					forceForward.MaxForce = Vector3.new(5e3, 0, 5e3)
					forceForward.Parent = target.Torso
					
					local startTick = tick()
					local move = tick()
					local lastHealth = target.Humanoid.Health
					local damage = 5
					local stop = death and (part.Name == "Head" and (math.random(50, 450) / 100) or 4) or 6
					Ragdoll.setGlobal(target, "muscles", true, part, nil, stop)
					while target:IsDescendantOf(workspace) and target:FindFirstChild("Humanoid") and tick() - startTick < stop and (target.Humanoid.Health > 0 or death) do
						if (target.Humanoid:FindFirstChild("killed")) then
							break
						end
						
						local vel = Vector3.new(target.Humanoid.RootPart.Velocity.x, 0, target.Humanoid.RootPart.Velocity.z).magnitude
						if (vel > 0.5 and forceForward) then
							local front = isInFront(target.Torso, target.Torso.Position + dir.unit * 5)
							forceForward.Velocity = target.Torso.CFrame.LookVector * (front and 5 or -5)
							move = tick()
						else
							if (tick() - move >= 0.5) then
								forceForward:Destroy()
							else
								forceForward.Velocity = Vector3.new()
							end
						end
						if (forceForward:IsDescendantOf(workspace)) then
							target.Humanoid:TakeDamage(1)
						end
						if (gyro) then
							gyro.CFrame = CFrame.new(target.Torso.Position, target.Torso.Position + target.Torso.CFrame.LookVector * 100)
						end
						task.wait(1 / 30)
					end
					local now = 16e-6
					if (tick() - startTick >= stop - 0.1) then
						now = 1
					end
					task.delay(now, function()
						target.Torso.CollisionGroupId = collisionGroup
					end)
					forceForward:Destroy()
					if (force) then
						force:Destroy()
					end
					if (gyro) then
						gyro:Destroy()
					end
					if (lastHealth - target.Humanoid.Health >= damage or target.Humanoid.Health <= 0 or death or tick() - startTick >= stop - 0.1) then
						Ragdoll.setGlobal(target, "muscles", false, nil, now)
					end
					hurt:Destroy()
				end
			end
		end
	end,
})