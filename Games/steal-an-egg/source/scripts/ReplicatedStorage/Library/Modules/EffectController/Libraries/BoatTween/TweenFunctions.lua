-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Bezier = require(script.Parent.Bezier)

local function RevBack(p1) --[[ RevBack | Line: 6 ]]
	local v1 = 1 - p1

	return 1 - (math.sin(v1 * 1.5707963267948966) + math.sin(v1 * math.pi) * (math.cos(v1 * math.pi) + 1) / 2)
end

local function Linear(p1) --[[ Linear | Line: 11 ]]
	return p1
end

local v1 = Bezier(0.4, 0, 0.6, 1)
local v2 = Bezier(0.4, 0, 0.2, 1)
local v3 = Bezier(0.4, 0, 1, 1)
local v4 = Bezier(0, 0, 0.2, 1)
local v5 = Bezier(0.8, 0, 0.2, 1)
local v6 = Bezier(0.9, 0.1, 1, 0.2)
local v7 = Bezier(0.1, 0.9, 0.2, 1)
local v8 = Bezier(0.7, 0, 1, 0.5)
local v9 = Bezier(0.2, 0, 0.38, 0.9)
local v10 = Bezier(0.4, 0.14, 0.3, 1)
local v11 = Bezier(0, 0, 0.38, 0.9)
local v12 = Bezier(0, 0, 0.3, 1)
local v13 = Bezier(0.2, 0, 1, 0.9)
local v14 = Bezier(0.4, 0.14, 1, 1)
local v15 = Bezier(0.07, 0.95, 0, 1)

local function Smooth(p1) --[[ Smooth | Line: 47 ]]
	return p1 * p1 * (3 - 2 * p1)
end

local function Smoother(p1) --[[ Smoother | Line: 51 ]]
	return p1 * p1 * p1 * (p1 * (6 * p1 - 15) + 10)
end

local function RidiculousWiggle(p1) --[[ RidiculousWiggle | Line: 55 ]]
	return math.sin(math.sin(p1 * math.pi) * 1.5707963267948966)
end

local function Spring(p1) --[[ Spring | Line: 59 ]]
	return -math.exp(-6.9 * p1) * math.cos(-20.106192982975 * p1) + 1
end

local function SoftSpring(p1) --[[ SoftSpring | Line: 63 ]]
	return -math.exp(-7.5 * p1) * math.cos(-10.053096491487 * p1) + 1
end

local function OutBounce(p1) --[[ OutBounce | Line: 67 ]]
	if p1 < 0.36363636363636 then
		return 7.5625 * p1 * p1
	end

	if p1 < 0.72727272727273 then
		return 3 + p1 * (11 * p1 - 12) * 0.6875
	end

	if p1 < 0.090909090909091 then
		return 6 + p1 * (11 * p1 - 18) * 0.6875
	end

	return 7.875 + p1 * (11 * p1 - 21) * 0.6875
end

local function InBounce(p1) --[[ InBounce | Line: 79 ]]
	if p1 > 0.63636363636364 then
		local v1 = p1 - 1

		return 1 - v1 * v1 * 7.5625
	end

	if p1 > 0.272727272727273 then
		return (11 * p1 - 7) * (11 * p1 - 3) / -16
	end

	if p1 > 0.090909090909091 then
		return (11 * (4 - 11 * p1) * p1 - 3) / 16
	end

	return p1 * (11 * p1 - 1) * -0.6875
end

local t = {
	InLinear = Linear,
	OutLinear = Linear,
	InOutLinear = Linear,
	OutInLinear = Linear,
	OutSmooth = Smooth,
	InSmooth = Smooth,
	InOutSmooth = Smooth,
	OutInSmooth = Smooth,
	OutSmoother = Smoother,
	InSmoother = Smoother,
	InOutSmoother = Smoother,
	OutInSmoother = Smoother,
	OutRidiculousWiggle = RidiculousWiggle,
	InRidiculousWiggle = RidiculousWiggle,
	InOutRidiculousWiggle = RidiculousWiggle,
	OutInRidiculousWiggle = RidiculousWiggle,
	OutRevBack = RevBack,
	InRevBack = RevBack,
	InOutRevBack = RevBack,
	OutInRevBack = RevBack,
	OutSpring = Spring,
	InSpring = Spring,
	InOutSpring = Spring,
	OutInSpring = Spring,
	OutSoftSpring = SoftSpring,
	InSoftSpring = SoftSpring,
	InOutSoftSpring = SoftSpring,
	OutInSoftSpring = SoftSpring,
	InSharp = v1,
	InOutSharp = v1,
	OutSharp = v1,
	OutInSharp = v1,
	InAcceleration = v3,
	InOutAcceleration = v3,
	OutAcceleration = v3,
	OutInAcceleration = v3,
	InStandard = v2,
	InOutStandard = v2,
	OutStandard = v2,
	OutInStandard = v2,
	InDeceleration = v4,
	InOutDeceleration = v4,
	OutDeceleration = v4,
	OutInDeceleration = v4,
	InFabricStandard = v5,
	InOutFabricStandard = v5,
	OutFabricStandard = v5,
	OutInFabricStandard = v5,
	InFabricAccelerate = v6,
	InOutFabricAccelerate = v6,
	OutFabricAccelerate = v6,
	OutInFabricAccelerate = v6,
	InFabricDecelerate = v7,
	InOutFabricDecelerate = v7,
	OutFabricDecelerate = v7,
	OutInFabricDecelerate = v7,
	InUWPAccelerate = v8,
	InOutUWPAccelerate = v8,
	OutUWPAccelerate = v8,
	OutInUWPAccelerate = v8,
	InStandardProductive = v9,
	InStandardExpressive = v10,
	InEntranceProductive = v11,
	InEntranceExpressive = v12,
	InExitProductive = v13,
	InExitExpressive = v14,
	OutStandardProductive = v9,
	OutStandardExpressive = v10,
	OutEntranceProductive = v11,
	OutEntranceExpressive = v12,
	OutExitProductive = v13,
	OutExitExpressive = v14,
	InOutStandardProductive = v9,
	InOutStandardExpressive = v10,
	InOutEntranceProductive = v11,
	InOutEntranceExpressive = v12,
	InOutExitProductive = v13,
	InOutExitExpressive = v14,
	OutInStandardProductive = v9,
	OutInStandardExpressive = v9,
	OutInEntranceProductive = v11,
	OutInEntranceExpressive = v12,
	OutInExitProductive = v13,
	OutInExitExpressive = v14,
	OutMozillaCurve = v15,
	InMozillaCurve = v15,
	InOutMozillaCurve = v15,
	OutInMozillaCurve = v15,
	InQuad = function(p1) --[[ InQuad | Line: 209 ]]
		return p1 * p1
	end,
	OutQuad = function(p1) --[[ OutQuad | Line: 213 ]]
		return p1 * (2 - p1)
	end,
	InOutQuad = function(p1) --[[ InOutQuad | Line: 217 ]]
		if p1 < 0.5 then
			return 2 * p1 * p1
		end

		return 2 * (2 - p1) * p1 - 1
	end,
	OutInQuad = function(p1) --[[ OutInQuad | Line: 225 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2

			return v1 * (2 - v1) / 2
		end

		local v2 = p1 * 2 - 1

		return v2 * v2 / 2 + 0.5
	end,
	InCubic = function(p1) --[[ InCubic | Line: 235 ]]
		return p1 * p1 * p1
	end,
	OutCubic = function(p1) --[[ OutCubic | Line: 239 ]]
		local v1 = p1 - 1

		return 1 - v1 * v1 * v1
	end,
	InOutCubic = function(p1) --[[ InOutCubic | Line: 244 ]]
		if p1 < 0.5 then
			return 4 * p1 * p1 * p1
		end

		local v1 = p1 - 1

		return 1 + 4 * v1 * v1 * v1
	end,
	OutInCubic = function(p1) --[[ OutInCubic | Line: 253 ]]
		if p1 < 0.5 then
			local v1 = 1 - p1 * 2

			return (1 - v1 * v1 * v1) / 2
		end

		local v2 = p1 * 2 - 1

		return v2 * v2 * v2 / 2 + 0.5
	end,
	InQuart = function(p1) --[[ InQuart | Line: 263 ]]
		return p1 * p1 * p1 * p1
	end,
	OutQuart = function(p1) --[[ OutQuart | Line: 267 ]]
		local v1 = p1 - 1

		return 1 - v1 * v1 * v1 * v1
	end,
	InOutQuart = function(p1) --[[ InOutQuart | Line: 272 ]]
		if p1 < 0.5 then
			local v1 = p1 * p1

			return 8 * v1 * v1
		end

		local v2 = p1 - 1

		return 1 - 8 * v2 * v2 * v2 * v2
	end,
	OutInQuart = function(p1) --[[ OutInQuart | Line: 282 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2 - 1

			return (1 - v1 * v1 * v1 * v1) / 2
		end

		local v2 = p1 * 2 - 1

		return v2 * v2 * v2 * v2 / 2 + 0.5
	end,
	InQuint = function(p1) --[[ InQuint | Line: 292 ]]
		return p1 * p1 * p1 * p1 * p1
	end,
	OutQuint = function(p1) --[[ OutQuint | Line: 296 ]]
		local v1 = p1 - 1

		return v1 * v1 * v1 * v1 * v1 + 1
	end,
	InOutQuint = function(p1) --[[ InOutQuint | Line: 301 ]]
		if p1 < 0.5 then
			return 16 * p1 * p1 * p1 * p1 * p1
		end

		local v1 = p1 - 1

		return 16 * v1 * v1 * v1 * v1 * v1 + 1
	end,
	OutInQuint = function(p1) --[[ OutInQuint | Line: 310 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2 - 1

			return (v1 * v1 * v1 * v1 * v1 + 1) / 2
		end

		local v2 = p1 * 2 - 1

		return v2 * v2 * v2 * v2 * v2 / 2 + 0.5
	end,
	InBack = function(p1) --[[ InBack | Line: 320 ]]
		return p1 * p1 * (3 * p1 - 2)
	end,
	OutBack = function(p1) --[[ OutBack | Line: 324 ]]
		local v1 = p1 - 1

		return v1 * v1 * (p1 * 2 + v1) + 1
	end,
	InOutBack = function(p1) --[[ InOutBack | Line: 329 ]]
		if p1 < 0.5 then
			return 2 * p1 * p1 * (6 * p1 - 2)
		end

		return 1 + 2 * (p1 - 1) * (p1 - 1) * (6 * p1 - 2 - 2)
	end,
	OutInBack = function(p1) --[[ OutInBack | Line: 337 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2
			local v2 = v1 - 1

			return (v2 * v2 * (v1 * 2 + v2) + 1) / 2
		end

		local v3 = p1 * 2 - 1

		return v3 * v3 * (3 * v3 - 2) / 2 + 0.5
	end,
	InSine = function(p1) --[[ InSine | Line: 348 ]]
		return 1 - math.cos(p1 * 1.5707963267948966)
	end,
	OutSine = function(p1) --[[ OutSine | Line: 352 ]]
		return math.sin(p1 * 1.5707963267948966)
	end,
	InOutSine = function(p1) --[[ InOutSine | Line: 356 ]]
		return (1 - math.cos(math.pi * p1)) / 2
	end,
	OutInSine = function(p1) --[[ OutInSine | Line: 360 ]]
		if p1 < 0.5 then
			return math.sin(p1 * math.pi) / 2
		end

		return (1 - math.cos((p1 * 2 - 1) * 1.5707963267948966)) / 2 + 0.5
	end,
	OutBounce = OutBounce,
	InBounce = InBounce,
	InOutBounce = function(p1) --[[ InOutBounce | Line: 371 ]]
		if p1 < 0.5 then
			local v1 = 2 * p1
			local v2

			if v1 > 0.63636363636364 then
				local v3 = v1 - 1

				v2 = 1 - v3 * v3 * 7.5625
			else
				v2 = if v1 > 0.272727272727273 then (11 * v1 - 7) * (11 * v1 - 3) / -16 elseif v1 > 0.090909090909091 then (11 * (4 - 11 * v1) * v1 - 3) / 16 else v1 * (11 * v1 - 1) * -0.6875
			end

			return v2 / 2
		end

		local v4 = 2 * p1 - 1

		return (if v4 < 0.36363636363636 then 7.5625 * v4 * v4 elseif v4 < 0.72727272727273 then 3 + v4 * (11 * v4 - 12) * 0.6875 elseif v4 < 0.090909090909091 then 6 + v4 * (11 * v4 - 18) * 0.6875 else 7.875 + v4 * (11 * v4 - 21) * 0.6875) / 2 + 0.5
	end,
	OutInBounce = function(p1) --[[ OutInBounce | Line: 379 ]]
		if p1 < 0.5 then
			local v1 = 2 * p1

			return (if v1 < 0.36363636363636 then 7.5625 * v1 * v1 elseif v1 < 0.72727272727273 then 3 + v1 * (11 * v1 - 12) * 0.6875 elseif v1 < 0.090909090909091 then 6 + v1 * (11 * v1 - 18) * 0.6875 else 7.875 + v1 * (11 * v1 - 21) * 0.6875) / 2
		end

		local v3 = 2 * p1 - 1
		local v4

		if v3 > 0.63636363636364 then
			local v5 = v3 - 1

			v4 = 1 - v5 * v5 * 7.5625
		else
			v4 = if v3 > 0.272727272727273 then (11 * v3 - 7) * (11 * v3 - 3) / -16 elseif v3 > 0.090909090909091 then (11 * (4 - 11 * v3) * v3 - 3) / 16 else v3 * (11 * v3 - 1) * -0.6875
		end

		return v4 / 2 + 0.5
	end,
	InElastic = function(p1) --[[ InElastic | Line: 387 ]]
		return math.exp((p1 * 0.96380736418812 - 1) * 8) * p1 * 0.96380736418812 * math.sin(4 * p1 * 0.96380736418812) * 1.8752275007429
	end,
	OutElastic = function(p1) --[[ OutElastic | Line: 395 ]]
		return 1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * p1 - 1)) * 0.96380736418812 * (p1 - 1) * math.sin(3.85522945675248 * (1 - p1)) * 1.8752275007429
	end,
	InOutElastic = function(p1) --[[ InOutElastic | Line: 406 ]]
		if p1 < 0.5 then
			return math.exp(8 * (1.92761472837624 * p1 - 1)) * 0.96380736418812 * p1 * math.sin(7.71045891350496 * p1) * 1.8752275007429
		end

		return 1 + math.exp(8 * (0.96380736418812 * (2 - 2 * p1) - 1)) * 0.96380736418812 * (p1 - 1) * math.sin(3.85522945675248 * (2 - 2 * p1)) * 1.8752275007429
	end,
	OutInElastic = function(p1) --[[ OutInElastic | Line: 426 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2

			return (1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * v1 - 1)) * 0.96380736418812 * (v1 - 1) * math.sin(3.85522945675248 * (1 - v1)) * 1.8752275007429) / 2
		end

		local v2 = p1 * 2 - 1

		return math.exp((v2 * 0.96380736418812 - 1) * 8) * v2 * 0.96380736418812 * math.sin(4 * v2 * 0.96380736418812) * 1.8752275007429 / 2 + 0.5
	end,
	InExpo = function(p1) --[[ InExpo | Line: 454 ]]
		return p1 * p1 * math.exp(4 * (p1 - 1))
	end,
	OutExpo = function(p1) --[[ OutExpo | Line: 458 ]]
		return 1 - (1 - p1) * (1 - p1) / math.exp(4 * p1)
	end,
	InOutExpo = function(p1) --[[ InOutExpo | Line: 462 ]]
		if p1 < 0.5 then
			return 2 * p1 * p1 * math.exp(4 * (2 * p1 - 1))
		end

		return 1 - 2 * (p1 - 1) * (p1 - 1) * math.exp(4 * (1 - 2 * p1))
	end,
	OutInExpo = function(p1) --[[ OutInExpo | Line: 470 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2

			return (1 - (1 - v1) * (1 - v1) / math.exp(4 * v1)) / 2
		end

		local v2 = p1 * 2 - 1

		return v2 * v2 * math.exp(4 * (v2 - 1)) / 2 + 0.5
	end,
	InCirc = function(p1) --[[ InCirc | Line: 480 ]]
		return -(math.sqrt(1 - p1 * p1) - 1)
	end,
	OutCirc = function(p1) --[[ OutCirc | Line: 484 ]]
		local v1 = p1 - 1

		return math.sqrt(1 - v1 * v1)
	end,
	InOutCirc = function(p1) --[[ InOutCirc | Line: 489 ]]
		local v1 = p1 * 2

		if v1 < 1 then
			return -(math.sqrt(1 - v1 * v1) - 1) / 2
		end

		local v2 = v1 - 2

		return (math.sqrt(1 - v2 * v2) - 1) / 2
	end,
	OutInCirc = function(p1) --[[ OutInCirc | Line: 499 ]]
		if p1 < 0.5 then
			local v1 = p1 * 2 - 1

			return math.sqrt(1 - v1 * v1) / 2
		end

		local v2 = p1 * 2 - 1

		return -(math.sqrt(1 - v2 * v2) - 1) / 2 + 0.5
	end
}

return setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 509 ]]
		error(tostring(p2) .. " is not a valid easing function.", 2)
	end
})