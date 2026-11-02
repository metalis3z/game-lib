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
        if v_u_1.AcceptedGift then
            p_u_2:CreateDialog({
                ["Text"] = "They look delighted to see you."
            })
            p_u_2:CreateDialog({
                ["Text"] = "They wish you a merry christmas."
            })
        else
            p_u_2:CreateDialog({
                ["Text"] = "They\'re quiet."
            })
        end
    else
        p_u_2:CreateDialog({
            ["Text"] = "It looks as though they want to give you something."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Do you accept?"
        })
        local v3 = {
            {
                ["Choice"] = "Yes"
            },
            {
                ["Choice"] = "No"
            }
        }
        local v4 = p_u_2:GetUserResponse(v3)
        v_u_1.SpokenToBefore = true
        p_u_2:ProcessResponse(v4, { function()
                -- upvalues: (copy) p_u_2, (ref) v_u_1
                p_u_2:CreateDialog({
                    ["Text"] = "You receive a note with fancy writing."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "\"Do not fret. I am nothing but kindness and a gift.\""
                })
                p_u_2:CreateDialog({
                    ["Text"] = "\"I am also your friend, even if it is only temporarily.\""
                })
                p_u_2:CreateDialog({
                    ["Text"] = "\"It is a pleasure to meet you.\""
                })
                p_u_2:CreateDialog({
                    ["Text"] = "\"May we have a wonderous christmas together.\""
                })
                p_u_2:CreateDialog({
                    ["Text"] = "\"With regards, Gift Monster.\""
                })
                p_u_2:CreateDialog({
                    ["Text"] = "You keep the note in your pockets."
                })
                v_u_1.AcceptedGift = true
            end, function()
                -- upvalues: (copy) p_u_2, (ref) v_u_1
                p_u_2:CreateDialog({
                    ["Text"] = "They look dejected by your reaction..."
                })
                v_u_1.AcceptedGift = false
            end })
        return
    end
end
return v_u_1