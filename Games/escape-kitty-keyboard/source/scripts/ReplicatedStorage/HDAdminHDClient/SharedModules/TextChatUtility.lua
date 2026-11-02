

local u1 = {
	["gamesToVerifyTextChatServiceUpdates"] = {}
}
task.defer(function()
	local v2 = game:GetService("RunService")
	game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral", 10)
	v2:IsServer()
end)
function u1.verifyCanUpdate() 

	local v3 = u1.gamesToVerifyTextChatServiceUpdates
	return not table.find(v3, game.GameId)
end
return u1