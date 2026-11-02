-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
            [2.983] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }
        };
    end, 
    GashingWoundCutsceneLength = 5.25, 
    Animations = {
        Idle = "rbxassetid://131367659019241", 
        Walk = "rbxassetid://115410294451828", 
        Run = "rbxassetid://138660433982140", 
        Introduction = {
            KillerRig = "rbxassetid://79415652331337", 
            CameraRig = "rbxassetid://110878008631585", 
            MollyRig = "rbxassetid://93618430487638", 
            ElliotRig = "rbxassetid://131268704293655", 
            NoobRig = "rbxassetid://72820452229919"
        }, 
        Stunned = {
            Start = "rbxassetid://140178620633381", 
            Loop = "rbxassetid://104031212227871", 
            End = "rbxassetid://138646989721956"
        }, 
        EnragedStart = "rbxassetid://94646688758704", 
        EnragedIdle = "rbxassetid://86852156029855", 
        EnragedWalk = "rbxassetid://116466156887792", 
        EnragedRun = "rbxassetid://116466156887792", 
        Execution = {
            KillerRig = "rbxassetid://98299540493640", 
            PlayerRig = "rbxassetid://124703837261442"
        }, 
        Slash = "rbxassetid://118681737442209", 
        Behead = "rbxassetid://131228727885075", 
        GashingWoundStart = "rbxassetid://71606819752295", 
        GashingWound = {
            KillerRig = "rbxassetid://75735474665572", 
            PlayerRig = "rbxassetid://109354869636017"
        }
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