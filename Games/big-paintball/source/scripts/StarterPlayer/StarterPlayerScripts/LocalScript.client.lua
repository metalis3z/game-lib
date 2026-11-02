while wait () do
	local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
	while not v1.Loaded do
		game:GetService("RunService").Heartbeat:Wait();
	end;
	local itstimeforlozkoosbugfixing = game.Players.LocalPlayer.PlayerGui.Message.Enabled == true
	if itstimeforlozkoosbugfixing then
		v1.InfoOverlay.Remove()
	end
end