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
        Idle = "rbxassetid://78878041363623", 
        Walk = "rbxassetid://96966016871562", 
        Run = "rbxassetid://97583854823689", 
        Introduction = {
            KillerRig = "rbxassetid://121367859804477", 
            CameraRig = "rbxassetid://100970181173982", 
            MollyRig = "rbxassetid://104939203929526", 
            ElliotRig = "rbxassetid://77292735389225", 
            NoobRig = "rbxassetid://82965392297738"
        }, 
        Stunned = {
            Start = "rbxassetid://90065885078909", 
            Loop = "rbxassetid://137300461712277", 
            End = "rbxassetid://105969486830195"
        }, 
        EnragedStart = "rbxassetid://83613067972248", 
        EnragedIdle = "rbxassetid://137656066258525", 
        EnragedWalk = "rbxassetid://101009837006007", 
        EnragedRun = "rbxassetid://101009837006007", 
        Execution = {
            KillerRig = "rbxassetid://95054064583142", 
            PlayerRig = "rbxassetid://100991197371161"
        }, 
        Slash = "rbxassetid://131316855258292", 
        Behead = "rbxassetid://80482655290898", 
        GashingWoundStart = "rbxassetid://123862049302883", 
        GashingWound = {
            KillerRig = "rbxassetid://100125526255677", 
            PlayerRig = "rbxassetid://106692319859014"
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
				ID = "rbxassetid://100275220605713", 
                BPM = 178
            }, 
            [30] = {
				ID = "rbxassetid://117162662405258", 
                BPM = 178
            }, 
            [15] = {
				ID = "rbxassetid://96326618861903", 
                BPM = 178
            }, 
            [6] = {
				ID = "rbxassetid://118363298224660", 
                BPM = 178, 
                Volume = 1.25, 
                Chase = true, 
                LoopRegion = NumberRange.new(1.355, 55.281)
            }
        }
    }
};