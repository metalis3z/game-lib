-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:14 2025 ]]
return {
    DisplayName = "White Pumpkin", 
    Description = "I will not rest until it's mine!", 
    RenderImage = "rbxassetid://126067149489844", 
    Price = 0, 
    Exclusive = true, 
    GashingWoundHitData = function() --[[ Line: 1 ]] --[[ Name: getHitData ]]
        return {
            [0.37] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.09] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.39] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.8] = {
                DamageDivisor = 5, 
                Time = 0.15
            }, 
            [3.12] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }
        };
    end, 
    GashingWoundCutsceneLength = 4.23, 
    GashingWoundCutsceneOffset = CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0), 
    IntroLighting = script.IntroLighting, 
    OutroLighting = script.OutroLighting, 
    Animations = {
        Idle = "rbxassetid://109016395842494", 
        Walk = "rbxassetid://118435516159047", 
        Run = "rbxassetid://81513142647413", 
        InjuredIdle = "rbxassetid://109016395842494", 
        InjuredWalk = "rbxassetid://118435516159047", 
        InjuredRun = "rbxassetid://81513142647413", 
        EnragedStart = "rbxassetid://101918385781728", 
        EnragedIdle = "rbxassetid://79846371850200", 
        EnragedWalk = "rbxassetid://107984909330026", 
        EnragedRun = "rbxassetid://107984909330026", 
        Execution = {
            KillerRig = "rbxassetid://99446258166404", 
            PlayerRig = "rbxassetid://82604627119677", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 0)
        }, 
        Victory = {
            KillerRig = "rbxassetid://106481263225168", 
            CameraRig = "rbxassetid://117180313190459"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://79994170963623", 
            CameraRig = "rbxassetid://118650101575685"
        }, 
        Slash = "rbxassetid://119934122398280", 
        Behead = "rbxassetid://81821837730086", 
        GashingWoundStart = "rbxassetid://72795609500928", 
        GashingWound = {
            KillerRig = "rbxassetid://129734468584291", 
            PlayerRig = "rbxassetid://100094225670646", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 0)
        }
    }, 
    Voicelines = {
        Stunned = {
            "rbxassetid://114835881998545", 
            "rbxassetid://92490871543046", 
            "rbxassetid://128437890138829", 
            "rbxassetid://138282317942986", 
            "rbxassetid://86689438645633", 
            "rbxassetid://75644041434837", 
            "rbxassetid://136099831012365"
        }, 
        RagingPace = {
            "rbxassetid://90806019841630", 
            "rbxassetid://98847325066568", 
            "rbxassetid://86062840312178", 
            "rbxassetid://120989722937739", 
            "rbxassetid://88698079468355", 
            "rbxassetid://77275147379023"
        }, 
        GashingWoundHit = {
            "rbxassetid://130585609456622", 
            "rbxassetid://115494986218546", 
            "rbxassetid://72829416154013", 
            "rbxassetid://131222654907069", 
            "rbxassetid://71875834274402"
        }, 
        Behead = {
            "rbxassetid://116320933974407", 
            "rbxassetid://114741188212484", 
            "rbxassetid://88827120840643", 
            "rbxassetid://74692612932318"
        }, 
        Kill = {
            "rbxassetid://116976774085083", 
            "rbxassetid://95817280332302", 
            "rbxassetid://72066232500755", 
            "rbxassetid://104448683532547", 
            "rbxassetid://124619601277107"
        }, 
        LastSurvivor = {
            "rbxassetid://74231855906542", 
            "rbxassetid://110951990631003", 
            "rbxassetid://88619619170967", 
            "rbxassetid://114851452986026", 
            "rbxassetid://88601091099706"
        }
    }, 
    Sounds = {
        Introduction = "rbxassetid://131385062047424", 
        VictoryTheme = {
            ID = "rbxassetid://133452756698616", 
            Properties = {
                Volume = 1, 
                Looped = false
            }
        }, 
        Execution = "rbxassetid://110286373493525", 
        GashingWoundSwing = "rbxassetid://110372418055226", 
        GashingWoundHit = "rbxassetid://111654237193989"
    }
};