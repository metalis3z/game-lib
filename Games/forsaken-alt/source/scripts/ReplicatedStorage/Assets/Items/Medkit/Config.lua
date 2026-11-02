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
		Equipped = "rbxassetid://119353017198818", 
		Idle = "rbxassetid://92258313909186", 
		Heal = "rbxassetid://81394541764352"
    }, 
    Sounds = {
        Healing = "rbxassetid://85635774971278"
    }
};