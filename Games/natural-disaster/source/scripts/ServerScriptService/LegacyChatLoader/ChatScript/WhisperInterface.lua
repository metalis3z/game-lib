-- // Interface for getting and caching whisper channels.

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local TextChannels = TextChatService:WaitForChild("TextChannels")
local localPlayer = Players.LocalPlayer
local Remotes = Chat:WaitForChild("Remotes")

local WhisperInterface = {}

local cachedChannels: {[Player]: TextChannel?} = {}

function WhisperInterface.getWhisperChannelAsync(targetPlayer: Player): TextChannel?
	local cachedTextChannel = cachedChannels[targetPlayer]
	if cachedTextChannel ~= nil then
		return cachedTextChannel
	else
		local textChannel = Remotes.GetWhisperChannel:InvokeServer(targetPlayer)
		if textChannel ~= nil then
			cachedChannels[targetPlayer] = textChannel
		end
		return textChannel
	end
end

function WhisperInterface.init()
	TextChannels.ChildAdded:Connect(function(textChannel: TextChannel)
		if string.sub(textChannel.Name, 1, 7) == "Whisper" then
			local split = string.split(textChannel.Name, "/")
			local playerName1 = split[2]
			local playerName2 = split[3]

			local otherPlayer
			if playerName1 == localPlayer.Name then
				otherPlayer = Players[playerName2]
			elseif playerName2 == localPlayer.Name then
				otherPlayer = Players[playerName1]
			end

			if otherPlayer ~= nil then
				cachedChannels[otherPlayer] = textChannel
			end
		end
	end)
	
	TextChannels.ChildRemoved:Connect(function(textChannel: TextChannel)
		for otherPlayer,cachedTextChannel in cachedChannels do
			if textChannel == cachedTextChannel then
				cachedChannels[otherPlayer] = nil
			end
		end
	end)
end

return WhisperInterface