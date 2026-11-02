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
    if v_u_1.choice == 1 then
        p_u_3:CreateDialog({
            ["Text"] = "How quiet it has gotten."
        })
        p_u_3:CreateDialog({
            ["Text"] = "Crops have gone undisturbed as I ensured."
        })
        return
    elseif v_u_1.choice == 2 then
        p_u_3:CreateDialog({
            ["Text"] = "Tread lightly."
        })
    else
        p_u_3:CreateDialog({
            ["Text"] = "All are victim to its influence and live each day."
        })
        p_u_3:CreateDialog({
            ["Text"] = "To see everything as it is will be when you are truly living."
        })
        p_u_3:CreateDialog({
            ["Text"] = "With curiosity, there is reason."
        })
        p_u_3:CreateDialog({
            ["Text"] = "A motivation to seek answers."
        })
        local v4 = {
            {
                ["Choice"] = "What\'s up with the mask?"
            },
            {
                ["Choice"] = "Huh?"
            }
        }
        local v5 = { function()
                -- upvalues: (copy) p_u_3, (ref) v_u_1
                p_u_3:CreateDialog({
                    ["Text"] = "A figure that is representative of what I am."
                })
                v_u_1.choice = 1
            end, function()
                -- upvalues: (copy) p_u_3, (ref) v_u_1
                p_u_3:CreateDialog({
                    ["Text"] = "Influence will remain for as long as your presence does."
                })
                p_u_3:CreateDialog({
                    ["Text"] = "It watches every moment."
                })
                p_u_3:CreateDialog({
                    ["Text"] = "Stay for as long as you wish, only I can watch where we all stand."
                })
                v_u_1.choice = 2
            end }
        p_u_3:ProcessResponse(p_u_3:GetUserResponse(v4), v5)
    end
end
return v_u_1