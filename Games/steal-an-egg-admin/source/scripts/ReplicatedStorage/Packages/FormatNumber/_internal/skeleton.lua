-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local formatter_settings = require(script.Parent.formatter_settings)
local enums = require(script.Parent.enums)
local v1 = {}
local v2 = {}

v2[enums.SignDisplay.AUTO] = nil
v2[enums.SignDisplay.ALWAYS] = "sign-always"
v2[enums.SignDisplay.NEVER] = "sign-never"
v2[enums.SignDisplay.EXCEPT_ZERO] = "sign-except-zero"
v2[enums.SignDisplay.NEGATIVE] = "sign-negative"

local function notation_to_skeleton(v3) -- line 15 | captures: enums, v2
    if v3.type == enums._Internal.NotationType.SCIENTIFIC then
        local v4 = if v3.power10Scale == 3 then "engineering" else "scientific"
        if v3.minExponentDigits ~= 1 then
            v4 ..= "/*" .. string.rep("e", v3.minExponentDigits)
        end
        if v3.exponentSignDisplay == enums.SignDisplay.AUTO then
            return true, v4
        end
        return true, v4 .. "/" .. v2[v3.exponentSignDisplay]
    end
    if v3.type == enums._Internal.NotationType.SIMPLE then
        return true, nil
    end
    return false, "Compact notation skeleton is not supported for being represented as a skeleton string in this module"
end

local function precision_to_skeleton(v5) -- line 37 | captures: formatter_settings, enums
    local minFractionDigits, maxFractionDigits, v6, v7, v8
    if v5.type == enums._Internal.PrecisionType.FRACTION then
        v8, minFractionDigits, maxFractionDigits, v6, v7 = nil, v5.min, v5.max, nil, nil
    elseif v5.type == enums._Internal.PrecisionType.SIGNFICANT then
        v8, minFractionDigits, maxFractionDigits, v6, v7 = nil, nil, nil, v5.min, v5.max
    elseif v5.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
        minFractionDigits = v5.minFractionDigits
        maxFractionDigits = v5.maxFractionDigits
        if v5.sourcedWithSignificantDigits then
            v8, v6, v7 = nil, v5.minSignificantDigits, v5.maxSignificantDigits
        elseif v5.roundingPriority == enums.RoundingPriority.RELAXED then
            v8, v6, v7 = nil, v5.maxSignificantDigits, formatter_settings.MAX_PRECISION
        else
            v8, v6, v7 = nil, 1, v5.maxSignificantDigits
        end
    else
        v8 = "precision-unlimited"
    end
    local v9
    if minFractionDigits then
        if maxFractionDigits == 0 then
            v9 = "precision-integer"
        else
            local v10 = "." .. string.rep("0", minFractionDigits)
            if maxFractionDigits == formatter_settings.MAX_PRECISION then
                v9 = v10 .. "*"
            else
                v9 = v10 .. string.rep("#", maxFractionDigits - minFractionDigits)
            end
        end
    end
    local v11
    if v6 then
        local v12 = string.rep("@", v6)
        if v7 == formatter_settings.MAX_PRECISION then
            v11 = v12 .. "*"
        else
            v11 = v12 .. string.rep("#", v7 - v6)
        end
    end
    if v9 then
        if v11 then
            local v13 = v9 .. "/" .. v11
            if not (v5.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT and v5.sourcedWithSignificantDigits) then
                return v13
            end
            if v5.roundingPriority == enums.RoundingPriority.RELAXED then
                return v13 .. "r"
            end
            return v13 .. "s"
        end
        return v9
    end
    return v11 or v8
end

local v14 = {}

v14[enums.RoundingMode.CEILING] = "rounding-mode-ceiling"
v14[enums.RoundingMode.FLOOR] = "rounding-mode-floor"
v14[enums.RoundingMode.DOWN] = "rounding-mode-down"
v14[enums.RoundingMode.UP] = "rounding-mode-up"
v14[enums.RoundingMode.HALF_EVEN] = "rounding-mode-half-even"
v14[enums.RoundingMode.HALF_DOWN] = "rounding-mode-half-down"
v14[enums.RoundingMode.HALF_UP] = "rounding-half-up"

local v15 = {}

v15[enums.GroupingStrategy.OFF] = "group-off"
v15[enums.GroupingStrategy.MIN2] = "group-min2"
v15[enums.GroupingStrategy.ON_ALIGNED] = "group-on-aligned"

local function int_width_to_skeleton(v16) -- line 118
    if v16.max == -1 then
        return "integer-width/*" .. string.rep("0", v16.min)
    end
    if v16.max == 0 and v16.min == 0 then
        return "integer-width-trunc"
    end
    return "integer-width/" .. string.rep("#", v16.max - v16.min) .. string.rep("0", v16.min)
end

local v17 = {}

v17[enums.DecimalSeparatorDisplay.AUTO] = nil
v17[enums.DecimalSeparatorDisplay.ALWAYS] = "decimal-always"

function v1.settings_to_skeleton(v18) -- line 136 | captures: notation_to_skeleton, precision_to_skeleton, v14, v15, int_width_to_skeleton, v17
    local v19 = {}
    local v20, v21
    if v18.notation then
        v20, v21 = notation_to_skeleton(v18.notation)
        if v20 then
            table.insert(v19, v21)
            v21 = nil
        end
    else
        v20 = true
    end
    local v22
    if v20 then
        if v18.precision then
            local v23 = precision_to_skeleton(v18.precision)
            table.insert(v19, v23)
        end
        if v18.roundingMode then
            local v24 = v14[v18.roundingMode]
            table.insert(v19, v24)
        end
        if v18.grouping then
            local v25 = v15[v18.grouping]
            table.insert(v19, v25)
        end
        if v18.integerWidth then
            local v26 = int_width_to_skeleton(v18.integerWidth)
            table.insert(v19, v26)
        end
        if v18.decimal then
            local v27 = v17[v18.decimal]
            table.insert(v19, v27)
        end
        v22 = table.concat(v19, " ")
    else
        v22 = v21
    end
    return v20, v22
end

local v28 = {}

v28["notation-simple"] = "notation"
v28["precision-unlimited"] = "precision"
v28[".+"] = "precision"
v28["rounding-mode-ceiling"] = "roundingMode"
v28["rounding-mode-floor"] = "roundingMode"
v28["rounding-mode-down"] = "roundingMode"
v28["rounding-mode-up"] = "roundingMode"
v28["rounding-mode-half-even"] = "roundingMode"
v28["rounding-mode-half-down"] = "roundingMode"
v28["rounding-mode-half-up"] = "roundingMode"
v28["group-off"] = "grouping"
v28["group-min2"] = "grouping"
v28["group-on-aligned"] = "grouping"
v28[",_"] = "grouping"
v28[",?"] = "grouping"
v28[",!"] = "grouping"
v28["sign-auto"] = "sign"
v28["sign-always"] = "sign"
v28["sign-never"] = "sign"
v28["sign-except-zero"] = "sign"
v28["sign-negative"] = "sign"
v28["+!"] = "sign"
v28["+_"] = "sign"
v28["+?"] = "sign"
v28["+-"] = "sign"
v28["decimal-auto"] = "decimal"
v28["decimal-always"] = "decimal"

local v29 = {}

v29["notation-simple"] = table.freeze({ type = enums._Internal.NotationType.SIMPLE })
v29["precision-unlimited"] = table.freeze({ type = enums._Internal.PrecisionType.UNLIMITED })

local v30 = { type = enums._Internal.PrecisionType.UNLIMITED }

v29[".+"] = table.freeze(v30)
v29["rounding-mode-ceiling"] = enums.RoundingMode.CEILING
v29["rounding-mode-floor"] = enums.RoundingMode.FLOOR
v29["rounding-mode-down"] = enums.RoundingMode.DOWN
v29["rounding-mode-up"] = enums.RoundingMode.UP
v29["rounding-mode-half-even"] = enums.RoundingMode.HALF_EVEN
v29["rounding-mode-half-down"] = enums.RoundingMode.HALF_DOWN
v29["rounding-mode-half-up"] = enums.RoundingMode.HALF_UP
v29["group-off"] = enums.GroupingStrategy.OFF
v29["group-min2"] = enums.GroupingStrategy.MIN2
v29["group-on-aligned"] = enums.GroupingStrategy.ON_ALIGNED
v29[",_"] = enums.GroupingStrategy.OFF
v29[",?"] = enums.GroupingStrategy.MIN2
v29[",!"] = enums.GroupingStrategy.ON_ALIGNED
v29["sign-auto"] = enums.SignDisplay.AUTO
v29["sign-always"] = enums.SignDisplay.ALWAYS
v29["sign-never"] = enums.SignDisplay.NEVER
v29["sign-except-zero"] = enums.SignDisplay.EXCEPT_ZERO
v29["sign-negative"] = enums.SignDisplay.NEGATIVE
v29["+!"] = enums.SignDisplay.ALWAYS
v29["+_"] = enums.SignDisplay.NEVER
v29["+?"] = enums.SignDisplay.EXCEPT_ZERO
v29["+-"] = enums.SignDisplay.NEGATIVE
v29["decimal-auto"] = enums.DecimalSeparatorDisplay.AUTO
v29["decimal-always"] = enums.DecimalSeparatorDisplay.ALWAYS

local function skeleton_to_scientific_notation(v31) -- line 228 | captures: formatter_settings, enums, v29
    local v32, v33, v34 = string.match(v31, "^(%a+)/?([^/]*)/?([^/]*)$")
    local AUTO = enums.SignDisplay.AUTO
    if v32 == "scientific" then
        local v35
        if string.match(v33, "^[%*%+]e+$") then
            v35 = #v33 - 1
        elseif string.match(v34, "^[%*%+]e+$") then
            v34, v35 = v33, #v34 - 1
        else
            v34 = v33
            v35 = 1
        end
        if v34 == "" then
            if v35 > 999 then
                return nil
            end
            local v36 = { type = enums._Internal.NotationType.SCIENTIFIC }
            if v32 == "engineering" then
                v36.power10Scale = 3
            else
                v36.power10Scale = 1
            end
            v36.minExponentDigits = v35
            v36.exponentSignDisplay = AUTO
            v36.displayExponentSignAt = formatter_settings.generate_from_sign_enum(AUTO)
            return table.freeze(v36)
        end
        if string.sub(v34, 1, 5) == "sign-" then
            local v37 = v29[v34]
            if v35 > 999 then
                return nil
            end
            local v38 = { type = enums._Internal.NotationType.SCIENTIFIC }
            if v32 == "engineering" then
                v38.power10Scale = 3
            else
                v38.power10Scale = 1
            end
            v38.minExponentDigits = v35
            v38.exponentSignDisplay = v37
            v38.displayExponentSignAt = formatter_settings.generate_from_sign_enum(v37)
            return table.freeze(v38)
        end
    elseif v32 == "engineering" then
        return
    end
    return nil
end

local function skeleton_to_scientific_notation_concise(v39) -- line 279 | captures: formatter_settings, enums, v29
    local v40, v41 = string.match(v39, "^(EE?)(.+)$")
    if v40 then
        local v42, v43 = string.match(v41, "^(%+[!%?])(.+)$")
        local v44
        if v42 then
            v44 = v29[v42]
        else
            v44 = enums.SignDisplay.AUTO
            v43 = v41
        end
        local v45, v46, v47
        if string.match(v43, "^0+$") then
            if #v43 > 999 then
                v47 = true
            else
                v45 = { type = enums._Internal.NotationType.SCIENTIFIC }
                if v40 == "EE" then
                    v46 = 3
                else
                    v46 = 1
                end
                v47 = false
            end
        else
            v47 = true
        end
        if v47 then
            return nil
        end
        v45.power10Scale = v46
        v45.minExponentDigits = #v43
        v45.exponentSignDisplay = v44
        v45.displayExponentSignAt = formatter_settings.generate_from_sign_enum(v44)
        return table.freeze(v45)
    end
    return nil
end

local function skeleton_to_precision(v48) -- line 312 | captures: formatter_settings, enums
    local v49, v50, v51 = string.match(v48, "^%.((0*)#*)(.*)$")
    if not v49 then
        v49, v51 = string.match(v48, "^(precision%-integer)(.*)$")
    end
    if v49 then
        local v52, v53
        if v49 == "precision-integer" then
            v52 = 0
            v53 = 0
        else
            v52, v53 = #v50, #v49
        end
        if string.match(v51, "^[%*%+]") and v50 == v49 then
            v51 = string.sub(v51, 2)
            v53 = -1
        end
        if not (v52 > 999) and not (v53 > 999) then
            if v53 == -1 then
                v53 = formatter_settings.MAX_PRECISION
            end
            if string.sub(v51, 1, 1) == "/" then
                local v54, v55, v56 = string.match(v51, "^/((@+)#*)([%*%+rs]?)$")
                if v54 then
                    local v57 = v56 == ""
                    local v58, v59
                    if v57 then
                        v59 = v55 == "@"
                    else
                        if v56 == "*" then
                            local v60, v61, v62, v63
                            if v55 == v54 then
                                if v56 == "" then
                                    v62, v63, v61, v60 = "s", false, #v54, 1
                                elseif v56 == "*" or v56 == "+" then
                                    v62, v63, v61, v60 = "r", false, #v55, 1
                                else
                                    v60 = #v55
                                    v62, v63, v61 = v56, true, #v54
                                end
                            else
                                return nil
                            end
                            if v60 > 999 or v61 > 999 then
                                return nil
                            end
                            local v64 = {
                                type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
                                minFractionDigits = v52,
                                maxFractionDigits = v53,
                                minSignificantDigits = v60,
                                maxSignificantDigits = v61
                            }
                            if v62 == "r" then
                                v64.roundingPriority = enums.RoundingPriority.RELAXED
                            else
                                v64.roundingPriority = enums.RoundingPriority.STRICT
                            end
                            v64.sourcedWithSignificantDigits = v63
                            return table.freeze(v64)
                        end
                        v58 = v56 == "+"
                    end
                    if not (v57 and v59 or not v57 and v58) and v57 then
                        return nil
                    end
                    return
                end
            elseif v51 == "" then
                return table.freeze({
                    type = enums._Internal.PrecisionType.FRACTION,
                    min = v52,
                    max = v53
                })
            end
        end
    else
        local v65, v66, v67 = string.match(v48, "^((@+)#*)([%*%+]?)$")
        if v65 then
            local v68 = #v66
            local v69 = #v65
            if v67 == "" then
                if v68 <= 999 then
                    if v69 > 999 then
                        return nil
                    end
                    if v69 == -1 then
                        v69 = formatter_settings.MAX_PRECISION
                    end
                    return table.freeze({
                        type = enums._Internal.PrecisionType.SIGNFICANT,
                        min = v68,
                        max = v69
                    })
                end
            elseif v68 == v69 and not (v68 > 999 or 999 < -1) then
                local MAX_PRECISION = formatter_settings.MAX_PRECISION
                return table.freeze({
                    type = enums._Internal.PrecisionType.SIGNFICANT,
                    min = v68,
                    max = MAX_PRECISION
                })
            end
        end
    end
    return nil
end

local function skeleton_to_int_width(v70) -- line 441
    if v70 == "integer-width-trunc" then
        return table.freeze({
            min = 0,
            max = 0
        })
    end
    local v71 = string.match(v70, "^integer%-width/[%*%+](0*)$")
    if v71 then
        if #v71 > 999 then
            return nil
        end
        return table.freeze({
            max = -1,
            min = #v71
        })
    end
    local v72, v73 = string.match(v70, "^integer%-width/(#*(0*))$")
    if v72 and v72 ~= "" and not (#v72 > 999) and not (#v73 > 999) then
        return table.freeze({
            min = #v73,
            max = #v72
        })
    end
    return nil
end

local function skeleton_to_int_width_concise(v74) -- line 461
    if not string.match(v74, "^0+$") or #v74 >= 1000 then
        return nil
    end
    local v75 = {
        max = -1,
        min = #v74
    }
    return (table.freeze(v75))
end

function v1.to_option_linked_list(v76) -- line 468 | captures: v28, v29, skeleton_to_scientific_notation, skeleton_to_scientific_notation_concise, skeleton_to_precision, skeleton_to_int_width, skeleton_to_int_width_concise
    local v77 = {}
    local v78
    for v79, v80 in string.gmatch(v76, "()(%S+)") do
        local v81 = v28[v80]
        local v82 = if v81 then v29[v80] else nil
        if not v82 then
            v82 = skeleton_to_scientific_notation(v80) or skeleton_to_scientific_notation_concise(v80)
            if v82 then
                v81 = "notation"
            end
        end
        if not v82 then
            v82 = skeleton_to_precision(v80)
            if v82 then
                v81 = "precision"
            end
        end
        if not v82 then
            v82 = skeleton_to_int_width(v80) or skeleton_to_int_width_concise(v80)
            if v82 then
                v81 = "integerWidth"
            end
        end
        if v81 then
            if v77[v81] then
                local v83 = string.gsub(v80, "'", "\\'")
                return false, string.format("number skeleton syntax error near '%*' at position %d", v83, v79)
            end
            v77[v81] = true
            v78 = {
                key = v81,
                value = v82,
                parent = v78
            }
        else
            local v84 = string.gsub(v80, "'", "\\'")
            return false, string.format("number skeleton syntax error near '%*' at position %d", v84, v79)
        end
    end
    return true, v78
end

return v1
