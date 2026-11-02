-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 86,
	Title = "Force Intermission End",
	Executable = true,
    Executed = function(_, _) --[[ Line: 8 ]] --[[ Name: Executed ]]
		local v2 = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
        if v2.IntermissionTimePast then
            v2.IntermissionTimePast = v2.IntermissionTimePast + 99999;
        end;
	end,
};