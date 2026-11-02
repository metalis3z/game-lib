--[[
	INPUT: Object part
	OUTPUT: Object character, Player player, Humanoid humanoid
--]]
local Players = game:GetService'Players'

return function(part)
	local current = part
	local character = nil
	local humanoid = nil
	local player = nil
	while true do
		for i, child in next, current:GetChildren() do
			if child:IsA'Humanoid' then
				character = current
				humanoid = child
				break
			end
		end
		if current:IsA'Player' then
			local GLib = require(script.Parent)
			character = current.Character
			humanoid = character and GLib.GetHumanoid(character)
			player = current
			break
		end
		
		if character then
			break
		else
			current = current.Parent
			
			if not current or current == game then
				break
			end
		end
	end
	
	return character, player or (character and Players:GetPlayerFromCharacter(character)), humanoid
end