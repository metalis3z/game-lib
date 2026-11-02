-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:06 2025 ]]
return {
    DisplayName = "Milestone IV", 
    RenderImage = "rbxassetid://132525215767441", 
    Description = "\"A suit worn at funerals and celebrations.\"", 
    Price = -8, 
    Exclusive = true, 
    Animations = {
        Idle = "rbxassetid://132133335254718", 
        Run = "rbxassetid://134584204088288", 
        Walk = "rbxassetid://129376686701450", 
        InjuredIdle = "rbxassetid://127420004831859", 
        InjuredRun = "rbxassetid://134584204088288", 
        InjuredWalk = "rbxassetid://129376686701450", 
        CorruptEnergy = "rbxassetid://126473593500464", 
        DigitalFootprint = "rbxassetid://105090344788999", 
        Execution = {
            KillerRig = "rbxassetid://114599567681431", 
            PlayerRig = "rbxassetid://72281438743877", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 4)
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
				ID = "rbxassetid://90859077607703", 
                BPM = 100
            }, 
            [40] = {
				ID = "rbxassetid://105973247781430", 
                BPM = 100
            }, 
            [20] = {
				ID = "rbxassetid://138682227705312", 
                BPM = 100
            }, 
            [6] = {
				ID = "rbxassetid://83571234728572", 
                BPM = 100, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://90844069410171"
    }, 
    Spike = script.Spike
};