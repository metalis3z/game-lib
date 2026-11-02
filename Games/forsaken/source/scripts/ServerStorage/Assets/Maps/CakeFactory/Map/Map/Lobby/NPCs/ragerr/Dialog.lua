-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:50 2025 ]]
local v0 = {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://70912459826953"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 11 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "I'm THE greatest forsaken player"
        });
        v1:CreateDialog({
            Text = "ME"
        });
        return;
    else
        v1:CreateDialog({
            Text = "I'm lowk buns at the game tho"
        });
        return;
    end;
end;
return v0;