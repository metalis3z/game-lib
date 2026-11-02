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
        ["Text"] = "HELLO"
    })
    local v4 = {
        {
            ["Choice"] = "oh um, whats your name?"
        }
    }
    p3:GetUserResponse(v4)
    p3:CreateDialog({
        ["Text"] = "MELTY"
    })
    local v5 = {
        {
            ["Choice"] = "i can only wonder why >_>"
        }
    }
    p3:GetUserResponse(v5)
    p3:CreateDialog({
        ["Text"] = "YEAH HAHAHA BYE NOW BYE GET OUT NOW BYE"
    })
end
return v1