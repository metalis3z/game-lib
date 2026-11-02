
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local LocalPlayer = game.Players.LocalPlayer
local Selection = LocalPlayer.PlayerGui.CharacterSelection.Selection

Lib.Buttons.OnActivate(script.Parent, function() --[[ Line: 10 | Upvalues: Lib (copy), LocalPlayer (copy), Selection (copy) ]]
	Lib.Buttons.ChangeVisibility(LocalPlayer.PlayerGui.CharacterSelection.PremadeSelection)

	local Text = Selection.Nametag.Text

	game.ReplicatedStorage.Events.Morph:InvokeServer("Characters", script.Parent.Name)
end)