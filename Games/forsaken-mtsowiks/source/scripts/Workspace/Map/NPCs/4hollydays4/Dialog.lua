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
            ["Text"] = "Still waiting..."
        })
    else
        v_u_1.SpokenToBefore = true
        p2:CreateDialog({
            ["Text"] = "Oh, hello!"
        })
        p2:CreateDialog({
            ["Text"] = "I\'m waiting on some friends so we can record our Christmas music video soon."
        })
        p2:CreateDialog({
            ["Text"] = "They have the camera, so I can\'t really start it without them."
        })
        p2:CreateDialog({
            ["Text"] = "But I\'ll keep on waiting!"
        })
        p2:CreateDialog({
            ["Text"] = "It\'s pretty under the snow, isn\'t it?"
        })
    end
end
return v_u_1