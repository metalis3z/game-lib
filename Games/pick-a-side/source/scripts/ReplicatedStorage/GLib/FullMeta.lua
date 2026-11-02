-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:07
-- Luau version 6, Types version 3
-- Time taken: 0.000962 seconds

local function var1_upvw(arg1, arg2) -- Line 3
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	setmetatable(arg1, arg2)
	for _, v in next, arg1 do
		if type(v) == "table" then
			var1_upvw(v, arg2)
		end
	end
	return arg1
end
return var1_upvw