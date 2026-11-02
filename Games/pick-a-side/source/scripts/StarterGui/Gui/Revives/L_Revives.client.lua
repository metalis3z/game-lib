-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:45
-- Luau version 6, Types version 3
-- Time taken: 0.004336 seconds

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
local Title_upvr = script.Parent.Revives.Title
local revives_upvw = CLIENT_DATA_upvr.data.revives
Title_upvr.Text = Beautify(revives_upvw)
local Resurrect_upvr = Parent.Resurrect
function UpdateRevives() -- Line 35
	--[[ Upvalues[4]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: Title_upvr (readonly)
		[3]: revives_upvw (read and write)
		[4]: Resurrect_upvr (readonly)
	]]
	local data = CLIENT_DATA_upvr.data
	Title_upvr.Text = Beautify(data.revives)
	local var12 = data.revives - revives_upvw
	if var12 ~= 0 then
		Resurrect_upvr:Play()
	end
	if 0 < var12 then
		_G.message("Reward", '+'..Beautify(var12), Color3.new(1, 0, 0))
	end
	revives_upvw = data.revives
end
CLIENT_DATA_upvr.change.Event:connect(UpdateRevives)
local tbl_upvr = {
	['1'] = 1909851020;
	['3'] = 1909851618;
	['5'] = 1909852270;
	["10"] = 1909852919;
	["25"] = 1909853652;
	["50"] = 1909854221;
}
for _, v_upvr in pairs(Parent.Windows.Orig.List:GetChildren()) do
	if v_upvr.ClassName == "TextButton" then
		local MarketplaceService_upvr = game:GetService("MarketplaceService")
		local LocalPlayer_upvr = game.Players.LocalPlayer
		v_upvr.MouseButton1Down:connect(function() -- Line 67
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
local Parent_2_upvr = script.Parent
script.Parent.Revives.Title.Buttons.Activated:Connect(function() -- Line 75
	--[[ Upvalues[1]:
		[1]: Parent_2_upvr (readonly)
	]]
	_G.CloseWindows()
	Parent_2_upvr.Windows.Orig.Visible = not Parent_2_upvr.Windows.Orig.Visible
end)