-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = require("./task")
local v2 = require("./flags")

local function get_budget(v3) -- line 12 | captures: v2
    if game then
        local datastoreservice = v2.datastoreservice
        local v4
        if v3 == "get" then
            v4 = Enum.DataStoreRequestType.GetAsync
        elseif v3 == "get_version" then
            v4 = Enum.DataStoreRequestType.GetVersionAsync
        elseif v3 == "update" then
            v4 = Enum.DataStoreRequestType.UpdateAsync
        elseif v3 == "set" then
            v4 = Enum.DataStoreRequestType.SetIncrementAsync
        else
            v4 = error((("%* is not valid"):format(v3)))
        end
        return (datastoreservice:GetRequestBudgetForRequestType(v4))
    end
    return 1000
end

return {
    has_budget_and_delta = function(v5, v6) -- has_budget_and_delta | line 25 | captures: get_budget
        return v6 < get_budget(v5) - 5
    end,
    delay_until_meets_budget = function(v7, v8) -- delay_until_meets_budget | line 29 | captures: v1, get_budget
        while v8 < get_budget(v7) - 5 == false do
            v1.wait()
        end
    end,
    get_budget = get_budget
}
