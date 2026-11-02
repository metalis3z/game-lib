local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MultiplierVisible = ReplicatedStorage:WaitForChild("MultiplierVisible")
local Multiplies = ReplicatedStorage:WaitForChild("Multiplies")
local TimerTag = ReplicatedStorage:WaitForChild("TimerTag")
local Minutes = ReplicatedStorage:WaitForChild("Minutes")
local Seconds = ReplicatedStorage:WaitForChild("Seconds")
local Timer = script.Parent:WaitForChild("Timer")
local Multiplier = script.Parent:WaitForChild("Multiplier")

local Red = Color3.new(0.986007, 0, 0.027039)
local Green = Color3.new(0.155673, 1, 0.0251316)
local White = Color3.new(1, 1, 1)

Minutes.Changed:Connect(function()
	if Minutes.Value == 0 then
		Timer.TextColor3 = Red
	else
		Timer.TextColor3 = White
	end
end)

Seconds.Changed:Connect(function()
	if MultiplierVisible.Value == true then
		Multiplier.Visible = true
		Timer.TextColor3 = Green
	else
		Multiplier.Visible = false
		Timer.TextColor3 = White
	end

	Multiplier.Text = "x"..Multiplies.Value
	Timer.Text = TimerTag.Value
end)