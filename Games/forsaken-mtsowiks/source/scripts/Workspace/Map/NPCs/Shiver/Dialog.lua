-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
game:GetService("TweenService")
v_u_1.Config = {
    ["PlayIdleOutsideOfDialog"] = false
}
function v_u_1.Interacted(p2)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p2:CreateDialog({
            ["Text"] = "snowy snow"
        })
    else
        v_u_1.SpokenToBefore = true
        p2:CreateDialog({
            ["Text"] = "hi"
        })
        p2:CreateDialog({
            ["Text"] = "i\'m shiver"
        })
        p2:CreateDialog({
            ["Text"] = "i like the sno"
        })
        p2:CreateDialog({
            ["Text"] = "what about you?"
        })
        p2:CreateDialog({
            ["Text"] = "eh, doesn\'t matter"
        })
        p2:CreateDialog({
            ["Text"] = "i just like the sno"
        })
        p2:CreateDialog({
            ["Text"] = "hehe"
        })
        p2:CreateDialog({
            ["Text"] = "lots of it this year"
        })
        p2:CreateDialog({
            ["Text"] = "hope to see more soon"
        })
    end
end
return v_u_1