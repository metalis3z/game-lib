-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Milestone III", 
    Description = "Hatred drowned out any thoughts I had. I just wanted to rest.", 
    RenderImage = "rbxassetid://136197430178619", 
    Price = -3, 
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
				ID = "rbxassetid://120519310823654", 
                BPM = 150
            }, 
            [40] = {
				ID = "rbxassetid://134324141094552", 
                BPM = 150
            }, 
            [20] = {
				ID = "rbxassetid://114493586772422", 
                BPM = 150
            }, 
            [6] = {
				ID = "rbxassetid://73370013474226", 
                BPM = 150, 
                Chase = true
            }
        }
    }
};