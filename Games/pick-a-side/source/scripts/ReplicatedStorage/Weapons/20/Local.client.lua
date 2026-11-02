-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:50
-- Luau version 6, Types version 3
-- Time taken: 0.001490 seconds

local Parent_upvr = script.Parent
local LocalPlayer_upvr = game.Players.LocalPlayer
local var3_upvw = 0
local Remote_upvr = script.Parent:WaitForChild("Remote")
local mouse_upvr = LocalPlayer_upvr:GetMouse()
function Start() -- Line 12
	--[[ Upvalues[5]:
		[1]: Parent_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var3_upvw (read and write)
		[4]: Remote_upvr (readonly)
		[5]: mouse_upvr (readonly)
	]]
	if Parent_upvr.Parent ~= LocalPlayer_upvr.Character then
	else
		var3_upvw += 1
		while var3_upvw == var3_upvw do
			Remote_upvr:FireServer(mouse_upvr.Hit.p)
			wait(Parent_upvr.Reload.Value)
		end
	end
end
function Release() -- Line 23
	--[[ Upvalues[1]:
		[1]: var3_upvw (read and write)
	]]
	var3_upvw += 1
end
require(game.ReplicatedStorage.Modules.ToolHold)(Start, Release)