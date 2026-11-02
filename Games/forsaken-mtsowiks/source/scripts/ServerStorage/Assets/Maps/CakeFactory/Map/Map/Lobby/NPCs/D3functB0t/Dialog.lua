-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:51 2025 ]]
local v0 = {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://123307845513567"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 11 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "1 C4N'T M0V3 W1TH TH1S @#%!#< B0DY 0F M1N3!!!! (\226\151\163_\226\151\162)(\226\151\163_\226\151\162)(\226\151\163_\226\151\162)!!!!"
        });
        v1:CreateDialog({
            Text = "#$<@!!! \239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137!!!!"
        });
        v1:CreateDialog({
            Text = "wh4t3v3r. ;_;"
        });
        return;
    else
        v1:CreateDialog({
            Text = "?@#$>$!!!! @#>$?!!! \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140!!!!"
        });
        return;
    end;
end;
return v0;