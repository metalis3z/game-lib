local replicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local event = replicatedStorage.FilterText

event.OnServerInvoke = (function(player, textToFilter)
	local filteredTextResult = TextService:FilterStringAsync(textToFilter, player.UserId)
	return filteredTextResult:GetNonChatStringForBroadcastAsync()
end)