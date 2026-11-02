-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toKelvin = function(p1) --[[ toKelvin | Line: 21 ]]
		return p1 + 273
	end,
	toFahrenheit = function(p1) --[[ toFahrenheit | Line: 24 ]]
		return p1 * 1.8 + 32
	end
}
local t2 = {
	toCelsius = function(p1) --[[ toCelsius | Line: 29 ]]
		return p1 - 273
	end
}

function t2.toFahrenheit(p1) --[[ toFahrenheit | Line: 32 | Upvalues: t (copy), t2 (copy) ]]
	return t.toFahrenheit(t2.toCelsius(p1))
end

local t3 = {
	toCelsius = function(p1) --[[ toCelsius | Line: 37 ]]
		return (p1 - 32) / 1.8
	end
}

function t3.toKelvin(p1) --[[ toKelvin | Line: 40 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKelvin(t3.toCelsius(p1))
end

return {
	Kelvin = t2,
	Celsius = t,
	Fahrenheit = t3
}