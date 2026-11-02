local UvLampPower = game.Players.LocalPlayer.Character.UvLamp:WaitForChild("Power")
local UvLampMaxPower = game.Players.LocalPlayer.Character.UvLamp:WaitForChild("MaxPower")

--while true do
	--wait()
	--script.Parent:TweenSize(UDim2.new(UvLampPower.Value/0,35.5,34,0),"In","Linear",0.25)
--end

function _G.round(n)
	return n - math.floor(n) >= 0.5 and math.ceil(n) or n - math.floor(n) < 0.5 and math.floor(n)
end

local Round = (_G.round(UvLampPower.Value))

while true do
	wait()
	script.Parent.Battery.Bar.Size = UDim2.new(UvLampPower.Value/UvLampMaxPower.Value,0,1,0)
	Round = (_G.round(UvLampPower.Value))
end