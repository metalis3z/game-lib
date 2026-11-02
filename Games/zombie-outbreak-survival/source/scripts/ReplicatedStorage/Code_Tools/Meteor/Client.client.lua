local Event = script.Parent:WaitForChild("Activated")
local Tool = script.Parent
local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local Mouse = Player:GetMouse()

local db = false

Tool.Activated:Connect(function()
	if not db then
		if character:FindFirstChild("Humanoid").Health < 1 then return end

		db = true

		local HitLocation = Mouse.Hit

		if HitLocation then
			Event:FireServer(HitLocation)
		end

		wait(0.5)

		db = false
	end
end)