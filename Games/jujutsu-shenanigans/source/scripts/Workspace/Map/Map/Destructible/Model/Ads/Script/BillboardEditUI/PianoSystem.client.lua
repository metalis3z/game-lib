local TweenService = game:GetService("TweenService")

local Value_upvr = script.Parent.Remote.Value
local TweenInfo_new_result1 = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
TweenService:Create(script.Parent.TextBox, TweenInfo_new_result1, {
	Position = UDim2.new(0.5, 0, 0.5, 0);
	BackgroundTransparency = 0.5;
	TextTransparency = 0;
}):Play()
TweenService:Create(script.Parent.TextBox.UIStroke, TweenInfo_new_result1, {
	Transparency = 0;
}):Play()
TweenService:Create(script.Parent.TextBox.TextButton, TweenInfo_new_result1, {
	BackgroundTransparency = 0.5;
	TextTransparency = 0;
}):Play()
TweenService:Create(script.Parent.TextBox.TextButton.UIStroke, TweenInfo_new_result1, {
	Transparency = 0;
}):Play()
TweenService:Create(script.Parent.TextBox.Warnng, TweenInfo_new_result1, {
	TextTransparency = 0;
}):Play()
script.Parent.TextBox.FocusLost:Connect(function(arg1) -- Line 13
	if not arg1 then
		
	else
		Value_upvr:FireServer(script.Parent.Promptobj.Value, script.Parent.TextBox.Text, game.Players.LocalPlayer)
		script.Parent:Destroy()
	end
end)
script.Parent.TextBox.TextButton.MouseButton1Down:Connect(function() -- Line 19
	Value_upvr:FireServer(script.Parent.Promptobj.Value, script.Parent.TextBox.Text, game.Players.LocalPlayer)
	script.Parent:Destroy()
end)