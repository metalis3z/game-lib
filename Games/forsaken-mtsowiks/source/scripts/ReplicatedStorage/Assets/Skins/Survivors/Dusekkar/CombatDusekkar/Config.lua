-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:11:48 2025 ]]
return {
    DisplayName = "Combat Wizard", 
    Description = "An uncommon but elite group who are practitioners of magic, fielding in every part of study regarding it.", 
    RenderImage = "rbxassetid://113284076545529", 
    Price = 1500, 
    CollabInfo = "CombatInitiation", 
    VFXTemplate = script.VFX, 
    PlasmaBeamColor1 = Color3.fromRGB(255, 255, 0), 
    PlasmaBeamColor2 = Color3.fromRGB(255, 255, 0), 
    Voicelines = {
        Died = {
            "rbxassetid://172613272"
        }
    }, 
    Sounds = {
        SpawnProtectionActivate = "rbxassetid://10209268", 
        SpawnProtectionLoop = "rbxassetid://5272402531", 
        SpawnProtectionShieldBreak = {
            "rbxassetid://3727463344"; 
            Volume = 0.1
        }
    }, 
    Expressions = {
        Happy = "rbxassetid://84627315080756", 
        Default = "rbxassetid://91588663834343", 
        Hurt = "rbxassetid://83540224151209", 
        Injured = "rbxassetid://90031317199581", 
        Dead = "rbxassetid://138735634063459", 
        Drinking = "rbxassetid://139098226549474"
    }
};