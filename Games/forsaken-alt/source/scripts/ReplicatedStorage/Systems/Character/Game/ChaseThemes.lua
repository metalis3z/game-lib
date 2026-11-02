-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    KillerThemes = {}, 
    ChasingKiller = nil, 
    CurrentTheme = nil
};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Actors);
v0.KillerAdded = function(_, v4) --[[ Line: 14 ]] --[[ Name: KillerAdded ]]
    -- upvalues: v0 (copy)
    local l_Sounds_0 = v4.Config.Sounds;
    local v6 = l_Sounds_0 and l_Sounds_0.TerrorRadiusThemes;
    if v6 then
        local v7 = {};
        for v8, v9 in pairs(v6) do
            v9.Distance = v8;
            v7[v8] = v9;
        end;
        v0.KillerThemes[v4.Rig] = v7;
    end;
end;
v0.KillerRemoved = function(_, v11) --[[ Line: 32 ]] --[[ Name: KillerRemoved ]]
    -- upvalues: v0 (copy), v1 (copy)
    if v0.KillerThemes[v11.Rig] then
        for _, v13 in pairs(v0.KillerThemes[v11.Rig]) do
            v1:StopTheme(v13.ID, 0.35, false);
        end;
        v1:UpdateThemes();
        v0.ChasingKiller = nil;
        v0.CurrentTheme = nil;
        v0.KillerThemes[v11.Rig] = nil;
    end;
end;
local function v18() --[[ Line: 52 ]] --[[ Name: stopThemes ]]
    -- upvalues: v0 (copy), v1 (copy)
    for _, v15 in pairs(v0.KillerThemes) do
        for _, v17 in pairs(v15) do
            v1:StopTheme(v17.ID, 0.35, false);
        end;
    end;
    v1:UpdateThemes();
end;
local function v25(v19, v20) --[[ Line: 62 ]] --[[ Name: getThemeDataFromDistance ]]
    local v21 = nil;
    local v22 = nil;
    for v23, v24 in pairs(v19) do
        if v24.Distance <= v20 and (v21 == nil or v21 < v23) then
            v21 = v23;
            v22 = v24;
        end;
    end;
    return v22;
end;
local function v33(v26) --[[ Line: 77 ]] --[[ Name: getDistanceOfFurthestTheme ]]
    local v27 = nil;
    local l_pairs_0 = pairs;
    local v29 = v26 or {};
    for _, v31 in l_pairs_0(v29) do
        local v32 = tonumber(v31.Distance);
        if not v27 then
            v27 = v32;
        end;
        if v32 and v27 < v32 then
            v27 = v32;
        end;
    end;
    return (tonumber(v27) or 60) * 1.25;
end;
local function _(v34) --[[ Line: 89 ]] --[[ Name: getDistanceFromKiller ]]
    local l_Character_0 = game.Players.LocalPlayer.Character;
    local v36 = l_Character_0 and l_Character_0.PrimaryPart;
    return v36 and (v34.Position - v36.Position).Magnitude or 999;
end;
local function v44(v38) --[[ Line: 97 ]] --[[ Name: getClosestKiller ]]
    local v39 = nil;
    local v40 = 1e999;
    for _, v42 in pairs(workspace.Players.Killers:GetChildren()) do
        if v42.PrimaryPart and not v42:GetAttribute("Undetectable") then
            local l_Magnitude_0 = (v42.PrimaryPart.Position - v38.Position).Magnitude;
            if l_Magnitude_0 < v40 then
                v39 = v42;
                v40 = l_Magnitude_0;
            end;
        end;
    end;
    return v39, (tonumber(v40));
end;
v0.Start = function(_) --[[ Line: 114 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), v33 (copy), v2 (copy), v18 (copy), v44 (copy), v25 (copy), v1 (copy)
    local v46 = require(game.ReplicatedStorage.Modules.Util);
    v46.OnPlayingStateChanged(function(v47) --[[ Line: 118 ]]
        -- upvalues: v0 (ref), v46 (copy), v33 (ref), v2 (ref), v18 (ref), v44 (ref), v25 (ref), v1 (ref)
        if v47 ~= "Survivors" then
            v0.ChasingKiller = nil;
            v0.CurrentTheme = nil;
            v46:ToggleResetButton(true);
            return;
        else
            local l_Character_1 = game.Players.LocalPlayer.Character;
            local l_HumanoidRootPart_0 = l_Character_1:WaitForChild("HumanoidRootPart");
            task.spawn(function() --[[ Line: 131 ]]
                -- upvalues: l_Character_1 (copy), v0 (ref), v33 (ref), v2 (ref), v46 (ref), v18 (ref), v44 (ref), l_HumanoidRootPart_0 (copy), v25 (ref), v1 (ref)
                while task.wait(0.05) and tostring(l_Character_1.Parent) == "Survivors" do
                    local l_ChasingKiller_0 = v0.ChasingKiller;
                    local l_l_Character_1_Attribute_0 = l_Character_1:GetAttribute("MuteChaseThemes");
                    if l_ChasingKiller_0 then
                        local l_PrimaryPart_0 = l_ChasingKiller_0.PrimaryPart;
                        local v53 = v0.KillerThemes[l_ChasingKiller_0];
                        local l_Character_2 = game.Players.LocalPlayer.Character;
                        local v55 = l_Character_2 and l_Character_2.PrimaryPart;
                        if (v55 and (l_PrimaryPart_0.Position - v55.Position).Magnitude or 999) >= v33(v53) or l_l_Character_1_Attribute_0 or not v53 then
                            l_Character_2 = v2.CurrentActors[game.Players:GetPlayerFromCharacter(l_ChasingKiller_0)];
                            if l_Character_2 then
                                if l_Character_2.CustomBehavior.OnChase then
                                    l_Character_2.CustomBehavior:OnChase("Ended", l_Character_2);
                                elseif l_Character_2.Behavior.OnChase then
                                    l_Character_2.Behavior:OnChase("Ended", l_Character_2);
                                end;
                            end;
                            v0.ChasingKiller = nil;
                            v0.CurrentTheme = nil;
                            v46:ToggleResetButton(true);
                            v18();
                        else
                            continue;
                        end;
                    end;
                    local v56, v57 = v44(l_HumanoidRootPart_0);
                    if v56 and v57 and not l_l_Character_1_Attribute_0 then
                        local v58 = v0.KillerThemes[v56];
                        local v59 = v2.CurrentActors[game.Players:GetPlayerFromCharacter(v56)];
                        if v59 and v58 then
                            if v33(v58) < v57 then
                                if v0.CurrentTheme then
                                    v0.CurrentTheme = nil;
                                    v18();
                                end;
                            else
                                local v60 = v25(v58, v57);
                                if v60 and (not v0.CurrentTheme or not v0.CurrentTheme.Chase and v0.CurrentTheme.ID ~= v60.ID) then
                                    local v61 = v1:StopTheme(v0.CurrentTheme and v0.CurrentTheme.ID);
                                    local v62 = v1:PlayTheme(v60.ID, {
                                        Priority = 5, 
                                        Volume = v60.Volume, 
                                        PlaybackRegionsEnabled = v60.LoopRegion, 
                                        LoopRegion = v60.LoopRegion
                                    });
                                    if v62 then
                                        v62.TimePosition = v61 and v61.TimePosition % v62.TimeLength or 0;
                                    end;
                                    v0.CurrentTheme = v60;
                                    if v60.Chase then
                                        v46:ToggleResetButton(false);
                                        v0.ChasingKiller = v56;
                                        if v59 then
                                            if v59.CustomBehavior.OnChase then
                                                v59.CustomBehavior:OnChase("Started", v59);
                                            elseif v59.Behavior.OnChase then
                                                v59.Behavior:OnChase("Started", v59);
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
return v0;