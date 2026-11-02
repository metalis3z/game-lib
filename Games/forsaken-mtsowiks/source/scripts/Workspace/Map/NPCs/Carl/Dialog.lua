-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://107715594645264",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    },
    ["Actions"] = {
        ["Wave"] = "rbxassetid://128777973"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if v_u_1.TimesSpokenTo then
        local v4 = v_u_1
        v4.TimesSpokenTo = v4.TimesSpokenTo + 1
        p3:CreateDialog({
            ["Text"] = "the tables here are free"
        })
        p3:CreateDialog({
            ["Text"] = "they\'d cost more but there\'s no point in costing anything if i can\'t go to the store to spend my money"
        })
        p3:CreateDialog({
            ["Text"] = "because there are no stores here"
        })
    else
        v_u_1.TimesSpokenTo = 0
        p3:CreateDialog({
            ["Text"] = "yo"
        })
        p3:CreateDialog({
            ["Text"] = "the tables here are free"
        })
        p3:CreateDialog({
            ["Text"] = "they\'d cost more but there\'s no point in costing anything if i can\'t go to the store to spend my money"
        })
        p3:CreateDialog({
            ["Text"] = "because there are no stores here"
        })
    end
end
return v_u_1