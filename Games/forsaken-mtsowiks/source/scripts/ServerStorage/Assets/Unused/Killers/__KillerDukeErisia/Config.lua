-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Duke Erisia", 
    Quote = "Indolent worm.", 
    Credits = "\240\159\145\133\240\159\145\133\240\159\145\133\240\159\145\133\240\159\145\133\240\159\145\133\240\159\145\133\240\159\145\133", 
    RenderImage = "rbxassetid://12931215778", 
    Price = 99999, 
    Exclusive = true, 
    Information = {
        {
            Separator = "GENERAL INFO"
        }, 
        {
            Header = "Duke Ishamon Erisia", 
            Text = "SO, once you're in layer 2. What you're gonna wanna do is- <b><font color=\"rgb(113, 138, 96)\">Yo.</font></b> WHAT???!! DUKE OF ERISIA??.. <b><font color=\"rgb(113, 138, 96)\">Yeah?</font></b> WHY ARE YOU SO CAKED UP???!!"
        }, 
        {
            Separator = "ABILITIES"
        }, 
        {
            Image = nil, 
            Header = "Strong Left", 
            Text = "<b><font color=\"rgb(113, 138, 96)\">The Duke</font></b> will charge up a punch, and teleport to his target."
        }, 
        {
            Image = nil, 
            Header = "Critical", 
            Text = "<b><font color=\"rgb(113, 138, 96)\">The Duke</font></b> attempts to grab his victim before slamming them into the ground head-first."
        }, 
        {
            Image = nil, 
            Header = "Aero Spear", 
            Text = "<b><font color=\"rgb(113, 138, 96)\">The Duke</font></b> flies into the air and shoots a singular decently sized Wind Lance at whoever he's provoked/aggroed on to."
        }, 
        {
            Image = nil, 
            Header = "Gale Stomp", 
            Text = "<b><font color=\"rgb(113, 138, 96)\">The Duke</font></b> stomps the ground, conjuring a wave of wind up from the ground towards his victim in his line of direction."
        }, 
        {
            Image = nil, 
            Header = "Detect", 
            Text = "<b><font color=\"rgb(113, 138, 96)\">The Duke</font></b> looks up kinda gayly and detects other people who are gay."
        }
    }, 
    Health = 15000, 
    Speed = 16, 
    SprintSpeed = 24, 
    StaminaLoss = 15, 
    StaminaGain = 50, 
    MaxStamina = 500000, 
    PunchDamage = 20, 
    StrongLeftDamage = 70, 
    StrongLeftForce = 95, 
    AeroSpearDamage = 35, 
    AeroSpearSpeed = 80, 
    Animations = {
        Idle = "rbxassetid://89172716352668", 
        Walk = "rbxassetid://106937004851916", 
        Run = "rbxassetid://104363080897072", 
        Stunned = {
            Start = "rbxassetid://77992249992180", 
            Loop = "rbxassetid://91405699153323", 
            End = "rbxassetid://128572975929032"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://88154852136376", 
            CameraRig = "rbxassetid://110023623090018"
        }, 
        Victory = {
            KillerRig = "rbxassetid://94672089154587", 
            CameraRig = "rbxassetid://91079835068264"
        }, 
        Execution = {
            KillerRig = "rbxassetid://115466116169950", 
            PlayerRig = "rbxassetid://82343317513950"
        }, 
        Punch1 = "rbxassetid://109480711438208", 
        Punch2 = "rbxassetid://140027957425484", 
        StrongLeft = "rbxassetid://107123867326564", 
        AeroSpear = "rbxassetid://104558370994392", 
        Stomp = "rbxassetid://123594293832051"
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://106029794447542", 
            "rbxassetid://96762479007469"
        }, 
        Ambience = "rbxassetid://14390644599", 
        Execution = "rbxassetid://79016487248667", 
        CorruptThrow = "rbxassetid://111033845010938", 
        PizzaDeliveryGuySpawned = "rbxassetid://119993322066460", 
        PizzaDeliveryPunchGround = "rbxassetid://73139934333155", 
        WalkspeedOverrideLunge = "rbxassetid://105200830849301", 
        WalkspeedOverrideHit = "rbxassetid://116806980881542", 
        WalkspeedOverrideTimeout = "rbxassetid://123577398651116", 
        WalkspeedOverrideCollide = "rbxassetid://131584836684993", 
        Hit = "rbxassetid://14865735867", 
        Swing = "rbxassetid://14865735071", 
        StrongLeftBuild = "rbxassetid://14863112691", 
        StompSound = "rbxassetid://14866083386", 
        Stomphit = "rbxassetid://14863241607", 
        StrongLeftHit = "rbxassetid://14863113512", 
        Introduction = "rbxassetid://14865830190"
    }
};