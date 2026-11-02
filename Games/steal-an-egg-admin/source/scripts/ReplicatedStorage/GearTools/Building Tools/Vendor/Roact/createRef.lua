-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Binding = require(script.Parent.Binding)

local function createRef() -- line 7 | captures: Binding
    local v1 = Binding.create(nil)
    local v2 = {}
    local v3 = {}

    function v3.__index(v4, v5) -- line 16 | captures: v1
        if v5 == "current" then
            return v1:getValue()
        end
        return v1[v5]
    end

    function v3.__newindex(v6, v7, v8) -- line 23 | captures: v1
        if v7 == "current" then
            error("Cannot assign to the 'current' property of refs", 2)
        end
        v1[v7] = v8
    end

    function v3.__tostring(v9) -- line 30 | captures: v1
        local function v10(...)
            return (tostring(...))
        end

        return ("RoactRef(%s)"):format((v10(v1:getValue())))
    end

    setmetatable(v2, v3)
    return v2
end

return createRef
