

local v1 = game:GetService("TextChatService")
local u2 = game:GetService("Players")
local u3 = {
	["Owner"] = {
		["Color"] = "#ff0000",
		["Prefix"] = "\240\159\145\145 [OWNER]"
	},
	["HeadManager"] = {
		["Color"] = "#a855f7",
		["Prefix"] = "[COO]"
	},
	["Admin"] = {
		["Color"] = "#3b82f6",
		["Prefix"] = "[STAFF]"
	},
	["MarketingLead"] = {
		["Color"] = "#ff8c00",
		["Prefix"] = "[MARKETING LEAD]"
	},
	["Moderator"] = {
		["Color"] = "#3b82f6",
		["Prefix"] = "[STAFF]"
	}
}
function v1.OnIncomingMessage(p4)

	local v5 = Instance.new("TextChatMessageProperties")
	local v6 = p4.TextSource
	if not v6 then
		return v5
	end
	local v7 = u2:GetPlayerByUserId(v6.UserId)
	if not v7 then
		return v5
	end
	if v7:GetAttribute("AdminChatTagEnabled") ~= true then
		return v5
	end
	local v8 = v7:GetAttribute("AdminRole")
	if not v8 or v8 == "" then
		return v5
	end
	local v9 = u3[v8]
	if not v9 then
		return v5
	end
	local v10 = v7.Name
	v5.PrefixText = string.format("<b><font color=\'%s\' size=\'18\'>%s %s</font></b>:", v9.Color, v9.Prefix, v10)
	return v5
end