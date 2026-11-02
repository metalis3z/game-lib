-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
game:GetService("TweenService")
v_u_1.Config = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = false
}
function v_u_1.Interacted(p2)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p2:CreateDialog({
            ["Text"] = "This is so cool!"
        })
        p2:CreateDialog({
            ["Text"] = "Literally!"
        })
    else
        v_u_1.SpokenToBefore = true
        p2:CreateDialog({
            ["Text"] = "Wow... this new headset I got is great!"
        })
        p2:CreateDialog({
            ["Text"] = "It\'s so realistic, I can actually feel the cold!"
        })
    end
end
return v_u_1