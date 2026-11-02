-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if v_u_1.first then
        p3:CreateDialog({
            ["Text"] = "<Color=Blue>#LookingIntoThis<Color=/>..."
        })
    else
        v_u_1.first = true
        p3:CreateDialog({
            ["Text"] = "Hey again"
        })
        p3:CreateDialog({
            ["Text"] = "I\'m back to investigating this <Color=Blue>#Mysterious<Color=/> portrait"
        })
    end
end
return v_u_1