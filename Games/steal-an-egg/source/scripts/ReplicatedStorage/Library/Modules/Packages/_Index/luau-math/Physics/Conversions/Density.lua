-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toKilogramsPerCubicMeter = function(p1) --[[ toKilogramsPerCubicMeter | Line: 19 ]]
		return p1 * 0.001
	end,
	toGramPerMilliliter = function(p1) --[[ toGramPerMilliliter | Line: 24 ]]
		return p1 * 1e-6
	end
}
local t2 = {
	toGramPerCubicCentimeter = function(p1) --[[ toGramPerCubicCentimeter | Line: 29 ]]
		return p1 / 1e-6
	end
}

function t2.toKilogramsPerCubicMeter(p1) --[[ toKilogramsPerCubicMeter | Line: 32 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKilogramsPerCubicMeter(t2.toGramPerCubicCentimeter(p1))
end

local t3 = {
	toGramPerCubicCentimeter = function(p1) --[[ toGramPerCubicCentimeter | Line: 41 ]]
		return p1 / 0.001
	end
}

function t3.toKilogramsPerCubicMeter(p1) --[[ toKilogramsPerCubicMeter | Line: 46 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilogramsPerCubicMeter(t3.toGramPerCubicCentimeter(p1))
end

return {
	GramPerCubicCentimeter = t,
	KilogramsPerCubicMeter = t3,
	GramPerMilliliter = t2
}