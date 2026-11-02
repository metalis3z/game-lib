-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:38
-- Luau version 6, Types version 3
-- Time taken: 0.003237 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
function Beautify(arg1) -- Line 13
	local var5
	repeat
		local string_gsub_result1, string_gsub_result2 = string.gsub(var5, "^(-?%d+)(%d%d%d)", "%1,%2")
		var5 = string_gsub_result1
	until string_gsub_result2 == 0
	return var5
end
local Windows = script.Parent.Windows
local Title_upvr_2 = Windows.Custom1.Amount.Title
local Title_upvr = Windows.Custom2.Amount.Title
local money = CLIENT_DATA_upvr.data.money
Title_upvr_2.Text = '$'..Beautify(money)
Title_upvr.Text = '$'..Beautify(money)
function UpdateMoney() -- Line 40
	--[[ Upvalues[3]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: Title_upvr_2 (readonly)
		[3]: Title_upvr (readonly)
	]]
	local data = CLIENT_DATA_upvr.data
	Title_upvr_2.Text = '$'..Beautify(data.money)
	Title_upvr.Text = '$'..Beautify(data.money)
end
CLIENT_DATA_upvr.change.Event:connect(UpdateMoney)
local tbl_upvr = {
	["10"] = 51638939;
	["50"] = 51639006;
	["250"] = 51639120;
	["625"] = 51639194;
	["1000"] = 51639309;
	["2000"] = 51639382;
}
for _, v_upvr in pairs(Windows.Money.List:GetChildren()) do
	if v_upvr.ClassName == "TextButton" then
		local MarketplaceService_upvr = game:GetService("MarketplaceService")
		local LocalPlayer_upvr = game.Players.LocalPlayer
		v_upvr.MouseButton1Down:connect(function() -- Line 73
			--[[ Upvalues[4]:
				[1]: MarketplaceService_upvr (readonly)
				[2]: LocalPlayer_upvr (readonly)
				[3]: tbl_upvr (readonly)
				[4]: v_upvr (readonly)
			]]
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, tbl_upvr[v_upvr.Name])
		end)
	end
end