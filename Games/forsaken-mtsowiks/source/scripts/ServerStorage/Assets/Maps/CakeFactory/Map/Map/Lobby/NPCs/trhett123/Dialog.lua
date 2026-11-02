-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:53 2025 ]]
return {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://104600448510944"
        }
    }, 
    Interacted = function(v0) --[[ Line: 12 ]]
        v0:CreateDialog({
            Text = "I like waffles."
        });
    end
};