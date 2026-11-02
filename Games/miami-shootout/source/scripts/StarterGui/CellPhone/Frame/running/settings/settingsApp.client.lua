local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local callsEnabled = true

script.Parent.calls.MouseButton1Click:Connect(function()
	if callsEnabled == true then
		callsEnabled = false
		game.ReplicatedStorage.PhoneStuff.DisablePhone:FireServer(callsEnabled)
		script.Parent.calls.Text = "Calls: OFF"
		script.Parent.calls.BackgroundColor3 = Color3.fromRGB(255,0,0)
	else
		callsEnabled = true
		game.ReplicatedStorage.PhoneStuff.DisablePhone:FireServer(callsEnabled)
		script.Parent.calls.Text = "Calls: ON"
		script.Parent.calls.BackgroundColor3 = Color3.fromRGB(0,255,0)
	end
end)