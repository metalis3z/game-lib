local v0 = {
    DisplayName = "Jim", 
	Quote = "Jim's new computer just arrived!", 
    Credits = "By: ActuallyNotNhat & PorkRob", 
    Class = "Sentinel", 
	RenderImage = "rbxassetid://92719338598431", 
    Price = 450, 
	Exclusive = false,
    Health = 100, 
	Speed = 12,
	GunCooldown = 30,
	SuperBallCooldown = 45,
	FirstAidKit = 1,
	FirstAidKitCooldown = 999, 
	FirstAidKitHealDelay = 2.78, 
	FirstAidKitHealInitialAmount = 35, 
	FirstAidKitHealOvertimeAmount = 0, 
	FirstAidKitHealOvertimeDuration = 0, 
    Expressions = {
		Happy = "rbxassetid://144080495", 
		Default = "rbxassetid://87716232019856", 
		Hurt = "rbxassetid://93421870784694", 
		Injured = "rbxassetid://7918793", 
		Dead = "rbxassetid://87776840853341", 
    }, 
	Animations = {
		ShootGun = "rbxassetid://95548209429901",
		ThrowBall = "rbxassetid://124135424855827", 
		FirstAidKit = "rbxassetid://99034178437281",
		GiveUp = "rbxassetid://0" -- Scrapped
    }, 
	Sounds = {
		Shoot = "rbxassetid://4502821590",
		BulletHit = "rbxassetid://3092866899",
		SuperBall = "rbxassetid://12222124",
		BallHit = "rbxassetid://14671871879",
		Heal = "rbxassetid://0",
		HeavyBreathing = "rbxassetid://0" -- Scrapped
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = { 
                "I really could use some pizza...",
            }, 
            BuildermanSentry = {
                "Get the sentry going over here.",
            }, 
            BuildermanDispenser = {
                "Need a dispenser over here!", 
            }, 
            DusekkarProtection = {
                "Cast your force field!", 
            }
        }, 
        Thanks = {
            Regular = {
                "Thank you."
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "JIM", 
        Text = "A Horrified person, he wanted to escape it all, so he ended it, only to end up in another hell again.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
		Image = "rbxassetid://120384661730793", 
        Header = "SHOOT", 
        Quote = "\"Prepare.\"", 
        Text = ("Cooldown: %*s\n"):format(v0.GunCooldown) .. ("Jims pulls out a gun and quickly shoots, stunning the killer for a bit.\n")
    }, 
    {
		Image = "rbxassetid://138473319781900", 
        Header = "SUPER BALL", 
		Quote = "\"Super Happy Bouncy Fun Ball. For entertainment purposes only.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.SuperBallCooldown) .. ("Jim pulls out a Super Ball and throwns it in any direction he looks\n") .. ("If the Super Ball hits a killer it will inflict <b>Slowness II</b> for 2s.\n")
    }, 
    {
		Image = "rbxassetid://94768747549529", 
        Header = "FIRST AID KIT", 
		Quote = "\"Why aren't they just called aid kits? Or bandaid boxes?  Why the word first?\" - Roblox", 
        Text = ("Charges: %*s\n"):format(v0.FirstAidKit) .. ("Jim takes out a First Aid Kit and heals himself for 50 HP\n") .. "40% less speed.\n"
    }
};
return v0;