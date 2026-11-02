-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toKilojoule = function(p1) --[[ toKilojoule | Line: 39 ]]
		return p1 * 0.001
	end,
	toMegajoule = function(p1) --[[ toMegajoule | Line: 42 ]]
		return p1 * 1e-6
	end,
	toCalorie = function(p1) --[[ toCalorie | Line: 45 ]]
		return p1 * 2.39006e-7
	end,
	toKilocalorie = function(p1) --[[ toKilocalorie | Line: 48 ]]
		return p1 * 0.000239006
	end,
	toBritishThermalUnit = function(p1) --[[ toBritishThermalUnit | Line: 51 ]]
		return p1 * 0.000947817
	end,
	toGigajoule = function(p1) --[[ toGigajoule | Line: 54 ]]
		return p1 * 9.999999999999999e-10
	end
}
local t2 = {
	toJoule = function(p1) --[[ toJoule | Line: 59 ]]
		return p1 / 0.001
	end
}

function t2.toMegajoule(p1) --[[ toMegajoule | Line: 62 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMegajoule(t2.toJoule(p1))
end
function t2.toCalorie(p1) --[[ toCalorie | Line: 65 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCalorie(t2.toJoule(p1))
end
function t2.toKilocalorie(p1) --[[ toKilocalorie | Line: 68 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKilocalorie(t2.toJoule(p1))
end
function t2.toBritishThermalUnit(p1) --[[ toBritishThermalUnit | Line: 71 | Upvalues: t (copy), t2 (copy) ]]
	return t.toBritishThermalUnit(t2.toJoule(p1))
end
function t2.toGigajoule(p1) --[[ toGigajoule | Line: 74 | Upvalues: t (copy), t2 (copy) ]]
	return t.toGigajoule(t2.toJoule(p1))
end

local t3 = {
	toJoule = function(p1) --[[ toJoule | Line: 79 ]]
		return p1 / 0.001
	end
}

function t3.toKilojoule(p1) --[[ toKilojoule | Line: 82 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilojoule(t3.toJoule(p1))
end
function t3.toCalorie(p1) --[[ toCalorie | Line: 85 | Upvalues: t (copy), t3 (copy) ]]
	return t.toCalorie(t3.toJoule(p1))
end
function t3.toKilocalorie(p1) --[[ toKilocalorie | Line: 88 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilocalorie(t3.toJoule(p1))
end
function t3.toBritishThermalUnit(p1) --[[ toBritishThermalUnit | Line: 91 | Upvalues: t (copy), t3 (copy) ]]
	return t.toBritishThermalUnit(t3.toJoule(p1))
end
function t3.toGigajoule(p1) --[[ toGigajoule | Line: 94 | Upvalues: t (copy), t3 (copy) ]]
	return t.toGigajoule(t3.toJoule(p1))
end

local t4 = {
	toJoule = function(p1) --[[ toJoule | Line: 99 ]]
		return p1 / 2.39006e-7
	end
}

function t4.toKilojoule(p1) --[[ toKilojoule | Line: 102 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKilojoule(t4.toJoule(p1))
end
function t4.toMegajoule(p1) --[[ toMegajoule | Line: 105 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMegajoule(t4.toJoule(p1))
end
function t4.toKilocalorie(p1) --[[ toKilocalorie | Line: 108 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKilocalorie(t4.toJoule(p1))
end
function t4.toBritishThermalUnit(p1) --[[ toBritishThermalUnit | Line: 111 | Upvalues: t (copy), t4 (copy) ]]
	return t.toBritishThermalUnit(t4.toJoule(p1))
end
function t4.toGigajoule(p1) --[[ toGigajoule | Line: 114 | Upvalues: t (copy), t4 (copy) ]]
	return t.toGigajoule(t4.toJoule(p1))
end

local t5 = {
	toJoule = function(p1) --[[ toJoule | Line: 119 ]]
		return p1 / 2.39006e-7
	end
}

function t5.toKilojoule(p1) --[[ toKilojoule | Line: 122 | Upvalues: t (copy), t5 (copy) ]]
	return t.toKilojoule(t5.toJoule(p1))
end
function t5.toMegajoule(p1) --[[ toMegajoule | Line: 125 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMegajoule(t5.toJoule(p1))
end
function t5.toCalorie(p1) --[[ toCalorie | Line: 128 | Upvalues: t (copy), t5 (copy) ]]
	return t.toCalorie(t5.toJoule(p1))
end
function t5.toBritishThermalUnit(p1) --[[ toBritishThermalUnit | Line: 131 | Upvalues: t (copy), t5 (copy) ]]
	return t.toBritishThermalUnit(t5.toJoule(p1))
end
function t5.toGigajoule(p1) --[[ toGigajoule | Line: 134 | Upvalues: t (copy), t5 (copy) ]]
	return t.toGigajoule(t5.toJoule(p1))
end

local t6 = {
	toJoule = function(p1) --[[ toJoule | Line: 139 ]]
		return p1 / 0.000947817
	end
}

function t6.toKilojoule(p1) --[[ toKilojoule | Line: 142 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKilojoule(t6.toJoule(p1))
end
function t6.toMegajoule(p1) --[[ toMegajoule | Line: 145 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMegajoule(t6.toJoule(p1))
end
function t6.toKilocalorie(p1) --[[ toKilocalorie | Line: 148 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKilocalorie(t6.toJoule(p1))
end
function t6.toCalorie(p1) --[[ toCalorie | Line: 151 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCalorie(t6.toJoule(p1))
end
function t6.toGigajoule(p1) --[[ toGigajoule | Line: 154 | Upvalues: t (copy), t6 (copy) ]]
	return t.toGigajoule(t6.toJoule(p1))
end

local t7 = {
	toJoule = function(p1) --[[ toJoule | Line: 159 ]]
		return p1 / 9.999999999999999e-10
	end
}

function t7.toKilojoule(p1) --[[ toKilojoule | Line: 162 | Upvalues: t (copy), t7 (copy) ]]
	return t.toKilojoule(t7.toJoule(p1))
end
function t7.toMegajoule(p1) --[[ toMegajoule | Line: 165 | Upvalues: t (copy), t7 (copy) ]]
	return t.toMegajoule(t7.toJoule(p1))
end
function t7.toKilocalorie(p1) --[[ toKilocalorie | Line: 168 | Upvalues: t (copy), t7 (copy) ]]
	return t.toKilocalorie(t7.toJoule(p1))
end
function t7.toCalorie(p1) --[[ toCalorie | Line: 171 | Upvalues: t (copy), t7 (copy) ]]
	return t.toCalorie(t7.toJoule(p1))
end
function t7.toBritishThermalUnit(p1) --[[ toBritishThermalUnit | Line: 174 | Upvalues: t (copy), t7 (copy) ]]
	return t.toBritishThermalUnit(t7.toJoule(p1))
end

return {
	Joule = t,
	Kilojoule = t2,
	Megajoule = t3,
	Calorie = t4,
	Kilocalorie = t5,
	BritishThermalUnit = t6,
	Gigajoule = t7
}