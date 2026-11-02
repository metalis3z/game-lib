-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Broadsword", 
    Description = "this is just like sword fight on the heights", 
    Icon = "rbxassetid://10708917081", 
    Motor6D = script.BroadswordJoint, 
    Motor6DPart0 = "Right Arm", 
    SpawnInfo = {
        SpawnChance = 4, 
        MinSpawned = 0, 
        MaxSpawned = 1
    }, 
    SlashDamage = 25, 
    SlashCooldown = 0.75, 
    ThirdSlashDamage = 40, 
    ThirdSlashCooldown = 1.5, 
    Animations = {
        Equipped = "rbxassetid://100244684270893", 
        Idle = "rbxassetid://106879228427107", 
        Swing1 = "rbxassetid://126592149943201", 
        Swing2 = "rbxassetid://117887689685400", 
        Swing3 = "rbxassetid://17226764549"
    }, 
    Sounds = {
        Swing = "rbxassetid://7118966167", 
        Hit = "rbxassetid://935843979"
    }
};