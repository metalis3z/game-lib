debounce = false



function touch(hit)
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") and  hit.Parent.HumanoidRootPart:FindFirstChild("BodyVelocity") == nil then
		debounce = true
		hit.Parent.Humanoid.Sit = true
		wait(4)
		
		debounce = false
	end
end
script.Parent.Touched:connect(touch)