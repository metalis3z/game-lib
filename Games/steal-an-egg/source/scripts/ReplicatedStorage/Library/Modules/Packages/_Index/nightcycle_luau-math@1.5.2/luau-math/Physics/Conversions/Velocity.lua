-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toKilometersPerHour = function(p1) --[[ toKilometersPerHour | Line: 31 ]]
		return p1 * 3.6
	end,
	toMilesPerHour = function(p1) --[[ toMilesPerHour | Line: 34 ]]
		return p1 * 2.23694
	end,
	toFeetPerSecond = function(p1) --[[ toFeetPerSecond | Line: 37 ]]
		return p1 * 3.28084
	end,
	toKnot = function(p1) --[[ toKnot | Line: 40 ]]
		return p1 * 1.94384
	end
}
local t2 = {
	toMetersPerSecond = function(p1) --[[ toMetersPerSecond | Line: 45 ]]
		return p1 / 3.6
	end
}

function t2.toMilesPerHour(p1) --[[ toMilesPerHour | Line: 48 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMilesPerHour(t2.toMetersPerSecond(p1))
end
function t2.toFeetPerSecond(p1) --[[ toFeetPerSecond | Line: 51 | Upvalues: t (copy), t2 (copy) ]]
	return t.toFeetPerSecond(t2.toMetersPerSecond(p1))
end
function t2.toKnot(p1) --[[ toKnot | Line: 54 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKnot(t2.toMetersPerSecond(p1))
end

local t3 = {
	toMetersPerSecond = function(p1) --[[ toMetersPerSecond | Line: 59 ]]
		return p1 / 2.23694
	end
}

function t3.toKilometersPerHour(p1) --[[ toKilometersPerHour | Line: 62 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilometersPerHour(t3.toMetersPerSecond(p1))
end
function t3.toFeetPerSecond(p1) --[[ toFeetPerSecond | Line: 65 | Upvalues: t (copy), t3 (copy) ]]
	return t.toFeetPerSecond(t3.toMetersPerSecond(p1))
end
function t3.toKnot(p1) --[[ toKnot | Line: 68 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKnot(t3.toMetersPerSecond(p1))
end

local t4 = {
	toMetersPerSecond = function(p1) --[[ toMetersPerSecond | Line: 73 ]]
		return p1 / 3.28084
	end
}

function t4.toKilometersPerHour(p1) --[[ toKilometersPerHour | Line: 76 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKilometersPerHour(t4.toMetersPerSecond(p1))
end
function t4.toMilesPerHour(p1) --[[ toMilesPerHour | Line: 79 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMilesPerHour(t4.toMetersPerSecond(p1))
end
function t4.toKnot(p1) --[[ toKnot | Line: 82 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKnot(t4.toMetersPerSecond(p1))
end

return {
	MetersPerSecond = t,
	KilometersPerHour = t2,
	MilesPerHour = t3,
	FeetPerSecond = t4,
	Knot = {
		toMetersPerSecond = function(p1) --[[ toMetersPerSecond | Line: 87 ]]
			return p1 / 1.94384
		end,
		toKilometersPerHour = function(p1) --[[ toKilometersPerHour | Line: 90 | Upvalues: t (copy), t4 (copy) ]]
			return t.toKilometersPerHour(t4.toMetersPerSecond(p1))
		end,
		toMilesPerHour = function(p1) --[[ toMilesPerHour | Line: 93 | Upvalues: t (copy), t4 (copy) ]]
			return t.toMilesPerHour(t4.toMetersPerSecond(p1))
		end,
		toFeetPerSecond = function(p1) --[[ toFeetPerSecond | Line: 96 | Upvalues: t (copy), t4 (copy) ]]
			return t.toFeetPerSecond(t4.toMetersPerSecond(p1))
		end
	}
}