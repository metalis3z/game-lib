-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:11:09 2025 ]]
return {
    DisplayName = "Monster", 
    Description = "This dish just got deep!", 
    RenderImage = "rbxassetid://134121319934104", 
    Price = 800, 
    CollabInfo = "PizzaGame", 
    Exclusive = false, 
    Expressions = {
        Default = "rbxassetid://72729100620253", 
        Happy = "rbxassetid://72729100620253", 
        SlightlyHappy = "rbxassetid://72729100620253", 
        Hurt = "rbxassetid://97208676168062", 
        Injured = "rbxassetid://140477192972472", 
        Dead = "rbxassetid://123465740139161", 
        Drinking = "rbxassetid://88903612057442"
    }, 
    Animations = {
        Idle = "rbxassetid://135440139358392", 
        Walk = "rbxassetid://126794988901751", 
        Run = "rbxassetid://138681996115603", 
        InjuredIdle = "rbxassetid://111799105644862", 
        InjuredWalk = "rbxassetid://135694465375184", 
        InjuredRun = "rbxassetid://116204729581383", 
        ThrowPizza = "rbxassetid://88030183690072"
    }, 
    Sounds = {
        PizzaThrown = "rbxassetid://86984347644217"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Pizza please.", 
                "Out of pizza.", 
                "Need more souls... or pizza."
            }, 
            BuildermanSentry = {
                "Sentry.", 
                "Put a sentry here.", 
                "Gun turret, now."
            }, 
            BuildermanDispenser = {
                "Dispenser.", 
                "Need healing.", 
                "Can't revive, need a dispenser."
            }, 
            DusekkarProtection = {
                "Protect me.", 
                "...Drav?", 
                "Cover me."
            }
        }, 
        Thanks = {
            Regular = {
                "...", 
                "It's Pizza Time!", 
                "Won't waste it.", 
                "Thank you.", 
                "Bazinga!"
            }
        }
    }
};