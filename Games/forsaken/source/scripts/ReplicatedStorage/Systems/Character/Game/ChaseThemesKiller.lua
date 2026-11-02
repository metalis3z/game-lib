-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_TerrorRadiusThemes_0 = require(l_ReplicatedStorage_0.Assets.Killers.Slasher.Config).Sounds.TerrorRadiusThemes;
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = {
    ChaseID = 0, 
    ChaseVolume = nil
};
local _ = function(v7) --[[ Line: 16 ]] --[[ Name: findChaseTheme ]]
    local v8 = nil;
    local v9 = nil;
    local v10 = nil;
    for _, v12 in pairs(v7) do
        if v12.Chase then
            return v12.ID, v12.Volume, v12.LoopRegion;
        end;
    end;
    return v8, v9, v10;
end;
local function v26(v14) --[[ Line: 31 ]] --[[ Name: getClosestSurvivor ]]
    -- upvalues: v4 (copy)
    local l_CollectionService_0 = game:GetService("CollectionService");
    local v16 = nil;
    local v17 = 1e999;
    local l_Children_0 = workspace.Players.Survivors:GetChildren();
    for _, v20 in ipairs(l_CollectionService_0:GetTagged("SimulateSurvivor")) do
        table.insert(l_Children_0, v20);
    end;
    for _, v22 in pairs(l_Children_0) do
        local l_PrimaryPart_0 = v22.PrimaryPart;
        local l_Humanoid_0 = v22:FindFirstChild("Humanoid");
        if l_PrimaryPart_0 and l_Humanoid_0 and l_Humanoid_0.Health > 0 and (not v22:GetAttribute("Undetectable") or #l_Children_0 <= 1) then
            local l_Magnitude_0 = ((l_PrimaryPart_0.Position - v14.Position) * v4.KillerDistanceVector).Magnitude;
            if l_Magnitude_0 < v17 then
                v16 = v22;
                v17 = l_Magnitude_0;
            end;
        end;
    end;
    return v16, (tonumber(v17));
end;
v6.KillerAdded = function(_, v28) --[[ Line: 55 ]] --[[ Name: KillerAdded ]]
    -- upvalues: l_Players_0 (copy), v4 (copy), l_TerrorRadiusThemes_0 (copy), v6 (copy)
    if v28.Rig:GetAttribute("Username") == l_Players_0.LocalPlayer.Name then
        local l_Config_0 = v28.Config;
        local v30 = false;
        if l_Config_0.Sounds.isSensitiveTerrorRadius == true then
            v30 = v4:GetSettingValue("SensitiveMusicMode", l_Players_0.LocalPlayer) == true;
        end;
        local v31 = v30 and l_TerrorRadiusThemes_0 or l_Config_0.Sounds.TerrorRadiusThemes;
        if v31 then
            local v32 = nil;
            local v33 = nil;
            local v34 = nil;
            for _, v36 in pairs(v31) do
                if v36.Chase then
                    v32 = v36.ID;
                    v33 = v36.Volume;
                    v34 = v36.LoopRegion;
                    break;
                end;
            end;
            local l_v32_0 = v32;
            local l_v33_0 = v33;
            local l_v34_0 = v34;
            v6.ChaseID = l_v32_0;
            v6.ChaseVolume = l_v33_0;
            v6.ChaseRegions = l_v34_0;
        end;
    end;
end;
v6.Start = function(_) --[[ Line: 75 ]] --[[ Name: Start ]]
    -- upvalues: v4 (copy), l_Players_0 (copy), v6 (copy), v26 (copy), v5 (copy)
    v4.OnPlayingStateChanged(function(_) --[[ Line: 78 ]]
        -- upvalues: l_Players_0 (ref), v6 (ref), v26 (ref), v5 (ref)
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        local l_PrimaryPart_1 = l_Character_0.PrimaryPart;
        local v44 = false;
        while task.wait() and tostring(l_Character_0.Parent) == "Killers" do
            if v6.ChaseID then
                local _, v46 = v26(l_PrimaryPart_1);
                local l_l_Character_0_Attribute_0 = l_Character_0:GetAttribute("MuteChaseThemes");
                if v46 >= 60 and v44 or l_l_Character_0_Attribute_0 then
                    v5:StopTheme(v6.ChaseID);
                    v44 = false;
                end;
                if v46 <= 16 and not v44 and not l_l_Character_0_Attribute_0 then
                    v5:PlayTheme(v6.ChaseID, {
                        Priority = 5, 
                        TweenTime = 0.2, 
                        Volume = v6.ChaseVolume, 
                        PlaybackRegionsEnabled = v6.ChaseRegions, 
                        LoopRegion = v6.ChaseRegions
                    });
                    v44 = true;
                end;
            end;
        end;
    end);
end;
return v6;