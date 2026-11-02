-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Savior", 
    Description = "No matter the cost.", 
    RenderImage = "rbxassetid://111699685651124", 
    Price = 1200, 
    Animations = {
		Attack = "rbxassetid://119826055544730", 
		Run = "rbxassetid://124375345960277", 
		WalkspeedOverrideHit = "rbxassetid://89727418203994", 
        Execution007n7 = false
    }, 
    PizzaDeliveryRig = script.PizzaDeliveryRig, 
    Projectile = script.Projectile, 
    Voicelines = {
        Idle = false, 
        Kill = false, 
        WalkspeedOverrideHit = false, 
        WalkspeedOverrideCollide = false, 
        WalkspeedOverrideTimeout = false, 
        Stunned = false, 
        LastSurvivor = false, 
        KillNoob = false, 
        KillElliot = false, 
        KillGuest1337 = false, 
        Kill007n7 = false, 
        CorruptNature = false, 
        PizzaDelivery = false, 
        PizzaDeliveryHit = false, 
        WalkspeedOverride = false
    }, 
    Sounds = {
        CorruptThrow = "rbxassetid://75330693422988", 
        CorruptHit = "rbxassetid://134042647920943", 
        PizzaDeliveryGuySpawned = "rbxassetid://82443348611109", 
        PizzaDeliveryPunchGround = "rbxassetid://129046352981084", 
        WalkspeedOverrideLunge = "rbxassetid://125427128221522", 
        WalkspeedOverrideHit = "rbxassetid://73016385873609", 
        WalkspeedOverrideTimeout = "rbxassetid://128202728411311", 
        WalkspeedOverrideCollide = "rbxassetid://85670331670100", 
        Hit = "rbxassetid://92022926286674", 
        Swing = "rbxassetid://75330693422988", 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://116301176570622", 
                BPM = 140
            }, 
            [40] = {
                ID = "rbxassetid://103939867987981", 
                BPM = 140
            }, 
            [20] = {
                ID = "rbxassetid://99065260170958", 
                BPM = 140
            }, 
            [6] = {
                ID = "rbxassetid://104824061725770", 
                BPM = 140, 
                Chase = true
            }
        }
    }
};