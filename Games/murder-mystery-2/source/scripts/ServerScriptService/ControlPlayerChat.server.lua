local Player = game:GetService("Players").LocalPlayer

if _G.RoundEnded == false then
	Player.Team = game.Teams.Alive
	game.ReplicatedStorage.Remotes.Gameplay.AliveChat:FireClient(Player)
elseif _G.RoundEnded == true then
	Player.Team = game.Teams.Dead
	game.ReplicatedStorage.Remotes.Gameplay.DeadChat:FireClient(Player)
end