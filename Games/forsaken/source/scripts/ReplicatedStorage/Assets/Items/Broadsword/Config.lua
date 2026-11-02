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
        Equipped = "rbxassetid://138230629687847", 
        Idle = "rbxassetid://95126164411079", 
        Swing1 = "rbxassetid://138338910936244", 
        Swing2 = "rbxassetid://113029297339705", 
        Swing3 = "rbxassetid://81026666181969"
    }, 
    Sounds = {
        Swing = "rbxassetid://7118966167", 
        Hit = "rbxassetid://935843979"
    }
};