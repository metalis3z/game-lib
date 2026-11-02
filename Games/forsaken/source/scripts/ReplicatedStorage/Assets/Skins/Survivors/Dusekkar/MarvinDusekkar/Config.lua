-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Marvin", 
    Description = "\"I feel like a pilgrim heading towards the distant light, enlightenment I shall be the first to witness.\"", 
    RenderImage = "rbxassetid://133816084239117", 
    Price = 1000, 
    Exclusive = false, 
    CollabInfo = "Postmortem", 
    PlasmaBeamColor1 = Color3.fromRGB(255, 255, 255), 
    PlasmaBeamColor2 = Color3.fromRGB(255, 255, 255), 
    SpawnProtectionRadiusTemplate = script.MouseRadius, 
    Expressions = {
        Happy = "rbxassetid://76255960800785", 
        Default = "rbxassetid://118093244185407", 
        Hurt = "rbxassetid://103266682235794", 
        Injured = "rbxassetid://99402372019621", 
        Dead = "rbxassetid://125775679772812", 
        Drinking = "rbxassetid://97577808501701", 
        Concentrating = "rbxassetid://83884696691486"
    }, 
    Animations = {
        Idle = "rbxassetid://75499447342226", 
        Walk = "rbxassetid://97775550731124", 
        Run = "rbxassetid://115668656069134", 
        InjuredIdle = "rbxassetid://73553834181658", 
        InjuredWalk = "rbxassetid://95677139259011", 
        InjuredRun = "rbxassetid://83410051517329", 
        StaffShot = "rbxassetid://137116631332417", 
        StaffStartup = "rbxassetid://85285423433761", 
        StaffLoop = "rbxassetid://89989656139122"
    }, 
    VoicelineVolume = 1.5, 
    Voicelines = {
        Died = {
            "rbxassetid://123571562223011"
        }
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "My magic has a limit...", 
                "I apologize for my negligence, but I require your services.", 
                "Say, do you perhaps carry any healing potions?", 
                "I am in dire need of your kindness at this present moment..."
            }, 
            BuildermanSentry = {
                "We may be in need of some kind of long range assistance...", 
                "I do not think my spells will be enough, you need to place something down...", 
                "Try using the magic of building..."
            }, 
            BuildermanDispenser = {
                "I need one of your marvelous inventions.", 
                "I cannot regenerate myself, sadly...", 
                "Some health, please..."
            }, 
            DusekkarProtection = {
                "Am I worthy of witnessing one of your spells?", 
                "Please protect me... From a magician to another, right...?", 
                "Hey! Can you spare me some magic? Quick!"
            }, 
            MarvinDusekkarProtection = {
                "Mayhaps this is the effect of a cloning potion?", 
                "Is this reality, or is an illusion spell deceiving my eyes?", 
                "The resemblance is otherworldly."
            }
        }, 
        Thanks = {
            Regular = {
                "My gratitude is unimaginable!", 
                "I owe you a favor...", 
                "I can gift you a potion later, I hope...", 
                "50% discount on everything in my shop, as a sign of my gratitude..."
            }
        }
    }
};