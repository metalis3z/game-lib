-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:11:38 2025 ]]
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
        Idle = "rbxassetid://87316192920787", 
        Walk = "rbxassetid://102477927272186", 
        Run = "rbxassetid://77569601690256", 
        InjuredIdle = "rbxassetid://121332621427818", 
        InjuredWalk = "rbxassetid://112719009202590", 
        InjuredRun = "rbxassetid://110067651272441", 
        StaffShot = "rbxassetid://102098977919772", 
        StaffStartup = "rbxassetid://121405630722955", 
        StaffLoop = "rbxassetid://128248061591431"
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