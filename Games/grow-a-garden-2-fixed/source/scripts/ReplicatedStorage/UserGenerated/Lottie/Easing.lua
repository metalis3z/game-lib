--credit to quartz games studio
require(script.Parent.Types)

local function SampleCurve(p1, p2, p3, p4) --[[ SampleCurve | Line: 20 ]]
	return ((p1 * p4 + p2) * p4 + p3) * p4
end

local function SampleDerivative(p1, p2, p3, p4) --[[ SampleDerivative | Line: 24 ]]
	return (p1 * 3 * p4 + p2 * 2) * p4 + p3
end

local function SolveCubicBezier(p1, p2, p3, p4, p5) --[[ SolveCubicBezier | Line: 28 ]]
	if p5 <= 0 then
		return 0
	end

	if p5 >= 1 then
		return 1
	end

	if p1 == p2 and p3 == p4 then
		return p5
	end

	local v1 = p1 * 3
	local v2 = (p3 - p1) * 3 - v1
	local v3 = p2 * 3
	local v4 = (p4 - p2) * 3 - v3
	local v5, sum, v6 = 1 - v3 - v4, p5, 1 - v1 - v2

	for i = 1, 8 do
		local v7 = ((v6 * sum + v2) * sum + v1) * sum - p5

		if math.abs(v7) < 1e-7 then
			return ((v5 * sum + v4) * sum + v3) * sum
		end

		local v8 = (v6 * 3 * sum + v2 * 2) * sum + v1

		if math.abs(v8) < 1e-7 then
			break
		end

		sum = sum - v7 / v8
	end

	local v9, v10, v11 = p5, 0, 1

	for j = 1, 16 do
		local v12 = ((v6 * v9 + v2) * v9 + v1) * v9 - p5

		if math.abs(v12) < 1e-7 then
			break
		end

		if v12 > 0 then
			v11 = v9
		else
			v10 = v9
		end

		v9 = (v10 + v11) * 0.5
	end

	return ((v5 * v9 + v4) * v9 + v3) * v9
end

local function NormalizeHandle(p1, p2) --[[ NormalizeHandle | Line: 70 ]]
	if type(p1) == "number" then
		return p1
	end

	return p1[p2 or 1] or 0
end

local function LerpScalar(p1, p2, p3) --[[ LerpScalar | Line: 78 ]]
	return p1 + (p2 - p1) * p3
end

local function LerpArray(p1, p2, p3) --[[ LerpArray | Line: 82 ]]
	local v1 = table.create(#p1)

	for i = 1, #p1 do
		v1[i] = p1[i] + ((p2[i] or p1[i]) - p1[i]) * p3
	end

	return v1
end

local function LerpBezierShape(p1, p2, p3) --[[ LerpBezierShape | Line: 90 ]]
	local v1 = table.create(#p1.v)
	local v2 = table.create(#p1.i)
	local v3 = table.create(#p1.o)

	for i = 1, #p1.v do
		local v4 = p1.v[i]
		local v5 = p2.v[i]
		local v6 = p1.i[i]
		local v7 = p2.i[i]
		local v8 = p1.o[i]
		local v9 = p2.o[i]

		v1[i] = { v4[1] + (v5[1] - v4[1]) * p3, v4[2] + (v5[2] - v4[2]) * p3 }
		v2[i] = { v6[1] + (v7[1] - v6[1]) * p3, v6[2] + (v7[2] - v6[2]) * p3 }
		v3[i] = { v8[1] + (v9[1] - v8[1]) * p3, v8[2] + (v9[2] - v8[2]) * p3 }
	end

	return {
		v = v1,
		i = v2,
		o = v3,
		c = p1.c
	}
end

local function FindKeyframes(p1, p2) --[[ FindKeyframes | Line: 107 ]]
	local v1 = #p1

	if v1 == 0 then
		return nil, nil, 0
	end

	if v1 == 1 then
		return p1[1], nil, 0
	end

	local v2 = p1[1]

	if p2 <= v2.t then
		return v2, nil, 0
	end

	for i = 2, v1 do
		local v3 = p1[i]

		if p2 < v3.t then
			return p1[i - 1], v3, i - 1
		end
	end

	return p1[v1], nil, v1
end

local function ExtractValue(p1) --[[ ExtractValue | Line: 127 ]]
	if p1 == nil then
		return nil
	end

	if #p1 == 0 then
		return nil
	end

	if type(p1[1]) == "table" then
		return p1[1]
	end

	return p1
end

local function Evaluate(p1, p2) --[[ Evaluate | Line: 139 | Upvalues: FindKeyframes (copy), SolveCubicBezier (copy), LerpArray (copy), LerpBezierShape (copy) ]]
	local a = p1.a
	local k = p1.k

	if a == nil or a == 0 then
		if type(k) == "number" then
			return k
		end

		if type(k) ~= "table" then
			return nil
		end

		if #k > 0 and type(k[1]) == "table" then
			return k[1]
		end

		return k
	end

	local v2, v3, _ = FindKeyframes(k, p2)

	if v2 == nil then
		return nil
	end

	if v3 == nil then
		local s = v2.s
		local v4 = if s == nil or #s == 0 then nil elseif type(s[1]) == "table" then s[1] else s

		if v4 ~= nil then
			return v4
		end

		local e = v2.e

		if e == nil then
			return nil
		end

		if #e == 0 then
			return nil
		end

		if type(e[1]) == "table" then
			return e[1]
		end

		return e
	end

	if v2.h == 1 then
		local s = v2.s

		if s == nil then
			return nil
		end

		if #s == 0 then
			return nil
		end

		if type(s[1]) == "table" then
			return s[1]
		end

		return s
	end

	local t = v2.t
	local v8 = v3.t - t

	if v8 <= 0 then
		local s = v2.s

		if s == nil then
			return nil
		end

		if #s == 0 then
			return nil
		end

		if type(s[1]) == "table" then
			return s[1]
		end

		return s
	end

	local v10 = math.clamp((p2 - t) / v8, 0, 1)
	local s = v2.s
	local v11 = if s == nil or #s == 0 then nil elseif type(s[1]) == "table" then s[1] else s
	local s2 = v3.s
	local v13 = if s2 == nil or #s2 == 0 then nil elseif type(s2[1]) == "table" then s2[1] else s2

	if not v13 then
		local e = v2.e

		v13 = if e == nil or #e == 0 then nil elseif type(e[1]) == "table" then e[1] else e
	end

	if v11 == nil or v13 == nil then
		return v11 or v13
	end

	local o = v2.o
	local i = v2.i

	if o and i then
		local x = o.x
		local v17 = if type(x) == "number" then x else x[1] or 0
		local y = o.y
		local v18 = if type(y) == "number" then y else y[1] or 0
		local x2 = i.x
		local v19 = if type(x2) == "number" then x2 else x2[1] or 0
		local y2 = i.y

		v10 = SolveCubicBezier(v17, v18, v19, if type(y2) == "number" then y2 else y2[1] or 0, v10)
	end

	if type(v11) == "number" then
		return v11 + (v13 - v11) * v10
	end

	if type(v11) ~= "table" then
		return v11
	end

	if #v11 > 0 and type(v11[1]) == "number" then
		return LerpArray(v11, v13, v10)
	end

	return LerpBezierShape(v11, v13, v10)
end

local function EvaluateScalar(p1, p2) --[[ EvaluateScalar | Line: 212 | Upvalues: Evaluate (copy) ]]
	if p1 == nil then
		return p2
	end

	local v1 = Evaluate(p1, 0)

	if v1 == nil then
		return p2
	end

	if type(v1) == "number" then
		return v1
	end

	if type(v1) == "table" then
		return v1[1] or p2
	end

	return p2
end

local function EvaluateScalarAtFrame(p1, p2, p3) --[[ EvaluateScalarAtFrame | Line: 221 | Upvalues: Evaluate (copy) ]]
	if p1 == nil then
		return p3
	end

	local v1 = Evaluate(p1, p2)

	if v1 == nil then
		return p3
	end

	if type(v1) == "number" then
		return v1
	end

	if type(v1) == "table" then
		return v1[1] or p3
	end

	return p3
end

local function EvaluateVector(p1, p2, p3) --[[ EvaluateVector | Line: 230 | Upvalues: Evaluate (copy) ]]
	if p1 == nil then
		return p3
	end

	local v1 = Evaluate(p1, p2)

	if v1 == nil then
		return p3
	end

	if type(v1) == "table" then
		return v1
	end

	if type(v1) == "number" then
		return { v1 }
	end

	return p3
end

local function EvaluateColor(p1, p2) --[[ EvaluateColor | Line: 239 | Upvalues: Evaluate (copy) ]]
	if p1 == nil then
		return Color3.new(255/255, 255/255, 255/255)
	end

	local v1 = Evaluate(p1, p2)

	if v1 == nil then
		return Color3.new(255/255, 255/255, 255/255)
	end

	if type(v1) == "table" then
		return Color3.new(v1[1] or 1, v1[2] or 1, v1[3] or 1)
	end

	return Color3.new(255/255, 255/255, 255/255)
end

local function EvaluateBezierShape(p1, p2) --[[ EvaluateBezierShape | Line: 250 | Upvalues: Evaluate (copy) ]]
	if p1 == nil then
		return nil
	end

	local v1 = Evaluate(p1, p2)

	if v1 == nil then
		return nil
	end

	if type(v1) ~= "table" or not (#v1 > 0) then
		return nil
	end

	if type(v1[1]) == "number" then
		return nil
	end

	return v1
end

return table.freeze({
	SolveCubicBezier = SolveCubicBezier,
	Evaluate = Evaluate,
	EvaluateScalar = EvaluateScalar,
	EvaluateScalarAtFrame = EvaluateScalarAtFrame,
	EvaluateVector = EvaluateVector,
	EvaluateColor = EvaluateColor,
	EvaluateBezierShape = EvaluateBezierShape,
	LerpArray = LerpArray
})