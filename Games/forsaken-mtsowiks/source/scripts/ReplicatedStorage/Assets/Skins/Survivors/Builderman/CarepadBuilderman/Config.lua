-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:12:01 2025 ]]
return {
    DisplayName = "Carepad", 
    Description = "Now updated with sentry support!", 
    RenderImage = "rbxassetid://108388026642050", 
    Price = 850, 
    CollabInfo = "DieOfDeath", 
    Exclusive = false, 
    SentryTemplate = script.Sentry, 
    DispenserTemplate = script.Dispenser, 
    Expressions = {
        Happy = "rbxassetid://139719339704282", 
        Default = "rbxassetid://130771506470880", 
        Hurt = "rbxassetid://73731686138225", 
        Injured = "rbxassetid://100330100817533", 
        Dead = "rbxassetid://120148745136181", 
        Drinking = "rbxassetid://73950884525991", 
        Concentrating = "rbxassetid://82036670050409"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Ah! Civilian, I need help!", 
                "Civilian, I need some help!", 
                "Over here, Civilian! It\226\128\153s an emergency!", 
                "I need some food, Civilian! Emergency!", 
                "I need some food, Civilian! Emergency!"
            }, 
            CaretakerElliotPizza = {
                "Ah, Caretaker! I need some medicine!", 
                "Caretaker, help me!", 
                "Help me, Caretaker! It\226\128\153s important!", 
                "Quickly, Caretaker! I need aid!", 
                "Quickly, Caretaker! I need aid!"
            }, 
            BuildermanSentry = {
                "Civilian, we need your machinery, stat!", 
                "Civilian! Your machinery is needed over here!", 
                "Hurry, Civilian! Build those defenses!", 
                "Get to building those defenses, Civilian!", 
                "Get to building those defenses, Civilian!"
            }, 
            CarepadBuildermanSentry = {
                "Uh\226\128\166", 
                "Why do you look exactly like me?", 
                "Huh. I suppose my type of attire is common these days.", 
                "Hello\226\128\166 Citizen..?", 
                "Hello\226\128\166 Citizen..?"
            }, 
            BuildermanDispenser = {
                "I\226\128\153m not sure if you\226\128\153ve noticed, but there are injured strewn about, Civilian!", 
                "Civilian! Get those health machines prepared!", 
                "Gotta get those dispensers prepared, Civilian!", 
                "Get to work on those machines, Civilian! Many of us are injured!", 
                "Get to work on those machines, Civilian! Many of us are injured!"
            }, 
            CarepadBuildermanDispenser = {
                "Um..", 
                "I\226\128\153ve got to look for more original attire at some point..", 
                "Are we one in the same..?", 
                "Goodness.. You look just like me.", 
                "Goodness.. You look just like me."
            }, 
            DusekkarProtection = {
                "When did you practice magic? I could use some.", 
                "Quickly now, a bit of magic!", 
                "I must ask for your magic.", 
                "Your forcefield would have been useful against some of those\226\128\166 things.", 
                "You\226\128\153re so much better than that awful performer."
            }
        }, 
        Thanks = {
            Regular = {
                "Thank you, Civilian!", 
                "I better get going, thank you, Civilian!", 
                "I won\226\128\153t forget this, Civilian! Trust me!", 
                "Thanks, Civilian!", 
                "Thank you very much, Civilian! Let\226\128\153s get going."
            }
        }
    }
};