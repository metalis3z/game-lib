-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

require(script.Parent.Types)
function t.Linear(p1, p2, p3, p4) --[[ Linear | Line: 21 ]]
	return p3 * p1 / p4 + p2
end
function t.Constant(p1, p2, p3, p4) --[[ Constant | Line: 29 ]]
	if p1 == p4 then
		return 1
	end

	return 0
end
function t.InSine(p1, p2, p3, p4) --[[ InSine | Line: 37 ]]
	return -p3 * math.cos(p1 / p4 * 1.5707963267948966) + p3 + p2
end
function t.OutSine(p1, p2, p3, p4) --[[ OutSine | Line: 41 ]]
	return p3 * math.sin(p1 / p4 * 1.5707963267948966) + p2
end
function t.InOutSine(p1, p2, p3, p4) --[[ InOutSine | Line: 45 ]]
	return -p3 / 2 * (math.cos(math.pi * p1 / p4) - 1) + p2
end
function t.OutInSine(p1, p2, p3, p4) --[[ OutInSine | Line: 49 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutSine(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InSine(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InQuad(p1, p2, p3, p4) --[[ InQuad | Line: 61 ]]
	return p3 * math.pow(p1 / p4, 2) + p2
end
function t.OutQuad(p1, p2, p3, p4) --[[ OutQuad | Line: 66 ]]
	local v1 = p1 / p4

	return -p3 * v1 * (v1 - 2) + p2
end
function t.InOutQuad(p1, p2, p3, p4) --[[ InOutQuad | Line: 71 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * math.pow(v1, 2) + p2
	end

	return -p3 / 2 * ((v1 - 1) * (v1 - 3) - 1) + p2
end
function t.OutInQuad(p1, p2, p3, p4) --[[ OutInQuad | Line: 81 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutQuad(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InQuad(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InCubic(p1, p2, p3, p4) --[[ InCubic | Line: 93 ]]
	return p3 * math.pow(p1 / p4, 3) + p2
end
function t.OutCubic(p1, p2, p3, p4) --[[ OutCubic | Line: 98 ]]
	return p3 * (math.pow(p1 / p4 - 1, 3) + 1) + p2
end
function t.InOutCubic(p1, p2, p3, p4) --[[ InOutCubic | Line: 103 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * v1 * v1 * v1 + p2
	end

	local v2 = v1 - 2

	return p3 / 2 * (v2 * v2 * v2 + 2) + p2
end
function t.OutInCubic(p1, p2, p3, p4) --[[ OutInCubic | Line: 114 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutCubic(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InCubic(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InQuart(p1, p2, p3, p4) --[[ InQuart | Line: 126 ]]
	return p3 * math.pow(p1 / p4, 4) + p2
end
function t.OutQuart(p1, p2, p3, p4) --[[ OutQuart | Line: 131 ]]
	return -p3 * (math.pow(p1 / p4 - 1, 4) - 1) + p2
end
function t.InOutQuart(p1, p2, p3, p4) --[[ InOutQuart | Line: 136 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * math.pow(v1, 4) + p2
	end

	return -p3 / 2 * (math.pow(v1 - 2, 4) - 2) + p2
end
function t.OutInQuart(p1, p2, p3, p4) --[[ OutInQuart | Line: 147 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutQuart(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InQuart(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InQuint(p1, p2, p3, p4) --[[ InQuint | Line: 159 ]]
	return p3 * math.pow(p1 / p4, 5) + p2
end
function t.OutQuint(p1, p2, p3, p4) --[[ OutQuint | Line: 164 ]]
	return p3 * (math.pow(p1 / p4 - 1, 5) + 1) + p2
end
function t.InOutQuint(p1, p2, p3, p4) --[[ InOutQuint | Line: 169 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * math.pow(v1, 5) + p2
	end

	return p3 / 2 * (math.pow(v1 - 2, 5) + 2) + p2
end
function t.OutInQuint(p1, p2, p3, p4) --[[ OutInQuint | Line: 180 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutQuint(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InQuint(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InSextic(p1, p2, p3, p4) --[[ InSextic | Line: 192 ]]
	return p3 * math.pow(p1 / p4, 6) + p2
end
function t.OutSextic(p1, p2, p3, p4) --[[ OutSextic | Line: 197 ]]
	return -p3 * (math.pow(p1 / p4 - 1, 6) - 1) + p2
end
function t.InOutSextic(p1, p2, p3, p4) --[[ InOutSextic | Line: 202 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * math.pow(v1, 6) + p2
	end

	return -p3 / 2 * (math.pow(v1 - 2, 6) - 2) + p2
end
function t.OutInSextic(p1, p2, p3, p4) --[[ OutInSextic | Line: 213 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutSextic(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InSextic(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InExpo(p1, p2, p3, p4) --[[ InExpo | Line: 225 ]]
	if p1 == 0 then
		return p2
	end

	return p3 * math.pow(2, 10 * (p1 / p4 - 1)) + p2 - p3 * 0.001
end
function t.OutExpo(p1, p2, p3, p4) --[[ OutExpo | Line: 233 ]]
	if p1 == p4 then
		return p2 + p3
	end

	return p3 * 1.001 * (-math.pow(2, -10 * p1 / p4) + 1) + p2
end
function t.InOutExpo(p1, p2, p3, p4) --[[ InOutExpo | Line: 241 ]]
	if p1 == 0 then
		return p2
	end

	if p1 == p4 then
		return p2 + p3
	end

	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return p3 / 2 * math.pow(2, 10 * (v1 - 1)) + p2 - p3 * 0.0005
	end

	return p3 / 2 * 1.0005 * (-math.pow(2, -10 * (v1 - 1)) + 2) + p2
end
function t.OutInExpo(p1, p2, p3, p4) --[[ OutInExpo | Line: 260 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutExpo(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InExpo(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InCirc(p1, p2, p3, p4) --[[ InCirc | Line: 272 ]]
	return -p3 * (math.sqrt(1 - math.pow(p1 / p4, 2)) - 1) + p2
end
function t.OutCirc(p1, p2, p3, p4) --[[ OutCirc | Line: 277 ]]
	return p3 * math.sqrt(1 - math.pow(p1 / p4 - 1, 2)) + p2
end
function t.InOutCirc(p1, p2, p3, p4) --[[ InOutCirc | Line: 282 ]]
	local v1 = p1 / p4 * 2

	if v1 < 1 then
		return -p3 / 2 * (math.sqrt(1 - v1 * v1) - 1) + p2
	end

	local v2 = v1 - 2

	return p3 / 2 * (math.sqrt(1 - v2 * v2) + 1) + p2
end
function t.OutInCirc(p1, p2, p3, p4) --[[ OutInCirc | Line: 293 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutCirc(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InCirc(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.InBack(p1, p2, p3, p4, p5) --[[ InBack | Line: 305 ]]
	if not p5 then
		p5 = 1.70158
	end

	local v1 = p1 / p4

	return p3 * v1 * v1 * ((p5 + 1) * v1 - p5) + p2
end
function t.OutBack(p1, p2, p3, p4, p5) --[[ OutBack | Line: 314 ]]
	if not p5 then
		p5 = 1.70158
	end

	local v1 = p1 / p4 - 1

	return p3 * (v1 * v1 * ((p5 + 1) * v1 + p5) + 1) + p2
end
function t.InOutBack(p1, p2, p3, p4, p5) --[[ InOutBack | Line: 323 ]]
	if not p5 then
		p5 = 1.70158
	end

	local v1 = p5 * 1.525
	local v2 = p1 / p4 * 2

	if v2 < 1 then
		return p3 / 2 * (v2 * v2 * ((v1 + 1) * v2 - v1)) + p2
	end

	local v3 = v2 - 2

	return p3 / 2 * (v3 * v3 * ((v1 + 1) * v3 + v1) + 2) + p2
end
function t.OutInBack(p1, p2, p3, p4, p5) --[[ OutInBack | Line: 339 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutBack(p1 * 2, p2, p3 / 2, p4, p5)
	end

	return t.InBack(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4, p5)
end
function t.OutBounce(p1, p2, p3, p4) --[[ OutBounce | Line: 351 ]]
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
function t.InBounce(p1, p2, p3, p4) --[[ InBounce | Line: 368 | Upvalues: t (copy) ]]
	return p3 - t.OutBounce(p4 - p1, 0, p3, p4) + p2
end
function t.InOutBounce(p1, p2, p3, p4) --[[ InOutBounce | Line: 372 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.InBounce(p1 * 2, 0, p3, p4) * 0.5 + p2
	end

	return t.OutBounce(p1 * 2 - p4, 0, p3, p4) * 0.5 + p3 * 0.5 + p2
end
function t.OutInBounce(p1, p2, p3, p4) --[[ OutInBounce | Line: 380 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutBounce(p1 * 2, p2, p3 / 2, p4)
	end

	return t.InBounce(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4)
end
function t.ElasticBlend(p1, p2, p3, p4, p5, p6) --[[ ElasticBlend | Line: 392 ]]
	if p2 ~= 0 then
		local v1 = math.abs(p5)

		p6 = if p4 == 0 then 0 else p6 * (p4 / math.abs(p2))

		if math.abs(p1 * p3) < v1 then
			local v2 = math.abs(p1 * p3) / v1

			p6 = p6 * v2 + (1 - v2)
		end
	end

	return p6
end
function t.InElastic(p1, p2, p3, p4, p5, p6) --[[ InElastic | Line: 411 | Upvalues: t (copy) ]]
	local v1 = 1

	if p1 == 0 then
		return p2
	end

	local v2 = p1 / p4

	if v2 == 1 then
		return p2 + p3
	end

	local v3 = v2 - 1

	if not p6 or p6 == 0 then
		p6 = p4 * 0.3
	end

	local v4

	if p5 == nil or p5 < math.abs(p3) then
		v4 = p6 / 4
		v1, p5 = t.ElasticBend(v3, p3, p4, p5, v4, v1), p3
	else
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	end

	return -v1 * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p2
end
function t.OutElastic(p1, p2, p3, p4, p5, p6) --[[ OutElastic | Line: 442 | Upvalues: t (copy) ]]
	local v1 = 1

	if p1 == 0 then
		return p2
	end

	local v2 = p1 / p4

	if v2 == 1 then
		return p2 + p3
	end

	local v3 = -v2

	if not p6 or p6 == 0 then
		p6 = p4 * 0.3
	end

	local v4

	if p5 == nil or p5 < math.abs(p3) then
		v4 = p6 / 4
		p5, v1 = p3, t.ElasticBlend(v3, p3, p4, p5, v4, v1)
	else
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	end

	return v1 * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p3 + p2
end
function t.InOutElastic(p1, p2, p3, p4, p5, p6) --[[ InOutElastic | Line: 473 | Upvalues: t (copy) ]]
	local v1 = 1

	if p1 == 0 then
		return p2
	end

	local v2 = p1 / (p4 / 2)

	if v2 == 2 then
		return p2 + p3
	end

	local v3 = v2 - 1

	if not p6 or p6 == 0 then
		p6 = p4 * 0.44999999999999996
	end

	local v4

	if p5 == nil or p5 < math.abs(p3) then
		v4 = p6 / 4
		v1, p5 = t.ElasticBlend(v3, p3, p4, p5, v4, v1), p3
	else
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	end

	if v3 < 0 then
		return v1 * -0.5 * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p2
	end

	local v6 = -v3

	return v1 * 0.5 * (p5 * math.pow(2, 10 * v6) * math.sin((v6 * p4 - v4) * 6.283185307179586 / p6)) + p3 + p2
end
function t.OutInElastic(p1, p2, p3, p4, p5, p6) --[[ OutInElastic | Line: 511 | Upvalues: t (copy) ]]
	if p1 < p4 / 2 then
		return t.OutElastic(p1 * 2, p2, p3 / 2, p4, p5, p6)
	end

	return t.InElastic(p1 * 2 - p4, p2 + p3 / 2, p3 / 2, p4, p5, p6)
end

local HttpService = game:GetService("HttpService")
local t2 = {
	Type = "Linear",
	Params = {}
}
local t3 = {}

local function v2(p1) --[[ get | Line: 534 | Upvalues: t2 (copy), HttpService (copy), t3 (copy), t (copy), v2 (copy) ]]
	local v1 = if p1 then p1 else t2
	local v22 = HttpService:JSONEncode(v1)

	if t3[v22] == nil then
		local Params = v1.Params
		local v3 = v1.Type or "Linear"
		local v4 = t[("%*%*"):format(Params.Direction or "In", v3)] or t[v3]

		if not v4 then
			return v2(t2)
		end

		local v5 = nil
		local v6 = nil

		if v3 == "Elastic" then
			v5 = Params.Amplitude or 1
			v6 = Params.Period or 0.3
		elseif v3 == "Back" then
			v5 = Params.Overshoot or 1.70158
		end

		t3[v22] = function(p1) --[[ Line: 558 | Upvalues: v4 (copy), v5 (ref), v6 (ref) ]]
			return v4(p1, 0, 1, 1, v5, v6)
		end
	end

	return t3[v22]
end

return {
	Get = v2
}