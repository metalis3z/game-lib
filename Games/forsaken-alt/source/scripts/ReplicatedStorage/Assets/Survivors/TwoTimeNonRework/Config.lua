-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Two Time", 
    Quote = "\"Shadows die twice.\"", 
    Credits = "", 
    Class = "Survivalist", 
    RenderImage = "rbxassetid://75010378731203", 
    Price = 400, 
    Health = 80, 
    Speed = 12, 
    Lives = 2, 
    NextLifeHealthDivisor = 2, 
    InvincibilityDuration = 2, 
    LastSurvivorMaxHealth = 110, 
    LastSurvivorHealthBonus = 50, 
    LifeChangedFX = script.RespawnVFX, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    DaggerTemplate = script.GhostFire, 
    Animations = {}, 
    Sounds = {
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
        Text = "A fragile cultist holding a horrible secret. When mortally wounded, they resurrect themselves with wings and tails, and recover as if nothing had happened.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\134\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "UNDYING DEVOTION", 
        Quote = "\"what have you done..?\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("Upon receiving fatal damage, %*'s appearance changes & they're reborn into a second life!\n"):format("Two Time") .. "In their second life, they only have <b>half</b> as much health (40) as they usually do (80).\n" .. "Upon activation:\n" .. " * Stamina is restored by 40%\n" .. " * All status effects are removed\n" .. (" * %* is made invincible for %* seconds \n"):format("Two Time", v0.InvincibilityDuration) .. " * <b>Speed II</b> is applied for 6 seconds\n" .. " * <b>Weakness V</b> is applied for 12 seconds\n" .. ("Becoming the last survivor alive forces %* to enter into their second life, but they are given %* max HP, +%* HP healed, and do not suffer from <b>Weakness V</b>\n"):format("Two Time", v0.LastSurvivorMaxHealth, v0.LastSurvivorHealthBonus)
    }
};
return v0;