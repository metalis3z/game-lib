-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:57
-- Luau version 6, Types version 3
-- Time taken: 0.000556 seconds

local function deepCopy_upvr(arg1) -- Line 7, Named "deepCopy"
	--[[ Upvalues[1]:
		[1]: deepCopy_upvr (readonly)
	]]
	local module = {}
	for i, v in pairs(arg1) do
		if type(v) == "table" then
			v = deepCopy_upvr(v)
		end
		module[i] = v
	end
	return module
end
return function(arg1) -- Line 18
	--[[ Upvalues[1]:
		[1]: deepCopy_upvr (readonly)
	]]
	return deepCopy_upvr(arg1)
end