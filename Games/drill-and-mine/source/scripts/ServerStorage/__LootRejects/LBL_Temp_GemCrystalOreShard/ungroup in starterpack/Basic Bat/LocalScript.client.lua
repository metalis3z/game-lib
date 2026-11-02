-- Bat Tool LocalScript (Animation + Sounds)

local Tool = script.Parent
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local ANIMATION_ID = "rbxassetid://125897969127166"
local COOLDOWN = 0.8

local debounce = false

-- Sounds
local Handle = Tool:WaitForChild("Handle")
local SwingSound = Handle:WaitForChild("Swing")
local Hit1 = Handle:WaitForChild("Hit1")
local Hit2 = Handle:WaitForChild("Hit2")

-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local BatSwingRemote = Remotes:WaitForChild("BatSwingRemote")
local BatHitConfirm = Remotes:WaitForChild("BatHitConfirm")

local animationTrack

local function playAnimation()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	if not animationTrack then
		local anim = Instance.new("Animation")
		anim.AnimationId = ANIMATION_ID
		animationTrack = animator:LoadAnimation(anim)
		animationTrack.Priority = Enum.AnimationPriority.Action
		animationTrack.Looped = false
	end

	animationTrack:Play()
end

local function playHitSound()
	if math.random(1, 2) == 1 then
		Hit1:Play()
	else
		Hit2:Play()
	end
end

Tool.Activated:Connect(function()
	if debounce then return end
	debounce = true

	playAnimation()
	SwingSound:Play()

	-- ask server to check hits
	BatSwingRemote:FireServer()

	task.delay(COOLDOWN, function()
		debounce = false
	end)
end)

-- Server tells us if we hit someone
BatHitConfirm.OnClientEvent:Connect(function(hit)
	if hit then
		playHitSound()
	end
end)
