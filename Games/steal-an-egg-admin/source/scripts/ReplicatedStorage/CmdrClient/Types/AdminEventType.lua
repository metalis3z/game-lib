-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local v1 = {
    "RecoveryEvent",
    "DemonicEvent",
    "Countdown",
    "DragonEggEvent",
    "CaptureTheEgg",
    "GreatBloom",
    "AdminAbuse",
    "MonsterEvent",
    "MonsterParasite",
    "AdminTreadmill"
}
local v2 = {}
for v3, v4 in v1 do
    if v4 ~= "CaptureTheEgg" then
        table.insert(v2, v4)
    end
end
return function(v5) -- line 31 | captures: v1, v2
    v5:RegisterType("adminEventType", v5.Cmdr.Util.MakeEnumType("AdminEventType", v1))
    v5:RegisterType("adminStartEventType", v5.Cmdr.Util.MakeEnumType("AdminStartEventType", v2))
end
