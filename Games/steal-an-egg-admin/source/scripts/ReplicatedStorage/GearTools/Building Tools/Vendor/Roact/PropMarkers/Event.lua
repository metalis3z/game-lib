-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Type = require(script.Parent.Parent.Type)
local v1 = {}
local v2 = {
    __tostring = function(v3) -- __tostring | line 21
        return ("RoactHostEvent(%s)"):format(v3.name)
    end
}
local v4 = {}

function v4.__index(v5, v6) -- line 27 | captures: Type, v1, v2
    local v7 = {}
    v7[Type] = Type.HostEvent
    v7.name = v6
    setmetatable(v7, v2)
    v1[v6] = v7
    return v7
end

setmetatable(v1, v4)
return v1
