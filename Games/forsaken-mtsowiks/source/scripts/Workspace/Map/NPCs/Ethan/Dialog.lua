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
            ["Text"] = "Again, let me know if you see her!"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "Hey, you look like a good seeker!"
        })
        p3:CreateDialog({
            ["Text"] = "Let me know if you spot a brown-haired girl around here with a black and blue sweater, okay?"
        })
        p3:CreateDialog({
            ["Text"] = "We were playing a game, but I haven\226\128\153t found her in a bit.."
        })
        p3:CreateDialog({
            ["Text"] = "I\226\128\153m sure she\226\128\153s around here though!"
        })
    end
end
return v_u_1