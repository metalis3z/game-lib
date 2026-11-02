-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:47 2025 ]]
return {
    DisplayName = "Pursuer", 
    Description = "All of their prey shall be pursued too.", 
    RenderImage = "rbxassetid://133238058361890", 
    Price = 2500, 
    CollabInfo = "DieOfDeath", 
    GashingWoundHitData = function() --[[ Line: 2 ]] --[[ Name: getHitData ]]
        return {
            [0.33] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [0.6] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [1.1] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.15] = {
                DamageDivisor = 5, 
                Time = 0.15
            }, 
            [3.35] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }
        };
    end, 
    GashingWoundCutsceneLength = 5.25, 
    Animations = {
        Idle = "rbxassetid://114181480948485", 
        Walk = "rbxassetid://108487529358080", 
        Run = "rbxassetid://127896964186651", 
        Introduction = {
            KillerRig = "rbxassetid://139233855081805", 
            CameraRig = "rbxassetid://86647985844423", 
            MollyRig = "rbxassetid://134381049746921", 
            ElliotRig = "rbxassetid://133332860608505", 
            NoobRig = "rbxassetid://121976166145544"
        }, 
        Stunned = {
            Start = "rbxassetid://72996493920618", 
            Loop = "rbxassetid://97590900288566", 
            End = "rbxassetid://124318883755756"
        }, 
        EnragedStart = "rbxassetid://93174961583569", 
        EnragedIdle = "rbxassetid://132684691700450", 
        EnragedWalk = "rbxassetid://111665231062417", 
        EnragedRun = "rbxassetid://111665231062417", 
        Execution = {
            KillerRig = "rbxassetid://100878976805149", 
            PlayerRig = "rbxassetid://106430966526994"
        }, 
        Slash = "rbxassetid://74576508628779", 
        Behead = "rbxassetid://133165719504689", 
        GashingWoundStart = "rbxassetid://124391262566933", 
        GashingWound = {
            KillerRig = "rbxassetid://140479601793146", 
            PlayerRig = "rbxassetid://97728221134145"
        }
    }, 
    Relations = {
        "!_LoveshotChance", 
        "BlockGuest", 
        "CaretakerElliot", 
        "CloakTwoTime", 
        "TauntNoob", 
        "BananaTaph", 
        "HotdogShedletsky", 
        "RevolverChance", 
        "CarepadBuilderman"
    }, 
    LastManStandingEmotionalData = {
        ThemeID = "rbxassetid://95804479897896", 
        RoundTime = 75
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Stunned = "rbxassetid://115110356281126", 
        Introduction = "rbxassetid://118093513073163", 
        Swing = "rbxassetid://108907358619313", 
        Hit = "rbxassetid://88582935528044", 
        EnragedStart = "rbxassetid://139926313168788", 
        GashingWoundHit = "rbxassetid://110592910502331", 
        GashingWoundSwing = "rbxassetid://127793641088496", 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://87452114563440", 
                BPM = 178
            }, 
            [30] = {
                ID = "rbxassetid://109532520829464", 
                BPM = 178
            }, 
            [15] = {
                ID = "rbxassetid://85055674690742", 
                BPM = 178
            }, 
            [6] = {
                ID = "rbxassetid://137123073496980", 
                BPM = 178, 
                Volume = 1.25, 
                Chase = true, 
                LoopRegion = NumberRange.new(1.355, 55.281)
            }
        }
    }
};