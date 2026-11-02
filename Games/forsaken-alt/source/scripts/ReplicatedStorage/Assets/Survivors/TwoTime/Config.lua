-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Two Time", 
    Quote = "\"Shadows die twice.\"", 
    Credits = "", 
    Class = "Sentinel", 
    RenderImage = "rbxassetid://100794675544132", 
    Price = 500, 
    Exclusive = false, 
    Health = 80, 
    Speed = 12, 
    DaggerCooldown = 30, 
    DaggerDamage = 25, 
    DaggerBackstabDamage = 35, 
    DaggerLungeForce = 110, 
    DaggerUncrouchedLungeForce = 35, 
    DaggerBackstabThreshold = 90, 
    DaggerLookDirectionAngle = 70, 
    DaggerStatusTime = 2, 
    DaggerBackstabStatusTime = 4, 
    DaggerLifestealFromFront = 10, 
    DaggerLifestealFromBack = 20, 
    DaggerResLevel = 3, 
    DaggerResDuration = 0.7, 
    BloodReqIncreasePerTwoTime = 1, 
    CrouchCooldown = 50, 
    CrouchMinCooldown = 35, 
    CrouchSpeed = 9, 
    CrouchRunSpeed = 15, 
    CrouchInvisibilityLevel = 3, 
    CrouchUndetectableLevel = 1, 
    CrouchSpeedCloseTime = 1, 
    CrouchStabAmplifyTime = 5, 
    CrouchRevealTime = 2, 
    CrouchDistances = {
        CLOSE = {
            0, 
            15
        }, 
        DEBUFF_SLOWNESS = {
            75, 
            -1
        }, 
        DEBUFF_HIGHLIGHT = {
            125, 
            -1
        }
    }, 
    CrouchSlownessDebuffMax = 150, 
    Lives = 2, 
    BloodRequiredForRespawn = 8, 
    BloodFromFront = 3, 
    BloodFromBack = 4.5, 
    RespawnLocationDistance = 10, 
    NextLifeHealthDivisor = 2, 
    InvincibilityDuration = 2, 
    LastSurvivorMaxHealth = 110, 
    LastSurvivorHealthBonus = 50, 
    RespawnLocation = script.Spawn, 
    HealthBar = script.Sidebar, 
    AudioReplication = script.AudioReplication, 
    VFX = script.TwoTimeVFX, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    DaggerTemplate = script.GhostFire, 
    Animations = {
		CrouchStart = "rbxassetid://89757321152216", 
		CrouchIdle = "rbxassetid://131061831433270", 
		CrouchWalk = "rbxassetid://72435958976605", 
		CrouchRun = "rbxassetid://95747261336615", 
		Stab = "rbxassetid://77378516947022", 
		LungeStart = "rbxassetid://113371670549525", 
		LungeLoop = "rbxassetid://82125899996007", 
		LungeEnd = "rbxassetid://133661685694613", 
		Ritual = "rbxassetid://140338034497840"
    }, 
    Sounds = {
        Crouch = "rbxassetid://93315212708186", 
        Stand = "rbxassetid://112995614541035", 
        Mark = "rbxassetid://100981628806546", 
        Hit = "rbxassetid://96032371062643", 
        Stab = "rbxassetid://86710781315432", 
        CrouchStab = "rbxassetid://99820161736138", 
        Respawn = "rbxassetid://84260460113659"
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://81896815825257", 
            Default = "rbxassetid://73483634925418", 
            Hurt = "rbxassetid://93421870784694", 
            Injured = "rbxassetid://133089396665213", 
            Dead = "rbxassetid://133611309054814", 
            Drinking = "rbxassetid://99335439385081"
        }, 
        [2] = {
            Happy = "rbxassetid://79565455816327", 
            Default = "rbxassetid://131136664195288", 
            Hurt = "rbxassetid://120830873592415", 
            Injured = "rbxassetid://104452353265078", 
            Dead = "rbxassetid://123221349342396", 
            Drinking = "rbxassetid://127552301758353"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
v0.TextInteractions = {
    Requests = {
        ElliotPizza = {
            "Hey, hey. Pizza, pizza please.", 
            "Pizza\226\128\153s something I haven\226\128\153t tried much, mind if I get a slice?", 
            "I must ask for a pizza.", 
            "Do you have pizza? I could use one!", 
            "May I have a pizza slice?", 
            "I really want a pizza! May I have one?"
        }, 
        BuildermanSentry = {
            "Your turrets may be of use over here.", 
            "A sentry here should be put to use. Place it here.", 
            "Place your sentry over here. It will help against the foes.", 
            "Put down a sentry here.", 
            "Your sentry will be of use over here."
        }, 
        BuildermanDispenser = {
            "I\226\128\153m in need of a dispenser in my position.", 
            "I require a dispenser to be placed here.", 
            "Dispenser here, please.", 
            "Put down one of your dispensers here.", 
            "Your dispenser is needed here."
        }, 
        DusekkarProtection = {
            "Divine pumpkin, I humbly request your divine ability.", 
            "Divine pumpkin, I implore you to cast your ability onto me.", 
            "Divine pumpkin, I ask of thee to be blessed.", 
            "Divine pumpkin, blessed be thy heart should you cast a spell unto me.", 
            "Divine pumpkin, I ask for thy divine intervention."
        }
    }, 
    Thanks = {
        Regular = {
            "Much appreciated.", 
            "Very thankful for your service.", 
            "May good fortune come your way for your generosity.", 
            "The Spawn would be pleased with your acts of kindness.", 
            "I thank you for your service.", 
            "Oh give thanks to the Spawn, for he is good; for their steadfast love endures forever."
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "TWO TIME", 
        Text = "A fragile cultist that holds a terrible secret. Bearing nothing other than a sleek dagger and manic smile, they're able to earn a second life through risk and sacrifice.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "OBLATION", 
        Quote = "\"You both shall set out on the grand step to rebirth.\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("%* has a bar on the right side of the screen that, when filled, grants them a second life.\n"):format("Two Time") .. "The only way to fill this bar is by dealing damage to the Killer.\n" .. "In their second life, they only have <b>half</b> as much health (40) as they usually do (80).\n" .. "Upon activation:\n" .. " * Stamina is restored by 40%\n" .. " * All status effects are removed\n" .. (" * %* is made invincible for %* seconds \n"):format("Two Time", v0.InvincibilityDuration) .. " * <b>Speed II</b> is applied for 6 seconds\n" .. " * <b>Weakness V</b> is applied for 12 seconds\n"
    }, 
    {
        Header = "SACRIFICIAL DAGGER", 
        Quote = "\"Lookie, \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\128\148they gave us this cool knife!\" - Two Time", 
        Text = ("%* instantly stabs forward and gains Resistance %* for %* seconds.\n"):format("Two Time", v0.DaggerResLevel, v0.DaggerResDuration) .. ("Landing a stab to the front will do %* damage, and heal Two Time for %*.\n"):format(v0.DaggerDamage, v0.DaggerLifestealFromFront) .. ("Landing a stab to the back will instead do %* damage, stun the killer for %*, and heal Two Time for %*.\n"):format(v0.DaggerBackstabDamage, v0.DaggerBackstabStatusTime, v0.DaggerLifestealFromBack) .. "Using this ability while crouched lunges you forward with a quicker stab.\n"
    }, 
    {
        Header = "CROUCH", 
        Quote = "\"Quiet, Two Time! They're not supposed to see us in here, hehe!\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("%* crouches down to silence their footsteps & become stealthier.\n"):format("Two Time") .. ("%* remains crouched for at most %* seconds, but can uncrouch whenever they need to.\n"):format("Two Time", v0.CrouchCooldown - v0.CrouchMinCooldown) .. ("Crouching applies Undetectable I and Invisibility III for at most %* seconds. Uncrouching manually will forcibly remove these statuses.\n"):format(v0.CrouchCooldown - v0.CrouchMinCooldown)
    }, 
    {
        Header = "RITUAL", 
        Quote = "\"Spawn will be eternally pleased at our devotion!\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("%* places down a respawn location.\n"):format("Two Time") .. ("Dying with a full oblation bar will instantly teleport %* to this point.\n"):format("Two Time")
    }
};
return v0;