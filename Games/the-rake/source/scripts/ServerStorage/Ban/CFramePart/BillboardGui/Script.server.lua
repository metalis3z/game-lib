local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local appear = ts:Create(script.Parent.TextLabel,tweenInfo,{TextTransparency = 0,TextStrokeTransparency = 0})
local disappear = ts:Create(script.Parent.TextLabel,tweenInfo,{TextTransparency = 1,TextStrokeTransparency = 1})

script.Parent.Parent.Parent.Kicked.Changed:Connect(function()
	if script.Parent.Parent.Parent.Kicked.Value == true then
		script.Parent.Parent.Parent.Kicked.Value = false
		appear:Play()
		wait(3)
		disappear:Play()
	end
end)