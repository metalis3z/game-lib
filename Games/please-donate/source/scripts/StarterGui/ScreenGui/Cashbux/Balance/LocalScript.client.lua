local _NumberHelpers = require(script.NumberHelpers)

while wait(1) do
	local yues = _NumberHelpers.format(game.Players.LocalPlayer.Cashbux.Value)
	script.Parent.Text = tostring(yues)
end
