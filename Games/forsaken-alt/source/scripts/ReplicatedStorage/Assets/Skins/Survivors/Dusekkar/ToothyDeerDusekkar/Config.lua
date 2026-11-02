-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Toothy Deer", 
    Description = "You're the boss now. -Admin Chicken Man\"", 
    RenderImage = "rbxassetid://107642645345237", 
    Price = 1500, 
    PlasmaBeamColor1 = Color3.fromRGB(255, 0, 0), 
    PlasmaBeamColor2 = Color3.fromRGB(255, 107, 107), 
    VFXTemplate = script.VFX, 
    SpawnProtectionRadiusTemplate = script.MouseRadius, 
    SpawnProtectionIndicatorTemplate = script.Indicator, 
    Expressions = {
        HitTarget = "rbxassetid://93310328307347", 
        Happy = "rbxassetid://122393118052382", 
        Default = "rbxassetid://79475050681266", 
        Hurt = "rbxassetid://139122859154127", 
        Injured = "rbxassetid://138264279802257", 
        Dead = "rbxassetid://115505172042473", 
        Drinking = "rbxassetid://70989146899619"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "I don\226\128\153t look like a toothy deer, do I, pizza boy?", 
                "Mmmm\226\128\166 pizza\226\128\166", 
                "Pizza!", 
                "I want some pizza\226\128\166"
            }, 
            BuildermanSentry = {
                "You\226\128\153re all such meanypants, I\226\128\153m just here to pester you about a sentry.", 
                "Not a toothy deer, by the way. Just get me a sentry.", 
                "Put a sentry here, it should be the best spot to place one.", 
                "Can\226\128\153t summon my lasers, so a sentry is the next best thing."
            }, 
            BuildermanDispenser = {
                "Machines vs Magic\226\128\166 think that\226\128\153d make for a good title?", 
                "Need some machine help here! Hurry!", 
                "Pestering you about a dispenser\226\128\166 pls\226\128\166", 
                "I really need some heals but I can\226\128\153t heal myself\226\128\166 it sucks\226\128\166"
            }, 
            DusekkarProtection = {
                "Woah, stranger danger dude. Just kidding, can I get a force field?", 
                "Fellow magic user! Got any magic for me?", 
                "Quick, magician! I need some of your magic!", 
                "Your lasers may not be as strong as mine, but your forcefield is really good!"
            }
        }, 
        Thanks = {
            Regular = {
                "Yeah, I\226\128\153m the Boss around Roblox.", 
                "Still don\226\128\153t want to make Sparta, thanks.", 
                "I don\226\128\153t look weird.", 
                "Maybe you\226\128\153re alright. Maybe.", 
                "Okay thanks, going back to hiding now."
            }
        }
    }
};