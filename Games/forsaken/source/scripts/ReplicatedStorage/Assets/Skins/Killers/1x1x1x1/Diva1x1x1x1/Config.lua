-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Diva", 
    Description = "All eyes on her...", 
    RenderImage = "rbxassetid://134481225474280", 
    Price = 3500, 
    Exclusive = false, 
    HighlightDisabled = false, 
    ZombieTemplate = script.Zombie, 
    ShockwaveTemplate = script.shockwave, 
    SwordsTemplate = script.Swords, 
    Relations = {
        "GhoulTwoTime", 
        "Shedletsky"
    }, 
    LastManStandingEmotionalData = {
        GhoulTwoTime = {
            ThemeID = "rbxassetid://130101085745481", 
            ThemeProperties = {
                Volume = 1.25
            }, 
            RoundTime = 74
        }, 
        Shedletsky = {
            ThemeID = "rbxassetid://115884097233860", 
            ThemeProperties = {
                Volume = 0.5
            }, 
            RoundTime = 91
        }
    }, 
    Sounds = {
        Introduction = "rbxassetid://131868412215042", 
        VictoryTheme = "rbxassetid://126586105253460", 
        TerrorRadiusThemes = {
            [80] = {
                ID = "rbxassetid://136173089500207", 
                BPM = 101.333
            }, 
            [40] = {
                ID = "rbxassetid://101818598457262", 
                BPM = 101.333
            }, 
            [20] = {
                ID = "rbxassetid://106555743720553", 
                BPM = 101.333
            }, 
            [6] = {
                ID = "rbxassetid://82465507839449", 
                BPM = 101.333, 
                Chase = true
            }
        }
    }, 
    Animations = {
        Introduction = {
            KillerRig = "rbxassetid://125300243730126", 
            RealRig = "rbxassetid://125300243730126", 
            CameraRig = "rbxassetid://125336956260279"
        }, 
        Victory = {
            KillerRig = "rbxassetid://105472802949959", 
            RealRig = "rbxassetid://105472802949959", 
            CameraRig = "rbxassetid://73447556973896", 
            GumiRig = "rbxassetid://73988886829123"
        }
    }
};