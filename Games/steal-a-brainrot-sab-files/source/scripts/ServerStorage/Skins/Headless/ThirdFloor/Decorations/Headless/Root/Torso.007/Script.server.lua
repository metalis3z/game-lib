local TweenService = game:GetService("TweenService")

local bone = script.Parent
local moveAmount = 1
local moveTime = 1.5

local originalPosition = bone.Position

local tweenInfo = TweenInfo.new(
	moveTime,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false
)

while true do
	if script:IsDescendantOf(workspace) then
		local upTween = TweenService:Create(bone, tweenInfo, {
			Position = originalPosition + Vector3.new(0, moveAmount, 0)
		})
		upTween:Play()
		upTween.Completed:Wait()

		local downTween = TweenService:Create(bone, tweenInfo, {
			Position = originalPosition - Vector3.new(0, moveAmount, 0)
		})
		downTween:Play()
		downTween.Completed:Wait()
	else
		task.wait(0.1)
	end
end