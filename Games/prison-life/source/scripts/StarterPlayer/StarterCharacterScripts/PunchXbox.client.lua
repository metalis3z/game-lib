local uis = game:GetService("UserInputService")

--CanDoDmg = true -- If the player can do damage
local Keybind = Enum.KeyCode.DPadUp -- Keybind to activate the punch
--dmg = 15 -- How much damage the player takes
local RStorage = game:GetService("ReplicatedStorage")

local plr = game.Players.LocalPlayer
--local Remotes = RStorage:WaitForChild("Remotes")
local Punch = RStorage.Punch:WaitForChild("Punch")
local Animation = script:WaitForChild("Animation")
local CanDamage = true
local OneTime = true
local connection

uis.InputBegan:Connect(function(key)
	if key == Keybind then

		if CanDamage == false then
			CanDamage = true

			Punch:InvokeServer()

			CanDamage = false
		end 
	end
end)