local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local GAMEPASS_IDS = {
	  1234567, 1234567, 1234567, 1234567,  -- choose your gamepasse here
	  1234567, 1234567, 1234567, 1234567,
	  1234567, 1234567, 1234567, 1234567,
	  1234567, 1234567, 1234567, 1234567,
	  1234567, 1234567, 1234567, 1234567,
	  1234567
}

-- Vérifie si un joueur possède un gamepass
local function playerHasPass(player, passId)
	local success, result = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId)
	end)
	return success and result
end

-- Quand un achat est complété
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, wasPurchased)
	if wasPurchased then
		print(player.Name .. " a acheté le gamepass " .. passId)
		-- Ajoute ici les récompenses selon l'ID
		for _, id in ipairs(GAMEPASS_IDS) do
			if id == passId then
				-- Exemple : donner un tag, outil, etc.
				break
			end
		end
	end
end)

-- RemoteFunction pour récupérer les infos des passes
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local getPassesRemote = Instance.new("RemoteFunction")
getPassesRemote.Name = "GetGamepasses"
getPassesRemote.Parent = ReplicatedStorage

getPassesRemote.OnServerInvoke = function(player)
	local passData = {}
	for _, id in ipairs(GAMEPASS_IDS) do
		local success, info = pcall(function()
			return MarketplaceService:GetProductInfo(id, Enum.InfoType.GamePass)
		end)
		if success and info then
			local owned = playerHasPass(player, id)
			table.insert(passData, {
				Id = id,
				Name = info.Name,
				Price = info.PriceInRobux,
				Image = "rbxassetid://" .. (info.IconImageAssetId or 0),
				Owned = owned
			})
		end
	end
	return passData
end