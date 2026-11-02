-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local v3 = _internal.class.create_init_function("Notation", nil, v1, nil, _internal.class.ImmutabilityType.DEFAULT)
local v4 = {}
local v5 = _internal.class.create_init_function("ScientificNotation", "Notation", v4, v2, _internal.class.ImmutabilityType.DEFAULT)

function v4.WithMinExponentDigits(v6, v7) -- line 12 | captures: _internal, v5
    local ScientificNotation = _internal.class.try_coerce(1, v6, "ScientificNotation")
    local v8 = _internal.class.try_coerce_range(2, v7, 1, 999)
    local v9 = table.clone(ScientificNotation)
    v9.minExponentDigits = v8
    return v5(v9)
end

function v4.WithExponentSignDisplay(v10, v11) -- line 19 | captures: _internal, v5
    local ScientificNotation = _internal.class.try_coerce(1, v10, "ScientificNotation")
    local v12 = _internal.class.try_coerce_enum(2, v11, _internal.enums.SignDisplay)
    local v13 = table.clone(ScientificNotation)
    v13.exponentSignDisplay = v12
    v13.displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(v12)
    return v5(v13)
end

_internal.class.create_init_function("CompactNotation", "Notation", {}, v2, _internal.class.ImmutabilityType.DEFAULT)
_internal.class.create_init_function("SimpleNotation", "Notation", {}, v2, _internal.class.ImmutabilityType.DEFAULT)

function v1.scientific() -- line 29 | captures: _internal, v5
    return v5({
        power10Scale = 1,
        minExponentDigits = 1,
        type = _internal.enums._Internal.NotationType.SCIENTIFIC,
        exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
        displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO)
    })
end

function v1.engineering() -- line 38 | captures: _internal, v5
    return v5({
        power10Scale = 3,
        minExponentDigits = 1,
        type = _internal.enums._Internal.NotationType.SCIENTIFIC,
        exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
        displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO)
    })
end

function v1.compactWithSuffixThousands(v14) -- line 47 | captures: _internal, v3
    local v15 = _internal.class.try_coerce(1, v14, "{string}")
    local v16 = table.find(v15, "")
    if v16 then
        local v17 = string.format("Index %d is an empty string, please double check the suffixes", v16)
        error(v17, 2)
    elseif #v15 == 0 then
        error("Suffixes is empty", 2)
    end
    return v3({
        power10Scale = 3,
        type = _internal.enums._Internal.NotationType.COMPACT,
        suffixes = v15,
        suffixesLength = #v15
    })
end

function v1.simple() -- line 58 | captures: _internal, v3
    return v3({ type = _internal.enums._Internal.NotationType.SIMPLE })
end

return table.freeze(v1)
