
local rainbowChatPlayers = {21748114}	-- Myzta

local Chat = game:GetService("Chat")
local ReplicatedModules = Chat:WaitForChild("ClientChatModules")
local ChatConstants = require(ReplicatedModules:WaitForChild("ChatConstants"))

local rainbowModulus = 0

local function findValueInTable(t, searchValue)
	for index, value in pairs(t) do
		if value == searchValue then
			return index
		end
	end
end

local function Run(ChatService)

	ChatService:RegisterFilterMessageFunction("rainbow_chat", function(speakerName, messageObj, channelName)
		local message = messageObj.Message
		if message and speakerName then
			local player = game.Players:FindFirstChild(speakerName)
			if player and findValueInTable(rainbowChatPlayers, player.UserId) then
				rainbowModulus = (rainbowModulus + .15)%1
				messageObj.ExtraData.ChatColor = Color3.fromHSV(rainbowModulus,.8,1)
			end
		end
	end)

end

return Run
