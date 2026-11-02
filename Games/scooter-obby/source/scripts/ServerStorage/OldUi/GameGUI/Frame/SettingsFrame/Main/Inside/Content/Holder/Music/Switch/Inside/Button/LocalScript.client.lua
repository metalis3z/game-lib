local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.4, Enum.EasingStyle.Quad)

script.Parent.Activated:Connect(function()
	if script.Parent.Parent.Enabled.Value then
		-- function
		script.Parent.Parent.Enabled.Value = false
		for i, v in pairs(game:GetService("ReplicatedStorage").Playlist:GetChildren()) do
			if v:IsA("Sound") then
				v.Volume = 0
			end
		end
		
		-- animation
		ts:Create(script.Parent.Parent.ToggleSwitch, ti, {Position = UDim2.new(0,0,0.5,0)}):Play()
		ts:Create(script.Parent.Parent.ToggleSwitch.UIStroke, ti, {Color = Color3.fromRGB(255, 66, 66)}):Play()
		ts:Create(script.Parent.Parent.BackColor, ti, {BackgroundColor3 = Color3.fromRGB(255, 66, 66)}):Play()
	else
		-- function
		script.Parent.Parent.Enabled.Value = true
		for i, v in pairs(game:GetService("ReplicatedStorage").Playlist:GetChildren()) do
			if v:IsA("Sound") then
				v.Volume = 0.5
			end
		end
		
		-- animation
		ts:Create(script.Parent.Parent.ToggleSwitch, ti, {Position = UDim2.new(0.5,0,0.5,0)}):Play()
		ts:Create(script.Parent.Parent.ToggleSwitch.UIStroke, ti, {Color = Color3.fromRGB(76, 255, 67)}):Play()
		ts:Create(script.Parent.Parent.BackColor, ti, {BackgroundColor3 = Color3.fromRGB(76, 255, 67)}):Play()
	end
end)