-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _internal = require(script.Parent._internal)
local Notation = require(script.Notation)
local Precision = require(script.Precision)
local IntegerWidth = require(script.IntegerWidth)
local DecimalFormatSymbols = require(script.DecimalFormatSymbols)
local enums = _internal.enums
local v1 = {}
local v2 = {}
local v3 = _internal.class.create_init_function("NumberFormatter", nil, v2, nil, _internal.class.ImmutabilityType.NUMBER_FORMATTER)

function v2.Notation(v4, v5) -- line 15 | captures: _internal, v3
    _internal.class.try_coerce(1, v4, "NumberFormatter")
    local Notation = _internal.class.try_coerce(2, v5, "Notation")
    return v3({
        key = "notation",
        value = Notation,
        parent = _internal.class.get_data(v4)
    })
end

function v2.Precision(v6, v7) -- line 20 | captures: _internal, v3
    _internal.class.try_coerce(1, v6, "NumberFormatter")
    local Precision = _internal.class.try_coerce(2, v7, "Precision")
    return v3({
        key = "precision",
        value = Precision,
        parent = _internal.class.get_data(v6)
    })
end

function v2.RoundingMode(v8, v9) -- line 25 | captures: _internal, enums, v3
    _internal.class.try_coerce(1, v8, "NumberFormatter")
    local v10 = _internal.class.try_coerce_enum(2, v9, enums.RoundingMode)
    return v3({
        key = "roundingMode",
        value = v10,
        parent = _internal.class.get_data(v8)
    })
end

function v2.Grouping(v11, v12) -- line 30 | captures: _internal, enums, v3
    _internal.class.try_coerce(1, v11, "NumberFormatter")
    local v13 = _internal.class.try_coerce_enum(2, v12, enums.GroupingStrategy)
    return v3({
        key = "grouping",
        value = v13,
        parent = _internal.class.get_data(v11)
    })
end

function v2.IntegerWidth(v14, v15) -- line 35 | captures: _internal, v3
    _internal.class.try_coerce(1, v14, "NumberFormatter")
    local IntegerWidth = _internal.class.try_coerce(2, v15, "IntegerWidth")
    return v3({
        key = "integerWidth",
        value = IntegerWidth,
        parent = _internal.class.get_data(v14)
    })
end

function v2.Symbols(v16, v17) -- line 40 | captures: _internal, v3
    _internal.class.try_coerce(1, v16, "NumberFormatter")
    local DecimalFormatSymbols = _internal.class.try_coerce(2, v17, "DecimalFormatSymbols")
    return v3({
        key = "symbols",
        value = DecimalFormatSymbols,
        parent = _internal.class.get_data(v16)
    })
end

function v2.Sign(v18, v19) -- line 45 | captures: _internal, enums, v3
    _internal.class.try_coerce(1, v18, "NumberFormatter")
    local v20 = _internal.class.try_coerce_enum(2, v19, enums.SignDisplay)
    return v3({
        key = "sign",
        value = v20,
        parent = _internal.class.get_data(v18)
    })
end

function v2.Decimal(v21, v22) -- line 50 | captures: _internal, enums, v3
    _internal.class.try_coerce(1, v21, "NumberFormatter")
    local v23 = _internal.class.try_coerce_enum(2, v22, enums.DecimalSeparatorDisplay)
    return v3({
        key = "decimal",
        value = v23,
        parent = _internal.class.get_data(v21)
    })
end

local function resolve_nf_data(v24) -- line 55 | captures: _internal
    return _internal.formatter_settings.resolve_settings(_internal.formatter_settings.linked_list_to_dict(v24))
end

function v2.Format(v25, v26) -- line 58 | captures: _internal, enums, resolve_nf_data
    local function v27(...)
        return (string.byte(...))
    end

    _internal.class.try_coerce(1, v25, "NumberFormatter")
    if type(v26) == "string" then
        error("Argument #2 as a string interpreted as decimal is not currently supported, please cast the argument to a double if you want the string to be interpreted as a double", 2)
    end
    local number = _internal.class.try_coerce(2, v26, "number")
    local v28 = _internal.class.get_resolved_data(v25, resolve_nf_data)
    local symbols = v28.symbols
    local v29, v30, v31
    if number == number then
        if number == (1/0) then
            local v32 = number < 0
            v29 = symbols[enums.ENumberFormatSymbols.kInfinitySymbol]
            v31 = v32
            v30 = false
        elseif number == (-1/0) then
        else
            local v33, v34, v35, v36
            if number == 0 then
                v36 = math.atan2(number, -1) < 0
                v34 = 0
                v35 = 1
            else
                v36 = number < 0
                v33, v34, v35 = _internal.decimal_conversion.from_double((math.abs(number)))
            end
            v29, v30 = _internal.format.format_unsigned_finite(v33, v34, v35, v36, v28)
            v31 = v36
        end
    else
        local v37 = v27(string.pack(">d", number)) >= 128
        v29 = symbols[enums.ENumberFormatSymbols.kNaNSymbol]
        v31 = v37
        v30 = true
    end
    return (_internal.format.display_sign(v29, v31, v30, v28.displaySignAt, v28.symbols))
end

function v2.ToSkeleton(v38) -- line 98 | captures: _internal
    local NumberFormatter = _internal.class.try_coerce(1, v38, "NumberFormatter")
    return _internal.skeleton.settings_to_skeleton(_internal.formatter_settings.linked_list_to_dict(NumberFormatter))
end

function v1.with() -- line 102 | captures: v3
    return v3(nil)
end

function v1.forSkeleton(v39) -- line 105 | captures: _internal, v3
    local string = _internal.class.try_coerce(1, v39, "string")
    local v40, v41 = _internal.skeleton.to_option_linked_list(string)
    if v40 then
        return v40, (v3(v41))
    end
    return v40, v41
end

return table.freeze({
    NumberFormatter = table.freeze(v1),
    Notation = Notation,
    Precision = Precision,
    RoundingPriority = enums.RoundingPriority,
    RoundingMode = enums.RoundingMode,
    GroupingStrategy = enums.GroupingStrategy,
    IntegerWidth = IntegerWidth,
    DecimalFormatSymbols = DecimalFormatSymbols,
    ENumberFormatSymbols = enums.ENumberFormatSymbols,
    SignDisplay = enums.SignDisplay,
    DecimalSeparatorDisplay = enums.DecimalSeparatorDisplay
})
