-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:21 2025 ]]
return {
    DisplayName = "Block", 
    Description = "Defend those in need.", 
    RenderImage = "rbxassetid://93141011495688", 
    Price = 1000, 
    CollabInfo = "DieOfDeath", 
    Expressions = {
        Happy = "rbxassetid://139719339704282", 
        Default = "rbxassetid://130771506470880", 
        Hurt = "rbxassetid://73731686138225", 
        Injured = "rbxassetid://100330100817533", 
        Dead = "rbxassetid://120148745136181", 
        Drinking = "rbxassetid://73950884525991", 
        StunnedKiller = "rbxassetid://112363202904390"
    }, 
    Animations = {
        Block = "rbxassetid://116626317009011", 
        Charge = "rbxassetid://137924650761338"
    }, 
    Sounds = {
        BlockStart = "rbxassetid://9089408772", 
        BlockSuccess = "rbxassetid://18568553101", 
        PunchWindup = "rbxassetid://109931874166612"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Be kind, civilian, and offer sustenance.", 
                "I ask of thee to provide rations for the wounded.", 
                "Civilian, I require your aid during these trying times.", 
                "Surely you've the necessary healing aid, no?", 
                "I require urgent care, and quickly!"
            }, 
            CaretakerElliotPizza = {
                "Caretaker! I must ask for your assistance.", 
                "I\226\128\153m injured, Caretaker! I require your aid!", 
                "Caretaker! Your medicine, quickly!", 
                "Quickly, Caretaker! I need your help!", 
                "Caretaker! Your medicine, quickly!"
            }, 
            BuildermanSentry = {
                "Ready those defenses!", 
                "Get the defenses ready!", 
                "We've no time for frivolity, get to building!", 
                "Quickly now, we've not much time! Get those defenses ready!", 
                "Hurry! Those monsters could be here any minute!\""
            }, 
            CarepadBuildermanSentry = {
                "Hurry, Carepad! We\226\128\153ve not much time\226\128\166 construct the firearm.", 
                "I\226\128\153ve heard you\226\128\153ve learnt to construct offensive weaponry, may I see it?", 
                "I hadn\226\128\153t expected you\226\128\153d learn to construct a weapon.. I must see it.", 
                "A firearm..? Can\226\128\153t I say I expected such a building from someone such as yourself.", 
                "A firearm..? Can\226\128\153t I say I expected such a building from someone such as yourself."
            }, 
            BuildermanDispenser = {
                "Many of us are gravely injured, we need medical aid!", 
                "Medicinal aid is your specialty, is it not?", 
                "Get to work on the urgent care those civilians need!", 
                "Civilians are injured, we don't have much time!", 
                "You've the only thing here that can aid multiple ill at once, hurry!"
            }, 
            CarepadBuildermanDispenser = {
                "You still have those carepads on your person, do you not?", 
                "Quickly now, those carepads..!", 
                "Get those civilians those carepads, quickly!", 
                "Hurry now, we need those carepads..!", 
                "Hurry now, we need those carepads..!"
            }, 
            DusekkarProtection = {
                "Be ready with the magic, I may need it soon.", 
                "Best get the magic prepared, I've a plan.", 
                "That magic of yours is interesting.. I think I have a plan.", 
                "Mage, I require your magic for an idea.", 
                "You, mage! Your magic is needed for this idea to work."
            }
        }, 
        Thanks = {
            Regular = {
                "Great work! I thank you.", 
                "May your heart be blessed upon this day.", 
                "May you be rewarded indefinitely.", 
                "I thank you, from the utmost reaches of my heart.", 
                "Thank you, civilian. Stay safe out there."
            }
        }
    }
};