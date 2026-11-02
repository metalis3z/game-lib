-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:51 2025 ]]
return {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://70912459826953"
        }
    }, 
    Interacted = function(v0) --[[ Line: 12 ]]
        v0:CreateDialog({
            Text = "I ordered a pizza before I was taken into this place... it was taking a while tho."
        });
    end
};