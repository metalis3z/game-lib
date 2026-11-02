-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Noob: The World", 
    Quote = "\"Clock In.\"", 
    Credits = "", 
    Class = "Survivalist", 
    RenderImage = "rbxassetid://78235240844505", 
    Price = 0, 
    Health = 100, 
    Speed = 12, 
    Exclusive = true, 
    BloxyColaCooldown = 50, 
    BloxyColaSpeedTime = 10, 
    DrinkingColaSpeedMultiplier = 0.9, 
    BloxyColaAwardThreshold = 140, 
    SlateskinPotionCooldown = 55, 
    SlateskinEffectDuration = 6, 
    SlateskinSpeedDuration = 2, 
    SlateskinLevel = 2, 
    DrinkingSlateskinSpeedMultiplier = 0.6, 
    GhostburgerCooldown = 45, 
    GhostburgerUndetectableTime = 10, 
    GhostburgerInvisibilityTime = 10, 
    EatingSpeedMultiplier = 0.6, 
    TimestopCooldown = 30, 
    TimestopLength = 6, 
    Expressions = {
        Happy = "rbxassetid://71475106359341", 
        Default = "rbxassetid://112904982368692", 
        Hurt = "rbxassetid://101124864542865", 
        Injured = "rbxassetid://87716232019856", 
        Dead = "rbxassetid://86936166426860", 
        Drinking = "rbxassetid://109402953259825", 
        EatStart = "rbxassetid://77577482028526", 
        Eating = "rbxassetid://140728535975340"
    }, 
    Animations = {
        Drinking1 = "rbxassetid://79156626356062", 
        Drinking2 = "rbxassetid://112647710459110", 
        Eating = "rbxassetid://70870602081927", 
        Timestop = "rbxassetid://98149967564215"
    }, 
    Sounds = {
        GhostburgerEffect = "rbxassetid://89796139014135", 
        Timestop = "rbxassetid://5104670875", 
        TimestopWindup = "rbxassetid://129832203716366", 
        Resume = "rbxassetid://5687891658"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "N-Need pizza..!", 
                "I r-really could use some pizza...", 
                "P-Pizza..! Please!!", 
                "Need pizza! Quick!!", 
                "I-I need pizza..!"
            }, 
            BuildermanSentry = {
                "Get the sentry going over here..!", 
                "O-Over here! Sentry!", 
                "Sentry here..!", 
                "Place a sentry here..!", 
                "N-Need a sentry!"
            }, 
            BuildermanDispenser = {
                "G-Get the dispenser going over here..!", 
                "Dispenser! H-Here..!", 
                "Need a d-dispenser over here!", 
                "Dispenser here..!", 
                "Place the dispenser here! H-Hurry!!"
            }, 
            DusekkarProtection = {
                "P-Protect me with your force field..!", 
                "I need some magic..! P-Please..!", 
                "C-Cast your force field..!", 
                "N-need a defense..!", 
                "Cast your magical shield..!"
            }, 
            HemmorhageAsk = {
                "I-I'm bleeding! Please help!!", 
                "I'm really, really hurt, please help..!", 
                "Help! I'm bleeding..!", 
                "Hhh.. h-help me! I'm bleeding!", 
                "I need help..! I-I'm bleeding!"
            }
        }, 
        Thanks = {
            Regular = {
                "T-Thank you..", 
                "Thanks..", 
                "Phew.. t-thanks..", 
                "Thank you...", 
                "I-I dunno how I could repay you..", 
                "Thank you..!"
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "NOOB: THE WORLD", 
        Text = "\227\129\138\229\137\141\227\129\175\227\130\130\227\129\134\230\173\187\227\130\147\227\129\167\227\129\132\227\130\139"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://133994175153795", 
        Header = "BLOXY COLA", 
        Quote = "\"Warning: Bloxy Cola may be habit-forming.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.BloxyColaCooldown) .. ("Noob pulls out a Bloxy Cola and takes a sip of it to gain <b>Speed I</b> for %*s.\n"):format(v0.BloxyColaSpeedTime) .. "10% less speed & cannot sprint while drinking.\n" .. "Any pre-existing <b>Slowness</b> status is removed upon consumption.\n" .. "Drinking a Bloxy Cola item will put this move on cooldown and grant less Speed."
    }, 
    {
        Image = "rbxassetid://133354880475554", 
        Header = "SLATESKIN POTION", 
        Quote = "\"IM ROCK SOLID!!\" - Homeless Guy", 
        Text = ("Cooldown: %*s\n"):format(v0.SlateskinPotionCooldown) .. ("Noob pulls out a Slate-skin Potion and takes a sip of it to gain <b>Slateskin II</b> for %*s.\n"):format(v0.SlateskinEffectDuration) .. ("If the slateskin effect wears off naturally, Noob gains <b>Speed II</b> for %*s.\n"):format(v0.SlateskinSpeedDuration) .. "Noob can also instead activate the ability again to cancel its effects early, gaining <b>Speed I</b> for the same duration.\n" .. "40% less speed & cannot sprint while drinking.\n"
    }, 
    {
        Image = "rbxassetid://112547374697556", 
        Header = "GHOSTBURGER", 
        Quote = "\"What happens if you eat a ghost? You'll find out.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.GhostburgerCooldown) .. ("Noob takes a bite of a Ghostburger and gains <b>Undetectable I</b> for %*s and <b>Invisibility IV</b> for %*s.\n"):format(v0.GhostburgerUndetectableTime, v0.GhostburgerInvisibilityTime) .. "40% less speed & cannot sprint while eating.\n"
    }, 
    {
        Image = "rbxassetid://112547374697556", 
        Header = "TIMESTOP", 
        Quote = "At first stab, it appears to be an ordinary dagger.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v0.TimestopCooldown) .. "Noob freezes everyone for 6 seconds.\n" .. "Nobody but them can move or use abilities for the duration.\n"
    }
};
return v0;