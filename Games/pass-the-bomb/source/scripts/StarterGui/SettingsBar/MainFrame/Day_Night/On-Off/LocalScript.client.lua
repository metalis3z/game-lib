local lighting = game.Lighting
local on = true 

script.Parent.MouseButton1Click:Connect(function()
	if lighting.ClockTime == 18 and on == true then 
		on = false
		lighting.ClockTime = 14
		script.Parent.Parent["On-Off"].Text = "Day" 
	else
		on = true
		lighting.ClockTime = 18
		script.Parent.Parent["On-Off"].Text = "Night"
	end
end)

