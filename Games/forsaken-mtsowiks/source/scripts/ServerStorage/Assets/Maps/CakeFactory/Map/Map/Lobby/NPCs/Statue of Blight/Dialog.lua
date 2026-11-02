-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:46 2025 ]]
return {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://5416666166", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }, 
    Interacted = function(v0) --[[ Line: 12 ]]
        v0:CreateDialog({
            Text = "The undead rises from the cold wastes of the night,"
        });
        v0:CreateDialog({
            Text = "Former humans that have adapted to their withering blight."
        });
        v0:CreateDialog({
            Text = "They march endlessly for the knowledge they crave and desire,"
        });
        v0:CreateDialog({
            Text = "With their army of necromancers burning all who oppose with blue fire."
        });
        v0:CreateDialog({
            Text = "No one can tarnish their desperate wishes and goal,"
        });
        v0:CreateDialog({
            Text = "Less they end up as one of them, another lost soul."
        });
    end
};