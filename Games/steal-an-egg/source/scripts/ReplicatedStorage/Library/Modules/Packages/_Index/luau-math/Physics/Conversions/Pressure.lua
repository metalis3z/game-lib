-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toAtmosphere = function(p1) --[[ toAtmosphere | Line: 40 ]]
		return p1 * 9.86923
	end,
	toKilopascal = function(p1) --[[ toKilopascal | Line: 43 ]]
		return p1 * 1000
	end,
	toPascal = function(p1) --[[ toPascal | Line: 46 ]]
		return p1 * 1000000
	end,
	toBar = function(p1) --[[ toBar | Line: 49 ]]
		return p1 * 10
	end,
	toMillibar = function(p1) --[[ toMillibar | Line: 52 ]]
		return p1 * 10000
	end,
	toPoundsPerSquareInch = function(p1) --[[ toPoundsPerSquareInch | Line: 55 ]]
		return p1 * 145.038
	end
}
local t2 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 60 ]]
		return p1 / 1000
	end
}

function t2.toAtmosphere(p1) --[[ toAtmosphere | Line: 63 | Upvalues: t (copy), t2 (copy) ]]
	return t.toAtmosphere(t2.toMegapascal(p1))
end
function t2.toPascal(p1) --[[ toPascal | Line: 66 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPascal(t2.toMegapascal(p1))
end
function t2.toBar(p1) --[[ toBar | Line: 69 | Upvalues: t (copy), t2 (copy) ]]
	return t.toBar(t2.toMegapascal(p1))
end
function t2.toMillibar(p1) --[[ toMillibar | Line: 72 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMillibar(t2.toMegapascal(p1))
end
function t2.toPoundsPerSquareInch(p1) --[[ toPoundsPerSquareInch | Line: 75 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPoundsPerSquareInch(t2.toMegapascal(p1))
end

local t3 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 80 ]]
		return p1 / 1000000
	end
}

function t3.toAtmosphere(p1) --[[ toAtmosphere | Line: 83 | Upvalues: t (copy), t3 (copy) ]]
	return t.toAtmosphere(t3.toMegapascal(p1))
end
function t3.toPascal(p1) --[[ toPascal | Line: 86 | Upvalues: t (copy), t3 (copy) ]]
	return t.toPascal(t3.toMegapascal(p1))
end
function t3.toBar(p1) --[[ toBar | Line: 89 | Upvalues: t (copy), t3 (copy) ]]
	return t.toBar(t3.toMegapascal(p1))
end
function t3.toMillibar(p1) --[[ toMillibar | Line: 92 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMillibar(t3.toMegapascal(p1))
end
function t3.toPoundsPerSquareInch(p1) --[[ toPoundsPerSquareInch | Line: 95 | Upvalues: t (copy), t3 (copy) ]]
	return t.toPoundsPerSquareInch(t3.toMegapascal(p1))
end

local t4 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 100 ]]
		return p1 / 9.86923
	end
}

function t4.toKilopascal(p1) --[[ toKilopascal | Line: 103 | Upvalues: t (copy), t4 (copy) ]]
	return t.toAtmosphere(t4.toMegapascal(p1))
end
function t4.toPascal(p1) --[[ toPascal | Line: 106 | Upvalues: t (copy), t4 (copy) ]]
	return t.toPascal(t4.toMegapascal(p1))
end
function t4.toBar(p1) --[[ toBar | Line: 109 | Upvalues: t (copy), t4 (copy) ]]
	return t.toBar(t4.toMegapascal(p1))
end
function t4.toMillibar(p1) --[[ toMillibar | Line: 112 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMillibar(t4.toMegapascal(p1))
end
function t4.toPoundsPerSquareInch(p1) --[[ toPoundsPerSquareInch | Line: 115 | Upvalues: t (copy), t4 (copy) ]]
	return t.toPoundsPerSquareInch(t4.toMegapascal(p1))
end

local t5 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 120 ]]
		return p1 / 10
	end
}

function t5.toKilopascal(p1) --[[ toKilopascal | Line: 123 | Upvalues: t (copy), t5 (copy) ]]
	return t.toAtmosphere(t5.toMegapascal(p1))
end
function t5.toPascal(p1) --[[ toPascal | Line: 126 | Upvalues: t (copy), t5 (copy) ]]
	return t.toPascal(t5.toMegapascal(p1))
end
function t5.toAtmosphere(p1) --[[ toAtmosphere | Line: 129 | Upvalues: t (copy), t5 (copy) ]]
	return t.toAtmosphere(t5.toMegapascal(p1))
end
function t5.toMillibar(p1) --[[ toMillibar | Line: 132 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMillibar(t5.toMegapascal(p1))
end
function t5.toPoundsPerSquareInch(p1) --[[ toPoundsPerSquareInch | Line: 135 | Upvalues: t (copy), t5 (copy) ]]
	return t.toPoundsPerSquareInch(t5.toMegapascal(p1))
end

local t6 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 140 ]]
		return p1 / 10000
	end,
	toKilopascal = function(p1) --[[ toKilopascal | Line: 143 | Upvalues: t (copy), t5 (copy) ]]
		return t.toAtmosphere(t5.toMegapascal(p1))
	end,
	toPascal = function(p1) --[[ toPascal | Line: 146 | Upvalues: t (copy), t5 (copy) ]]
		return t.toPascal(t5.toMegapascal(p1))
	end,
	toAtmosphere = function(p1) --[[ toAtmosphere | Line: 149 | Upvalues: t (copy), t5 (copy) ]]
		return t.toAtmosphere(t5.toMegapascal(p1))
	end,
	toBar = function(p1) --[[ toBar | Line: 152 | Upvalues: t (copy), t5 (copy) ]]
		return t.toBar(t5.toMegapascal(p1))
	end,
	toPoundsPerSquareInch = function(p1) --[[ toPoundsPerSquareInch | Line: 155 | Upvalues: t (copy), t5 (copy) ]]
		return t.toPoundsPerSquareInch(t5.toMegapascal(p1))
	end
}
local t7 = {
	toMegapascal = function(p1) --[[ toMegapascal | Line: 160 ]]
		return p1 / 145.038
	end
}

function t7.toKilopascal(p1) --[[ toKilopascal | Line: 163 | Upvalues: t (copy), t7 (copy) ]]
	return t.toAtmosphere(t7.toMegapascal(p1))
end
function t7.toPascal(p1) --[[ toPascal | Line: 166 | Upvalues: t (copy), t7 (copy) ]]
	return t.toPascal(t7.toMegapascal(p1))
end
function t7.toAtmosphere(p1) --[[ toAtmosphere | Line: 169 | Upvalues: t (copy), t7 (copy) ]]
	return t.toAtmosphere(t7.toMegapascal(p1))
end
function t7.toBar(p1) --[[ toBar | Line: 172 | Upvalues: t (copy), t7 (copy) ]]
	return t.toBar(t7.toMegapascal(p1))
end
function t7.toMillibar(p1) --[[ toMillibar | Line: 175 | Upvalues: t (copy), t7 (copy) ]]
	return t.toMillibar(t7.toMegapascal(p1))
end

return {
	Megapascal = t,
	Kilopascal = t2,
	Pascal = t3,
	Atmosphere = t4,
	Bar = t5,
	Millibar = t6,
	PoundsPerSquareInch = t7
}