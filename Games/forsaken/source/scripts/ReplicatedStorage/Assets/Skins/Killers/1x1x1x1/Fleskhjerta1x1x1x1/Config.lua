-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Fleskhjerta", 
    Description = "\"I like this place, Seriously =)\"", 
    RenderImage = "rbxassetid://112714984590846", 
    Price = 1900, 
    IntroLighting = script.IntroLighting, 
    OutroLighting = script.OutroLighting, 
    SwordsTemplate = script.Swords, 
    ZombieTemplate = script.Zombie, 
    ShockwaveTemplate = script.Shockwave, 
    OutroVFXFolder = script.OutroVFX, 
    HighlightProperties = {
        FillColor = Color3.fromRGB(74, 74, 74), 
        OutlineColor = Color3.new(), 
        FillTransparency = 15, 
        OutlineTransparency = 0.95
    }, 
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
    }
};