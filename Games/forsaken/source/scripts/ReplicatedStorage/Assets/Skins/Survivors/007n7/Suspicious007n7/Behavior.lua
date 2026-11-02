-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            local v4 = true;
            do
                local l_l_Health_0_0, l_v4_0 = l_Health_0, v4;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 10 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), l_v4_0 (ref), v1 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 and l_v4_0 then
                        l_v4_0 = false;
                        v1.Rig.HumanoidRootPart.ouch:Play();
                        task.delay(0.5, function() --[[ Line: 14 ]]
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