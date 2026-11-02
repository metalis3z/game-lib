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
        ["Text"] = "hee hee did you guys hear about- >_< oh hello!!"
    })
    local v4 = {
        {
            ["Choice"] = "hi whats your name? :?"
        }
    }
    p3:GetUserResponse(v4)
    p3:CreateDialog({
        ["Text"] = "oh me? i\'m icicle! good to meet you!!"
    })
    local v5 = {
        {
            ["Choice"] = "what do you like to do around here?"
        }
    }
    p3:GetUserResponse(v5)
    p3:CreateDialog({
        ["Text"] = "i like to make snowballs and throw them at my friends XD"
    })
end
return v1