game.Workspace.GameSettings.Fires.SetLimbs.Event:Connect(function()
	local req = require(game.ServerStorage.AcceptedLimbs)
	local value = req[math.random(1, #req)]

	game.ServerStorage.AcceptedLimbs:SetAttribute("RequestCode", value)
end)