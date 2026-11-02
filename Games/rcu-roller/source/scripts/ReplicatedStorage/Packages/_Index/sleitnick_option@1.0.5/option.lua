-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:01
-- Luau version 6, Types version 3
-- Time taken: 0.004374 seconds

local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr._new(arg1) -- Line 129
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local module = {}
	local var3 = "Option"
	module.ClassName = var3
	module._v = arg1
	if arg1 == nil then
		var3 = false
	else
		var3 = true
	end
	module._s = var3
	return setmetatable(module, module_2_upvr)
end
function module_2_upvr.Some(arg1) -- Line 145
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1 == nil then
	else
	end
	assert(true, "Option.Some() value cannot be nil")
	return module_2_upvr._new(arg1)
end
function module_2_upvr.Wrap(arg1) -- Line 158
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1 == nil then
		return module_2_upvr.None
	end
	return module_2_upvr.Some(arg1)
end
function module_2_upvr.Is(arg1) -- Line 171
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local var4 = false
	if type(arg1) == "table" then
		if getmetatable(arg1) ~= module_2_upvr then
			var4 = false
		else
			var4 = true
		end
	end
	return var4
end
function module_2_upvr.Assert(arg1) -- Line 179
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	assert(module_2_upvr.Is(arg1), "Result was not of type Option")
end
function module_2_upvr.Deserialize(arg1) -- Line 189
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local var5 = false
	local var6
	if type(arg1) == "table" then
		if arg1.ClassName ~= "Option" then
			var5 = false
		else
			var5 = true
		end
	end
	var6 = assert
	var6(var5, "Invalid data for deserializing Option")
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var6 = module_2_upvr.None
		return var6
	end
	if arg1.Value ~= nil or not INLINED() then
		var6 = module_2_upvr.Some(arg1.Value)
	end
	return var6
end
function module_2_upvr.Serialize(arg1) -- Line 198
	return {
		ClassName = arg1.ClassName;
		Value = arg1._v;
	}
end
function module_2_upvr.Match(arg1, arg2) -- Line 219
	local Some_2 = arg2.Some
	local None = arg2.None
	local var10
	if type(Some_2) ~= "function" then
		var10 = false
	else
		var10 = true
	end
	assert(var10, "Missing 'Some' match")
	if type(None) ~= "function" then
		var10 = false
	else
		var10 = true
	end
	assert(var10, "Missing 'None' match")
	if arg1:IsSome() then
		var10 = arg1:Unwrap()
		return Some_2(var10)
	end
	return None()
end
function module_2_upvr.IsSome(arg1) -- Line 235
	return arg1._s
end
function module_2_upvr.IsNone(arg1) -- Line 243
	return not arg1._s
end
function module_2_upvr.Expect(arg1, arg2) -- Line 257
	assert(arg1:IsSome(), arg2)
	return arg1._v
end
function module_2_upvr.ExpectNone(arg1, arg2) -- Line 266
	assert(arg1:IsNone(), arg2)
end
function module_2_upvr.Unwrap(arg1) -- Line 274
	return arg1:Expect("Cannot unwrap option of None type")
end
function module_2_upvr.UnwrapOr(arg1, arg2) -- Line 283
	if arg1:IsSome() then
		return arg1:Unwrap()
	end
	return arg2
end
function module_2_upvr.UnwrapOrElse(arg1, arg2) -- Line 297
	if arg1:IsSome() then
		return arg1:Unwrap()
	end
	return arg2()
end
function module_2_upvr.And(arg1, arg2) -- Line 323
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1:IsSome() then
		return arg2
	end
	return module_2_upvr.None
end
function module_2_upvr.AndThen(arg1, arg2) -- Line 347
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1:IsSome() then
		local arg2_result1 = arg2(arg1:Unwrap())
		module_2_upvr.Assert(arg2_result1)
		return arg2_result1
	end
	return module_2_upvr.None
end
function module_2_upvr.Or(arg1, arg2) -- Line 362
	if arg1:IsSome() then
		return arg1
	end
	return arg2
end
function module_2_upvr.OrElse(arg1, arg2) -- Line 376
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1:IsSome() then
		return arg1
	end
	local arg2_result1_2 = arg2()
	module_2_upvr.Assert(arg2_result1_2)
	return arg2_result1_2
end
function module_2_upvr.XOr(arg1, arg2) -- Line 393
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local any_IsSome_result1_4 = arg1:IsSome()
	if any_IsSome_result1_4 == arg2:IsSome() then
		return module_2_upvr.None
	end
	if any_IsSome_result1_4 then
		return arg1
	end
	return arg2
end
function module_2_upvr.Filter(arg1, arg2) -- Line 411
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if arg1:IsNone() or not arg2(arg1._v) then
		return module_2_upvr.None
	end
	return arg1
end
function module_2_upvr.Contains(arg1, arg2) -- Line 424
	local any_IsSome_result1_2 = arg1:IsSome()
	if any_IsSome_result1_2 then
		if arg1._v ~= arg2 then
			any_IsSome_result1_2 = false
		else
			any_IsSome_result1_2 = true
		end
	end
	return any_IsSome_result1_2
end
function module_2_upvr.__tostring(arg1) -- Line 438
	if arg1:IsSome() then
		return "Option<"..typeof(arg1._v)..'>'
	end
	return "Option<None>"
end
function module_2_upvr.__eq(arg1, arg2) -- Line 464
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	if module_2_upvr.Is(arg2) then
		if arg1:IsSome() then
			local any_IsSome_result1 = arg2:IsSome()
			if any_IsSome_result1 then
				if arg1:Unwrap() ~= arg2:Unwrap() then
					any_IsSome_result1 = false
				else
					any_IsSome_result1 = true
				end
				return any_IsSome_result1
			end
		end
		if arg1:IsNone() and arg2:IsNone() then
			return true
		end
	end
	return false
end
module_2_upvr.None = module_2_upvr._new()
return module_2_upvr