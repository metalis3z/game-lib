

local v1 = game:GetService("ReplicatedStorage")
require(v1.UserGenerated.Concurrency.Bindable)
return table.freeze({
    ["UpdateRemote"] = script:WaitForChild("Update")
})