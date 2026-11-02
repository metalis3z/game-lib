-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:01 2025 ]]
return {
    OnIntroduction = function(_, _, _, v3) --[[ Line: 4 ]] --[[ Name: OnIntroduction ]]
        local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.45, "GasharpoonIntroScene");
        game.Debris:AddItem(l_FOVMultiplier_0, v3);
    end
};