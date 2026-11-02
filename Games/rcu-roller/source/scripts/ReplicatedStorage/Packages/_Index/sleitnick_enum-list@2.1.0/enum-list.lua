-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:53
-- Luau version 6, Types version 3
-- Time taken: 0.001515 seconds

local newproxy_result1_upvr_2 = newproxy()
local newproxy_result1_upvr = newproxy()
local function _(arg1, arg2, arg3) -- Line 23, Named "CreateEnumItem"
	local module = {}
	module.Name = arg1
	module.Value = arg2
	module.EnumType = arg3
	table.freeze(module)
	return module
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1, arg2) -- Line 57
	--[[ Upvalues[3]:
		[1]: newproxy_result1_upvr_2 (readonly)
		[2]: newproxy_result1_upvr (readonly)
		[3]: module_upvr (readonly)
	]]
	local var9
	if type(arg1) ~= "string" then
		var9 = false
	else
		var9 = true
	end
	assert(var9, "Name string required")
	if type(arg2) ~= "table" then
		var9 = false
	else
		var9 = true
	end
	assert(var9, "Enums table required")
	local tbl = {}
	var9 = newproxy_result1_upvr_2
	tbl[var9] = {}
	var9 = newproxy_result1_upvr
	tbl[var9] = arg1
	var9 = ipairs(arg2)
	local ipairs_result1, ipairs_result2, ipairs_result3 = ipairs(arg2)
	for i, v in ipairs_result1, ipairs_result2, ipairs_result3 do
		local var14
		if type(v) ~= "string" then
			var14 = false
		else
			var14 = true
		end
		assert(var14, "Enum name must be a string")
		var14 = {}
		var14.Name = v
		var14.Value = i
		var14.EnumType = tbl
		table.freeze(var14)
		local var15 = var14
		tbl[v] = var15
		var14 = table.insert
		var14(tbl[newproxy_result1_upvr_2], var15)
	end
	ipairs_result1 = table.freeze(setmetatable(tbl, module_upvr))
	return ipairs_result1
end
function module_upvr.BelongsTo(arg1, arg2) -- Line 77
	local var16 = false
	if type(arg2) == "table" then
		if arg2.EnumType ~= arg1 then
			var16 = false
		else
			var16 = true
		end
	end
	return var16
end
function module_upvr.GetEnumItems(arg1) -- Line 86
	--[[ Upvalues[1]:
		[1]: newproxy_result1_upvr_2 (readonly)
	]]
	return arg1[newproxy_result1_upvr_2]
end
function module_upvr.GetName(arg1) -- Line 95
	--[[ Upvalues[1]:
		[1]: newproxy_result1_upvr (readonly)
	]]
	return arg1[newproxy_result1_upvr]
end
return module_upvr