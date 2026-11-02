local MainGUI = script.Parent.Game;
local v1 = require(game.ReplicatedStorage.Modules.FadeModule);
local LocalPlayer = game.Players.LocalPlayer;
local EndMusic = {
	"http://www.roblox.com/asset/?id=320394794";
	"http://www.roblox.com/asset/?id=320396686";
	"http://www.roblox.com/asset/?id=320397765";
	"http://www.roblox.com/asset/?id=320403652";
};
function CountInnocentsAlive(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Innocent" and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

function CountInnocentsDead(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff") and Data["Dead"] == true then
			Count = Count + 1;
		end
	end
	return Count;
end
