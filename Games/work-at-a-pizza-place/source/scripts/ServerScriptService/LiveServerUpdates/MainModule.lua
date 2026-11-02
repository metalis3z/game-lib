--see who the richest players are
return function()
	
	
	local RichPlayers = game:GetService("DataStoreService"):GetOrderedDataStore("RichPlayers")
	
	--command bar code
	--[[
	local RichPlayers = game:GetService("DataStoreService"):GetOrderedDataStore("RichPlayers")
	local list = RichPlayers:GetSortedAsync(false, 50,500000,1000000)
	for _,data in ipairs(list:GetCurrentPage()) do
		print(data.key,data.value)
	end]]

	game.Players.PlayerAdded:connect(function(player)
		
		wait(10)
		
		if player and _G["Players"] and _G["Players"][player] and _G["Players"][player].Moneyz and  _G["Players"][player].Moneyz > 500000 and  _G["Players"][player].Moneyz ~= 99999 then
			pcall(function()
				RichPlayers:SetAsync(tostring(player.userId),_G["Players"][player].Moneyz)
			end)
		end
	end)
end



