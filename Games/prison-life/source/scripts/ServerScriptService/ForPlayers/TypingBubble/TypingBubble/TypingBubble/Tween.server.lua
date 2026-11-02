local TweenService = game:GetService("TweenService")

while true do
	local TweenUp = TweenService:Create(script.Parent, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, -0.1, 0)})	
	TweenUp:Play()
	wait(1)
	local TweenDown = TweenService:Create(script.Parent, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)})	
	TweenDown:Play()
	wait(1)
end