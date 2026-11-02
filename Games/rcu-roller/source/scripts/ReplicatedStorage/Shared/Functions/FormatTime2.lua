-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:16
-- Luau version 6, Types version 3
-- Time taken: 0.000963 seconds

local function getTimeFormat_upvr(arg1) -- Line 5, Named "getTimeFormat"
	local module = {}
	local var2 = (arg1 - arg1 % 60) / 60
	local var3 = (var2 - var2 % 60) / 60
	local var4 = (var3 - var3 % 24) / 24
	module.seconds = arg1 - var2 * 60
	module.minutes = var2 - var3 * 60
	module.hours = var3 - var4 * 24
	module.days = var4
	return module
end
return function(arg1, arg2) -- Line 23
	--[[ Upvalues[1]:
		[1]: getTimeFormat_upvr (readonly)
	]]
	local getTimeFormat_result1 = getTimeFormat_upvr(arg1)
	local tbl = {}
	if 0 < getTimeFormat_result1.days then
		table.insert(tbl, getTimeFormat_result1.days..'d')
	end
	if 0 < getTimeFormat_result1.hours then
		table.insert(tbl, getTimeFormat_result1.hours..'h')
	end
	if 0 < getTimeFormat_result1.minutes then
		table.insert(tbl, getTimeFormat_result1.minutes..'m')
	end
	if 0 < getTimeFormat_result1.seconds or #tbl == 0 then
		table.insert(tbl, getTimeFormat_result1.seconds..'s')
	end
	return table.concat({unpack(tbl, 1, arg2 or 2)}, ' ')
end