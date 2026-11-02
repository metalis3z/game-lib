-- Customizable
local allowedTeam = BrickColor.new("Bright orange"); -- the color of the team allowed to change

local changedTeam = BrickColor.new("Really red"); -- the color they change to

-- Not customizable

local part = script.Parent;

part.Touched:connect(function(hit)
	
	local plr = game.Players:GetPlayerFromCharacter(hit.Parent);
	
	if plr then
		
		if plr.TeamColor == allowedTeam then
			
			plr.TeamColor = changedTeam;
			
			
			
		end
		
	end
	
end)