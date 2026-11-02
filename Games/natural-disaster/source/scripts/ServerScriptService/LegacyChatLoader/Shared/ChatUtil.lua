-- // General-use functions for the chat system.

local Players = game:GetService("Players")

local ChatConstants = require(script.Parent.ChatConstants)

local ChatUtil = {}

function ChatUtil.debugPrint(...)
	if ChatConstants.Logging then
		print(...)
	end
end

function ChatUtil.getPlayerFromTextQuery(sender: Player, query: string?): (Player?, string? | "TOO_MANY_RESULTS" | "NO_RESULTS" | "EMPTY_QUERY")
	local allPlayers = Players:GetPlayers()
	if #allPlayers == 2 then
		-- There's only one other player; use them
		for _,player in allPlayers do
			if player ~= sender then
				return player
			end
		end
	end
	
	if query == nil then
		return nil, "EMPTY_QUERY"
	end
	
	local loweredQuery = query:lower()
	
	local partialUsernameMatches: {Player} = {}
	local directDisplayNameMatches: {Player} = {}
	local partialDisplayNameMatches: {Player} = {}
	
	for _,player in allPlayers do
		local loweredUsername = player.Name:lower()
		local loweredDisplayName = player.DisplayName:lower()
		if loweredUsername == loweredQuery then
			-- Direct username match; immediately return this
			return player, nil
		elseif loweredDisplayName == loweredQuery then
			-- Direct display name match
			table.insert(directDisplayNameMatches, player)
		elseif string.sub(loweredUsername, 1, #loweredQuery) == loweredQuery then
			-- Partial username match
			table.insert(partialUsernameMatches, player)
		elseif string.sub(loweredDisplayName, 1, #loweredQuery) == loweredQuery then
			-- Partial username match
			table.insert(partialUsernameMatches, player)
		end
	end
	
	if #partialUsernameMatches == 1 then
		return partialUsernameMatches[1], nil
	elseif #directDisplayNameMatches == 1 then
		return directDisplayNameMatches[1], nil
	elseif #partialDisplayNameMatches == 1 then
		return partialDisplayNameMatches[1], nil
	else
		if #partialUsernameMatches > 1 or #directDisplayNameMatches > 1 or #partialDisplayNameMatches > 1 then
			return nil, "TOO_MANY_RESULTS"
		else
			return nil, "NO_RESULTS"
		end
	end
end

function ChatUtil.removeCommandFromMessage(message: string)
	local loweredMessage = message:lower()
	local commandPrefix = ChatConstants.CommandPrefix
	if string.sub(loweredMessage, 1, string.len(commandPrefix)) == commandPrefix then
		-- Skip the prefix, then just go through the characters until there's a space
		local commandEnd: number?
		for i = string.len(commandPrefix)+1, string.len(message) do
			local currentChar = string.sub(message, i, i)
			if currentChar == " " then
				commandEnd = i
				break
			end
		end
		if commandEnd == nil then
			-- No space detected; player is not finished typing this command
			return ""
		end
		return string.sub(message, commandEnd + 1)
	else
		-- Not a command message
		return message
	end
end

function ChatUtil.getCommandInfoFromMessage(message: string): {
		rawCommandName: string?,
		arguments: {string}
	}
	local loweredMessage = message:lower()
	local commandPrefix = ChatConstants.CommandPrefix
	if string.sub(loweredMessage, 1, string.len(commandPrefix)) == commandPrefix then
		local split = string.split(string.sub(message, string.len(commandPrefix)+1), " ")
		
		local arguments = table.clone(split)
		table.remove(arguments, 1)
		
		return {
			rawCommandName = split[1],
			arguments = arguments,
		}
	else
		--[[
			IMPORTANT REMINDER: No prefix doesn't necessarily mean this isn't a command!
			Make sure to also check MessageMode, as that can replace the prefix and command name.
		]]
		local arguments = string.split(message, " ")
		
		return {
			rawCommandName = nil,
			arguments = arguments
		}
	end
end

function ChatUtil.getCommandInfoFromMetadata(metadata: string): (string?, string?)
	local usingMetadataForCommand = false

	local commandName = ""
	for i=1, #metadata do
		local character = string.sub(metadata, i, i)
		if character == ":" then
			usingMetadataForCommand = true
			break
		end
		commandName = commandName .. character
	end

	if usingMetadataForCommand then
		return commandName, string.sub(metadata, #commandName+2)
	else
		return nil, nil
	end
end

local NAME_COLORS = ChatConstants.DefaultUsernameColors
function ChatUtil.getDefaultUsernameColor(username: string): Color3
	local value = 0
	for index = 1, #username do
		local cValue = string.byte(string.sub(username, index, index))
		local reverseIndex = #username - index + 1
		if #username%2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex%4 >= 2 then
			cValue = -cValue
		end
		value = value + cValue
	end
	
	return NAME_COLORS[(value % #NAME_COLORS) + 1]
end

function ChatUtil.sanitizeMessageForRichText(message: string): string
	message = string.gsub(message, "\&", "&amp;")
	message = string.gsub(message, "<", "&lt;")
	message = string.gsub(message, ">", "&gt;")
	message = string.gsub(message, `"`, "&quot;")
	message = string.gsub(message, `'`, "&apos;")

	return message
end

function ChatUtil.removeRichTextTags(message: string): string
	-- I just want to clarify that this regex is incomprehensible to me and this was written by code assist -steven
	message = string.gsub(message, "</?[biu]>", "")
	message = string.gsub(message, "</?font[^>]->", "")
	message = string.gsub(message, "<[^>]->", "")

	return message
end

function ChatUtil.convertRichTextEscapeStrings(message: string): string
	message = string.gsub(message, "&lt;", "<")
	message = string.gsub(message, "&gt;", ">")
	message = string.gsub(message, "&quot;", `"`)
	message = string.gsub(message, "&apos;", `'`)
	message = string.gsub(message, "&amp;", "&")
	
	return message
end

function ChatUtil.checkIsBlankString(text: string): boolean
	-- Checks if a string is either empty ("") or only whitespcae
	return text:match("^%s*$") ~= nil
end

return ChatUtil