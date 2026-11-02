
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local LocalPlayer = game.Players.LocalPlayer
local v2 = false

Lib.Buttons.OnActivate(script.Parent, function() --[[ Line: 10 | Upvalues: v2 (ref), LocalPlayer (copy) ]]
	if v2 == false then
		v2 = true
		LocalPlayer.PlayerGui.Actions.Enabled = true
	else
		v2 = false
		LocalPlayer.PlayerGui.Actions.Enabled = false
	end
end)