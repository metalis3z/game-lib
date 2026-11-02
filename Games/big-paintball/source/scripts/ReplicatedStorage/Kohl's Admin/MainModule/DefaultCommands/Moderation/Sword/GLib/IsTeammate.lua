--[[
	Input: Player a, Player b
	Output: Bool isTeammate
	
	Returns true if the players are on the same team
--]]

return function(a, b)
	if not a or not b then return nil end
	return a and b and a:IsA'Player' and b:IsA'Player' and a.Neutral==false and b.Neutral==false and a.TeamColor==b.TeamColor
end