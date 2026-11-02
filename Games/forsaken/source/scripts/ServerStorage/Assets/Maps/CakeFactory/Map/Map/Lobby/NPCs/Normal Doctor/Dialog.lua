-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:53 2025 ]]
return {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }, 
    Interacted = function(v0) --[[ Line: 10 ]]
        v0:CreateDialog({
            Text = "No matter what I do, people keep looking at me weird!"
        });
        v0:CreateDialog({
            Text = "Is it something I did?"
        });
        v0:CreateDialog({
            Text = "I don\226\128\153t know why people keep treating me like I\226\128\153m evil!"
        });
        v0:CreateDialog({
            Text = "I\226\128\153m just a doctor.."
        });
        v0:CreateDialog({
            Text = ":("
        });
    end
};