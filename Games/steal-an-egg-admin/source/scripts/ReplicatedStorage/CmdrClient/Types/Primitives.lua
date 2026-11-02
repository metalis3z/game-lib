-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = {
    Validate = function(v2) -- Validate | line 8
        return v2 ~= nil
    end,
    Parse = function(v3) -- Parse | line 12
        return (tostring(v3))
    end
}
local v4 = {
    Transform = function(v5) -- Transform | line 17
        return (tonumber(v5))
    end,
    Validate = function(v6) -- Validate | line 20
        return v6 ~= nil
    end,
    Parse = function(v7) -- Parse | line 24
        return v7
    end
}
local v8 = {
    Transform = function(v9) -- Transform | line 29
        return (tonumber(v9))
    end,
    Validate = function(v10) -- Validate | line 32
        local v11 = if v10 == nil then false else v10 == math.floor(v10)
        return v11, "Only whole numbers are valid."
    end,
    Parse = function(v12) -- Parse | line 36
        return v12
    end
}
local v13 = {
    Transform = function(v14) -- Transform | line 41
        return (tonumber(v14))
    end,
    Validate = function(v15) -- Validate | line 44
        local v16
        if v15 == nil then
            v16 = false
        elseif v15 == math.floor(v15) then
            v16 = v15 > 0
        else
            v16 = false
        end
        return v16, "Only positive whole numbers are valid."
    end,
    Parse = function(v17) -- Parse | line 48
        return v17
    end
}
local v18 = {
    Transform = function(v19) -- Transform | line 53
        return (tonumber(v19))
    end,
    Validate = function(v20) -- Validate | line 56
        local v21
        if v20 == nil then
            v21 = false
        elseif v20 == math.floor(v20) then
            v21 = v20 >= 0
        else
            v21 = false
        end
        return v21, "Only non-negative whole numbers are valid."
    end,
    Parse = function(v22) -- Parse | line 60
        return v22
    end
}
local v23 = {
    Transform = function(v24) -- Transform | line 65
        return (tonumber(v24))
    end,
    Validate = function(v25) -- Validate | line 68
        local v26
        if v25 == nil then
            v26 = false
        elseif v25 == math.floor(v25) and v25 >= 0 then
            v26 = v25 <= 255
        else
            v26 = false
        end
        return v26, "Only bytes are valid."
    end,
    Parse = function(v27) -- Parse | line 72
        return v27
    end
}
local v28 = {
    Transform = function(v29) -- Transform | line 77
        return (tonumber(v29))
    end,
    Validate = function(v30) -- Validate | line 80
        local v31
        if v30 == nil then
            v31 = false
        elseif v30 == math.floor(v30) and v30 >= 0 then
            v31 = v30 <= 9
        else
            v31 = false
        end
        return v31, "Only digits are valid."
    end,
    Parse = function(v32) -- Parse | line 84
        return v32
    end
}
local v33 = Util.MakeDictionary({
    "true",
    "t",
    "yes",
    "y",
    "on",
    "enable",
    "enabled",
    "1",
    "+"
})
local v34 = Util.MakeDictionary({
    "false",
    "f",
    "no",
    "n",
    "off",
    "disable",
    "disabled",
    "0",
    "-"
})
local v35 = {
    Transform = function(v36) -- Transform | line 111
        return v36:lower()
    end
}

function v35.Validate(v37) -- line 114 | captures: v33, v34
    local v38 = if v33[v37] == nil then v34[v37] ~= nil else true
    return v38, "Please use true/yes/on or false/no/off."
end

function v35.Parse(v39) -- line 118 | captures: v33, v34
    if v33[v39] then
        return true
    end
    if v34[v39] then
        return false
    end
    return nil
end

return function(v40) -- line 128 | captures: Util, v1, v4, v8, v13, v18, v23, v28, v35
    v40:RegisterType("string", v1)
    v40:RegisterType("number", v4)
    v40:RegisterType("integer", v8)
    v40:RegisterType("positiveInteger", v13)
    v40:RegisterType("nonNegativeInteger", v18)
    v40:RegisterType("byte", v23)
    v40:RegisterType("digit", v28)
    v40:RegisterType("boolean", v35)
    v40:RegisterType("strings", Util.MakeListableType(v1))
    v40:RegisterType("numbers", Util.MakeListableType(v4))
    v40:RegisterType("integers", Util.MakeListableType(v8))
    v40:RegisterType("positiveIntegers", Util.MakeListableType(v13))
    v40:RegisterType("nonNegativeIntegers", Util.MakeListableType(v18))
    v40:RegisterType("bytes", Util.MakeListableType(v23))
    v40:RegisterType("digits", Util.MakeListableType(v28))
    v40:RegisterType("booleans", Util.MakeListableType(v35))
end
