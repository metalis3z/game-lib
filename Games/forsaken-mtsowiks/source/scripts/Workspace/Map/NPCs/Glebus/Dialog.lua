-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://5416513331",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://76800635387262"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if not v_u_1.TimesInteracted then
        v_u_1.TimesInteracted = 0
    end
    local v4 = v_u_1
    v4.TimesInteracted = v4.TimesInteracted + 1
    if v_u_1.TimesInteracted == 1 then
        p3:CreateDialog({
            ["Text"] = "gleeb"
        })
        p3:CreateDialog({
            ["Text"] = "haha wasn\'t that a good one"
        })
        return
    elseif v_u_1.TimesInteracted == 2 then
        p3:CreateDialog({
            ["Text"] = "gleeb"
        })
        p3:CreateDialog({
            ["Text"] = "haha that one was good too wasn\'t it"
        })
        return
    elseif v_u_1.TimesInteracted == 3 then
        p3:CreateDialog({
            ["Text"] = "gleeb"
        })
        p3:CreateDialog({
            ["Text"] = "haha did i get you with that one"
        })
        return
    elseif v_u_1.TimesInteracted == 4 then
        p3:CreateDialog({
            ["Text"] = "gleeb"
        })
        p3:CreateDialog({
            ["Text"] = "haha that one\'s gotta be my funniest one yet"
        })
        return
    elseif v_u_1.TimesInteracted == 5 then
        p3:CreateDialog({
            ["Text"] = "okay dude now you\'re just dragging it on"
        })
    else
        p3:CreateDialog({
            ["Text"] = "..."
        })
    end
end
return v_u_1