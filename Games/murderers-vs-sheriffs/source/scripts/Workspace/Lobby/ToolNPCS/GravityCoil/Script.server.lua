local RunService = game:GetService("RunService")

local npc = script.Parent
local humanoid = npc:FindFirstChildWhichIsA("Humanoid")
if not humanoid then
	warn("[GravityCoil NPC] Humanoid missing")
	return
end

local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then
	animator = Instance.new("Animator")
	animator.Parent = humanoid
end

local idleAnimation = script:FindFirstChild("IdleAnimation")
if not idleAnimation then
	idleAnimation = Instance.new("Animation")
	idleAnimation.Name = "IdleAnimation"
	idleAnimation.Parent = script
end
idleAnimation.AnimationId = "rbxassetid://96506575561219"

local idleTrack
local function playIdle()
	if idleTrack and idleTrack.IsPlaying then
		return
	end
	local ok, result = pcall(function()
		local track = animator:LoadAnimation(idleAnimation)
		track.Priority = Enum.AnimationPriority.Idle
		track.Looped = true
		track:Play(0.2, 1, 1)
		return track
	end)
	if ok then
		idleTrack = result
	else
		warn("[GravityCoil NPC] Failed to play idle animation:", result)
	end
end

local display = npc:FindFirstChild("GravityCoilDisplay")
local lowerArm = npc:FindFirstChild("RightLowerArm")
local hand = npc:FindFirstChild("RightHand")
local anchoredOffsets = {}

local function nearestFollowPart(part)
	if not lowerArm then return hand end
	if not hand then return lowerArm end
	if part:FindFirstAncestor("HeldVisual") or part.Name == "Handle" then
		return hand
	end
	if part:FindFirstAncestor("ArmVisual") then
		return lowerArm
	end
	local handDistance = (part.Position - hand.Position).Magnitude
	local armDistance = (part.Position - lowerArm.Position).Magnitude
	return handDistance < armDistance and hand or lowerArm
end

if display then
	for _, inst in ipairs(display:GetDescendants()) do
		if inst:IsA("BasePart") and inst.Anchored then
			local followPart = nearestFollowPart(inst)
			if followPart then
				anchoredOffsets[inst] = {
					Part = followPart,
					Offset = followPart.CFrame:ToObjectSpace(inst.CFrame),
				}
			end
		end
	end
end

playIdle()
humanoid.Died:Connect(function()
	if idleTrack then
		idleTrack:Stop(0)
	end
end)

RunService.Heartbeat:Connect(function()
	if humanoid.Health > 0 then
		playIdle()
	end
	for part, data in pairs(anchoredOffsets) do
		if part.Parent and data.Part and data.Part.Parent then
			part.CFrame = data.Part.CFrame * data.Offset
		else
			anchoredOffsets[part] = nil
		end
	end
end)
