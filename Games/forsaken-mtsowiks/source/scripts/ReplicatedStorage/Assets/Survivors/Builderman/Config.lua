-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Builderman", 
    Quote = "\"Welcome to ROBLOX!\"", 
    Credits = "", 
    Class = "Support", 
    RenderImage = "rbxassetid://84427509230526", 
    Price = 500, 
    Requests = {
        BuildermanSentry = {
            AbilityName = "Sentry", 
            RequestTitle = "Request Sentry", 
            NotificationTitle = "PLAYERNAME wants a sentry built!", 
            Order = 1
        }, 
        BuildermanDispenser = {
            AbilityName = "Dispenser", 
            RequestTitle = "Request Dispenser", 
            NotificationTitle = "PLAYERNAME wants a dispenser built!", 
            Order = 2
        }
    }, 
    Health = 90, 
    Speed = 12, 
    SentryCooldown = 45, 
    SentryConstructionDuration = 6, 
    SentryPositionOffset = 4, 
    SentryPlacementRadius = 125, 
    SentryDamageRadius = 65, 
    SentryLimit = 1, 
    SentryPingDistance = 999, 
    SentryPingDuration = 999, 
    SentryHealth = 30, 
    SentrySlownessLevel = 2, 
    SentrySlownessDuration = 1, 
    SentryDamagePerSec = 3, 
    SentryRangeReductionPercentage = 16, 
    SentryMinimumRange = 8, 
    SentryTemplate = script.Sentry, 
    SentryAnimations = {
        Construction = "rbxassetid://109348379844511", 
        Idle = "rbxassetid://111799064148031", 
        Shoot = "rbxassetid://85046108167791"
    }, 
    DispenserCooldown = 45, 
    DispenserConstructionDuration = 6, 
    DispenserPositionOffset = 4, 
    DispenserPlacementRadius = 60, 
    DispenserHealingRadius = 16, 
    DispenserLimit = 1, 
    DispenserPingDistance = 999, 
    DispenserPingDuration = 999, 
    DispenserHealth = 15, 
    DispenserHealingPerSec = 1, 
    DispenserHealingReductionPercentage = 8, 
    DispenserMinimumHealing = 0.3, 
    DispenserTemplate = script.Dispenser, 
    DispenserAnimations = {
        Construction = "rbxassetid://75247799572271", 
        Idle = "rbxassetid://93996041475140"
    }, 
    WarningTemplate = script.Warning, 
    HatFixCooldown = 40, 
    HatFixBuffDelay = 1.5, 
    HatFixRange = 45, 
    Expressions = {
        Happy = "rbxassetid://130754645470907", 
        Default = "rbxassetid://139225455829885", 
        Hurt = "rbxassetid://86174714158513", 
        Injured = "rbxassetid://128394931942436", 
        Dead = "rbxassetid://135418077255514", 
        Drinking = "rbxassetid://105142250700664", 
        Concentrating = "rbxassetid://71690383944824"
    }, 
    Animations = {
        ConstructStart = "rbxassetid://94333158334507", 
        ConstructLoop = "rbxassetid://114989194204251", 
        ConstructEnd = "rbxassetid://127640530690901", 
        HatFix = "rbxassetid://83920583576053"
    }, 
    Sounds = {
        SentryBuilding = "rbxassetid://113539652713151", 
        SentryIdle = "rbxassetid://1796850373", 
        SentryDestroyed = "rbxassetid://7593713585", 
        SentryTargeted = "rbxassetid://6783209805", 
        SentryShoot = "rbxassetid://5238024665", 
        DispenserBuilding = "rbxassetid://113539652713151", 
        DispenserIdle = "rbxassetid://9117729244", 
        DispenserDestroyed = "rbxassetid://495135507"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Looking for a slice of pizza over here.", 
                "Could I ask for a slice of pizza?", 
                "Hey, pass a slice.", 
                "You don\226\128\153t happen to have pizza on you, do you?", 
                "A pizza would work great on me right now.. mind if I get one?"
            }, 
            BuildermanSentry = {
                "Place your sentry here.", 
                "Put down a sentry over here.", 
                "Over here\226\128\153s a good spot for a sentry.", 
                "Build your sentry here. It\226\128\153s good ground.", 
                "Put your sentry over here."
            }, 
            BuildermanBuildermanSentry = {
                "I know imitation is the best form of flattery, but uh-\226\128\166 whatever, put down a sentry here.", 
                "Impersonatin\226\128\153 an admin is a bannable offense. If you build a sentry I might change my mind.", 
                "It\226\128\153s like lookin\226\128\153 into an uncanny mirror-\226\128\166 ahem, uh.. Put a sentry here, will you?", 
                "Build the sentry here. If you're truly me then you'd know it's a good spot.", 
                "This spot over here could be good for a sentry. You know that, yeah?"
            }, 
            BuildermanDispenser = {
                "Here\226\128\153s a good spot for a dispenser.", 
                "Good spot for a dispenser here.", 
                "Put your dispenser down over here.", 
                "The spot over here could be good for a dispenser.", 
                "Dispenser could be great if it were put down here."
            }, 
            BuildermanBuildermanDispenser = {
                "Let\226\128\153s hope your dispenser building skills are as good as your imitation.", 
                "If you\226\128\153re really me, then you ought to know that this spot\226\128\153s good for a dispenser.", 
                "This spot\226\128\153s pretty good for a dispenser. Don\226\128\153t you think, me?", 
                "Put down a dispenser if you\226\128\153re really who you say you are.", 
                "You ought to know how to build a dispenser here if you\226\128\153re really the person you\226\128\153re imitating."
            }, 
            DusekkarProtection = {
                "Need a bit of your magic, Dusekkar!", 
                "Need a bit of magic from you, pumpkin.", 
                "A force field would do good on me, if that\226\128\153s alright.", 
                "Cast some of your magic, pumpkin!", 
                "Your magic I could really use right about now, Dusekkar."
            }, 
            HemmorhageAsk = {
                "Not feeling too good.. can feel myself draining.. I'm gonna need some help.", 
                "Lend me a hand for a bit, I'm hurting real' bad...", 
                "I'm.. not in a good state here, and I'm gonna need some of your help.", 
                "Trying real hard to keep going, but I might need your help for it.", 
                "Gonna need some of your help, I don't think I'll last long in this state..."
            }
        }, 
        Thanks = {
            Regular = {
                "Thanks.", 
                "Thank you.", 
                "Your work is appreciated.", 
                "Thank you.", 
                "Now that's some good work."
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "BUILDERMAN", 
        Text = "The big boss of Roblox HQ himself. With a hammer in his inventory and a lot of spare parts and materials to spare, he's able to build contraptions that can either slow the killer's path, or heal those around him. As a promise with Shedletsky, he'll do all he can to help everyone.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://104441527277654", 
        Header = "SENTRY CONSTRUCTION", 
        Quote = "\"These sentries see your enemies so you don't have to!\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.SentryCooldown) .. ("Sentry Health: %*\n"):format(v0.SentryHealth) .. ("Builderman takes %*s to construct a <b>Sentry</b> infront of him, which targets nearby killers and inflicts <b>Slowness II</b> for %*s onto them.\n"):format(v0.SentryConstructionDuration, v0.SentrySlownessDuration) .. "If Builderman is attacked while performing this ability, any <b>Sentry</b> that's currently in production by them will be destroyed and the ability will be cancelled.\n" .. ("Builderman is only able to construct %* <b>Sentry</b> at a time.\n"):format(v0.SentryLimit) .. ("<b>Sentries</b> have a target range of %* studs which decreases by %*%% for every additional <b>Sentry</b> that's placed in the world.\n"):format(v0.SentryDamageRadius / 2, v0.SentryRangeReductionPercentage) .. ("<b>Sentries</b> will always have a target range of at least %* studs no matter what the current target range reduction is.\n"):format(v0.SentryMinimumRange) .. ("Other kinds of constructions cannot be built within %* studs of any <b>Sentry</b> in the world.\n"):format(v0.SentryPlacementRadius / 2) .. "Using this ability while having constructed the max amount of <b>Sentries</b> automatically destroys the first <b>Sentry</b> you placed.\n"
    }, 
    {
        Image = "rbxassetid://102952736333903", 
        Header = "DISPENSER CONSTRUCTION", 
        Quote = "\"This is pretty much the best healing potion in any video game ever.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.DispenserCooldown) .. ("Dispenser Health: %*\n"):format(v0.DispenserHealth) .. ("Builderman takes %*s to construct a <b>Dispenser</b> infront of him, which heals all teammates within %* studs by %* HP/s.\n"):format(v0.DispenserConstructionDuration, v0.DispenserHealingRadius, v0.DispenserHealingPerSec) .. "If Builderman is attacked while performing this ability, any <b>Dispenser</b> that's currently in production by them will be destroyed and the ability will be cancelled.\n" .. ("Builderman is only able to construct %* <b>Dispenser</b> at a time.\n"):format(v0.DispenserLimit) .. ("<b>Dispensers</b> have their healing reduced by %*%% for every additional <b>Dispenser</b> that's placed in the world.\n"):format(v0.DispenserHealingReductionPercentage) .. ("<b>Dispensers</b> will always be able to heal at least %* HP/s no matter what the current healing reduction is.\n"):format(v0.DispenserMinimumHealing) .. ("Other kinds of constructions cannot be built within %* studs of any <b>Dispenser</b> in the world.\n"):format(v0.DispenserPlacementRadius / 2) .. "Using this ability while having constructed the max amount of <b>Dispensers</b> automatically destroys the first <b>Dispenser</b> you placed.\n"
    }
};
return v0;