-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate = require(Parent.Graph.evaluate)

local function change(v1) -- line 23 | captures: External, evaluate
    if v1.validity == "busy" then
        return External.logError("infiniteLoop")
    end
    if not evaluate(v1, true) then
        return
    end
    local v2 = {}
    local v3 = {}
    local v4 = {}
    v2[1] = v1
    local v5 = os.clock() + 1 * External.safetyTimerMultiplier
    while true do
        if v5 < os.clock() then
            return External.logError("infiniteLoop")
        end
        local v6 = true
        for v7, v8 in v2 do
            local v9 = v6
            for v10 in v8.dependentSet do
                if v10.validity == "valid" then
                    table.insert(v4, v10)
                    table.insert(v3, v10)
                    v9 = false
                elseif v10.validity == "busy" then
                    return External.logError("infiniteLoop")
                end
                v6 = v9
            end
        end
        table.clear(v2)
        if v6 then
            break
        end
        v2, v3 = v3, v2
    end
    local v11 = {}
    for v12, v13 in v4 do
        v13.validity = "invalid"
        if v13.timeliness == "eager" then
            table.insert(v11, v13)
        end
    end
    table.sort(v11, function(v14, v15) -- line 73
        return v14.createdAt < v15.createdAt
    end)
    for v16, v17 in v11 do
        evaluate(v17, false)
    end
end

return change
