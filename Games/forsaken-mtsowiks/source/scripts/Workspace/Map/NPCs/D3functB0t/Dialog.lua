-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = true,
    ["Poses"] = {
        ["Idle"] = "rbxassetid://103376827520240"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p3:CreateDialog({
            ["Text"] = "?@#$>$!!!! @#>$?!!! \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140 \226\139\139_\226\139\140!!!!"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "1 C4N\'T M0V3 W1TH TH1S @#%!#< B0DY 0F M1N3!!!! (\226\151\163_\226\151\162)(\226\151\163_\226\151\162)(\226\151\163_\226\151\162)!!!!"
        })
        p3:CreateDialog({
            ["Text"] = "#$<@!!! \239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137\239\188\136\239\188\158\208\180\239\188\156\239\188\137!!!!"
        })
        p3:CreateDialog({
            ["Text"] = "wh4t3v3r. ;_;"
        })
    end
end
return v_u_1