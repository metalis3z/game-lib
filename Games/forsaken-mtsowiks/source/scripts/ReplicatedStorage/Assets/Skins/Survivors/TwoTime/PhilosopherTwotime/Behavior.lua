-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:13 2025 ]]
return {
    CreatedPost = function(_, v1) --[[ Line: 3 ]] --[[ Name: CreatedPost ]]
        if game:GetService("RunService"):IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            local v4 = true;
            do
                local l_l_Health_0_0, l_v4_0 = l_Health_0, v4;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 8 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), l_v4_0 (ref), v1 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 and l_v4_0 and v1.Rig:FindFirstChild("Life1") and v1.Rig.Life1:FindFirstChild("Torso") and v1.Rig.Life1.Torso:FindFirstChild("ouch") then
                        l_v4_0 = false;
                        v1.Rig.Life1.Torso.ouch:Play();
                        task.delay(1, function() --[[ Line: 13 ]]
                            -- upvalues: l_v4_0 (ref)
                            l_v4_0 = true;
                        end);
                    end;
                    l_l_Health_0_0 = l_Humanoid_0.Health;
                end);
            end;
        end;
    end
};