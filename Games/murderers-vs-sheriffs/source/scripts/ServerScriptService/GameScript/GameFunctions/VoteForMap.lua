local Gets = script.Parent.Parent.Get
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local MapsDatabase = require(game.ServerScriptService.Modules.MapModule)

local CompatibleModes = {
	Classic = true,
	Infection = true
}

local Module = function()
	if _G.CustomMap then
		local v1 = _G.CustomMap
		return v1:Clone()
	end
	local Vote1 = game.ServerScriptService.Modules.Essentials.VoteServer.VotePad1;
	local Vote2 = game.ServerScriptService.Modules.Essentials.VoteServer.VotePad2;
	local Vote3 = game.ServerScriptService.Modules.Essentials.VoteServer.VotePad3;

	local Map1;
	local Map2;
	local Map3;

	local CompatibleMaps = {};
	local mapsFolder = game.ServerStorage.Database.Maps

	for MapName,MapTable in pairs(MapsDatabase) do
		if mapsFolder:FindFirstChild(MapName) then
			for _,GameModeName in pairs(MapTable["GameModes"] or {}) do
				if CompatibleModes[GameModeName] then
					table.insert(CompatibleMaps, MapName)
					break
				end
			end
		end
	end

	for i = #CompatibleMaps, 2, -1 do
		local j = math.random(1, i)
		CompatibleMaps[i], CompatibleMaps[j] = CompatibleMaps[j], CompatibleMaps[i]
	end

	if #CompatibleMaps == 0 then
		warn("VoteForMap: no compatible maps found; falling back to first map in storage")
		Map1 = mapsFolder:GetChildren()[1]
		Map2 = Map1
		Map3 = Map1
	else
		Map1 = mapsFolder[CompatibleMaps[1]]
		Map2 = mapsFolder[CompatibleMaps[2] or CompatibleMaps[1]]
		Map3 = mapsFolder[CompatibleMaps[3] or CompatibleMaps[2] or CompatibleMaps[1]]
	end



	local SelectedMap;

	Vote1.Votes.Value = 0;
	Vote2.Votes.Value = 0;
	Vote3.Votes.Value = 0;

	Vote1.Map.Value = Map1;
	Vote2.Map.Value = Map2;
	Vote3.Map.Value = Map3;

	Vote1.Voting.Value = true;
	Vote2.Voting.Value = true;
	Vote3.Voting.Value = true;

	wait(15);

	local Votes1 = Vote1.Votes.Value;
	local Votes2 = Vote2.Votes.Value;
	local Votes3 = Vote3.Votes.Value;

	local choices = {
		{Map = Map1, Votes = Votes1},
		{Map = Map2, Votes = Votes2},
		{Map = Map3, Votes = Votes3},
	}
	local highestVotes = math.max(Votes1, Votes2, Votes3)
	local tiedChoices = {}
	for _, choice in ipairs(choices) do
		if choice.Votes == highestVotes then
			table.insert(tiedChoices, choice.Map)
		end
	end
	SelectedMap = tiedChoices[math.random(1, #tiedChoices)]

	Vote1.Voting.Value = false;
	Vote2.Voting.Value = false;
	Vote3.Voting.Value = false;
	Vote1.Votes.Value = 0;
	Vote2.Votes.Value = 0;
	Vote3.Votes.Value = 0;

	return SelectedMap:Clone();
end

return Module;
