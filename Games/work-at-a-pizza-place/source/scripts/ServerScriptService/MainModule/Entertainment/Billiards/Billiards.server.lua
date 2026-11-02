--[[debounce = false
function touch(hit)
	if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		script.Parent.Velocity = hit.Parent.Torso.CFrame.lookVector * 10
	end
end
	
script.Parent.Touched:connect(touch)]]
