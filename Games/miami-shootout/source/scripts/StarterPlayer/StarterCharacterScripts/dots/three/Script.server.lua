local tweenservice = game:GetService("TweenService")
while true do
	local goals = {}
	goals.ImageTransparency = 0
	goals.Size = UDim2.new(0.1,0,0.1,0)
	local tween = tweenservice:Create(script.Parent,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),goals)
	tween:Play()
	wait(0.52)
	local goals2 = {}
	goals2.ImageTransparency = 0.5
	goals2.Size = UDim2.new(0.05,0,0.05,0)
	local tween2 = tweenservice:Create(script.Parent,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),goals2)
	tween2:Play()
	wait(0.52)
end