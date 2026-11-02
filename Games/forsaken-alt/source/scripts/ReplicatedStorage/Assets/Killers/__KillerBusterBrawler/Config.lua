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
        Idle = "rbxassetid://124126523274003", 
        Walk = "rbxassetid://114897190872118", 
        Run = "rbxassetid://114897190872118", 
        Stunned = {
            Start = "rbxassetid://71318840517357", 
            Loop = "rbxassetid://84521781438011", 
            End = "rbxassetid://118264066689908"
        }, 
        Victory = {
            KillerRig = "rbxassetid://86968383017675", 
            CameraRig = "rbxassetid://112527946233530"
        }, 
        Execution = {
            KillerRig = "rbxassetid://130705858224305", 
            PlayerRig = "rbxassetid://110439983615647"
        }, 
        Attack = "rbxassetid://106493114661007", 
        CorruptNature = "rbxassetid://18885919947", 
        SummonPizzaDelivery = "rbxassetid://90047965393118", 
        WalkspeedOverrideStart = "rbxassetid://74010322255146", 
        WalkspeedOverrideLoop = "rbxassetid://118996377709995", 
        WalkspeedOverrideHit = "rbxassetid://71089140629040", 
        WalkspeedOverrideMiss = "rbxassetid://132839238623831", 
        StrongLeft = "rbxassetid://108144714437787", 
        StrongLeftEnd = "rbxassetid://98304604299835"
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