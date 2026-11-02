-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentStats = {
        Round = {}, 
        Players = {}
    }
};
local v1 = {
    string = "N/A", 
    number = 0, 
    boolean = false
};
local v2 = require(game.ReplicatedStorage.Modules.Util);
v0.GetStat = function(_, v4, v5, v6, v7) --[[ Line: 17 ]] --[[ Name: GetStat ]]
    -- upvalues: v1 (copy), v0 (copy)
    local v8 = v1[v5:lower()];
    if v6 and v6 ~= "N/A" then
        local v9 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v6];
        local v10 = tostring(v6);
        if not v9 then
            return;
        else
            if not v0.CurrentStats.Players[v10] then
                v0.CurrentStats.Players[v10] = {
                    Info = {
                        DisplayName = v9.Config.DisplayName, 
                        RenderImage = v9.Config.RenderImage
                    }, 
                    Stats = {}
                };
            end;
            if not v0.CurrentStats.Players[v10].Stats[v4] then
                v0.CurrentStats.Players[v10].Stats[v4] = {
                    Value = v8, 
                    ConvertToDisplay = v7 or "<VALUE>"
                };
            end;
            return v0.CurrentStats.Players[v10].Stats[v4];
        end;
    else
        if not v0.CurrentStats.Round[v4] then
            v0.CurrentStats.Round[v4] = {
                Value = v8, 
                ConvertToDisplay = v7 or "<VALUE>"
            };
        end;
        return v0.CurrentStats.Round[v4];
    end;
end;
v0.SetStat = function(_, v12, v13, v14, v15) --[[ Line: 49 ]] --[[ Name: SetStat ]]
    -- upvalues: v0 (copy)
    local l_v0_Stat_0 = v0:GetStat(v12, typeof(v13), v14, v15);
    if l_v0_Stat_0 then
        l_v0_Stat_0.Value = v13;
    end;
end;
v0.AddToStat = function(_, v18, v19, v20, v21) --[[ Line: 56 ]] --[[ Name: AddToStat ]]
    -- upvalues: v0 (copy)
    local l_v0_Stat_1 = v0:GetStat(v18, typeof(v19), v20, v21);
    if l_v0_Stat_1 then
        l_v0_Stat_1.Value = l_v0_Stat_1.Value + v19;
    end;
end;
v0.UpdatePlayerStat = function(_, v24, v25, v26, v27, v28) --[[ Line: 63 ]] --[[ Name: UpdatePlayerStat ]]
    -- upvalues: v0 (copy), v2 (copy)
    if v26 == "Add" then
        v0:AddToStat(v25, v27, v24, v28);
        v2:AddToPlayerStat(v24, v25:gsub(" ", ""), v27);
        return;
    else
        if v26 == "Set" then
            v0:SetStat(v25, v27, v24, v28);
        end;
        return;
    end;
end;
v0.UpdateRoundStat = function(_, v30, v31, v32, v33) --[[ Line: 72 ]] --[[ Name: UpdateRoundStat ]]
    -- upvalues: v0 (copy)
    if v31 == "Add" then
        v0:AddToStat(v30, v32, "N/A", v33);
        return;
    else
        if v31 == "Set" then
            v0:SetStat(v30, v32, "N/A", v33);
        end;
        return;
    end;
end;
v0.CreateStatsFolder = function(_) --[[ Line: 80 ]] --[[ Name: CreateStatsFolder ]]
    -- upvalues: v0 (copy)
    local l_Folder_0 = Instance.new("Folder");
    l_Folder_0.Name = "FinalRoundStats";
    require(game.ReplicatedStorage.Modules.Util):ValueTableToBase(v0.CurrentStats, l_Folder_0);
    l_Folder_0.Parent = game.ReplicatedStorage;
    game.Debris:AddItem(l_Folder_0, 10);
    table.clear(v0.CurrentStats.Round);
    table.clear(v0.CurrentStats.Players);
end;
return v0;