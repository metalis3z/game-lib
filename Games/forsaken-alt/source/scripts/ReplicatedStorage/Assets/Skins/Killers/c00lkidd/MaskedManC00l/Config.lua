-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Masked Man", 
    Description = "Not even a fragment of life remains inside it.", 
    RenderImage = "rbxassetid://123797035379694", 
    Price = 1200, 
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
        Execution = "rbxassetid://103913079694429", 
        CorruptThrow = {
            "rbxassetid://113619790680549", 
            "rbxassetid://137640840999703", 
            "rbxassetid://132532703510390"
        }, 
        CorruptAmbience = "rbxassetid://123490041003045", 
        CorruptHit = "rbxassetid://91316049027243", 
        PizzaDeliveryGuySpawned = "rbxassetid://92571966229021", 
        PizzaDeliveryPunchGround = "rbxassetid://80092213739576", 
        WalkspeedOverrideLunge = "rbxassetid://75006340803049", 
        WalkspeedOverrideHit = "rbxassetid://110758360963976", 
        WalkspeedOverrideTimeout = "rbxassetid://129733185077837", 
        WalkspeedOverrideCollide = "rbxassetid://110324041664787", 
        Hit = "rbxassetid://71143181240728", 
        Swing = "rbxassetid://82221759983649", 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://83855733419141", 
                BPM = 126
            }, 
            [40] = {
                ID = "rbxassetid://129061217337333", 
                BPM = 126
            }, 
            [20] = {
                ID = "rbxassetid://85325066110175", 
                BPM = 126
            }, 
            [6] = {
                ID = "rbxassetid://88590561512814", 
                BPM = 200, 
                Chase = true
            }
        }
    }, 
    PizzaDeliveryAnimations = {
        Summoned = "rbxassetid://82692267744166", 
        Idle = "rbxassetid://104020071250999", 
        Walk = "rbxassetid://92757584647535", 
        Hit = "rbxassetid://110389186206009"
    }, 
    Execution007n7 = false
};