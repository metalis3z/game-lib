-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DisableHealthbar, time of decompilation: Fri Nov 28 21:12:38 2025 ]]
return {
    Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
    end
};