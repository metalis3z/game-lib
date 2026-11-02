--credit to prince games studio
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local t = {}
local v1 = false

local function buildPrefix(p1, p2, p3) --[[ buildPrefix | Line: 17 ]]
	local v1 = p2:gsub("<", "&lt;"):gsub(">", "&gt;")

	if p1 == "" then
		return string.format("<font color=\"%s\">[%s]</font> ", p3, v1)
	end

	return string.format("<font color=\"%s\">[%s]</font> %s", p3, v1, p1)
end

local function onIncomingMessage(p1) --[[ onIncomingMessage | Line: 26 | Upvalues: Players (copy), buildPrefix (copy) ]]
	local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
	local TextSource = p1.TextSource

	if not TextSource then
		return TextChatMessageProperties
	end

	local v1 = Players:GetPlayerByUserId(TextSource.UserId)

	if not v1 then
		return TextChatMessageProperties
	end

	local v2 = v1:GetAttribute("GuildTag")

	if typeof(v2) ~= "string" or v2 == "" then
		return TextChatMessageProperties
	end

	local v3 = v1:GetAttribute("GuildColor")

	TextChatMessageProperties.PrefixText = buildPrefix(p1.PrefixText, v2, if typeof(v3) == "string" and v3 ~= "" then v3 else "#6EE7A7")

	return TextChatMessageProperties
end

function t.Install() --[[ Install | Line: 46 | Upvalues: v1 (ref), TextChatService (copy), onIncomingMessage (copy) ]]
	if not v1 then
		v1 = true
		function TextChatService.OnIncomingMessage(p1) --[[ Line: 52 | Upvalues: onIncomingMessage (ref) ]]
			return onIncomingMessage(p1)
		end
	end
end

return t