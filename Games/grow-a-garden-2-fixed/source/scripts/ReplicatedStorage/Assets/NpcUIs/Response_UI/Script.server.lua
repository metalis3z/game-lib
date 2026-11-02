--credit to quartz games studio
local TopText = require(game.ReplicatedStorage.ClientModules.TopText)

task.wait(math.random(8, 12) * 0.2)

if not script or (not script.Parent or script.Parent == nil) then
	return
end

TopText.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer)