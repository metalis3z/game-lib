-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(v0, _) --[[ Line: 3 ]] --[[ Name: Updated ]]
        if not v0.IsInitialized then
            v0.IsInitialized = true;
            return;
        else
            require(game.ReplicatedStorage.Systems.Player.Game.SmoothShiftLock):BindKeybinds();
            return;
        end;
    end
};