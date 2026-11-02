local rs = game:GetService("ReplicatedStorage")

rs.TimeLeft.Changed:Connect(function(value)
	script.Parent.TextLabel.Text = value
end)

rs.RawTimeLeft.Changed:Connect(function(value)
	if value <= 10 then
		script.Parent.TextLabel.TextColor3 = Color3.new(1,0,0)
		if script.Parent.Parent.Parent.Tick.Playing == false then
			script.Parent.Parent.Parent.Tick:Play()
		end
	else
		script.Parent.TextLabel.TextColor3 = Color3.new(1,1,1)
		if script.Parent.Parent.Parent.Tick.Playing == true then
			script.Parent.Parent.Parent.Tick:Stop()
		end
	end
end)