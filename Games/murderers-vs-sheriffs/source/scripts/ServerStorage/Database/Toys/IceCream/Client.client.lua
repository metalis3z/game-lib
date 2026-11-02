local Tool = script.Parent
local eatAnimation = Instance.new("Animation")
eatAnimation.AnimationId = "rbxassetid://129961458659723"

local isOnCooldown = false

Tool.Activated:Connect(function()
	if isOnCooldown then return end
	isOnCooldown = true

	local character = Tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end

		local track = animator:LoadAnimation(eatAnimation)
		track:Play()
	end

	task.wait(3)
	isOnCooldown = false
end)
	