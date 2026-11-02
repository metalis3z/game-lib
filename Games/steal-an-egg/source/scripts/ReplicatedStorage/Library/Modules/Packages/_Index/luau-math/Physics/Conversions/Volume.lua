-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toMilliliter = function(p1) --[[ toMilliliter | Line: 54 ]]
		return p1 * 1000
	end,
	toKiloliter = function(p1) --[[ toKiloliter | Line: 57 ]]
		return p1 * 0.001
	end,
	toCup = function(p1) --[[ toCup | Line: 60 ]]
		return p1 * 4.16667
	end,
	toPint = function(p1) --[[ toPint | Line: 63 ]]
		return p1 * 2.11338
	end,
	toQuart = function(p1) --[[ toQuart | Line: 66 ]]
		return p1 * 1.05669
	end,
	toGallon = function(p1) --[[ toGallon | Line: 69 ]]
		return p1 * 0.264172
	end,
	toCubicFeet = function(p1) --[[ toCubicFeet | Line: 72 ]]
		return p1 * 0.0353147
	end,
	toCubicInch = function(p1) --[[ toCubicInch | Line: 75 ]]
		return p1 * 61.0237
	end,
	toCubicMeter = function(p1) --[[ toCubicMeter | Line: 78 ]]
		return p1 * 0.001
	end
}
local t2 = {
	toLiter = function(p1) --[[ toLiter | Line: 83 ]]
		return p1 / 1000
	end
}

function t2.toKiloliter(p1) --[[ toKiloliter | Line: 86 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKiloliter(t2.toLiter(p1))
end
function t2.toCup(p1) --[[ toCup | Line: 89 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCup(t2.toLiter(p1))
end
function t2.toPint(p1) --[[ toPint | Line: 92 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPint(t2.toLiter(p1))
end
function t2.toQuart(p1) --[[ toQuart | Line: 95 | Upvalues: t (copy), t2 (copy) ]]
	return t.toQuart(t2.toLiter(p1))
end
function t2.toGallon(p1) --[[ toGallon | Line: 98 | Upvalues: t (copy), t2 (copy) ]]
	return t.toGallon(t2.toLiter(p1))
end
function t2.toCubicFeet(p1) --[[ toCubicFeet | Line: 101 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCubicFeet(t2.toLiter(p1))
end
function t2.toCubicInch(p1) --[[ toCubicInch | Line: 104 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCubicInch(t2.toLiter(p1))
end
function t2.toCubicMeter(p1) --[[ toCubicMeter | Line: 107 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCubicMeter(t2.toLiter(p1))
end

local t3 = {
	toLiter = function(p1) --[[ toLiter | Line: 112 ]]
		return p1 / 0.001
	end
}

function t3.toMilliliter(p1) --[[ toMilliliter | Line: 115 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMilliliter(t3.toLiter(p1))
end
function t3.toCup(p1) --[[ toCup | Line: 118 | Upvalues: t (copy), t3 (copy) ]]
	return t.toCup(t3.toLiter(p1))
end
function t3.toPint(p1) --[[ toPint | Line: 121 | Upvalues: t (copy), t3 (copy) ]]
	return t.toPint(t3.toLiter(p1))
end
function t3.toQuart(p1) --[[ toQuart | Line: 124 | Upvalues: t (copy), t3 (copy) ]]
	return t.toQuart(t3.toLiter(p1))
end
function t3.toGallon(p1) --[[ toGallon | Line: 127 | Upvalues: t (copy), t3 (copy) ]]
	return t.toGallon(t3.toLiter(p1))
end
function t3.toCubicFeet(p1) --[[ toCubicFeet | Line: 130 | Upvalues: t (copy), t3 (copy) ]]
	return t.toCubicFeet(t3.toLiter(p1))
end
function t3.toCubicInch(p1) --[[ toCubicInch | Line: 133 | Upvalues: t (copy), t3 (copy) ]]
	return t.toCubicInch(t3.toLiter(p1))
end
function t3.toCubicMeter(p1) --[[ toCubicMeter | Line: 136 | Upvalues: t (copy), t3 (copy) ]]
	return t.toCubicMeter(t3.toLiter(p1))
end

local t4 = {
	toLiter = function(p1) --[[ toLiter | Line: 141 ]]
		return p1 / 4.16667
	end
}

function t4.toKiloliter(p1) --[[ toKiloliter | Line: 144 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKiloliter(t4.toLiter(p1))
end
function t4.toMilliliter(p1) --[[ toMilliliter | Line: 147 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMilliliter(t4.toLiter(p1))
end
function t4.toPint(p1) --[[ toPint | Line: 150 | Upvalues: t (copy), t4 (copy) ]]
	return t.toPint(t4.toLiter(p1))
end
function t4.toQuart(p1) --[[ toQuart | Line: 153 | Upvalues: t (copy), t4 (copy) ]]
	return t.toQuart(t4.toLiter(p1))
end
function t4.toGallon(p1) --[[ toGallon | Line: 156 | Upvalues: t (copy), t4 (copy) ]]
	return t.toGallon(t4.toLiter(p1))
end
function t4.toCubicFeet(p1) --[[ toCubicFeet | Line: 159 | Upvalues: t (copy), t4 (copy) ]]
	return t.toCubicFeet(t4.toLiter(p1))
end
function t4.toCubicInch(p1) --[[ toCubicInch | Line: 162 | Upvalues: t (copy), t4 (copy) ]]
	return t.toCubicInch(t4.toLiter(p1))
end
function t4.toCubicMeter(p1) --[[ toCubicMeter | Line: 165 | Upvalues: t (copy), t4 (copy) ]]
	return t.toCubicMeter(t4.toLiter(p1))
end

local t5 = {
	toLiter = function(p1) --[[ toLiter | Line: 170 ]]
		return p1 / 2.11338
	end
}

function t5.toKiloliter(p1) --[[ toKiloliter | Line: 173 | Upvalues: t (copy), t5 (copy) ]]
	return t.toKiloliter(t5.toLiter(p1))
end
function t5.toCup(p1) --[[ toCup | Line: 176 | Upvalues: t (copy), t5 (copy) ]]
	return t.toCup(t5.toLiter(p1))
end
function t5.toMilliliter(p1) --[[ toMilliliter | Line: 179 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMilliliter(t5.toLiter(p1))
end
function t5.toQuart(p1) --[[ toQuart | Line: 182 | Upvalues: t (copy), t5 (copy) ]]
	return t.toQuart(t5.toLiter(p1))
end
function t5.toGallon(p1) --[[ toGallon | Line: 185 | Upvalues: t (copy), t5 (copy) ]]
	return t.toGallon(t5.toLiter(p1))
end
function t5.toCubicFeet(p1) --[[ toCubicFeet | Line: 188 | Upvalues: t (copy), t5 (copy) ]]
	return t.toCubicFeet(t5.toLiter(p1))
end
function t5.toCubicInch(p1) --[[ toCubicInch | Line: 191 | Upvalues: t (copy), t5 (copy) ]]
	return t.toCubicInch(t5.toLiter(p1))
end
function t5.toCubicMeter(p1) --[[ toCubicMeter | Line: 194 | Upvalues: t (copy), t5 (copy) ]]
	return t.toCubicMeter(t5.toLiter(p1))
end

local t6 = {
	toLiter = function(p1) --[[ toLiter | Line: 199 ]]
		return p1 / 1.05669
	end
}

function t6.toKiloliter(p1) --[[ toKiloliter | Line: 202 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKiloliter(t6.toLiter(p1))
end
function t6.toCup(p1) --[[ toCup | Line: 205 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCup(t6.toLiter(p1))
end
function t6.toPint(p1) --[[ toPint | Line: 208 | Upvalues: t (copy), t6 (copy) ]]
	return t.toPint(t6.toLiter(p1))
end
function t6.toMilliliter(p1) --[[ toMilliliter | Line: 211 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMilliliter(t6.toLiter(p1))
end
function t6.toGallon(p1) --[[ toGallon | Line: 214 | Upvalues: t (copy), t6 (copy) ]]
	return t.toGallon(t6.toLiter(p1))
end
function t6.toCubicFeet(p1) --[[ toCubicFeet | Line: 217 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCubicFeet(t6.toLiter(p1))
end
function t6.toCubicInch(p1) --[[ toCubicInch | Line: 220 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCubicInch(t6.toLiter(p1))
end
function t6.toCubicMeter(p1) --[[ toCubicMeter | Line: 223 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCubicMeter(t6.toLiter(p1))
end

local t7 = {
	toLiter = function(p1) --[[ toLiter | Line: 228 ]]
		return p1 / 0.264172
	end
}

function t7.toKiloliter(p1) --[[ toKiloliter | Line: 231 | Upvalues: t (copy), t7 (copy) ]]
	return t.toKiloliter(t7.toLiter(p1))
end
function t7.toCup(p1) --[[ toCup | Line: 234 | Upvalues: t (copy), t7 (copy) ]]
	return t.toCup(t7.toLiter(p1))
end
function t7.toPint(p1) --[[ toPint | Line: 237 | Upvalues: t (copy), t7 (copy) ]]
	return t.toPint(t7.toLiter(p1))
end
function t7.toQuart(p1) --[[ toQuart | Line: 240 | Upvalues: t (copy), t7 (copy) ]]
	return t.toQuart(t7.toLiter(p1))
end
function t7.toMilliliter(p1) --[[ toMilliliter | Line: 243 | Upvalues: t (copy), t7 (copy) ]]
	return t.toMilliliter(t7.toLiter(p1))
end
function t7.toCubicFeet(p1) --[[ toCubicFeet | Line: 246 | Upvalues: t (copy), t7 (copy) ]]
	return t.toCubicFeet(t7.toLiter(p1))
end
function t7.toCubicInch(p1) --[[ toCubicInch | Line: 249 | Upvalues: t (copy), t7 (copy) ]]
	return t.toCubicInch(t7.toLiter(p1))
end
function t7.toCubicMeter(p1) --[[ toCubicMeter | Line: 252 | Upvalues: t (copy), t7 (copy) ]]
	return t.toCubicMeter(t7.toLiter(p1))
end

local t8 = {
	toLiter = function(p1) --[[ toLiter | Line: 257 ]]
		return p1 / 0.0353147
	end
}

function t8.toKiloliter(p1) --[[ toKiloliter | Line: 260 | Upvalues: t (copy), t8 (copy) ]]
	return t.toKiloliter(t8.toLiter(p1))
end
function t8.toCup(p1) --[[ toCup | Line: 263 | Upvalues: t (copy), t8 (copy) ]]
	return t.toCup(t8.toLiter(p1))
end
function t8.toPint(p1) --[[ toPint | Line: 266 | Upvalues: t (copy), t8 (copy) ]]
	return t.toPint(t8.toLiter(p1))
end
function t8.toQuart(p1) --[[ toQuart | Line: 269 | Upvalues: t (copy), t8 (copy) ]]
	return t.toQuart(t8.toLiter(p1))
end
function t8.toGallon(p1) --[[ toGallon | Line: 272 | Upvalues: t (copy), t8 (copy) ]]
	return t.toGallon(t8.toLiter(p1))
end
function t8.toMilliliter(p1) --[[ toMilliliter | Line: 275 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMilliliter(t8.toLiter(p1))
end
function t8.toCubicInch(p1) --[[ toCubicInch | Line: 278 | Upvalues: t (copy), t8 (copy) ]]
	return t.toCubicInch(t8.toLiter(p1))
end
function t8.toCubicMeter(p1) --[[ toCubicMeter | Line: 281 | Upvalues: t (copy), t8 (copy) ]]
	return t.toCubicMeter(t8.toLiter(p1))
end

local t9 = {
	toLiter = function(p1) --[[ toLiter | Line: 286 ]]
		return p1 / 1000
	end
}

function t9.toKiloliter(p1) --[[ toKiloliter | Line: 289 | Upvalues: t (copy), t9 (copy) ]]
	return t.toKiloliter(t9.toLiter(p1))
end
function t9.toCup(p1) --[[ toCup | Line: 292 | Upvalues: t (copy), t9 (copy) ]]
	return t.toCup(t9.toLiter(p1))
end
function t9.toPint(p1) --[[ toPint | Line: 295 | Upvalues: t (copy), t9 (copy) ]]
	return t.toPint(t9.toLiter(p1))
end
function t9.toQuart(p1) --[[ toQuart | Line: 298 | Upvalues: t (copy), t9 (copy) ]]
	return t.toQuart(t9.toLiter(p1))
end
function t9.toGallon(p1) --[[ toGallon | Line: 301 | Upvalues: t (copy), t9 (copy) ]]
	return t.toGallon(t9.toLiter(p1))
end
function t9.toCubicFeet(p1) --[[ toCubicFeet | Line: 304 | Upvalues: t (copy), t9 (copy) ]]
	return t.toCubicFeet(t9.toLiter(p1))
end
function t9.toMilliliter(p1) --[[ toMilliliter | Line: 307 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMilliliter(t9.toLiter(p1))
end
function t9.toCubicMeter(p1) --[[ toCubicMeter | Line: 310 | Upvalues: t (copy), t9 (copy) ]]
	return t.toCubicMeter(t9.toLiter(p1))
end

local t10 = {
	toLiter = function(p1) --[[ toLiter | Line: 315 ]]
		return p1 / 0.001
	end
}

function t10.toKiloliter(p1) --[[ toKiloliter | Line: 318 | Upvalues: t (copy), t10 (copy) ]]
	return t.toKiloliter(t10.toLiter(p1))
end
function t10.toCup(p1) --[[ toCup | Line: 321 | Upvalues: t (copy), t10 (copy) ]]
	return t.toCup(t10.toLiter(p1))
end
function t10.toPint(p1) --[[ toPint | Line: 324 | Upvalues: t (copy), t10 (copy) ]]
	return t.toPint(t10.toLiter(p1))
end
function t10.toQuart(p1) --[[ toQuart | Line: 327 | Upvalues: t (copy), t10 (copy) ]]
	return t.toQuart(t10.toLiter(p1))
end
function t10.toGallon(p1) --[[ toGallon | Line: 330 | Upvalues: t (copy), t10 (copy) ]]
	return t.toGallon(t10.toLiter(p1))
end
function t10.toCubicFeet(p1) --[[ toCubicFeet | Line: 333 | Upvalues: t (copy), t10 (copy) ]]
	return t.toCubicFeet(t10.toLiter(p1))
end
function t10.toCubicInch(p1) --[[ toCubicInch | Line: 336 | Upvalues: t (copy), t10 (copy) ]]
	return t.toCubicInch(t10.toLiter(p1))
end
function t10.toMilliliter(p1) --[[ toMilliliter | Line: 339 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMilliliter(t10.toLiter(p1))
end

return {
	Liter = t,
	Milliliter = t2,
	Kiloliter = t3,
	Cup = t4,
	Pint = t5,
	Quart = t6,
	Gallon = t7,
	CubicFeet = t8,
	CubicInch = t9
}