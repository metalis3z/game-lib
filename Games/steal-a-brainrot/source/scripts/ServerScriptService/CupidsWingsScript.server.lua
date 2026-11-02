----- Variables -----

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local tool = script:WaitForChild("Cupid's Wings")
local gamePassId = script:WaitForChild("PassID").Value

local owners = {}

----- Events -----

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
	if purchased and passId == gamePassId then
		local carpet = tool:Clone()
		carpet.Parent = player.Backpack
		owners["ID_" .. player.UserId] = true
	end
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait()
		
		local ownsPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassId)

		if ownsPass or owners["ID_" .. player.UserId] then
			local carpet = tool:Clone()
			carpet.Parent = player.Backpack
		end
	end)
end)