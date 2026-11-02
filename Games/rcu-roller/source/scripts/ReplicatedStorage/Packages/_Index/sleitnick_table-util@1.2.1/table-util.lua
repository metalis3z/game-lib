-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:16
-- Luau version 6, Types version 3
-- Time taken: 0.011185 seconds

local module = {}
local HttpService_upvr = game:GetService("HttpService")
local random_state_upvr = Random.new()
local function Sync_upvr(arg1, arg2) -- Line 84, Named "Sync"
	--[[ Upvalues[1]:
		[1]: Sync_upvr (readonly)
	]]
	local var15
	if type(arg1) ~= "table" then
		var15 = false
	else
		var15 = true
	end
	assert(var15, "First argument must be a table")
	if type(arg2) ~= "table" then
		var15 = false
	else
		var15 = true
	end
	assert(var15, "Second argument must be a table")
	var15 = arg1
	local clone_3 = table.clone(var15)
	var15 = pairs(clone_3)
	local pairs_result1, pairs_result2, pairs_result3 = pairs(clone_3)
	for i_2, v_2 in pairs_result1, pairs_result2, pairs_result3 do
		local var20 = arg2[i_2]
		if var20 == nil then
			clone_3[i_2] = nil
		elseif type(v_2) ~= type(var20) then
			if type(var20) == "table" then
				local function DeepCopy(arg1_3) -- Line 44
					--[[ Upvalues[1]:
						[1]: DeepCopy (readonly)
					]]
					local clone = table.clone(arg1_3)
					for i_29, v_24 in clone do
						if type(v_24) == "table" then
							clone[i_29] = DeepCopy(v_24)
						end
					end
					return clone
				end
				clone_3[i_2] = DeepCopy(var20)
			else
				clone_3[i_2] = var20
			end
		else
			DeepCopy = v_2
			if type(DeepCopy) == "table" then
				DeepCopy = v_2
				clone_3[i_2] = Sync_upvr(DeepCopy, var20)
			end
		end
	end
	pairs_result1 = pairs(arg2)
	for i_3, v_3 in pairs(arg2) do
		if clone_3[i_3] == nil then
			DeepCopy = v_3
			if type(DeepCopy) == "table" then
				function DeepCopy(arg1_4) -- Line 44
					--[[ Upvalues[1]:
						[1]: var27_upvr (readonly)
					]]
					local clone_9 = table.clone(arg1_4)
					for i_4, v_4 in clone_9 do
						if type(v_4) == "table" then
							clone_9[i_4] = var27_upvr(v_4)
						end
					end
					return clone_9
				end
				local var27_upvr = DeepCopy
				clone_3[i_3] = var27_upvr(v_3)
			else
				clone_3[i_3] = v_3
			end
		end
	end
	return clone_3
end
local function Reconcile_upvr(arg1, arg2) -- Line 156, Named "Reconcile"
	--[[ Upvalues[1]:
		[1]: Reconcile_upvr (readonly)
	]]
	local var35
	if type(arg1) ~= "table" then
		var35 = false
	else
		var35 = true
	end
	assert(var35, "First argument must be a table")
	if type(arg2) ~= "table" then
		var35 = false
	else
		var35 = true
	end
	assert(var35, "Second argument must be a table")
	var35 = arg1
	var35 = arg2
	for i_5, v_5 in var35 do
		local var36 = arg1[i_5]
		if var36 == nil then
			if type(v_5) == "table" then
				local function DeepCopy_upvr(arg1_5) -- Line 44, Named "DeepCopy"
					--[[ Upvalues[1]:
						[1]: DeepCopy_upvr (readonly)
					]]
					local clone_2 = table.clone(arg1_5)
					for i_6, v_6 in clone_2 do
						if type(v_6) == "table" then
							clone_2[i_6] = DeepCopy_upvr(v_6)
						end
					end
					return clone_2
				end
				table.clone(var35)[i_5] = DeepCopy_upvr(v_5)
			else
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				table.clone(var35)[i_5] = v_5
			end
		else
			DeepCopy_upvr = var36
			if type(DeepCopy_upvr) == "table" then
				DeepCopy_upvr = v_5
				if type(DeepCopy_upvr) == "table" then
					DeepCopy_upvr = var36
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					table.clone(var35)[i_5] = Reconcile_upvr(DeepCopy_upvr, v_5)
				else
					function DeepCopy_upvr(arg1_6) -- Line 44, Named "DeepCopy"
						--[[ Upvalues[1]:
							[1]: var40_upvr (readonly)
						]]
						local clone_7 = table.clone(arg1_6)
						for i_7, v_7 in clone_7 do
							if type(v_7) == "table" then
								clone_7[i_7] = var40_upvr(v_7)
							end
						end
						return clone_7
					end
					local var40_upvr = DeepCopy_upvr
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					table.clone(var35)[i_5] = var40_upvr(var36)
				end
			end
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return table.clone(var35)
end
local function Map_upvr(arg1, arg2) -- Line 262, Named "Map"
	local var51
	if type(arg1) ~= "table" then
		var51 = false
	else
		var51 = true
	end
	assert(var51, "First argument must be a table")
	if type(arg2) ~= "function" then
		var51 = false
	else
		var51 = true
	end
	assert(var51, "Second argument must be a function")
	var51 = #arg1
	var51 = arg1
	for i_8, v_8 in var51 do
		table.create(var51)[i_8] = arg2(v_8, i_8, arg1)
		local var53
	end
	return var53
end
function module.Copy(arg1, arg2) -- Line 40
	if not arg2 then
		return table.clone(arg1)
	end
	local function DeepCopy(arg1_2) -- Line 44
		--[[ Upvalues[1]:
			[1]: DeepCopy (readonly)
		]]
		local clone_6 = table.clone(arg1_2)
		for i, v in clone_6 do
			if type(v) == "table" then
				clone_6[i] = DeepCopy(v)
			end
		end
		return clone_6
	end
	return DeepCopy(arg1)
end
module.Sync = Sync_upvr
module.Reconcile = Reconcile_upvr
function module.SwapRemove(arg1, arg2) -- Line 209
	local len_3 = #arg1
	arg1[arg2] = arg1[len_3]
	arg1[len_3] = nil
end
function module.SwapRemoveFirstValue(arg1, arg2) -- Line 234
	local table_find_result1 = table.find(arg1, arg2)
	if table_find_result1 then
		local len_2 = #arg1
		arg1[table_find_result1] = arg1[len_2]
		arg1[len_2] = nil
	end
	return table_find_result1
end
module.Map = Map_upvr
function module.Filter(arg1, arg2) -- Line 292
	local var62
	if type(arg1) ~= "table" then
		var62 = false
	else
		var62 = true
	end
	assert(var62, "First argument must be a table")
	if type(arg2) ~= "function" then
		var62 = false
	else
		var62 = true
	end
	assert(var62, "Second argument must be a function")
	var62 = #arg1
	local table_create_result1_2 = table.create(var62)
	var62 = #arg1
	if 0 < var62 then
		var62 = 0
		for i_9, v_9 in arg1 do
			if arg2(v_9, i_9, arg1) then
				var62 += 1
				table_create_result1_2[var62] = v_9
			end
		end
		return table_create_result1_2
	end
	var62 = arg1
	for i_10, _ in var62 do
		if arg2(i_9, i_10, arg1) then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			table_create_result1_2[i_10] = i_9
		end
	end
	return table_create_result1_2
end
function module.Reduce(arg1, arg2, arg3) -- Line 335
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var76
	if type(arg1) ~= "table" then
		var76 = false
	else
		var76 = true
	end
	assert(var76, "First argument must be a table")
	if type(arg2) ~= "function" then
		var76 = false
	else
		var76 = true
	end
	assert(var76, "Second argument must be a function")
	var76 = #arg1
	if 0 < var76 then
		var76 = 1
		if arg3 == nil then
			var76 = 2
		end
		for i_11 = var76, #arg1 do
		end
		return arg2(arg1[1], arg1[i_11], i_11, arg1)
	end
	if arg3 == nil then
		local next_result1_2 = next(arg1)
	end
	for i_12, v_11 in next, arg1, next_result1_2 do
	end
	return arg2(next_result1_2, v_11, i_12, arg1)
end
function module.Assign(arg1, ...) -- Line 378
	local clone_5 = table.clone(arg1)
	for _, v_12 in {...} do
		for i_14, v_13 in v_12 do
			clone_5[i_14] = v_13
		end
	end
	return clone_5
end
function module.Extend(arg1, arg2) -- Line 407
	local clone_4 = table.clone(arg1)
	for _, v_14 in arg2 do
		table.insert(clone_4, v_14)
	end
	return clone_4
end
function module.Reverse(arg1) -- Line 432
	local len_4 = #arg1
	local table_create_result1_5 = table.create(len_4)
	for i_16 = 1, len_4 do
		table_create_result1_5[i_16] = arg1[len_4 - i_16 + 1]
	end
	return table_create_result1_5
end
function module.Shuffle(arg1, arg2) -- Line 459
	--[[ Upvalues[1]:
		[1]: random_state_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var101
	if type(arg1) ~= "table" then
		var101 = false
	else
		var101 = true
	end
	assert(var101, "First argument must be a table")
	var101 = arg1
	local clone_8 = table.clone(var101)
	if typeof(arg2) == "Random" then
		var101 = arg2
	else
		var101 = random_state_upvr
	end
	for i_17 = #arg1, 2, -1 do
		local any_NextInteger_result1_2 = var101:NextInteger(1, i_17)
		clone_8[i_17] = clone_8[any_NextInteger_result1_2]
		clone_8[any_NextInteger_result1_2] = clone_8[i_17]
		local var104
	end
	return var104
end
function module.Sample(arg1, arg2, arg3) -- Line 489
	--[[ Upvalues[1]:
		[1]: random_state_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var109
	if type(arg1) ~= "table" then
		var109 = false
	else
		var109 = true
	end
	assert(var109, "First argument must be a table")
	if type(arg2) ~= "number" then
		var109 = false
	else
		var109 = true
	end
	assert(var109, "Second argument must be a number")
	local len_5 = #arg1
	if len_5 == 0 then
		var109 = {}
		return var109
	end
	var109 = table.clone(arg1)
	local table_create_result1_6 = table.create(arg2)
	if typeof(arg3) == "Random" then
	else
	end
	local clamped_2 = math.clamp(arg2, 1, len_5)
	for i_18 = 1, clamped_2 do
		local any_NextInteger_result1 = random_state_upvr:NextInteger(i_18, len_5)
		var109[i_18] = var109[any_NextInteger_result1]
		var109[any_NextInteger_result1] = var109[i_18]
		local _
	end
	table.move(var109, 1, clamped_2, 1, table_create_result1_6)
	return table_create_result1_6
end
function module.Flat(arg1, arg2) -- Line 537
	local var115_upvr
	if type(arg2) == "number" then
		var115_upvr = arg2
	else
		var115_upvr = 1
	end
	local table_create_result1_upvr = table.create(#arg1)
	local function Scan(arg1_7, arg2_2) -- Line 540
		--[[ Upvalues[3]:
			[1]: var115_upvr (readonly)
			[2]: Scan (readonly)
			[3]: table_create_result1_upvr (readonly)
		]]
		for _, v_15 in arg1_7 do
			if type(v_15) == "table" and arg2_2 < var115_upvr then
				Scan(v_15, arg2_2 + 1)
			else
				table.insert(table_create_result1_upvr, v_15)
			end
		end
	end
	Scan(arg1, 0)
	return table_create_result1_upvr
end
function module.FlatMap(arg1, arg2) -- Line 574
	--[[ Upvalues[1]:
		[1]: Map_upvr (readonly)
	]]
	local Map_result1 = Map_upvr(arg1, arg2)
	local table_create_result1_3_upvr = table.create(#Map_result1)
	local var121_upvr = 1
	local function Scan_upvr(arg1_8, arg2_3) -- Line 540, Named "Scan"
		--[[ Upvalues[3]:
			[1]: var121_upvr (readonly)
			[2]: Scan_upvr (readonly)
			[3]: table_create_result1_3_upvr (readonly)
		]]
		for _, v_16 in arg1_8 do
			if type(v_16) == "table" and arg2_3 < var121_upvr then
				Scan_upvr(v_16, arg2_3 + 1)
			else
				table.insert(table_create_result1_3_upvr, v_16)
			end
		end
	end
	var121_upvr = Scan_upvr
	var121_upvr(Map_result1, 0)
	return table_create_result1_3_upvr
end
function module.Keys(arg1) -- Line 600
	local table_create_result1 = table.create(#arg1)
	for i_21 in arg1 do
		table.insert(table_create_result1, i_21)
	end
	return table_create_result1
end
function module.Values(arg1) -- Line 630
	local table_create_result1_4 = table.create(#arg1)
	for _, v_17 in arg1 do
		table.insert(table_create_result1_4, v_17)
	end
	return table_create_result1_4
end
function module.Find(arg1, arg2) -- Line 669
	for i_23, v_18 in arg1 do
		if arg2(v_18, i_23, arg1) then
			return v_18, i_23
		end
	end
	return nil, nil
end
function module.Every(arg1, arg2) -- Line 698
	for i_24, v_19 in arg1 do
		if not arg2(v_19, i_24, arg1) then
			return false
		end
	end
	return true
end
function module.Some(arg1, arg2) -- Line 727
	for i_25, v_20 in arg1 do
		if arg2(v_20, i_25, arg1) then
			return true
		end
	end
	return false
end
function module.Truncate(arg1, arg2) -- Line 753
	local len = #arg1
	local clamped = math.clamp(arg2, 1, len)
	if clamped == len then
		return table.clone(arg1)
	end
	return table.move(arg1, 1, clamped, 1, table.create(clamped))
end
function module.Zip(...) -- Line 786
	local ZipIteratorMap
	if 0 >= select('#', ...) then
		ZipIteratorMap = false
	else
		ZipIteratorMap = true
	end
	assert(ZipIteratorMap, "Must supply at least 1 table")
	function ZipIteratorMap(arg1, arg2) -- Line 801
		for i_27, v_22 in arg1 do
			local next_result1 = next(v_22, arg2)
			if next_result1 ~= nil then
				({})[i_27] = next_result1
			else
				return nil, nil
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		return arg2, {}
	end
	local args_list = {...}
	if 0 < #args_list[1] then
		return function(arg1, arg2) -- Line 788, Named "ZipIteratorArray"
			local var143 = arg2 + 1
			for i_26, v_21 in arg1 do
				local var144 = v_21[var143]
				if var144 ~= nil then
					({})[i_26] = var144
				else
					return nil, nil
				end
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var143, {}
		end, args_list, 0
	end
	return ZipIteratorMap, args_list, nil
end
function module.Lock(arg1) -- Line 839
	local function Freeze_upvr(arg1_9) -- Line 840, Named "Freeze"
		--[[ Upvalues[1]:
			[1]: Freeze_upvr (readonly)
		]]
		for i_28, v_23 in pairs(arg1_9) do
			if type(v_23) == "table" then
				arg1_9[i_28] = Freeze_upvr(v_23)
			end
		end
		return table.freeze(arg1_9)
	end
	return Freeze_upvr(arg1)
end
function module.IsEmpty(arg1) -- Line 869
	local var154
	if next(arg1) ~= nil then
		var154 = false
	else
		var154 = true
	end
	return var154
end
function module.EncodeJSON(arg1) -- Line 881
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	return HttpService_upvr:JSONEncode(arg1)
end
function module.DecodeJSON(arg1) -- Line 893
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	return HttpService_upvr:JSONDecode(arg1)
end
return module