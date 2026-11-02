-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function Get(p1, p2, p3) --[[ Get | Line: 3 | Upvalues: t (copy) ]]
	local v1 = if p2 == nil then "Sine" elseif typeof(p2) == "string" and p2 then p2 else p2.Name
	local v2 = if p3 == nil then "Sine" elseif typeof(p3) == "string" and p3 then p3 else p3.Name

	if type(v1) ~= "string" then
		v1 = string.sub(tostring(v1), 18)
	end

	if type(v2) ~= "string" then
		v2 = string.sub(tostring(v2), 22)
	end

	if v1 == "Circular" then
		v1 = "Circ"
	elseif v1 == "Exponential" then
		v1 = "Expo"
	end

	if v1 == "Linear" then
		return p1
	end

	local v7 = t[v1 .. v2]

	if v7 then
		return v7(p1)
	end

	error("Tween function \'" .. v1 .. "." .. v2 .. "\' doesn\'t exist.")
end
function t.QuadIn(p1) --[[ QuadIn | Line: 28 ]]
	return p1 * p1
end
function t.QuadOut(p1) --[[ QuadOut | Line: 32 ]]
	return p1 * (2 - p1)
end
function t.QuadInOut(p1) --[[ QuadInOut | Line: 36 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return v1 * v1 * 0.5
	end

	return ((v1 - 1) * (v1 - 3) - 1) * -0.5
end
function t.QuadOutIn(p1) --[[ QuadOutIn | Line: 44 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.QuadOut(p1 * 2)
	end

	return t.QuadIn(p1 * 2 - 1)
end
function t.CubicIn(p1) --[[ CubicIn | Line: 50 ]]
	return p1 * p1 * p1
end
function t.CubicOut(p1) --[[ CubicOut | Line: 54 ]]
	local v1 = p1 - 1

	return v1 * v1 * v1 + 1
end
function t.CubicInOut(p1) --[[ CubicInOut | Line: 59 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return v1 * v1 * v1 * 0.5
	end

	local v2 = v1 - 2

	return (v2 * v2 * v2 + 2) * 0.5
end
function t.CubicOutIn(p1) --[[ CubicOutIn | Line: 68 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.CubicOut(p1 * 2)
	end

	return t.CubicIn(p1 * 2 - 1)
end
function t.QuartIn(p1) --[[ QuartIn | Line: 74 ]]
	return p1 * p1 * p1 * p1
end
function t.QuartOut(p1) --[[ QuartOut | Line: 78 ]]
	local v1 = p1 - 1

	return 1 - v1 * v1 * v1 * v1
end
function t.QuartInOut(p1) --[[ QuartInOut | Line: 83 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return v1 * v1 * v1 * v1 * 0.5
	end

	local v2 = v1 - 2

	return (2 - v2 * v2 * v2 * v2) * 0.5
end
function t.QuartOutIn(p1) --[[ QuartOutIn | Line: 92 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.QuartOut(p1 * 2)
	end

	return t.QuartIn(p1 * 2 - 1)
end
function t.QuintIn(p1) --[[ QuintIn | Line: 98 ]]
	return p1 * p1 * p1 * p1 * p1
end
function t.QuintOut(p1) --[[ QuintOut | Line: 102 ]]
	local v1 = p1 - 1

	return v1 * v1 * v1 * v1 * v1 + 1
end
function t.QuintInOut(p1) --[[ QuintInOut | Line: 107 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return v1 * v1 * v1 * v1 * v1 * 0.5
	end

	local v2 = v1 - 2

	return (v2 * v2 * v2 * v2 * v2 + 2) * 0.5
end
function t.QuintOutIn(p1) --[[ QuintOutIn | Line: 116 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.QuintOut(p1 * 2)
	end

	return t.QuintIn(p1 * 2 - 1)
end
function t.SineIn(p1) --[[ SineIn | Line: 122 ]]
	return 1 - math.cos(p1 * 1.5707963267948966)
end
function t.SineOut(p1) --[[ SineOut | Line: 126 ]]
	return math.sin(p1 * 1.5707963267948966)
end
function t.SineInOut(p1) --[[ SineInOut | Line: 130 ]]
	return (1 - math.cos(math.pi * p1)) * 0.5
end
function t.SineOutIn(p1) --[[ SineOutIn | Line: 134 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.SineOut(p1 * 2)
	end

	return t.SineIn(p1 * 2)
end
function t.ExpoIn(p1) --[[ ExpoIn | Line: 140 ]]
	if p1 == 0 then
		return 0
	end

	return math.pow(2, (p1 - 1) * 10) - 0.001
end
function t.ExpoOut(p1) --[[ ExpoOut | Line: 147 ]]
	if p1 == 1 then
		return 1
	end

	return (1 - math.pow(2, p1 * -10)) * 1.001
end
function t.ExpoInOut(p1) --[[ ExpoInOut | Line: 154 ]]
	if p1 == 0 then
		return 0
	end

	if p1 == 1 then
		return 1
	end

	local v1 = p1 * 2

	if v1 < 1 then
		return math.pow(2, (v1 - 1) * 10) * 0.5 - 0.0005
	end

	return (2 - math.pow(2, (v1 - 1) * -10)) * 0.50025
end
function t.ExpoOutIn(p1) --[[ ExpoOutIn | Line: 169 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.ExpoOut(p1 * 2)
	end

	return t.ExpoIn(p1 * 2 - 1)
end
function t.CircIn(p1) --[[ CircIn | Line: 175 ]]
	return 1 - math.sqrt(1 - p1 * p1)
end
function t.CircOut(p1) --[[ CircOut | Line: 179 ]]
	local v1 = p1 - 1

	return math.sqrt(1 - v1 * v1)
end
function t.CircInOut(p1) --[[ CircInOut | Line: 184 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return (1 - math.sqrt(1 - v1 * v1)) * 0.5
	end

	local v2 = v1 - 2

	return (math.sqrt(1 - v2 * v2) + 1) * 0.5
end
function t.CircOutIn(p1) --[[ CircOutIn | Line: 193 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.CircOut(p1 * 2)
	end

	return t.CircIn(p1 * 2 - 1)
end
function t.ElasticIn(p1) --[[ ElasticIn | Line: 199 ]]
	if p1 == 0 then
		return 0
	end

	if p1 == 1 then
		return 1
	end

	local v1 = p1 - 1

	return -(math.pow(2, v1 * 10) * 1 * math.sin((v1 - 0.075) * 6.283185307179586 / 0.3))
end
function t.ElasticOut(p1) --[[ ElasticOut | Line: 213 ]]
	if p1 == 0 then
		return 0
	end

	if p1 == 1 then
		return 1
	end

	return math.pow(2, p1 * -10) * 1 * math.sin((p1 - 0.075) * 6.283185307179586 / 0.3) + 1
end
function t.ElasticInOut(p1) --[[ ElasticInOut | Line: 225 ]]
	if p1 == 0 then
		return 0
	end

	local v1 = p1 * 2

	if v1 == 2 then
		return 1
	end

	if v1 < 1 then
		local v2 = v1 - 1

		return math.pow(2, v2 * 10) * 1 * math.sin((v2 - 0.1125) * 6.283185307179586 / 0.45) * -0.5
	end

	local v3 = v1 - 1

	return math.pow(2, v3 * -10) * 1 * math.sin((v3 - 0.1125) * 6.283185307179586 / 0.45) * 0.5 + 1
end
function t.ElasticOutIn(p1) --[[ ElasticOutIn | Line: 244 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.ElasticOut(p1 * 2)
	end

	return t.ElasticIn(p1 * 2 - 1)
end
function t.BackIn(p1) --[[ BackIn | Line: 250 ]]
	return p1 * p1 * (p1 * 2.70158 - 1.70158)
end
function t.BackOut(p1) --[[ BackOut | Line: 254 ]]
	local v1 = p1 - 1

	return v1 * v1 * (v1 * 2.70158 + 1.70158) + 1
end
function t.BackInOut(p1) --[[ BackInOut | Line: 259 ]]
	local v1 = p1 * 2

	if v1 < 1 then
		return v1 * v1 * (3.5949095 * v1 - 2.5949095) * 0.5
	end

	local v2 = v1 - 2

	return (v2 * v2 * (3.5949095 * v2 + 2.5949095) + 2) * 0.5
end
function t.BackOutIn(p1) --[[ BackOutIn | Line: 269 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.BackOut(p1 * 2)
	end

	return t.BackIn(p1 * 2 - 1)
end
function t.BounceOut(p1) --[[ BounceOut | Line: 275 ]]
	if p1 < 0.36363636363636365 then
		return p1 * 7.5625 * p1
	end

	if p1 < 0.7272727272727273 then
		local v1 = p1 - 0.5454545454545454

		return v1 * 7.5625 * v1 + 0.75
	end

	if p1 < 0.9090909090909091 then
		local v2 = p1 - 0.8181818181818182

		return v2 * 7.5625 * v2 + 0.9375
	end

	local v3 = p1 - 0.9545454545454546

	return v3 * 7.5625 * v3 + 0.984375
end
function t.BounceIn(p1) --[[ BounceIn | Line: 291 | Upvalues: t (copy) ]]
	return 1 - t.BounceOut(1 - p1)
end
function t.BounceInOut(p1) --[[ BounceInOut | Line: 295 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.BounceIn(p1 * 2) * 0.5
	end

	return t.BounceOut(p1 * 2 - 1) * 0.5 + 0.5
end
function t.BounceOutIn(p1) --[[ BounceOutIn | Line: 302 | Upvalues: t (copy) ]]
	if p1 < 0.5 then
		return t.BounceOut(p1 * 2)
	end

	return t.BounceIn(p1 * 2 - 1)
end

return Get