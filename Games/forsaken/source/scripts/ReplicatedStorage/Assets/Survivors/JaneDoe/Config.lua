local v0 = {
    DisplayName = "Jane Doe", 
	Quote = "Every move is noted.. I remember everything.", 
	Credits = "By: Keve", 
	Class = "Support", 
	RenderImage = "rbxassetid://113809612532150",
	Price = 400;
	Speed = 12;
	Health = 100;
	WallCooldown = 30;
	WallConfig = {
		AbilityLength = 1.75;
		CatchKnockback = 8;
		CatchStuntime = 2;
		CatchCooldown = 10;
		CatchDamage = 10;
		CatchTime = 0.1;
		BuildLifetime = 30;
		BuildOffset = CFrame.new(0, 0, -5);
		BuildHealth = 35;
		BuildDelay = 0.9;
		BuildTime = 0.2;
		BreakDebuffs = {
			Blindness = {
				Duration = 3;
				Level = 2;
			};
		};
		RunBreakDebuffs = {
			Slowness = {
				Duration = 3;
				Level = 3;
			};
			Helpless = {
				Duration = 0.5;
				Level = 1;
			};
		};
	};
	BookCooldown = 50;
	BookConfig = {
		AbilityLength = 2.7;
		HealingPerc = 40;
		Radius = 15;
		FailedDebuffs = {"Slowness", "Weakness"};
		HealedBuffs = {"Speed"};
		StatusLevel = 1;
		StatusTime = 3;
	};
	ScanCooldown = 20;
	ScanLength = 1.5;
	ScanTime = 5;
    Expressions = {
		Happy = "rbxassetid://111330821955942";
		Default = "rbxassetid://126623332589306";
		Hurt = "rbxassetid://123225983333543";
		Injured = "rbxassetid://75751791695531";
		Dead = "rbxassetid://126623332589306";
    }, 
    Animations = {
		Trowel = "rbxassetid://86148078007660";
		Spell = "rbxassetid://79837372820853";
		Scan = "rbxassetid://87451401862521";
    }, 
    Sounds = {
		CatchHit = "rbxassetid://78490174393426";
		Trowel = "rbxassetid://104697310997625";
		WallFinished = "rbxasset://sounds//bass.wav";
		BuildWall = "rbxassetid://136008538347755";
		WallBreak = "rbxassetid://17806432822";
		Splat = "rbxassetid://12222152";
		ReadBook = "rbxassetid://115186539195392";
		Healed = "rbxassetid://86711695272635";
		Scan = "rbxassetid://129210331369644";
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Hey elliot, give me a pizza really quick!", 
                "Oi Oi some pizza needed here", 
                "Im low help me out!", 
                "Pepperoni on the pizza please!", 
                "Hey im really hungry right now"
            }, 
            BuildermanSentry = {
                "Build your turret here!", 
                "A turret of yours could be amazing here", 
                "Turret here, for sure", 
                "Put a turret here, it will slow down the killer!", 
                "This is a perfect spot for the turret"
            }, 
            BuildermanDispenser = {
                "Put here you healing machine, it will help others and me!", 
                "Does your dispenser heal? I need one right now!", 
                "Help me please!", 
                "This spot will be so hiden that not even the killer will notice", 
                "I need help right now, hurry im low!"
            }, 
            DusekkarProtection = {
                "Uhm could you use your magic staff to help me?", 
                "I need some help!", 
                "Spawn a shield, fast!", 
                "Defense here!", 
                "Use you magic stuff to help me please!"
            }
        }, 
        Thanks = {
            Regular = {
                "Thank you", 
                "I dont know how can i help you back!", 
                "Thanks you for saving me!", 
                "You need to be on the tv for helping me!", 
                "If you want i can take your back.", 
                "Thats what i was looking for!"
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "JANE DOE", 
		Text = "Once a beloved wife lost to darkness, her presence lingers like a memory too painful to erase. With her face obscured by shadows and her heart bound by fractured love, she wanders the chaos untouched by her husband's wrath. Carrying a messenger bag filled with remnants of the past, able to place walls. Heal others, and sadly her husband unable to see her face, unable to recognize her.\n"
    }, 
    {
        Header = "STATS", 
		Text = "Difficulty: ★★★☆☆\n" .. 
			("Health: %*\n"):format(v0.Health or 100) .. 
			("Regular Speed: %*\n"):format(v0.Speed or 12) .. 
			("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. 
			("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. 
			("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. 
			("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
};
return v0;