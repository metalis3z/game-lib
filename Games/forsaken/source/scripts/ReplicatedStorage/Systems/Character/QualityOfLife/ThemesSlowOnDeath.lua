-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        task.spawn(function() --[[ Line: 6 ]]
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Once(function() --[[ Line: 13 ]]
                for _, v2 in pairs(workspace.Themes:GetChildren()) do
                    game.TweenService:Create(v2, TweenInfo.new(0.5), {
                        PlaybackSpeed = 0
                    }):Play();
                end;
            end);
        end);
    end
};