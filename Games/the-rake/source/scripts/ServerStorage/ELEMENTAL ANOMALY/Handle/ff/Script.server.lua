local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local c1 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(0,255,0)})
local c2 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(9, 137, 207)})
local c3 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(128, 187, 219)})
local c4 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(0,0,0)})
local c5 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(255,255,255)})
local c6 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(218, 133, 65)})
local c7 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(170, 85, 0)})
local c8 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(124, 92, 70)})
while true do
	wait(3)
	local color = math.random(1,8)
	if color == 1 then
		c1:Play()
	elseif color == 2 then
		c2:Play()
	elseif color == 3 then
		c3:Play()
	elseif color == 4 then
		c4:Play()
	elseif color == 5 then
		c5:Play()
	elseif color == 6 then
		c6:Play()
	elseif color == 7 then
		c7:Play()
	elseif color == 8 then
		c8:Play()
	end
end