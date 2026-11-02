-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:06 2025 ]]
return {
    DisplayName = "The Admin", 
    Description = "Losers are supposed to lose.", 
    RenderImage = "rbxassetid://99261252211737", 
    Price = -1, 
    Exclusive = true, 
    VoidRushCutsceneOffset = CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0), 
    ScreamerSpritesheet = "NoliRomeo", 
    Videos = {
        Intro = "rbxassetid://137856260308774", 
        Outro = "rbxassetid://92785561086106"
    }, 
    ObservantWarningTemplate = script.GeneratorWarning, 
    ObservantIncomingTemplate = script.GeneratorIncoming, 
    IntroLighting = script.IntroLighting, 
    OutroLighting = script.OutroLighting, 
    ObservantTeleportVFX = script.TeleportVFX, 
    Animations = {
        Idle = "rbxassetid://83376700060511", 
        Walk = "rbxassetid://83687957716441", 
        Run = "rbxassetid://117344330579665", 
        InjuredIdle = "rbxassetid://83376700060511", 
        InjuredWalk = "rbxassetid://83687957716441", 
        InjuredRun = "rbxassetid://117344330579665", 
        Stab = "rbxassetid://126952912407795", 
        Victory = {
            KillerRig = "rbxassetid://109393698327413", 
            CameraRig = "rbxassetid://110549791620624"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://122186497240724", 
            CameraRig = "rbxassetid://118676084847854"
        }, 
        VoidRush = {
            StartCharge = "rbxassetid://138519561613599", 
            LoopCharge = "rbxassetid://91881131525614", 
            CancelCharge = "rbxassetid://138519561613599", 
            StartDashInit = "rbxassetid://135342084420278", 
            LoopDashInit = "rbxassetid://120101534501143", 
            StartDashCombo = "rbxassetid://135342084420278", 
            LoopDashCombo = "rbxassetid://120101534501143", 
            EndDash = "rbxassetid://107177585536285", 
            EndDashCrashed = "rbxassetid://99329354264266", 
            EndDashNonChar = "rbxassetid://99329354264266", 
            WeakHit = "rbxassetid://122146389266124", 
            CutsceneKillerRig = "rbxassetid://75065679512811"
        }, 
        VoidRushVictimRig = "rbxassetid://137090237993615", 
        NovaThrow = "rbxassetid://92898188129849", 
        NovaDet = "rbxassetid://138519561613599", 
        ObservantStart = "rbxassetid://82279883351207", 
        ObservantLoop = "rbxassetid://125215761661091", 
        ObservantTeleport = "rbxassetid://91287751085232", 
        Hallucination = "rbxassetid://91287751085232", 
        Execution = {
            KillerRig = "rbxassetid://108503381949696", 
            PlayerRig = "rbxassetid://74329309329139", 
            PlayerCFrameOffset = CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0)
        }, 
        Stunned = {
            Start = "rbxassetid://139198625313137", 
            Loop = "rbxassetid://88808537500617", 
            End = "rbxassetid://128035640622540"
        }
    }, 
    Sounds = {
        HallucinationScreamer = {
            "rbxassetid://72569825294424", 
            "rbxassetid://72569825294424", 
            "rbxassetid://72569825294424"
        }, 
        HallucinationCloneDeath = "rbxassetid://72569825294424", 
        HallucinationDispenserDeath = "rbxassetid://72569825294424", 
        Ambience = "rbxassetid://124800669703146", 
        Footsteps = {
            "rbxassetid://83185818968555", 
            "rbxassetid://71972168260699"
        }, 
        Execution = "rbxassetid://130689661251152", 
        Swing = "rbxassetid://131406927389838", 
        Hit = "rbxassetid://136406635725343", 
        Nova = "rbxassetid://134685885315276", 
        NovaInject = "rbxassetid://134685885315276", 
        NovaDefused = "rbxassetid://134685885315276", 
        NovaShatter = "rbxassetid://135436309", 
        Explosion = "rbxassetid://122413970010838", 
        VoidRushStart = {
            Killers = "rbxassetid://72569487786799", 
            Survivors = "rbxassetid://72569487786799"
        }, 
        VoidRushWindow = {
            Killers = "rbxassetid://77245770579014", 
            Survivors = "rbxassetid://117420477449885"
        }, 
        VoidRushWeakHit1 = {
            Killers = "rbxassetid://93295056027426", 
            Survivors = "rbxassetid://93295056027426"
        }, 
        VoidRushWeakHit2 = {
            Killers = "rbxassetid://89916825013185", 
            Survivors = "rbxassetid://89916825013185"
        }, 
        VoidRushWeakHit3 = {
            Killers = "rbxassetid://121993564263125", 
            Survivors = "rbxassetid://121993564263125"
        }, 
        VoidRushWeakHit4 = {
            Killers = "rbxassetid://85885985616242", 
            Survivors = "rbxassetid://85885985616242"
        }, 
        VoidRushWeakHit5 = {
            Killers = "rbxassetid://121647649450951", 
            Survivors = "rbxassetid://121647649450951"
        }, 
        VoidRushLoop = "rbxassetid://89315669689903", 
        VoidRushCancel = "rbxassetid://72059832992161", 
        VoidRushMissTimeout = "rbxassetid://72059832992161", 
        VoidRushMissCancelled = "rbxassetid://72059832992161", 
        VoidRushMissCrashed = "rbxassetid://96050032345177", 
        VoidRushMissStunned = "rbxassetid://96050032345177", 
        VoidRushMissNonChar = "rbxassetid://72059832992161", 
        VoidRushDashLoop = "rbxassetid://71090513459907", 
        VoidRushCutscene = "rbxassetid://135554389493369", 
        Teleport = "rbxassetid://131178549856092", 
        ObservantTeleportChannel = "rbxassetid://140414258572390", 
        ObservantOn = "rbxassetid://77578608559836", 
        ObservantOff = "rbxassetid://98263749323192", 
        ObservantGeneratorStart = "rbxassetid://110897561747154", 
        ObservantGeneratorEnd = "rbxassetid://98263749323192", 
        ObservantGeneratorLoop = "rbxassetid://135773051398762", 
        ObservantGeneratorWarning = "rbxassetid://131178549856092", 
        TerrorRadiusThemes = {
            [80] = {
                ID = "rbxassetid://127516940733136", 
                BPM = 81
            }, 
            [40] = {
                ID = "rbxassetid://75646133535821", 
                BPM = 81
            }, 
            [20] = {
                ID = "rbxassetid://125944442315436", 
                BPM = 81
            }, 
            [6] = {
                ID = "rbxassetid://79396800836293", 
                BPM = 81, 
                Chase = true
            }
        }, 
        Stunned = {
            Start = "rbxassetid://124857608807975"
        }, 
        VoidstarEnable = "rbxassetid://81170306325685", 
        Introduction = "rbxassetid://89337443101571", 
        VictoryTheme = "rbxassetid://134941329043567"
    }, 
    VoidstarDisappearCases = {
        Stab = false
    }, 
    NovaProjectile = script.Voidstar, 
    Voicelines = {
        Idle = {
            "rbxassetid://128657983811546", 
            "rbxassetid://71680580404686", 
            "rbxassetid://106197830092408", 
            "rbxassetid://122370329557914", 
            "rbxassetid://139818750306256", 
            "rbxassetid://128189964285290", 
            "rbxassetid://126014993943793", 
            "rbxassetid://123857270152329", 
            "rbxassetid://136519455017554"
        }, 
        Kill = {
            "rbxassetid://88059607505712", 
            "rbxassetid://75517628444806", 
            "rbxassetid://108937800248919", 
            "rbxassetid://126022310896589", 
            "rbxassetid://71024968103434", 
            "rbxassetid://127471575341453", 
            "rbxassetid://94809377768034", 
            "rbxassetid://76131872869482", 
            "rbxassetid://102963070508770", 
            "rbxassetid://71313237736366", 
            "rbxassetid://108798809193459"
        }, 
        Nova = {
            "rbxassetid://120267565579111", 
            "rbxassetid://118840492357266", 
            "rbxassetid://120344193158982", 
            "rbxassetid://108737753379927", 
            "rbxassetid://84209401652439"
        }, 
        Slam = {
            "rbxassetid://98633003715290", 
            "rbxassetid://70700074357096", 
            "rbxassetid://135076245996527"
        }, 
        LastSurvivor = {
            "rbxassetid://120759555935602", 
            "rbxassetid://90134095319280"
        }, 
        Stunned = {
            "rbxassetid://107919656765908", 
            "rbxassetid://82500446152478", 
            "rbxassetid://109250938762844", 
            "rbxassetid://134603163533104", 
            "rbxassetid://98204103666735", 
            "rbxassetid://101627173320026", 
            "rbxassetid://83885249999852", 
            "rbxassetid://116863153119484"
        }, 
        VoidRushStart = {
            "rbxassetid://120267565579111", 
            "rbxassetid://99863365142863", 
            "rbxassetid://108737753379927"
        }, 
        VoidRushLoop = {
            "rbxassetid://99863365142863"
        }, 
        VoidRushMissCrashed = {
            "rbxassetid://84209401652439", 
            "rbxassetid://122652126302255"
        }, 
        VoidRushMissStunned = {
            "rbxassetid://118840492357266", 
            "rbxassetid://120344193158982"
        }, 
        VoidRushMissNonChar = {
            "rbxassetid://134006978881244", 
            "rbxassetid://87633298182200"
        }, 
        Teleport = {
            "rbxassetid://115763631903898", 
            "rbxassetid://108113859160624"
        }
    }
};