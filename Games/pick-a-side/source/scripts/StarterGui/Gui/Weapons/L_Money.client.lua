-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:34
-- Luau version 6, Types version 3
-- Time taken: 0.003652 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Parent = script.Parent
function Beautify(arg1) -- Line 13
	local var5
	repeat
		local string_gsub_result1, string_gsub_result2 = string.gsub(var5, "^(-?%d+)(%d%d%d)", "%1,%2")
		var5 = string_gsub_result1
	until string_gsub_result2 == 0
	return var5
end
local Title_upvr = Parent.Windows.Orig.Amount.Title
local money_upvw = CLIENT_DATA_upvr.data.money
Title_upvr.Text = '$'..Beautify(money_upvw)
local Kaching_upvr = Parent.Kaching
function UpdateMoney() -- Line 36
	--[[ Upvalues[4]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: Title_upvr (readonly)
		[3]: money_upvw (read and write)
		[4]: Kaching_upvr (readonly)
	]]
	local data = CLIENT_DATA_upvr.data
	Title_upvr.Text = '$'..Beautify(data.money)
	local var12 = data.money - money_upvw
	if var12 ~= 0 then
		Kaching_upvr:Play()
	end
	if 0 < var12 then
		_G.message("Reward", "+$"..Beautify(var12), Color3.new(1, 1, 0))
	end
	money_upvw = data.money
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
for _, v_upvr in pairs(Parent.Windows.Money.List:GetChildren()) do
	if v_upvr.ClassName == "TextButton" then
		local MarketplaceService_upvr = game:GetService("MarketplaceService")
		local LocalPlayer_upvr = game.Players.LocalPlayer
		v_upvr.MouseButton1Down:connect(function() -- Line 68
			--[[ Upvalues[4]:
				[1]: MarketplaceService_upvr (readonly)
				[2]: LocalPlayer_upvr (readonly)
				[3]: tbl_upvr (readonly)
				[4]: v_upvr (readonly)
			]]
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, tbl_upvr[v_upvr.Name])
			game.ReplicatedStorage.Signals.LogFunnel:FireServer("Purchase")
		end)
	end
end
Parent.Windows.Money:GetPropertyChangedSignal("Visible"):Connect(function() -- Line 76
	game.ReplicatedStorage.Signals.LogFunnel:FireServer("Money")
end)