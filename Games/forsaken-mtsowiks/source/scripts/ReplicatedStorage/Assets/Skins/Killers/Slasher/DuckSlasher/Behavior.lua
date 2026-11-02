-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:17 2025 ]]
return {
    GetRig = function(_) --[[ Line: 3 ]] --[[ Name: GetRig ]]
        local l_script_Children_0 = script:GetChildren();
        return (l_script_Children_0[math.random(1, #l_script_Children_0)] or script:FindFirstChild("Duck")):Clone();
    end
};