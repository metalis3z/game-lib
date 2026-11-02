-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:13 2025 ]]
return {
    DisplayName = "Philosopher", 
    Description = "There are more things in heaven and earth, Cogitatilux, than are dreamt of in your philosophy.", 
    RenderImage = "rbxassetid://74126031603824", 
    Price = 1500, 
    Exclusive = false, 
    CollabInfo = "Postmortem", 
    VFX = script.TwoTimeVFX, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    DaggerTemplate = script.GhostFire, 
    Animations = {
        Idle = "rbxassetid://80988220876235", 
        Walk = "rbxassetid://127738627741387", 
        Run = "rbxassetid://134862007911493", 
        InjuredIdle = "rbxassetid://130374146526766", 
        InjuredWalk = "rbxassetid://124203916026614", 
        InjuredRun = "rbxassetid://107090062533126", 
        CrouchStart = "rbxassetid://78991547936498", 
        CrouchIdle = "rbxassetid://122869556632255", 
        CrouchWalk = "rbxassetid://110806569718340", 
        CrouchRun = "rbxassetid://108579701694864", 
        Stab = "rbxassetid://106508682860516", 
        LungeStart = "rbxassetid://108690058268586", 
        LungeLoop = "rbxassetid://128858428286026", 
        LungeEnd = "rbxassetid://107353112052819", 
        Ritual = "rbxassetid://119132315296533"
    }, 
    Sounds = {
        Respawn = "rbxassetid://132924459951404", 
        Stab = "rbxassetid://83419374143723", 
        CrouchStab = "rbxassetid://81859713902429"
    }, 
    VoicelineVolume = 1.5, 
    Voicelines = {
        Died = {
            "rbxassetid://85991151219748"
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
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "My body requires sustenance before my mind can wander abroad.", 
                "Share me your discoveries.", 
                "Allow me to experiment your folk's gastronomy."
            }, 
            BuildermanSentry = {
                "We require a method to maintain that threat at a distance.", 
                "Weaponize your knowledge.", 
                "Knowledge is power."
            }, 
            BuildermanDispenser = {
                "Bless me with your fountain of health.", 
                "Display me your benevolence.", 
                "You shall grant us vigor."
            }, 
            DusekkarProtection = {
                "I insist for thy blessing.", 
                "Enlighten me.", 
                "One must first commit to helping their fellow individuals before they can reach true enlightenment.", 
                "Show me your thesis."
            }
        }, 
        Thanks = {
            Regular = {
                "Here's to knowledge!", 
                "Much obliged.", 
                "I stand in recognition."
            }
        }
    }
};