-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Yorick", 
    Description = "\"Alas, poor Yorick!\"", 
    RenderImage = "rbxassetid://119192138200044", 
    Price = 1000, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "In kitchens I\226\128\153m born, from fiery hearts torn, round as the moon, yet on tables, I\226\128\153m sworn.", 
                "I vanish before eyes, no trace or ties; what am I that leaves without saying goodbye?", 
                "I start as a ball, then I\226\128\153m stretched with ease, a base for flavors that sure does please.", 
                "I flow underneath, a crimson tide, covering the base where toppings abide."
            }, 
            BuildermanSentry = {
                "I do not sleep; I do not stray\226\128\148protecting the gate, come what may.", 
                "Still as stone or quick as light, I keep the peace or start the fight.", 
                "I stand all night, I stand all day, watching threats from far away.", 
                "I have no bed, yet I never sleep. My watch is long, and my post is steep."
            }, 
            BuildermanDispenser = {
                "I have no hands, yet I give you what you need. I may not be human, but I help whenever you bleed.", 
                "I am built with a purpose: to help those who are hurt. I may fall quickly, but it is no curse.", 
                "I hum and glow; I\226\128\153m built to mend; your wounds and troubles I help to end.", 
                "Step right up; don\226\128\153t be shy; I\226\128\153ll heal you fast\226\128\148just stand nearby."
            }, 
            DusekkarProtection = {
                "A touchless wall that keeps you out; I stop attacks without a doubt.", 
                "No bricks, no glass, no wood in sight, and yet I can stop the fiercest fight.", 
                "I\226\128\153m not a wall, but I stop the attack, try to push through, and you\226\128\153ll bounce back.", 
                "Though I am not made of stone or brick, I stop attacks both fast and quick."
            }
        }, 
        Thanks = {
            Regular = {
                "You\226\128\153ve found your way here, but can you continue?", 
                "Will you find my precious? Only time will tell\226\128\166", 
                "Voiceless it cries, wingless flutters, toothless bites, mouthless mutters.", 
                "Beware\226\128\166 you have no time to relax, or do you\226\128\166?", 
                "Speak your answer aloud to continue\226\128\166"
            }
        }
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "", 
            Default = "", 
            Hurt = "", 
            Injured = "", 
            Dead = "", 
            Drinking = ""
        }, 
        [2] = {
            Happy = "", 
            Default = "", 
            Hurt = "", 
            Injured = "", 
            Dead = "", 
            Drinking = ""
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;