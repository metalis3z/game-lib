-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Kitty Cat", 
    Description = "Not really 9 lives but 2 lives is close enough", 
    RenderImage = "rbxassetid://89186734142021", 
    Price = 800, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    Sounds = {
        Respawn = "rbxassetid://108911618385640"
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://80082153649381", 
            Default = "rbxassetid://99015983806414", 
            Hurt = "rbxassetid://133931526768459", 
            Injured = "rbxassetid://120468210386596", 
            Dead = "rbxassetid://85538209590850", 
            Drinking = "rbxassetid://113869605386583"
        }, 
        [2] = {
            Happy = "rbxassetid://136691706979309", 
            Default = "rbxassetid://121287341229094", 
            Hurt = "rbxassetid://108675259845299", 
            Injured = "rbxassetid://107592295674875", 
            Dead = "rbxassetid://85538209590850", 
            Drinking = "rbxassetid://136383065503061"
        }
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Meow, meow! Pizza, pizza please! :3", 
                "Pizza\226\128\153s something I haven\226\128\153t tried much, mind if I get a slice? :3c", 
                "I must ask for a pizza, meow! :3", 
                "Do you have pizza? I could use one, meow! :3", 
                "May I have a pizza slice? :3c", 
                "I really want a pizza! May I have one, meow? :3c"
            }, 
            BuildermanSentry = {
                "Your turrets may be of use over here, mrow! :3", 
                "Mrow! A sentry here should be put to use! Place it here! :3", 
                "Place your sentry over here! It will help against the foes, mrow! :3", 
                "Put down a sentry here, meow! :3", 
                "Your sentry will be of use over here! :3"
            }, 
            DusekkarProtection = {
                "Divine pumpkin, I humbly request your divine ability! :3", 
                "Divine pumpkin, I implore you to cast your ability onto me, meow! :3", 
                "Divine pumpkin, I ask of thee to be blessed! Mrow! :3", 
                "Divine pumpkin, blessed be thy heart should you cast a spell unto me! :3", 
                "Divine pumpkin, I ask for thy divine intervention! Meow! :3"
            }
        }, 
        Thanks = {
            Regular = {
                "Much appreciated, mrow. :3", 
                "Very thankful for your service! :3", 
                "May good tuna come your way for your generosity, meow! :3", 
                "The Spawn would be pleased with your acts of kindness! :3", 
                "Kitty thanks you for your service! :3", 
                "Oh give thanks to the Spawn, for he is good; for their steadfast love endures forever! :3"
            }
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;