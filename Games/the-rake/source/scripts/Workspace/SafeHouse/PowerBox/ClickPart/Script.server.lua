script.Parent.Parent.Parent.SlidingDoor.Open.Changed:Connect(function()
	if script.Parent.Parent.Parent.SlidingDoor.Open.Value == true then
		script.Parent.ProximityPrompt.Enabled = false
	elseif script.Parent.Parent.Parent.SlidingDoor.Open.Value == false then
		script.Parent.ProximityPrompt.Enabled = true
	end
end)