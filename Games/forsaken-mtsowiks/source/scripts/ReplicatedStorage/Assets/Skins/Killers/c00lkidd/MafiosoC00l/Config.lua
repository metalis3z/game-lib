-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Mafioso", 
    Description = "\"Never mess with the Sonnellinos.", 
    RenderImage = "rbxassetid://121563011487815", 
    Price = 2777, 
    Projectile = game.ReplicatedStorage.Assets.Instances.SuitcaseBase, 
    NoProjectileJitter = true, 
    IntroLighting = script.IntroLighting, 
    c00lguiTemplate = script.c00lgui, 
    PizzaDeliveryRig = script.Minions, 
    PizzaDeliveryAnimations = {
        Summoned = "rbxassetid://86947355943876", 
        Idle = "rbxassetid://117003327453642", 
        Walk = "rbxassetid://132491105686399", 
        Hit = "rbxassetid://108918591165632"
    }, 
    Emotes = {
        Animations = {
            Snap = {
                DisplayName = "Snap", 
                Description = " ", 
                Speed = 6, 
                AssetID = "rbxassetid://123483679060474", 
                SFX = "rbxassetid://128566549159266", 
                SFXProperties = {
                    Looped = true
                }
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://135946545634697", 
        Walk = "rbxassetid://137705425453132", 
        Run = "rbxassetid://82263518508300", 
        InjuredIdle = "rbxassetid://135946545634697", 
        InjuredWalk = "rbxassetid://137705425453132", 
        InjuredRun = "rbxassetid://82263518508300", 
        Introduction = {
            KillerRig = "rbxassetid://136069876649630", 
            CameraRig = "rbxassetid://80594579883913", 
            CaporegimeRig = "rbxassetid://124754288757785", 
            ConsigliereRig = "rbxassetid://84050384182032", 
            ContracteeRig = "rbxassetid://94392263877177", 
            SoldierRig = "rbxassetid://127884189708052"
        }, 
        Victory = {
            KillerRig = "rbxassetid://135946545634697", 
            KillerRigLoop = "rbxassetid://135946545634697", 
            CameraRig = "rbxassetid://135946545634697"
        }, 
        Execution = {
            KillerRig = "rbxassetid://76321481569469", 
            PlayerRig = "rbxassetid://113104250613332"
        }, 
        Stunned = {
            Start = "rbxassetid://84989135496147", 
            Loop = "rbxassetid://87373331704826", 
            End = "rbxassetid://75020094475179"
        }, 
        Execution007n7 = false, 
        WalkspeedOverrideStart = "rbxassetid://91758957691100", 
        WalkspeedOverrideLoop = "rbxassetid://115482496270795", 
        WalkspeedOverrideHit = "rbxassetid://113025740844957", 
        WalkspeedOverrideMiss = "rbxassetid://83577803902589", 
        Attack = "rbxassetid://110175935023416", 
        CorruptNature = "rbxassetid://86153194640638", 
        SummonPizzaDelivery = "rbxassetid://101655184986137"
    }, 
    Sounds = {
		TerrorRadiusThemes = {
			[60] = {
				["ID"] = "rbxassetid://122654349776910",
				["BPM"] = 140
			},
			[40] = {
				["ID"] = "rbxassetid://70590668205133",
				["BPM"] = 140
			},
			[20] = {
				["ID"] = "rbxassetid://133535736575133",
				["BPM"] = 140
			},
			[6] = {
				["ID"] = "rbxassetid://103891028117851",
				["BPM"] = 140,
				["Chase"] = true,
				["LoopRegion"] = NumberRange.new(3.64, 130.5)
			}
		},
        PizzaDeliveryGuySpawned = {
            ID = "rbxassetid://117700822726695", 
            Properties = {
                Looped = false, 
                TimePosition = 0.9
            }
        }, 
        Introduction = "rbxassetid://76078176465249", 
        CorruptThrow = "rbxassetid://96968897550969", 
        WalkspeedOverrideHit = "rbxassetid://84122523631600", 
        WalkspeedOverrideCollide = "rbxassetid://107593207834624", 
        WalkspeedOverrideTimeout = "rbxassetid://107593207834624", 
        SwordUnsheath = "rbxassetid://102834749715839", 
        Swing = "rbxassetid://84307400688050"
    }, 
    VoicelineVolume = 1.75, 
    Voicelines = {
        Kill007n7 = false, 
        KillNoob = false, 
        LastSurvivorEmotional = false, 
        Idle = {
            "rbxassetid://120536789961739", 
            "rbxassetid://76112309181055", 
            "rbxassetid://73441939539105", 
            "rbxassetid://96662308769352", 
            "rbxassetid://95612382126159", 
            "rbxassetid://92093780845537", 
            "rbxassetid://137963699213332", 
            "rbxassetid://113280210448632"
        }, 
        Introduction = {
            "rbxassetid://72785613225305", 
            "rbxassetid://98758335597614", 
            "rbxassetid://108022885850016", 
            "rbxassetid://107816074118089", 
            "rbxassetid://89269718342412"
        }, 
        Victory = {
            "rbxassetid://80082924076323", 
            "rbxassetid://124657006080250", 
            "rbxassetid://96467328612143", 
            "rbxassetid://72125435113043", 
            "rbxassetid://85101629798832"
        }, 
        LastSurvivor = {
            "rbxassetid://130645222462245", 
            "rbxassetid://133553577407545", 
            "rbxassetid://101481281119115", 
            "rbxassetid://75394690461812", 
            "rbxassetid://129188632800882", 
            "rbxassetid://112550175091312"
        }, 
        KillElliot = {
            "rbxassetid://140244007889725", 
            "rbxassetid://113778578754149"
        }, 
        CorruptNature = {
            "rbxassetid://77772986039216", 
            "rbxassetid://79018425642776", 
            "rbxassetid://131025354670534", 
            "rbxassetid://107930204924286", 
            "rbxassetid://72716938933512", 
            "rbxassetid://119587632892619", 
            "rbxassetid://137143328123005"
        }, 
        PizzaDelivery = {
            "rbxassetid://106013915796756", 
            "rbxassetid://107774071837724", 
            "rbxassetid://124225832378552", 
            "rbxassetid://79956207479895", 
            "rbxassetid://71592947125030", 
            "rbxassetid://117935077469660", 
            "rbxassetid://77146726911882", 
            "rbxassetid://101957046095436", 
            "rbxassetid://129648163855265"
        }, 
        PizzaDeliveryHit = {
            "rbxassetid://72666345141497", 
            "rbxassetid://115485149611567", 
            "rbxassetid://128803132153726", 
            "rbxassetid://86175986834233", 
            "rbxassetid://91103863517303", 
            "rbxassetid://121377579075571", 
            "rbxassetid://111131574710998", 
            "rbxassetid://96030975206116", 
            "rbxassetid://84968970746596"
        }, 
        WalkspeedOverride = {
            "rbxassetid://131330398434394", 
            "rbxassetid://80050323067056", 
            "rbxassetid://95421243294179", 
            "rbxassetid://79019700121690", 
            "rbxassetid://115100083626278", 
            "rbxassetid://129488348647628", 
            "rbxassetid://104693988311673", 
            "rbxassetid://94338049777740"
        }, 
        WalkspeedOverrideHit = {
            "rbxassetid://73208075751305", 
            "rbxassetid://115337202312481", 
            "rbxassetid://94731493023258", 
            "rbxassetid://130814932709145", 
            "rbxassetid://116594850113107"
        }, 
        WalkspeedOverrideCollide = {
            "rbxassetid://97710422930563", 
            "rbxassetid://99878217280983", 
            "rbxassetid://90376303964839", 
            "rbxassetid://111265128779745", 
            "rbxassetid://136637133703291", 
            "rbxassetid://106090774054279", 
            "rbxassetid://136830776696969"
        }, 
        WalkspeedOverrideTimeout = {
            "rbxassetid://111305604436505", 
            "rbxassetid://104846774001495", 
            "rbxassetid://109756994179563", 
            "rbxassetid://127483255329627", 
            "rbxassetid://81008505245181", 
            "rbxassetid://104481832974563"
        }, 
        KillGuest1337 = {
            "rbxassetid://130682574994142", 
            "rbxassetid://101547115067043"
        }, 
        KillChance = {
            "rbxassetid://140502647710513", 
            "rbxassetid://95826072509698", 
            "rbxassetid://70827186205144", 
            "rbxassetid://99818468440031", 
            "rbxassetid://119886631468081", 
            "rbxassetid://109317488551706", 
            "rbxassetid://76632198575362"
        }, 
        Kill = {
            "rbxassetid://106991973720957", 
            "rbxassetid://110136703532043", 
            "rbxassetid://127400428423463", 
            "rbxassetid://91029414776851", 
            "rbxassetid://118836865755954", 
            "rbxassetid://108290752252329", 
            "rbxassetid://110292460108562", 
            "rbxassetid://77704626972735", 
            "rbxassetid://109091774963362", 
            "rbxassetid://81645514987266"
        }, 
        Stunned = {
            "rbxassetid://127230113608103", 
            "rbxassetid://140031550551195", 
            "rbxassetid://92144067757604", 
            "rbxassetid://126259929120250", 
            "rbxassetid://74106703740001", 
            "rbxassetid://129668212140393", 
            "rbxassetid://138355865813993", 
            "rbxassetid://93392259017222", 
            "rbxassetid://115829442060483"
        }
    }, 
    TerrorRadiusThemes = {
        [60] = {
            ID = "rbxassetid://118235532103625", 
            BPM = 132
        }, 
        [40] = {
            ID = "rbxassetid://117916926328775", 
            BPM = 132
        }, 
        [20] = {
            ID = "rbxassetid://75425168734218", 
            BPM = 132
        }, 
        [6] = {
            ID = "rbxassetid://88325606095183", 
            BPM = 132, 
            Chase = true
        }
    }
};