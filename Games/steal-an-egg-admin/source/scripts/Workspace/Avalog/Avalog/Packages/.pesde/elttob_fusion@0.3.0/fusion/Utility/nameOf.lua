-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local nicknames = require(script.Parent.Parent.Utility.nicknames)

local function nameOf(v1, v2) -- line 14 | captures: nicknames
    local v3 = nicknames[v1]
    if typeof(v3) == "string" then
        return v3
    end
    if typeof(v1) == "table" then
        local name = v1.name
        if typeof(name) == "string" then
            return v1.name
        end
        local kind = v1.kind
        if typeof(kind) == "string" then
            return v1.kind
        end
        local type = v1.type
        if typeof(type) == "string" then
            return v1.type
        end
    end
    return v2
end

return nameOf
