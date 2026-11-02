-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Hallucination, time of decompilation: Fri Nov 28 21:06:21 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerStorage");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v5 = require(l_ReplicatedStorage_0.Modules.Statuses);
local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
local v7 = require(l_ReplicatedStorage_0.Modules.Util);
local v8 = require(l_ReplicatedStorage_0.Modules.Actors);
local v9 = {
    AuraColors = {
        [1] = Color3.fromRGB(122, 105, 255), 
        [2] = Color3.fromRGB(76, 21, 195), 
        [3] = Color3.fromRGB(37, 0, 93)
    }, 
    Data = {
        Duration = 10, 
        MaxLevel = 3, 
        Description = "Reveals your aura to the Killer.\nCauses many visual/audible hallucinations.\nHigher levels will produce stronger hallucinations.", 
        Hidden = not l_RunService_0:IsStudio()
    }
};
local _ = {
    __len = function(v10) --[[ Line: 28 ]]
        local v11 = 0;
        for _, _ in pairs(v10) do
            v11 = v11 + 1;
        end;
        return v11;
    end
};
v9.Applied = function(v15) --[[ Line: 38 ]] --[[ Name: Applied ]]
    -- upvalues: l_RunService_0 (copy), v7 (copy), v9 (copy), l_Players_0 (copy), v8 (copy)
    local l_Level_0 = v15.Level;
    local l_Killer_0 = v15.Data.Killer;
    local l_Duration_0 = v15.Data.Duration;
    assert(l_Killer_0, "attempted to give hallucination with no killer");
    if l_RunService_0:IsServer() then
        v7:RevealPlayerAuraTo(l_Killer_0.Player, v15.Character, l_Duration_0, v9.AuraColors[math.clamp(l_Level_0, 1, 3)]);
        return;
    else
        if l_RunService_0:IsClient() then
            local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
            local v20 = v8.CurrentActors[l_LocalPlayer_0];
            if not v20 then
                warn("No actor.");
                return;
            else
                v15.Data.Hallucinations = v15.Data.Hallucinations or {};
                v15.Data.PreviousLevel = v15.Data.PreviousLevel or 0;
                local v21 = l_Level_0 - v15.Data.PreviousLevel;
                if v21 > 0 then
                    local v22 = {};
                    for _, v24 in ipairs(script.HallucinationClass:GetChildren()) do
                        if v24:IsA("ModuleScript") and not v15.Data.Hallucinations[v24] then
                            local v25 = require(v24);
                            local v26 = v25.Condition and v25.Condition();
                            if (not v25.ApplyAt or v25.ApplyAt <= l_Level_0) and v26 ~= false then
                                if v25.ForceApply then
                                    local v27 = v25.new(v20, l_Killer_0, v15);
                                    v27.TriggeredAtLevel = l_Level_0;
                                    local l_status_0, l_result_0 = pcall(v27.Init, v27);
                                    if not l_status_0 and l_result_0 then
                                        warn((("[%*]: Failed to initate! %*"):format(tostring(v24), l_result_0)));
                                    end;
                                    v15.Data.Hallucinations[v24] = v27;
                                else
                                    table.insert(v22, v24);
                                end;
                            end;
                        end;
                    end;
                    if v22 == {} then
                        return;
                    else
                        for v30 = 1, math.min(v21, #v22) do
                            local v31 = math.random(1, #v22);
                            local v32 = v22[v31];
                            assert(v32, "what do you mean it doesn't exist");
                            local v33 = require(v32).new(v20, l_Killer_0, v15);
                            v33.TriggeredAtLevel = math.min(v30 + v15.Data.PreviousLevel, l_Level_0);
                            local l_status_1, l_result_1 = pcall(v33.Init, v33);
                            if not l_status_1 and l_result_1 then
                                warn((("[%*]: Failed to initate! %*"):format(tostring(v32), l_result_1)));
                            end;
                            v15.Data.Hallucinations[v32] = v33;
                            table.remove(v22, v31);
                        end;
                        v15.Data.PreviousLevel = l_Level_0;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
v9.Heartbeat = function(v36) --[[ Line: 119 ]] --[[ Name: Heartbeat ]]
    -- upvalues: l_RunService_0 (copy), v5 (copy)
    if l_RunService_0:IsClient() then
        return;
    else
        local l_Character_0 = v36.Character;
        local v38 = l_Character_0 and l_Character_0:FindFirstChild("Humanoid");
        local v39 = v36.Data and v36.Data.Killer;
        local v40 = v39 and v39.Rig;
        local v41 = v40 and v40:FindFirstChild("Humanoid");
        if not l_Character_0 or not l_Character_0.Parent or not v38 or not v39 or not v40 or not v40.Parent or not v41 or v38.Health <= 0 or v41.Health <= 0 then
            v5:RemoveStatus(l_Character_0, "Hallucination");
        end;
        return;
    end;
end;
v9.Removed = function(v42) --[[ Line: 133 ]] --[[ Name: Removed ]]
    -- upvalues: l_RunService_0 (copy), v7 (copy)
    if l_RunService_0:IsServer() then
        local l_Character_1 = v42.Character;
        local v44 = v42.Data and v42.Data.Killer;
        local v45 = v44 and v44.Player;
        if v45 and l_Character_1 then
            v7:RemovePlayerAuraFrom(l_Character_1, v45);
            return;
        end;
    elseif l_RunService_0:IsClient() then
        local l_pairs_0 = pairs;
        local v47 = v42.Data.Hallucinations or {};
        for v48, v49 in l_pairs_0(v47) do
            if v49.Destroy then
                local l_status_2, l_result_2 = pcall(v49.Destroy, v49);
                if not l_status_2 then
                    warn((("[%*]: Failed to destroy! (%*)"):format(tostring(v48), l_result_2)));
                    v49:Clean();
                end;
            else
                v49:Clean();
            end;
        end;
        table.clear(v42.Data.Hallucinations or {});
        v42.Data.Hallucinations = nil;
        if v42.Character and v42.Character:FindFirstChild("Humanoid") then
            v42.Character.Humanoid:SetAttribute("FakeDamage", nil);
        end;
    end;
end;
return v9;