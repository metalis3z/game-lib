-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TopText = require(game.ReplicatedStorage.Library.Client.UI.TopText)

task.wait(math.random(8, 12) * 0.2)

if not script or (not script.Parent or script.Parent == nil) then
	return
end

TopText.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer)