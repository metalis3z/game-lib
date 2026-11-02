-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:15:19

-- Luau version 6, Types version 3

-- Time taken: 0.003330 seconds


local module = {}

local module_upvr = {}

module.enums = module_upvr

function module.createEnum(arg1, arg2) -- Line 20

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var13_upvr

	if typeof(arg1) ~= "string" then

		var13_upvr = false

	else

		var13_upvr = true

	end

	assert(var13_upvr, "bad argument #1 - enums must be created using a string name!")

	if typeof(arg2) ~= "table" then

		var13_upvr = false

	else

		var13_upvr = true

	end

	assert(var13_upvr, "bad argument #2 - enums must be created using a table!")

	var13_upvr = not module_upvr[arg1]

	assert(var13_upvr, string.format("enum '%s' already exists!", arg1))

	local module_2 = {}

	var13_upvr = {}

	local tbl_upvr_2 = {}

	local tbl_upvr = {}

	local module_3_upvr = {

		getName = function(arg1_2) -- Line 30, Named "getName"

			--[[ Upvalues[3]:

				[1]: tbl_upvr_2 (readonly)

				[2]: tbl_upvr (readonly)

				[3]: arg2 (readonly)

			]]

			local tostring_result1_3 = tostring(arg1_2)

			local var19 = tbl_upvr_2[tostring_result1_3]

			if not var19 then

				var19 = tbl_upvr[tostring_result1_3]

			end

			if var19 then

				return arg2[var19][1]

			end

		end;

		getValue = function(arg1_3) -- Line 40, Named "getValue"

			--[[ Upvalues[3]:

				[1]: var13_upvr (readonly)

				[2]: tbl_upvr (readonly)

				[3]: arg2 (readonly)

			]]

			local tostring_result1_4 = tostring(arg1_3)

			local var21 = var13_upvr[tostring_result1_4]

			if not var21 then

				var21 = tbl_upvr[tostring_result1_4]

			end

			if var21 then

				return arg2[var21][2]

			end

		end;

		getProperty = function(arg1_4) -- Line 50, Named "getProperty"

			--[[ Upvalues[3]:

				[1]: var13_upvr (readonly)

				[2]: tbl_upvr_2 (readonly)

				[3]: arg2 (readonly)

			]]

			local tostring_result1_2 = tostring(arg1_4)

			local var23 = var13_upvr[tostring_result1_2]

			if not var23 then

				var23 = tbl_upvr_2[tostring_result1_2]

			end

			if var23 then

				return arg2[var23][3]

			end

		end;

	}

	for i, v in pairs(arg2) do

		local var27

		if typeof(v) ~= "table" then

			var27 = false

		else

			var27 = true

		end

		assert(var27, string.format("bad argument #2.%s - details must only be comprised of tables!", i))

		local _1 = v[1]

		if typeof(_1) ~= "string" then

		else

		end

		var27 = assert

		var27(true, string.format("bad argument #2.%s.1 - detail name must be a string!", i))

		var27 = assert

		var27(typeof(not var13_upvr[_1]), string.format("bad argument #2.%s.1 - the detail name '%s' already exists!", i, _1))

		var27 = assert

		var27(typeof(not module_3_upvr[_1]), string.format("bad argument #2.%s.1 - that name is reserved.", i, _1))

		var27 = tostring(_1)

		var13_upvr[var27] = i

		var27 = v[2]

		local tostring_result1 = tostring(var27)

		assert(typeof(not tbl_upvr_2[tostring_result1]), string.format("bad argument #2.%s.2 - the detail value '%s' already exists!", i, tostring_result1))

		tbl_upvr_2[tostring_result1] = i

		local _3 = v[3]

		if _3 then

			assert(typeof(not tbl_upvr[_3]), string.format("bad argument #2.%s.3 - the detail property '%s' already exists!", i, tostring(_3)))

			tbl_upvr[tostring(_3)] = i

		end

		module_2[_1] = var27

		setmetatable(module_2, {

			__index = function(arg1_5, arg2_2) -- Line 80, Named "__index"

				--[[ Upvalues[1]:

					[1]: module_3_upvr (readonly)

				]]

				return module_3_upvr[arg2_2]

			end;

		})

	end

	module_upvr[arg1] = module_2

	return module_2

end

function module.getEnums() -- Line 90

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	return module_upvr

end

for _, v_2 in pairs(script:GetChildren()) do

	if v_2:IsA("ModuleScript") then

		module.createEnum(v_2.Name, require(v_2))

	end

end

return module
