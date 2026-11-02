local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DoorMessage = ReplicatedStorage:WaitForChild("DoorMessage")
local TimerSpeed = ReplicatedStorage:WaitForChild("TimerSpeed")
local MultiplierVisible = ReplicatedStorage:WaitForChild("MultiplierVisible")
local Multiplies = ReplicatedStorage:WaitForChild("Multiplies")
local Minutes = ReplicatedStorage:WaitForChild("Minutes")
local Seconds = ReplicatedStorage:WaitForChild("Seconds")

local Winners = {}

script.Parent.Touched:Connect(function(hit)
	if not hit.Parent:FindFirstChild("Humanoid") then return end
	local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not Player then return end
	if table.find(Winners, Player.UserId) then return end
	table.insert(Winners, Player.UserId)
	TimerSpeed.Value = TimerSpeed.Value / 2 -- Speeds up timer
	DoorMessage:FireAllClients(Player) -- Sends the win message in chat
	MultiplierVisible.Value = true -- Makes the "x2" visible
	Multiplies.Value = Multiplies.Value * 2 -- Shows the "x2" text
end)

Minutes.Changed:Connect(function()
	if Minutes.Value == 0 and Seconds.Value == 0 then
		if not Winners then return end
		for _, id in pairs(Winners) do
			local Player = game:GetService("Players"):GetPlayerByUserId(id)
			if not Player then continue end
			if not Player:FindFirstChild("leaderstats") then continue end
			if not Player.leaderstats:FindFirstChild("Coins") then continue end
			Player.leaderstats.Coins.Value = Player.leaderstats.Coins.Value + 100 -- Gives 100 cash after the round
		end
		Winners = {}
	end
end)