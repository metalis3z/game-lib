-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Glock 19", 
    Description = "time to show those killers what you're made of", 
    Icon = "rbxassetid://18120568176", 
    Motor6D = script.GunJoint, 
    Motor6DPart0 = "Right Arm", 
    SpawnInfo = {
        SpawnChance = 10, 
        MinSpawned = 0, 
        MaxSpawned = 1
    }, 
    BaseDamage = 20, 
    TorsoDamage = 25, 
    HeadshotDamage = 40, 
    RPM = 400, 
    MagSize = 8, 
    ReservedAmmo = 128, 
    ReloadTime = 2.65, 
    Animations = {
        Equipped = "rbxassetid://109222305074533", 
        Idle = "rbxassetid://128460902270762", 
        Shoot = "rbxassetid://94149998773962", 
        Reloading = "rbxassetid://85371427723123"
    }, 
    Sounds = {
        Equipped = "rbxassetid://9114701864", 
        Shoot = "rbxassetid://4502821590", 
        Reloading = "rbxassetid://8850679817", 
        BulletHitMaterial = "rbxassetid://4427236368", 
        BulletHitFlesh = "rbxassetid://8636404035"
    }
};