-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Two Time (OP)", 
    Quote = "\"I UNDERSTAND IT NOW\"", 
    Credits = "Evil Room And a bit Nextix", 
	Class = "Support", 
	RenderImage = "rbxassetid://14992773801", 
    Price = 1, 
    Exclusive = false, 
    Health = 999999, 
    Speed = 50, 
    DaggerCooldown = 0, 
    DaggerDamage = 500, 
    DaggerBackstabDamage = 650, 
    DaggerLungeForce = 9900, 
	DaggerUncrouchedLungeForce = 9900, 
    DaggerBackstabThreshold = 90, 
    DaggerLookDirectionAngle = 70, 
    DaggerStatusTime = 2, 
    DaggerBackstabStatusTime = 4, 
    DaggerLifestealFromFront = 10, 
    DaggerLifestealFromBack = 20, 
    DaggerResLevel = 3, 
    DaggerResDuration = 0.7, 
    BloodReqIncreasePerTwoTime = 1, 
    CrouchCooldown = 0, 
    CrouchMinCooldown = 0, 
    CrouchSpeed = 90, 
    CrouchRunSpeed = 100, 
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
        Header = "TWO TIME BUT OP ?", 
		Text = "A being beyond god himself, watching down upon all of the survivors, in hope of being able to strike, though, out of guilt, and overall restrictions from the universe, he protects the survivors with a dagger capable of shattering souls, in short, he's strong. By the way, there is gambling."
    }, 
};
return v0;