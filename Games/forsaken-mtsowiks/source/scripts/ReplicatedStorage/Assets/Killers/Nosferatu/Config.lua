-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Nosferatu", 
    Quote = "Who was flickering the lights bruhhhh", 
    Description = "A sanguine desire, one held by those of bloodied code. Tempted by a deal of infinite celebration and desire, Nosferatu arrived to bring forth the Masquerade into the realm, alongside a bloody banquet. Through the manipulation of code and form, Nosferatu takes advantage of land and air. Luring those in with his manipulation of bloody code to further feast and infect those around him.", 
	Credits = "Sayso_1230 & ffPrankster", 
    RenderImage = "rbxassetid://78365111323543", 
    Price = 0, 
    Exclusive = true, 
    Health = 1700, 
    Speed = 7.25, 
    SprintSpeed = 27.5, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = 110, 
    Slash = {
        Damage = 24, 
        Windup = 0.3, 
        Linger = 0.3, 
        Endlag = 0.5
    }, 
    Uppercut = {
        Windup = 0.8333333333333334, 
        InitialDamage = 15, 
        KickDamage = 20, 
        ProjectileSpeed = 330, 
        ProjectileLifetime = 0.3333333333333333, 
        WeakDamage = 3, 
        WeakDistance = 24, 
        PullWindup = 1, 
        Endlag = 0.5, 
        LingeringInvincibility = 1.5, 
        BasePullSpeed = 12, 
        FailPullSpeed = 32, 
        KickKnockback = 90, 
        QTEFrame = script.QTE, 
        CutsceneSelfStatuses = {
            Helpless = {
                Duration = 2
            }, 
            Slowness = {
                Level = 2, 
                Duration = 1
            }
        }
    }, 
    Spire = {
        Windup = 0.75, 
        Duration = 1.25, 
        Speed = 15, 
        Delay = 0.55, 
        TurnControl = 10, 
        ExplosionGap = 3.3, 
        ExplosionDamage = 10, 
        ExplosionRadius = 17.5, 
        Endlag = 0.8, 
        PuddleLifetime = 14, 
        BeamTemplate = script.Beam
    }, 
    Ascent = {
        InitialCooldown = 10, 
        Windup = 0.65, 
        Length = 0.35, 
        Speed = 45, 
        Force = 100000, 
        Gravity = 0.8, 
        CanTurn = false, 
        Endlag = 0.2
    }, 
    AscentFlight = {
        Speed = 6.5, 
        Force = 100000, 
        FlapForce = 30, 
        Acceleration = 1600, 
        AuraDuration = 10, 
        Duration = 10, 
        Endlag = 1, 
        GroundSlowness = 0.35
    }, 
    AscentBite = {
        Damage = {
            5, 
            35
        }, 
        Windup = 0.7, 
        Speed = 100, 
        TurnSpeed = 4, 
        EndlagMiss = 1, 
        EndlagHit = 2, 
        Knockback = 100, 
        MissedStatuses = {
            Slowness = {
                Level = 3, 
                Duration = 2.5
            }, 
            Helpless = {
                Level = 1, 
                Duration = 2.5
            }
        }
    }, 
    Bats = {
        Damage = 5, 
        Windup = 0.23, 
        Endlag = 0.5, 
        Statuses = {
            Creatures = {
                Duration = 10, 
                Level = 1
            }, 
            Oblivious = {
                Duration = 10, 
                Level = 1
            }
        }, 
        SelfStatuses = {
            Undetectable = {
                Duration = 10
            }, 
            Invisibility = {
                Level = 4, 
                Duration = 10
            }
        }, 
        AuraDuration = 10, 
        HitboxScalar = 5.75, 
        ProjectileSpeed = 60, 
        ProjectileTemplate = script.Bats
    }, 
    OutroDummy = script.OutroDummy, 
    CataclysmTrailFolder = script:FindFirstChild("CataclysmTrail"), 
    CataclysmExplode = script:FindFirstChild("CataclysmExplode"), 
    BatTransform = script.BatTransform, 
    PuddleRootTemplate = script.PuddleRootTemplate, 
    Animations = {
        Idle = "rbxassetid://127875180725690", 
        Walk = "rbxassetid://114565232921228", 
        Run = "rbxassetid://120288399446365", 
        InjuredIdle = "rbxassetid://127875180725690", 
        InjuredWalk = "rbxassetid://114565232921228", 
        InjuredRun = "rbxassetid://120288399446365", 
        Introduction = {
            KillerRig = "rbxassetid://89712828487228", 
            CameraRig = "rbxassetid://131310815416678"
        }, 
        Victory = {
            KillerRig = "rbxassetid://96117089826379", 
            CameraRig = "rbxassetid://124921298694550"
        }, 
        Execution = {
            KillerRig = "rbxassetid://126788555575577", 
            PlayerRig = "rbxassetid://119620962458350"
        }, 
        Stunned = {
            Start = "rbxassetid://137746762871568", 
            Loop = "rbxassetid://108232656163472", 
            End = "rbxassetid://87707658765450"
        }, 
        Slash = "rbxassetid://132730828893721", 
        SlashAir = "rbxassetid://132754258737574", 
        Uppercut = "rbxassetid://128761019396002", 
        UppercutPullingLoop = "rbxassetid://106829620802899", 
        UppercutWinner = "rbxassetid://71758022469766", 
        SpireStart = "rbxassetid://114879537408306", 
        SpireLoop = "rbxassetid://104452814791160", 
        SpireEnd = "rbxassetid://137817511415612", 
        BatAirLoop = "rbxassetid://122946356093518", 
        BatFloorLoop = "rbxassetid://76464763390489", 
        BatStart = "rbxassetid://126446884482493", 
        BatBiteWindup = "rbxassetid://96936087997286", 
        BatBiteWarning = "rbxassetid://75233844730127", 
        BatBiteLoop = "rbxassetid://83419783984520", 
        BatBiteCutscene = {
            Killer = "rbxassetid://128123829703494", 
            Victim = "rbxassetid://117213018654948"
        }, 
        BatsThrow = "rbxassetid://123399352415027", 
        Ascent = "rbxassetid://132530883614498"
    }, 
    Sounds = {
        Ambience = "rbxassetid://104753467512212", 
        Footsteps = {
            "rbxassetid://72457886454761", 
            "rbxassetid://98852761114513"
        }, 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://79368350590028", 
                BPM = 73
            }, 
            [45] = {
                ID = "rbxassetid://112172740581825", 
                BPM = 73
            }, 
            [20] = {
                ID = "rbxassetid://132072387842237", 
                BPM = 73
            }, 
            [10] = {
                ID = "rbxassetid://115451433622488", 
                BPM = 73, 
                Chase = true
            }
        }, 
        Stunned = "rbxassetid://109824454593705", 
        Introduction = "rbxassetid://120322466052873", 
        VictoryTheme = {
            ID = "rbxassetid://137826049730316", 
            Properties = {
                Volume = 1.45, 
                Looped = false
            }
        }, 
        Execution = "rbxassetid://133018631915745", 
        Hit = "rbxassetid://110126546193799", 
        SlashGround = "rbxassetid://104910828105172", 
        UppercutWindup = "rbxassetid://120038054863702", 
        UppercutCaught = {
            SoundId = "rbxassetid://140194172008986", 
            Volume = 0.55
        }, 
        UppercutMiss = "rbxassetid://133072471020257", 
        UppercutReelLoop = "rbxassetid://95086312434966", 
        UppercutEscape = "rbxassetid://118313228757371", 
        UppercutBreak = "rbxassetid://139535470409055", 
        UppercutCutscene = "rbxassetid://140139514810063", 
        SpireStart = "rbxassetid://83428781642755", 
        SpireLoop = "rbxassetid://133665685592727", 
        SpireExplode = {
            "rbxassetid://75529168252358", 
            "rbxassetid://130719628501628", 
            "rbxassetid://133014346991084"
        }, 
        SpireEnd = "rbxassetid://107851350547944", 
        AscentStart = "rbxassetid://88000454882343", 
        AscentTransform = "rbxassetid://123356727212395", 
        AscentFlyLoop = "rbxassetid://120692767377828", 
        AscentWingFlap = {
            "rbxassetid://77635194855200", 
            "rbxassetid://109098627756396", 
            "rbxassetid://119478857711415"
        }, 
        AscentDetransform = "rbxassetid://117349805936188", 
        AscentBiteWarning = "rbxassetid://72224025765386", 
        AscentBiteStart = "rbxassetid://88000454882343", 
        AscentBiteLoop = "rbxassetid://94043596324983", 
        AscentBiteMiss = "rbxassetid://92764078909748", 
        AscentBiteHit = "rbxassetid://85544168523099", 
        BatsGround = "rbxassetid://105672084180163", 
        BatsBatHit = "rbxassetid://104388455240670", 
        BatsBatMiss = "rbxassetid://104388455240670", 
        BatsBatsIdle = "rbxassetid://104283479568709", 
        QTESucceed = {
            "rbxassetid://91417050997662", 
            "rbxassetid://92272415010778", 
            "rbxassetid://107032865404056"
        }, 
        QTEFail = "rbxassetid://77699647248581"
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "NOSFERATU", 
        Text = "A vampire, tired of the hierarchy, terrorized Roblox before being taken away. He boasts his superior powers and flies through the skies, isolating survivors and feasting on them. Nosferatu is particularly \n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v0.Health) .. ("Regular Speed: %*\n"):format(v0.Speed) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed) .. ("Max Stamina: %*\n"):format(v0.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain) .. "Terror Radius: 60 studs\n"
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "LEVITATION", 
        Quote = "\"To walk without sound is to hunt without mercy.\" \226\128\147 Nosferatu", 
        Text = "Nosferatu levitates naturally, meaning that they don't make footstep sounds.\n"
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://119979438428834", 
        Header = "LACERATE", 
        Quote = "\"We are the things that Robloxians fear.\" - Nosferatu", 
        Text = "Cooldown: 2s\n" .. ("Damage: %*\n"):format(v0.Slash.Damage) .. ("Windup: %*\n"):format(v0.Slash.Windup) .. ("Linger: %*\n"):format(v0.Slash.Linger) .. "Length: 7.5 studs\n" .. "Nosferatu slashes infront of him with his claws.\n"
    }, 
    {
        Image = "rbxassetid://93747578668234", 
        Header = "BLOODHOOK", 
        Quote = "\"We are those who arrive in the night, stalking our prey and pulling them from prying eyes.\" - Nosferatu", 
        Text = "Cooldown: 20s \nNosferatu slows himself briefly to wind up a Blood Hook for 0.9s, and will then root himself as he throws it forward at high speed.\nIf BLOODHOOK connects with a survivor, it will deal 15 damage and latch onto them where Nosferatu will then start dragging the survivor towards him.\nBoth Nosferatu and the survivor will engage in a minigame where Nosferatu will attempt to keep the survivor hooked and the survivor will attempt to escape.\nIf Nosferatu is successful in pulling the survivor all the way towards him, he will perform a kick, dealing 20 damage and knocking the survivor away from him.\nNosferatu will be briefly inflicted with <b>Slowness</b> II and <b>Helpless</b> after performing the kick.\nIf the survivor manages to escape the hook, Nosferatu will only be inflicted with <b>Helpless</b>.\n"
    }, 
    {
        Image = "rbxassetid://119327945150704", 
        Header = "CATACLYSM", 
        Quote = "\"Dude I swear on my life I saw a vampire dash at like mach 5!!!\" - Random Robloxian", 
        Text = "Cooldown: 20s \nDamage: 10\nNosferatu will briefly wind up and then gain immense speed while also turning invisible. leaving a small trail behind him. Survivors and obstacles do not immediately take damage. \nAfter reaching the end of the path, Nosferatu explodes into a swarm of bats, dealing 10 damage, instantly returning to his starting point and leaving a large trail of blood in his path that will inflict Survivors with <b>Bleeding III</b> and <b>Slowness II</b> for 5s if entered.\n"
    }, 
    {
        Image = "rbxassetid://122139471274199", 
        Header = "HUNTER'S FEAST", 
        Quote = "\"THE BATS AAAAAAAAAAAAAAAAAAAAAAAAAAAA\" - Unfortunate Robloxian", 
        Text = "Cooldown: 20s\nDamage: 5\nNosferatu releases a swarm of bats that fly forward.\nIf HUNTER'S FEAST hits a survivor, they will be inflicted with <b>Creatures I</b> and <b>Oblivious I</b> for 10s, while Nosferatu will gain <b>Invisibiliy IV</b> and <b>Undetectable I</b> for 10s.\nWhile HUNTER'S FEAST is in the air, Nosferatu is able to redirect the swarm to their cursor by pressing the ability button again.\nThis can only be done once each use.\n"
    }, 
    {
        Image = "rbxassetid://87426383077507", 
        Header = "ASCENSION", 
        Quote = "\"You know what's in here, I know what's in here. Inside you'll find...\" -???", 
        Text = "Cooldown: 30s\nNosferatu leaps upwards before temporarily transforming into a bat and gaining free flight across the map.\nNosferatu is able to flap his wings and propel himself upwards by pressing spacebar and can hold the key down to hover briefly.\nWhile in bat form, Nosferatu can perform a dive attack by pressing the LACERATE ability button. If the dive attack successfully collides with a Survivor, he instantly reverts to humanoid shape and bites down on their neck, dealing 5 damage and stunning them before winding up and throwing the survivor for 35 damage.\nWhile transformed, Nosferatu's Terror Radius is reduced and his movement speed is increased, but they do not regenerate Stamina.\nIf Nosferatu misses the dive attack or exits without using it, he will be inflicted with <b>Slowness III</b> and <b>Helpless I</b> for 2.5s.\nNosferatu can remain transformed for up to 10s.\n"
    }
};
return v0;