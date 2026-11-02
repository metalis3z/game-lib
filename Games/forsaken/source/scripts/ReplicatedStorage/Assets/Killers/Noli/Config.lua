-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Noli", 
    Quote = "\"This thing of darkness I acknowledge mine.\"", 
    Credits = "By: c2o", 
    RenderImage = "rbxassetid://83819111053954", 
    Price = 1100, 
    Exclusive = false, 
    Health = 1111, 
    Speed = 7.5, 
    SprintSpeed = 27.5, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = 110, 
    MovementAnimSpeed = 1.5, 
    StabDamage = 25, 
    StabCooldown = 1.8, 
    StabWindup = 0.35, 
    StabLinger = 0.25, 
    StabEndlag = 1.5, 
    VoidRushBaseDamage = 10, 
    VoidRushSlamDamage = 30, 
    VoidRushC00ldown = 20, 
    VoidRushHallucinationLevel = 2, 
    VoidRushHallucinationDuration = 20, 
    VoidRushChargeLength = 1, 
    VoidRushDashLength = 3.5, 
    VoidRushDashSpeed = 60, 
    VoidRushTurnSpeed = 1, 
    VoidRushInitialTurnDuration = 1.12, 
    VoidRushInitialTurnMult = 6, 
    VoidRushHitEndlag = 0.85, 
    VoidRushComboWindow = 1.5, 
    VoidRushComboDamage = 3.5, 
    VoidRushMissEndlag = 2, 
    VoidRushChargingSpeed = 0.4, 
    VoidRushCutsceneLength = 2.65, 
    VoidRushStopMessages = {
        Hit = "Hit the Void Rush key again to charge again!", 
        HitLarge = "hell yeah >:)", 
        Crashed = "owwwww ;(", 
        Cancelled = "Awww :(", 
        Stunned = "AUGHHHHHHH", 
        Timeout = "too slow", 
        FailedToCharge = "you didn't charge it long enough >:((", 
        WindowMissed = "ok... ;(", 
        NonChar = "PROPERTY DAMAGE"
    }, 
    NovaCooldown = 12, 
    NovaProjectile = script.Voidstar, 
    NovaWindup = 0.78, 
    NovaWindupSpeed = 0.5, 
    NovaProjectileSpeed = 80, 
    NovaMaxRange = 115, 
    NovaExplosionRadius = 26, 
    NovaExplosionDamage = 15, 
    NovaExplosionKnockback = 700, 
    NovaTeleportDisableLength = 0.5, 
    NovaFloorAngle = 10, 
    ObservantC00ldown = 30, 
    ObservantSpeed = 0.2, 
    ObservantTeleportWindup = 1.45, 
    ObservantTeleportEndlag = 1.3, 
    ObservantStatusThresholds = {
        20, 
        60, 
        100, 
        1e999
    }, 
    ObservantStatusDuration = game["Run Service"]:IsStudio() and 45 or 15, 
    ObservantWarningTemplate = script.GeneratorWarning, 
    ObservantHighlightTemplate = script.ScaryGenAura, 
    ObservantKillerProperties = {
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, 
        FillTransparency = 0.5, 
        FillColor = Color3.new(0.635294, 0, 1), 
        OutlineColor = Color3.new(0.117647, 0, 0.188235), 
        OutlineTransparency = 0.75
    }, 
    ObservantIncomingTemplate = script.GeneratorIncoming, 
    ObservantTeleportButton = script.GeneratorTeleportButton, 
    ObservantMinDistance = 50, 
    ObservantTeleportVFX = script.TeleportVFX, 
    HallucinationScreamer = script.noliLaugh, 
    HallucinationCloneDamage = 0.01, 
    HallucinationCloneFakeDamage = 25, 
    HallucinationCloneExtension = 3, 
    IntroLighting = script.IntroLighting, 
    ImpactCC = script.Impact, 
    OutroLighting = script.OutroLighting, 
    OutroFrameData = require(script.BakedOutroData), 
    Emotes = {
        Voicelines = {
            Yes = {
                DisplayName = "Yes", 
                Description = "Yayayaya", 
                Voiceline = "Wheel_Yes"
            }, 
            No = {
                DisplayName = "No", 
                Description = "no", 
                Voiceline = "Wheel_No"
            }, 
            Taunt = {
                DisplayName = "Taunt", 
                Description = "nananana boo boo", 
                Voiceline = "Wheel_Taunt"
            }, 
            Rage = {
                DisplayName = "Rage", 
                Description = "GRRRRRRRRRR", 
                Voiceline = "Wheel_Rage"
            }, 
            Laugh = {
                DisplayName = "Laugh", 
                Description = "HAHAHAHAHAHAHAHA", 
                Voiceline = "Wheel_Laugh"
            }
        }
    }, 
	Animations = {
		["Idle"] = "rbxassetid://104613758840874",
		["Walk"] = "rbxassetid://134258056987999",
		["Run"] = "rbxassetid://110995276528216",
		["InjuredIdle"] = "rbxassetid://104613758840874",
		["InjuredWalk"] = "rbxassetid://134258056987999",
		["InjuredRun"] = "rbxassetid://110995276528216",
		["Stab"] = "rbxassetid://89369123712289",
		["Victory"] = {
			["KillerRig"] = "rbxassetid://81458954992983",
			["CameraRig"] = "rbxassetid://108788289395603"
		},
		["VoidRush"] = {
			["StartCharge"] = "rbxassetid://122891690336630",
			["LoopCharge"] = "rbxassetid://96628721121045",
			["CancelCharge"] = "rbxassetid://122891690336630",
			["StartDashInit"] = "rbxassetid://119131075187744",
			["LoopDashInit"] = "rbxassetid://95252516719717",
			["StartDashCombo"] = "rbxassetid://76595611899623",
			["LoopDashCombo"] = "rbxassetid://136118578455208",
			["EndDash"] = "rbxassetid://92771850341685",
			["EndDashCrashed"] = "rbxassetid://95799318622009",
			["EndDashNonChar"] = "rbxassetid://95799318622009",
			["WeakHit"] = "rbxassetid://70471370518052",
			["CutsceneKillerRig"] = "rbxassetid://131315567131652"
		},
		["VoidRushVictimRig"] = "rbxassetid://110987229741630",
		["NovaThrow"] = "rbxassetid://109889492051037",
		["NovaDet"] = "rbxassetid://115464744452121",
		["ObservantStart"] = "rbxassetid://83597189679107",
		["ObservantLoop"] = "rbxassetid://91657744897137",
		["ObservantTeleport"] = "rbxassetid://120639364886911",
		["Hallucination"] = "rbxassetid://120639364886911",
		["Introduction"] = {
			["KillerRig"] = "rbxassetid://125884362792872",
			["CameraRig"] = "rbxassetid://127955890807163"
		},
		["Execution"] = {
			["KillerRig"] = "rbxassetid://95173068891855",
			["PlayerRig"] = "rbxassetid://117824856200442",
			["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
		},
		["Stunned"] = {
			["Start"] = "rbxassetid://117206848425415",
			["Loop"] = "rbxassetid://123053408195406",
			["End"] = "rbxassetid://106920502838050"
		}
	},
    Sounds = {
        Ambience = "rbxassetid://82260342194598", 
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Execution = "rbxassetid://78344423946580", 
        Swing = "rbxassetid://109348678063422", 
        Hit = "rbxassetid://136406635725343", 
        Nova = "rbxassetid://90768093259753", 
        NovaInject = "rbxassetid://114767134633867", 
        NovaDefused = "rbxassetid://9117341652", 
        NovaShatter = "rbxassetid://135436309", 
        Explosion = "rbxassetid://99558901806521", 
        VoidRushStart = {
            Killers = "rbxassetid://107347032614322", 
            Survivors = "rbxassetid://126318185932771"
        }, 
        VoidRushWindow = {
            Killers = "rbxassetid://77245770579014", 
            Survivors = "rbxassetid://117420477449885"
        }, 
        VoidRushWeakHit1 = {
            Killers = "rbxassetid://123051542178150", 
            Survivors = "rbxassetid://83893550495660"
        }, 
        VoidRushWeakHit2 = {
            Killers = "rbxassetid://70791051058969", 
            Survivors = "rbxassetid://83893550495660"
        }, 
        VoidRushWeakHit3 = {
            Killers = "rbxassetid://80956911752327", 
            Survivors = "rbxassetid://83893550495660"
        }, 
        VoidRushWeakHit4 = {
            Killers = "rbxassetid://96081637668009", 
            Survivors = "rbxassetid://83893550495660"
        }, 
        VoidRushWeakHit5 = {
            Killers = "rbxassetid://119071199261500", 
            Survivors = "rbxassetid://83893550495660"
        }, 
        VoidRushLoop = "rbxassetid://89315669689903", 
        VoidRushCancel = "rbxassetid://105484443350662", 
        VoidRushMissTimeout = "rbxassetid://105484443350662", 
        VoidRushMissCancelled = "rbxassetid://105484443350662", 
        VoidRushMissCrashed = "rbxassetid://77652597584455", 
        VoidRushMissStunned = "rbxassetid://77652597584455", 
        VoidRushMissNonChar = "rbxassetid://77652597584455", 
        VoidRushDash1 = "rbxassetid://85810983952228", 
        VoidRushDash2 = "rbxassetid://110115912768379", 
        VoidRushDashLoop = "rbxassetid://113037804008732", 
        VoidRushCutscene = "rbxassetid://103260933771149", 
        Teleport = "rbxassetid://5066021887", 
        ObservantTeleportChannel = "rbxassetid://125253972523701", 
        ObservantOn = "rbxassetid://124468317999247", 
        ObservantOff = "rbxassetid://9125639499", 
        ObservantGeneratorStart = "rbxassetid://7112391013", 
        ObservantGeneratorEnd = "rbxassetid://106145041472451", 
        ObservantGeneratorLoop = "rbxassetid://99769633154277", 
        ObservantGeneratorWarning = "rbxassetid://115934615655183", 
        HallucinationScreamer = {
            "rbxassetid://95738748103805", 
            "rbxassetid://108264373333326", 
            "rbxassetid://71577922726140"
        }, 
        HallucinationCloneDeath = {
            "rbxassetid://6246626799", 
            "rbxassetid://101644004711755", 
            "rbxassetid://19003360641", 
            "rbxassetid://95385713829111"
        }, 
        HallucinationDispenserDeath = {
            "rbxassetid://18909603132"
        }, 
        Stunned = {
            Start = "rbxassetid://115332398454262", 
            End = "rbxassetid://113454045849271"
        }, 
        VoidstarEnable = "rbxassetid://106727013904874", 
        isSensitiveTerrorRadius = true, 
		TerrorRadiusThemes = {
			[80] = {
				["ID"] = "rbxassetid://109373934292378",
				["BPM"] = 169.333,
				["Volume"] = 0.75
			},
			[40] = {
				["ID"] = "rbxassetid://99302589554269",
				["BPM"] = 169.333,
				["Volume"] = 0.75
			},
			[20] = {
				["ID"] = "rbxassetid://79411100624492",
				["BPM"] = 169.333,
				["Volume"] = 0.75
			},
			[6] = {
				["ID"] = "rbxassetid://122860939809873",
				["BPM"] = 169.333,
				["Volume"] = 0.75,
				["Chase"] = true
			}
		},
        Introduction = "rbxassetid://102261382920667", 
        VictoryTheme = "rbxassetid://135361916861123"
    }, 
    Voicelines = {
        KillTwoTime = {
            "rbxassetid://103656172031780"
        }, 
        KillNoob = {
            "rbxassetid://126709864631697"
        }, 
        KillElliot = {
            "rbxassetid://132412345542058"
        }, 
        KillChance = {
            "rbxassetid://71577922726140", 
            "rbxassetid://91878831552537"
        }, 
        KillTaph = {
            "rbxassetid://96946385572611"
        }, 
        KillBuilderman = {
            "rbxassetid://133601470283097"
        }, 
        Kill007n7 = {
            "rbxassetid://100966549431630"
        }, 
        Kill = {
            "rbxassetid://110684813246558", 
            "rbxassetid://91228266003282", 
            "rbxassetid://109301111857562", 
            "rbxassetid://134916679174108"
        }, 
        LastManStanding = {
            "rbxassetid://131652936535098", 
            "rbxassetid://85221721762115"
        }, 
        VoidRushStart = {
            "rbxassetid://89355086113310", 
            "rbxassetid://70522191793442"
        }, 
        Teleport = {
            "rbxassetid://80760319411525"
        }, 
        Nova = {
            "rbxassetid://95524724737837"
        }, 
        Slam = {
            "rbxassetid://71357050276175", 
            "rbxassetid://88353435705314", 
            "rbxassetid://100165796681973", 
            "rbxassetid://89332702462626"
        }, 
        VoidRushMissTimeout = {
            "rbxassetid://102491594132079"
        }, 
        VoidRushMissCrashed = {
            "rbxassetid://122812329550651"
        }, 
        Stunned = {
            "rbxassetid://91017967178100", 
            "rbxassetid://132412345542058"
        }, 
        Wheel_Yes = {
            "rbxassetid://103787230519184"
        }, 
        Wheel_No = {
            "rbxassetid://110684813246558"
        }, 
        Wheel_Taunt = {
            "rbxassetid://91017967178100", 
            "rbxassetid://129484195219781", 
            "rbxassetid://103656172031780", 
            "rbxassetid://105079226220020"
        }, 
        Wheel_Rage = {
            "rbxassetid://110684813246558", 
            "rbxassetid://132412345542058", 
            "rbxassetid://91017967178100", 
            "rbxassetid://96946385572611"
        }, 
        Wheel_Laugh = {
            "rbxassetid://109301111857562", 
            "rbxassetid://91228266003282"
        }
    }
};
local l_AuraColors_0 = require(game.ReplicatedStorage.Modules.StatusEffects.KillerExclusive.Hallucination).AuraColors;
local function v10(v2, v3) --[[ Line: 403 ]] --[[ Name: schizoString ]]
    -- upvalues: l_AuraColors_0 (copy)
    if not v2 then
        return "<b>Hallucination</b>";
    else
        local v4 = l_AuraColors_0[math.clamp(v2, 1, #l_AuraColors_0)];
        local function _(v5) --[[ Line: 410 ]] --[[ Name: f ]]
            -- upvalues: v4 (copy)
            return (math.floor(v4[v5] * 255));
        end;
        local v7 = math.floor(v4.R * 255);
        local v8 = math.floor(v4.G * 255);
        local v9 = math.floor(v4.B * 255);
        return ("<b><font color=\"rgb(%%d, %%d, %%d)\">%*%*</font></b>"):format(v3 and "" or "Hallucination ", (string.rep("I", v2))):format(v7, v8, v9);
    end;
end;
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "Noli", 
        Text = "The all-powerful & ancient Noli has made his grand entrance into the realm. Wielding power which easily surpasses that of scripts and guis by the exploiters, Noli manipulates any and all those around him. For him, these games are nothing but a way for him to truly shine as the star of the show."
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v0.Health) .. ("Regular Speed: %*\n"):format(v0.Speed) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed) .. ("Max Stamina: %*\n"):format(v0.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain) .. "Terror Radius: 80 studs\n"
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "HALLUCINATIONS", 
        Quote = "O, that way madness lies.", 
        Text = ("Many of %*'s abilities will inflict %*.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", (v10())) .. ("Having any level of %* will reveal your aura to %* for its duration.\n"):format(v10(), "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("%* will also cause you to hallucinate. Effects will grow stronger as %* increases in level.\n"):format(v10(), (v10())) .. ("Being hit by %* will remove all stacks of %*\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", (v10())) .. ("%* maxes at %*.\n"):format(v10(), (v10(3))) .. ("At %*, a mirage of %* will manifest and start to attack you. <b>Do not look at it.</b>"):format(v10(3), "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
    }, 
    {
        Header = "PRANKSTER", 
        Quote = "Art ignorant of what thou art.", 
        Text = ("At the beginning of the round, %* will spawn Fake Generators in places where the real generators did not.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("If a survivor completes a Fake Generator puzzle, they will gain a stack of %*.\n"):format((v10())) .. ("Fully completing a Fake Generator will <b>instantly grant</b> %*.\n"):format((v10(3))) .. "Fake Generators have many tells to differentiate them from real generators. <b>Pay attention to sound and visuals.</b>"
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://130161235577806", 
        Header = "STAB", 
        Quote = "Our revels now are ended.", 
        Text = ("Cooldown: %*s\n"):format(v0.StabCooldown) .. ("Damage: %*\n"):format(v0.StabDamage) .. ("Windup: %*s\n"):format(v0.StabWindup) .. ("Linger: %*s\n"):format(v0.StabLinger) .. "Length: 7.5 studs\n" .. ("%* uses his Shadow Tendril to stab forwards.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
    }, 
    {
        Image = "rbxassetid://110747688363796", 
        Header = "VOID RUSH", 
        Quote = "Which pierces so that it assaults.", 
        Text = ("Cooldown: %*s\n"):format(v0.VoidRushC00ldown) .. ("Damage: %*\n"):format(v0.VoidRushBaseDamage) .. ("%* will prepare a rush for %* seconds. This preperation can be cancelled.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v0.VoidRushChargeLength) .. ("If a survivor is hit with the rush, they will gain <b>%*</b> for %* seconds. After %* seconds, %* can perform a re-rush.\n"):format(v10(2), v0.VoidRushHallucinationDuration, v0.VoidRushHitEndlag, "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("If a survivor with %* or above is hit with the rush, %* will slam them into the ground, dealing %* damage and ending the move. This slam will deal %* more damage for every re-rush you have performed.\n"):format(v10(2), "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v0.VoidRushSlamDamage, v0.VoidRushComboDamage) .. ("The rush will prematurely end if %* is stunned, crashes into a wall, doesn't hit a survivor in time, or lets go of the Void Rush key.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("Turn rate during the rush is heavily increased during the first %* seconds. \n"):format(v0.VoidRushInitialTurnDuration) .. ("%* can sprint during a re-rush to temporarily boost speed. \n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("%* is <b>unable to regenerate stamina</b> for the duration of the rush."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
    }, 
    {
        Image = "rbxassetid://70669903126039", 
        Header = "NOVA", 
        Quote = "Thou art inclined to sleep; \226\128\153tis a good dullness.", 
        Text = ("Cooldown: %*s\n"):format(v0.NovaCooldown) .. ("Damage: %*\n"):format(v0.NovaExplosionDamage) .. ("%* will throw his Voidstar forward after a %* second windup.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v0.NovaWindup) .. "If the Voidstar hits a survivor or a wall, it will implode and pull survivors inward.\n" .. ("%* can manually detonate the Voidstar by pressing the Nova button again, but this will significantly reduce the implosion's radius."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
    }, 
    {
        Image = "rbxassetid://86665948552323", 
        Header = "OBSERVANT", 
        Quote = "Mine enemies are all knit up In their distractions.", 
        Text = ("Cooldown: %*s\n"):format(v0.ObservantC00ldown) .. ("%* will enter a stance. All generators will be highlighted to him, and a mirage of him will display over the generators as a warning.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("%* can select a generator to teleport it after a %* windup.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v0.ObservantTeleportWindup) .. ("After teleporting, %* will inflict %* %*/%*/%* to all survivors more than %*/%*/%* studs away from the generator.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v10(), v10(1, true), v10(2, true), v10(3, true), v0.ObservantStatusThresholds[1], v0.ObservantStatusThresholds[2], v0.ObservantStatusThresholds[3]) .. ("Stunning %* during this windup or stance will cancel the move."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. "This ability starts on a halved cooldown at the beginning of the game.\n"
    }
};
return v0;