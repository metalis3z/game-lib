
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.UserGenerated.FastFlags)
local v3 = require(v1.UserGenerated.Lang.Asserts)
return table.freeze({
    ["DraggingThreshold"] = v2.Replicated("ActionController.DraggingThreshold", v3.Finite, 4),
    ["TouchDuration"] = v2.Replicated("ActionController.TouchDuration", v3.Finite, 0.2)
})