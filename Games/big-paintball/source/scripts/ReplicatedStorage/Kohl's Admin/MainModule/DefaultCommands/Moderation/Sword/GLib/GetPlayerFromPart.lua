--[[
	INPUT: Object part
	OUTPUT: Player player, Object character
--]]
local Players = game:GetService'Players'

return function(part)
	if not part then return nil end
	
	local player
	local current = part
	while true do
		player = Players:GetPlayerFromCharacter(current)
		if not player then
			current = current.Parent
			if not current or current == game then
				break
			end
		else
			break
		end
	end
	
	return player, player and player.Character
end