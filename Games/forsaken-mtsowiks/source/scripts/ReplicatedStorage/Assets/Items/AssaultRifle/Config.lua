-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Assault Rifle", 
    Description = "finally, some REAL gunpower", 
    Icon = "rbxassetid://117272986392405", 
    Motor6D = script.GunJoint, 
    Motor6DPart0 = "Right Arm", 
    SpawnInfo = {
        SpawnChance = 10, 
        MinSpawned = 0, 
        MaxSpawned = 1
    }, 
    BaseDamage = 15, 
    TorsoDamage = 20, 
    HeadshotDamage = 30, 
    RPM = 500, 
    SemiAuto = false, 
    MagSize = 32, 
    ReservedAmmo = 384, 
    ReloadTime = 2.65, 
    Animations = {
		Equipped = "rbxassetid://136746561372481", 
		Idle = "rbxassetid://125111601379268", 
		Shoot = "rbxassetid://113508155691267", 
		Reloading = "rbxassetid://138440603790793"
    }, 
    Sounds = {
        Equipped = "rbxassetid://9114701864", 
        Shoot = "rbxassetid://8169240213", 
        Reloading = "rbxassetid://8850679817", 
        BulletHitMaterial = "rbxassetid://4427236368", 
        BulletHitFlesh = "rbxassetid://8636404035"
    }
};