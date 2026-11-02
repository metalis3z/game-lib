-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Init = function(_) --[[ Line: 4 ]] --[[ Name: Init ]]
        local v1 = require(game.ReplicatedStorage.Modules.Sounds);
        for _, v3 in pairs(workspace.Themes:GetChildren()) do
            if not v3:GetAttribute("DeloadOnDeath") then
                v1:StopTheme(v3.Name, 0.5, false);
            else
                game.TweenService:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    PlaybackSpeed = 1
                }):Play();
            end;
        end;
        v1:UpdateThemes();
    end
};