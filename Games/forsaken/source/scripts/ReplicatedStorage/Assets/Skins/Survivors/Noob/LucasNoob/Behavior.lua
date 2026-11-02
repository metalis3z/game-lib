-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Created = function(_, v1) --[[ Line: 3 ]] --[[ Name: Created ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            do
                local l_l_Health_0_0 = l_Health_0;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 8 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), v1 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 then
                        v1.Rig.HumanoidRootPart.ouch:Play();
                    end;
                    l_l_Health_0_0 = l_Humanoid_0.Health;
                end);
            end;
        end;
    end
};