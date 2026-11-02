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
            ["Text"] = "Why do the most unfortunate circumstances happen to me?"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "Well.. I tried swimming.."
        })
        p3:CreateDialog({
            ["Text"] = "BUT in a blink, EVERYTHING FROZE."
        })
    end
end
return v_u_1