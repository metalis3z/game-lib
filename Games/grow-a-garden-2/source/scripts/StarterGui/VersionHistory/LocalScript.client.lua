--credit to prince games studio
if game:GetService("RunService"):IsStudio() ~= true and (game.Players.LocalPlayer.Name ~= "BMWLux" and (game.Players.LocalPlayer.Name ~= "UGDataX" and game.Players.LocalPlayer.Name ~= "DevNamedDavid")) then
	return
end

script.Parent.Enabled = true

local TextLabel = script.Parent.TextLabel

TextLabel.Text = "v" .. tostring(game.PlaceVersion)