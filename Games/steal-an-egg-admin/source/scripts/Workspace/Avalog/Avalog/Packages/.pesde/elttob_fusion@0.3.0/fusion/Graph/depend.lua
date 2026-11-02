-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate = require(Parent.Graph.evaluate)
local nameOf = require(Parent.Utility.nameOf)

local function depend(v1, v2) -- line 16 | captures: External, evaluate, nameOf
    evaluate(v2, false)
    if table.isfrozen(v1.dependencySet) or table.isfrozen(v2.dependentSet) then
        External.logError("cannotDepend", nil, nameOf(v1, "Dependent"), nameOf(v2, "dependency"))
    end
    v2.dependentSet[v1] = true
    v1.dependencySet[v2] = true
end

return depend
