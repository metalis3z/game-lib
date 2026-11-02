-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    }
}
v1.Config = v2
function v1.Interacted(p3)
    p3:CreateDialog({
        ["Text"] = "oh, hi! sorry i was listening to icicle!"
    })
    local v4 = {
        {
            ["Choice"] = "whats your name?"
        }
    }
    p3:GetUserResponse(v4)
    p3:CreateDialog({
        ["Text"] = "its obvious its snow related.. but snowball >_>"
    })
    local v5 = {
        {
            ["Choice"] = "icicle was just talking about snowballs!"
        }
    }
    p3:GetUserResponse(v5)
    p3:CreateDialog({
        ["Text"] = "lol! well im gonna keep talking to my friends :)"
    })
end
return v1