local rs = game:GetService("RunService")

local ToggleAll = script.Parent.Parent.ToggleAll
local Light = script.Parent.Light
local Bulb = script.Parent.Bulb
local Spinning = false

local function updateLights()
	while Spinning do
		Light.CFrame = Light.CFrame * CFrame.Angles(math.rad(5),0,0)
		rs.Heartbeat:Wait()
	end
end

ToggleAll:GetPropertyChangedSignal("Value"):Connect(function()
	if ToggleAll.Value == true then
		Spinning = true
		Bulb.BrickColor = BrickColor.new("Really red")
		Light.SpotLight.Enabled = true
		Light.SpotLight2.Enabled = true
		spawn(updateLights)
	else
		Spinning = false
		Bulb.BrickColor = BrickColor.new("Mid gray")
		Light.SpotLight.Enabled = false
		Light.SpotLight2.Enabled = false
	end
end)
