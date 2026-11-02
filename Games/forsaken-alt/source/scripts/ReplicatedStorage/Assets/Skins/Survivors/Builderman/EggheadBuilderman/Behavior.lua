-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 3 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.HealthChanged:Connect(function(v3) --[[ Line: 7 ]]
                    -- upvalues: v1 (copy), l_Humanoid_0 (copy)
                    v1.Rig.Accessories.Torso.BuildermanEgg.Crack.Transparency = v3 <= l_Humanoid_0.MaxHealth / 2 and 0 or 1;
                end);
            end;
        end;
    end
};