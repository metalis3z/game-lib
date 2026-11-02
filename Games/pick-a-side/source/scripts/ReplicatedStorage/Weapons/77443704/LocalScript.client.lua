-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:26
-- Luau version 6, Types version 3
-- Time taken: 0.001004 seconds

local Parent_upvr = script.Parent
local module_upvr = require(Parent_upvr:WaitForChild("Sword"))
if not workspace.FilteringEnabled then
	module_upvr:Initialize()
end
Parent_upvr.Equipped:connect(function(arg1) -- Line 15
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	arg1.Button1Down:connect(function() -- Line 16
		--[[ Upvalues[2]:
			[1]: Parent_upvr (copied, readonly)
			[2]: module_upvr (copied, readonly)
		]]
		if workspace.FilteringEnabled then
			Parent_upvr.RemoteClick:FireServer()
		else
			module_upvr:Attack()
		end
	end)
end)