-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local whichLivesLonger = require(Parent.Memory.whichLivesLonger)
local nameOf = require(Parent.Utility.nameOf)
local v1 = {
    formatters = {}
}

local function useFunction(v2, v3) -- line 22 | captures: nameOf
    local object = nameOf(v2, "object")
    return ("The use()-d %*"):format((nameOf(v3, "object"))), (("the %*"):format(object))
end

v1.formatters.useFunction = useFunction

local function boundProperty(v4, v5, v6) -- line 31 | captures: nameOf
    local Name = v4.Name
    return ("The %* (bound to the %* property)"):format(nameOf(v5, "value"), v6), (("the %* instance"):format(Name))
end

v1.formatters.boundProperty = boundProperty

local function boundAttribute(v7, v8, v9) -- line 41 | captures: nameOf
    local Name = v7.Name
    return ("The %* (bound to the %* attribute)"):format(nameOf(v8, "value"), v9), (("the %* instance"):format(Name))
end

v1.formatters.boundAttribute = boundAttribute

local function propertyOutputsTo(v10, v11, v12) -- line 51 | captures: nameOf
    local Name = v10.Name
    return ("The %* (which the %* property outputs to)"):format(nameOf(v11, "object"), v12), (("the %* instance"):format(Name))
end

v1.formatters.propertyOutputsTo = propertyOutputsTo

local function attributeOutputsTo(v13, v14, v15) -- line 61 | captures: nameOf
    local Name = v13.Name
    return ("The %* (which the %* attribute outputs to)"):format(nameOf(v14, "object"), v15), (("the %* instance"):format(Name))
end

v1.formatters.attributeOutputsTo = attributeOutputsTo

local function refOutputsTo(v16, v17) -- line 71 | captures: nameOf
    local Name = v16.Name
    return ("The %* (which the Ref key outputs to)"):format((nameOf(v17, "object"))), (("the %* instance"):format(Name))
end

v1.formatters.refOutputsTo = refOutputsTo

local function animationGoal(v18, v19) -- line 80 | captures: nameOf
    local object = nameOf(v18, "object")
    return ("The goal %*"):format((nameOf(v19, "object"))), (("the %* that is following it"):format(object))
end

v1.formatters.animationGoal = animationGoal

local function parameter(v20, v21, v22) -- line 89 | captures: nameOf
    local object = nameOf(v20, "object")
    local object_2 = nameOf(v21, "object")
    if v22 == false then
        return ("The %* parameter"):format(object_2), (("the %* that it was used for"):format(object))
    end
    return ("The %* representing the %* parameter"):format(object_2, v22), (("the %* that it was used for"):format(object))
end

v1.formatters.parameter = parameter

local function observer(v23, v24) -- line 103 | captures: nameOf
    local object = nameOf(v23, "object")
    return ("The watched %*"):format((nameOf(v24, "object"))), (("the %* that's observing it for changes"):format(object))
end

v1.formatters.observer = observer

function v1.bOutlivesA(v25, v26, v27, v28, v29, ...) -- line 112 | captures: External, whichLivesLonger
    if v27 == nil then
        External.logError("useAfterDestroy", nil, v29(v26, v28, ...))
    elseif whichLivesLonger(v25, v26, v27, v28) == "definitely-a" then
        local v30, v31 = v29(v26, v28, ...)
        local logWarn = External.logWarn
        local v32 = if v25 == v27 then "they're in the same scope, but the latter is destroyed too quickly" else "the latter is in a different scope that gets destroyed too quickly"
        logWarn("possiblyOutlives", v30, v31, v32)
    end
end

return v1
