-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toWatt = function(p1) --[[ toWatt | Line: 40 ]]
		return p1 * 1000
	end,
	toMegawatt = function(p1) --[[ toMegawatt | Line: 43 ]]
		return p1 * 0.001
	end,
	toGigawatt = function(p1) --[[ toGigawatt | Line: 46 ]]
		return p1 * 1e-6
	end,
	toHorsepower = function(p1) --[[ toHorsepower | Line: 49 ]]
		return p1 * 0.7457
	end,
	toFootPoundsPerMinute = function(p1) --[[ toFootPoundsPerMinute | Line: 52 ]]
		return p1 * 43478.260869565216
	end,
	toKilogramMetersPerSecond = function(p1) --[[ toKilogramMetersPerSecond | Line: 55 ]]
		return p1 * 0.0098
	end
}
local t2 = {
	toKilowatt = function(p1) --[[ toKilowatt | Line: 60 ]]
		return p1 / 1000
	end
}

function t2.toMegawatt(p1) --[[ toMegawatt | Line: 63 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMegawatt(t2.toKilowatt(p1))
end
function t2.toGigawatt(p1) --[[ toGigawatt | Line: 66 | Upvalues: t (copy), t2 (copy) ]]
	return t.toGigawatt(t2.toKilowatt(p1))
end
function t2.toHorsepower(p1) --[[ toHorsepower | Line: 69 | Upvalues: t (copy), t2 (copy) ]]
	return t.toHorsepower(t2.toKilowatt(p1))
end
function t2.toFootPoundsPerMinute(p1) --[[ toFootPoundsPerMinute | Line: 72 | Upvalues: t (copy), t2 (copy) ]]
	return t.toFootPoundsPerMinute(t2.toKilowatt(p1))
end
function t2.toKilogramMetersPerSecond(p1) --[[ toKilogramMetersPerSecond | Line: 75 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKilogramMetersPerSecond(t2.toKilowatt(p1))
end

local t3 = {
	toKilowatt = function(p1) --[[ toKilowatt | Line: 80 ]]
		return p1 / 0.001
	end
}

function t3.toWatt(p1) --[[ toWatt | Line: 83 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMegawatt(t3.toKilowatt(p1))
end
function t3.toGigawatt(p1) --[[ toGigawatt | Line: 86 | Upvalues: t (copy), t3 (copy) ]]
	return t.toGigawatt(t3.toKilowatt(p1))
end
function t3.toHorsepower(p1) --[[ toHorsepower | Line: 89 | Upvalues: t (copy), t3 (copy) ]]
	return t.toHorsepower(t3.toKilowatt(p1))
end
function t3.toFootPoundsPerMinute(p1) --[[ toFootPoundsPerMinute | Line: 92 | Upvalues: t (copy), t3 (copy) ]]
	return t.toFootPoundsPerMinute(t3.toKilowatt(p1))
end
function t3.toKilogramMetersPerSecond(p1) --[[ toKilogramMetersPerSecond | Line: 95 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilogramMetersPerSecond(t3.toKilowatt(p1))
end

local t4 = {
	toKilowatt = function(p1) --[[ toKilowatt | Line: 100 ]]
		return p1 / 1e-6
	end
}

function t4.toWatt(p1) --[[ toWatt | Line: 103 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMegawatt(t4.toKilowatt(p1))
end
function t4.toMegawatt(p1) --[[ toMegawatt | Line: 106 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMegawatt(t4.toKilowatt(p1))
end
function t4.toHorsepower(p1) --[[ toHorsepower | Line: 109 | Upvalues: t (copy), t4 (copy) ]]
	return t.toHorsepower(t4.toKilowatt(p1))
end
function t4.toFootPoundsPerMinute(p1) --[[ toFootPoundsPerMinute | Line: 112 | Upvalues: t (copy), t4 (copy) ]]
	return t.toFootPoundsPerMinute(t4.toKilowatt(p1))
end
function t4.toKilogramMetersPerSecond(p1) --[[ toKilogramMetersPerSecond | Line: 115 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKilogramMetersPerSecond(t4.toKilowatt(p1))
end

local t5 = {
	toKilowatt = function(p1) --[[ toKilowatt | Line: 120 ]]
		return p1 / 1e-6
	end
}

function t5.toWatt(p1) --[[ toWatt | Line: 123 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMegawatt(t5.toKilowatt(p1))
end
function t5.toMegawatt(p1) --[[ toMegawatt | Line: 126 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMegawatt(t5.toKilowatt(p1))
end
function t5.toGigawatt(p1) --[[ toGigawatt | Line: 129 | Upvalues: t (copy), t5 (copy) ]]
	return t.toGigawatt(t5.toKilowatt(p1))
end
function t5.toFootPoundsPerMinute(p1) --[[ toFootPoundsPerMinute | Line: 132 | Upvalues: t (copy), t5 (copy) ]]
	return t.toFootPoundsPerMinute(t5.toKilowatt(p1))
end
function t5.toKilogramMetersPerSecond(p1) --[[ toKilogramMetersPerSecond | Line: 135 | Upvalues: t (copy), t5 (copy) ]]
	return t.toKilogramMetersPerSecond(t5.toKilowatt(p1))
end

local t6 = {
	toKilowatt = function(p1) --[[ toKilowatt | Line: 140 ]]
		return p1 / 1e-6
	end
}

function t6.toWatt(p1) --[[ toWatt | Line: 143 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMegawatt(t6.toKilowatt(p1))
end
function t6.toMegawatt(p1) --[[ toMegawatt | Line: 146 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMegawatt(t6.toKilowatt(p1))
end
function t6.toGigawatt(p1) --[[ toGigawatt | Line: 149 | Upvalues: t (copy), t6 (copy) ]]
	return t.toGigawatt(t6.toKilowatt(p1))
end
function t6.toHorsepower(p1) --[[ toHorsepower | Line: 152 | Upvalues: t (copy), t6 (copy) ]]
	return t.toHorsepower(t6.toKilowatt(p1))
end
function t6.toKilogramMetersPerSecond(p1) --[[ toKilogramMetersPerSecond | Line: 155 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKilogramMetersPerSecond(t6.toKilowatt(p1))
end

return {
	Kilowatt = t,
	Watt = t2,
	Megawatt = t3,
	Gigawatt = t4,
	Horsepower = t5,
	FootPoundsPerMinute = t6
}