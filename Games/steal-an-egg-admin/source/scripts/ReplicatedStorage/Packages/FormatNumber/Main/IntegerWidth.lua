-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local v3 = _internal.class.create_init_function("IntegerWidth", nil, v2, nil, _internal.class.ImmutabilityType.DEFAULT)

function v2.TruncateAt(v4, v5) -- line 10 | captures: _internal, v3
    local IntegerWidth = _internal.class.try_coerce(1, v4, "IntegerWidth")
    local v6
    if tonumber(v5) and math.ceil(v5) == -1 then
        v6 = -1
    else
        v6 = _internal.class.try_coerce_range(1, v5, IntegerWidth.min, 999)
    end
    return v3({
        min = IntegerWidth.min,
        max = v6
    })
end

function v1.zeroFillTo(v7) -- line 22 | captures: _internal, v3
    local v8 = _internal.class.try_coerce_range(1, v7, 0, 999)
    return v3({
        max = -1,
        min = v8
    })
end

return table.freeze(v1)
