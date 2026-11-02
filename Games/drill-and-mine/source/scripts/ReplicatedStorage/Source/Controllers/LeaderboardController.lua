local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local LeaderboardController = {}

local player = Players.LocalPlayer

-- U+E001 is the Premium logo glyph in the chat font. Verified users need
-- no treatment here: the platform already appends the verified badge
-- (U+E000) to their chat display name, so adding it would double it up.
local PREMIUM_GLYPH = utf8.char(0xE001)

local function getBadgePrefix(sender)
	if sender.MembershipType == Enum.MembershipType.Premium then
		return PREMIUM_GLYPH .. " "
	end
	return ""
end

local function getGamepassTags(sender)
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	if not passes then return "" end
	local out = ""
	for configKey, entry in pairs(passes) do
		if entry.ChatTag and sender:GetAttribute("OwnsGamepass_" .. configKey) then
			local color = entry.ChatTagColor or "#FFFFFF"
			out = out .. string.format('<font color="%s">%s</font> ', color, entry.ChatTag)
		end
	end
	return out
end

local function setupChatTags()
	TextChatService.OnIncomingMessage = function(message)
		local properties = Instance.new("TextChatMessageProperties")

		if message.TextSource then
			local senderId = message.TextSource.UserId
			local sender = Players:GetPlayerByUserId(senderId)
			if sender then
				-- gamepass tags first, then the Premium logo hugging the name
				local prefix = getGamepassTags(sender) .. getBadgePrefix(sender)
				if prefix ~= "" then
					properties.PrefixText = prefix .. message.PrefixText
				end
			end
		end

		return properties
	end
end

function LeaderboardController.Init()
	setupChatTags()
end

return LeaderboardController