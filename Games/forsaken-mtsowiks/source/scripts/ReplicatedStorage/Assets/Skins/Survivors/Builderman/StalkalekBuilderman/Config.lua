-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:12:04 2025 ]]
return {
    DisplayName = "Stalkalek", 
    Description = "Can't flee from her for much longer.", 
    RenderImage = "rbxassetid://115146611163944", 
    Price = 1100, 
    SentryTemplate = script.Sentry, 
    DispenserTemplate = script.Dispenser, 
    Animations = {
        ConstructStart = "rbxassetid://132109615344721", 
        ConstructLoop = "rbxassetid://125850405840820", 
        ConstructEnd = "rbxassetid://117794807222614"
    }, 
    DispenserAnimations = {
        Construction = "rbxassetid://116355384913565", 
        Idle = "rbxassetid://83462928376827"
    }, 
    Expressions = {
        Happy = "rbxassetid://113633464795030", 
        Concentrating = "rbxassetid://138477260882187", 
        Default = "rbxassetid://79765929651890", 
        Hurt = "rbxassetid://78758141300061", 
        Injured = "rbxassetid://132843468057375", 
        Dead = "rbxassetid://87455550865738", 
        Drinking = "rbxassetid://95006804567428"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Need it. I want it. I can't stop thinking about PIZZA!", 
                "Pizza delivery to a Stalkalek, please!", 
                "I'm hungry for some pizza!"
            }, 
            BuildermanSentry = {
                "Got a spare sentry? I won't mess it up!", 
                "We need more automated chaos!", 
                "Can we pleeease get a sentry here?", 
                "Requesting a turret for defensive purposes!", 
                "Go-Go sentry here, please!"
            }, 
            StalkalekBuildermanSentry = {
                "Oh hi me! Got a sentry?", 
                "Can we get a sentry? We know we want it!", 
                "Gimme a sentry my awesome self!", 
                "I'm humbly asking myself for a sentry (do it)!", 
                "Get me a sentry! Wait, is that me!?"
            }, 
            BuildermanDispenser = {
                "Be a hero and deploy a dispenser!", 
                "Would love to get a dispenser here!", 
                "Build a dispenser! I'm too close to being responsible for my survival.", 
                "Would love to get some ammo and snacks from a dispenser.", 
                "DISPENSEEEEEEEEER please :]"
            }, 
            StalkalekBuildermanDispenser = {
                "I'd ask Builderman for a dispenser, but its better if you do it, my other self!", 
                "Hello me! Could use a dispenser.", 
                "We both know we need ourselves a dispenser!", 
                "Place a dispenser, me! We need more MATERIALS."
            }, 
            DusekkarProtection = {
                "Grant me your spawn safety!", 
                "I'm gonna need some protection here!", 
                "I need a shield! I don't wanna die again!"
            }, 
            HemmorhageAsk = {
                "I\226\128\153m bleeding, I need help here!", 
                "Heal me please!", 
                "I need treatment! I'm bleeding alot here! :["
            }
        }, 
        Thanks = {
            Regular = {
                "And the name is Alek\226\128\166 Stalkalek.", 
                "Thanks for the help! :]", 
                "Very much appreciated!", 
                "I won\226\128\153t let you all down, trust me."
            }
        }
    }
};