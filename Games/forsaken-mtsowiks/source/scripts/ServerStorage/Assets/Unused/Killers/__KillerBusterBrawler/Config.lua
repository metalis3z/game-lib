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
        Idle = "rbxassetid://104204164861011", 
        Walk = "rbxassetid://123634588068446", 
        Run = "rbxassetid://123634588068446", 
        Stunned = {
            Start = "rbxassetid://135773314678691", 
            Loop = "rbxassetid://102867148831844", 
            End = "rbxassetid://84854658372494"
        }, 
        Victory = {
            KillerRig = "rbxassetid://94672089154587", 
            CameraRig = "rbxassetid://91079835068264"
        }, 
        Execution = {
            KillerRig = "rbxassetid://115466116169950", 
            PlayerRig = "rbxassetid://82343317513950"
        }, 
        Attack = "rbxassetid://80428193483930", 
        CorruptNature = "rbxassetid://126618846292846", 
        SummonPizzaDelivery = "rbxassetid://137093319652059", 
        WalkspeedOverrideStart = "rbxassetid://97078136860954", 
        WalkspeedOverrideLoop = "rbxassetid://119305560883480", 
        WalkspeedOverrideHit = "rbxassetid://132403614334554", 
        WalkspeedOverrideMiss = "rbxassetid://90093577584193", 
        StrongLeft = "rbxassetid://104612739329318", 
        StrongLeftEnd = "rbxassetid://101758284096556"
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