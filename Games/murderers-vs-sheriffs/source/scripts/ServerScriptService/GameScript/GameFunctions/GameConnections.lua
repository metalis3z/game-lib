local Gets = script.Parent.Parent.Get
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end
local module = function(Sync,ServerVersion,Data,GameFunctions)
	function game.ReplicatedStorage.Remotes.Events.Summer2024.GetRewards.OnServerInvoke(Player)
		return Sync.Data["Summer2024Event"];
	end
	function game.ReplicatedStorage.Remotes.Extras.GetChance.OnServerInvoke(Player)
		return GameFunctions.Chance.Get(Player.Name);
	end
	function game.ReplicatedStorage.Remotes.Extras.GetPlayerData.OnServerInvoke()
		return Get("PlayerData");
	end
	function game.ReplicatedStorage.Remotes.Gameplay.GetCurrentPlayerData.OnServerInvoke()
		return Get("PlayerData");
	end
	function game.ReplicatedStorage.GetPlayerData_REMOTE.OnInvoke()
		return Get("PlayerData");
	end
	function game.ReplicatedStorage.GetSyncData.OnServerInvoke(Player,DataName)
		return Sync[DataName];
	end
	function game.ReplicatedStorage.GetSyncDataServer.OnInvoke(DataName)
		return Sync[DataName];
	end
end
return module
