-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Mafioso", 
    Description = "\"I didn't really expect to find one of our targets here.\"", 
    RenderImage = "rbxassetid://87758948514551", 
    Price = 1750, 
    Exclusive = true, 
    Projectile = game.ReplicatedStorage.Assets.Instances.SuitcaseBase, 
    NoProjectileJitter = true, 
    Mafiasos = {
        [1] = script.Mafia1, 
        [2] = script.Mafia2, 
        [3] = script.Mafia3, 
        [4] = script.Mafia4
    }, 
    PizzaDeliveryAnimations = {
        Summoned = "rbxassetid://101433229509261", 
        Idle = "rbxassetid://78214594411942", 
        Walk = "rbxassetid://114894512372072", 
        Hit = "rbxassetid://71827670017746"
    }, 
    Emotes = {
        Animations = {
            Snap = {
                DisplayName = "Snap", 
                Description = " ", 
                Speed = 6, 
                AssetID = "rbxassetid://132946177664650", 
                SFX = {
                    "rbxassetid://71474935050030", 
                    "rbxassetid://128566549159266"
                }, 
                SFXProperties = {
                    Looped = true
                }
            }
        }
    }, 
    Animations = {
		Idle = "rbxassetid://130061100084153", 
		Walk = "rbxassetid://103480848290847", 
		Run = "rbxassetid://91426151366768", 
        Execution = {
			KillerRig = "rbxassetid://101228628952081", 
			PlayerRig = "rbxassetid://110733014595417"
        }, 
        Stunned = {
			Start = "rbxassetid://90289531038897", 
			Loop = "rbxassetid://94540813870319", 
			End = "rbxassetid://95759851666191"
        }, 
        Execution007n7 = false, 
		WalkspeedOverrideStart = "rbxassetid://75333083343667", 
		WalkspeedOverrideLoop = "rbxassetid://93696014536640", 
		WalkspeedOverrideHit = "rbxassetid://137821065948194", 
		WalkspeedOverrideMiss = "rbxassetid://100078079246678", 
		Attack = "rbxassetid://139539704434328", 
		CorruptNature = "rbxassetid://137460487315648", 
		SummonPizzaDelivery = "rbxassetid://102704534404835"
    }, 
    Sounds = {
        MafiasoSpawn = {
            [1] = "rbxassetid://123948182337855", 
            [2] = "rbxassetid://93659656839634", 
            [3] = "rbxassetid://93952540545104", 
            [4] = "rbxassetid://93952540545104"
        }, 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://75554737667196", 
                BPM = 140
            }, 
            [40] = {
                ID = "rbxassetid://121567985915317", 
                BPM = 140
            }, 
            [20] = {
                ID = "rbxassetid://133222944971198", 
                BPM = 140
            }, 
            [6] = {
                ID = "rbxassetid://84250831671130", 
                BPM = 140, 
                Chase = true, 
                LoopRegion = NumberRange.new(3.64, 130.5)
            }
        }, 
        PizzaDeliveryGuySpawned = "rbxassetid://12221944", 
        IntroductionSound = "rbxassetid://87207560431801", 
        Introduction = "rbxassetid://1", 
        Bunny = "rbxassetid://6715870978", 
        CorruptThrow = "rbxassetid://106484876889079", 
        WalkspeedOverrideHit = "rbxassetid://12222208", 
        WalkspeedOverrideCollide = "rbxassetid://109397400639910", 
        WalkspeedOverrideTimeout = "rbxassetid://109397400639910", 
        SwordUnsheath = "rbxassetid://12222225", 
        Swing = "rbxassetid://12222216"
    }, 
    Voicelines = {
        Idle = false, 
        LastSurvivorEmotional = false, 
        LastSurvivor = false, 
        KillNoob = false, 
        KillElliot = false, 
        KillGuest1337 = false, 
        Kill007n7 = false, 
        CorruptNature = false, 
        PizzaDelivery = false, 
        PizzaDeliveryHit = false, 
        WalkspeedOverride = false, 
        WalkspeedOverrideHit = {
            "rbxassetid://97981944414502"
        }, 
        WalkspeedOverrideCollide = {
            "rbxassetid://118437725423583"
        }, 
        WalkspeedOverrideTimeout = {
            "rbxassetid://118437725423583"
        }, 
        KillNashatraShedletsky = {
            "rbxassetid://119069863150852", 
            "rbxassetid://121292981713587"
        }, 
        Kill = {
            [1] = "rbxassetid://77256557251496", 
            [2] = "rbxassetid://126485367406048", 
            [3] = "rbxassetid://88498119897840"
        }, 
        Stunned = {
            "rbxassetid://81573614952080"
        }
    }
};