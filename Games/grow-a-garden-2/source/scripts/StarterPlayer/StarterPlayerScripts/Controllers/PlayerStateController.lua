--credit to quartz games studio
local t = {
	StartOrder = 0
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)

function t.Init(p1) --[[ Init | Line: 8 ]] end
function t.Start(p1) --[[ Start | Line: 11 | Upvalues: PlayerStateClient (copy) ]]
	PlayerStateClient:GetLocalReplica()
end

return t