-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local scopePool = require(Parent.Memory.scopePool)
local poisonScope = require(Parent.Memory.poisonScope)
local v1 = {}
local doCleanup

local function doCleanup_2(v2) -- line 24 | captures: External, scopePool, poisonScope, v1, doCleanup
    if v1[v2] then
        return External.logError("destroyedTwice")
    end
    v1[v2] = true
    if typeof(v2) == "Instance" then
        v2:Destroy()
    elseif typeof(v2) == "RBXScriptConnection" then
        v2:Disconnect()
    elseif typeof(v2) == "function" then
        v2()
    elseif typeof(v2) == "table" then
        local destroy = v2.destroy
        if typeof(destroy) == "function" then
            v2:destroy()
        else
            local Destroy = v2.Destroy
            if typeof(Destroy) == "function" then
                v2:Destroy()
            elseif v2[1] ~= nil then
                local v3 = #v2
                for v4 = v3, 1, -1 do
                    doCleanup(v2[v4])
                    v2[v4] = nil
                end
                if External.isTimeCritical() then
                    scopePool.giveIfEmpty(v2)
                else
                    poisonScope(v2, "`doCleanup()` was previously called on this scope. Ensure you are not reusing scopes after cleanup.")
                end
            end
        end
    end
    v1[v2] = nil
end

doCleanup = doCleanup_2
return doCleanup_2
