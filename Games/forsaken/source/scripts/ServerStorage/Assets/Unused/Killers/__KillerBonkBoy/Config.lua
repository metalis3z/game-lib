-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Bonk Boy", 
    Quote = "BONK!", 
    Credits = "Made By: kaiserdegurechaff", 
    RenderImage = "rbxassetid://17672180523", 
    Price = 9999999999, 
    Exclusive = true, 
    Health = 999, 
    Speed = 30, 
    SprintSpeed = 0, 
    StaminaLoss = 0, 
    StaminaGain = 0, 
    MaxStamina = 0, 
    SlashDamage = 20, 
    SlashCooldown = 0.4, 
    EnragedSlashDamage = 20, 
    EnragedSlashCooldown = 0.25, 
    EnragedSlashLungeForce = 65, 
    RagingPaceCooldown = 30, 
    EnragedSpeed = 60, 
    EnragedTime = 10000, 
    EnragedAuraLingerTime = 2, 
    EnragedStaminaCap = 0, 
    EnragedStaminaCapLerpTime = 6.5, 
    Animations = {
        Idle = "rbxassetid://136487778250206", 
        Walk = "rbxassetid://130236445997861", 
        Run = "rbxassetid://78978317128370", 
        EnragedStart = "rbxassetid://139543828121486", 
        EnragedIdle = "rbxassetid://81491166460028", 
        EnragedWalk = "rbxassetid://130218307721515", 
        EnragedRun = "rbxassetid://80357216335134", 
        Introduction = {
            KillerRig = "rbxassetid://103006875837587", 
            CameraRig = "rbxassetid://104600469896168"
        }, 
        Execution = {
            KillerRig = "rbxassetid://110825125761071", 
            PlayerRig = "rbxassetid://116744047460777"
        }, 
        Stunned = {
            Start = "rbxassetid://137465682866162", 
            Loop = "rbxassetid://127419253663019", 
            End = "rbxassetid://73921571282698"
        }, 
        Slash = "rbxassetid://96754451078678", 
        Behead = "rbxassetid://88546470212830", 
        GashingWoundStart = "rbxassetid://83777289492360", 
        GashingWound = {
            KillerRig = "rbxassetid://131858043616633", 
            PlayerRig = "rbxassetid://116648610642279"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://72457886454761", 
            "rbxassetid://98852761114513"
        }, 
        Ambience = "rbxassetid://140305527099547", 
        Execution = "rbxassetid://80903632607907", 
        Stunned = "rbxassetid://136281175461752", 
        Introduction = "rbxassetid://70658180298709", 
        Swing = "rbxassetid://112809109188560", 
        Hit = "rbxassetid://7129073354", 
        EnragedStart = "rbxassetid://112390922764994", 
        GashingWoundSwing = "rbxassetid://102228729296384", 
        GashingWoundMiss = "rbxassetid://84353899757208", 
        GashingWoundHit = "rbxassetid://127648610882555"
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "BONK BOY", 
        Text = "BONK!\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health) .. ("Regular Speed: %*\n"):format(v0.Speed) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed) .. ("Max Stamina: %*\n"):format(v0.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://96590285148227", 
        Header = "SLASH", 
        Quote = "\"Make them remember!\" - Mother", 
        Text = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v0.SlashCooldown, v0.EnragedSlashCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v0.SlashDamage, v0.EnragedSlashDamage) .. "<font color=\"rgb(200,150,20)\">Jason</font> does a basic slash with his machete.\n" .. "A lunge is added to this attack if it's used while <font color=\"rgb(200,150,20)\">Jason's</font> <font color=\"rgb(255,50,50)\">ENRAGED</font>.\n"
    }, 
    {
        Image = "rbxassetid://112952508748158", 
        Header = "RAGING PACE", 
        Quote = "\"Kill them!\" - Mother", 
        Text = ("Cooldown: %*s\n"):format(v0.RagingPaceCooldown) .. "<font color=\"rgb(200,150,20)\">Jason</font> becomes <font color=\"rgb(255,0,0)\">ENRAGED.</font>\n" .. ("On activation, <font color=\"rgb(200,150,20)\">Jason</font>'s speed becomes %* for %* seconds, and the aura of the nearest survivor is revealed to him. The aura remains revealed until his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state ends, in which it'll linger for an additional %*s.\n"):format(v0.EnragedSpeed, v0.EnragedTime, v0.EnragedAuraLingerTime) .. ("While in effect, <font color=\"rgb(200,150,20)\">Jason</font> becomes immune to stuns, has his sprinting disabled, and has his stamina slowly become capped at %* over the span of %*s. The cap is removed once he leaves his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state.\n"):format(v0.EnragedStaminaCap, v0.EnragedStaminaCapLerpTime)
    }
};
return v0;