-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
game:GetService("TweenService")
v_u_1.Config = {
    ["PlayIdleOutsideOfDialog"] = false
}
function v_u_1.Interacted(p_u_2)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p_u_2:CreateDialog({
            ["Text"] = "Hope you\'re doing alright!"
        })
    else
        v_u_1.SpokenToBefore = true
        p_u_2:CreateDialog({
            ["Text"] = "Hello there!"
        })
        local v3 = {
            {
                ["Choice"] = "Wait, shouldn\'t you be hiding?"
            },
            {
                ["Choice"] = "Toothy deer man you dont have to hide behind a disguise, we all know its you"
            }
        }
        p_u_2:ProcessResponse(p_u_2:GetUserResponse(v3), { function()
                -- upvalues: (copy) p_u_2
                p_u_2:CreateDialog({
                    ["Text"] = "Oh no, you must be confusing me with my cousin."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "He thinks he looks strange, but I love him all the same."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Say, do you know where he is?"
                })
                local v4 = {
                    {
                        ["Choice"] = "Not sure, one day he was here and the next he was gone."
                    }
                }
                local v5 = { function()
                        -- upvalues: (ref) p_u_2
                        p_u_2:CreateDialog({
                            ["Text"] = "Oh, alright. Well, if you see him, tell him I said hello!"
                        })
                    end }
                p_u_2:ProcessResponse(p_u_2:GetUserResponse(v4), v5)
            end, function()
                -- upvalues: (copy) p_u_2
                p_u_2:CreateDialog({
                    ["Text"] = "Huh? What are you talking about...?"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Oh! You must be confusing me with my cousin."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "He thinks he looks strange, but I love him all the same."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Say, do you know where he is?"
                })
                local v6 = {
                    {
                        ["Choice"] = "Not sure, one day he was here and the next he was gone."
                    },
                    {
                        ["Choice"] = "I know it\'s you."
                    }
                }
                local v7 = { function()
                        -- upvalues: (ref) p_u_2
                        p_u_2:CreateDialog({
                            ["Text"] = "Oh, alright. Well, if you see him, tell him I said hello!"
                        })
                    end, function()
                        -- upvalues: (ref) p_u_2
                        p_u_2:CreateDialog({
                            ["Text"] = "Uhhh... I can assure you I\'m not him."
                        })
                        p_u_2:CreateDialog({
                            ["Text"] = "If you do seem, tell him I say hello."
                        })
                    end }
                p_u_2:ProcessResponse(p_u_2:GetUserResponse(v6), v7)
            end })
    end
end
return v_u_1