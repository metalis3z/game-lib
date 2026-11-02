-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:49
-- Luau version 6, Types version 3
-- Time taken: 0.000926 seconds

local Like_upvr = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gui"):WaitForChild("Like")
script.Parent.Activated:Connect(function() -- Line 5
	--[[ Upvalues[1]:
		[1]: Like_upvr (readonly)
	]]
	_G.CloseWindows()
	Like_upvr.Windows.Orig.Visible = not Like_upvr.Windows.Orig.Visible
end)