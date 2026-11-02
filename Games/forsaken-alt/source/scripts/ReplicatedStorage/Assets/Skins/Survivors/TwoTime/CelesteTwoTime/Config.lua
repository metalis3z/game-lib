-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Celeste", 
    Description = "Unfortunately, they can't double jump in this game", 
    RenderImage = "rbxassetid://74610290830544", 
    Price = 900, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://120568235225313", 
            Default = "rbxassetid://79073604240105", 
            Hurt = "rbxassetid://113988726797296", 
            Injured = "rbxassetid://99036692469994", 
            Dead = "rbxassetid://99036692469994", 
            Drinking = "rbxassetid://135278756020603"
        }, 
        [2] = {
            Happy = "rbxassetid://84699326432414", 
            Default = "rbxassetid://77638012825903", 
            Hurt = "rbxassetid://96557954216658", 
            Injured = "rbxassetid://74686613496399", 
            Dead = "rbxassetid://125755307480275", 
            Drinking = "rbxassetid://106994750046503"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
v0.TextInteractions = {
    Requests = {
        ElliotPizza = {
            "It\226\128\153s not my thing, but\226\128\166 a pizza does sound nice right about now.", 
            "Excuse me! Um.. could I maybe have a pizza?", 
            "Please help!", 
            "I\226\128\153m in pretty rough shape, could you lend a hand?", 
            "Not saying I\226\128\153m dying or anything\226\128\166 but a pizza could really save me right now."
        }, 
        BuildermanSentry = {
            "You can build sentries, right? I think one could work over here!", 
            "How about a sentry over here? You know, for safety..?", 
            "A sentry would be really great right now! I mean, no pressure\226\128\166", 
            "We really need a sentry\226\128\166 I don\226\128\153t want to spiral again\226\128\166", 
            "Can you drop a sentry? I\226\128\153d rather not have a repeat of last time..."
        }, 
        BuildermanDispenser = {
            "There\226\128\153s a lot on my mind right now, a dispenser could help\226\128\166", 
            "I think a dispenser could help us!"
        }
    }
};
return v0;