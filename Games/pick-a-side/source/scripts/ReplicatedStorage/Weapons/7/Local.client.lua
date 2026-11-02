-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:47
-- Luau version 6, Types version 3
-- Time taken: 0.000893 seconds

local Parent_upvr = script.Parent
local Remote_upvr = script.Parent:WaitForChild("Remote")
local mouse_upvr = game.Players.LocalPlayer:GetMouse()
Parent_upvr.Activated:Connect(function() -- Line 11
	--[[ Upvalues[3]:
		[1]: Parent_upvr (readonly)
		[2]: Remote_upvr (readonly)
		[3]: mouse_upvr (readonly)
	]]
	if Parent_upvr.Enabled == true then
		Parent_upvr.Enabled = false
		Remote_upvr:FireServer(mouse_upvr.Hit.p)
		wait(Parent_upvr.Reload.Value)
		Parent_upvr.Enabled = true
	end
end)