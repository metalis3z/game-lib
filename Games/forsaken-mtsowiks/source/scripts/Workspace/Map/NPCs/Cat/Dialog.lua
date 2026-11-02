-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://107715594645264",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    },
    ["Actions"] = {
        ["Wave"] = "rbxassetid://128777973"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if v_u_1.TimesSpokenTo then
        local v4 = v_u_1
        v4.TimesSpokenTo = v4.TimesSpokenTo + 1
        if v_u_1.TimesSpokenTo == 15 then
            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "ILoveCats")
            p3:CreateDialog({
                ["Text"] = "meow meow meow AGHHAGGAUGHUUGHGHGHG"
            })
        else
            local v5 = {
                "meow",
                "mew",
                "mrow",
                "myeow",
                "miau",
                "nyaw",
                "nya",
                "mmrrp",
                "prrrr"
            }
            p3:CreateDialog({
                ["Text"] = v5[math.random(1, #v5)]
            })
        end
    else
        v_u_1.TimesSpokenTo = 0
        p3:CreateDialog({
            ["Text"] = "What u looking at punk."
        })
        p3:CreateDialog({
            ["Text"] = "Yeah I can talk. whats it to ya. punk."
        })
        return
    end
end
return v_u_1