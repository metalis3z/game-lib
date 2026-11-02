-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 85,
	Title = "Force Round End",
	Executable = true,
    Executed = function(_, _) --[[ Line: 8 ]] --[[ Name: Executed ]]
		local v2 = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
        if v2.CurrentSession and v2.CurrentSession.TimePast then
            local l_CurrentSession_0 = v2.CurrentSession;
            l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast + 99999;
        end;
	end,
};