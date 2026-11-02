-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local v3 = _internal.class.create_init_function("DecimalFormatSymbols", nil, v2, nil, _internal.class.ImmutabilityType.SYMBOLS)

function v2.GetSymbol(v4, v5) -- line 10 | captures: _internal
    return _internal.class.try_coerce(1, v4, "DecimalFormatSymbols")[_internal.class.try_coerce_enum(2, v5, _internal.enums.ENumberFormatSymbols)]
end

function v2.SetSymbol(v6, v7, v8) -- line 14 | captures: _internal
    _internal.class.try_coerce(1, v6, "DecimalFormatSymbols")[_internal.class.try_coerce_enum(2, v7, _internal.enums.ENumberFormatSymbols)] = _internal.class.try_coerce(3, v8, "string")
end

function v1.createWithLastResortData() -- line 19 | captures: _internal, v3
    local v9 = {}
    v9[_internal.enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = "."
    v9[_internal.enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = ""
    v9[_internal.enums.ENumberFormatSymbols.kMinusSignSymbol] = "-"
    v9[_internal.enums.ENumberFormatSymbols.kPlusSignSymbol] = "+"
    v9[_internal.enums.ENumberFormatSymbols.kExponentialSymbol] = "E"
    v9[_internal.enums.ENumberFormatSymbols.kInfinitySymbol] = "\226\136\158"
    v9[_internal.enums.ENumberFormatSymbols.kNaNSymbol] = "\239\191\189"
    return v3(v9)
end

return table.freeze(v1)
