
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local LocalPlayer = game.Players.LocalPlayer

Lib.Buttons.OnActivate(script.Parent, function() --[[ Line: 9 | Upvalues: Lib (copy), LocalPlayer (copy) ]]
	Lib.Buttons.ChangeVisibility(LocalPlayer.PlayerGui.Shop.Frame)
end)