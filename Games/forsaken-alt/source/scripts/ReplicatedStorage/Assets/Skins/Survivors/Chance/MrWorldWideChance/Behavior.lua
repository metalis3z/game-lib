-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    GetRig = function(_) --[[ Line: 3 ]] --[[ Name: GetRig ]]
        local l_script_Children_0 = script:GetChildren();
        return (l_script_Children_0[math.random(1, #l_script_Children_0)] or script:FindFirstChild("AmericanChance")):Clone();
    end
};