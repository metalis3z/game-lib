-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        require(game.ReplicatedStorage.Modules.Network):SetConnection("ApplyCameraShake", "REMOTE_EVENT", function(...) --[[ Line: 8 ]]
            require(game.ReplicatedStorage.Modules.Util):ApplyCameraShake(...);
        end);
    end
};