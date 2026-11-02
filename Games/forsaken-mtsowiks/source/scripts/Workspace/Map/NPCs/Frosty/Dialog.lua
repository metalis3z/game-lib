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
        ["Text"] = "hi im frosty :D"
    })
    local v4 = {
        {
            ["Choice"] = "hi frosty!"
        }
    }
    p3:GetUserResponse(v4)
    p3:CreateDialog({
        ["Text"] = "hello!!!"
    })
    local v5 = {
        {
            ["Choice"] = "you look a bit sad frosty D:"
        }
    }
    p3:GetUserResponse(v5)
    p3:CreateDialog({
        ["Text"] = "oh.. well..my friends make fun of me for having a black tophat :(("
    })
    local v6 = {
        {
            ["Choice"] = "aw thats so sad ;("
        }
    }
    p3:GetUserResponse(v6)
    p3:CreateDialog({
        ["Text"] = "yes but i moved on and i am now enjoying my winter wonderland!"
    })
end
return v1