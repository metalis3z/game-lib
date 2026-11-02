--berezaa's Tycoon Kit

tycoonBackups = {}

for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Model") then
		
		tycoonBackups[v.Name] = v:Clone() -- Clones a copy of the tycoon to later regen	
		
		local teamcolor = BrickColor.new(v.Name)
		if teamcolor ~= nil then
			local team = Instance.new("Team",game.Teams)
			team.Name = v.TeamName.Value
			team.AutoAssignable = false
			team.TeamColor = teamcolor
		end
	end
end

function getTycoonFromPlayer(player)
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Model") then
			if v.Owner.Value == player then
				return v
			end
		end
	end
	return nil
end

game.Players.PlayerRemoving:connect(function(player)
	local tycoon = getTycoonFromPlayer(player)
	if tycoon then
		local backup = tycoonBackups[tycoon.Name]:Clone()
		tycoon:Destroy()
		wait()
		backup.Parent=script.Parent
	end
end)
