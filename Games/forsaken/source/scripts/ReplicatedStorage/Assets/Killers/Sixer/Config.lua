-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = math.floor;
local v1 = {};
v1 = {
    DisplayName = "Guest 666", 
    Quote = "A kind of beast never before encountered.", 
    Credits = "kacklebox, BakedMesh, Koekonaut, Foolskarp", 
    RenderImage = "rbxassetid://90797768189297", 
    Price = 1666, 
    Exclusive = false, 
    NotReplicated = false, 
    Health = 2500, 
    Speed = 8.75, 
    SprintSpeed = 27, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = 110, 
    HighlightColor = Color3.new(0.9, 0, 0), 
    ManicSpeed = 1.2, 
    ManicChaseSpeed = 1.1, 
    ManicBuildRate = 0.1, 
    ManicDecayRate = 0.1, 
    ManicConeSize = 40, 
    ManicForceProximity = 30, 
    ManicColorCorrectionProperties = {
        Saturation = 0.35, 
        Contrast = 0.2, 
        TintColor = Color3.new(1, 0.9, 0.9)
    }, 
    BloodUI = script.BloodUI, 
    SlashDamage = 20, 
    SlashCooldown = 2, 
    SlashWindup = 0.3, 
    SlashLinger = 0.25, 
    SlashBloodOnHit = 10, 
    SlashBiteTime = 0.65, 
    EviscerateDamage = 10, 
    EviscerateDamagePerBlood = 0, 
    EviscerateBloodOnHit = 15, 
    EviscerateWindup = 0.4, 
    EviscerateLinger = 0.25, 
    EviscerateBiteForce = 3, 
    EviscerateBlood = 10, 
    EviscerateHighlight = 8, 
    EviscerateSlowness = {
        Level = 1, 
        Duration = 2
    }, 
    PursuitBlood = 20, 
    PursuitBaseDamage = 5, 
    PursuitMaxDamage = 40, 
    PursuitHardDamageBonus = 0.4, 
    PursuitLength = 0.8, 
    PursuitEndlag = 1.25, 
    PursuitHitEndlag = 1.25, 
    PursuitCooldownReductionPerHighlight = 0, 
    PursuitInitialCooldown = 10, 
    PursuitBaseSpeed = 7, 
    PursuitMaxSpeed = 17, 
    PursuitGravity = 0.6, 
    PursuitMinAngle = 20, 
    PursuitHold = NumberRange.new(0.5, 1.25), 
    PursuitHorizontalPenalty = 0.8, 
    PursuitDamagePerOrb = 1.5, 
    PursuitCooldownReduction = 2.5, 
    PursuitLandVFX = script.LandingParticle, 
    CryWindup = 0.7, 
    CryEndlag = 0.9, 
    CryShockwaveTemplate = script.ShockwaveProjectile, 
    CryDamage = 0, 
    CrySlowness = 2, 
    CrySlownessDuration = 4, 
    CryConfusionDuration = 2, 
    CryHuntSelfStatuses = {
        Speed = {
            Duration = 3, 
            Level = 1
        }, 
        Strength = {
            Duration = 8, 
            Level = 1
        }
    }, 
    CryHighlightDuration = 12, 
    CryShockwaveSize = NumberRange.new(6.6, 6.9), 
    CryShockwaveDuration = 0.55, 
    CryOrbDrop = 2, 
    CryShockwaveDistance = 75, 
    CryHuntingSize = 0.9, 
    CryHuntingDamage = 10, 
    CryLooker = script.AlignOrientation, 
    EcholocationWindup = 0.5, 
    EcholocationEndlag = 1.4, 
    EcholocationDuration = NumberRange.new(5, 20), 
    EcholocationDistance = NumberRange.new(15, 200), 
    BloodHuntInitialCooldown = 15, 
    BloodHuntDuration = 25, 
    BloodHuntKillIncrease = 15, 
    BloodHuntWindup = 1.4, 
    BloodHuntEndlag = 2.4, 
    BloodHuntHeartbeat = script.Heartbeat, 
    BloodHuntVisuals = script.Hunt, 
    BloodHuntVignette = script.Vignette, 
    BloodHuntLMSTime = 6, 
    BloodHuntAtmosphere = {
        Color = Color3.fromRGB(110, 0, 2), 
        Decay = Color3.fromRGB(70, 0, 3), 
        Glare = 0.2, 
        Haze = 10, 
        Density = 0.65
    }, 
    BloodHuntSpeedBoost = 1.04, 
    BloodHuntIncrease = 50, 
    BloodHuntTerror = 0.5, 
    BloodOnKill = 30, 
    BloodStartCount = 0, 
    BloodStartMax = 150, 
    BloodOrbGive = 15, 
    BloodOrbCollectRange = 3.5, 
    BloodOrbCooldownReduction = 3, 
    BloodOrbHighlightDuration = 3, 
    BloodOrbAttractRange = 25, 
    BloodOrbTemplate = script.BloodOrb, 
    BloodOrbVisibleDistance = 90, 
    BloodOrbHighlightTemplate = script.Highlight, 
    BloodOrbLifespan = 60, 
    ChaseEnterThreshold = 15, 
    ChaseLeaveThreshold = 80, 
    HipHeight = 0, 
    CollisionHitbox = script.CollisionHitbox, 
    QueryHitbox = script.QueryHitbox, 
    VFXFolder = script.VFX, 
    Tail = script.TailClass, 
    ELMSLighting = script.ELMSLighting, 
    Relations = {
        "Noob"
    }, 
    LastManStandingEmotionalData = {
        ThemeID = "rbxassetid://88279626466849", 
        RoundTime = 94
    }, 
    Animations = {
        Idle = "rbxassetid://90598066410150", 
        Walk = "rbxassetid://139458868837231", 
        Run = "rbxassetid://111657950569701", 
        InjuredIdle = "rbxassetid://90598066410150", 
        InjuredWalk = "rbxassetid://139458868837231", 
        InjuredRun = "rbxassetid://111657950569701", 
        Slash = {
            Slash = "rbxassetid://73656028013842", 
            Bite = "rbxassetid://112962322837673"
        }, 
        DemonicPursuitStart = "rbxassetid://99500996196440", 
        DemonicPursuitLoop = "rbxassetid://90533098144516", 
        DemonicPursuitLunge = "rbxassetid://100713004609259", 
        DemonicPursuitCutscene = {
            Killer = "rbxassetid://109181231446694", 
            Victim = "rbxassetid://134260613346929"
        }, 
        Cry = "rbxassetid://135738722759081", 
        Stunned = {
            Start = "rbxassetid://119353337033198", 
            Loop = "rbxassetid://72267639577196", 
            End = "rbxassetid://95938636547070"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://127647959458837", 
            CameraRig = "rbxassetid://122027257121066"
        }, 
        Victory = {
            KillerRig = "rbxassetid://118616300377043", 
            CameraRig = "rbxassetid://126837620157836", 
            NoobRig = "rbxassetid://109111656932264"
        }, 
        Execution = {
            KillerRig = "rbxassetid://123008061193635", 
            PlayerRig = "rbxassetid://123742215038305", 
            PlayerCFrameOffset = CFrame.new(0, 4.44, 0)
        }, 
        ExecutionNoob = {
            KillerRig = "rbxassetid://129868247331583", 
            PlayerRig = "rbxassetid://110267086321080", 
            PlayerCFrameOffset = CFrame.new(0, 4.44, 0)
        }, 
        EcholocationActivate = "rbxassetid://93794290762919", 
        BloodHuntActivate = "rbxassetid://118072655890784"
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://103236746412561", 
            "rbxassetid://77506187182539"
        }, 
        Ambience = "rbxassetid://117443714718238", 
        LastSurvivorStanding = "rbxassetid://116163840392152", 
        Introduction = "rbxassetid://90534814756666", 
        Victory = "rbxassetid://125289721415240", 
        TerrorRadiusThemes = {
            [90] = {
                ID = "rbxassetid://130162392348768", 
                BPM = 139
            }, 
            [60] = {
                ID = "rbxassetid://106412504971532", 
                BPM = 139
            }, 
            [30] = {
                ID = "rbxassetid://73158074206972", 
                BPM = 139
            }, 
            [9] = {
				ID = "rbxassetid://136530890609266", 
                BPM = 139, 
                Chase = true
            }
        }, 
        Stunned = {
            Start = "rbxassetid://126971570525921", 
            Loop = "rbxassetid://71372217037383", 
            End = "rbxassetid://105351093198067"
        }, 
        Swing = {
            "rbxassetid://119583605486352", 
            "rbxassetid://79980897195554"
        }, 
        Chomp = "rbxassetid://119583605486352", 
        Hit = "rbxassetid://90819435118493", 
        DemonicPursuitPrepare = {
            SoundId = "rbxassetid://116527305931161", 
            RollOffMaxDistance = 100
        }, 
        DemonicPursuitPrepareWARN = {
            SoundId = "rbxassetid://78298577002481", 
            RollOffMaxDistance = 100
        }, 
        DemonicPursuitLunge = "rbxassetid://71834552297085", 
        DemonicPursuitHit = "rbxassetid://110877859670130", 
        DemonicPursuitCutscene = "rbxassetid://122349424375883", 
        Crashed = {
            SoundId = "rbxassetid://5148302439"
        }, 
        Landed = {
            SoundId = "rbxassetid://18782451032"
        }, 
        Slide = {
            SoundId = "rbxassetid://97251745910217"
        }, 
        CryWindup = {
            SoundId = "rbxassetid://131659092221462", 
            RollOffMaxDistance = v1.CryShockwaveDistance
        }, 
        CryShockwave = {
            SoundId = "rbxassetid://132684357236758", 
            RollOffMaxDistance = v1.CryShockwaveDistance
        }, 
        CryHit = "rbxassetid://118681146051975", 
        Echolocation = "rbxassetid://118238967628320", 
        BloodHunt = "rbxassetid://100133932957472", 
        BloodHuntStart = "rbxassetid://72985187238486", 
        BloodHuntLoop = "rbxassetid://119717613419355", 
        BloodHuntEnd = "rbxassetid://132091893396922", 
        AmbBloodHuntTheme = {
            ID = "rbxassetid://9112863181", 
            BPM = 60
        }, 
        AmbBloodHuntBell = "rbxassetid://117208820805593", 
        AmbBloodHuntHeartbeatSlow = "rbxassetid://6556968450", 
        AmbBloodHuntHeartbeatFast = {
            SoundId = "rbxassetid://393621716", 
            Volume = 0.3
        }, 
        AmbBloodHuntStart = "rbxassetid://9043357118", 
        BloodOrbCollect = {
            "rbxassetid://7837536770"
        }, 
        Execution = "rbxassetid://72183497664401", 
        ExecutionNoob = "rbxassetid://79883354528007", 
        VictoryTheme = "rbxassetid://125289721415240"
    }
};
v1.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "GUEST 666", 
        Text = "Cursed with their name from the moment of their existence, he had managed to find solace in Noob. Someone who saw them for they were inside, but that ideal reality would not last. Guest 666 will viciously rip and tear through any obstacle in her way, feasting on the bloodshed and carnage to empower his abilities."
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. "Stamina Loss per sec: 9.5\n" .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain) .. "Terror Radius: 80 studs\n"
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "MANIC FIXATION", 
        Quote = "\"Have you not heard the legend of Guest 666?\" - Random Robloxian", 
        Text = "While a highlighted Survivor is within 30 studs of Guest 666, he gradually gains up to 10% bonus speed, even if he is not running directly toward them. This bonus becomes 20% stronger if the highlighted Survivor is not currently in Chase.\n"
    }, 
    {
        Header = "BLOODHOUND", 
        Quote = "\"I know you hate that name... so how about Sixer instead?\" - \226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = "Many of <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b>'s attacks will inflict <b>Hemorrhage</b>.\n" .. "While a Survivor is inflicted with <b>Hemorrhage</b>, vines will begin to cover their health bar. <b>Any health the vines are covering cannot be healed back.</b>\n" .. ("Survivors inflicted will also occasionally drop Blood Orbs, giving <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> %* Blood on contact. Blood Orbs drop faster if the Survivor is sprinting, but slower in chase.\n"):format(v1.BloodOrbGive) .. ("Blood Orbs have a maximum lifespan of %*s.\n"):format(v1.BloodOrbLifespan) .. "<b>Hemorrhage</b> can be removed by other Survivors, but <b>you must ask them to do so first by clicking on them.</b>\n" .. "<b>Hemorrhage</b> can also be removed by using a Medkit, but doing so will not heal any health covered by the vines.\n" .. ("<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> starts with %* Blood, and a maximum of %*.\n"):format(v1.BloodStartCount, v1.BloodStartMax) .. ("Collecting Blood Orbs will reduce <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b>'s cooldowns by %*s for each Blood Orb collected.\n"):format(v1.BloodOrbCooldownReduction) .. ("Killing a Survivor will grant <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> %* Blood.\n"):format(v1.BloodOnKill) .. "All of <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b>'s attacks hit multiple players at once."
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://133652393566679", 
        Header = "CARVING SLASH", 
        Quote = "\"The legend says that Guest 666 could use admin commands and stuff... pretty gnarly...\" - Random Robloxian", 
        Text = ("Damage: %*\n"):format(v1.SlashDamage) .. ("Windup: %*s\n"):format(v1.SlashWindup) .. ("Linger: %*s\n"):format(v1.SlashLinger) .. "Length: 7.25 studs\n" .. "<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> slashes forward with their claws.\n" .. ("If this button is held down for %*s and <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> has %* or more Blood, she will follow the slash with Eviscerate.\n"):format(v1.SlashBiteTime, v1.EviscerateBlood) .. ("Landing this move will grant %* Blood.\n"):format(v1.SlashBloodOnHit)
    }, 
    {
        Image = "rbxassetid://133652393566679", 
        Header = "EVISCERATE", 
        Quote = "\"Have you never tried this? Give it a bite!\" - \226\150\136\226\150\136\226\150\136\226\150\136 ", 
        Text = ("Damage: %*\n"):format(v1.EviscerateDamage) .. ("Windup: %*s\n"):format(v1.EviscerateWindup) .. ("Linger: %*s\n"):format(v1.EviscerateLinger) .. "Length: 7 studs\n" .. "Cooldown: 8s\n" .. "<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will lunge forward and bite down.\n" .. "Hit Survivors will be afflicted with <b>Hemorrhage</b>.\n" .. ("This move costs %* Blood to use, but will grant %* Blood and reduce the cooldown of Eviscerate by 50%% on hit.\n"):format(v1.EviscerateBlood, v1.EviscerateBloodOnHit) .. ("Missing this attack will inflict <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> with <b>Slowness I</b> for %*s.\n"):format(v1.EviscerateSlowness.Duration)
    }, 
    {
        Image = "rbxassetid://112820220795591", 
        Header = "DEMONIC PURSUIT", 
        Quote = "\"Guest 666 is a demon bro, I swear on my robux they are.\" - Random Player", 
        Text = ("Damage: 26 - %*\n"):format(v1.PursuitMaxDamage) .. ("Windup: %* - %*s\n"):format(v1.PursuitHold.Min, v1.PursuitHold.Max) .. "Cooldown: 30s\n" .. "<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will crouch down, preparing a leap. By holding the button, this leap can be charged to deal more damage and travel further.\n" .. "By aiming upwards, <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> can <b>jump upwards</b> instead of leaping directly forward.\n" .. ("If <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> makes contact with a Survivor while airborne or for the first %*s of a leap, they will pin them down.\n"):format(v1.PursuitLength) .. "If a Survivor is successfully pinned, <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will slash them 4 times and throw them to the side, inflicting <b>Hemorrhage</b>.\n" .. ("Successfully landing this ability grants <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> %* Blood.\n"):format(v1.PursuitBlood) .. ("During Blood Hunt, this ability will deal more damage depending on how long a Survivor has had <b>Hemorrhage</b>. (+%* for every unhealable health point)"):format(v1.PursuitHardDamageBonus)
    }, 
    {
        Image = "rbxassetid://85312426208381", 
        Header = "INFERNAL CRY", 
        Quote = "\"That voice I heard... it was horrible.\" - \226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("Damage: %*\n"):format(v1.CryDamage) .. ("Windup: %*s\n"):format(v1.CryWindup) .. ("Range: %* studs\n"):format(v1.CryShockwaveDistance) .. "Cooldown: 20s\n" .. "<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will roar, producing a piercing shockwave.\n" .. ("If a Survivor is hit by the shockwave, they will be forced to view <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> and will be afflicted with <b>Blindness II</b> for %*s.\n"):format(v1.CrySlownessDuration) .. ("If a Survivor hit by the shockwave is afflicted with <b>Hemorrhage</b>, they will additionally drop %* Blood Orbs.\n"):format(v1.CryOrbDrop) .. ("Hit Survivors will also be Highlighted for %*s.\n"):format(v1.CryHighlightDuration) .. ("During Blood Hunt, the shockwave deals %* damage, has it's <b>Blindness</b> duration increased to 6s, and now additionally grants <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> <b>Speed I</b> for %*s and <b>Strength I</b> for %*s on hit.\n"):format(v1.CryHuntingDamage, v1.CryHuntSelfStatuses.Speed.Duration, v1.CryHuntSelfStatuses.Strength.Duration) .. "However, the shockwave has it's size reduced by 10%.\n"
    }, 
    {
        Image = "rbxassetid://86146830667112", 
        Header = "BLOOD RUSH", 
        Quote = "\"Guest 666 is real. I saw them with my own two eyes hacking in a game\" - Myth Hunter", 
        Text = "Cooldown: 30s\n" .. ("<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will smell the blood in the air, highlighting every Survivor. The length of the highlight increases with distance from the Survivor, up to %*s at %* studs.\n"):format(v1.EcholocationDuration.Max, v1.EcholocationDistance.Max) .. "While <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> is at maximum blood, this move is replaced with Blood Hunt."
    }, 
    {
        Image = "rbxassetid://90131718849060", 
        Header = "BLOOD HUNT", 
        Quote = "\"You'll always be my best friend Sixer, through and through!\" - \226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = ("<b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will produce an ear-splitting cry audible to every Survivor, resetting all of her cooldowns and starting a Blood Hunt that lasts for %*s.\n"):format(v1.BloodHuntDuration) .. "For the duration of Blood Hunt: \n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> and all survivors suffer from many obstructive visuals.\n" .. " - Several of <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b>'s abilities are amplified.\n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> cannot use Blood Rush.\n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> has their movement speed increased by 4%.\n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> has their terror radius decreased by 50%.\n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> cannot be <b>Stunned</b>, instead only gaining <b>Slowness II</b> for 3s and <b>Helpless I</b> for 2s.\n" .. " - <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> will be able to see the position of <b>all alive Survivors</b> every 5s, appearing as a flashing red highlight. Survivors with <b>Hemorrhage</b> will have a noticably faster flashing highlight and appear white instead of red.\n" .. (" - When <b><font color=\"rgb(200, 0, 0)\">Guest 666</font></b> kills a Survivor, <b>all cooldowns are reset</b> and the duration of Blood Hunt is extended by %*s.\n"):format(v1.BloodHuntKillIncrease) .. " - During a chase, Blood Hunt's timer will decrease twice as slow.\n" .. ("When a Blood Hunt ends, all Blood is instantly removed and maximum blood is increased by %*.\n"):format(v1.BloodHuntIncrease) .. "While Blood Hunt is active, the round cannot end.\n" .. "Blood Hunt is disabled if there is only one survivor left, and will have it's duration set to 6s upon there only being one survivor left while it's active.\n"
    }
};
return v1;