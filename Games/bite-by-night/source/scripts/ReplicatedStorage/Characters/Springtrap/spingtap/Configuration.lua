-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    ["Speed"] = 14,
    ["RunSpeed"] = 23,
    ["Health"] = 1750,
    ["Stamina"] = 70,
    ["Regen"] = 16,
    ["Dodges"] = 0,
    ["SlowStop"] = false,
    ["DefaultRunSpeed"] = 23,
    ["AxelessRunSpeed"] = 25,
    ["MaxTraps"] = 3,
    ["AxeDuration"] = 30,
    ["HitAxeDuration"] = 15,
    ["hitbox"] = Vector3.new(4, 8, 4),
    ["GrabCFrame"] = CFrame.new(0, -3, -2.803) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0),
    ["KillCFrame"] = CFrame.new(0, -1, -3),
    ["BeartrapStun"] = 10,
    ["Damage"] = {
        ["Swing"] = 34,
        ["SwingAxeless"] = 28,
        ["Grab"] = 0.4,
        ["Remnant Cleaver"] = 20,
        ["Beartrap"] = 12
    }
}
local v2 = {
    ["Swing"] = {
        ["Size"] = Vector3.new(8, 8, 9.5),
        ["CFrame"] = CFrame.new(0, 0, -4.75)
    },
    ["SwingAxeless"] = {
        ["Size"] = Vector3.new(6, 8, 9),
        ["CFrame"] = CFrame.new(0, 0, -4.5)
    },
    ["Grab"] = {
        ["Size"] = Vector3.new(5, 8, 8),
        ["CFrame"] = CFrame.new(0, 0, -4)
    },
    ["Remnant Cleaver"] = 5,
    ["Beartrap"] = 2
}
v1.Hitbox = v2
return v1
