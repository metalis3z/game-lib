-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:04
-- Luau version 6, Types version 3
-- Time taken: 0.018762 seconds

local pow_upvr = math.pow
local sin_upvr = math.sin
local cos_upvr = math.cos
local sqrt_upvr = math.sqrt
local abs_upvr = math.abs
local asin_upvr = math.asin
local function inElastic_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 200, Named "inElastic"
	--[[ Upvalues[4]:
		[1]: abs_upvr (readonly)
		[2]: asin_upvr (readonly)
		[3]: pow_upvr (readonly)
		[4]: sin_upvr (readonly)
	]]
	if arg1 == 0 then
		return arg2
	end
	local var22 = arg1 / arg4
	if var22 == 1 then
		return arg2 + arg3
	end
	if not arg6 then
		local var23 = arg4 * 0.3
	end
	local var24
	if not arg5 or arg5 < abs_upvr(arg3) then
		local var25 = arg3
		var24 = var23 / 4
	else
		var24 = var23 / (-math.pi*2) * asin_upvr(arg3 / var25)
	end
	local var26 = var22 - 1
	return -(var25 * pow_upvr(2, 10 * var26) * sin_upvr((var26 * arg4 - var24) * (-math.pi*2) / var23)) + arg2
end
local function outElastic_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 225, Named "outElastic"
	--[[ Upvalues[4]:
		[1]: abs_upvr (readonly)
		[2]: asin_upvr (readonly)
		[3]: pow_upvr (readonly)
		[4]: sin_upvr (readonly)
	]]
	if arg1 == 0 then
		return arg2
	end
	local var27 = arg1 / arg4
	if var27 == 1 then
		return arg2 + arg3
	end
	if not arg6 then
		local var28 = arg4 * 0.3
	end
	local var29
	if not arg5 or arg5 < abs_upvr(arg3) then
		local var30 = arg3
		var29 = var28 / 4
	else
		var29 = var28 / (-math.pi*2) * asin_upvr(arg3 / var30)
	end
	return var30 * pow_upvr(2, -10 * var27) * sin_upvr((var27 * arg4 - var29) * (-math.pi*2) / var28) + arg3 + arg2
end
local function outBounce_upvr(arg1, arg2, arg3, arg4) -- Line 316, Named "outBounce"
	local var47 = arg1 / arg4
	if var47 < 0.36363636363636365 then
		return (arg3) * (7.5625 * var47 * var47) + arg2
	end
	if var47 < 0.7272727272727273 then
		local var48 = var47 - 0.5454545454545454
		return arg3 * (7.5625 * var48 * var48 + 0.75) + arg2
	end
	if var48 < 0.9090909090909091 then
		local var49 = var48 - 0.8181818181818182
		return arg3 * (7.5625 * var49 * var49 + 0.9375) + arg2
	end
	local var50 = var49 - 0.9545454545454546
	return arg3 * (7.5625 * var50 * var50 + 0.984375) + arg2
end
return {
	linear = function(arg1, arg2, arg3, arg4) -- Line 9, Named "linear"
		return arg3 * arg1 / arg4 + arg2
	end;
	inQuad = function(arg1, arg2, arg3, arg4) -- Line 13, Named "inQuad"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * pow_upvr(arg1 / arg4, 2) + arg2
	end;
	outQuad = function(arg1, arg2, arg3, arg4) -- Line 18, Named "outQuad"
		local var7 = arg1 / arg4
		return -arg3 * var7 * (var7 - 2) + arg2
	end;
	inOutQuad = function(arg1, arg2, arg3, arg4) -- Line 23, Named "inOutQuad"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		local var8 = arg1 / arg4 * 2
		if var8 < 1 then
			return arg3 / 2 * pow_upvr(var8, 2) + arg2
		end
		return -arg3 / 2 * ((var8 - 1) * (var8 - 3) - 1) + arg2
	end;
	inCubic = function(arg1, arg2, arg3, arg4) -- Line 32, Named "inCubic"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * pow_upvr(arg1 / arg4, 3) + arg2
	end;
	outCubic = function(arg1, arg2, arg3, arg4) -- Line 37, Named "outCubic"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * (pow_upvr(arg1 / arg4 - 1, 3) + 1) + arg2
	end;
	inOutCubic = function(arg1, arg2, arg3, arg4) -- Line 42, Named "inOutCubic"
		local var9 = arg1 / arg4 * 2
		if var9 < 1 then
			return arg3 / 2 * var9 * var9 * var9 + arg2
		end
		local var10 = var9 - 2
		return arg3 / 2 * (var10 * var10 * var10 + 2) + arg2
	end;
	outInCubic = function(arg1, arg2, arg3, arg4) -- Line 52, Named "outInCubic"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return arg3 / 2 * (pow_upvr(arg1 * 2 / arg4 - 1, 3) + 1) + arg2
		end
		return (arg3 / 2 * pow_upvr((arg1 * 2 - arg4) / arg4, 3)) + (arg2 + arg3 / 2)
	end;
	inQuart = function(arg1, arg2, arg3, arg4) -- Line 60, Named "inQuart"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * pow_upvr(arg1 / arg4, 4) + arg2
	end;
	outQuart = function(arg1, arg2, arg3, arg4) -- Line 65, Named "outQuart"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return -arg3 * (pow_upvr(arg1 / arg4 - 1, 4) - 1) + arg2
	end;
	inOutQuart = function(arg1, arg2, arg3, arg4) -- Line 70, Named "inOutQuart"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		local var11 = arg1 / arg4 * 2
		if var11 < 1 then
			return arg3 / 2 * pow_upvr(var11, 4) + arg2
		end
		return -arg3 / 2 * (pow_upvr(var11 - 2, 4) - 2) + arg2
	end;
	outInQuart = function(arg1, arg2, arg3, arg4) -- Line 80, Named "outInQuart"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return -(arg3 / 2) * (pow_upvr(arg1 * 2 / arg4 - 1, 4) - 1) + arg2
		end
		return (arg3 / 2 * pow_upvr((arg1 * 2 - arg4) / arg4, 4)) + (arg2 + arg3 / 2)
	end;
	inQuint = function(arg1, arg2, arg3, arg4) -- Line 88, Named "inQuint"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * pow_upvr(arg1 / arg4, 5) + arg2
	end;
	outQuint = function(arg1, arg2, arg3, arg4) -- Line 93, Named "outQuint"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		return arg3 * (pow_upvr(arg1 / arg4 - 1, 5) + 1) + arg2
	end;
	inOutQuint = function(arg1, arg2, arg3, arg4) -- Line 98, Named "inOutQuint"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		local var12 = arg1 / arg4 * 2
		if var12 < 1 then
			return arg3 / 2 * pow_upvr(var12, 5) + arg2
		end
		return arg3 / 2 * (pow_upvr(var12 - 2, 5) + 2) + arg2
	end;
	outInQuint = function(arg1, arg2, arg3, arg4) -- Line 108, Named "outInQuint"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return arg3 / 2 * (pow_upvr(arg1 * 2 / arg4 - 1, 5) + 1) + arg2
		end
		return (arg3 / 2 * pow_upvr((arg1 * 2 - arg4) / arg4, 5)) + (arg2 + arg3 / 2)
	end;
	inSine = function(arg1, arg2, arg3, arg4) -- Line 116, Named "inSine"
		--[[ Upvalues[1]:
			[1]: cos_upvr (readonly)
		]]
		return -arg3 * cos_upvr(arg1 / arg4 * (math.pi/2)) + arg3 + arg2
	end;
	outSine = function(arg1, arg2, arg3, arg4) -- Line 120, Named "outSine"
		--[[ Upvalues[1]:
			[1]: sin_upvr (readonly)
		]]
		return arg3 * sin_upvr(arg1 / arg4 * (math.pi/2)) + arg2
	end;
	inOutSine = function(arg1, arg2, arg3, arg4) -- Line 124, Named "inOutSine"
		--[[ Upvalues[1]:
			[1]: cos_upvr (readonly)
		]]
		return -arg3 / 2 * (cos_upvr(math.pi * arg1 / arg4) - 1) + arg2
	end;
	outInSine = function(arg1, arg2, arg3, arg4) -- Line 128, Named "outInSine"
		--[[ Upvalues[2]:
			[1]: sin_upvr (readonly)
			[2]: cos_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return arg3 / 2 * sin_upvr(arg1 * 2 / arg4 * (math.pi/2)) + arg2
		end
		local var13 = arg3 / 2
		return (-var13 * cos_upvr((arg1 * 2 - arg4) / arg4 * (math.pi/2)) + var13) + (arg2 + arg3 / 2)
	end;
	inExpo = function(arg1, arg2, arg3, arg4) -- Line 136, Named "inExpo"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 == 0 then
			return arg2
		end
		return arg3 * pow_upvr(2, 10 * (arg1 / arg4 - 1)) + arg2 - arg3 * 0.001
	end;
	outExpo = function(arg1, arg2, arg3, arg4) -- Line 144, Named "outExpo"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 == arg4 then
			return arg2 + arg3
		end
		return arg3 * 1.001 * (-pow_upvr(2, -10 * arg1 / arg4) + 1) + arg2
	end;
	inOutExpo = function(arg1, arg2, arg3, arg4) -- Line 152, Named "inOutExpo"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 == 0 then
			return arg2
		end
		if arg1 == arg4 then
			return arg2 + arg3
		end
		local var14 = arg1 / arg4 * 2
		if var14 < 1 then
			return arg3 / 2 * pow_upvr(2, 10 * (var14 - 1)) + arg2 - arg3 * 0.0005
		end
		return arg3 / 2 * 1.0005 * (-pow_upvr(2, -10 * (var14 - 1)) + 2) + arg2
	end;
	outInExpo = function(arg1, arg2, arg3, arg4) -- Line 164, Named "outInExpo"
		--[[ Upvalues[1]:
			[1]: pow_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			local var15 = arg1 * 2
			local var16 = arg3 / 2
			if var15 == arg4 then
				return arg2 + var16
			end
			return var16 * 1.001 * (-pow_upvr(2, -10 * var15 / arg4) + 1) + arg2
		end
		local var17 = arg1 * 2 - arg4
		local var18 = arg2 + arg3 / 2
		local var19 = arg3 / 2
		if var17 == 0 then
			return var18
		end
		return var19 * pow_upvr(2, 10 * (var17 / arg4 - 1)) + var18 - var19 * 0.001
	end;
	inCirc = function(arg1, arg2, arg3, arg4) -- Line 172, Named "inCirc"
		--[[ Upvalues[2]:
			[1]: pow_upvr (readonly)
			[2]: sqrt_upvr (readonly)
		]]
		return -arg3 * (sqrt_upvr(1 - pow_upvr(arg1 / arg4, 2)) - 1) + arg2
	end;
	outCirc = function(arg1, arg2, arg3, arg4) -- Line 177, Named "outCirc"
		--[[ Upvalues[2]:
			[1]: pow_upvr (readonly)
			[2]: sqrt_upvr (readonly)
		]]
		return arg3 * sqrt_upvr(1 - pow_upvr(arg1 / arg4 - 1, 2)) + arg2
	end;
	inOutCirc = function(arg1, arg2, arg3, arg4) -- Line 182, Named "inOutCirc"
		--[[ Upvalues[1]:
			[1]: sqrt_upvr (readonly)
		]]
		local var20 = arg1 / arg4 * 2
		if var20 < 1 then
			return -arg3 / 2 * (sqrt_upvr(1 - var20 * var20) - 1) + arg2
		end
		local var21 = var20 - 2
		return arg3 / 2 * (sqrt_upvr(1 - var21 * var21) + 1) + arg2
	end;
	outInCirc = function(arg1, arg2, arg3, arg4) -- Line 192, Named "outInCirc"
		--[[ Upvalues[2]:
			[1]: pow_upvr (readonly)
			[2]: sqrt_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return arg3 / 2 * sqrt_upvr(1 - pow_upvr(arg1 * 2 / arg4 - 1, 2)) + arg2
		end
		return (-(arg3 / 2) * (sqrt_upvr(1 - pow_upvr((arg1 * 2 - arg4) / arg4, 2)) - 1)) + (arg2 + arg3 / 2)
	end;
	inElastic = inElastic_upvr;
	outElastic = outElastic_upvr;
	inOutElastic = function(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 248, Named "inOutElastic"
		--[[ Upvalues[4]:
			[1]: abs_upvr (readonly)
			[2]: asin_upvr (readonly)
			[3]: pow_upvr (readonly)
			[4]: sin_upvr (readonly)
		]]
		if arg1 == 0 then
			return arg2
		end
		local var31 = arg1 / arg4 * 2
		if var31 == 2 then
			return arg2 + arg3
		end
		if not arg6 then
			local var32 = arg4 * 0.44999999999999996
		end
		if not arg5 then
			local const_number = 0
		end
		if not const_number or const_number < abs_upvr(arg3) then
			s = var32 / 4 -- Setting global
		else
			s = var32 / (-math.pi*2) * asin_upvr(arg3 / arg3) -- Setting global
		end
		if var31 < 1 then
			local var34 = var31 - 1
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return (-0.5) * (arg3 * pow_upvr(2, 10 * var34) * sin_upvr((var34 * arg4 - s) * (-math.pi*2) / var32)) + arg2
		end
		local var35 = var34 - 1
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		return arg3 * pow_upvr(2, -10 * var35) * sin_upvr((var35 * arg4 - s) * (-math.pi*2) / var32) * 0.5 + arg3 + arg2
	end;
	outInElastic = function(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 276, Named "outInElastic"
		--[[ Upvalues[2]:
			[1]: outElastic_upvr (readonly)
			[2]: inElastic_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return outElastic_upvr(arg1 * 2, arg2, arg3 / 2, arg4, arg5, arg6)
		end
		return inElastic_upvr(arg1 * 2 - arg4, arg2 + arg3 / 2, arg3 / 2, arg4, arg5, arg6)
	end;
	inBack = function(arg1, arg2, arg3, arg4, arg5) -- Line 284, Named "inBack"
		if not arg5 then
			local const_number_3 = 1.70158
		end
		local var37 = arg1 / arg4
		return arg3 * var37 * var37 * ((const_number_3 + 1) * var37 - const_number_3) + arg2
	end;
	outBack = function(arg1, arg2, arg3, arg4, arg5) -- Line 290, Named "outBack"
		if not arg5 then
			local const_number_2 = 1.70158
		end
		local var39 = arg1 / arg4 - 1
		return arg3 * (var39 * var39 * ((const_number_2 + 1) * var39 + const_number_2) + 1) + arg2
	end;
	inOutBack = function(arg1, arg2, arg3, arg4, arg5) -- Line 296, Named "inOutBack"
		if not arg5 then
		end
		local var40 = 1.70158 * 1.525
		local var41 = arg1 / arg4 * 2
		if var41 < 1 then
			return (arg3 / 2) * (var41 * var41 * ((var40 + 1) * var41 - var40)) + arg2
		end
		local var42 = var41 - 2
		return arg3 / 2 * (var42 * var42 * ((var40 + 1) * var42 + var40) + 2) + arg2
	end;
	outInBack = function(arg1, arg2, arg3, arg4, arg5) -- Line 308, Named "outInBack"
		if arg1 < arg4 / 2 then
			local var43 = arg5
			if not var43 then
				var43 = 1.70158
			end
			local var44 = arg1 * 2 / arg4 - 1
			return arg3 / 2 * (var44 * var44 * ((var43 + 1) * var44 + var43) + 1) + arg2
		end
		local var45 = arg5
		if not var45 then
			var45 = 1.70158
		end
		local var46 = (arg1 * 2 - arg4) / arg4
		return (arg3 / 2 * var46 * var46 * ((var45 + 1) * var46 - var45)) + (arg2 + arg3 / 2)
	end;
	inBounce = function(arg1, arg2, arg3, arg4) -- Line 332, Named "inBounce"
		--[[ Upvalues[1]:
			[1]: outBounce_upvr (readonly)
		]]
		return arg3 - outBounce_upvr(arg4 - arg1, 0, arg3, arg4) + arg2
	end;
	outBounce = outBounce_upvr;
	inOutBounce = function(arg1, arg2, arg3, arg4) -- Line 336, Named "inOutBounce"
		--[[ Upvalues[1]:
			[1]: outBounce_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return (arg3 - outBounce_upvr(arg4 - arg1 * 2, 0, arg3, arg4) + 0) * 0.5 + arg2
		end
		return outBounce_upvr(arg1 * 2 - arg4, 0, arg3, arg4) * 0.5 + arg3 * 0.5 + arg2
	end;
	outInBounce = function(arg1, arg2, arg3, arg4) -- Line 344, Named "outInBounce"
		--[[ Upvalues[1]:
			[1]: outBounce_upvr (readonly)
		]]
		if arg1 < arg4 / 2 then
			return outBounce_upvr(arg1 * 2, arg2, arg3 / 2, arg4)
		end
		local var51 = arg3 / 2
		return (var51 - outBounce_upvr((arg4) - (arg1 * 2 - arg4), 0, var51, arg4)) + (arg2 + arg3 / 2)
	end;
}