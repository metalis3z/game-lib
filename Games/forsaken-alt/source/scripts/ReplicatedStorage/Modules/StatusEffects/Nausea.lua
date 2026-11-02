-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        Description = "Disorientates your screen.\nEvery level of this status makes the disorientation worse."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsClient() then
            local l_PlayerSettings_0 = require(game.ReplicatedStorage.Initializer).PlayerSettings;
            local v2 = l_PlayerSettings_0.EpilepsyMode and l_PlayerSettings_0.EpilepsyMode.Value and 0.5 or v0.Level;
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local v4 = nil;
            v0.Amplitude = v2 / 5;
            v0.Frequency = v2 / 2;
            if not v0.TickTimePast then
                v0.TickTimePast = 0;
            end;
            if v0.Running then
                return;
            else
                v0.Running = true;
                local function v11(v5) --[[ Line: 31 ]] --[[ Name: drunkEffect ]]
                    -- upvalues: v0 (copy)
                    local v6 = tick();
                    local v7 = math.sin(v6 * v0.Frequency) * v0.Amplitude;
                    local v8 = math.cos(v6 * v0.Frequency * 0.7) * v0.Amplitude;
                    local v9 = math.sin(v6 * v0.Frequency * 0.5) * v0.Amplitude;
                    local v10 = math.sin(v6 * v0.Frequency * 0.3) * 0.17453292519943295;
                    return CFrame.new(v7 * v5, v8 * v5, v9 * v5) * CFrame.Angles(0, 0, v10 * v5);
                end;
                local function v16(v12) --[[ Line: 42 ]] --[[ Name: getStretchEffect ]]
                    -- upvalues: v0 (copy)
                    local v13 = tick();
                    local v14 = math.sin(v13 * v0.Frequency * 0.5) * math.clamp(v0.Amplitude, 0.1, 0.6) * v12;
                    local v15 = math.cos(v13 * v0.Frequency * 0.5) * math.clamp(v0.Amplitude, 0.1, 0.6) * v12;
                    return CFrame.new(0, 0, 0, 1, v14, v15, v14, 1, v15, 0, 0, 1);
                end;
                do
                    local l_v4_0 = v4;
                    local function v18() --[[ Line: 49 ]] --[[ Name: preDistortCamera ]]
                        -- upvalues: l_v4_0 (ref), l_CurrentCamera_0 (copy)
                        if l_v4_0 then
                            l_CurrentCamera_0.CFrame = l_v4_0;
                        end;
                    end;
                    local function v20() --[[ Line: 55 ]] --[[ Name: distortCamera ]]
                        -- upvalues: v0 (copy), l_v4_0 (ref), l_CurrentCamera_0 (copy), v11 (copy), v16 (copy)
                        if v0.Character and v0.Character.Parent then
                            local v19 = math.clamp(v0.TickTimePast / 3.5, 0, 1);
                            l_v4_0 = l_CurrentCamera_0.CFrame;
                            l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * (v11(v19) * v16(v19));
                            return;
                        else
                            game["Run Service"]:UnbindFromRenderStep("PreDistort");
                            game["Run Service"]:UnbindFromRenderStep("DistortCamera");
                            return;
                        end;
                    end;
                    game["Run Service"]:BindToRenderStep("PreDistort", 199, v18);
                    game["Run Service"]:BindToRenderStep("DistortCamera", 201, v20);
                end;
            end;
        end;
    end, 
    Removed = function(_) --[[ Line: 71 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsClient() then
            game["Run Service"]:UnbindFromRenderStep("PreDistort");
            game["Run Service"]:UnbindFromRenderStep("DistortCamera");
        end;
    end, 
    Heartbeat = function(v22, v23) --[[ Line: 78 ]] --[[ Name: Heartbeat ]]
        if game["Run Service"]:IsClient() then
            if not v22.TickTimePast then
                v22.TickTimePast = 0;
            end;
            if v22.TimePast >= v22.TimeRequired / 2 then
                if v22.TickTimePast > v22.TimeRequired / 2 then
                    v22.TickTimePast = v22.TimeRequired / 2;
                end;
                v22.TickTimePast = v22.TickTimePast - v23;
                return;
            else
                v22.TickTimePast = v22.TickTimePast + v23;
            end;
        end;
    end
};