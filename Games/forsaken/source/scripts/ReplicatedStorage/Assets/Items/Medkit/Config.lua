-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Medkit", 
    Description = "no it's not the phighting character", 
    Icon = "rbxassetid://122136678764357", 
    Motor6D = script.MedkitJoint, 
    Motor6DPart0 = "HumanoidRootPart", 
    SpawnInfo = {
        SpawnChance = 35, 
        MinSpawned = 0, 
        MaxSpawned = 2
    }, 
    HealTime = 7, 
    HealAmount = 80, 
    HealSpeedMultiplier = 0.2, 
    Animations = {
		Equipped = "rbxassetid://136663874730378", 
		Idle = "rbxassetid://122186620737334", 
		Heal = "rbxassetid://80287459052083"
    }, 
    Sounds = {
        Healing = "rbxassetid://85635774971278"
    }
};