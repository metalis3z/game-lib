-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:37 2025 ]]
return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            do
                local l_l_Health_0_0 = l_Health_0;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 9 ]]
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