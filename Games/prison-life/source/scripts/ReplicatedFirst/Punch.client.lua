local Players = game:GetService("Players")
local RStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Remotes = RStorage:WaitForChild("Remotes")
local Punch = Remotes:WaitForChild("Punch")
local Mouse = Player:GetMouse()
local Animation = script:WaitForChild("Animation")
local CanDamage = true

Mouse.KeyDown:connect(function(Key)
	if Key == "f" then
		if CanDamage then
			CanDamage = false
			
			local Humanoid = Character:WaitForChild("Humanoid")
			local PunchAnimation = Humanoid:LoadAnimation(Animation)
			
			PunchAnimation:Play()
			Punch:FireServer()
			wait(0.7)
			CanDamage = true
		end
	end
end)