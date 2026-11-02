-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:29
-- Luau version 6, Types version 3
-- Time taken: 0.001297 seconds

local MarketplaceService_upvr = game:GetService("MarketplaceService")
local LocalPlayer_upvr = game.Players.LocalPlayer
local Gui = workspace.Passes.Screen.Gui
local tbl = {}
local tbl_2_upvr = {
	VIP = 687675648;
	Radio = 687678420;
}
tbl.VIP = Gui.VIP.Buy
tbl.Radio = Gui.Radio.Buy
for i_upvr, v in pairs(tbl) do
	v.MouseButton1Down:connect(function() -- Line 29
		--[[ Upvalues[4]:
			[1]: MarketplaceService_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: tbl_2_upvr (readonly)
			[4]: i_upvr (readonly)
		]]
		MarketplaceService_upvr:PromptPurchase(LocalPlayer_upvr, tbl_2_upvr[i_upvr])
	end)
end