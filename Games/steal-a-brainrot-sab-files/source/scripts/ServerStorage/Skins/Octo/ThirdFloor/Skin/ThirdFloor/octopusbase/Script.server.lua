

-- https://lua.expert/
if not script:IsDescendantOf(workspace) then
	return
end

local v1 = script.Parent:WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(script:WaitForChild("Animation"))

v1.Looped = true
v1:Play()