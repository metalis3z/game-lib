local LogService = game:GetService("LogService")
local ServerLog = {};



script.RequestServerOutput.Parent = game.ReplicatedStorage;
script.ServerMessageOut.Parent = game.ReplicatedStorage;


function game.ReplicatedStorage.RequestServerOutput.OnServerInvoke()
	return ServerLog;
end
