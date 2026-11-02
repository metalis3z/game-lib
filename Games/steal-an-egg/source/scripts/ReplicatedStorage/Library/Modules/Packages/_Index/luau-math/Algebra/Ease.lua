-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local sin = math.sin
local cos = math.cos
local abs = math.abs
local asin = math.asin

local function outBounce(p1, p2, p3, p4) --[[ outBounce | Line: 43 ]]
	local v1 = p1 / p4

	if v1 < 0.36363636363636365 then
		return p3 * (7.5625 * v1 * v1) + p2
	end

	if v1 < 0.7272727272727273 then
		local v2 = v1 - 0.5454545454545454

		return p3 * (7.5625 * v2 * v2 + 0.75) + p2
	end

	if v1 < 0.9090909090909091 then
		local v3 = v1 - 0.8181818181818182

		return p3 * (7.5625 * v3 * v3 + 0.9375) + p2
	end

	local v4 = v1 - 0.9545454545454546

	return p3 * (7.5625 * v4 * v4 + 0.984375) + p2
end

local function inBounce(p1, p2, p3, p4) --[[ inBounce | Line: 59 | Upvalues: outBounce (copy) ]]
	return p3 - outBounce(p4 - p1, 0, p3, p4) + p2
end

local t = {
	[Enum.EasingStyle.Sine] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 66 | Upvalues: cos (copy) ]]
			return -p3 * cos(p1 / p4 * 1.5707963267948966) + p3 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 69 | Upvalues: cos (copy) ]]
			return -p3 * 0.5 * (cos(math.pi * p1 / p4) - 1) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 72 | Upvalues: sin (copy) ]]
			return p3 * sin(p1 / p4 * 1.5707963267948966) + p2
		end
	},
	[Enum.EasingStyle.Quint] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 77 ]]
			local v1 = p1 / p4

			return p3 * v1 * v1 * v1 * v1 * v1 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 81 ]]
			local v1 = p1 / p4 * 2

			if v1 < 1 then
				return p3 * 0.5 * v1 * v1 * v1 * v1 * v1 + p2
			end

			local v2 = v1 - 2

			return p3 * 0.5 * (v2 * v2 * v2 * v2 * v2 + 2) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 90 ]]
			local v1 = p1 / p4 - 1

			return p3 * (v1 * v1 * v1 * v1 * v1 + 1) + p2
		end
	},
	[Enum.EasingStyle.Quart] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 96 ]]
			local v1 = p1 / p4

			return p3 * v1 * v1 * v1 * v1 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 100 ]]
			local v1 = p1 / p4 * 2

			if v1 < 1 then
				return p3 * 0.5 * v1 * v1 * v1 * v1 + p2
			end

			local v2 = v1 - 2

			return -p3 * 0.5 * (v2 * v2 * v2 * v2 - 2) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 109 ]]
			local v1 = p1 / p4 - 1

			return -p3 * (v1 * v1 * v1 * v1 - 1) + p2
		end
	},
	[Enum.EasingStyle.Quad] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 115 ]]
			local v1 = p1 / p4

			return p3 * v1 * v1 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 119 ]]
			local v1 = p1 / p4 * 2

			return v1 < 1 and p3 * 0.5 * v1 * v1 + p2 or -p3 * 0.5 * ((v1 - 1) * (v1 - 3) - 1) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 123 ]]
			local v1 = p1 / p4

			return -p3 * v1 * (v1 - 2) + p2
		end
	},
	[Enum.EasingStyle.Linear] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 129 ]]
			return p3 * p1 / p4 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 132 ]]
			return p3 * p1 / p4 + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 135 ]]
			return p3 * p1 / p4 + p2
		end
	},
	[Enum.EasingStyle.Exponential] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 140 ]]
			return if p1 == 0 and p2 then p2 else p3 * 2 ^ (10 * (p1 / p4 - 1)) + p2 - p3 * 0.001
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 143 ]]
			local v1 = p1 / p4 * 2

			if v1 == 0 then
				return p2
			end

			if v1 == p4 then
				return p2 + p3
			end

			local v2 = v1 / p4 * 2

			if v2 < 1 then
				return p3 / 2 * math.pow(2, 10 * (v2 - 1)) + p2 - p3 * 0.0005
			end

			return p3 / 2 * 1.0005 * (-math.pow(2, -10 * (v2 - 1)) + 2) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 159 ]]
			return p1 == p4 and p2 + p3 or p3 * 1.001 * (1 - 2 ^ (-10 * p1 / p4)) + p2
		end
	},
	[Enum.EasingStyle.Elastic] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 164 | Upvalues: abs (copy), asin (copy), sin (copy) ]]
			if p1 == 0 then
				return p2
			end

			local v1 = p1 / p4

			if v1 == 1 then
				return p2 + p3
			end

			local v2 = 1 or p4 * 0.3
			local v3 = 1
			local v4

			if v3 and not (v3 < abs(p3)) then
				v4 = v2 / 6.283185307179586 * asin(p3 / v3)
			else
				v3 = p3
				v4 = v2 / 4
			end

			local v5 = v1 - 1

			return -(v3 * math.pow(2, 10 * v5) * sin((v5 * p4 - v4) * 6.283185307179586 / v2)) + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 194 | Upvalues: abs (copy), asin (copy), sin (copy) ]]
			if p1 == 0 then
				return p2
			end

			local v1 = p1 / p4 * 2 - 1

			if v1 == 1 then
				return p2 + p3
			end

			local v2 = 1
			local v3 = p4 * 0.3
			local v4

			if v2 and not (v2 < abs(p3)) then
				v4 = v3 / 6.283185307179586 * asin(p3 / v2)
			else
				v2 = p3
				v4 = v3 * 0.25
			end

			if v1 < 1 then
				return v2 * -0.5 * 2 ^ (10 * v1) * sin((v1 * p4 - v4) * 6.283185307179586 / v3) + p2
			end

			return v2 * 2 ^ (-10 * v1) * sin((v1 * p4 - v4) * 6.283185307179586 / v3) * 0.5 + p3 + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 223 | Upvalues: abs (copy), asin (copy), sin (copy) ]]
			if p1 == 0 then
				return p2
			end

			local v1 = p1 / p4

			if v1 == 1 then
				return p2 + p3
			end

			local v2 = 1
			local v3 = 1

			if not v2 then
				v2 = p4 * 0.3
			end

			local v4

			if v3 and not (v3 < abs(p3)) then
				v4 = v2 / 6.283185307179586 * asin(p3 / v3)
			else
				v3 = p3
				v4 = v2 / 4
			end

			return v3 * math.pow(2, -10 * v1) * sin((v1 * p4 - v4) * 6.283185307179586 / v2) + p3 + p2
		end
	},
	[Enum.EasingStyle.Cubic] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 254 ]]
			local v1 = p1 / p4

			return p3 * v1 * v1 * v1 + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 258 ]]
			local v1 = p1 / p4 * 2

			if v1 < 1 then
				return p3 * 0.5 * v1 * v1 * v1 + p2
			end

			local v2 = v1 - 2

			return p3 * 0.5 * (v2 * v2 * v2 + 2) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 267 ]]
			local v1 = p1 / p4 - 1

			return p3 * (v1 * v1 * v1 + 1) + p2
		end
	},
	[Enum.EasingStyle.Circular] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 273 ]]
			local v1 = p1 / p4

			return -p3 * ((1 - v1 * v1) ^ 0.5 - 1) + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 277 ]]
			local v1 = p1 / p4 * 2

			if v1 < 1 then
				return -p3 * 0.5 * ((1 - v1 * v1) ^ 0.5 - 1) + p2
			end

			local v2 = v1 - 2

			return p3 * 0.5 * ((1 - v2 * v2) ^ 0.5 + 1) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 286 ]]
			local v1 = p1 / p4 - 1

			return p3 * (1 - v1 * v1) ^ 0.5 + p2
		end
	},
	[Enum.EasingStyle.Bounce] = {
		[Enum.EasingDirection.In] = inBounce,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 293 | Upvalues: outBounce (copy) ]]
			if p1 < p4 * 0.5 then
				return (p3 - outBounce(p4 - p1 * 2, 0, p3, p4) + 0) * 0.5 + p2
			end

			return outBounce(p1 * 2 - p4, 0, p3, p4) * 0.5 + p3 * 0.5 + p2
		end,
		[Enum.EasingDirection.Out] = outBounce
	},
	[Enum.EasingStyle.Back] = {
		[Enum.EasingDirection.In] = function(p1, p2, p3, p4) --[[ Line: 303 ]]
			local v1 = p1 / p4

			return p3 * v1 * v1 * (2.70158 * v1 - 1.70158) + p2
		end,
		[Enum.EasingDirection.InOut] = function(p1, p2, p3, p4) --[[ Line: 308 ]]
			local v1 = p1 / p4 * 2

			if v1 < 1 then
				return p3 * 0.5 * (v1 * v1 * (3.5949095 * v1 - 2.5949095)) + p2
			end

			local v2 = v1 - 2

			return p3 * 0.5 * (v2 * v2 * (3.5949095 * v2 + 2.5949095) + 2) + p2
		end,
		[Enum.EasingDirection.Out] = function(p1, p2, p3, p4) --[[ Line: 318 ]]
			local v1 = p1 / p4 - 1

			return p3 * (v1 * v1 * (2.70158 * v1 + 1.70158) + 1) + p2
		end
	}
}

return function(p1, p2, p3) --[[ Line: 326 | Upvalues: t (copy) ]]
	local v1 = if p2 then p2 else Enum.EasingStyle.Quad

	return t[v1][if p3 then p3 else Enum.EasingDirection.InOut](p1, 0, 1, 1)
end