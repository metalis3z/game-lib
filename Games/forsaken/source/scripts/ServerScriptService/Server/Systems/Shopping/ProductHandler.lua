local module = {}

local Network = require(game.ReplicatedStorage.Modules.Network)
local marketplace = game:GetService("MarketplaceService")
local Products = require(game.ReplicatedStorage.Modules.Schematics.Products)
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local safecall = ServerUtil.SafeCall

function HandlePurchase(Player, ProductId, Purchased)
	safecall(function()
		if not Purchased then return end
		Player = typeof(Player)=="Instance" and Player or game.Players:GetPlayerByUserId(Player)
		if not Player then return end
		local ProductInfo
		local ProductType
		local Receiver = Player:GetAttribute("GiftingTo") and game.Players:FindFirstChild(Player:GetAttribute("GiftingTo")) or Player
		Player:SetAttribute("GiftingTo", nil)
		for _, section in pairs(Products) do
			if section.Contents[ProductId] then
				ProductInfo = section.Contents[ProductId]
				break
			else
				for id, prod in pairs(section.Contents) do
					if prod.GiftingID == ProductId then
						ProductInfo = prod
						ProductId = id
						task.spawn(function()
							if ProductInfo.ProductType ~= "Gamepass" then return end
							local newVal = Instance.new("BoolValue", Receiver.PlayerData.Purchased.Gamepasses)
							newVal.Name = ProductId
							newVal.Value = true
						end)
						break
					end
				end
			end
		end

		if (not ProductInfo) then return end

		ProductInfo:Callback(Receiver)
		return true
	end)
end

module.Start = function()
	marketplace.PromptGamePassPurchaseFinished:Connect(HandlePurchase)
	marketplace.PromptProductPurchaseFinished:Connect(HandlePurchase)
	Network:SetConnection("SetGiftedPlayer", "REMOTE_FUNCTION", function(Player : Player, Receiver : Player)
		if (not Receiver) or (not game.Players:FindFirstChild(Receiver)) then return end
		Player:SetAttribute("GiftingTo", Receiver)
		return true
	end)
	Network:SetConnection("PlayerOwnGamepass", "REMOTE_FUNCTION", function(_, Info)
		return marketplace:UserOwnsGamePassAsync(Info[1].UserId, Info[2]) or (Info[1]:FindFirstChild("PlayerData") and Info[1].PlayerData:FindFirstChild("Purchased") and Info[1].PlayerData.Purchased:FindFirstChild(tostring(Info[2]), true) and true)
	end)
end

module.ActivatePasses = function(_, Player : Player)
	for _, section in pairs(Products) do
		for Id, Info in pairs(section.Contents) do
			if Info.ProductType ~= "Gamepass" then continue end
			if marketplace:UserOwnsGamePassAsync(Player.UserId, Id) or (Player:FindFirstChild("PlayerData") and Player.PlayerData:FindFirstChild("Purchased") and Player.PlayerData.Purchased:FindFirstChild(tostring(Id), true)) then
				Info:Callback(Player)
			end
		end
	end
end

return module