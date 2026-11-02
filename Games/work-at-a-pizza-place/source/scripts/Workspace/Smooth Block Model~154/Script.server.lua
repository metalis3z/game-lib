function touch(hit)
	if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		hit.Parent.Humanoid.Sit = true
	end
end
script.Parent.Touched:connect(touch)