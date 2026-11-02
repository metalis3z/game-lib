-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:07 2025 ]]
return {
    DisplayName = "Milestone III", 
    RenderImage = "rbxassetid://108480698355238", 
    Description = "\"Tears ran down my face and I could barely recognize you.\"", 
    Price = -7, 
    Exclusive = true, 
    Animations = {
        Execution = {
            KillerRig = "rbxassetid://114599567681431", 
            PlayerRig = "rbxassetid://72281438743877", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 4)
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {	
				ID = "rbxassetid://102238085186321", 
                BPM = 100
            }, 
            [40] = {
				ID = "rbxassetid://128509938020806", 
                BPM = 100
            }, 
            [20] = {
				ID = "rbxassetid://140673869947540", 
                BPM = 100
            }, 
            [6] = {
				ID = "rbxassetid://82962982694490", 
                BPM = 100, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://90844069410171"
    }, 
    Spike = script.Spike
};