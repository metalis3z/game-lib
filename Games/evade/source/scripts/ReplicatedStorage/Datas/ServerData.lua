-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    IsContentCreatorGame = function() --[[ Line: 6 ]] --[[ Name: IsContentCreatorGame ]]
        return game.GameId == 8049249507;
    end, 
    IsDevGame = function() --[[ Line: 10 ]] --[[ Name: IsDevGame ]]
        return game.GameId == 7766605450;
    end, 
    IsProdGame = function() --[[ Line: 14 ]] --[[ Name: IsProdGame ]]
        return game.GameId == 7709344486;
    end
};