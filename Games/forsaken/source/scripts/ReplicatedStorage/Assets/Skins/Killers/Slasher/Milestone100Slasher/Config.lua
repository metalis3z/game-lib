-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Milestone IV", 
    Description = "Hatred burned any thoughts I had. I just wanted revenge.", 
    RenderImage = "rbxassetid://70998593303012", 
    Price = -4, 
    Exclusive = true, 
    Animations = {
        Execution = {
            KillerRig = "rbxassetid://119583872100961", 
            PlayerRig = "rbxassetid://119159046976628", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3.75)
        }
    }, 
    Sounds = {
        Execution = "rbxassetid://133920638799807", 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://89412889054970", 
                BPM = 150
            }, 
            [40] = {
                ID = "rbxassetid://110159320385013", 
                BPM = 150
            }, 
            [20] = {
                ID = "rbxassetid://88809604073112", 
                BPM = 150
            }, 
            [6] = {
                ID = "rbxassetid://72775647208451", 
                BPM = 150, 
                Chase = true
            }
        }
    }
};