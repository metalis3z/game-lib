local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GAMEPASS_ID = 1923152308
local Tool = ReplicatedStorage:WaitForChild("Items"):WaitForChild("Waverider")

local function giveTool(player)
	local success, ownsPass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)

	if success and ownsPass then
		local backpack = player:WaitForChild("Backpack")

		if not backpack:FindFirstChild(Tool.Name) then
			Tool:Clone().Parent = backpack
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.2)
		giveTool(player)
	end)
end)