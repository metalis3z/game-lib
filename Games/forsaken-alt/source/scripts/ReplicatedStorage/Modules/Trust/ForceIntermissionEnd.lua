-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Force Intermission End", 
    LayoutOrder = 86, 
    Executable = true, 
    Executed = function(_, _) --[[ Line: 8 ]] --[[ Name: Executed ]]
        local v2 = require(game.ServerStorage.ServerSystems.RoundManager);
        if v2.IntermissionTimePast then
            v2.IntermissionTimePast = v2.IntermissionTimePast + 99999;
        end;
    end
};