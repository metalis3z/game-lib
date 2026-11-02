-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
local v5 = require(l_ReplicatedStorage_0.Modules.Actors);
local v6 = require(l_ReplicatedStorage_0.Modules.Stats);
local v7 = require(l_ReplicatedStorage_0.Modules.Util);
local v8 = l_RunService_0:IsServer();
local v9 = l_RunService_0:IsClient();
local v10 = {
	Name = "Standard", 
	Descriptions = {
		Survivors = "Survive until the time runs out or complete all objectives to win.", 
		Killers = "Kill all of the survivors to win."
	}, 
	PlayerRequirement = 1, 
	Exclusive = false
};
v10.__index = v10;
v10.Init = function(v11) --[[ Line: 30 ]] --[[ Name: Init ]]
	-- upvalues: v4 (copy), v10 (copy), v8 (copy), v7 (copy), v5 (copy), v6 (copy), v9 (copy)
	local v12 = {
		Maid = v4.new()
	};
	setmetatable(v12, v10);
	if v8 then
		local v13 = tonumber(workspace:GetAttribute("MaxKillers")) or 1;
		local v14, v15 = v7:SelectRandomKillers(v11.Players, v13);
		for _, v17 in v15 do
			local v18 = v11.Players[table.find(v11.Players, v17)];
			if v18 and v18.Instance then
				v5:CreateActor(v18.Instance, "Survivor");
				v18.Team = "Survivors";
				v18.Character = v18.Instance.Character;
				v6:UpdatePlayerStat(v18.Instance, "Objectives Completed", "Set", 0);
			end;
		end;
		for _, v20 in v14 do
			local v21 = v11.Players[table.find(v11.Players, v20)];
			if v21 and v21.Instance then
				v5:CreateActor(v21.Instance, "Killer");
				v21.Team = "Killers";
				v21.Character = v21.Instance.Character;
				v6:UpdatePlayerStat(v21.Instance, "Kills", "Set", 0);
			end;
		end;
		return v12;
	else
		if v9 then

		end;
		return v12;
	end;
end;
v10.WinCondition = function(_) --[[ Line: 70 ]] --[[ Name: WinCondition ]]

end;
v10.Destroy = function(v23) --[[ Line: 73 ]] --[[ Name: Destroy ]]
	-- upvalues: v8 (copy), v9 (copy)
	v23.Maid:Destroy();
	if v8 or v9 then

	end;
	v23 = nil;
end;
return v10;