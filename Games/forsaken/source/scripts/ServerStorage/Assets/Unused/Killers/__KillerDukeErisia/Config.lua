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
        Idle = "rbxassetid://74404433176716", 
        Walk = "rbxassetid://97636860388043", 
        Run = "rbxassetid://116039965248055", 
        Stunned = {
            Start = "rbxassetid://113649447135241", 
            Loop = "rbxassetid://90118282644700", 
            End = "rbxassetid://87216037279558"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://84380767214401", 
            CameraRig = "rbxassetid://83676754731620"
        }, 
        Victory = {
            KillerRig = "rbxassetid://73929615941775", 
            CameraRig = "rbxassetid://121159096428519"
        }, 
        Execution = {
            KillerRig = "rbxassetid://104029805778424", 
            PlayerRig = "rbxassetid://86470739857452"
        }, 
        Punch1 = "rbxassetid://86603593108405", 
        Punch2 = "rbxassetid://118793200682980", 
        StrongLeft = "rbxassetid://87247851053780", 
        AeroSpear = "rbxassetid://103991310999151", 
        Stomp = "rbxassetid://88419890172488"
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