-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Types)
local v1

return {
    setDebugger = function(v2) -- setDebugger | line 26 | captures: v1
        local v3 = v1
        if v3 ~= nil then
            v3.stopDebugging()
        end
        v1 = v2
        if v2 ~= nil then
            v2.startDebugging()
        end
        return v3
    end,
    trackScope = function(v4) -- trackScope | line 46 | captures: v1
        if v1 ~= nil then
            v1.trackScope(v4)
        end
    end,
    untrackScope = function(v5) -- untrackScope | line 61 | captures: v1
        if v1 ~= nil then
            v1.trackScope(v5)
        end
    end
}
