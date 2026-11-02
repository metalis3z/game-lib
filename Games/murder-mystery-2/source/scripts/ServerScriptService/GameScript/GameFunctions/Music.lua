local Module = {}

local CurrentSong = game.ReplicatedStorage.Music.Lobby.SneakyAdventure;

Module.Lobby = function()
	local Music = game.ReplicatedStorage.Music.Lobby:GetChildren();
	local Song = Music[math.random(1,#Music)];
	CurrentSong = Song;
	game.ReplicatedStorage.PlayMusic:FireAllClients(Song);
end

Module.Murderer = function()
	local Music = game.ReplicatedStorage.Music.Murderer:GetChildren();
	local Song = Music[math.random(1,#Music)];
	game.ReplicatedStorage.PlayMusic:FireAllClients(Song);
end

Module.RoundEnd = function()
	local Music = game.ReplicatedStorage.Music.RoundEnding:GetChildren();
	local Song = Music[math.random(1,#Music)];
	game.ReplicatedStorage.PlayMusic:FireAllClients(Song);
end

Module.Innocents = function()
	local Music = game.ReplicatedStorage.Music.Innocent:GetChildren();
	local Song = Music[math.random(1,#Music)];
	game.ReplicatedStorage.PlayMusic:FireAllClients(Song);
end

return Module;
