-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = {}
local v2 = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = true,
    ["Poses"] = {
        ["Idle"] = "rbxassetid://118276436606339"
    }
}
v1.Config = v2
function v1.Interacted(p3)
    p3:CreateDialog({
        ["Text"] = "I like waffles."
    })
end
return v1