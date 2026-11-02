-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:03 2025 ]]
return {
    DisplayName = "Bygone", 
    Description = "[Content Deleted]", 
    RenderImage = "rbxassetid://90765753397929", 
    Price = 9999999999, 
    Exclusive = true, 
    NovaProjectile = script.Voidstar, 
    ObservantTeleportVFX = script.TeleportVFX, 
    Animations = {
        Idle = "rbxassetid://140027301014571", 
        Walk = "rbxassetid://93024280965421", 
        Run = "rbxassetid://125412341721202", 
        InjuredIdle = "rbxassetid://140027301014571", 
        InjuredWalk = "rbxassetid://93024280965421", 
        InjuredRun = "rbxassetid://125412341721202", 
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
    Sounds = {
        Ambience = "rbxassetid://136108986388115", 
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Execution = "rbxassetid://79731623948632", 
        Swing = "rbxassetid://108610718831698", 
        Hit = "rbxassetid://120179334324041", 
        Nova = "rbxassetid://102521880760403", 
        NovaInject = "rbxassetid://114767134633867", 
        NovaDefused = "rbxassetid://9117341652", 
        NovaShatter = "rbxassetid://135436309", 
        Explosion = "rbxassetid://118556110699326", 
        VoidRushStart = {
            Killers = "rbxassetid://129321484816125", 
            Survivors = "rbxassetid://126318185932771"
        }, 
        VoidRushWindow = {
            Killers = "rbxassetid://77245770579014", 
            Survivors = "rbxassetid://117420477449885"
        }, 
        VoidRushWeakHit1 = {
            Killers = "rbxassetid://123051542178150", 
            Survivors = "rbxassetid://83452419401497"
        }, 
        VoidRushWeakHit2 = {
            Killers = "rbxassetid://70791051058969", 
            Survivors = "rbxassetid://124938251062884"
        }, 
        VoidRushWeakHit3 = {
            Killers = "rbxassetid://80956911752327", 
            Survivors = "rbxassetid://124938251062884"
        }, 
        VoidRushWeakHit4 = {
            Killers = "rbxassetid://96081637668009", 
            Survivors = "rbxassetid://124938251062884"
        }, 
        VoidRushWeakHit5 = {
            Killers = "rbxassetid://119071199261500", 
            Survivors = "rbxassetid://124938251062884"
        }, 
        VoidRushLoop = "rbxassetid://89315669689903", 
        VoidRushCancel = "rbxassetid://118831439312095", 
        VoidRushMissTimeout = "rbxassetid://118831439312095", 
        VoidRushMissCancelled = "rbxassetid://118831439312095", 
        VoidRushMissCrashed = "rbxassetid://127672659178959", 
        VoidRushMissStunned = "rbxassetid://127672659178959", 
        VoidRushMissNonChar = "rbxassetid://127672659178959", 
        VoidRushDash1 = "rbxassetid://90878551190839", 
        VoidRushDash2 = "rbxassetid://129533890149435", 
        VoidRushDashLoop = "rbxassetid://113037804008732", 
        VoidRushCutscene = "rbxassetid://103260933771149", 
        Teleport = "rbxassetid://5066021887", 
        ObservantTeleportChannel = "rbxassetid://129974844820427", 
        ObservantOn = "rbxassetid://82013344286371", 
        ObservantOff = "rbxassetid://9125639499", 
        ObservantGeneratorStart = "rbxassetid://78559441069645", 
        ObservantGeneratorEnd = "rbxassetid://93765277091414", 
        ObservantGeneratorLoop = "rbxassetid://86021977643606", 
        ObservantGeneratorWarning = "rbxassetid://125959692092693", 
        Introduction = "rbxassetid://114656341286864", 
        VictoryTheme = "rbxassetid://74165348818534", 
        Stunned = {
            Start = "rbxassetid://108421509080926", 
            End = "rbxassetid://113454045849271"
        }, 
        VoidstarEnable = "rbxassetid://106727013904874"
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
            ""
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