local Sound = script.Parent.Handle.Sound

Sound.Changed:Connect(function()
	if Sound.Playing == true then
		script.Parent.Parent.Stamina.Value = script.Parent.Parent.Stamina.Value - 1
	end
end)