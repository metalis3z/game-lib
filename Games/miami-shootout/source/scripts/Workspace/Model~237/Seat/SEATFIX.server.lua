local defaultPosition = script.Parent.CFrame

script.Parent:GetPropertyChangedSignal("CFrame"):Connect(function()
	if script.Parent.Occupant then
		script.Parent.Occupant.Sit = false
	end
	script.Parent.CFrame = defaultPosition
end)