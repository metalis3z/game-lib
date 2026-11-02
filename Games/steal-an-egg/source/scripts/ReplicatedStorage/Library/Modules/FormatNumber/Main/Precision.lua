-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local _internal = require(script.Parent.Parent._internal)
local t = {}
local t2 = {}
local v1 = _internal.class.create_init_function("Precision", nil, t2, nil, _internal.class.ImmutabilityType.DEFAULT)
local t3 = {}
local v2 = _internal.class.create_init_function("FractionPrecision", "Precision", t3, t2, _internal.class.ImmutabilityType.DEFAULT)

function t3.WithMinDigits(p1, p2) --[[ WithMinDigits | Line: 22 | Upvalues: _internal (copy), v1 (copy) ]]
	local v12 = _internal.class.try_coerce(1, p1, "FractionPrecision")

	return v1({
		minSignificantDigits = 1,
		sourcedWithSignificantDigits = false,
		type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
		minFractionDigits = v12.min,
		maxFractionDigits = v12.max,
		maxSignificantDigits = _internal.class.try_coerce_range(2, p2, 1, 999),
		roundingPriority = _internal.enums.RoundingPriority.RELAXED
	})
end
function t3.WithMaxDigits(p1, p2) --[[ WithMaxDigits | Line: 37 | Upvalues: _internal (copy), v1 (copy) ]]
	local v12 = _internal.class.try_coerce(1, p1, "FractionPrecision")

	return v1({
		minSignificantDigits = 1,
		sourcedWithSignificantDigits = false,
		type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
		minFractionDigits = v12.min,
		maxFractionDigits = v12.max,
		maxSignificantDigits = _internal.class.try_coerce_range(2, p2, 1, 999),
		roundingPriority = _internal.enums.RoundingPriority.STRICT
	})
end
function t3.WithSignificantDigits(p1, p2, p3, p4) --[[ WithSignificantDigits | Line: 52 | Upvalues: _internal (copy), v1 (copy) ]]
	local v12 = _internal.class.try_coerce(1, p1, "FractionPrecision")
	local v2 = _internal.class.try_coerce_range(2, p2, 1, 999)
	local v3 = _internal.class.try_coerce_range(3, p3, 1, 999)

	return v1({
		sourcedWithSignificantDigits = true,
		type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
		minFractionDigits = v12.min,
		maxFractionDigits = v12.max,
		minSignificantDigits = v2,
		maxSignificantDigits = v3,
		roundingPriority = _internal.class.try_coerce_enum(4, p4, _internal.enums.RoundingPriority)
	})
end

local v3 = _internal.class.create_init_function("SignificantDigitsPrecision", "Precision", {}, t2, _internal.class.ImmutabilityType.DEFAULT)

function t.unlimited() --[[ unlimited | Line: 84 | Upvalues: v1 (copy), _internal (copy) ]]
	return v1({
		type = _internal.enums._Internal.PrecisionType.UNLIMITED
	})
end
function t.integer() --[[ integer | Line: 90 | Upvalues: v2 (copy), _internal (copy) ]]
	return v2({
		min = 0,
		max = 0,
		type = _internal.enums._Internal.PrecisionType.FRACTION
	})
end
function t.fixedFraction(p1) --[[ fixedFraction | Line: 98 | Upvalues: _internal (copy), v2 (copy) ]]
	local v1 = _internal.class.try_coerce_range(1, p1, 0, 999)

	return v2({
		type = _internal.enums._Internal.PrecisionType.FRACTION,
		min = v1,
		max = v1
	})
end
function t.minFraction(p1) --[[ minFraction | Line: 108 | Upvalues: _internal (copy), v2 (copy) ]]
	return v2({
		type = _internal.enums._Internal.PrecisionType.FRACTION,
		min = _internal.class.try_coerce_range(1, p1, 0, 999),
		max = _internal.formatter_settings.MAX_PRECISION
	})
end
function t.maxFraction(p1) --[[ maxFraction | Line: 118 | Upvalues: _internal (copy), v2 (copy) ]]
	return v2({
		min = 0,
		type = _internal.enums._Internal.PrecisionType.FRACTION,
		max = _internal.class.try_coerce_range(1, p1, 0, 999)
	})
end
function t.minMaxFraction(p1, p2) --[[ minMaxFraction | Line: 128 | Upvalues: _internal (copy), v2 (copy) ]]
	local v1 = _internal.class.try_coerce_range(1, p1, 0, 999)

	return v2({
		type = _internal.enums._Internal.PrecisionType.FRACTION,
		min = v1,
		max = _internal.class.try_coerce_range(2, p2, v1, 999)
	})
end
function t.fixedSignificantDigits(p1) --[[ fixedSignificantDigits | Line: 139 | Upvalues: _internal (copy), v3 (copy) ]]
	local v1 = _internal.class.try_coerce_range(1, p1, 1, 999)

	return v3({
		type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
		min = v1,
		max = v1
	})
end
function t.minSignificantDigits(p1) --[[ minSignificantDigits | Line: 149 | Upvalues: _internal (copy), v3 (copy) ]]
	return v3({
		type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
		min = _internal.class.try_coerce_range(1, p1, 1, 999),
		max = _internal.formatter_settings.MAX_PRECISION
	})
end
function t.maxSignificantDigits(p1) --[[ maxSignificantDigits | Line: 159 | Upvalues: _internal (copy), v3 (copy) ]]
	return v3({
		min = 1,
		type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
		max = _internal.class.try_coerce_range(1, p1, 1, 999)
	})
end
function t.minMaxSignificantDigits(p1, p2) --[[ minMaxSignificantDigits | Line: 169 | Upvalues: _internal (copy), v3 (copy) ]]
	local v1 = _internal.class.try_coerce_range(1, p1, 1, 999)

	return v3({
		type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
		min = v1,
		max = _internal.class.try_coerce_range(2, p2, v1, 999)
	})
end

return table.freeze(t)