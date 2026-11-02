local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(6,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local c1 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(0,0,0)})
local c2 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(255,255,255)})
local c3 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(75, 75, 75)})
local c4 = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(0,0,0)})

while true do
	wait(6)
	local color = math.random(1,8)
	if color == 1 then
		c1:Play()
	elseif color == 2 then
		c2:Play()
	elseif color == 3 then
		c3:Play()
	elseif color == 4 then
		c4:Play()
	end
end