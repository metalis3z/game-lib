-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    GetRig = function(_, v1) --[[ Line: 4 ]] --[[ Name: GetRig ]]
        local l_script_Children_0 = script:GetChildren();
        local v3 = l_script_Children_0[math.random(1, (math.clamp(#l_script_Children_0, 1, 1e999)))] or script:FindFirstChild("1x1x1x1");
        v1.CosplayType = v3.Name;
        v1.Config.Voicelines = v1.Config.VoicelineTypes and v1.Config.VoicelineTypes[v1.CosplayType];
        return (v3:Clone());
    end
};