-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:18
-- Luau version 6, Types version 3
-- Time taken: 0.002735 seconds

local Parent_upvr = script.Parent
local var2_upvw
local function _() -- Line 8, Named "UpdateIcon"
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	local var3
	if var2_upvw then
		if Parent_upvr.Enabled then
			var3 = "rbxasset://textures/GunCursor.png"
		else
			var3 = "rbxasset://textures/GunWaitCursor.png"
		end
		var2_upvw.Icon = var3
	end
end
Parent_upvr.Equipped:connect(function(arg1) -- Line 14, Named "OnEquipped"
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	var2_upvw = arg1
	local var4
	if var2_upvw then
		if Parent_upvr.Enabled then
			var4 = "rbxasset://textures/GunCursor.png"
		else
			var4 = "rbxasset://textures/GunWaitCursor.png"
		end
		var2_upvw.Icon = var4
	end
end)
Parent_upvr.Changed:connect(function(arg1) -- Line 19, Named "OnChanged"
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	if arg1 == "Enabled" then
		local var6
		if var2_upvw then
			if Parent_upvr.Enabled then
				var6 = "rbxasset://textures/GunCursor.png"
			else
				var6 = "rbxasset://textures/GunWaitCursor.png"
			end
			var2_upvw.Icon = var6
		end
	end
end)