-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Timeless", 
    Description = "Commonly mistaken as 'Spirit'. He's not a fan.", 
    RenderImage = "rbxassetid://133348211508023", 
    Price = 1750, 
    ZombieTemplate = script.Zombie, 
    HighlightDisabled = true, 
    Animations = {
        Idle = "rbxassetid://121290259175445", 
        Walk = "rbxassetid://73232931166638", 
        Run = "rbxassetid://102965304565670", 
        Introduction = {
            KillerRig = "rbxassetid://124641198424213", 
            CameraRig = "rbxassetid://95711282008470"
        }, 
        Execution = {
            KillerRig = "rbxassetid://77751127741939", 
            PlayerRig = "rbxassetid://99553717087846"
        }, 
        Slash = "rbxassetid://99374613155606", 
        Entanglement = "rbxassetid://81935774508746", 
        UnstableEye = "rbxassetid://100461315307792", 
        RejuvenateTheRotten = "rbxassetid://86813370175207", 
        MassInfection = "rbxassetid://100592913030351", 
        Stunned = {
            Start = "rbxassetid://118119215058916", 
            Loop = "rbxassetid://119411831729452", 
            End = "rbxassetid://79552829394767"
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://76294591032484", 
                BPM = 143
            }, 
            [40] = {
                ID = "rbxassetid://130783295105613", 
                BPM = 143
            }, 
            [20] = {
                ID = "rbxassetid://132428643354111", 
                BPM = 143
            }, 
            [6] = {
                ID = "rbxassetid://92814243134036", 
                BPM = 143, 
                Chase = true
            }
        }, 
        EntanglementActivate = "rbxassetid://116792970438827", 
        UnstableEyeActivate = "rbxassetid://87284124610600", 
        UnstableEyeMode = "rbxassetid://134037097890097", 
        RejuvenateTheRottenActivate = "rbxassetid://134770542596997", 
        MassInfectionActivate = "rbxassetid://98004754767597", 
        Chains = "rbxassetid://73504812754586", 
        Execution = "rbxassetid://81088644266477", 
        ExecutionShedletsky = "rbxassetid://136239410827349", 
        Swing = "rbxassetid://85853080745515", 
        Hit = "rbxassetid://72380247081945", 
        Introduction = "rbxassetid://78268505965525", 
        VictoryTheme = "rbxassetid://89043663897133"
    }
};