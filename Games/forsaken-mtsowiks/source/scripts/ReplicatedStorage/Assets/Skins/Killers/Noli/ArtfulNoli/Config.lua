-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:57 2025 ]]
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
        Idle = "rbxassetid://135666466657447", 
        Walk = "rbxassetid://104700807550441", 
        Run = "rbxassetid://73194316367183", 
        InjuredIdle = "rbxassetid://135666466657447", 
        InjuredWalk = "rbxassetid://104700807550441", 
        InjuredRun = "rbxassetid://122925949411800", 
        Stab = "rbxassetid://86192323510918", 
        Victory = {
            KillerRig = "rbxassetid://98854181929115", 
            CameraRig = "rbxassetid://103284340633401"
        }, 
        VoidRush = {
            StartCharge = "rbxassetid://129388317883459", 
            LoopCharge = "rbxassetid://129752448707921", 
            CancelCharge = "rbxassetid://103671295267192", 
            StartDashInit = "rbxassetid://93211838986749", 
            LoopDashInit = "rbxassetid://106562454714161", 
            StartDashCombo = "rbxassetid://93211838986749", 
            LoopDashCombo = "rbxassetid://110909709425941", 
            EndDash = "rbxassetid://76469526830393", 
            EndDashCrashed = "rbxassetid://139605186924220", 
            EndDashNonChar = "rbxassetid://139605186924220", 
            WeakHit = "rbxassetid://79919823464699", 
            CutsceneKillerRig = "rbxassetid://95536737382573"
        }, 
        VoidRushVictimRig = "rbxassetid://139721773485708", 
        NovaThrow = "rbxassetid://105718720616405", 
        NovaDet = "rbxassetid://136243352500819", 
        ObservantStart = "rbxassetid://99267049416023", 
        ObservantLoop = "rbxassetid://74517626000740", 
        ObservantTeleport = "rbxassetid://84160779553727", 
        Hallucination = "rbxassetid://82248310193413", 
        Introduction = {
            KillerRig = "rbxassetid://83317955078292", 
            CameraRig = "rbxassetid://124511986143281"
        }, 
        Execution = {
            KillerRig = "rbxassetid://138076157532610", 
            PlayerRig = "rbxassetid://138524221822542", 
            PlayerCFrameOffset = CFrame.new(0, 0, -6)
        }, 
        Stunned = {
            Start = "rbxassetid://128705218649089", 
            Loop = "rbxassetid://88816313698907", 
            End = "rbxassetid://111869272145301"
        }
    }, 
    Relations = {
        "!_LoveshotChance", 
        "BlockGuest", 
        "CaretakerElliot", 
        "CloakTwoTime", 
        "TauntNoob", 
        "BananaTaph", 
        "HotdogShedletsky", 
        "RevolverChance", 
        "CarepadBuilderman"
    }, 
    LastManStandingEmotionalData = {
        ThemeID = "rbxassetid://95804479897896", 
        RoundTime = 75
    }, 
    Sounds = {
        Introduction = {
            SoundId = "rbxassetid://72035546114122", 
            Volume = 2
        }, 
        Ambience = "rbxassetid://89585407698140", 
        Footsteps = {
            "rbxassetid://94116180026878", 
            "rbxassetid://91288562212143"
        }, 
        Execution = "rbxassetid://110824682258297", 
        Swing = "rbxassetid://89004992452376", 
        Hit = "rbxassetid://118250546180773", 
        Nova = "rbxassetid://82322446333022", 
        NovaInject = "rbxassetid://114767134633867", 
        NovaDefused = "rbxassetid://9117341652", 
        NovaShatter = "rbxassetid://135436309", 
        Explosion = "rbxassetid://139097448014164", 
        VoidRushStart = {
            Killers = "rbxassetid://85260465177143", 
            Survivors = "rbxassetid://126318185932771"
        }, 
        VoidRushWeakHit1 = {
            Killers = "rbxassetid://121462448682270", 
            Survivors = "rbxassetid://81597761297703"
        }, 
        VoidRushWeakHit2 = {
            Killers = "rbxassetid://91140716185493", 
            Survivors = "rbxassetid://81597761297703"
        }, 
        VoidRushWeakHit3 = {
            Killers = "rbxassetid://113075396845016", 
            Survivors = "rbxassetid://81597761297703"
        }, 
        VoidRushWeakHit4 = {
            Killers = "rbxassetid://121133772410497", 
            Survivors = "rbxassetid://81597761297703"
        }, 
        VoidRushWeakHit5 = {
            Killers = "rbxassetid://92986329658358", 
            Survivors = "rbxassetid://81597761297703"
        }, 
        VoidRushMissCrashed = "rbxassetid://101387972373714", 
        VoidRushMissStunned = "rbxassetid://101387972373714", 
        VoidRushMissNonChar = "rbxassetid://101387972373714", 
        VoidRushDashLoop = "rbxassetid://140659146085461", 
        VoidRushCutscene = "rbxassetid://81597761297703", 
        Stunned = {
            Start = "rbxassetid://106228378876689"
        }, 
        Teleport = "rbxassetid://5066021887", 
        ObservantTeleportChannel = "rbxassetid://138357268062344", 
        ObservantOn = "rbxassetid://92571603693371", 
        ObservantOff = "rbxassetid://9125639499", 
        ObservantGeneratorStart = "rbxassetid://92571603693371", 
        ObservantGeneratorEnd = "rbxassetid://109995612165855", 
        ObservantGeneratorLoop = "rbxassetid://127642052151878", 
        ObservantGeneratorWarning = "rbxassetid://138357268062344", 
        TerrorRadiusThemes = {
            [80] = {
				ID = "rbxassetid://79156142388849", 
                BPM = 81
            }, 
            [40] = {
				ID = "rbxassetid://138843885286497", 
                BPM = 81
            }, 
            [20] = {
				ID = "rbxassetid://136991052518396", 
                BPM = 81
            }, 
            [6] = {
				ID = "rbxassetid://104602835070847", 
                BPM = 81, 
                Chase = true
            }
        }
    }, 
    Voicelines = {
        Kill = {
            ""
        }, 
        LastManStanding = {
            ""
        }, 
        VoidRushStart = {
            ""
        }, 
        Teleport = {
            ""
        }, 
        Nova = {
            ""
        }, 
        Slam = {
            ""
        }, 
        VoidRushMissTimeout = {
            ""
        }, 
        VoidRushMissCrashed = {
            ""
        }, 
        Stunned = {
            "rbxassetid://106228378876689"
        }, 
        Wheel_Yes = {
            ""
        }, 
        Wheel_No = {
            ""
        }, 
        Wheel_Taunt = {
            ""
        }, 
        Wheel_Rage = {
            ""
        }, 
        Wheel_Laugh = {
            ""
        }
    }
};