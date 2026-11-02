-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:59 2025 ]]
return {
    DisplayName = "YAAI", 
    Description = "\"You are an idiot!\"", 
    RenderImage = "rbxassetid://138157405597993", 
    Price = 2010, 
    Exclusive = false, 
    NovaProjectile = script.Voidstar, 
    IntroCrownOffset = CFrame.new(0, 0.75, 0) * CFrame.Angles(0, 3.141592653589793, 0), 
    isScreamerSensitive = true, 
    SensitiveScreamerImage = "rbxassetid://110444150393641", 
    ScreamerSpritesheet = "NoliIdiot", 
    ObservantTeleportVFX = script.TeleportVFX, 
    Sounds = {
        isSensitiveTerrorRadius = true, 
        TerrorRadiusThemes = {
            [80] = {
                ID = "rbxassetid://129585015374653", 
                BPM = 81
            }, 
            [40] = {
                ID = "rbxassetid://119407596822675", 
                BPM = 81
            }, 
            [20] = {
                ID = "rbxassetid://111934667387456", 
                BPM = 81
            }, 
            [6] = {
                ID = "rbxassetid://116122968535695", 
                BPM = 81, 
                Chase = true
            }
        }, 
        VoidRushCutscene = "rbxassetid://75640648249157", 
        Introduction = "rbxassetid://123402353096959", 
        Ambience = {
            SoundId = "rbxassetid://131858848260251", 
            Volume = 0.25
        }, 
        Swing = "rbxassetid://112395455254818", 
        Teleport = "rbxassetid://5066021887", 
        Nova = "rbxassetid://114573278513426", 
        Explosion = "rbxassetid://117938274970042", 
        VoidRushMissTimeout = "rbxassetid://96949588668580", 
        VoidRushMissCancelled = "rbxassetid://105484443350662", 
        VoidRushMissCrashed = "rbxassetid://96949588668580", 
        VoidRushMissStunned = "rbxassetid://96949588668580", 
        VoidRushMissNonChar = "rbxassetid://96949588668580", 
        VoidRushDashLoop = "rbxassetid://124580948668075", 
        ObservantTeleportChannel = "rbxassetid://128603561061140", 
        ObservantOn = "rbxassetid://129339516336471", 
        ObservantOff = "rbxassetid://132607121277576", 
        ObservantGeneratorStart = "rbxassetid://129339516336471", 
        ObservantGeneratorEnd = "rbxassetid://132607121277576", 
        ObservantGeneratorLoop = "rbxassetid://101835175933579", 
        ObservantGeneratorWarning = "rbxassetid://86459902696608"
    }, 
    ObservantKillerProperties = {
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, 
        FillTransparency = 0.5, 
        FillColor = Color3.new(1, 1, 1), 
        OutlineColor = Color3.new(0.188235, 0.188235, 0.188235), 
        OutlineTransparency = 0.75
    }, 
    Voicelines = {
        Kill = "rbxassetid://135387053105409", 
        Slam = "rbxassetid://100401616510667", 
        VoidRushStart = {
            Killers = {
                SoundId = "rbxassetid://88883605252476", 
                Volume = 0.25
            }, 
            Survivors = "rbxassetid://126318185932771"
        }, 
        Stunned = {
            Start = "rbxassetid://93508655701288", 
            End = "rbxassetid://125024182906315"
        }
    }, 
    Animations = {
        Introduction = {
            KillerRig = "rbxassetid://111325796300336", 
            CameraRig = "rbxassetid://116166543038409"
        }
    }
};