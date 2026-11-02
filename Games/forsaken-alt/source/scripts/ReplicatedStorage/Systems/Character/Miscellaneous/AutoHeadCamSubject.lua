-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        task.spawn(function() --[[ Line: 6 ]]
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local l_Character_0 = game.Players.LocalPlayer.Character;
            local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
            local v4 = {};
            local function v11(v5, v6, v7) --[[ Line: 15 ]] --[[ Name: setCamSubject ]]
                -- upvalues: v4 (copy), l_CurrentCamera_0 (copy), l_Humanoid_0 (copy)
                v4[v5] = v6 and {
                    Subject = v6, 
                    Priority = v7
                } or nil;
                local v8 = nil;
                for _, v10 in pairs(v4) do
                    if not v8 then
                        v8 = v10;
                    end;
                    if v10.Priority > v8.Priority then
                        v8 = v10;
                    end;
                end;
                l_CurrentCamera_0.CameraSubject = v8 and v8.Subject or l_Humanoid_0;
            end;
            local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
            if not l_PrimaryPart_0 then
                local v13 = tick();
                repeat
                    task.wait();
                    l_PrimaryPart_0 = l_Character_0.PrimaryPart;
                until l_PrimaryPart_0 or tick() > v13 + 3;
            end;
            if l_PrimaryPart_0 then
                l_PrimaryPart_0:GetPropertyChangedSignal("Anchored"):Connect(function() --[[ Line: 41 ]]
                    -- upvalues: l_Humanoid_0 (copy), v11 (copy), l_PrimaryPart_0 (ref), l_Character_0 (copy)
                    if l_Humanoid_0.Health > 0 then
                        v11("RootAnchored", l_PrimaryPart_0.Anchored and l_Character_0:FindFirstChild("Head", true), 1);
                    end;
                end);
            end;
            local _ = {};
            l_Character_0:GetAttributeChangedSignal("UsingAnimations"):Connect(function() --[[ Line: 50 ]]
                -- upvalues: l_Character_0 (copy), v11 (copy)
                local l_Value_0 = require(game.ReplicatedStorage.Initializer).PlayerSettings.EmoteCameraSubject.Value;
                local l_l_Character_0_Attribute_0 = l_Character_0:GetAttribute("UsingAnimations");
                v11("PlayingEmote", l_l_Character_0_Attribute_0 and l_Character_0:FindFirstChild(tostring(l_Value_0), true), 0);
            end);
        end);
    end
};