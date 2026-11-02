--berezaa's Tycoon Kit

tycoonBackups = {}

moneymanagement = Instance.new("Smoke",game.ServerStorage)
moneymanagement.Name = "MoneyStorage"


leaderboardscript = script.Parent.LinkedLeaderboard
leaderboardscript.Parent = game.ServerScriptService
leaderboardscript.Disabled = false

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

game.Players.PlayerAdded:connect(function(player)
	local cashmoney = Instance.new("NumberValue",game.ServerStorage.MoneyStorage)
	cashmoney.Name = player.Name
	local isowner = Instance.new("BoolValue",cashmoney)
	isowner.Name = "OwnsTycoon"
end)
game.Players.PlayerRemoving:connect(function(player)
	local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
	if cashmoney ~= nil then
		cashmoney:Destroy()
	end
	local tycoon = getTycoonFromPlayer(player)
	if tycoon then
		local backup = tycoonBackups[tycoon.Name]:Clone()
		tycoon:Destroy()
		wait()
		backup.Parent=script.Parent
	end
end)
