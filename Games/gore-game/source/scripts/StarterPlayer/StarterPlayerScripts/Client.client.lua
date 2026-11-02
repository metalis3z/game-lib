local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local Assets = ReplicatedStorage:WaitForChild("Assets")

local Peds = workspace.Peds

function findHumanoid(p)
	if (p.Parent and p.Parent:FindFirstChild("Humanoid")) then
		return p.Parent
	end

	if (p.Parent and not p.Parent == workspace) then
		return findHumanoid(p.Parent)
	end

	return false
end

function getRandomChild(parent)
	return parent:GetChildren()[math.random(#parent:GetChildren())]
end

function playsound(sound, parent, pitch)
	local isPos = typeof(parent) == "Vector3"
	if (isPos) then
		local pos = parent
		parent = Instance.new("Attachment")
		parent.WorldPosition = pos
		parent.Parent = workspace.Terrain
	end

	local sound = sound:Clone()
	sound.PlaybackSpeed = pitch and sound.PlaybackSpeed + (math.random() * pitch) or sound.PlaybackSpeed
	sound.Parent = parent
	sound:Play()
	Debris:AddItem(isPos and parent or sound, sound.TimeLength + 1)
	return sound
end

function handleImpact(p)
	task.wait(1 / 30)
	for _,part in pairs(p:GetChildren()) do
		if (part:IsA("BasePart") and part.Name ~= "HumanoidRootPart") then
			local lastVel = 0
			part.Touched:Connect(function(hit)
				if (not findHumanoid(hit) and not hit:IsDescendantOf(workspace.Ignored) and p.Humanoid:GetAttribute("Ragdoll")) then
					lastVel = part.Velocity.magnitude
				end
			end)
			
			part.TouchEnded:Connect(function(hit)
				if (not findHumanoid(hit) and not hit:IsDescendantOf(workspace.Ignored) and p.Humanoid:GetAttribute("Ragdoll")) then
					local vel = part.Velocity.magnitude - lastVel
					if (vel > 1.5) then
						if (vel < 4.5) then
							playsound(getRandomChild(Assets.Sounds.collision_impact), part, 1.5)
						else
							playsound(getRandomChild(Assets.Sounds.collision_impact1), part, 1.5)
						end
					end
				end
			end)
		end
	end
end

-- // handle npcs
for _,character in pairs(Peds:GetChildren()) do
	handleImpact(character)
end
Peds.ChildAdded:Connect(handleImpact)
Peds.ChildRemoved:Connect(handleImpact)