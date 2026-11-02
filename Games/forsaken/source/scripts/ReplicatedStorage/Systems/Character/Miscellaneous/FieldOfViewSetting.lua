-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_FirstChild_0 = l_LocalPlayer_0.PlayerData:FindFirstChild("FieldOfView", true);
        if l_FirstChild_0 then
            require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(l_LocalPlayer_0, l_FirstChild_0.Value / 70, "FOVSetting");
        end;
    end
};