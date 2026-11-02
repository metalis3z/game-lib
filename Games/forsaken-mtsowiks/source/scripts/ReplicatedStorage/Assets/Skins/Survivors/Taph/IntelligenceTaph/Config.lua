-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:45 2025 ]]
return {
    DisplayName = "Intelligence", 
    Description = "\"If only you weren't broken.\"", 
    RenderImage = "rbxassetid://120932877367723", 
    Price = 1010, 
    Exclusive = false, 
    CollabInfo = "WorkspaceConstructs", 
    TripwireTemplate = script.TripwireHook, 
    TripwireCFrameOffset = CFrame.new(), 
    TripwireLookAt = true, 
    Expressions = {
        Default = "rbxassetid://76994682418999", 
        Happy = "rbxassetid://97396447590796", 
        Hurt = "rbxassetid://107573587846073", 
        Injured = "rbxassetid://98584962932244", 
        Dead = "rbxassetid://79986697215847", 
        Drinking = "rbxassetid://92840750932945"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Hello UserID NOT_FOUND, I request a pizza.", 
                "Here's my order", 
                "I heard the Cheese Pizzas are yummy here. I'll have that."
            }, 
            BuildermanSentry = {
                "GearID 68603151, \"All-Seeing Sentry\", can be used to help your teammates by slowing the Killer when they're in it's radius to allow for escape.", 
                "You are the reason many feel safe, build your sentry.", 
                "Hello UserID 156, I request a sentry.", 
                "Moderate for us like you have done for the world."
            }, 
            BuildermanDispenser = {
                "GearID 11419319, \"Healing Potion\", can be used to help your teammates by recovering lost HitPoints.", 
                "You are the reason many feel safe, build your dispenser.", 
                "Hello UserID 156, I request a dispenser.", 
                "Build us back up like you have done for the world."
            }, 
            DusekkarProtection = {
                "Give the ForceField to my grouped body so I may not be damaged.", 
                "local function giveForcefield()", 
                "Hello UserID 916, I request a forcefield.", 
                "Write the code like you have done for the world."
            }
        }, 
        Thanks = {
            Regular = {
                "..RequestFulfilledLine..", 
                "Thank you.", 
                "Chances of survival are heightened.", 
                "If only we weren't stuck in a loop."
            }
        }
    }, 
    Animations = {
        ThrowSubspace = "rbxassetid://102552909707153"
    }, 
    Sounds = {
        SubspaceToss = false, 
        SubspaceUse = "rbxassetid://122084978764506", 
        SubspaceHint = "rbxassetid://121239396484711", 
        SubspaceDetonate = "rbxassetid://116258618514945"
    }
};