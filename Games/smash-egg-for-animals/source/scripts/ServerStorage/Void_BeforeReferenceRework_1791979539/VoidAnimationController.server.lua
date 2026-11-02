local boss = script.Parent
local humanoid = boss:WaitForChild("Humanoid")

local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then
	animator = Instance.new("Animator")
	animator.Parent = humanoid

end

local idleAnimation = boss:WaitForChild("Void_Idle")
local runAnimation = boss:WaitForChild("Void_Run")

local idle = animator:LoadAnimation(idleAnimation)
idle.Looped = true
idle.Priority = Enum.AnimationPriority.Idle

local run = animator:LoadAnimation(runAnimation)
run.Looped = true
run.Priority = Enum.AnimationPriority.Movement

local moving = false

local function setMoving(isMoving, speed)
	if isMoving == moving then
		if isMoving then
			run:AdjustSpeed(math.clamp(speed / 10, 0.65, 1.4))
		end
		return
	end

	moving = isMoving

	if moving then
		idle:Stop(0.2)
		run:Play(0.2)
		run:AdjustSpeed(math.clamp(speed / 10, 0.65, 1.4))
	else
		run:Stop(0.2)
		idle:Play(0.2)
	end
end

idle:Play(0.2)

-- Les deux seules animations de Void changent suivant sa vitesse réelle.
humanoid.Running:Connect(function(speed)
	setMoving(speed > 0.5, speed)

end)
