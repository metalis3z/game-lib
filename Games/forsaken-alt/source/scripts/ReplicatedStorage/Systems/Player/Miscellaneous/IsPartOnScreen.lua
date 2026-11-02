-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        require(game.ReplicatedStorage.Modules.Network):SetConnection("IsOnScreen", "REMOTE_FUNCTION", function(...) --[[ Line: 8 ]]
            return (require(game.ReplicatedStorage.Modules.Util):IsOnScreen(...));
        end);
    end
};