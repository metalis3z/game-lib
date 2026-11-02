-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    ["Speed"] = 12,
    ["RunSpeed"] = 22,
    ["Health"] = 3000,
    ["Stamina"] = 65,
    ["Regen"] = 16,
    ["Dodges"] = 0,
    ["SlowStop"] = false,
    ["StaminaRemove"] = 10,
    ["hitbox"] = Vector3.new(3, 8, 3),
    ["KillCFrame"] = CFrame.new(0.1, -1.15, -1.95),
    ["Damage"] = {
        ["Swing-Strength"] = 40,
        ["Swing-Speed"] = 6,
        ["Swing-Stealth"] = 25,
        ["DigOut"] = 32,
        ["Grab"] = 25,
        ["Jump"] = 25
    }
}
local v2 = {
    ["Swing"] = {
        ["Size"] = Vector3.new(8, 8, 9),
        ["CFrame"] = CFrame.new(0, 0, -4.5)
    },
    ["DigOut"] = 10,
    ["Jump"] = 12
}
v1.Hitbox = v2
return v1
