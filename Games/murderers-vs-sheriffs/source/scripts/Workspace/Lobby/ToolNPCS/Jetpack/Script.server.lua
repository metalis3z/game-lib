local RunService = game:GetService("RunService")

local npc = script.Parent
local humanoid = npc:FindFirstChildWhichIsA("Humanoid")
if not humanoid then
	warn("[Jetpack NPC] Humanoid missing")
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
		warn("[Jetpack NPC] Failed to play idle animation:", result)
	end
end

local display = npc:FindFirstChild("JetpackDisplay")
local torso = npc:FindFirstChild("UpperTorso") or npc:FindFirstChild("Torso") or npc:FindFirstChild("HumanoidRootPart")
local anchoredOffsets = {}

local function enableJetpackFire()
	local jetpackDisplay = npc:FindFirstChild("JetpackDisplay")
	if not jetpackDisplay then
		return
	end
	for _, inst in ipairs(jetpackDisplay:GetDescendants()) do
		if inst:IsA("ParticleEmitter") and (inst.Name:lower():find("fire") or inst:GetAttribute("JetpackDisplayFire")) then
			inst.Enabled = true
		elseif inst:IsA("PointLight") or inst:IsA("SpotLight") or inst:IsA("SurfaceLight") then
			inst.Enabled = true
		end
	end
end

enableJetpackFire()

if display and torso then
	for _, inst in ipairs(display:GetDescendants()) do
		if inst:IsA("BasePart") and inst.Anchored then
			anchoredOffsets[inst] = torso.CFrame:ToObjectSpace(inst.CFrame)
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
	if torso then
		for part, offset in pairs(anchoredOffsets) do
			if part.Parent then
				part.CFrame = torso.CFrame * offset
			else
				anchoredOffsets[part] = nil
			end
		end
	end
end)
