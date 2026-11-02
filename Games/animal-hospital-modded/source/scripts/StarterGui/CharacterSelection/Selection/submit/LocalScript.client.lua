
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local Selection = game.Players.LocalPlayer.PlayerGui.CharacterSelection.Selection

Lib.Buttons.OnActivate(script.Parent, function() --[[ Line: 10 | Upvalues: Selection (copy) ]]
	game.ReplicatedStorage.Events.ChangeRPName:InvokeServer(Selection.Nametag.Text)
end)