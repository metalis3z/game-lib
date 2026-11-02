-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = {}
game:GetService("TweenService")
v1.Config = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = false
}
function v1.Interacted(p_u_2)
    p_u_2:CreateDialog({
        ["Text"] = "It\'s a small snowglobe."
    })
    p_u_2:CreateDialog({
        ["Text"] = "The snow falls with a snowman inside."
    })
    p_u_2:CreateDialog({
        ["Text"] = "You notice some writing."
    })
    p_u_2:CreateDialog({
        ["Text"] = "Read it?"
    })
    local v3 = {
        {
            ["Choice"] = "Yes"
        },
        {
            ["Choice"] = "No"
        }
    }
    p_u_2:ProcessResponse(p_u_2:GetUserResponse(v3), { function()
            -- upvalues: (copy) p_u_2
            p_u_2:CreateDialog({
                ["Text"] = "You take a closer look."
            })
            p_u_2:CreateDialog({
                ["Text"] = "\"Memento tempus fugit.\""
            })
            p_u_2:CreateDialog({
                ["Text"] = "It\'s interesting."
            })
        end, function()
            -- upvalues: (copy) p_u_2
            p_u_2:CreateDialog({
                ["Text"] = "Not today, then."
            })
        end })
end
return v1