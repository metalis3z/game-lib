-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Actors);
local v5 = require(l_ReplicatedStorage_0.Modules.Stats);
local v6 = l_RunService_0:IsServer();
local v7 = l_RunService_0:IsClient();
v0.Name = "Extermination";
v0.Descriptions = {
    Survivors = "Track down and eliminate the killer(s) to win", 
    Killers = "Kill off the SWAT team to win"
};
v0.PlayerRequirement = 1;
v0.Exclusive = true;
v0.Init = function(v8) --[[ Line: 33 ]] --[[ Name: Init ]]
    -- upvalues: v0 (copy), v6 (copy), v4 (copy), v5 (copy), v7 (copy)
    local v9 = {
        Connections = {}
    };
    setmetatable(v9, v0);
    if v6 then
        local v10 = require(game.ReplicatedStorage.Modules.Util);
        local v11 = tonumber(workspace:GetAttribute("MaxKillers")) or 1;
        local v12, v13 = v10:SelectRandomKillers(v8.Players, v11);
        for _, v15 in pairs(v13) do
            local v16 = table.find(v8.Players, v15);
            local v17 = v8.Players[v16];
            if v17 and v17.Instance then
                v4:CreateActor(v17.Instance, "Survivor", "__SWATOfficer");
                v17.Team = "Survivors";
                v17.Character = v17.Instance.Character;
                v5:UpdatePlayerStat(v17.Instance, "Objectives Completed", "Set", 0);
            end;
        end;
        for _, v19 in pairs(v12) do
            local v20 = table.find(v8.Players, v19);
            local v21 = v8.Players[v20];
            if v21 and v21.Instance then
                v4:CreateActor(v21.Instance, "Killer");
                v21.Team = "Killers";
                v21.Character = v21.Instance.Character;
                local l_Humanoid_0 = v21.Character.Humanoid;
                l_Humanoid_0.MaxHealth = l_Humanoid_0.MaxHealth * ((#v13 / 4 + 0.75) / #v12);
                v21.Character.Humanoid.Health = v21.Character.Humanoid.MaxHealth;
                v5:UpdatePlayerStat(v21.Instance, "Kills", "Set", 0);
            end;
        end;
        return v9;
    else
        if v7 then

        end;
        return v9;
    end;
end;
v0.WinCondition = function(_) --[[ Line: 82 ]] --[[ Name: WinCondition ]]
    -- upvalues: v6 (copy)
    if v6 then

    end;
end;
v0.Destroy = function(v24) --[[ Line: 89 ]] --[[ Name: Destroy ]]
    -- upvalues: v6 (copy), v7 (copy)
    for _, v26 in pairs(v24.Connections) do
        v26:Disconnect();
        v26 = nil;
    end;
    if v6 or v7 then

    end;
    v24 = nil;
end;
return v0;