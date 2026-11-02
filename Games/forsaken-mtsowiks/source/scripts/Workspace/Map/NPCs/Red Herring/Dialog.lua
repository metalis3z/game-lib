-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
game:GetService("TweenService")
v_u_1.Config = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = false
}
function v_u_1.Interacted(p_u_2)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p_u_2:CreateDialog({
            ["Text"] = "hi"
        })
    else
        v_u_1.SpokenToBefore = true
        p_u_2:CreateDialog({
            ["Text"] = "Heh! Hey! Long time no see!"
        })
        p_u_2:CreateDialog({
            ["Text"] = "Look I\'m a red herring haha!"
        })
        p_u_2:CreateDialog({
            ["Text"] = "Haha! I have learnt instant transmission!"
        })
        p_u_2:CreateDialog({
            ["Text"] = "heh..."
        })
        p_u_2:CreateDialog({
            ["Text"] = "..."
        })
        p_u_2:CreateDialog({
            ["Text"] = "please dont kill me"
        })
        local v3 = {
            {
                ["Choice"] = "kill"
            },
            {
                ["Choice"] = "Not today."
            },
            {
                ["Choice"] = "I won\'t"
            }
        }
        p_u_2:ProcessResponse(p_u_2:GetUserResponse(v3), { function()
                -- upvalues: (copy) p_u_2
                local v4 = { "awww mannn" }
                p_u_2:CreateDialog({
                    ["Text"] = v4[math.random(1, #v4)]
                })
            end, function()
                -- upvalues: (copy) p_u_2
                local v5 = { "Oh." }
                p_u_2:CreateDialog({
                    ["Text"] = v5[math.random(1, #v5)]
                })
            end, function()
                -- upvalues: (copy) p_u_2
                local v6 = { "bye" }
                p_u_2:CreateDialog({
                    ["Text"] = v6[math.random(1, #v6)]
                })
            end })
    end
end
return v_u_1