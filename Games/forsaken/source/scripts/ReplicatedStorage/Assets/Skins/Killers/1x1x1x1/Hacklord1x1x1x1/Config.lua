-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Hacklord", 
    Description = "Thus approaches the final chapter of this tale.", 
    RenderImage = "rbxassetid://91171756002206", 
    Price = -1, 
    Exclusive = true, 
    HighlightProperties = {
        FillColor = Color3.fromRGB(113, 94, 255), 
        OutlineColor = Color3.fromRGB(2, 59, 10), 
        FillTransparency = 1.5, 
        OutlineTransparency = -10
    }, 
    IntroLighting = script.IntroLighting, 
    ShockwaveTemplate = script.shockwave, 
    IntroHeadTemplate = script.ShedletskyHead, 
    SwordsTemplate = script.Swords, 
    ZombieTemplate = script.Zombie, 
    PopupsFolder = script.Popups, 
    HighlightDisabled = true, 
    Animations = {
        Idle = "rbxassetid://81133507062849", 
        Walk = "rbxassetid://101095354379140", 
        Run = "rbxassetid://110726676708588", 
        InjuredIdle = "rbxassetid://81133507062849", 
        InjuredWalk = "rbxassetid://101095354379140", 
        InjuredRun = "rbxassetid://110726676708588", 
        Introduction = {
            KillerRig = "rbxassetid://80223013269411", 
            CameraRig = "rbxassetid://128947077578905"
        }, 
        Execution = {
            KillerRig = "rbxassetid://116930392030953", 
            PlayerRig = "rbxassetid://116782184543079", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5)
        }, 
        ExecutionShedletsky = {
            KillerRig = "rbxassetid://113963765161296", 
            PlayerRig = "rbxassetid://116328537191004", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5)
        }, 
        Slash = "rbxassetid://119569200169708", 
        Entanglement = "rbxassetid://118352872384653", 
        UnstableEye = "rbxassetid://71254560791294", 
        RejuvenateTheRotten = "rbxassetid://101500569551963", 
        MassInfection = "rbxassetid://98336356417909"
    }, 
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
    Sounds = {
        Footsteps = {
            "rbxassetid://86946421252636", 
            "rbxassetid://109338938491835"
        }, 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://74721298574668", 
                BPM = 150
            }, 
            [40] = {
                ID = "rbxassetid://86408957402821", 
                BPM = 150
            }, 
            [20] = {
                ID = "rbxassetid://114490785251869", 
                BPM = 150
            }, 
            [6] = {
                ID = "rbxassetid://139170638058239", 
                BPM = 150, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://107844494806365", 
        ExecutionShedletsky = "rbxassetid://133758815058484", 
        Stunned = "rbxassetid://102398799721605", 
        EntanglementActivate = "rbxassetid://130247421279831", 
        UnstableEyeActivate = "rbxassetid://116607543967887", 
        UnstableEyeMode = "rbxassetid://134037097890097", 
        RejuvenateTheRottenActivate = "rbxassetid://96908026446030", 
        MassInfectionActivate = "rbxassetid://79291895885110", 
        Introduction = "rbxassetid://79630377899438", 
        Swing = "rbxassetid://119942598489800", 
        Hit = {
            "rbxassetid://105491491801026", 
            "rbxassetid://74491072589342"
        }
    }
};