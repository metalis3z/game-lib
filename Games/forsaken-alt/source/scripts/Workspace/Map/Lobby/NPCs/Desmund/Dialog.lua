-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }, 
    Interacted = function(v0) --[[ Line: 10 ]]
        v0:CreateDialog({
            Text = "this guy does SUCH a cool trick dude you gotta see it"
        });
    end
};