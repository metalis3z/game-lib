local player = game.Players.LocalPlayer
local RemotePunch = game.ReplicatedStorage:WaitForChild("Punch"):WaitForChild("Punch")

local Keybind = "f" -- Keybind to activate the punch

local mouse = player:GetMouse()

local punchValue = false

mouse.KeyDown:Connect(function(key)
	if key == Keybind then
		if punchValue == false then
			punchValue = true
			
			RemotePunch:InvokeServer()
			
			punchValue = false
		end 
	end
end)