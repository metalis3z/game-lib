--credit to quartz games studio
local FastFlags = require(game.ReplicatedStorage.UserGenerated.FastFlags)
local v1 = require(script.Parent)
local v2 = FastFlags.Replicated("UserGenerated.Logging.ClientLevel", v1.AssertLevel, "Warn")

v1.SetLevel(v2:Get())
v2.Changed:Connect(function(p1) --[[ Line: 27 | Upvalues: v1 (copy) ]]
	v1.SetLevel(p1)
end)