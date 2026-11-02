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
function v_u_1.Interacted(p_u_3)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p_u_3:CreateDialog({
            ["Text"] = "No snitching!"
        })
    else
        v_u_1.SpokenToBefore = true
        p_u_3:CreateDialog({
            ["Text"] = "Oh! Haha, You found me! Congrats!"
        })
        p_u_3:CreateDialog({
            ["Text"] = "Don\226\128\153t tell Ethan yet, though! Okay?"
        })
        local v4 = {
            {
                ["Choice"] = "Okay"
            },
            {
                ["Choice"] = "Nah"
            },
            {
                ["Choice"] = "Bye"
            }
        }
        p_u_3:ProcessResponse(p_u_3:GetUserResponse(v4), { function()
                -- upvalues: (copy) p_u_3
                local v5 = { "Glad to have a pal, see ya\226\128\153 later!" }
                p_u_3:CreateDialog({
                    ["Text"] = v5[math.random(1, #v5)]
                })
            end, function()
                -- upvalues: (copy) p_u_3
                local v6 = { "H-Hey! Keep it down!", "I wanna win this!" }
                p_u_3:CreateDialog({
                    ["Text"] = v6[math.random(1, #v6)]
                })
            end, function()
                -- upvalues: (copy) p_u_3
                local v7 = { "Cya, don\'t be snitching!" }
                p_u_3:CreateDialog({
                    ["Text"] = v7[math.random(1, #v7)]
                })
            end })
    end
end
return v_u_1