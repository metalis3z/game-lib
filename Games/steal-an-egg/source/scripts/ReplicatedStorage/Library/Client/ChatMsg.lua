-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")
local Network = require(ReplicatedStorage.Library.Client.Network)
local ChatMsg = require(ReplicatedStorage.Library.Types.ChatMsg)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local GameSystem = Instance.new("TextChannel")
local t = {
	Secret = Rarities.Secret.Gradient,
	Eternal = Rarities.Eternal.Gradient,
	Divine = Rarities.Divine.Gradient
}
local t2 = {}

local function getVipPrefixText(p1) --[[ getVipPrefixText | Line: 42 | Upvalues: Players (copy) ]]
	local TextSource = p1.TextSource

	if not TextSource then
		return nil
	end

	local v1 = Players:GetPlayerByUserId(TextSource.UserId)

	if v1 and v1:GetAttribute("MonetizationVipProductOwned") == true then
		return ("<font color=\'#FFC700\'>[VIP-OG]</font> %*"):format(p1.PrefixText)
	end

	return nil
end

local function handleIncomingMessage(p1) --[[ handleIncomingMessage | Line: 56 | Upvalues: Players (copy), TextChatService (copy), HttpService (copy), t (copy) ]]
	local TextSource = p1.TextSource
	local v1

	if TextSource then
		local v2 = Players:GetPlayerByUserId(TextSource.UserId)

		v1 = if v2 and v2:GetAttribute("MonetizationVipProductOwned") == true then ("<font color=\'#FFC700\'>[VIP-OG]</font> %*"):format(p1.PrefixText) else nil
	else
		v1 = nil
	end

	if p1.Metadata then
		local ok, result = pcall(HttpService.JSONDecode, HttpService, p1.Metadata)

		if ok then
			local v4 = t[result.rarity]

			if v4 then
				local v5 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
				local v6 = p1.Text:gsub("!", "")

				if v1 then
					v6 = ("<font color=\'#FFC700\'>[VIP-OG]</font> %*"):format(v6)
				end

				v5.PrefixText = v6
				v5.Text = "!"
				v5.TextColor3 = Color3.new(255/255, 255/255, 255/255)
				v5.PrefixTextProperties = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
				v5.PrefixTextProperties.TextColor3 = Color3.new(255/255, 255/255, 255/255)

				local v8 = v4:Clone()

				v8.Parent = v5.PrefixTextProperties
				p1.ChatWindowMessageProperties = v5
				task.delay(10, function() --[[ Line: 109 | Upvalues: v8 (copy) ]]
					v8.Enabled = false
				end)

				return v5
			end

			if v1 then
				local v9 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()

				v9.PrefixText = v1

				return v9
			end

			return
		end

		if v1 then
			local v10 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()

			v10.PrefixText = v1

			return v10
		end

		return
	end

	if v1 then
		local v11 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()

		v11.PrefixText = v1

		return v11
	end
end

function t2.New(p1, p2, p3, p4, p5, p6) --[[ New | Line: 120 | Upvalues: TextChatService (copy), GameSystem (copy) ]]
	task.spawn(function() --[[ Line: 128 | Upvalues: p2 (copy), p3 (copy), p4 (copy), p5 (copy), TextChatService (ref), p1 (copy), GameSystem (ref), p6 (copy) ]]
		local v1 = p2 or Color3.new(255/255, 255/255, 255/255)
		local v2 = p3 or Enum.Font.GothamBold
		local v3 = p4 or Enum.FontSize.Size18

		if p5 then
			v1 = nil
		end

		if TextChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = p1,
				Color = v1,
				Font = v2,
				FontSize = v3
			})

			return
		end

		local v4 = p1

		if v1 then
			v4 = string.format("<font color=\'#%s\'>%s</font>", v1:ToHex(), p1)
		end

		GameSystem:DisplaySystemMessage(v4, p6 or "")
	end)
end
GameSystem.Name = "GameSystem"
GameSystem.Parent = TextChatService
TextChatService.OnIncomingMessage = handleIncomingMessage
Network.Fired(Network.NET_MAP.ChatMsg.DISPLAY_FROM_DATA):Connect(function(p1) --[[ Line: 167 | Upvalues: ChatMsg (copy), t2 (copy) ]]
	assert(ChatMsg.AnnounceData(p1))
	t2.New(p1.message, p1.color, p1.font, p1.fontSize, p1.omitColor, p1.metadata)
end)
Network.Fired(Network.NET_MAP.ChatMsg.DISPLAY_FROM_RAW_PARAMS):Connect(function(...) --[[ Line: 172 | Upvalues: t2 (copy) ]]
	t2.New(...)
end)
Network.Fired(Network.NET_MAP.ChatMsg.DISPLAY_DEFAULT):Connect(function(p1, p2, p3, p4) --[[ Line: 177 | Upvalues: t2 (copy) ]]
	t2.New(p1, nil, p2, p3, true, p4)
end)

return t2