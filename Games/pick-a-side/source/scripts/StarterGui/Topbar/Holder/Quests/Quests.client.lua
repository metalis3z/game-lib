-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:50
-- Luau version 6, Types version 3
-- Time taken: 0.000696 seconds

local Quests_upvr = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gui"):WaitForChild("Quests")
script.Parent.Activated:Connect(function() -- Line 5
	--[[ Upvalues[1]:
		[1]: Quests_upvr (readonly)
	]]
	_G.CloseWindows()
	Quests_upvr.Windows.Orig.Visible = not Quests_upvr.Windows.Orig.Visible
end)