-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:51
-- Luau version 6, Types version 3
-- Time taken: 0.000779 seconds

local Remote_upvr = script.Parent:WaitForChild("Remote")
local mouse_upvr = game.Players.LocalPlayer:GetMouse()
script.Parent.Activated:Connect(function() -- Line 7
	--[[ Upvalues[2]:
		[1]: Remote_upvr (readonly)
		[2]: mouse_upvr (readonly)
	]]
	Remote_upvr:FireServer(mouse_upvr.Hit.p)
end)