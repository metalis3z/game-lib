-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:55 2025 ]]
local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://6564956178", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }, 
        Actions = {
            Wave = "rbxassetid://128777973"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 14 ]]
    -- upvalues: v0 (copy)
    if not v0.TimesSpokenTo then
        v0.TimesSpokenTo = 0;
        v1:CreateDialog({
            Text = "yo its me the talking bat"
        });
        v1:CreateDialog({
            Text = "my bros are all getting ready to leave. guess its time to move on..."
        });
        v1:CreateDialog({
            Text = "well. except for me. im staying lol"
        });
        return;
    else
        local l_v0_0 = v0;
        l_v0_0.TimesSpokenTo = l_v0_0.TimesSpokenTo + 1;
        v1:CreateDialog({
            Text = "looks like the scary season is almost over..."
        });
        v1:CreateDialog({
            Text = "you guys even fixed the window already. that was quick!"
        });
        return;
    end;
end;
return v0;