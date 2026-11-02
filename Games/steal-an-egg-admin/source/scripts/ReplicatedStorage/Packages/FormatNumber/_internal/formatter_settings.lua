-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local enums = require(script.Parent.enums)
local v1 = { MAX_PRECISION = 2147483647 }

function v1.resolve_min_max_sig(v2, v3) -- line 8 | captures: enums, v1
    if v2.type == enums._Internal.PrecisionType.SIGNFICANT then
        return v2.min, v2.max
    end
    if v2.type == enums._Internal.PrecisionType.FRACTION then
        return v3 + v2.min, v3 + v2.max
    end
    if v2.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
        local v4 = v3 + v2.minFractionDigits
        local v5 = v3 + v2.maxFractionDigits
        local minSignificantDigits = v2.minSignificantDigits
        local maxSignificantDigits = v2.maxSignificantDigits
        local v6, v7
        if v2.roundingPriority == enums.RoundingPriority.RELAXED then
            v7, v6 = math.max(v4, minSignificantDigits), math.max(v5, maxSignificantDigits)
        else
            v7, v6 = math.min(v4, minSignificantDigits), math.min(v5, maxSignificantDigits)
        end
        if v2.sourcedWithSignificantDigits then
            return v7, v6
        end
        return v4, v6
    end
    local v8, MAX_PRECISION
    if v2.type == enums._Internal.PrecisionType.UNLIMITED then
        v8, MAX_PRECISION = 1, v1.MAX_PRECISION
    end
    return v8, MAX_PRECISION
end

local v9 = {}

v9[enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = "."
v9[enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = ","
v9[enums.ENumberFormatSymbols.kMinusSignSymbol] = "-"
v9[enums.ENumberFormatSymbols.kPlusSignSymbol] = "+"
v9[enums.ENumberFormatSymbols.kExponentialSymbol] = "E"
v9[enums.ENumberFormatSymbols.kInfinitySymbol] = "\226\136\158"
v9[enums.ENumberFormatSymbols.kNaNSymbol] = "NaN"

local v10 = table.freeze(v9)

function v1.generate_from_sign_enum(v11) -- line 49 | captures: enums
    local v12, v13, v14, v15
    if v11 == enums.SignDisplay.AUTO then
        v12 = true
        v13 = true
        v14 = false
        v15 = false
    elseif v11 == enums.SignDisplay.ALWAYS then
        v12 = true
        v13 = true
        v14 = true
        v15 = true
    elseif v11 == enums.SignDisplay.NEVER then
        v12 = false
        v13 = false
        v14 = false
        v15 = false
    elseif v11 == enums.SignDisplay.NEGATIVE then
        v12 = true
        v13 = false
        v14 = false
        v15 = false
    elseif v11 == enums.SignDisplay.EXCEPT_ZERO then
        v12 = true
        v13 = false
        v14 = false
        v15 = true
    end
    return table.freeze({
        negative = v12,
        negativeZero = v13,
        positiveZero = v14,
        positive = v15
    })
end

local function linked_list_to_dict(v16) -- line 82
    local v17 = {}
    local v18 = v16
    while true do
        if v18 then
            if not v17[v18.key] then
                v17[v18.key] = v18.value
            end
        else
            break
        end
        v18 = v18.parent
    end
    return table.freeze(v17)
end

v1.linked_list_to_dict = linked_list_to_dict

function v1.resolve_settings(v19) -- line 93 | captures: enums, v1, v10
    local v20 = {}
    v20.notation = v19.notation or table.freeze({ type = enums._Internal.NotationType.SIMPLE })
    local v21 = v20.notation.type == enums._Internal.NotationType.COMPACT
    if v19.precision then
        v20.precision = v19.precision
    elseif v21 then
        v20.precision = table.freeze({
            minFractionDigits = 0,
            maxFractionDigits = 0,
            minSignificantDigits = 1,
            maxSignificantDigits = 2,
            type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
            roundingPriority = enums.RoundingPriority.RELAXED
        })
    else
        v20.precision = table.freeze({
            min = 0,
            max = 6,
            type = enums._Internal.PrecisionType.FRACTION
        })
    end
    if v19.roundingMode then
        v20.roundingMode = v19.roundingMode
    elseif v21 then
        v20.roundingMode = enums.RoundingMode.DOWN
    elseif v20.notation.type == enums._Internal.NotationType.SCIENTIFIC then
        v20.roundingMode = nil
    else
        v20.roundingMode = enums.RoundingMode.HALF_EVEN
    end
    if v19.grouping then
        local grouping = v19.grouping
        if grouping == enums.GroupingStrategy.MIN2 then
            v20.minGrouping = 5
        elseif grouping == enums.GroupingStrategy.ON_ALIGNED then
            v20.minGrouping = 4
        else
            v20.minGrouping = nil
        end
    elseif v21 then
        v20.minGrouping = 5
    else
        v20.minGrouping = 4
    end
    v20.integerWidth = v19.integerWidth or
    table.freeze({
        min = 1,
        max = -1
    })
    v20.symbols = v19.symbols or v10
    if v19.sign then
        v20.displaySignAt = v1.generate_from_sign_enum(v19.sign)
    else
        v20.displaySignAt = v1.generate_from_sign_enum(enums.SignDisplay.AUTO)
    end
    v20.alwaysDisplayDecimal = v19.decimal == enums.DecimalSeparatorDisplay.ALWAYS
    return table.freeze(v20)
end

return table.freeze(v1)
