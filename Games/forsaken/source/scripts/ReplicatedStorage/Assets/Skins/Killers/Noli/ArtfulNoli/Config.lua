-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Artful", 
    Description = "For my next trick, i shall make the survivors of Forsaken VANISH!", 
    RenderImage = "rbxassetid://76333098590816", 
    Price = 2500, 
    Exclusive = false, 
    CollabInfo = "DieOfDeath", 
    NovaProjectile = script.Voidstar, 
    ObservantTeleportVFX = script.TeleportVFX, 
    ScreamerSpritesheet = "NoliArtful", 
    ObservantKillerProperties = {
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, 
        FillTransparency = 0.5, 
        FillColor = Color3.new(1, 1, 1), 
        OutlineColor = Color3.new(0.188235, 0.188235, 0.188235), 
        OutlineTransparency = 0.75
    }, 
    Animations = {
        Introduction = {
            KillerRig = "rbxassetid://98793383876757", 
            CameraRig = "rbxassetid://103967551441642"
        }
    }, 
    Sounds = {
        Introduction = {
            SoundId = "rbxassetid://72035546114122", 
            Volume = 2
        }, 
        VoidRushDashLoop = "rbxassetid://77374227659865", 
        VoidRushCutscene = "rbxassetid://70795888840923"
    }
};