-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TitleServiceClient, time of decompilation: Sun May  3 10:12:16 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Networker = require(ReplicatedStorage.Packages.Networker)
local DisplayNameWithIcons = require(ReplicatedStorage.Source.Core.UI.DisplayNameWithIcons)
local TitleServiceUtils = require(script.Parent.TitleServiceUtils)
local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration
local t1 = {}
local colorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255))

function t1.init(p1) -- line: 13
	-- upvalues: Networker (copy), TextChatService (copy), ChatWindowConfiguration (copy), Players (copy), TitleServiceUtils (copy), colorSequence (copy), DisplayNameWithIcons (copy)
	p1.networker = Networker.client.new("TitleService", p1)

	function TextChatService.OnChatWindowAdded(p2) -- line: 16
		-- upvalues: ChatWindowConfiguration (copy), Players (copy), TitleServiceUtils (copy), colorSequence (copy), DisplayNameWithIcons (copy)
		local v12 = ChatWindowConfiguration:DeriveNewMessageProperties()
		local TextSource = p2.TextSource

		if not TextSource then
			return
		end

		local UserId = TextSource.UserId
		local PlayerByUserId = Players:GetPlayerByUserId(UserId)

		if not PlayerByUserId then
			return
		end

		local v16 = PlayerByUserId:GetAttribute("TitleId") or ""
		local v17 = TitleServiceUtils.titles[v16]
		local v18 = not v17 and "" or `[{ v17.text }]`
		local v19 = if not v17 then colorSequence else v17.colorSequnce

		v12.PrefixText = `<font weight="ExtraBold">{ v18 }</font>`
		v12.Text = `<font weight="ExtraBold">{ DisplayNameWithIcons(PlayerByUserId) }:</font> { p2.Text }`
		v12.PrefixTextProperties = ChatWindowConfiguration:DeriveNewMessageProperties()

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = v19
		UIGradient.Rotation = not v17 and 0 or v17.rotation
		UIGradient.Parent = v12.PrefixTextProperties

		return v12
	end
end

return t1
