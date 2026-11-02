-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://107648255423077",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    }
}
v1.Config = v2
function v1.Interacted(p_u_3)
    p_u_3:CreateDialog({
        ["Text"] = "Mmarghh.. Mmmrgh.."
    })
    p_u_3:CreateDialog({
        ["Text"] = "RRGH? Rrghh..."
    })
    local v4 = {
        {
            ["Choice"] = "Yuck"
        },
        {
            ["Choice"] = "What are you?"
        },
        {
            ["Choice"] = "You look yummy"
        }
    }
    p_u_3:ProcessResponse(p_u_3:GetUserResponse(v4), { function()
            -- upvalues: (copy) p_u_3
            local v5 = {
                "MMMMRAGGH",
                "MARRGHH! HAAARGHH!!!!",
                "AGHRGHHRAAAAHHH",
                "HHRGRRAHHH!!!",
                "NNRAHHGHHH! NHHRRAGGHH!!",
                "MMRRGHHHRHGG!!",
                "HHRAGGHHH! HRGGRHHHG!!"
            }
            p_u_3:CreateDialog({
                ["Text"] = v5[math.random(1, #v5)]
            })
        end, function()
            -- upvalues: (copy) p_u_3
            local v6 = {
                "Mrrghh.. hhnghh..",
                "hhghhh.. gllrgrg..",
                "Ghhrggh...",
                "Hhrrhhrrghh.. gghhhhnn..",
                "Nnhhhrhhggghhh..."
            }
            p_u_3:CreateDialog({
                ["Text"] = v6[math.random(1, #v6)]
            })
        end, function()
            -- upvalues: (copy) p_u_3
            p_u_3:CreateDialog({
                ["Text"] = "!!!"
            })
            local v7 = {
                "RRAGHGH! MARRGH!! HHAAARRGGH!!!!!",
                "RRAGHGH! HHAAARRGGH!! MARRGH!!!!!",
                "HHAAARRGGH! RRAGHGH!! MARRGH!!!!!",
                "HHAAARRGGH! MARRGH!! RRAGHGH!!!!!",
                "MARRGH! HHAAARRGGH!! RRAGHGH!!!!!",
                "MARRGH! RRAGHGH!! HHAAARRGGH!!!!!"
            }
            p_u_3:CreateDialog({
                ["Text"] = v7[math.random(1, #v7)]
            })
        end })
end
return v1