-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local enums = require(script.Parent.enums)
local t = {
	MAX_PRECISION = 2147483647
}

function t.resolve_min_max_sig(p1, p2) --[[ resolve_min_max_sig | Line: 5 | Upvalues: enums (copy), t (copy) ]]
	local v1 = nil
	local v2 = nil

	if p1.type == enums._Internal.PrecisionType.SIGNFICANT then
		return p1.min, p1.max
	end

	if p1.type == enums._Internal.PrecisionType.FRACTION then
		return p2 + p1.min, p2 + p1.max
	end

	if p1.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
		local v3 = p2 + p1.minFractionDigits
		local v4 = p2 + p1.maxFractionDigits
		local minSignificantDigits = p1.minSignificantDigits
		local maxSignificantDigits = p1.maxSignificantDigits

		if p1.roundingPriority == enums.RoundingPriority.RELAXED then
			local v5 = math.max(v3, minSignificantDigits)

			v2, v1 = math.max(v4, maxSignificantDigits), v5
		else
			local v7 = math.min(v3, minSignificantDigits)

			v2, v1 = math.min(v4, maxSignificantDigits), v7
		end

		if not p1.sourcedWithSignificantDigits then
			return v3, v2
		end
	elseif p1.type == enums._Internal.PrecisionType.UNLIMITED then
		v2 = t.MAX_PRECISION
		v1 = 1
	end

	return v1, v2
end

local v1 = table.freeze({
	[enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = ".",
	[enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = ",",
	[enums.ENumberFormatSymbols.kMinusSignSymbol] = "-",
	[enums.ENumberFormatSymbols.kPlusSignSymbol] = "+",
	[enums.ENumberFormatSymbols.kExponentialSymbol] = "E",
	[enums.ENumberFormatSymbols.kInfinitySymbol] = "\226\136\158",
	[enums.ENumberFormatSymbols.kNaNSymbol] = "NaN"
})

function t.generate_from_sign_enum(p1) --[[ generate_from_sign_enum | Line: 49 | Upvalues: enums (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil

	if p1 == enums.SignDisplay.AUTO then
		v1 = true
		v2 = true
		v3 = false
		v4 = false
	elseif p1 == enums.SignDisplay.ALWAYS then
		v1 = true
		v2 = true
		v3 = true
		v4 = true
	elseif p1 == enums.SignDisplay.NEVER then
		v1 = false
		v2 = false
		v3 = false
		v4 = false
	elseif p1 == enums.SignDisplay.NEGATIVE then
		v1 = true
		v2 = false
		v3 = false
		v4 = false
	elseif p1 == enums.SignDisplay.EXCEPT_ZERO then
		v1 = true
		v2 = false
		v3 = false
		v4 = true
	end

	return table.freeze({
		negative = v1,
		negativeZero = v2,
		positiveZero = v3,
		positive = v4
	})
end
function t.linked_list_to_dict(p1) --[[ linked_list_to_dict | Line: 77 ]]
	local v1, v2 = p1, {}

	while v1 do
		if not v2[v1.key] then
			v2[v1.key] = v1.value
		end

		v1 = v1.parent
	end

	return table.freeze(v2)
end
function t.resolve_settings(p1) --[[ resolve_settings | Line: 90 | Upvalues: enums (copy), v1 (copy), t (copy) ]]
	local t2 = {}

	t2.notation = p1.notation or table.freeze({
		type = enums._Internal.NotationType.SIMPLE
	})

	local v2 = if t2.notation.type == enums._Internal.NotationType.COMPACT then true else false

	if p1.precision then
		t2.precision = p1.precision
	else
		t2.precision = if v2 then table.freeze({
	minFractionDigits = 0,
	maxFractionDigits = 0,
	minSignificantDigits = 1,
	maxSignificantDigits = 2,
	type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
	roundingPriority = enums.RoundingPriority.RELAXED
}) else table.freeze({
	min = 0,
	max = 6,
	type = enums._Internal.PrecisionType.FRACTION
})
	end

	if p1.roundingMode then
		t2.roundingMode = p1.roundingMode
	else
		t2.roundingMode = if v2 or t2.notation.type == enums._Internal.NotationType.SCIENTIFIC then enums.RoundingMode.DOWN else enums.RoundingMode.HALF_EVEN
	end

	if p1.grouping then
		local grouping = p1.grouping

		t2.minGrouping = if grouping == enums.GroupingStrategy.MIN2 then 5 elseif grouping == enums.GroupingStrategy.ON_ALIGNED then 4 else nil
	else
		t2.minGrouping = if v2 then 5 else 4
	end

	t2.integerWidth = p1.integerWidth or table.freeze({
		min = 1,
		max = -1
	})
	t2.symbols = p1.symbols or v1

	if p1.sign then
		t2.displaySignAt = t.generate_from_sign_enum(p1.sign)
	else
		t2.displaySignAt = t.generate_from_sign_enum(enums.SignDisplay.AUTO)
	end

	t2.alwaysDisplayDecimal = if p1.decimal == enums.DecimalSeparatorDisplay.ALWAYS then true else false

	return table.freeze(t2)
end

return table.freeze(t)