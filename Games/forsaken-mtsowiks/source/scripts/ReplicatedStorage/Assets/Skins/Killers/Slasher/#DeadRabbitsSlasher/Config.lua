-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:18 2025 ]]
return {
    DisplayName = "Dead Rabbits", 
    Description = "test", 
    RenderImage = "rbxassetid://27258990", 
    Price = 2000, 
    Exclusive = true, 
    GashingWoundHitData = function() --[[ Line: 2 ]] --[[ Name: getHitData ]]
        return {
            [0.333] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [0.717] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [1.117] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [1.733] = {
                DamageDivisor = 10, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.233] = {
                DamageDivisor = 10, 
                Time = 0.15
            }, 
            [2.7] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }
        };
    end, 
    Relations = {
        "HeartbrokenShedletsky"
    }, 
    LastManStandingEmotionalData = {
        HeartbrokenShedletsky = {
            ThemeID = "rbxassetid://134062685653533", 
            ThemeProperties = {
                Volume = 1
            }, 
            RoundTime = 91
        }
    }, 
    Animations = {
        Idle = "rbxassetid://89986805957139", 
        EnragedStart = "rbxassetid://73070261531333", 
        Execution = {
            KillerRig = "rbxassetid://101992535367842", 
            PlayerRig = "rbxassetid://110689897056078"
        }, 
        Slash = "rbxassetid://111083572826870", 
        Behead = "rbxassetid://84100752959014", 
        GashingWoundStart = "rbxassetid://107741926280176", 
        GashingWound = {
            KillerRig = "rbxassetid://108534706030723", 
            PlayerRig = "rbxassetid://132970813209554"
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://120625074849463", 
                BPM = 120
            }, 
            [30] = {
                ID = "rbxassetid://100850412971228", 
                BPM = 120
            }, 
            [15] = {
                ID = "rbxassetid://93363907907660", 
                BPM = 120
            }, 
            [6] = {
                ID = "rbxassetid://113081858218471", 
                BPM = 120, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://127049173349221", 
        Hit = {
            "rbxassetid://132578824075256", 
            "rbxassetid://132025616295266"
        }, 
        Stunned = {
            Start = "rbxassetid://97356451336095"
        }, 
        GashingWoundHit = "rbxassetid://111225773242486"
    }, 
    Voicelines = {
        Kill = {
            "rbxassetid://108430844483382"
        }, 
        Idle = {
            "rbxassetid://114478740630753"
        }, 
        RagingPace = {
            "rbxassetid://104312229535272"
        }
    }
};