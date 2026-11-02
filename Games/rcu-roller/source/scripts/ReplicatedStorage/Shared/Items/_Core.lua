-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:38
-- Luau version 6, Types version 3
-- Time taken: 0.000987 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 8
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	return setmetatable({}, module_upvr)
end
function module_upvr.setData(arg1, arg2) -- Line 14
	for i, v in arg2 do
		arg1[i] = v
	end
	return arg1
end
function module_upvr.getClass(arg1) -- Line 21
	return arg1.cl
end
function module_upvr.getName(arg1) -- Line 25
	return arg1.nm
end
function module_upvr.hasConfirm(arg1) -- Line 29
	return arg1:directory()[arg1:getName()].confirm
end
function module_upvr.isTemporary(arg1) -- Line 33
	return arg1:directory()[arg1:getName()].temporary
end
function module_upvr.setAmount(arg1, arg2) -- Line 37
	arg1.am = arg2
	return arg1
end
function module_upvr.getAmount(arg1) -- Line 42
	return arg1.am or 1
end
return module_upvr