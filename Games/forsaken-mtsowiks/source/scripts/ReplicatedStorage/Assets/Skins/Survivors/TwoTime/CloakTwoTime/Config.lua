-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:14 2025 ]]
return {
    DisplayName = "Cloak", 
    Description = "I hope I don't die and turn into a ghost!", 
    RenderImage = "rbxassetid://104092797501656", 
    Price = 1000, 
    CollabInfo = "DieOfDeath", 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://139719339704282", 
            Default = "rbxassetid://130771506470880", 
            Hurt = "rbxassetid://73731686138225", 
            Injured = "rbxassetid://100330100817533", 
            Dead = "rbxassetid://120148745136181", 
            Drinking = "rbxassetid://73950884525991"
        }, 
        [2] = {
            Happy = "rbxassetid://98951295563780", 
            Default = "rbxassetid://91906468485188", 
            Hurt = "rbxassetid://112918198189230", 
            Injured = "rbxassetid://128239090290210", 
            Dead = "rbxassetid://120148745136181", 
            Drinking = "rbxassetid://101904533565016"
        }
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Could you offer those delectables to me?", 
                "I\226\128\153m in need of some aid over here..", 
                "Please lend me some aid. I\226\128\153m gravely injured..", 
                "..I don\226\128\153t want to die.", 
                "..I don\226\128\153t want to die."
            }, 
            CaretakerElliotPizza = {
                "Quickly now, Caretaker! The vial!", 
                "Ah, Caretaker! Just the professional I\226\128\153ve been searching for..", 
                "I\226\128\153m in need of some of those health potions of yours..!", 
                "Lend me a helping hand, Caretaker!", 
                "Lend me a helping hand, Caretaker!"
            }, 
            BuildermanSentry = {
                "Hurry! Get those weapons built!", 
                "Those firearms of yours will be perfect against those monsters!", 
                "Let\226\128\153s just make this quick.. Don\226\128\153t want that virus to know we\226\128\153re here..", 
                "These weapons of yours, they\226\128\153re hack-proof, right?", 
                "These weapons of yours, they\226\128\153re hack-proof, right?"
            }, 
            CarepadBuildermanSentry = {
                "A-.. A firearm? I hadn\226\128\153t expected that from you..", 
                "You know how to make firearms? Intriguing..", 
                "Wait a moment.. You know how to build a weapon?", 
                "A weapon was the last thing I\226\128\153d expected from someone like you.. Not complaining, of course.", 
                "A-.. A firearm? I hadn\226\128\153t expected that from you.."
            }, 
            BuildermanDispenser = {
                "Quickly now.. The vial!", 
                "Many civilians are injured but potions are slim to none! Perhaps you can remedy this..?", 
                "Many civilians are injured but potions are slim to none! Perhaps you can remedy this..?", 
                "Hurry, hurry! There\226\128\153s many Civilians to tend to!", 
                "Quickly now, we\226\128\153ve not much time to waste! Get those potions!"
            }, 
            CarepadBuildermanDispenser = {
                "Hey wait, don\226\128\153t have a carepad..?", 
                "What\226\128\153s this? You\226\128\153re expanding your arsenal?", 
                "Do you perhaps still consider using a carepad?", 
                "A carepad is of utmost importance! What do you mean you don\226\128\153t have any??", 
                "Hey wait, don\226\128\153t have a carepad..?"
            }, 
            DusekkarProtection = {
                "For my next trick.. I ask for your magic!!", 
                "Magic please, magical civilian!", 
                "Hm.. do you know that awful magician?", 
                "Marvelous.. I simply must require your magic!", 
                "For my next trick.. I ask for your magic!!"
            }
        }, 
        Thanks = {
            Regular = {
                "Now you see me.. Eh, you know the rest.", 
                "The most sincere of thanks, my dear!", 
                "I bow to you, Civilian, as thank you.", 
                "You are but a kind Civilian, thank you.", 
                "Thank you, thank you! You are a kind soul."
            }
        }
    }
};