-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Flashlight", 
    Description = "check out my new night light", 
    Icon = "rbxassetid://105017542674842", 
    Motor6D = script.FlashlightJoint, 
    Motor6DPart0 = "Right Arm", 
    SpawnInfo = {
        SpawnChance = 50, 
        MinSpawned = 0, 
        MaxSpawned = 0
    }, 
    ToggleCooldown = 0.1, 
    Animations = {
        Equipped = "rbxassetid://124897579233560", 
        Idle = "rbxassetid://129256575462813", 
        Activated = "rbxassetid://88159519767403"
    }, 
    Sounds = {
        On = "rbxassetid://9114481260", 
        Off = "rbxassetid://9114479857"
    }
};