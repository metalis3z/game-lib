local events = game:GetService("ReplicatedStorage"):WaitForChild("menu_remotes")
local respawn = events.respawn
local team = events.team
local players = game:GetService("Players")

local keyValue = 61263231872376162382731273618376


respawn.OnServerEvent:Connect(function(Player, key)
	Player:LoadCharacter()
end)

team.OnServerEvent:Connect(function(Player, team_name, group_id, minimum_rank, key)
	if Player:GetRankInGroup(group_id) >= minimum_rank and key == keyValue then
		local teams = game:GetService("Teams")
		Player.Team = teams[team_name]
		Player:LoadCharacter()
	end
end)
