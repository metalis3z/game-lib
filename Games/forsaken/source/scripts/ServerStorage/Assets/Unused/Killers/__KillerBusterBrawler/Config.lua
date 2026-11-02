-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "buster brawler", 
    Quote = "im super iconic!", 
    Credits = "Made By: ME!", 
    RenderImage = "rbxassetid://18997973596", 
    Price = 18, 
    Exclusive = true, 
    Health = #game.Players:GetPlayers() * 1000 + 2000, 
    Speed = 32, 
    SprintSpeed = 46, 
    StaminaLoss = 50, 
    StaminaGain = 20, 
    MaxStamina = 100, 
    AttackDamage = 20, 
    RootPartDamage = 20, 
    EnragedSlashLungeForce = 65, 
    CycloneKickDamage = 30, 
    FalconPunchDamage = 30, 
    RunPunchDamage = 30, 
    StrongLeftForce = 75, 
    Animations = {
        Idle = "rbxassetid://103927776722872", 
        Walk = "rbxassetid://74637796942810", 
        Run = "rbxassetid://74637796942810", 
        Stunned = {
            Start = "rbxassetid://95801006711774", 
            Loop = "rbxassetid://110796442787759", 
            End = "rbxassetid://133974319192349"
        }, 
        Victory = {
            KillerRig = "rbxassetid://73929615941775", 
            CameraRig = "rbxassetid://121159096428519"
        }, 
        Execution = {
            KillerRig = "rbxassetid://104029805778424", 
            PlayerRig = "rbxassetid://86470739857452"
        }, 
        Attack = "rbxassetid://112649211996431", 
        CorruptNature = "rbxassetid://84587596497053", 
        SummonPizzaDelivery = "rbxassetid://93602523400324", 
        WalkspeedOverrideStart = "rbxassetid://84454896999546", 
        WalkspeedOverrideLoop = "rbxassetid://138237743798166", 
        WalkspeedOverrideHit = "rbxassetid://111939240645588", 
        WalkspeedOverrideMiss = "rbxassetid://89260007040620", 
        StrongLeft = "rbxassetid://78512568261417", 
        StrongLeftEnd = "rbxassetid://113051538474487"
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://106029794447542", 
            "rbxassetid://96762479007469"
        }, 
        TerrorRadiusThemes = {
            [6] = {
                ID = "rbxassetid://0", 
                BPM = 81, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://79016487248667", 
        Ambience = "rbxassetid://14320498411", 
        CorruptThrow = "rbxassetid://111033845010938", 
        PizzaDeliveryGuySpawned = "rbxassetid://119993322066460", 
        PizzaDeliveryPunchGround = "rbxassetid://73139934333155", 
        WalkspeedOverrideLunge = "rbxassetid://105200830849301", 
        WalkspeedOverrideHit = "rbxassetid://116806980881542", 
        WalkspeedOverrideTimeout = "rbxassetid://123577398651116", 
        WalkspeedOverrideCollide = "rbxassetid://131584836684993", 
        Hit = "rbxassetid://110759725172567", 
        Swing = "rbxassetid://102228729296384", 
        Introduction = "rbxassetid://120121923711079"
    }
};