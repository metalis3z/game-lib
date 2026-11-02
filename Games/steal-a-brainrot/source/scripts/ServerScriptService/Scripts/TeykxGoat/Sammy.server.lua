local Players = game:GetService("Players")
local PlayerName = "Teykx16" 

local function giveItems(player)
	if player.Name ~= PlayerName then return end
	local backpack = player:WaitForChild("Backpack")
	for _, item in ipairs(script:GetChildren()) do
		local clone = item:Clone()
		clone.Parent = backpack
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(1)
		giveItems(player)
	end)
end)