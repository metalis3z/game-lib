--	// FileName: DefaultChatMessage.lua
--	// Written by: TheGamer101
--	// Description: Create a message label for a standard chat message.

local clientChatModules = script.Parent.Parent
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local util = require(script.Parent:WaitForChild("Util"))

function CreateMessageLabel(messageData, channelName)

	local fromSpeaker = messageData.FromSpeaker
	local speakerName

	if ChatSettings.PlayerDisplayNamesEnabled and messageData.SpeakerDisplayName then
		speakerName = messageData.SpeakerDisplayName
	else
		speakerName = fromSpeaker
	end
	
	local useNoEliteChat = Color3.fromRGB(255, 255, 255)
	local useAliveChat
	local useDeadChat
	
	local message = messageData.Message

	local extraData = messageData.ExtraData or {}
	local useFont = extraData.Font or ChatSettings.DefaultFont
	local useTextSize = extraData.TextSize or ChatSettings.ChatWindowTextSize
	local useNameColor = extraData.NameColor or ChatSettings.DefaultNameColor
	local useChatColor = extraData.ChatColor or ChatSettings.DefaultMessageColor
	local useChannelColor = extraData.ChannelColor or useChatColor
	local useAliveChannel = messageData.OriginalChannel == "alive"
	local disguiseChatColor
	local tags = extraData.Tags or {}
	
	for i, tag in pairs(tags) do
		if tag.TagColorAlive then
			useAliveChat = tag.TagColorAlive
			useDeadChat = tag.TagColorDead
			break
		end
	end
	
	if useAliveChannel then
		if extraData.Disguise ~= nil then
			if not disguiseChatColor then
				if useAliveChannel then
					disguiseChatColor = useAliveChat or (useNoEliteChat or (useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color))
				else
					disguiseChatColor = useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color
				end
			end
		elseif useAliveChannel then
			disguiseChatColor = useAliveChat or (useNoEliteChat or (useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color))
		else
			disguiseChatColor = useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color
		end
	elseif useAliveChannel then
		disguiseChatColor = useAliveChat or (useNoEliteChat or (useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color))
	else
		disguiseChatColor = useAliveChat and useDeadChat or BrickColor.new("Medium stone grey").Color
	end
	
	if extraData.ChannelColor then
		
	end
	
	if extraData.Disguise ~= nil then
		fromSpeaker = extraData.Disguise.CodeName
	end
	
	local formatUseName = string.format("[%s]:", speakerName)
	if extraData.RemoveBrackets ~= nil then
		formatUseName = string.format("%s:", speakerName)
	end
	local speakerNameSize = util:GetStringTextBounds(formatUseName, useFont, useTextSize)
	local numNeededSpaces = util:GetNumberOfSpaces(formatUseName, useFont, useTextSize) + 1

	local BaseFrame, BaseMessage = util:CreateBaseMessage("", useFont, useTextSize, useChatColor)
	local NameButton = util:AddNameButtonToBaseMessage(BaseMessage, disguiseChatColor, formatUseName, fromSpeaker)
	local ChannelButton = nil

	local guiObjectSpacing = UDim2.new(0, 0, 0, 0)

	if channelName ~= messageData.OriginalChannel then
		--	local formatChannelName = string.format("{%s}", messageData.OriginalChannel)
		--	ChannelButton = util:AddChannelButtonToBaseMessage(BaseMessage, useChannelColor, formatChannelName, messageData.OriginalChannel)
		--	guiObjectSpacing = UDim2.new(0, ChannelButton.Size.X.Offset + util:GetStringTextBounds(" ", useFont, useTextSize).X, 0, 0)
		--	numNeededSpaces = numNeededSpaces + util:GetNumberOfSpaces(formatChannelName, useFont, useTextSize) + 1
	end

	local tagLabels = {}
	for i, tag in pairs(tags) do
		local tagColor = tag.TagColorDead or Color3.fromRGB(255, 0, 255)
		local tagText = tag.TagText or "???"
		local formatTagText = string.format("[%s] ", tagText)
		local label = util:AddTagLabelToBaseMessage(BaseMessage, useAliveChannel and tag.TagColorAlive or (tagColor), formatTagText);
		label.Position = guiObjectSpacing

		numNeededSpaces = numNeededSpaces + util:GetNumberOfSpaces(formatTagText, useFont, useTextSize)
		guiObjectSpacing = guiObjectSpacing + UDim2.new(0, label.Size.X.Offset, 0, 0)

		table.insert(tagLabels, label)
	end

	NameButton.Position = guiObjectSpacing

	local function UpdateTextFunction(messageObject)
		if messageData.IsFiltered then
			BaseMessage.Text = string.rep(" ", numNeededSpaces) .. messageObject.Message
		else
			local messageLength = messageObject.MessageLengthUtf8 or messageObject.MessageLength
			BaseMessage.Text = string.rep(" ", numNeededSpaces) .. string.rep("_", messageLength)
		end
	end

	UpdateTextFunction(messageData)

	local function GetHeightFunction(xSize)
		return util:GetMessageHeight(BaseMessage, BaseFrame, xSize)
	end

	local FadeParmaters = {}
	FadeParmaters[NameButton] = {
		TextTransparency = {FadedIn = 0, FadedOut = 1},
		TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}
	}

	FadeParmaters[BaseMessage] = {
		TextTransparency = {FadedIn = 0, FadedOut = 1},
		TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}
	}

	for i, tagLabel in pairs(tagLabels) do
		local index = string.format("Tag%d", i)
		FadeParmaters[tagLabel] = {
			TextTransparency = {FadedIn = 0, FadedOut = 1},
			TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}
		}
	end

	if ChannelButton then
		FadeParmaters[ChannelButton] = {
			TextTransparency = {FadedIn = 0, FadedOut = 1},
			TextStrokeTransparency = {FadedIn = 0.75, FadedOut = 1}
		}
	end

	local FadeInFunction, FadeOutFunction, UpdateAnimFunction = util:CreateFadeFunctions(FadeParmaters)

	return {
		[util.KEY_BASE_FRAME] = BaseFrame,
		[util.KEY_BASE_MESSAGE] = BaseMessage,
		[util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction,
		[util.KEY_GET_HEIGHT] = GetHeightFunction,
		[util.KEY_FADE_IN] = FadeInFunction,
		[util.KEY_FADE_OUT] = FadeOutFunction,
		[util.KEY_UPDATE_ANIMATION] = UpdateAnimFunction
	}
end

return {
	[util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeDefault,
	[util.KEY_CREATOR_FUNCTION] = CreateMessageLabel
}
