-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(_, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        game.TweenService:Create(game.SoundService:WaitForChild("Voicelines"), TweenInfo.new(0.1), {
            Volume = v1 / 100
        }):Play();
    end
};