-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Trove = require(script.Parent.Parent.Trove)
require(script.Parent.Streamable)
local v1 = {}

function v1.Compound(v2, v3) -- line 9 | captures: Trove
    local v4 = Trove.new()
    local v5 = Trove.new()
    local v6 = false

    local function Check() -- line 13 | captures: v6, v2, v3, v5
        if v6 then
            return
        end
        for v7, v8 in pairs(v2) do
            if not v8.Instance then
                return
            end
        end
        v6 = true
        v3(v2, v5)
    end

    local function Cleanup() -- line 25 | captures: v6, v5
        if v6 then
            v6 = false
            v5:Clean()
        end
    end

    for v9, v10 in pairs(v2) do
        v4:Add(v10:Observe(function(v11, v12) -- line 33 | captures: v6, v2, v3, v5, Cleanup
            if not v6 then
                for v13, v14 in pairs(v2) do
                    if not v14.Instance then
                        v12:Add(Cleanup)
                        return
                    end
                end
                v6 = true
                v3(v2, v5)
            end
            v12:Add(Cleanup)
        end))
    end
    v4:Add(Cleanup)
    return v4
end

return v1
