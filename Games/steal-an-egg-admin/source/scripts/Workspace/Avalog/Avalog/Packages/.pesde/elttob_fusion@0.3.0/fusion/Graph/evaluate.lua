-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate

local function evaluate_2(v1, v2) -- line 17 | captures: External, evaluate
    if v1.validity == "busy" then
        return External.logError("infiniteLoop")
    end
    local v3 = v1.lastChange == nil
    local v4 = v1.validity == "invalid"
    if not v3 and not v4 and not v2 then
        return false
    end
    local v5 = v3 or v2
    if not v5 then
        for v6 in v1.dependencySet do
            evaluate(v6, false)
            local lastChange = v6.lastChange
            if v1.lastChange < lastChange then
                v5 = true
                break
            end
        end
    end
    local v7
    if v5 then
        for v8 in v1.dependencySet do
            v8.dependentSet[v1] = nil
            v1.dependencySet[v8] = nil
        end
        v1.validity = "busy"
        v7 = v1:_evaluate() or v3
    else
        v7 = false
    end
    if v7 then
        v1.lastChange = os.clock()
    end
    v1.validity = "valid"
    return v7
end

evaluate = evaluate_2
return evaluate_2
