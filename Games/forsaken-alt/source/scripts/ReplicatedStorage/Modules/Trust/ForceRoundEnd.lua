-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Force Round End", 
    LayoutOrder = 85, 
    Executable = true, 
    Executed = function(_, _) --[[ Line: 8 ]] --[[ Name: Executed ]]
        local v2 = require(game.ServerStorage.ServerSystems.RoundManager);
        if v2.CurrentSession and v2.CurrentSession.TimePast then
            local l_CurrentSession_0 = v2.CurrentSession;
            l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast + 99999;
        end;
    end
};