-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = false,
    ["VoiceSFX"] = "rbxassetid://107648255423077",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    }
}
v1.Config = v2
function v1.Interacted(p_u_3)
    local v_u_4 = game.Players.LocalPlayer.PlayerData.Settings:FindFirstChild("AFK", true)
    if v_u_4 then
        local v_u_5 = require(game.ReplicatedStorage.Modules.Network)
        p_u_3:CreateDialog({
            ["Text"] = "You look at the hypnotizing movements of the grandfather clock. Even it can\'t tell the real time."
        })
        local v6 = {
            {
                ["Choice"] = "Enable AFK Mode"
            },
            {
                ["Choice"] = "Disable AFK Mode"
            },
            {
                ["Choice"] = "Cancel"
            }
        }
        p_u_3:ProcessResponse(p_u_3:GetUserResponse(v6), { function()
                -- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) p_u_3
                v_u_5:FireServerConnection("UpdateSettings", "REMOTE_EVENT", v_u_4, true)
                p_u_3:CreateDialog({
                    ["Text"] = "You suddenly feel at peace."
                })
            end, function()
                -- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) p_u_3
                v_u_5:FireServerConnection("UpdateSettings", "REMOTE_EVENT", v_u_4, false)
                p_u_3:CreateDialog({
                    ["Text"] = "You suddenly start to feel worried."
                })
            end, function() end })
    end
end
return v1