-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:59
-- Luau version 6, Types version 3
-- Time taken: 0.001427 seconds

local Parent_upvr = script.Parent
local var2_upvw = true
function onEquippedLocal(arg1) -- Line 4
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	var2_upvw = true
	if arg1 == nil then
		print("Mouse not found")
	else
		while true do
			if not var2_upvw then break end
			arg1.Icon = "rbxasset://textures\\GunCursor.png"
			while true do
				if not Parent_upvr.Enabled then break end
				if not var2_upvw then break end
				wait(0.01)
			end
			arg1.Icon = "rbxasset://textures\\GunWaitCursor.png"
			while true do
				if Parent_upvr.Enabled then break end
				if not var2_upvw then break end
				wait(0.01)
			end
		end
	end
end
function onUnequippedLocal() -- Line 26
	--[[ Upvalues[1]:
		[1]: var2_upvw (read and write)
	]]
	var2_upvw = false
end
Parent_upvr.Equipped:connect(onEquippedLocal)
Parent_upvr.Unequipped:connect(onUnequippedLocal)