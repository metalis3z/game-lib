-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    ["Speed"] = 12,
    ["RunSpeed"] = 23,
    ["Health"] = 2500,
    ["Stamina"] = 70,
    ["Regen"] = 18,
    ["Dodges"] = 0,
    ["SlowStop"] = false,
    ["hitbox"] = Vector3.new(3, 8, 3),
    ["KillCFrame"] = CFrame.new(0, -0.865, -2.705),
    ["Damage"] = {
        ["Swing"] = 32,
        ["Explode"] = 25
    }
}
local v2 = {
    ["Pull"] = 4,
    ["Swing"] = {
        ["Size"] = Vector3.new(8, 8, 10),
        ["CFrame"] = CFrame.new(0, 0, -4.5)
    },
    ["Explode"] = 12
}
v1.Hitbox = v2
return v1
