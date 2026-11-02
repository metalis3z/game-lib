local ServerStorage = game:GetService("ServerStorage")

local function getRoundState()
	local roundState = ServerStorage:FindFirstChild("RoundState")
	if not roundState then
		return nil
	end

	return roundState:FindFirstChild("RoundActive"), roundState:FindFirstChild("ForceInnocentsWin")
end

return function()
	local roundActive, forceInnocentsWin = getRoundState()
	if not (roundActive and forceInnocentsWin) then
		return "Round state is not ready yet."
	end

	if roundActive.Value ~= true then
		return "There is no active round to end."
	end

	_G.ForceInnocentsWin = true
	forceInnocentsWin.Value = true
	return "Ending round with an Innocents win."
end