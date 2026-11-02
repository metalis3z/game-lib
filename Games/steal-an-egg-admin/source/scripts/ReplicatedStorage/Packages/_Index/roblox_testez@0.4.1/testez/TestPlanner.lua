-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestPlan = require(script.Parent.TestPlan)
local v1 = {}

function v1.createPlan(v2, v3, v4) -- line 8 | captures: TestPlan
    local v5 = TestPlan.new(v3, v4)
    table.sort(v2, function(v6, v7) -- line 10
        return v6.pathStringForSorting < v7.pathStringForSorting
    end)
    for v8, v9 in ipairs(v2) do
        v5:addRoot(v9.path, v9.method)
    end
    return v5
end

return v1
