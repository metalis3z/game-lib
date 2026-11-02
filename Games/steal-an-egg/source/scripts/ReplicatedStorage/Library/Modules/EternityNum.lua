-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	0.9999999999998099,
	676.5203681218851,
	-1259.1392167224028,
	771.3234287776531,
	-176.6150291621406,
	12.507343278686905,
	-0.13857109526572012,
	9.984369578019572e-6,
	1.5056327351493116e-7
}

function F_Gamma(p1) --[[ F_Gamma | Line: 98 | Upvalues: t (copy) ]]
	if p1 > 171.6236 then
		return (1 / 0)
	end

	if p1 > 0.5 then
		local v1 = p1 - 1
		local v2 = v1 + 7.5

		return (t[1] + t[2] / (v1 + 1) + t[3] / (v1 + 2) + t[4] / (v1 + 3) + t[5] / (v1 + 4) + t[6] / (v1 + 5) + t[7] / (v1 + 6) + t[8] / (v1 + 7)) * v2 ^ (v1 + 0.5 - 36) * math.exp(-v2) * v2 ^ 36 * 2.5066282746310007
	end

	return math.pi / (math.sin(math.pi * p1) * F_Gamma(1 - p1))
end
function f_Lambertw(p1) --[[ f_Lambertw | Line: 124 ]]
	if p1 > 1.79e308 then
		return p1
	end

	if p1 == 0 then
		return p1
	end

	if p1 == 1 then
		return 0.5671432904097838
	end

	local v1

	if p1 < 10 then
		v1 = 0
	else
		local v2 = math.log(p1)

		v1 = v2 - math.log((math.log(p1)))
	end

	for i = 1, 100 do
		local v4 = (p1 * math.exp(-v1) + v1 * v1) / (v1 + 1)

		if math.abs(v4 - v1) < math.abs(v4) * 1e-10 then
			return v4
		end

		v1 = v4
	end

	error("Failed to itterate z.... at function: f_lambertw")
end

local t2 = {}

function Cnew(p1, p2, p3) --[[ Cnew | Line: 163 ]]
	return {
		Sign = p1,
		Layer = p2,
		Exp = p3
	}
end

local v1 = Cnew(0, 0, 0)
local v2 = Cnew(1, 0, 1)
local v3 = Cnew(1, -1, 1)
local v4 = Cnew(1, (1 / 0), 1)

function t2.IsNaN(p1) --[[ IsNaN | Line: 174 | Upvalues: v3 (copy) ]]
	return if p1.Sign == v3.Sign and p1.Layer == v3.Layer then p1.Exp == v3.Exp else false
end
function t2.IsInf(p1) --[[ IsInf | Line: 178 ]]
	return if p1.Layer == (1 / 0) then true else p1.Exp == (1 / 0)
end
function t2.IsZero(p1) --[[ IsZero | Line: 182 ]]
	return if p1.Sign == 0 then true elseif p1.Exp == 0 then p1.Layer == 0 else false
end
function t2.correct(p1) --[[ correct | Line: 186 | Upvalues: t2 (copy), v3 (copy), v4 (copy), v1 (copy) ]]
	if t2.IsNaN(p1) then
		return v3
	end

	if t2.IsInf(p1) then
		return v4
	end

	if t2.IsZero(p1) then
		return v1
	end

	local Sign = p1.Sign
	local Layer = p1.Layer
	local Exp = p1.Exp

	if Layer == 0 and Exp < 0 then
		Exp = -Exp
		Sign = -Sign
	end

	if Layer == 0 and Exp < 1e-10 then
		return Cnew(Sign, Layer + 1, (math.log10(Exp)))
	end

	local v2 = math.abs(Exp)
	local v32 = math.sign(Exp)

	if v2 >= 10000000000 then
		return Cnew(Sign, Layer + 1, v32 * math.log10(v2))
	end

	while v2 < 10 and Layer > 0 do
		Layer = Layer - 1

		if Layer == 0 then
			Exp = math.pow(10, Exp)
		else
			Exp = v32 * math.pow(10, v2)

			local v6 = math.abs(Exp)

			v2, v32 = v6, math.sign(Exp)
		end
	end

	if Layer == 0 then
		if Exp < 0 then
			Sign = -Sign
			Exp = -Exp
		end
	elseif Exp == 0 then
		Sign = 0
	end

	return Cnew(Sign, Layer, Exp)
end
function t2.new(p1, p2, p3) --[[ new | Line: 243 | Upvalues: t2 (copy) ]]
	return t2.correct({
		Sign = p1,
		Layer = p2,
		Exp = p3
	})
end
function t2.fromNumber(p1) --[[ fromNumber | Line: 247 | Upvalues: t2 (copy) ]]
	return t2.correct({
		Sign = math.sign(p1),
		Layer = 0,
		Exp = math.abs(p1)
	})
end
function t2.fromScientific(p1) --[[ fromScientific | Line: 255 | Upvalues: t2 (copy), v1 (copy) ]]
	local v12 = p1:split("e")
	local v3 = tonumber(v12[1])
	local sum = tonumber(v12[2])
	local v5 = math.sign(v3)
	local v7 = math.floor((math.log10(v3)))

	if v7 > 0 then
		sum = sum + v7
		v3 = v3 / 10 ^ v7
	end

	if sum == 0 then
		return t2.new(math.sign(v3), 0, v3)
	end

	if v3 == 0 then
		return v1
	end

	if v3 < 0 then
		v3 = -v3
	end

	if sum < 0 then
		if sum < -100 then
			return v1
		end

		return t2.correct(t2.new(v5, 1, math.log10(v3) + sum))
	end

	local v9 = math.log10(v3) + sum
	local count = 1

	if v9 > 10000000000 then
		count, v9 = count + 1, math.log10(v9)
	end

	return t2.correct(t2.new(v5, count, v9))
end
function t2.fromDefaultStringFormat(p1) --[[ fromDefaultStringFormat | Line: 300 | Upvalues: t2 (copy) ]]
	local v1 = p1:split(";")
	local v4 = math.sign((tonumber(v1[1])))

	if v4 == 0 then
		v4 = 1
	end

	return t2.correct(t2.new(v4, math.abs((tonumber(v1[1]))), (tonumber(v1[2]))))
end
function t2.fromString(p1) --[[ fromString | Line: 311 | Upvalues: t2 (copy), v3 (copy), v4 (copy), v1 (copy) ]]
	if p1:find("e") and not p1:find(";") then
		return t2.fromScientific(p1)
	end

	if p1:find(";") then
		return t2.fromDefaultStringFormat(p1)
	end

	if p1 == "NaN" then
		return v3
	end

	if p1 == "Inf" then
		return v4
	end

	if p1 == "" then
		return v1
	end

	return t2.fromNumber((tonumber(p1)))
end
function t2.toString(p1) --[[ toString | Line: 331 | Upvalues: t2 (copy) ]]
	if t2.IsNaN(p1) then
		return "NaN"
	end

	if t2.IsInf(p1) then
		return "Inf"
	end

	return p1.Layer .. ";" .. p1.Exp
end
function t2.convert(p1) --[[ convert | Line: 341 | Upvalues: t2 (copy), v1 (copy) ]]
	if typeof(p1) == "number" then
		return t2.fromNumber(p1)
	end

	if typeof(p1) == "string" then
		return t2.fromString(p1)
	end

	if typeof(p1) ~= "table" then
		warn("Returning DefaultReturn at EN.Convert(): Invalid input!")

		return v1
	end

	if #p1 == 2 then
		return t2.fromScientific(p1[1] .. "e" .. p1[2])
	end

	if #p1 == 3 then
		return t2.correct(t2.new(p1[1], p1[2], p1[3]))
	end

	if p1.Sign then
		return t2.correct(t2.new(p1.Sign, p1.Layer, p1.Exp))
	end

	warn("Returning DefaultReturn at EN.Convert(): Invalid input!")

	return v1
end
function t2.toNumber(p1) --[[ toNumber | Line: 360 ]]
	if p1.Layer > 1 then
		if math.sign(p1.Exp) == -1 then
			return p1.Sign * 0
		end

		return p1.Sign * (1 / 0)
	end

	if p1.Layer == 0 then
		return p1.Sign * p1.Exp
	end

	if p1.Layer == 1 then
		return p1.Sign * 10 ^ p1.Exp
	end

	return (0 / 0)
end
function t2.abs(p1) --[[ abs | Line: 377 | Upvalues: t2 (copy), v1 (copy) ]]
	local v12 = t2.convert(p1)

	if v12.Sign == 0 then
		return v1
	end

	return t2.new(1, v12.Layer, v12.Exp)
end
function t2.maxAbs(p1, p2) --[[ maxAbs | Line: 386 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)
	local v2 = t2.convert(p2)

	if t2.cmpAbs(v1, v2) < 0 then
		return v2
	end

	return v1
end
function t2.neg(p1) --[[ neg | Line: 395 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	return t2.new(-v1.Sign, v1.Layer, v1.Exp)
end
function t2.cmpAbs(p1, p2) --[[ cmpAbs | Line: 400 ]]
	local v1 = if p1.Exp > 0 then p1.Layer else -p1.Layer
	local v2 = if p2.Exp > 0 then p2.Layer else -p2.Layer

	if v2 < v1 then
		return 1
	end

	if v1 < v2 then
		return -1
	end

	if p1.Exp > p2.Exp then
		return 1
	end

	if p1.Exp < p2.Exp then
		return -1
	end

	return 0
end
function t2.cmp(p1, p2) --[[ cmp | Line: 431 | Upvalues: t2 (copy) ]]
	if p1.Sign > p2.Sign then
		return 1
	end

	if p1.Sign < p2.Sign then
		return -1
	end

	return p1.Sign * t2.cmpAbs(p1, p2)
end
function t2.le(p1, p2) --[[ le | Line: 441 | Upvalues: t2 (copy) ]]
	return t2.cmp(t2.convert(p1), (t2.convert(p2))) == -1
end
function t2.me(p1, p2) --[[ me | Line: 447 | Upvalues: t2 (copy) ]]
	return t2.cmp(t2.convert(p1), (t2.convert(p2))) == 1
end
function t2.eq(p1, p2) --[[ eq | Line: 453 | Upvalues: t2 (copy) ]]
	return t2.cmp(t2.convert(p1), (t2.convert(p2))) == 0
end
function t2.leeq(p1, p2) --[[ leeq | Line: 459 | Upvalues: t2 (copy) ]]
	return not (t2.cmp(t2.convert(p1), (t2.convert(p2))) == 1)
end
function t2.meeq(p1, p2) --[[ meeq | Line: 465 | Upvalues: t2 (copy) ]]
	return not (t2.cmp(t2.convert(p1), (t2.convert(p2))) == -1)
end
function t2.recip(p1) --[[ recip | Line: 471 | Upvalues: t2 (copy), v3 (copy) ]]
	local v1 = t2.convert(p1)

	if v1.Exp == 0 then
		return v3
	end

	if v1.Layer == 0 then
		return t2.new(v1.Sign, 0, 1 / v1.Exp)
	end

	return t2.new(v1.Sign, v1.Layer, -v1.Exp)
end
function baseLog(p1, p2) --[[ baseLog | Line: 484 | Upvalues: t2 (copy), v3 (copy) ]]
	local v1 = t2.convert(p1)
	local v2 = t2.convert(p2)

	if v1.Sign <= 0 or v2.Sign <= 0 then
		return v3
	end

	if t2.IsNaN(v2) or t2.IsNaN(v1) then
		return v3
	end

	if v1.Layer == 0 and v2.Layer == 0 then
		local v4 = math.log(v1.Exp)

		return t2.new(v1.Sign, 0, v4 / math.log(v2.Exp))
	end

	return t2.div(t2.log10(v1), t2.log10(v2))
end
function t2.log(p1, p2) --[[ log | Line: 503 | Upvalues: t2 (copy), v3 (copy) ]]
	if p2 then
		return baseLog(p1, p2)
	end

	local v1 = t2.convert(p1)

	if v1.Sign <= 0 then
		return v3
	end

	if v1.Layer == 0 then
		return t2.new(v1.Sign, 0, math.log10(v1.Exp) * 2.302585092994046)
	end

	if v1.Layer == 1 then
		return t2.new(math.sign(v1.Exp), 0, math.abs(v1.Exp) * 2.302585092994046)
	end

	if v1.Layer == 2 then
		return t2.new(math.sign(v1.Exp), 1, math.abs(v1.Exp) + 0.36221568869946325)
	end

	return t2.new(math.sign(v1.Exp), v1.Layer - 1, (math.abs(v1.Exp)))
end
function t2.log10(p1) --[[ log10 | Line: 529 | Upvalues: t2 (copy), v3 (copy) ]]
	local v1 = t2.convert(p1)

	if v1.Sign <= 0 then
		return v3
	end

	if v1.Layer > 0 then
		return t2.new(math.sign(v1.Exp), v1.Layer - 1, (math.abs(v1.Exp)))
	end

	return t2.new(v1.Sign, 0, (math.log10(v1.Exp)))
end
function t2.exp(p1) --[[ exp | Line: 543 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	if v1.Layer == 0 and v1.Exp <= 709.7 then
		return t2.fromNumber((math.exp(v1.Sign * v1.Exp)))
	end

	local v3 = v1

	if v3.Layer == 0 then
		return t2.new(1, 1, v3.Sign * 0.4342944819032518 * v3.Exp)
	end

	if v3.Layer == 1 then
		return t2.new(1, 2, v3.Sign * (-0.36221568869946325 + v3.Exp))
	end

	return t2.new(1, v3.Layer + 1, v3.Sign * v3.Exp)
end
function t2.add(p1, p2) --[[ add | Line: 557 | Upvalues: t2 (copy), v4 (copy), v1 (copy) ]]
	local v12 = t2.convert(p1)
	local v2 = t2.convert(p2)

	if t2.IsInf(v12) or t2.IsInf(v2) then
		return v4
	end

	if t2.IsZero(v12) then
		return v2
	end

	if t2.IsZero(v2) then
		return v12
	end

	if v12.Sign == -v2.Sign and (v12.Layer == v2.Layer and v12.Exp == v2.Exp) then
		return v1
	end

	local v3, v42 = v12, v2

	if v3.Layer >= 2 or v42.Layer >= 2 then
		return t2.maxAbs(v3, v42)
	end

	local v5, v6

	if t2.cmpAbs(v3, v42) > 0 then
		v5 = v3
		v6 = v42
	else
		v5 = v42
		v6 = v3
	end

	if v5.Layer == 0 and v6.Layer == 0 then
		return t2.fromNumber(v5.Sign * v5.Exp + v6.Sign * v6.Exp)
	end

	local v7 = v5.Layer * math.sign(v5.Exp)
	local v8 = v6.Layer * math.sign(v6.Exp)

	if v7 - v8 >= 2 then
		return v5
	end

	if v7 == 0 and v8 == -1 then
		if math.abs(v6.Exp - math.log10(v5.Exp)) > 100 then
			return v5
		end

		local v11 = v6.Sign + v5.Sign * 10 ^ (math.log10(v5.Exp) - v6.Exp)

		return t2.new(math.sign(v11), 1, v6.Exp + math.log10((math.abs(v11))))
	end

	if v7 == 1 and v8 == 0 then
		if math.abs(v5.Exp - math.log10(v6.Exp)) > 100 then
			return v5
		end

		local v17 = v6.Sign + v5.Sign * 10 ^ (v5.Exp - math.log10(v6.Exp))
		local v19 = math.sign(v17)
		local v20 = math.log10(v6.Exp)

		return t2.new(v19, 1, v20 + math.log10((math.abs(v17))))
	end

	if math.abs(v5.Exp - v6.Exp) > 100 then
		return v5
	end

	local v24 = v6.Sign + v5.Sign * 10 ^ (v5.Exp - v6.Exp)

	return t2.new(math.sign(v24), 1, v6.Exp + math.log10((math.abs(v24))))
end
function t2.sub(p1, p2) --[[ sub | Line: 627 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	return t2.add(v1, t2.neg((t2.convert(p2))))
end
function t2.toScientific(p1) --[[ toScientific | Line: 633 | Upvalues: t2 (copy) ]]
	if p1.Layer > 2 then
		return ""
	end

	if p1.Layer == 2 and p1.Exp > 308 then
		return "Inf"
	end

	if t2.IsZero(p1) then
		return "0e0"
	end

	if p1.Layer == 0 then
		local v2 = p1.Exp / 10 ^ math.floor((math.log10(p1.Exp))) * p1.Sign

		return v2 .. "e" .. math.floor((math.log10(p1.Exp)))
	end

	if p1.Layer == 1 then
		local v4 = 10 ^ (p1.Exp - math.floor(p1.Exp)) * p1.Sign

		return v4 .. "e" .. math.floor(p1.Exp)
	end

	local v5 = 10 ^ p1.Exp

	return 10 ^ (v5 - math.floor(v5)) * p1.Sign .. "e" .. math.floor(v5)
end
function t2.mul(p1, p2) --[[ mul | Line: 660 | Upvalues: t2 (copy), v4 (copy), v1 (copy), v3 (copy) ]]
	local v12 = t2.convert(p1)
	local v2 = t2.convert(p2)

	if t2.IsInf(v12) or t2.IsInf(v2) then
		return v4
	end

	if t2.IsZero(v12) or t2.IsZero(v2) then
		return v1
	end

	if v12.Layer == v2.Layer and v12.Exp == -v2.Exp then
		return t2.new(v12.Sign * v2.Sign, 0, 1)
	end

	local v32, v42 = v12, v2
	local v5, v6

	if v32.Layer > v42.Layer then
		v5 = v32
		v6 = v42
	elseif v32.Layer == v42.Layer then
		local v7 = math.abs(v32.Exp)

		if math.abs(v42.Exp) < v7 then
			v5 = v32
			v6 = v42
		else
			v5 = v42
			v6 = v32
		end
	else
		v5 = v42
		v6 = v32
	end

	if v5.Layer == 0 and v6.Layer == 0 then
		return t2.fromNumber(v5.Sign * v6.Sign * v5.Exp * v6.Exp)
	end

	if v5.Layer >= 3 or v5.Layer - v6.Layer >= 2 then
		return t2.new(v5.Sign * v6.Sign, v5.Layer, v5.Exp)
	end

	if v5.Layer == 1 and v6.Layer == 0 then
		return t2.new(v5.Sign * v6.Sign, 1, v5.Exp + math.log10(v6.Exp))
	end

	if v5.Layer == 1 and v6.Layer == 1 then
		return t2.new(v5.Sign * v6.Sign, 1, v5.Exp + v6.Exp)
	end

	if (v5.Layer ~= 2 or v6.Layer ~= 1) and (v5.Layer ~= 2 or v6.Layer ~= 2) then
		return v3
	end

	local v13 = t2.new(math.sign(v6.Exp), v6.Layer - 1, (math.abs(v6.Exp)))
	local v17 = t2.add(t2.new(math.sign(v5.Exp), v5.Layer - 1, (math.abs(v5.Exp))), v13)

	return t2.new(v5.Sign * v6.Sign, v17.Layer + 1, v17.Sign * v17.Exp)
end
function t2.div(p1, p2) --[[ div | Line: 708 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	return t2.mul(v1, t2.recip((t2.convert(p2))))
end
function t2.abslog10(p1) --[[ abslog10 | Line: 714 | Upvalues: t2 (copy), v3 (copy) ]]
	local v1 = t2.convert(p1)

	if t2.IsZero(v1) then
		return v3
	end

	if v1.Layer > 0 then
		return t2.new(math.sign(v1.Exp), v1.Layer - 1, (math.abs(v1.Exp)))
	end

	return t2.new(1, 0, (math.log10((math.abs(v1.Exp)))))
end
function t2.pow10(p1) --[[ pow10 | Line: 727 | Upvalues: t2 (copy), v4 (copy), v2 (copy) ]]
	local v1 = t2.convert(p1)

	if t2.IsInf(v1) then
		return v4
	end

	local v22

	if v1.Layer == 0 then
		local v3 = 10 ^ (v1.Sign * v1.Exp)

		if v3 < (1 / 0) and math.abs(v3) > 0.1 then
			return t2.new(1, 0, v3)
		end

		if v1.Sign == 0 then
			return v2
		end

		v22 = t2.new(v1.Sign, v1.Layer + 1, (math.log10(v1.Exp)))
	else
		v22 = v1
	end

	if v22.Sign > 0 and v22.Exp > 0 then
		return t2.new(v22.Sign, v22.Layer + 1, v22.Exp)
	end

	if v22.Sign < 0 and v22.Exp > 0 then
		return t2.new(-v22.Sign, v22.Layer + 1, -v22.Exp)
	end

	return v2
end
function t2.pow(p1, p2) --[[ pow | Line: 755 | Upvalues: t2 (copy), v1 (copy), v2 (copy) ]]
	local v12 = t2.convert(p1)
	local v22 = t2.convert(p2)

	if t2.IsZero(v12) then
		return v1
	end

	if v12.Sign == 1 and (v12.Layer == 0 and v12.Exp == 1) then
		return v2
	end

	local v3 = v12

	if t2.IsZero(v22) then
		return v2
	end

	if v22.Sign == 1 and (v22.Layer == 0 and v22.Exp == 1) then
		return v3
	end

	local v4 = v22
	local v5 = t2.pow10(t2.mul(t2.abslog10(v3), v4))

	if v3.Sign == -1 and t2.toNumber(v4) % 2 == 1 then
		return t2.neg(v5)
	end

	if v3.Sign == -1 and t2.toNumber(v4) < 1e20 then
		return t2.mul(v5, (t2.fromNumber((math.cos(t2.toNumber(v4) * math.pi)))))
	end

	return v5
end

local t3 = { "k", "M", "B" }
local t4 = {
	"",
	"U",
	"D",
	"T",
	"Qd",
	"Qn",
	"Sx",
	"Sp",
	"Oc",
	"No"
}
local t5 = {
	"",
	"De",
	"Vt",
	"Tg",
	"qg",
	"Qg",
	"sg",
	"Sg",
	"Og",
	"Ng"
}
local t6 = {
	"",
	"Ce",
	"Du",
	"Tr",
	"Qa",
	"Qi",
	"Se",
	"Si",
	"Ot",
	"Ni"
}
local t7 = {
	"",
	"Mi",
	"Mc",
	"Na",
	"Pi",
	"Fm",
	"At",
	"Zp",
	"Yc",
	"Xo",
	"Ve",
	"Me",
	"Due",
	"Tre",
	"Te",
	"Pt",
	"He",
	"Hp",
	"Oct",
	"En",
	"Ic",
	"Mei",
	"Dui",
	"Tri",
	"Teti",
	"Pti",
	"Hei",
	"Hp",
	"Oci",
	"Eni",
	"Tra",
	"TeC",
	"MTc",
	"DTc",
	"TrTc",
	"TeTc",
	"PeTc",
	"HTc",
	"HpT",
	"OcT",
	"EnT",
	"TetC",
	"MTetc",
	"DTetc",
	"TrTetc",
	"TeTetc",
	"PeTetc",
	"HTetc",
	"HpTetc",
	"OcTetc",
	"EnTetc",
	"PcT",
	"MPcT",
	"DPcT",
	"TPCt",
	"TePCt",
	"PePCt",
	"HePCt",
	"HpPct",
	"OcPct",
	"EnPct",
	"HCt",
	"MHcT",
	"DHcT",
	"THCt",
	"TeHCt",
	"PeHCt",
	"HeHCt",
	"HpHct",
	"OcHct",
	"EnHct",
	"HpCt",
	"MHpcT",
	"DHpcT",
	"THpCt",
	"TeHpCt",
	"PeHpCt",
	"HeHpCt",
	"HpHpct",
	"OcHpct",
	"EnHpct",
	"OCt",
	"MOcT",
	"DOcT",
	"TOCt",
	"TeOCt",
	"PeOCt",
	"HeOCt",
	"HpOct",
	"OcOct",
	"EnOct",
	"Ent",
	"MEnT",
	"DEnT",
	"TEnt",
	"TeEnt",
	"PeEnt",
	"HeEnt",
	"HpEnt",
	"OcEnt",
	"EnEnt",
	"Hect",
	"MeHect"
}

function CutDigits(p1, p2) --[[ CutDigits | Line: 895 ]]
	if p2 < 0 then
		return p1
	end

	return math.floor(p1 * 10 ^ p2) / 10 ^ p2
end
function t2.toSuffix(p1, p2) --[[ toSuffix | Line: 902 | Upvalues: t2 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
	local v1 = p2 or 2
	local v2 = t2.toScientific(p1):split("e")
	local v3 = v2[1]
	local v4 = v2[2]
	local v5 = math.fmod(v4, 3)
	local v6 = math.floor(v4 / 3) - 1

	if v6 <= -1 then
		return CutDigits(v2[1] * 10 ^ v2[2], v1)
	end

	if v6 < 3 then
		return CutDigits(v3 * 10 ^ v5, v1) .. t3[v6 + 1]
	end

	local v7 = ""

	local function SuffixPartOne(p1) --[[ SuffixPartOne | Line: 920 | Upvalues: v7 (ref), t4 (ref), t5 (ref), t6 (ref) ]]
		local v1 = math.floor(p1 / 100)
		local v2 = math.fmod(p1, 100)
		local v3 = math.floor(v2 / 10)

		v7 = v7 .. t4[math.floor(math.fmod(v2, 10) / 1) + 1]
		v7 = v7 .. t5[v3 + 1]
		v7 = v7 .. t6[v1 + 1]
	end

	local function SuffixPartTwo(p1) --[[ SuffixPartTwo | Line: 932 | Upvalues: v7 (ref), t4 (ref), t5 (ref), t6 (ref) ]]
		if p1 > 0 then
			p1 = p1 + 1
		end

		if p1 > 1000 then
			p1 = math.fmod(p1, 1000)
		end

		local v2 = math.floor(p1 / 100)
		local v3 = math.fmod(p1, 100)
		local v4 = math.floor(v3 / 10)

		v7 = v7 .. t4[math.floor(math.fmod(v3, 10) / 1) + 1]
		v7 = v7 .. t5[v4 + 1]
		v7 = v7 .. t6[v2 + 1]
	end

	if v6 < 1000 then
		local v8 = math.floor(v6 / 100)
		local v9 = math.fmod(v6, 100)
		local v10 = math.floor(v9 / 10)

		v7 = v7 .. t4[math.floor(math.fmod(v9, 10) / 1) + 1]
		v7 = v7 .. t5[v10 + 1]
		v7 = v7 .. t6[v8 + 1]

		return CutDigits(v3 * 10 ^ v5, v1) .. v7
	end

	for i = math.floor(math.log10(v6) / 3), 0, -1 do
		if 10 ^ (i * 3) <= v6 then
			local count = math.floor(v6 / 10 ^ (i * 3)) - 1

			if count > 0 then
				count = count + 1
			end

			if count > 1000 then
				count = math.fmod(count, 1000)
			end

			local v14 = math.floor(count / 100)
			local v15 = math.fmod(count, 100)
			local v16 = math.floor(v15 / 10)

			v7 = v7 .. t4[math.floor(math.fmod(v15, 10) / 1) + 1]
			v7 = v7 .. t5[v16 + 1]
			v7 = v7 .. t6[v14 + 1]
			v7 = v7 .. t7[i + 1]
			v6 = math.fmod(v6, 10 ^ (i * 3))
		end
	end

	return CutDigits(v3 * 10 ^ v5, v1) .. v7
end
function t2.between(p1, p2, p3) --[[ between | Line: 958 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)
	local v2 = t2.convert(p2)
	local v3 = t2.convert(p3)

	return t2.me(v1, v2) and t2.le(v1, v3)
end
function t2.toLayerNotation(p1, p2) --[[ toLayerNotation | Line: 965 | Upvalues: t2 (copy), v1 (copy), v2 (copy) ]]
	local v12 = t2.convert(p1)
	local v22 = p2 or 2

	if t2.between(v12, v1, v2) then
		return "1 / " .. t2.short(t2.div(v2, v12))
	end

	if v12.Sign == 1 then
		if v12.Exp < 0 then
			local v3 = CutDigits

			return "E(" .. v12.Layer .. "-" .. ")" .. v3(math.abs(v12.Exp), v22)
		end

		return "E(" .. v12.Layer .. ")" .. CutDigits(v12.Exp, v22)
	end

	if v12.Sign == 0 then
		return "E(0)0"
	end

	return t2.toLayerNotation(t2.abs(v12), v22)
end
function t2.short(p1, p2) --[[ short | Line: 988 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	if t2.le(v1, "9e1E14") then
		return t2.toSuffix(v1, p2)
	end

	return t2.toLayerNotation(v1, p2)
end
function t2.root(p1, p2) --[[ root | Line: 996 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	return t2.pow(v1, t2.recip((t2.convert(p2))))
end
function t2.sqrt(p1) --[[ sqrt | Line: 1002 | Upvalues: t2 (copy) ]]
	return t2.root(t2.convert(p1), 2)
end
function t2.gamma(p1) --[[ gamma | Line: 1007 | Upvalues: t2 (copy), v1 (copy), v3 (copy) ]]
	local v12 = t2.convert(p1)

	if t2.leeq(v12, v1) then
		return v3
	end

	if v12.Exp < 0 then
		return t2.recip(v12)
	end

	if v12.Layer == 0 then
		if t2.le(v12, { 1, 0, 24 }) then
			return t2.fromNumber(F_Gamma(v12.Sign * v12.Exp))
		end

		local v2 = v12.Exp - 1
		local v32 = 0.9189385332046727 + (v2 + 0.5) * math.log(v2) - v2
		local v4 = v2 * v2
		local v5 = v32 + 1 / (12 * v2)

		if v5 == v32 then
			return t2.exp(v32)
		end

		local v6 = v2 * v4
		local v7 = v5 - 1 / (360 * v6)

		if v7 == v5 then
			return t2.exp(v5)
		end

		local v8 = v6 * v4

		return t2.exp(v7 + 1 / (1260 * v8) - 1 / (1680 * (v8 * v4)))
	end

	if v12.Layer == 1 then
		return t2.exp(t2.mul(v12, t2.sub(t2.log(v12), 1)))
	end

	return t2.exp(v12)
end
function t2.fact(p1) --[[ fact | Line: 1064 | Upvalues: t2 (copy) ]]
	return t2.gamma(t2.add(t2.convert(p1), 1))
end
function t2.rand(p1, p2) --[[ rand | Line: 1069 | Upvalues: t2 (copy) ]]
	local v1 = math.random()

	return t2.add(t2.mul(t2.sub(p2, p1), v1), p1)
end
function t2.exporand(p1, p2) --[[ exporand | Line: 1076 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)
	local v2 = t2.convert(p2)

	return t2.exp(t2.rand(t2.mul(t2.exp(t2.abs(v1)), v1.Sign), (t2.mul(t2.exp(t2.abs(v2)), v2.Sign))))
end
function t2.lbencode(p1) --[[ lbencode | Line: 1084 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	if t2.eq(v1, 1) then
		return 1
	end

	local v2 = 0
	local v3, sum, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27

	if v1.Sign == -1 and v1.Layer > 9999 then
		if math.sign(v1.Exp) == 1 then
			v2 = 0
			v3 = v1
			sum = v2 * 1e18

			if v2 == 8 then
				v4 = v3.Layer
				v5 = v3.Exp
				v6 = v4 + math.log10(v5) / 10

				return sum + math.log10(v6) * 3244067411720800
			end

			if v2 == 7 then
				v7 = sum + v3.Layer * 100000000000000
				v8 = v3.Exp

				return v7 + math.log10(v8) * 10000000000000
			end

			if v2 == 6 then
				v9 = v3.Layer
				v10 = v3.Exp
				v11 = math.abs(v10)
				v12 = v9 + math.log10(v11) / 10

				return sum + 1e18 - math.log10(v12) * 3244067411720800
			end

			if v2 == 5 then
				v13 = sum + (v3.Layer * 100000000000000 + 100000000000000)
				v14 = v3.Exp
				v15 = math.abs(v14)

				return v13 - math.log10(v15) * 10000000000000
			end

			if v2 == 3 then
				v16 = sum + (v3.Layer * 100000000000000 + 100000000000000)
				v17 = v3.Exp
				v18 = math.abs(v17)

				return v16 - math.log10(v18) * 10000000000000 + 1e18
			end

			if v2 == 2 then
				v19 = v3.Layer
				v20 = v3.Exp
				v21 = math.abs(v20)
				v22 = v19 + math.log10(v21) / 10

				return sum + 1e18 - math.log10(v22) * 3244067411720800 + 1e18
			end

			if v2 == 1 then
				v23 = sum + v3.Layer * 100000000000000
				v24 = v3.Exp

				return v23 + math.log10(v24) * 10000000000000 + 1e18
			end

			if v2 == 0 then
				v25 = v3.Layer
				v26 = v3.Exp
				v27 = v25 + math.log10(v26) / 10
				sum = sum + (1e18 - math.log10(v27) * 3244067411720800)
			end

			return sum
		end

		v3 = v1
	else
		v3 = v1
	end

	if v3.Sign == -1 and v3.Layer < 9999 and math.sign(v3.Exp) == 1 then
		v2 = 1
		sum = v2 * 1e18

		if v2 == 8 then
			v4 = v3.Layer
			v5 = v3.Exp
			v6 = v4 + math.log10(v5) / 10

			return sum + math.log10(v6) * 3244067411720800
		end

		if v2 == 7 then
			v7 = sum + v3.Layer * 100000000000000
			v8 = v3.Exp

			return v7 + math.log10(v8) * 10000000000000
		end

		if v2 == 6 then
			v9 = v3.Layer
			v10 = v3.Exp
			v11 = math.abs(v10)
			v12 = v9 + math.log10(v11) / 10

			return sum + 1e18 - math.log10(v12) * 3244067411720800
		end

		if v2 == 5 then
			v13 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v14 = v3.Exp
			v15 = math.abs(v14)

			return v13 - math.log10(v15) * 10000000000000
		end

		if v2 == 3 then
			v16 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v17 = v3.Exp
			v18 = math.abs(v17)

			return v16 - math.log10(v18) * 10000000000000 + 1e18
		end

		if v2 == 2 then
			v19 = v3.Layer
			v20 = v3.Exp
			v21 = math.abs(v20)
			v22 = v19 + math.log10(v21) / 10

			return sum + 1e18 - math.log10(v22) * 3244067411720800 + 1e18
		end

		if v2 == 1 then
			v23 = sum + v3.Layer * 100000000000000
			v24 = v3.Exp

			return v23 + math.log10(v24) * 10000000000000 + 1e18
		end

		if v2 == 0 then
			v25 = v3.Layer
			v26 = v3.Exp
			v27 = v25 + math.log10(v26) / 10
			sum = sum + (1e18 - math.log10(v27) * 3244067411720800)
		end

		return sum
	end

	if v3.Sign == -1 and v3.Layer > 9999 and math.sign(v3.Exp) == -1 then
		v2 = 2
		sum = v2 * 1e18

		if v2 == 8 then
			v4 = v3.Layer
			v5 = v3.Exp
			v6 = v4 + math.log10(v5) / 10

			return sum + math.log10(v6) * 3244067411720800
		end

		if v2 == 7 then
			v7 = sum + v3.Layer * 100000000000000
			v8 = v3.Exp

			return v7 + math.log10(v8) * 10000000000000
		end

		if v2 == 6 then
			v9 = v3.Layer
			v10 = v3.Exp
			v11 = math.abs(v10)
			v12 = v9 + math.log10(v11) / 10

			return sum + 1e18 - math.log10(v12) * 3244067411720800
		end

		if v2 == 5 then
			v13 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v14 = v3.Exp
			v15 = math.abs(v14)

			return v13 - math.log10(v15) * 10000000000000
		end

		if v2 == 3 then
			v16 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v17 = v3.Exp
			v18 = math.abs(v17)

			return v16 - math.log10(v18) * 10000000000000 + 1e18
		end

		if v2 == 2 then
			v19 = v3.Layer
			v20 = v3.Exp
			v21 = math.abs(v20)
			v22 = v19 + math.log10(v21) / 10

			return sum + 1e18 - math.log10(v22) * 3244067411720800 + 1e18
		end

		if v2 == 1 then
			v23 = sum + v3.Layer * 100000000000000
			v24 = v3.Exp

			return v23 + math.log10(v24) * 10000000000000 + 1e18
		end

		if v2 == 0 then
			v25 = v3.Layer
			v26 = v3.Exp
			v27 = v25 + math.log10(v26) / 10
			sum = sum + (1e18 - math.log10(v27) * 3244067411720800)
		end

		return sum
	end

	if v3.Sign == -1 and v3.Layer < 9999 and math.sign(v3.Exp) == -1 then
		v2 = 3
		sum = v2 * 1e18

		if v2 == 8 then
			v4 = v3.Layer
			v5 = v3.Exp
			v6 = v4 + math.log10(v5) / 10

			return sum + math.log10(v6) * 3244067411720800
		end

		if v2 == 7 then
			v7 = sum + v3.Layer * 100000000000000
			v8 = v3.Exp

			return v7 + math.log10(v8) * 10000000000000
		end

		if v2 == 6 then
			v9 = v3.Layer
			v10 = v3.Exp
			v11 = math.abs(v10)
			v12 = v9 + math.log10(v11) / 10

			return sum + 1e18 - math.log10(v12) * 3244067411720800
		end

		if v2 == 5 then
			v13 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v14 = v3.Exp
			v15 = math.abs(v14)

			return v13 - math.log10(v15) * 10000000000000
		end

		if v2 == 3 then
			v16 = sum + (v3.Layer * 100000000000000 + 100000000000000)
			v17 = v3.Exp
			v18 = math.abs(v17)

			return v16 - math.log10(v18) * 10000000000000 + 1e18
		end

		if v2 == 2 then
			v19 = v3.Layer
			v20 = v3.Exp
			v21 = math.abs(v20)
			v22 = v19 + math.log10(v21) / 10

			return sum + 1e18 - math.log10(v22) * 3244067411720800 + 1e18
		end

		if v2 == 1 then
			v23 = sum + v3.Layer * 100000000000000
			v24 = v3.Exp

			return v23 + math.log10(v24) * 10000000000000 + 1e18
		end

		if v2 == 0 then
			v25 = v3.Layer
			v26 = v3.Exp
			v27 = v25 + math.log10(v26) / 10
			sum = sum + (1e18 - math.log10(v27) * 3244067411720800)
		end

		return sum
	end

	if v3.Sign == 0 then
		return 4e18
	end

	if v3.Sign == 1 and v3.Layer < 9999 and math.sign(v3.Exp) == -1 then
		v2 = 5
	else
		local v28, v29, v30

		if v3.Sign == 1 and v3.Layer > 9999 then
			v28 = v3.Exp

			if math.sign(v28) == -1 then
				v2 = 6
			elseif v3.Sign == 1 and v3.Layer < 9999 then
				v29 = v3.Exp

				if math.sign(v29) == 1 then
					v2 = 7
				elseif v3.Sign == 1 and v3.Layer > 9999 then
					v30 = v3.Exp

					if math.sign(v30) == 1 then
						v2 = 8
					end
				end
			elseif v3.Sign == 1 and v3.Layer > 9999 then
				v30 = v3.Exp

				if math.sign(v30) == 1 then
					v2 = 8
				end
			end
		elseif v3.Sign == 1 and v3.Layer < 9999 then
			v29 = v3.Exp

			if math.sign(v29) == 1 then
				v2 = 7
			elseif v3.Sign == 1 and v3.Layer > 9999 then
				v30 = v3.Exp

				if math.sign(v30) == 1 then
					v2 = 8
				end
			end
		elseif v3.Sign == 1 and v3.Layer > 9999 then
			v30 = v3.Exp

			if math.sign(v30) == 1 then
				v2 = 8
			end
		end
	end

	sum = v2 * 1e18

	if v2 == 8 then
		v4 = v3.Layer
		v5 = v3.Exp
		v6 = v4 + math.log10(v5) / 10

		return sum + math.log10(v6) * 3244067411720800
	end

	if v2 == 7 then
		v7 = sum + v3.Layer * 100000000000000
		v8 = v3.Exp

		return v7 + math.log10(v8) * 10000000000000
	end

	if v2 == 6 then
		v9 = v3.Layer
		v10 = v3.Exp
		v11 = math.abs(v10)
		v12 = v9 + math.log10(v11) / 10

		return sum + 1e18 - math.log10(v12) * 3244067411720800
	end

	if v2 == 5 then
		v13 = sum + (v3.Layer * 100000000000000 + 100000000000000)
		v14 = v3.Exp
		v15 = math.abs(v14)

		return v13 - math.log10(v15) * 10000000000000
	end

	if v2 == 3 then
		v16 = sum + (v3.Layer * 100000000000000 + 100000000000000)
		v17 = v3.Exp
		v18 = math.abs(v17)

		return v16 - math.log10(v18) * 10000000000000 + 1e18
	end

	if v2 == 2 then
		v19 = v3.Layer
		v20 = v3.Exp
		v21 = math.abs(v20)
		v22 = v19 + math.log10(v21) / 10

		return sum + 1e18 - math.log10(v22) * 3244067411720800 + 1e18
	end

	if v2 == 1 then
		v23 = sum + v3.Layer * 100000000000000
		v24 = v3.Exp

		return v23 + math.log10(v24) * 10000000000000 + 1e18
	end

	if v2 == 0 then
		v25 = v3.Layer
		v26 = v3.Exp
		v27 = v25 + math.log10(v26) / 10
		sum = sum + (1e18 - math.log10(v27) * 3244067411720800)
	end

	return sum
end
function t2.lbdecode(p1) --[[ lbdecode | Line: 1149 | Upvalues: t2 (copy), v2 (copy), v1 (copy), v3 (copy) ]]
	if p1 == 2e18 then
		return t2.new(-1, 0, 1)
	end

	if p1 == 3e18 then
		return t2.new(-1, 10000, -1)
	end

	if p1 == 1e18 then
		return t2.new(-1, 0, -1)
	end

	if p1 == 6e18 then
		return v2
	end

	if p1 == 7e18 then
		return t2.new(1, 10000, 1)
	end

	if p1 == 5e18 then
		return t2.new(1, 10000, -1)
	end

	if p1 == 1 then
		return v2
	end

	local v12 = math.floor(p1 / 1e18)

	if v12 == 4 then
		return v1
	end

	if v12 == 0 then
		local v22 = 10 ^ ((1e18 - p1) / 3244067411720800)
		local v32 = math.floor(v22)

		return t2.new(-1, v32, 10 ^ (math.fmod(v22, 1) * 10))
	end

	if v12 == 8 then
		local v5 = 10 ^ ((p1 - 8e18) / 3244067411720800)
		local v6 = math.floor(v5)

		return t2.new(1, v6, 10 ^ (math.fmod(v5, 1) * 10))
	end

	if v12 == 1 then
		local v8 = 1e18 - (p1 - 1e18)
		local v9 = math.floor(v8 / 100000000000000)

		return t2.new(-1, v9, 10 ^ (math.fmod(v8, 100000000000000) / 10000000000000))
	end

	if v12 == 7 then
		local v11 = p1 - 7e18
		local v122 = math.floor(v11 / 100000000000000)

		return t2.new(1, v122, 10 ^ (math.fmod(v11, 100000000000000) / 10000000000000))
	end

	if v12 == 2 then
		local v14 = 10 ^ ((p1 - 2e18) / 3244067411720800)
		local v15 = math.floor(v14)

		return t2.new(-1, v15, -10 ^ (math.fmod(v14, 1) * 10))
	end

	if v12 == 6 then
		local v17 = 10 ^ ((1e18 - (p1 - 6e18)) / 3244067411720800)
		local v18 = math.floor(v17)

		return t2.new(1, v18, -10 ^ (math.fmod(v17, 1) * 10))
	end

	if v12 == 5 then
		local v20 = p1 - 5e18
		local v21 = math.floor(v20 / 100000000000000)

		return t2.new(1, v21, -10 ^ ((100000000000000 - math.fmod(v20, 100000000000000)) / 10000000000000))
	end

	if v12 == 3 then
		local v23 = 1e18 - (p1 - 3e18)
		local v24 = math.floor(v23 / 100000000000000)

		return t2.new(-1, v24, -10 ^ ((100000000000000 - math.fmod(v23, 100000000000000)) / 10000000000000))
	end

	return v3
end
function t2.shift(p1, p2) --[[ shift | Line: 1228 | Upvalues: t2 (copy) ]]
	local v1 = t2.convert(p1)

	if v1.Layer > 1 then
		return v1
	end

	if not (p2 > 20) then
		local _ = 10 ^ (v1.Exp - math.floor(v1.Exp))
		local v2 = math.floor(p2 * 10 ^ p2) / 10 ^ p2

		v1.Exp = math.floor(v1.Exp) + math.log10(v2)
	end

	return v1
end

return t2