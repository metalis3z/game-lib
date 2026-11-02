-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_TerrorRadiusThemes_0 = require(l_ReplicatedStorage_0.Assets.Killers.Slasher.Config).Sounds.TerrorRadiusThemes;
local v4 = {
    KillerThemes = {}, 
    ChasingKiller = nil, 
    CurrentTheme = nil
};
local v5 = require(game.ReplicatedStorage.Modules.Sounds);
local v6 = require(game.ReplicatedStorage.Modules.Actors);
local v7 = require(game.ReplicatedStorage.Modules.Util);
v4.KillerAdded = function(_, v9) --[[ Line: 22 ]] --[[ Name: KillerAdded ]]
    -- upvalues: l_LocalPlayer_0 (ref), l_Players_0 (copy), v7 (copy), l_TerrorRadiusThemes_0 (copy), v4 (copy)
    if not l_LocalPlayer_0 then
        l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    end;
    local l_Sounds_0 = v9.Config.Sounds;
    local v11 = false;
    if l_Sounds_0.isSensitiveTerrorRadius == true then
        v11 = v7:GetSettingValue("SensitiveMusicMode", l_LocalPlayer_0) == true;
    end;
    local v12 = l_Sounds_0 and (v11 and l_TerrorRadiusThemes_0 or l_Sounds_0.TerrorRadiusThemes);
    if v12 then
        local v13 = {};
        for v14, v15 in pairs(v12) do
            v15.Distance = tonumber(v14);
            v13[tonumber(v14)] = v15;
        end;
        v4.KillerThemes[v9.Rig] = v13;
    end;
end;
v4.KillerRemoved = function(_, v17) --[[ Line: 42 ]] --[[ Name: KillerRemoved ]]
    -- upvalues: v4 (copy), v5 (copy)
    if v4.KillerThemes[v17.Rig] then
        for _, v19 in pairs(v4.KillerThemes[v17.Rig]) do
            v5:StopTheme(v19.ID, 0.35, false);
        end;
        v5:UpdateThemes();
        v4.ChasingKiller = nil;
        v4.CurrentTheme = nil;
        v4.KillerThemes[v17.Rig] = nil;
    end;
end;
local function v24() --[[ Line: 62 ]] --[[ Name: stopThemes ]]
    -- upvalues: v4 (copy), v5 (copy)
    for _, v21 in pairs(v4.KillerThemes) do
        for _, v23 in pairs(v21) do
            v5:StopTheme(v23.ID, 0.35, false);
        end;
    end;
    v5:UpdateThemes();
end;
local function v34(v25, v26) --[[ Line: 72 ]] --[[ Name: getThemeDataFromDistance ]]
    -- upvalues: l_LocalPlayer_0 (ref)
    local v27 = nil;
    local v28 = nil;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_l_Character_0_Attribute_0 = l_Character_0:GetAttribute("ForcedMinChaseDistance");
    local l_l_Character_0_Attribute_1 = l_Character_0:GetAttribute("ForcedMaxChaseDistance");
    if l_l_Character_0_Attribute_0 or l_l_Character_0_Attribute_1 then
        v26 = math.clamp(v26, l_l_Character_0_Attribute_0 or 0, l_l_Character_0_Attribute_1 or 1e999);
    end;
    for v32, v33 in pairs(v25) do
        if v33.Distance <= v26 and (v27 == nil or v27 < v32) then
            v27 = v32;
            v28 = v33;
        end;
    end;
    return v28;
end;
local function v42(v35) --[[ Line: 95 ]] --[[ Name: getDistanceOfFurthestTheme ]]
    local v36 = nil;
    local l_pairs_0 = pairs;
    local v38 = v35 or {};
    for _, v40 in l_pairs_0(v38) do
        local v41 = tonumber(v40.Distance);
        if not v36 then
            v36 = v41;
        end;
        if v41 and v36 < v41 then
            v36 = v41;
        end;
    end;
    return (tonumber(v36) or 60) * 1.25;
end;
local function _(v43) --[[ Line: 106 ]] --[[ Name: getDistanceFromKiller ]]
    -- upvalues: v7 (copy)
    local l_Character_1 = game.Players.LocalPlayer.Character;
    local v45 = l_Character_1 and l_Character_1.PrimaryPart;
    return v45 and ((v43.Position - v45.Position) * v7.KillerDistanceVector).Magnitude or 999;
end;
local function v53(v47) --[[ Line: 114 ]] --[[ Name: getClosestKiller ]]
    -- upvalues: v7 (copy)
    local v48 = nil;
    local v49 = 1e999;
    for _, v51 in pairs(workspace.Players.Killers:GetChildren()) do
        if v51.PrimaryPart and not v51:GetAttribute("Undetectable") then
            local l_Magnitude_0 = ((v51.PrimaryPart.Position - v47.Position) * v7.KillerDistanceVector).Magnitude;
            if l_Magnitude_0 < v49 then
                v48 = v51;
                v49 = l_Magnitude_0;
            end;
        end;
    end;
    return v48, (tonumber(v49));
end;
v4.Start = function(_) --[[ Line: 131 ]] --[[ Name: Start ]]
    -- upvalues: v4 (copy), v24 (copy), v7 (copy), v42 (copy), v6 (copy), v53 (copy), v34 (copy), v5 (copy)
    local v55 = require(game.ReplicatedStorage.Modules.Util);
    v55.OnPlayingStateChanged(function(v56) --[[ Line: 135 ]]
        -- upvalues: v4 (ref), v55 (copy), v24 (ref), v7 (ref), v42 (ref), v6 (ref), v53 (ref), v34 (ref), v5 (ref)
        if v56 ~= "Survivors" then
            v4.ChasingKiller = nil;
            v4.CurrentTheme = nil;
            v55:ToggleResetButton(true);
            return;
        else
            local l_Character_2 = game.Players.LocalPlayer.Character;
            local l_HumanoidRootPart_0 = l_Character_2:WaitForChild("HumanoidRootPart");
            task.spawn(function() --[[ Line: 148 ]]
                -- upvalues: l_Character_2 (copy), v4 (ref), v55 (ref), v24 (ref), v7 (ref), v42 (ref), v6 (ref), v53 (ref), l_HumanoidRootPart_0 (copy), v34 (ref), v5 (ref)
                while task.wait(0.05) and tostring(l_Character_2.Parent) == "Survivors" do
                    local l_ChasingKiller_0 = v4.ChasingKiller;
                    local l_l_Character_2_Attribute_0 = l_Character_2:GetAttribute("MuteChaseThemes");
                    if not v55:IsAlive(l_Character_2) then
                        v4.ChasingKiller = nil;
                        v4.CurrentTheme = nil;
                        v24();
                    else
                        if l_ChasingKiller_0 then
                            local v61 = l_ChasingKiller_0:GetAttribute("TerrorMultiplier") or 1;
                            local l_PrimaryPart_0 = l_ChasingKiller_0.PrimaryPart;
                            local v63 = v4.KillerThemes[l_ChasingKiller_0];
                            local l_Character_3 = game.Players.LocalPlayer.Character;
                            local v65 = l_Character_3 and l_Character_3.PrimaryPart;
                            if (v65 and ((l_PrimaryPart_0.Position - v65.Position) * v7.KillerDistanceVector).Magnitude or 999) >= v42(v63) * v61 or l_l_Character_2_Attribute_0 or not v63 then
                                l_Character_3 = game.Players:GetPlayerFromCharacter(l_ChasingKiller_0);
                                v65 = l_Character_3 and v6.CurrentActors[l_Character_3];
                                if v65 then
                                    if v65.CustomBehavior.OnChase then
                                        v65.CustomBehavior:OnChase("Ended", v65);
                                    elseif v65.Behavior.OnChase then
                                        v65.Behavior:OnChase("Ended", v65);
                                    end;
                                end;
                                v4.ChasingKiller = nil;
                                v4.CurrentTheme = nil;
                                v55:ToggleResetButton(true);
                                v24();
                            else
                                continue;
                            end;
                        end;
                        local v66, v67 = v53(l_HumanoidRootPart_0);
                        if v66 and v67 and not l_l_Character_2_Attribute_0 then
                            local v68 = v4.KillerThemes[v66];
                            local v69 = v6.CurrentActors[game.Players:GetPlayerFromCharacter(v66)];
                            local v70 = v66:GetAttribute("TerrorMultiplier") or 1;
                            if v68 then
                                if v42(v68) * v70 < v67 then
                                    if v4.CurrentTheme then
                                        v4.CurrentTheme = nil;
                                        v24();
                                    end;
                                else
                                    local v71 = v34(v68, v67 / v70);
                                    if v71 and (not v4.CurrentTheme or not v4.CurrentTheme.Chase and v4.CurrentTheme.ID ~= v71.ID) then
                                        local v72 = v5:StopTheme(v4.CurrentTheme and v4.CurrentTheme.ID);
                                        local v73 = v5:PlayTheme(v71.ID, {
                                            Priority = 5, 
                                            Volume = v71.Volume, 
                                            PlaybackRegionsEnabled = v71.LoopRegion, 
                                            LoopRegion = v71.LoopRegion
                                        });
                                        if v73 then
                                            v73.TimePosition = v72 and v72.TimePosition % v73.TimeLength or 0;
                                        end;
                                        v4.CurrentTheme = v71;
                                        if v71.Chase then
                                            v55:ToggleResetButton(false);
                                            v4.ChasingKiller = v66;
                                            if v69 then
                                                if v69.CustomBehavior.OnChase then
                                                    v69.CustomBehavior:OnChase("Started", v69);
                                                elseif v69.Behavior.OnChase then
                                                    v69.Behavior:OnChase("Started", v69);
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            return;
        end;
    end);
end;
return v4;