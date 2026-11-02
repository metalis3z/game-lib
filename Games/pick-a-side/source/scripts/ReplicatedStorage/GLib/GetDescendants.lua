-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:58
-- Luau version 6, Types version 3
-- Time taken: 0.000800 seconds

return function(arg1) -- Line 8
	local module_upvr = {}
	local function var3_upvw(arg1_2) -- Line 11
		--[[ Upvalues[2]:
			[1]: module_upvr (readonly)
			[2]: var3_upvw (read and write)
		]]
		for _, v in next, arg1_2:GetChildren() do
			table.insert(module_upvr, v)
			var3_upvw(v)
		end
	end
	var3_upvw(arg1)
	return module_upvr
end