local ReplicatedStorage = game:GetService('ReplicatedStorage');
local MarketplaceService = game:GetService('MarketplaceService');
------------------------------
local Modules = ReplicatedStorage:FindFirstChild('Modules');
------------------------------
local GroupModule = require(Modules:FindFirstChild('groupModule'));
------------------------------
local accessModule = {};
------------------------------
function accessModule.checkAccess(playerInstance,accessTable)
	if not accessTable then return true end
	
	local playerAccess = accessTable.players;
	local gamepassAccess = accessTable.gamepasses;
	local groupAccess = accessTable.groups;
	local teamAccess = accessTable.teams;
	local toolAccess = accessTable.tools;
	
	if playerAccess then for playerNumberIndex,playerIdentifier in pairs (playerAccess) do if playerInstance.Name == tostring(playerIdentifier) or playerInstance.UserId == tonumber(playerIdentifier) then return true end end end
	if gamepassAccess then for gamepassNumberIndex,gamepass in pairs(gamepassAccess) do if MarketplaceService:UserOwnsGamePassAsync(playerInstance.UserId,gamepass) then return true end end end
	if groupAccess then
		for groupNumberIndex,groupTable in pairs(groupAccess) do
			local groupId = groupTable.groupId or groupTable.groupid;
			local minRank = groupTable.minRank or 1;
			local maxRank = groupTable.maxRank or 255;
			local playerRank = playerInstance:GetRankInGroup(groupId);
			
			if playerRank >= minRank and playerRank <= maxRank then return true end
		end
	end
	
	if teamAccess then for teamNumberIndex,gameTeamName in pairs(teamAccess) do if playerInstance.Team.Name == gameTeamName then return true end end end
	
	if toolAccess then
		local playerTools = {}
		local backpackTools = playerInstance:FindFirstChild('Backpack'):GetChildren();
		for toolNumberIndex,backpackTool in pairs(backpackTools) do table.insert(playerTools,backpackTool.Name) end
		if playerInstance.Character then if playerInstance.Character:FindFirstChildWhichIsA('Tool') then table.insert(playerTools,playerInstance.Character:FindFirstChildWhichIsA('Tool')) end end
		
		for toolNumberIndex,toolName in pairs(toolAccess) do if table.find(playerTools,toolName) then return true end end
	end
	
	return false
end
------------------------------
return accessModule
