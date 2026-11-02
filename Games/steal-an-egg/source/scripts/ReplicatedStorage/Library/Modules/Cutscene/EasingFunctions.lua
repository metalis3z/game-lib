-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pow = math.pow
local sin = math.sin
local cos = math.cos
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

local function Linear(p1, p2, p3, p4) --[[ Linear | Line: 81 ]]
	return p1 / p4
end

local function InQuad(p1, p2, p3, p4) --[[ InQuad | Line: 85 | Upvalues: pow (copy) ]]
	return p3 * pow(p1 / p4, 2) + p2
end

local function OutQuad(p1, p2, p3, p4) --[[ OutQuad | Line: 89 ]]
	local v1 = p1 / p4

	return -p3 * v1 * (v1 - 2) + p2
end

local function InOutQuad(p1, p2, p3, p4) --[[ InOutQuad | Line: 94 | Upvalues: pow (copy) ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * pow(v1, 2) + p2
	end

	return -p3 / 2 * ((v1 - 1) * (v1 - 3) - 1) + p2
end

local function OutInQuad(p1, p2, p3, p4) --[[ OutInQuad | Line: 103 | Upvalues: pow (copy) ]]
	if p1 < p4 / 2 then
		local v1 = p1 * 2 / p4

		return -(p3 / 2) * v1 * (v1 - 2) + p2
	end

	return p3 / 2 * pow((p1 * 2 - p4) / p4, 2) + (p2 + p3 / 2)
end

local function InCubic(p1, p2, p3, p4) --[[ InCubic | Line: 111 | Upvalues: pow (copy) ]]
	return p3 * pow(p1 / p4, 3) + p2
end

local function OutCubic(p1, p2, p3, p4) --[[ OutCubic | Line: 115 | Upvalues: pow (copy) ]]
	return p3 * (pow(p1 / p4 - 1, 3) + 1) + p2
end

local function InOutCubic(p1, p2, p3, p4) --[[ InOutCubic | Line: 119 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * v1 * v1 * v1 + p2
	end

	local v2 = v1 - 2

	return p3 / 2 * (v2 * v2 * v2 + 2) + p2
end

local function OutInCubic(p1, p2, p3, p4) --[[ OutInCubic | Line: 129 | Upvalues: pow (copy) ]]
	if p1 < p4 / 2 then
		return p3 / 2 * (pow(p1 * 2 / p4 - 1, 3) + 1) + p2
	end

	return p3 / 2 * pow((p1 * 2 - p4) / p4, 3) + (p2 + p3 / 2)
end

local function InQuart(p1, p2, p3, p4) --[[ InQuart | Line: 137 | Upvalues: pow (copy) ]]
	return p3 * pow(p1 / p4, 4) + p2
end

local function OutQuart(p1, p2, p3, p4) --[[ OutQuart | Line: 141 | Upvalues: pow (copy) ]]
	return -p3 * (pow(p1 / p4 - 1, 4) - 1) + p2
end

local function InOutQuart(p1, p2, p3, p4) --[[ InOutQuart | Line: 145 | Upvalues: pow (copy) ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * pow(v1, 4) + p2
	end

	return -p3 / 2 * (pow(v1 - 2, 4) - 2) + p2
end

local function OutInQuart(p1, p2, p3, p4) --[[ OutInQuart | Line: 155 | Upvalues: pow (copy) ]]
	if p1 < p4 / 2 then
		return -(p3 / 2) * (pow(p1 * 2 / p4 - 1, 4) - 1) + p2
	end

	return p3 / 2 * pow((p1 * 2 - p4) / p4, 4) + (p2 + p3 / 2)
end

local function InQuint(p1, p2, p3, p4) --[[ InQuint | Line: 163 | Upvalues: pow (copy) ]]
	return p3 * pow(p1 / p4, 5) + p2
end

local function OutQuint(p1, p2, p3, p4) --[[ OutQuint | Line: 167 | Upvalues: pow (copy) ]]
	return p3 * (pow(p1 / p4 - 1, 5) + 1) + p2
end

local function InOutQuint(p1, p2, p3, p4) --[[ InOutQuint | Line: 171 | Upvalues: pow (copy) ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * pow(v1, 5) + p2
	end

	return p3 / 2 * (pow(v1 - 2, 5) + 2) + p2
end

local function OutInQuint(p1, p2, p3, p4) --[[ OutInQuint | Line: 180 | Upvalues: pow (copy) ]]
	if p1 < p4 / 2 then
		return p3 / 2 * (pow(p1 * 2 / p4 - 1, 5) + 1) + p2
	end

	return p3 / 2 * pow((p1 * 2 - p4) / p4, 5) + (p2 + p3 / 2)
end

local function InSine(p1, p2, p3, p4) --[[ InSine | Line: 188 | Upvalues: cos (copy) ]]
	return -p3 * cos(p1 / p4 * 1.5707963267948966) + p3 + p2
end

local function OutSine(p1, p2, p3, p4) --[[ OutSine | Line: 192 | Upvalues: sin (copy) ]]
	return p3 * sin(p1 / p4 * 1.5707963267948966) + p2
end

local function InOutSine(p1, p2, p3, p4) --[[ InOutSine | Line: 196 | Upvalues: cos (copy) ]]
	return -p3 / 2 * (cos(math.pi * p1 / p4) - 1) + p2
end

local function OutInSine(p1, p2, p3, p4) --[[ OutInSine | Line: 200 | Upvalues: sin (copy), cos (copy) ]]
	if p1 < p4 / 2 then
		return p3 / 2 * sin(p1 * 2 / p4 * 1.5707963267948966) + p2
	end

	local v1 = p3 / 2

	return -v1 * cos((p1 * 2 - p4) / p4 * 1.5707963267948966) + v1 + (p2 + p3 / 2)
end

local function InExpo(p1, p2, p3, p4) --[[ InExpo | Line: 208 | Upvalues: pow (copy) ]]
	if p1 == 0 then
		return p2
	end

	return p3 * pow(2, (p1 / p4 - 1) * 10) + p2 - p3 * 0.001
end

local function OutExpo(p1, p2, p3, p4) --[[ OutExpo | Line: 216 | Upvalues: pow (copy) ]]
	if p1 == p4 then
		return p2 + p3
	end

	return p3 * 1.001 * (-pow(2, p1 * -10 / p4) + 1) + p2
end

local function InOutExpo(p1, p2, p3, p4) --[[ InOutExpo | Line: 224 | Upvalues: pow (copy) ]]
	if p1 == 0 then
		return p2
	end

	if p1 == p4 then
		return p2 + p3
	end

	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * pow(2, (v1 - 1) * 10) + p2 - p3 * 0.0005
	end

	return p3 / 2 * 1.0005 * (-pow(2, (v1 - 1) * -10) + 2) + p2
end

local function OutInExpo(p1, p2, p3, p4) --[[ OutInExpo | Line: 240 | Upvalues: pow (copy) ]]
	if p1 < p4 / 2 then
		local v1 = p1 * 2
		local v2 = p3 / 2

		if v1 == p4 then
			return p2 + v2
		end

		return v2 * 1.001 * (-pow(2, v1 * -10 / p4) + 1) + p2
	end

	local v3 = p1 * 2 - p4
	local v4 = p2 + p3 / 2
	local v5 = p3 / 2

	if v3 == 0 then
		return v4
	end

	return v5 * pow(2, (v3 / p4 - 1) * 10) + v4 - v5 * 0.001
end

local function InCirc(p1, p2, p3, p4) --[[ InCirc | Line: 248 | Upvalues: pow (copy), sqrt (copy) ]]
	return -p3 * (sqrt(1 - pow(p1 / p4, 2)) - 1) + p2
end

local function OutCirc(p1, p2, p3, p4) --[[ OutCirc | Line: 252 | Upvalues: pow (copy), sqrt (copy) ]]
	return p3 * sqrt(1 - pow(p1 / p4 - 1, 2)) + p2
end

local function InOutCirc(p1, p2, p3, p4) --[[ InOutCirc | Line: 256 | Upvalues: sqrt (copy) ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return -p3 / 2 * (sqrt(1 - v1 * v1) - 1) + p2
	end

	local v2 = v1 - 2

	return p3 / 2 * (sqrt(1 - v2 * v2) + 1) + p2
end

local function OutInCirc(p1, p2, p3, p4) --[[ OutInCirc | Line: 266 | Upvalues: pow (copy), sqrt (copy) ]]
	if p1 < p4 / 2 then
		return p3 / 2 * sqrt(1 - pow(p1 * 2 / p4 - 1, 2)) + p2
	end

	return -(p3 / 2) * (sqrt(1 - pow((p1 * 2 - p4) / p4, 2)) - 1) + (p2 + p3 / 2)
end

local function InElastic(p1, p2, p3, p4, p5, p6) --[[ InElastic | Line: 274 | Upvalues: abs (copy), asin (copy), pow (copy), sin (copy) ]]
	if p1 == 0 then
		return p2
	end

	local v1 = p1 / p4

	if v1 == 1 then
		return p2 + p3
	end

	if not p6 then
		p6 = p4 * 0.3
	end

	local v2

	if p5 and not (p5 < abs(p3)) then
		v2 = p6 / 6.283185307179586 * asin(p3 / p5)
	else
		p5 = p3
		v2 = p6 / 4
	end

	local v3 = v1 - 1

	return -(p5 * pow(2, v3 * 10) * sin((v3 * p4 - v2) * 6.283185307179586 / p6)) + p2
end

local function OutElastic(p1, p2, p3, p4, p5, p6) --[[ OutElastic | Line: 296 | Upvalues: abs (copy), asin (copy), pow (copy), sin (copy) ]]
	if p1 == 0 then
		return p2
	end

	local v1 = p1 / p4

	if v1 == 1 then
		return p2 + p3
	end

	if not p6 then
		p6 = p4 * 0.3
	end

	local v2

	if p5 and not (p5 < abs(p3)) then
		v2 = p6 / 6.283185307179586 * asin(p3 / p5)
	else
		p5 = p3
		v2 = p6 / 4
	end

	return p5 * pow(2, v1 * -10) * sin((v1 * p4 - v2) * 6.283185307179586 / p6) + p3 + p2
end

local function InOutElastic(p1, p2, p3, p4, p5, p6) --[[ InOutElastic | Line: 317 | Upvalues: abs (copy), asin (copy), pow (copy), sin (copy) ]]
	if p1 == 0 then
		return p2
	end

	local v1 = p1 / p4 * 2

	if v1 == 2 then
		return p2 + p3
	end

	if not p6 then
		p6 = p4 * 0.44999999999999996
	end

	if not p5 then
		p5 = 0
	end

	local v2

	if p5 and not (p5 < abs(p3)) then
		v2 = p6 / 6.283185307179586 * asin(p3 / p5)
	else
		p5 = p3
		v2 = p6 / 4
	end

	if v1 < 1 then
		local v3 = v1 - 1

		return p5 * pow(2, v3 * 10) * sin((v3 * p4 - v2) * 6.283185307179586 / p6) * -0.5 + p2
	end

	local v4 = v1 - 1

	return p5 * pow(2, v4 * -10) * sin((v4 * p4 - v2) * 6.283185307179586 / p6) * 0.5 + p3 + p2
end

local function OutInElastic(p1, p2, p3, p4, p5, p6) --[[ OutInElastic | Line: 347 | Upvalues: OutElastic (copy), InElastic (copy) ]]
	if p1 < p4 / 2 then
		return OutElastic(p1 * 2, p2, p3 / 2, p4, p5, p6)
	end

	return InElastic(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4, p5, p6)
end

local function InBack(p1, p2, p3, p4) --[[ InBack | Line: 355 ]]
	local v1 = p1 / p4

	return p3 * v1 * v1 * (v1 * 2.70158 - 1.70158) + p2
end

local function OutBack(p1, p2, p3, p4) --[[ OutBack | Line: 360 ]]
	local v1 = p1 / p4 - 1

	return p3 * (v1 * v1 * (v1 * 2.70158 + 1.70158) + 1) + p2
end

local function InOutBack(p1, p2, p3, p4) --[[ InOutBack | Line: 365 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * (v1 * v1 * (v1 * 2.70158 - 1.70158)) + p2
	end

	local v2 = v1 - 2

	return p3 / 2 * (v2 * v2 * (v2 * 2.70158 + 1.70158) + 2) + p2
end

local function OutInBack(p1, p2, p3, p4) --[[ OutInBack | Line: 375 ]]
	if p1 < p4 / 2 then
		local v1 = p1 * 2 / p4 - 1

		return p3 / 2 * (v1 * v1 * (v1 * 2.70158 + 1.70158) + 1) + p2
	end

	local v2 = (p1 * 2 - p4) / p4

	return p3 / 2 * v2 * v2 * (v2 * 2.70158 - 1.70158) + (p2 + p3 / 2)
end

local function OutBounce(p1, p2, p3, p4) --[[ OutBounce | Line: 383 ]]
	local v1 = p1 / p4

	if v1 < 0.36363636363636 then
		return p3 * (v1 * 7.5625 * v1) + p2
	end

	if v1 < 0.72727272727273 then
		local v2 = v1 - 0.54545454545455

		return p3 * (v2 * 7.5625 * v2 + 0.75) + p2
	end

	if v1 < 0.90909090909091 then
		local v3 = v1 - 0.81818181818182

		return p3 * (v3 * 7.5625 * v3 + 0.9375) + p2
	end

	local v4 = v1 - 0.95454545454545

	return p3 * (v4 * 7.5625 * v4 + 0.984375) + p2
end

return {
	Linear = Linear,
	InQuad = InQuad,
	OutQuad = OutQuad,
	InOutQuad = InOutQuad,
	OutInQuad = OutInQuad,
	InCubic = InCubic,
	OutCubic = OutCubic,
	InOutCubic = InOutCubic,
	OutInCubic = OutInCubic,
	InQuart = InQuart,
	OutQuart = OutQuart,
	InOutQuart = InOutQuart,
	OutInQuart = OutInQuart,
	InQuint = InQuint,
	OutQuint = OutQuint,
	InOutQuint = InOutQuint,
	OutInQuint = OutInQuint,
	InSine = InSine,
	OutSine = OutSine,
	InOutSine = InOutSine,
	OutInSine = OutInSine,
	InExponential = InExpo,
	OutExponential = OutExpo,
	InOutExponential = InOutExpo,
	OutInExponential = OutInExpo,
	InCircular = InCirc,
	OutCircular = OutCirc,
	InOutCircular = InOutCirc,
	OutInCircular = OutInCirc,
	InElastic = InElastic,
	OutElastic = OutElastic,
	InOutElastic = InOutElastic,
	OutInElastic = OutInElastic,
	InBack = InBack,
	OutBack = OutBack,
	InOutBack = InOutBack,
	OutInBack = OutInBack,
	InBounce = function(p1, p2, p3, p4) --[[ InBounce | Line: 399 | Upvalues: OutBounce (copy) ]]
		return p3 - OutBounce(p4 - p1, 0, p3, p4) + p2
	end,
	OutBounce = OutBounce,
	InOutBounce = function(p1, p2, p3, p4) --[[ InOutBounce | Line: 403 | Upvalues: OutBounce (copy) ]]
		if p1 < p4 / 2 then
			return (p3 - OutBounce(p4 - p1 * 2, 0, p3, p4) + 0) * 0.5 + p2
		end

		return OutBounce(p1 * 2 - p4, 0, p3, p4) * 0.5 + p3 * 0.5 + p2
	end,
	OutInBounce = function(p1, p2, p3, p4) --[[ OutInBounce | Line: 411 | Upvalues: OutBounce (copy) ]]
		if p1 < p4 / 2 then
			return OutBounce(p1 * 2, p2, p3 / 2, p4)
		end

		local v1 = p3 / 2

		return v1 - OutBounce(p4 - (p1 * 2 - p4), 0, v1, p4) + (p2 + p3 / 2)
	end
}