-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:03 2025 ]]
local v0 = {
    DisplayName = "Ghost", 
    Description = "\"Target nearby!\"", 
    RenderImage = "rbxassetid://91329905838185", 
    Price = 700, 
    Exclusive = true, 
    CollabInfo = "Isle", 
    VFX = script.TwoTimeVFX, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    DaggerTemplate = script.GhostFire, 
    Sounds = {
        Crouch = "rbxassetid://93315212708186", 
        Stand = "rbxassetid://112995614541035", 
        Mark = "rbxassetid://100981628806546", 
        Hit = "rbxassetid://135436314", 
        Stab = "rbxassetid://144352131", 
        CrouchStab = "rbxassetid://144352131", 
        Respawn = "rbxassetid://84260460113659"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "I\226\128\153m hit!", 
                "Target Elliot sp\226\128\148I mean I need a pizza!", 
                "I need a.. pizza?", 
                "Healing spra\226\128\148pizza needed here!"
            }, 
            BuildermanSentry = {
                "Deploy a sentry, now!", 
                "Sentry in position?", 
                "Sentry in place?", 
                "Sentry needed, proceed.", 
                "Place a sentry!"
            }, 
            BuildermanDispenser = {
                "Squad needs a dispenser.", 
                "Dispenser here!", 
                "Dispenser needed!", 
                "Set up a dispenser!", 
                "I\226\128\153m hit! I need a dispenser!"
            }, 
            OperatorBuildermanSentry = {
                "We\226\128\153re still a team, right? Even if we\226\128\153re stuck here and what I\226\128\153ve\226\128\148 I just need your help\226\128\166 please?"
            }, 
            OperatorBuildermanDispenser = {
                "Neither of us have time for questions, we just need to focus. Get that dispenser nearby whenever you're ready!"
            }, 
            DusekkarProtection = {
                "A magical ball? I need that!", 
                "Usually, going invisible works wonders. But that magic can help too!", 
                "Does your forcefield work like a shield pack?", 
                "I need a shield pa\226\128\148I mean, a forcefield! Do you copy?"
            }
        }, 
        Thanks = {
            Regular = {
                "Thank you so much!", 
                "B-Corp pays well, maybe you should apply?", 
                "Greatly appreciated!", 
                "Another mercenary wouldn\226\128\153t hurt. If you\226\128\153re interested?", 
                "Thanks!", 
                "Thanks a lot!"
            }
        }
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://99032539738754", 
            Default = "rbxassetid://123104451423331", 
            Hurt = "rbxassetid://80711265605264", 
            Injured = "rbxassetid://107209215540430", 
            Dead = "rbxassetid://137606928028304", 
            Drinking = "rbxassetid://134326058725954"
        }, 
        [2] = {
            Happy = "rbxassetid://99032539738754", 
            Default = "rbxassetid://124076971348826", 
            Hurt = "rbxassetid://70844561476541", 
            Injured = "rbxassetid://134327241273091", 
            Dead = "rbxassetid://74762201102614", 
            Drinking = "rbxassetid://129623625608297"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;