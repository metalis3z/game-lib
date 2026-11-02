-- // Handles creation of whisper (private message) channels.

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local TextChannels = TextChatService:WaitForChild("TextChannels")
local Remotes = Chat:WaitForChild("Remotes")

local WhisperInterface = {}

local function canWhisper(speaker: Player, recipient: Player): boolean
	return TextChatService:CanUsersChatAsync(speaker.UserId, recipient.UserId) and TextChatService:CanUsersDirectChatAsync(speaker.UserId, {recipient.UserId})
end

function WhisperInterface.getAllWhisperChannelsWithPlayer(player: Player): {TextChannel}
	local channelsFound: {TextChannel} = {}
	
	for _,textChannel: TextChannel in TextChannels:GetChildren() do
		if string.sub(textChannel.Name, 1, 7) == "Whisper" then
			local split = string.split(textChannel.Name, "/")
			local playerName1 = split[2]
			local playerName2 = split[3]
			
			if playerName1 == player.Name or playerName2 == player.Name then
				table.insert(channelsFound, textChannel)
			end
		end
	end
	
	return channelsFound
end

function WhisperInterface.getWhisperChannel(playerA: Player, playerB: Player): TextChannel?
	local textChannel = TextChannels:FindFirstChild(`Whisper/{playerA.Name}/{playerB.Name}`)
	if textChannel == nil then
		TextChannels:FindFirstChild(`Whisper/{playerB.Name}/{playerA.Name}`)
	end
	if textChannel == nil then
		return nil
	end
end

function WhisperInterface.init()
	Remotes.GetWhisperChannel.OnServerInvoke = function(requester: Player, targetPlayer: Player)
		local whisperChannel = WhisperInterface.getWhisperChannel(requester, targetPlayer)
		
		-- Check if these two players are able to communicate
		if not canWhisper(requester, targetPlayer) then
			-- They can't; destroy whisper channel if it exists, then return nothing
			if whisperChannel ~= nil then
				whisperChannel:Destroy()
			end
			return nil
		end
		
		if whisperChannel ~= nil then
			return whisperChannel
		else
			-- Whisper channel does not exist; create one
			local newWhisperChannel = Instance.new("TextChannel")
			newWhisperChannel.Name = `Whisper/{requester.Name}/{targetPlayer.Name}`
			newWhisperChannel.Parent = TextChannels
			newWhisperChannel:AddUserAsync(requester.UserId)
			newWhisperChannel:AddUserAsync(targetPlayer.UserId)
			
			return newWhisperChannel
		end
	end
	
	Players.PlayerRemoving:Connect(function(player)
		for _,textChannel in WhisperInterface.getAllWhisperChannelsWithPlayer(player) do
			textChannel:Destroy()
		end
	end)
end

return WhisperInterface