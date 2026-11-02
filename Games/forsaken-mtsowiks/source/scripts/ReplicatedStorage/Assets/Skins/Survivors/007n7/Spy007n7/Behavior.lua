-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:31 2025 ]]
return {
    GetRig = function(_) --[[ Line: 4 ]] --[[ Name: GetRig ]]
        local l_script_Children_0 = script:GetChildren();
        return (l_script_Children_0[math.random(1, (math.clamp(#l_script_Children_0, 1, 1e999)))] or script:FindFirstChild("RED")):Clone();
    end
};