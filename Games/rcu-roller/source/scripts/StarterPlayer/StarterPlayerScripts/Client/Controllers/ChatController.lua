-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:57
-- Luau version 6, Types version 3
-- Time taken: 0.004577 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ChatController";
})
local var4_upvw
local var5_upvw
local var6_upvw
local Players_upvr = game:GetService("Players")
local TextChatService_upvr = game:GetService("TextChatService")
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local tbl_upvr = {
	ids = {};
	groupRank = {};
}
local tbl_upvr_2 = {
	rebirths = {
		emoji = "♻️";
		color = Color3.fromRGB(255, 46, 46);
	};
	eggsOpened = {
		emoji = "🥚";
		color = Color3.fromRGB(255, 204, 142);
	};
	totalClicks = {
		emoji = "👋🏻";
		color = Color3.fromRGB(117, 235, 255);
	};
	timePlayed = {
		emoji = "⌛";
		color = Color3.fromRGB(254, 220, 53);
	};
	robuxSpent = {
		emoji = "🤑";
		color = Color3.fromRGB(109, 253, 91);
	};
}
local RBXSystem_upvr = TextChatService_upvr:FindFirstChild("RBXSystem", true)
function any_CreateController_result1.message(arg1, arg2) -- Line 81
	--[[ Upvalues[1]:
		[1]: RBXSystem_upvr (readonly)
	]]
	RBXSystem_upvr:DisplaySystemMessage(arg2)
end
function any_CreateController_result1.onIncomingMessage(arg1) -- Line 85
	--[[ Upvalues[7]:
		[1]: TextChatService_upvr (readonly)
		[2]: Players_upvr (readonly)
		[3]: tbl_upvr_2 (readonly)
		[4]: var5_upvw (read and write)
		[5]: var10_upvw (read and write)
		[6]: tbl_upvr (readonly)
		[7]: var12_upvw (read and write)
	]]
	function TextChatService_upvr.OnIncomingMessage(arg1_2) -- Line 86
		--[[ Upvalues[6]:
			[1]: Players_upvr (copied, readonly)
			[2]: tbl_upvr_2 (copied, readonly)
			[3]: var5_upvw (copied, read and write)
			[4]: var10_upvw (copied, read and write)
			[5]: tbl_upvr (copied, readonly)
			[6]: var12_upvw (copied, read and write)
		]]
		local var42
		if not arg1_2.TextSource then return end
		local UserId = arg1_2.TextSource.UserId
		local any_GetPlayerByUserId_result1 = Players_upvr:GetPlayerByUserId(UserId)
		local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
		var42 = "clanTag"
		local attribute = any_GetPlayerByUserId_result1:GetAttribute(var42)
		if attribute then
			var42 = TextChatMessageProperties.PrefixText
			TextChatMessageProperties.PrefixText = var42.."<font color='#08deff'>["..attribute.."]</font> "
		end
		var42 = nil
		for i, v in tbl_upvr_2, var42 do
			if var5_upvw._topPlayers[i] then
				for i_2, v_2 in var5_upvw._topPlayers[i] do
					if v_2.userInfos.Id == UserId then
						TextChatMessageProperties.PrefixText = `{TextChatMessageProperties.PrefixText}<font color='#{v.color:ToHex()}'>[{v.emoji} #{i_2}]</font> `
					end
				end
			end
		end
		var42 = var10_upvw
		local var47 = var42[any_GetPlayerByUserId_result1:GetAttribute("title")]
		if var47 then
			var42 = TextChatMessageProperties.PrefixText.."<font color='#"..var47.chatColor:ToHex().."'>["..var47.title.."]</font> "
			TextChatMessageProperties.PrefixText = var42
		end
		var42 = tbl_upvr.ids[UserId]
		if not var42 then
			var42 = tbl_upvr.groupRank[var12_upvw.getRankInGroup(any_GetPlayerByUserId_result1)]
		end
		if var42 then
			TextChatMessageProperties.PrefixText ..= "<font color='#"..var42.color:ToHex().."'>["..var42.tag.."]</font> "
		end
		TextChatMessageProperties.PrefixText ..= arg1_2.PrefixText
		return TextChatMessageProperties
	end
end
local ChatWindowConfiguration_upvr = TextChatService_upvr.ChatWindowConfiguration
function any_CreateController_result1.onChatWindowAdded(arg1) -- Line 130
	--[[ Upvalues[3]:
		[1]: TextChatService_upvr (readonly)
		[2]: ChatWindowConfiguration_upvr (readonly)
		[3]: var9_upvw (read and write)
	]]
	function TextChatService_upvr.OnChatWindowAdded(arg1_3) -- Line 131
		--[[ Upvalues[2]:
			[1]: ChatWindowConfiguration_upvr (copied, readonly)
			[2]: var9_upvw (copied, read and write)
		]]
		if arg1_3.TextSource then
		elseif arg1_3.Text:find("Ultimate") then
			local any_DeriveNewMessageProperties_result1 = ChatWindowConfiguration_upvr:DeriveNewMessageProperties()
			any_DeriveNewMessageProperties_result1.PrefixTextProperties = ChatWindowConfiguration_upvr:DeriveNewMessageProperties()
			any_DeriveNewMessageProperties_result1.PrefixText = arg1_3.Text:gsub("#%x%x%x%x%x%x", "#ffffff")
			arg1_3.Text = "‎ "
			Instance.new("UIGradient", any_DeriveNewMessageProperties_result1.PrefixTextProperties).Color = var9_upvw[11].gradient
			return any_DeriveNewMessageProperties_result1
		end
	end
end
local ChannelTabsConfiguration_upvr = TextChatService_upvr.ChannelTabsConfiguration
function any_CreateController_result1.toggleChannelTabs(arg1, arg2) -- Line 150
	--[[ Upvalues[1]:
		[1]: ChannelTabsConfiguration_upvr (readonly)
	]]
	ChannelTabsConfiguration_upvr.Enabled = arg2
end
local var52_upvw = 0
function any_CreateController_result1.randomServerTips(arg1) -- Line 154
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var52_upvw (read and write)
	]]
	task.spawn(function() -- Line 155
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: var11_upvw (copied, read and write)
			[3]: var52_upvw (copied, read and write)
			[4]: arg1 (readonly)
		]]
		while task.wait(120) do
			local var54
			if not var54 then
				var54 = nil
				repeat
					var54 = var11_upvw[math.random(1, #var11_upvw)]
				until var52_upvw ~= var54
				var52_upvw = var54
				arg1:message(var54)
				task.wait(180)
			end
		end
	end)
end
local GuiService_upvr = game:GetService("GuiService")
function any_CreateController_result1.KnitStart(arg1) -- Line 176
	--[[ Upvalues[4]:
		[1]: GuiService_upvr (readonly)
		[2]: TextChatService_upvr (readonly)
		[3]: var12_upvw (read and write)
		[4]: var6_upvw (read and write)
	]]
	arg1:onChatWindowAdded()
	arg1:onIncomingMessage()
	arg1:randomServerTips()
	if GuiService_upvr:IsTenFootInterface() then
		local ChatWindowConfiguration_2 = TextChatService_upvr.ChatWindowConfiguration
		ChatWindowConfiguration_2.HeightScale /= 1.75
		local ChatWindowConfiguration = TextChatService_upvr.ChatWindowConfiguration
		ChatWindowConfiguration.WidthScale /= 1.55
		var12_upvw.print("Skala ner chatten eftersom \xE4r p\xE5 konsol")
	end
	var6_upvw.message:Connect(function(...) -- Line 187
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:message(...)
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_CreateController_result1.KnitInit(arg1) -- Line 192
	--[[ Upvalues[9]:
		[1]: var6_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var9_upvw (read and write)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: var10_upvw (read and write)
		[8]: var11_upvw (read and write)
		[9]: var12_upvw (read and write)
	]]
	var6_upvw = Knit_upvr.GetService("ChatService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("LeaderboardController")
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Rarities)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Titles)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.ServerTips)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_CreateController_result1