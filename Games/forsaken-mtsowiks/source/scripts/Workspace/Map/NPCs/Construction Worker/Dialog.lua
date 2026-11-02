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
    if v_u_1.SpokenToBefore then
        p3:CreateDialog({
            ["Text"] = "pretty please dont go over my barrier"
        })
        p3:CreateDialog({
            ["Text"] = "i spent a lot of time making it just so that you dont go past it"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "i was told to not let anyone go past this point because of like evil monsters or something"
        })
        p3:CreateDialog({
            ["Text"] = "so you can\'t go past these planks i built"
        })
        p3:CreateDialog({
            ["Text"] = "unless you like climb over them"
        })
        p3:CreateDialog({
            ["Text"] = "but you wouldnt do that i think"
        })
    end
end
return v_u_1