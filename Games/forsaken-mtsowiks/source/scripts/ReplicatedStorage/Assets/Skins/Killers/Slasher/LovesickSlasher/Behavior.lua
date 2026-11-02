-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:20 2025 ]]
return {
    EnragedReveal = function(_, v1) --[[ Line: 3 ]] --[[ Name: EnragedReveal ]]
        local l_Rig_0 = v1.Rig;
        for _, v4 in pairs(l_Rig_0.Head.RagingPaceAttachment:GetChildren()) do
            if v4:IsA("Beam") or v4:IsA("PointLight") or v4:IsA("ParticleEmitter") then
                v4.Enabled = true;
            end;
        end;
    end, 
    EnragedEnd = function(_, v6) --[[ Line: 13 ]] --[[ Name: EnragedEnd ]]
        local l_Rig_1 = v6.Rig;
        for _, v9 in pairs(l_Rig_1.Head.RagingPaceAttachment:GetChildren()) do
            if v9:IsA("Beam") or v9:IsA("PointLight") or v9:IsA("ParticleEmitter") then
                v9.Enabled = false;
            end;
        end;
    end
};