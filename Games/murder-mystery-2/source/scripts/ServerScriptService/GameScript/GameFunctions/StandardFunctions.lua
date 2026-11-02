local Module = {}

local Gets = script.Parent.Parent.Get

function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local Set = script.Parent.Parent.Set.PlayerData;

Module.PlayerRemoving = function(Player)
	local PlayerData = Get("PlayerData");
	local pData = PlayerData[Player.Name];
	if pData ~= nil then
		local GameMode = Get("GameMode");
		if GameMode.Name == "Classic" then
			Set:Fire(Player.Name,"Dead",true);
		elseif GameMode.Name == "WildWest" then
			Set:Fire(Player.Name,"Dead",true);
		elseif GameMode.Name == "Infection" then
			Set:Fire(Player.Name,"Dead",true);
			Set:Fire(Player.Name,"Role","Murderer");
			Set:Fire(Player.Name,"Color",BrickColor.new("Bright green"));
		elseif GameMode.Name == "Assassin" then
			Set:Fire(Player.Name,"Dead",true);
		end;
		game.ReplicatedStorage.UpdatePlayerData:FireAllClients( PlayerData )
	end
end

Module.CheckForInnocents = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end

Module.CheckForMurderer = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Murderer" and Data["Dead"] == false then
			return true;
		else
			return false;
		end
	end
	return false;
end

Module.CheckForSheriff = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end

Module.Murderer = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Murderer" and Data["Dead"] == false then
			return PlayerName;
		end
	end
end
Module.InnocentsAlive = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Innocent" and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end
Module.CheckForBlueTeam = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Blue" and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end
Module.CheckForRedTeam = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Red" and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end
Module.ElfsAlive = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Elf" and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end
Module.GetSurvivors = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Survivor" and Data["Dead"] == false then
			return true;
		end
	end
	return false;
end
Module.CiviliansAlive = function()
	local Count = 0;
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Hero" or Data["Role"] == "Sheriff") and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

Module.Sheriff = function()
	local PlayerData = Get("PlayerData");
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == false then
			return PlayerName;
		end
	end
end

Module.CountInnocentsAlive = function(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Innocent" and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

Module.CountAlive = function(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

Module.CountSheriffAlive = function(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

Module.AllCharactersLoaded = function()
	for i,Player in pairs(game.Players:GetPlayers()) do
		if Player.Character == nil then
			return false;
		elseif Player.Character:FindFirstChild("Humanoid") == false then
			return false;
		end
	end
	return true;
end


Module.CountInnocentsDead = function()
	local PlayerData = Get("PlayerData");
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff" or Data["Role"] == "Hero") and Data["Dead"] == true then
			Count = Count + 1;
		end
	end
	return Count;
end
return Module;
