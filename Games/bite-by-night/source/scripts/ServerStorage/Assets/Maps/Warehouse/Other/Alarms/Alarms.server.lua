
workspace.GAME.CAN_ESCAPE:GetPropertyChangedSignal("Value"):Connect(function()
	if workspace.GAME.CAN_ESCAPE.Value == true and script.Parent:FindFirstAncestorOfClass("Workspace") then
		script.Parent.AlarmSFX:Play()
		while workspace.GAME.CAN_ESCAPE.Value == true do
			for _, thing in pairs(script.Parent:GetDescendants()) do
				if thing:IsA("BasePart") then
					thing.Orientation += Vector3.new(0,0,1)
				end
				if thing:IsA("Light") then
					thing.Enabled = true
				end
			end
			task.wait()
		end
	else
		script.Parent.AlarmSFX:Stop()
		for _, thing in pairs(script.Parent:GetDescendants()) do
			if thing:IsA("Light") then
				thing.Enabled = false
			end
		end
	end
end)