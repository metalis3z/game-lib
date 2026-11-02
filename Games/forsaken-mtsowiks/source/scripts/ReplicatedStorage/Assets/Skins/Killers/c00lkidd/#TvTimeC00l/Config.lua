-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:38 2025 ]]
return {
    DisplayName = "TV TIME", 
    Description = "Coming straight from your house!", 
    RenderImage = "rbxassetid://83638570637522", 
    Price = 9999999, 
    Exclusive = true, 
    NoProjectileJitter = true, 
    NoProjectileResize = true, 
    PizzaDeliveryRig = script.PizzaDeliveryRig, 
    Projectile = script.Projectile, 
    IntroLighting = script.IntroLighting, 
    OutroLighting = script.OutroLighting, 
    c00lguiTemplate = script.c00lgui, 
    PizzaDeliveryAnimations = {
        Summoned = "rbxassetid://125139531550919", 
        Idle = "rbxassetid://90263582165268", 
        Run = "rbxassetid://94316428632816", 
        Walk = "rbxassetid://94316428632816", 
        Hit = "rbxassetid://133879420283846"
    }, 
    LastManStandingData = {
        ThemeID = "rbxassetid://95455387850059", 
        ThemeProperties = {
            Volume = 0.75
        }, 
        RoundTime = 74
    }, 
    Animations = {
        Idle = "rbxassetid://91799955430083", 
        Walk = "rbxassetid://115284082166996", 
        Run = "rbxassetid://115284082166996", 
        InjuredIdle = "rbxassetid://91799955430083", 
        InjuredWalk = "rbxassetid://115284082166996", 
        InjuredRun = "rbxassetid://115284082166996", 
        Execution = {
            KillerRig = "rbxassetid://81086562573347", 
            PlayerRig = "rbxassetid://98617608753150"
        }, 
        Stunned = {
            Start = "rbxassetid://135642675382143", 
            Loop = "rbxassetid://79882068671113", 
            End = "rbxassetid://95879766009940"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://129786024151404"
        }, 
        Victory = {
            KillerRig = "rbxassetid://136692655719506", 
            KillerRigLoop = "rbxassetid://136692655719506"
        }, 
        Execution007n7 = false, 
        WalkspeedOverrideStart = "rbxassetid://103341196442825", 
        WalkspeedOverrideLoop = "rbxassetid://110610918697654", 
        WalkspeedOverrideHit = "rbxassetid://135750312140542", 
        WalkspeedOverrideMiss = "rbxassetid://135750312140542", 
        Attack = "rbxassetid://119583284360714", 
        CorruptNature = "rbxassetid://133879420283846", 
        SummonPizzaDelivery = "rbxassetid://96248884656114"
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://95455387850059", 
                BPM = 140
            }, 
            [40] = {
                ID = "rbxassetid://95455387850059", 
                BPM = 140
            }, 
            [20] = {
                ID = "rbxassetid://95455387850059", 
                BPM = 140
            }, 
            [6] = {
                ID = "rbxassetid://95455387850059", 
                BPM = 140, 
                Chase = true
            }
        }, 
        Footsteps = {
            "rbxassetid://130436277916156", 
            "rbxassetid://133109342591438"
        }, 
        Execution = "rbxassetid://90057908236903", 
        Introduction = "rbxassetid://81019153203807", 
        CorruptThrow = "rbxassetid://96968897550969", 
        CorruptAmbience = "rbxassetid://101232891446544", 
        CorruptHit = "rbxassetid://91230789399953", 
        WalkspeedOverrideLunge = "rbxassetid://4953447383", 
        WalkspeedOverrideHit = "rbxassetid://8447388510", 
        WalkspeedOverrideCollide = "rbxassetid://79391273191671", 
        WalkspeedOverrideTimeout = "rbxassetid://107593207834624", 
        PizzaDeliveryGuySpawned = "rbxassetid://128700743805872", 
        PizzaDeliveryPunchGround = {
            {
                SoundId = "rbxassetid://78064799059846", 
                Volume = 2.5
            }
        }, 
        SwordUnsheath = "rbxassetid://79391273191671", 
        VictoryTheme = {
            ID = "rbxassetid://123785352574997", 
            Properties = {
                Volume = 1.5, 
                Looped = false
            }
        }, 
        Hit = "rbxassetid://91230789399953", 
        Swing = "rbxassetid://79391273191671"
    }, 
    VoicelineVolume = 0.8, 
    Voicelines = {
        KillNoob = false, 
        KillElliot = false, 
        KillGuest1337 = false, 
        Kill007n7 = false, 
        KillChange = false, 
        LastSurvivorEmotional = false, 
        Idle = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        Introduction = {
            {
                SoundId = "rbxassetid://98530734009625", 
                Volume = 2.5
            }
        }, 
        Victory = false, 
        LastSurvivor = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        CorruptNature = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        PizzaDelivery = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        PizzaDeliveryHit = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        WalkspeedOverride = {
            "rbxassetid://80840335076210", 
            "rbxassetid://80840335076210", 
            "rbxassetid://80840335076210", 
            "rbxassetid://80840335076210", 
            "rbxassetid://80840335076210", 
            "rbxassetid://103256925970549"
        }, 
        WalkspeedOverrideHit = {
            "rbxassetid://103256925970549"
        }, 
        WalkspeedOverrideCollide = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        WalkspeedOverrideTimeout = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }, 
        Kill = {
            "rbxassetid://117236105724823", 
            "rbxassetid://103256925970549", 
            "rbxassetid://80840335076210", 
            "rbxassetid://132502162488199", 
            "rbxassetid://81868023121589", 
            "rbxassetid://104032928975176"
        }, 
        Stunned = {
            "rbxassetid://93187346777650", 
            "rbxassetid://98035287592527", 
            "rbxassetid://117236105724823"
        }
    }
};