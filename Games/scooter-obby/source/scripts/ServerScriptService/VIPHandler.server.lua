local mps = game:GetService("MarketplaceService")
local vipID = 258736517
local mvpID = 258735823
local doubleCoinID = 258735893
local gigaBundleId = 669263399

game.Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("joinTime", os.time() - 2)
	if mps:UserOwnsGamePassAsync(player.UserId, vipID) and not  mps:UserOwnsGamePassAsync(player.UserId, mvpID) then
		player:SetAttribute("isVIP", true)
		player:SetAttribute("isMVP", false)
	elseif not mps:UserOwnsGamePassAsync(player.UserId, vipID) and mps:UserOwnsGamePassAsync(player.UserId, mvpID) then
		player:SetAttribute("isVIP", false)
		player:SetAttribute("isMVP", true)
	elseif mps:UserOwnsGamePassAsync(player.UserId, vipID) and mps:UserOwnsGamePassAsync(player.UserId, mvpID) then
		player:SetAttribute("isVIP", true)
		player:SetAttribute("isMVP", true)
	else
		player:SetAttribute("isVIP", false)
		player:SetAttribute("isMVP", false)
	end
	if mps:UserOwnsGamePassAsync(player.UserId, doubleCoinID) then
		player:SetAttribute("hasDoubleCoins", true)
	else
		player:SetAttribute("hasDoubleCoins", false)
	end
	if mps:UserOwnsGamePassAsync(player.UserId, gigaBundleId) and player:GetAttribute("isVIP") == false then
		player:SetAttribute("isVIP", true)
	end
end)