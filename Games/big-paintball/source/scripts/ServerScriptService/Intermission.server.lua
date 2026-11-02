local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while (not _L.Loaded) do
	game:GetService("RunService").Heartbeat:Wait();
end;

local IntermissionTime = 15
randomized =  math.random(1, 2)	
local matchresult = game.StarterGui.MatchResults

while wait() do
	if game.Workspace.__VARIABLES.SecondsRemaining.Value  == 0 then
		_L.Print("Start")
		matchresult.Enabled = true;
		game.Workspace.__VARIABLES.RoundType.Value =  "Intermission"
		wait(IntermissionTime)
		if randomized == 1 then
			game.Workspace.__VARIABLES.RoundType.Value = "FFA"
			game.Workspace.__VARIABLES.SecondsRemaining.Value = "600"
		end
		if randomized == 2 then
			game.Workspace.__VARIABLES.RoundType.Value = "KOTH"
			game.Workspace.__VARIABLES.SecondsRemaining.Value = "600"
		end

		if randomized == 3 then
			game.Workspace.__VARIABLES.RoundType.Value = "TDM"
			game.Workspace.__VARIABLES.SecondsRemaining.Value = "600"
		end
		matchresult.Enabled = true;
		_L.Print("End")
		_L.Print("Start of new Round" .. randomized .. "!")
	end
end