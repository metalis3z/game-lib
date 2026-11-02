-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:03
-- Luau version 6, Types version 3
-- Time taken: 0.014783 seconds

local tostring_upvr = tostring
local tbl_upvr = {
	forward = true;
	backward = true;
	loopforward = true;
	loopbackward = true;
	pingpong = true;
}
local module_3_upvr = {
	__tostring = function(arg1) -- Line 1, Named "__tostring"
		--[[ Upvalues[1]:
			[1]: tostring_upvr (readonly)
		]]
		local var8 = "tween{"
		for i, v in pairs(arg1.p) do
			var8 = var8..' '..tostring_upvr(i)..'='..tostring_upvr(v)
		end
		var8 = var8.." }"
		return var8
	end;
}
local module_2_upvr = require(script.Parent:WaitForChild('e'))
local function h_upvr(arg1, arg2, arg3) -- Line 1, Named "h"
	--[[ Upvalues[2]:
		[1]: module_2_upvr (readonly)
		[2]: module_3_upvr (readonly)
	]]
	local module = {
		d = arg1 or 1;
	}
	local var14 = arg2
	if not var14 then
		var14 = module_2_upvr.inExpo
	end
	module.f = var14
	var14 = arg3
	local var15 = var14
	if not var15 then
		var15 = {}
	end
	module.p = var15
	return setmetatable(module, module_3_upvr)
end
return function(arg1) -- Line 1, Named "l"
	--[[ Upvalues[3]:
		[1]: h_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: tostring_upvr (readonly)
	]]
	local var16_upvw
	local var17_upvw
	local var18_upvw
	local var19_upvw
	local function r_upvr(arg1_2) -- Line 1, Named "r"
		--[[ Upvalues[1]:
			[1]: var16_upvw (read and write)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [20] 16. Error Block 18 start (CF ANALYSIS FAILED)
		if type(arg1_2) == "number" then
		end
		-- KONSTANTERROR: [20] 16. Error Block 18 end (CF ANALYSIS FAILED)
	end
	local function z_upvr() -- Line 1, Named "z"
		--[[ Upvalues[4]:
			[1]: var16_upvw (read and write)
			[2]: var17_upvw (read and write)
			[3]: arg1 (read and write)
			[4]: var19_upvw (read and write)
		]]
		if #var16_upvw <= 1 then
			return var16_upvw[var17_upvw], var17_upvw
		end
		if arg1 == "forward" then
			local var29 = var17_upvw + 1
			return var16_upvw[var29], var29
		end
		if arg1 == "backward" then
			local var30 = var17_upvw - 1
			return var16_upvw[var30], var30
		end
		if arg1 == "loopforward" then
			local var31 = var17_upvw + 1
			if #var16_upvw < var31 then
				var31 = 1
			end
			return var16_upvw[var31], var31
		end
		if arg1 == "loopbackward" then
			local var32 = var17_upvw - 1
			if var32 < 1 then
				var32 = #var16_upvw
			end
			return var16_upvw[var32], var32
		end
		if arg1 == "pingpong" then
			local var33 = var17_upvw + var19_upvw
			if #var16_upvw < var33 then
				var33 = #var16_upvw - 1
			elseif var33 < 1 then
				var33 = 2
			end
			return var16_upvw[var33], var33
		end
	end
	local function D_upvr() -- Line 1, Named "D"
		--[[ Upvalues[4]:
			[1]: var16_upvw (read and write)
			[2]: var17_upvw (read and write)
			[3]: arg1 (read and write)
			[4]: var19_upvw (read and write)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 2 start (CF ANALYSIS FAILED)
		var17_upvw = #var16_upvw
		do
			return
		end
		-- KONSTANTERROR: [5] 5. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [9] 9. Error Block 3 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [9] 9. Error Block 3 end (CF ANALYSIS FAILED)
	end
	var16_upvw = {}
	local var53_upvw = var16_upvw
	var17_upvw = nil
	var18_upvw = 0
	var19_upvw = 1
	local var54 = arg1 or "forward"
	assert(tbl_upvr[var54], tostring_upvr(var54).." is invalid, must be one of the valid animation modes")
	arg1 = var54
	return {
		getCurrentProperties = function() -- Line 1, Named "I"
			--[[ Upvalues[4]:
				[1]: var16_upvw (read and write)
				[2]: var17_upvw (read and write)
				[3]: z_upvr (readonly)
				[4]: var18_upvw (read and write)
			]]
			local module_4 = {}
			local var44 = var16_upvw[var17_upvw]
			local z_upvr_result1 = z_upvr()
			if var44 then
				for i_3, v_2 in pairs(var44.p) do
					module_4[i_3] = v_2
				end
			end
			if z_upvr_result1 and 0 < var18_upvw then
				i_3 = pairs
				v_2 = z_upvr_result1.p
				i_3 = i_3(v_2)
				for i_4, v_3 in i_3(v_2) do
					local var52 = module_4[i_4]
					if type(var52) == "number" and type(v_3) == "number" then
						module_4[i_4] = z_upvr_result1.f(var18_upvw, var52, v_3 - var52, z_upvr_result1.d)
					end
				end
			end
			return module_4
		end;
		add = function(...) -- Line 1, Named "u"
			--[[ Upvalues[3]:
				[1]: h_upvr (copied, readonly)
				[2]: var16_upvw (read and write)
				[3]: var17_upvw (read and write)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local args_list = {...}
			local var25
			for i_2 = 1, 3 do
				if type(args_list[i_2]) == "number" then
				elseif type(args_list[i_2]) == "table" then
				elseif type(args_list[i_2]) == "function" then
				end
			end
			local h_upvr_result1 = h_upvr(nil, args_list[i_2], args_list[i_2])
			var16_upvw[#var16_upvw + 1] = h_upvr_result1
			if not var17_upvw then
				var17_upvw = 1
			end
			return h_upvr_result1
		end;
		remove = function(arg1_3) -- Line 1, Named "remove"
			--[[ Upvalues[3]:
				[1]: r_upvr (readonly)
				[2]: var16_upvw (read and write)
				[3]: var17_upvw (read and write)
			]]
			local r_upvr_result1_2 = r_upvr(arg1_3)
			if r_upvr_result1_2 then
				if var17_upvw < #var16_upvw then
					var17_upvw = #var16_upvw
				end
				return table.remove(var16_upvw, r_upvr_result1_2)
			end
		end;
		reset = function() -- Line 1, Named "N"
			--[[ Upvalues[4]:
				[1]: var16_upvw (read and write)
				[2]: var17_upvw (read and write)
				[3]: var18_upvw (read and write)
				[4]: var19_upvw (read and write)
			]]
			var16_upvw = {}
			var17_upvw = nil
			var18_upvw = 0
			var19_upvw = 1
		end;
		getLength = function() -- Line 1, Named "getLength"
			--[[ Upvalues[1]:
				[1]: var53_upvw (read and write)
			]]
			return #var53_upvw
		end;
		getElapsed = function() -- Line 1, Named "getElapsed"
			--[[ Upvalues[1]:
				[1]: var18_upvw (read and write)
			]]
			return var18_upvw
		end;
		setCurrent = function(arg1_4) -- Line 1, Named "x"
			--[[ Upvalues[3]:
				[1]: r_upvr (readonly)
				[2]: var17_upvw (read and write)
				[3]: var18_upvw (read and write)
			]]
			local r_upvr_result1 = r_upvr(arg1_4)
			if r_upvr_result1 then
				var17_upvw = r_upvr_result1
				var18_upvw = 0
			end
		end;
		getCurrent = function() -- Line 1, Named "y"
			--[[ Upvalues[2]:
				[1]: var16_upvw (read and write)
				[2]: var17_upvw (read and write)
			]]
			return var16_upvw[var17_upvw], var17_upvw
		end;
		getNext = z_upvr;
		setMode = function(arg1_5) -- Line 1, Named "B"
			--[[ Upvalues[3]:
				[1]: tbl_upvr (copied, readonly)
				[2]: tostring_upvr (copied, readonly)
				[3]: arg1 (read and write)
			]]
			local var34 = arg1_5 or "forward"
			assert(tbl_upvr[var34], tostring_upvr(var34).." is invalid, must be one of the valid animation modes")
			arg1 = var34
		end;
		getMode = function() -- Line 1, Named "getMode"
			--[[ Upvalues[1]:
				[1]: arg1 (read and write)
			]]
			return arg1
		end;
		update = function(arg1_6) -- Line 1, Named "E"
			--[[ Upvalues[5]:
				[1]: var18_upvw (read and write)
				[2]: var16_upvw (read and write)
				[3]: var17_upvw (read and write)
				[4]: z_upvr (readonly)
				[5]: D_upvr (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			var18_upvw += arg1_6
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [19] 17. Error Block 4 start (CF ANALYSIS FAILED)
			D_upvr()
			var18_upvw = 0
			do
				return
			end
			-- KONSTANTERROR: [19] 17. Error Block 4 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [24] 22. Error Block 5 start (CF ANALYSIS FAILED)
			var18_upvw = 0
			-- KONSTANTERROR: [24] 22. Error Block 5 end (CF ANALYSIS FAILED)
		end;
		eachTween = function() -- Line 1, Named "eachTween"
			--[[ Upvalues[1]:
				[1]: var53_upvw (read and write)
			]]
			local var57_upvw = 0
			return function() -- Line 1
				--[[ Upvalues[2]:
					[1]: var57_upvw (read and write)
					[2]: var53_upvw (copied, read and write)
				]]
				var57_upvw += 1
				if var57_upvw <= #var53_upvw then
					return var57_upvw, var53_upvw[var57_upvw]
				end
			end
		end;
	}
end