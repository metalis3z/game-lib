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
            ["Text"] = "This ROCKS!"
        })
    else
        v_u_1.SpokenToBefore = true
        p_u_2:CreateDialog({
            ["Text"] = "Yo, buddy!"
        })
        p_u_2:CreateDialog({
            ["Text"] = "This environment is totally killer, right"
        })
        p_u_2:CreateDialog({
            ["Text"] = "I could rock on this all night long!"
        })
        p_u_2:CreateDialog({
            ["Text"] = "Whaddya\' think? Eh?"
        })
        local v3 = {
            {
                ["Choice"] = "Uh, sure?"
            },
            {
                ["Choice"] = "Nobody talks like that"
            }
        }
        p_u_2:ProcessResponse(p_u_2:GetUserResponse(v3), { function()
                -- upvalues: (copy) p_u_2
                p_u_2:CreateDialog({
                    ["Text"] = "Wicked, isn\'t it?"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Oh man, I could go down these slopes forever!"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "It\'s some real gnarly stuff, bro!"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "I gotta get in on this snow action soon."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Talk to ya\' later, okay?"
                })
            end, function()
                -- upvalues: (copy) p_u_2
                p_u_2:CreateDialog({
                    ["Text"] = "What\'re you talkin\' about, bud?"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Don\'t gotta be hatin\' on my style!"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "I bring nothin\' but good energy all around!"
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Maybe you\'re just not feelin\' it tonight, man."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Talk to ya\' later, okay?"
                })
            end })
    end
end
return v_u_1