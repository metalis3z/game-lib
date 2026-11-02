
if not script:IsDescendantOf(workspace) then
	return
end

local CarAnimationLoop = script.CarAnimationLoop
local track = script.Parent:WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(CarAnimationLoop)

track.Looped = true
track:Play()
track:AdjustSpeed(0.33)
