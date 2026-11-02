local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local c1 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(58, 125, 21)})
local c2 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(0,255,0)})

while true do
	wait(4)
	local color = math.random(1,8)
	if color == 1 then
		c1:Play()
	elseif color == 2 then
		c2:Play()
	end
end