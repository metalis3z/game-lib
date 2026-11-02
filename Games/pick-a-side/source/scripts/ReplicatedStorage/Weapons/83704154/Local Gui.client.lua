-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:07
-- Luau version 6, Types version 3
-- Time taken: 0.001441 seconds

Tool = script.Parent -- Setting global
local var1_upvw = false
function onEquippedLocal(arg1) -- Line 5
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = true
	if arg1 == nil then
		print("Mouse not found")
	else
		while true do
			if not var1_upvw then break end
			arg1.Icon = "rbxasset://textures\\GunCursor.png"
			while true do
				if not Tool.Enabled then break end
				if not var1_upvw then break end
				wait(0.01)
			end
			arg1.Icon = "rbxasset://textures\\GunWaitCursor.png"
			while true do
				if Tool.Enabled then break end
				if not var1_upvw then break end
				wait(0.01)
			end
		end
	end
end
function onUnequippedLocal() -- Line 24
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = false
end
Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)