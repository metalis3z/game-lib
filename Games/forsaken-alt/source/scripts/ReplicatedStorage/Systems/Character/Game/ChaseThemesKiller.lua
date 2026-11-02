-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Modules.Util);
local v4 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v5 = {
    ChaseID = 0, 
    ChaseVolume = nil
};
local _ = function(v6) --[[ Line: 13 ]] --[[ Name: findChaseTheme ]]
    local v7 = nil;
    local v8 = nil;
    local v9 = nil;
    for _, v11 in pairs(v6) do
        if v11.Chase then
            return v11.ID, v11.Volume, v11.LoopRegion;
        end;
    end;
    return v7, v8, v9;
end;
local function v21(v13) --[[ Line: 28 ]] --[[ Name: getClosestSurvivor ]]
    local v14 = nil;
    local v15 = 1e999;
    for _, v17 in pairs(workspace.Players.Survivors:GetChildren()) do
        local l_PrimaryPart_0 = v17.PrimaryPart;
        local l_Humanoid_0 = v17:FindFirstChild("Humanoid");
        if l_PrimaryPart_0 and l_Humanoid_0 and l_Humanoid_0.Health > 0 and not v17:GetAttribute("Undetectable") then
            local l_Magnitude_0 = (l_PrimaryPart_0.Position - v13.Position).Magnitude;
            if l_Magnitude_0 < v15 then
                v14 = v17;
                v15 = l_Magnitude_0;
            end;
        end;
    end;
    return v14, (tonumber(v15));
end;
v5.KillerAdded = function(_, v23) --[[ Line: 46 ]] --[[ Name: KillerAdded ]]
    -- upvalues: l_Players_0 (copy), v5 (copy)
    if v23.Rig:GetAttribute("Username") == l_Players_0.LocalPlayer.Name then
        local l_TerrorRadiusThemes_0 = v23.Config.Sounds.TerrorRadiusThemes;
        if l_TerrorRadiusThemes_0 then
            local v25 = nil;
            local v26 = nil;
            local v27 = nil;
            for _, v29 in pairs(l_TerrorRadiusThemes_0) do
                if v29.Chase then
                    v25 = v29.ID;
                    v26 = v29.Volume;
                    v27 = v29.LoopRegion;
                    break;
                end;
            end;
            local l_v25_0 = v25;
            local l_v26_0 = v26;
            local l_v27_0 = v27;
            v5.ChaseID = l_v25_0;
            v5.ChaseVolume = l_v26_0;
            v5.ChaseRegions = l_v27_0;
        end;
    end;
end;
v5.Start = function(_) --[[ Line: 65 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), l_Players_0 (copy), v5 (copy), v21 (copy), v4 (copy)
    v3.OnPlayingStateChanged(function(_) --[[ Line: 68 ]]
        -- upvalues: l_Players_0 (ref), v5 (ref), v21 (ref), v4 (ref)
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        local l_PrimaryPart_1 = l_Character_0.PrimaryPart;
        local v37 = false;
        while task.wait() and tostring(l_Character_0.Parent) == "Killers" do
            if v5.ChaseID then
                local _, v39 = v21(l_PrimaryPart_1);
                local l_l_Character_0_Attribute_0 = l_Character_0:GetAttribute("MuteChaseThemes");
                if v39 >= 60 and v37 or l_l_Character_0_Attribute_0 then
                    v4:StopTheme(v5.ChaseID);
                    v37 = false;
                end;
                if v39 <= 16 and not v37 and not l_l_Character_0_Attribute_0 then
                    v4:PlayTheme(v5.ChaseID, {
                        Priority = 5, 
                        TweenTime = 0.2, 
                        Volume = v5.ChaseVolume, 
                        PlaybackRegionsEnabled = v5.ChaseRegions, 
                        LoopRegion = v5.ChaseRegions
                    });
                    v37 = true;
                end;
            end;
        end;
    end);
end;
return v5;