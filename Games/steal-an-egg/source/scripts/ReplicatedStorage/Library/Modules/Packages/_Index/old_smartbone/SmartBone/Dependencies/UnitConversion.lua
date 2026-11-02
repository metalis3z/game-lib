-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Conversions = {
		Kilometer = 280.0336040324839,
		Hektometer = 28.00336040324839,
		Decameter = 2.800336040324839,
		Meter = 0.2800336040324839,
		Decimeter = 0.02800336040324839,
		Centimeter = 0.002800336040324839,
		Millimeter = 0.0002800336040324839,
		Miles = 4850.975973116774,
		Yards = 2.7562363483618033,
		Feet = 0.9187454494539344,
		Inches = 0.07656212078782787
	}
}

function t.Convert(p1, p2) --[[ Convert | Line: 22 | Upvalues: t (copy) ]]
	return if t.Conversions[p2] == nil then false else p1 * t.Conversions[p2]
end
function t.ConvertInverse(p1, p2) --[[ ConvertInverse | Line: 26 | Upvalues: t (copy) ]]
	return if t.Conversions[p2] == nil then false else t.Conversions[p2] / p1
end
function t.ConvertRounded(p1, p2) --[[ ConvertRounded | Line: 30 | Upvalues: t (copy) ]]
	return if t.Conversions[p2] == nil then false else math.floor(p1 * t.Conversions[p2])
end

return t