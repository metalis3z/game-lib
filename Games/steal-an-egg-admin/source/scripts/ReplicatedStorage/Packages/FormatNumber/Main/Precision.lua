-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local v3 = _internal.class.create_init_function("Precision", nil, v2, nil, _internal.class.ImmutabilityType.DEFAULT)
local v4 = {}
local v5 = _internal.class.create_init_function("FractionPrecision", "Precision", v4, v2, _internal.class.ImmutabilityType.DEFAULT)

function v4.WithMinDigits(v6, v7) -- line 12 | captures: _internal, v3
    local FractionPrecision = _internal.class.try_coerce(1, v6, "FractionPrecision")
    local v8 = _internal.class.try_coerce_range(2, v7, 1, 999)
    return v3({
        minSignificantDigits = 1,
        sourcedWithSignificantDigits = false,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = FractionPrecision.min,
        maxFractionDigits = FractionPrecision.max,
        maxSignificantDigits = v8,
        roundingPriority = _internal.enums.RoundingPriority.RELAXED
    })
end

function v4.WithMaxDigits(v9, v10) -- line 25 | captures: _internal, v3
    local FractionPrecision = _internal.class.try_coerce(1, v9, "FractionPrecision")
    local v11 = _internal.class.try_coerce_range(2, v10, 1, 999)
    return v3({
        minSignificantDigits = 1,
        sourcedWithSignificantDigits = false,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = FractionPrecision.min,
        maxFractionDigits = FractionPrecision.max,
        maxSignificantDigits = v11,
        roundingPriority = _internal.enums.RoundingPriority.STRICT
    })
end

function v4.WithSignificantDigits(v12, v13, v14, v15) -- line 38 | captures: _internal, v3
    local FractionPrecision = _internal.class.try_coerce(1, v12, "FractionPrecision")
    local v16 = _internal.class.try_coerce_range(2, v13, 1, 999)
    local v17 = _internal.class.try_coerce_range(3, v14, 1, 999)
    local v18 = _internal.class.try_coerce_enum(4, v15, _internal.enums.RoundingPriority)
    return v3({
        sourcedWithSignificantDigits = true,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = FractionPrecision.min,
        maxFractionDigits = FractionPrecision.max,
        minSignificantDigits = v16,
        maxSignificantDigits = v17,
        roundingPriority = v18
    })
end

local v19 = _internal.class.create_init_function("SignificantDigitsPrecision", "Precision", {}, v2, _internal.class.ImmutabilityType.DEFAULT)

function v1.unlimited() -- line 54 | captures: _internal, v3
    return v3({ type = _internal.enums._Internal.PrecisionType.UNLIMITED })
end

function v1.integer() -- line 57 | captures: _internal, v5
    return v5({
        min = 0,
        max = 0,
        type = _internal.enums._Internal.PrecisionType.FRACTION
    })
end

function v1.fixedFraction(v20) -- line 60 | captures: _internal, v5
    local v21 = _internal.class.try_coerce_range(1, v20, 0, 999)
    return v5({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = v21,
        max = v21
    })
end

function v1.minFraction(v22) -- line 64 | captures: _internal, v5
    local v23 = _internal.class.try_coerce_range(1, v22, 0, 999)
    return v5({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = v23,
        max = _internal.formatter_settings.MAX_PRECISION
    })
end

function v1.maxFraction(v24) -- line 68 | captures: _internal, v5
    local v25 = _internal.class.try_coerce_range(1, v24, 0, 999)
    return v5({
        min = 0,
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        max = v25
    })
end

function v1.minMaxFraction(v26, v27) -- line 72 | captures: _internal, v5
    local v28 = _internal.class.try_coerce_range(1, v26, 0, 999)
    local v29 = _internal.class.try_coerce_range(2, v27, v28, 999)
    return v5({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = v28,
        max = v29
    })
end

function v1.fixedSignificantDigits(v30) -- line 77 | captures: _internal, v19
    local v31 = _internal.class.try_coerce_range(1, v30, 1, 999)
    return v19({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = v31,
        max = v31
    })
end

function v1.minSignificantDigits(v32) -- line 81 | captures: _internal, v19
    local v33 = _internal.class.try_coerce_range(1, v32, 1, 999)
    return v19({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = v33,
        max = _internal.formatter_settings.MAX_PRECISION
    })
end

function v1.maxSignificantDigits(v34) -- line 85 | captures: _internal, v19
    local v35 = _internal.class.try_coerce_range(1, v34, 1, 999)
    return v19({
        min = 1,
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        max = v35
    })
end

function v1.minMaxSignificantDigits(v36, v37) -- line 89 | captures: _internal, v19
    local v38 = _internal.class.try_coerce_range(1, v36, 1, 999)
    local v39 = _internal.class.try_coerce_range(2, v37, v38, 999)
    return v19({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = v38,
        max = v39
    })
end

return table.freeze(v1)
