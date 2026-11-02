local MainGUI = script.Parent.Game;

game.ReplicatedStorage.PlayMusic.OnClientEvent:connect(function(Song)
	for i = 1,10 do
		for i,S in pairs(game.Soundscape:GetChildren()) do
			S.Volume = S.Volume - 0.1;
		end
		wait(0.1);
	end;
	for i,S in pairs(game.Soundscape:GetChildren()) do
		S:Stop();
		S:Destroy();
	end
	local Song = Song:Clone();
	Song.Parent = game.Soundscape;
	Song:Play();
	for i = 1,Song.Volume*10 do
		Song.Volume = Song.Volume + 0.1;
		wait(0.1);
	end
end)