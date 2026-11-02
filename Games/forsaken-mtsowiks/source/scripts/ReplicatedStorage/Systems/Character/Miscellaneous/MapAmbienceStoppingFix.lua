-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_Character_0 = game.Players.LocalPlayer.Character;
        if not l_Character_0 then
            return;
        else
            local _ = require(game.ReplicatedStorage.Modules.Sounds);
            local v3 = nil;
            local function v7(v4) --[[ Line: 13 ]] --[[ Name: toggleMapAmbiencePlaying ]]
                -- upvalues: v3 (ref)
                if v3 then
                    task.cancel(v3);
                end;
                if v4 == "Spectating" then
                    v3 = task.delay(1, function() --[[ Line: 16 ]]
                        local l_MapAmbience_0 = workspace.Themes:FindFirstChild("MapAmbience");
                        if l_MapAmbience_0 then
                            l_MapAmbience_0.Playing = false;
                        end;
                    end);
                    return;
                else
                    local l_MapAmbience_1 = workspace.Themes:FindFirstChild("MapAmbience");
                    if l_MapAmbience_1 then
                        l_MapAmbience_1.Playing = true;
                    end;
                    return;
                end;
            end;
            v7((tostring(l_Character_0.Parent)));
            l_Character_0:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 28 ]]
                -- upvalues: v7 (copy), l_Character_0 (copy)
                v7((tostring(l_Character_0.Parent)));
            end);
            return;
        end;
    end
};