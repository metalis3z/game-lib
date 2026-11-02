-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local enums = require(script.Parent.enums)
local formatter_settings = require(script.Parent.formatter_settings)
local v1 = {}

local function internal_get_digits(v2, v3, v4, v5) -- line 9
    local function v6(...)
        return (string.char(...))
    end

    local v7, v8
    if v4 > 0 then
        v7 = v4
        v8 = ""
    else
        v7, v8 = 1, string.rep("0", -v4 + 1)
    end
    local v9 = v7 - 1
    local v10 = v5 - math.max(v3, v9)
    local v11, v12
    if v10 > 0 then
        v11, v12 = v3, string.rep("0", v10)
    else
        v11 = v5
        v12 = ""
    end
    local v13
    if v7 <= v3 then
        v13 = v6(table.unpack(v2, v7, v11))
    else
        v13 = ""
    end
    return v8 .. v13 .. v12
end

local function strip_trailing_zero(v14, v15) -- line 33
    if v15 < 0 then
        return 0
    end
    local v16 = v15
    while v14[v16] == 0 do
        v16 -= 1
    end
    return v16
end

v1.strip_trailing_zero = strip_trailing_zero

function v1.round_sig(v17, v18, v19, v20, v21) -- line 43 | captures: enums, v1
    if v18 <= v19 then
        return v18, 0
    end
    local v22
    if v19 >= 0 then
        if v17[v19 + 1] > 5 then
            v22 = 1
        elseif v17[v19 + 1] == 5 then
            if v18 <= v19 + 1 then
                v22 = 0
            else
                v22 = 1
            end
        else
            v22 = -1
        end
    else
        v22 = -1
    end
    local v23
    if v21 == enums.RoundingMode.CEILING then
        if v20 then
            v23 = 1
        else
            v23 = -2
        end
    elseif v21 == enums.RoundingMode.FLOOR then
        if v20 then
            v23 = -2
        else
            v23 = 1
        end
    elseif v21 == enums.RoundingMode.UP then
        v23 = -2
    elseif v21 == enums.RoundingMode.DOWN then
        v23 = 1
    elseif v21 == enums.RoundingMode.HALF_EVEN then
        if v19 > 0 then
            v23 = v17[v19] % -2
        else
            v23 = 0
        end
    elseif v21 == enums.RoundingMode.HALF_DOWN then
        v23 = 0
    elseif v21 == enums.RoundingMode.HALF_UP then
        v23 = -1
    end
    local v24, v25
    if v23 < v22 then
        v24 = v19
        while v17[v24] == 9 do
            if v24 <= 0 then
                break
            end
            v24 -= 1
        end
        if v24 > 0 then
            v17[v24] += 1
            v25 = 0
        else
            v17[1] = 1
            v24, v25 = 1, 1 - v24
        end
    else
        v24 = v19
        v25 = 0
    end
    return v1.strip_trailing_zero(v17, v24), v25
end

function v1.resolve_int_frac(v26, v27, v28, v29, v30, v31, v32) -- line 112 | captures: internal_get_digits
    for v33 = 1, v27 do
        v26[v33] += 48
    end
    local v34, v35
    if v29 <= v28 then
        v34, v35 = internal_get_digits(v26, v27, v29, v28), internal_get_digits(v26, v27, v28 + 1, v30)
    elseif v30 < v28 + 1 then
        v34 = "0"
        v35 = ""
    end
    local v36
    if v31 and v31 <= v28 - v29 + 1 then
        local v37
        if v32 == "%" then
            v37 = "%0%%"
        elseif #v32 <= 1 then
            v37 = "%0" .. v32
        else
            v37 = "%0" .. string.reverse(v32)
        end
        local v38 = string.reverse(v34)
        v36 = string.reverse((string.gsub(v38, "...", v37, (v28 - v29) / 3)))
    else
        v36 = v34
    end
    return v36, v35
end

function v1.format_expt(v39, v40, v41, v42) -- line 139 | captures: enums
    local v43, v44
    if v39 < 0 then
        local v45 = -v39
        v43 = tostring(v45)
        if v42.negative then
            v44 = v40[enums.ENumberFormatSymbols.kMinusSignSymbol]
        else
            v44 = ""
        end
    elseif v39 == 0 then
        if v42.positiveZero then
            v43, v44 = "0", v40[enums.ENumberFormatSymbols.kPlusSignSymbol]
        else
            v43 = "0"
            v44 = ""
        end
    else
        v43 = tostring(v39)
        if v42.positive then
            v44 = v40[enums.ENumberFormatSymbols.kPlusSignSymbol]
        else
            v44 = ""
        end
    end
    local v46 = string.rep("0", v41 - #v43) .. v43
    return v40[enums.ENumberFormatSymbols.kExponentialSymbol] .. v44 .. v46
end

function v1.resolve_with_notation(v47, v48, v49, v50, v51) -- line 162 | captures: enums, v1
    local power10Scale, v52, v53, v54
    if v48 > 0 then
        if v50.type == enums._Internal.NotationType.SIMPLE then
            v53, power10Scale, v54, v52 = nil, nil, nil, v49 + v48
        else
            power10Scale = v50.power10Scale
            local v55 = v49 + v48 - 1
            local v56 = v55 / power10Scale
            local v57 = math.floor(v56)
            v52 = v55 - v57 * power10Scale + 1
            if v50.type == enums._Internal.NotationType.COMPACT then
                local suffixesLength = v50.suffixesLength
                local v58
                if suffixesLength < v57 then
                    v58 = v52 + (v57 - suffixesLength) * power10Scale
                    v53 = v50.suffixes[suffixesLength]
                elseif v57 < 0 then
                    v53, v58 = nil, v52 + v57 * power10Scale
                elseif v57 == 0 then
                    v58 = v52
                else
                    v53 = v50.suffixes[v57]
                    v58 = v52
                end
                if v57 >= 0 and v57 < suffixesLength then
                    v54 = v50.suffixes[v57 + 1]
                    v52 = v58
                else
                    power10Scale = nil
                    v52 = v58
                end
            else
                v53, v54 = v1.format_expt(v57 * power10Scale, v51, v50.minExponentDigits, v50.displayExponentSignAt), v1.format_expt((v57 + 1) * power10Scale, v51, v50.minExponentDigits, v50.displayExponentSignAt)
            end
        end
    elseif v50.type == enums._Internal.NotationType.SCIENTIFIC then
        v53 = v1.format_expt(0, v51, v50.minExponentDigits, v50.displayExponentSignAt)
        v52 = v49
    else
        v52 = v49
    end
    return v52, v53, power10Scale, v54
end

function v1.format_unsigned_finite(v59, v60, v61, v62, v63) -- line 200 | captures: enums, formatter_settings, v1
    local min = v63.integerWidth.min
    local max = v63.integerWidth.max
    local symbols = v63.symbols
    local v64, v65, v66, v67 = v1.resolve_with_notation(v59, v60, v61, v63.notation, symbols)
    local v68, v69 = formatter_settings.resolve_min_max_sig(v63.precision, v64)
    local v70, v71 = v1.round_sig(v59, v60, v69, v62, v63.roundingMode)
    local v72 = v70 == 0
    if v71 > 0 then
        local v73, v74
        if v64 == v66 then
            local v75 = v71 == 1
            assert(v75)
            v73 = 1
            v74 = v67
        else
            v73 = v64 + v71
            v74 = v65
        end
        v68 = formatter_settings.resolve_min_max_sig(v63.precision, v73)
        v64 = v73
        v65 = v74
    elseif v72 then
        v68 = formatter_settings.resolve_min_max_sig(v63.precision, 1)
        v64 = 1
    end
    if not (v64 < min) then
        if max == -1 then
            min = v64
        elseif max < v64 then
            min = max
        else
            min = nil
        end
    end
    local v76 = math.max(v64, 0) - min + 1
    local v77 = math.max(v70, v68)
    local v78, v79 = v1.resolve_int_frac(v59, v70, v64, v76, v77, v63.minGrouping, symbols[enums.ENumberFormatSymbols.kGroupingSeparatorSymbol])
    if v63.alwaysDisplayDecimal or v79 ~= "" then
        v78 ..= symbols[enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] .. v79
    end
    if v65 then
        v78 ..= v65
    end
    return v78, v72
end

function v1.display_sign(v80, v81, v82, v83, v84) -- line 250 | captures: enums
    local v85, v86
    if v81 then
        v85 = v84[enums.ENumberFormatSymbols.kMinusSignSymbol]
        if v82 then
            v86 = v83.negativeZero
        else
            v86 = v83.negative
        end
    else
        v85 = v84[enums.ENumberFormatSymbols.kPlusSignSymbol]
        if v82 then
            v86 = v83.positiveZero
        else
            v86 = v83.positive
        end
    end
    if v86 then
        return v85 .. v80
    end
    return v80
end

return table.freeze(v1)
