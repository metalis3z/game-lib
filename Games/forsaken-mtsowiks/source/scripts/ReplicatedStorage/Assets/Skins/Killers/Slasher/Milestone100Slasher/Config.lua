-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Milestone IV", 
    Description = "Hatred burned any thoughts I had. I just wanted revenge.", 
    RenderImage = "rbxassetid://70998593303012", 
    Price = -4, 
    Exclusive = true, 
    Animations = {
        Execution = {
            KillerRig = "rbxassetid://84564988323739", 
            PlayerRig = "rbxassetid://123378177231528", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3.75)
        }
    }, 
    Sounds = {
        Execution = "rbxassetid://133920638799807", 
        TerrorRadiusThemes = {
            [60] = {
				ID = "rbxassetid://114824840451427", 
                BPM = 150
            }, 
            [40] = {
				ID = "rbxassetid://122641121403648", 
                BPM = 150
            }, 
            [20] = {
				ID = "rbxassetid://105972300702506", 
                BPM = 150
            }, 
            [6] = {
				ID = "rbxassetid://105972300702506", 
                BPM = 150, 
                Chase = true
            }
        }
    }
};