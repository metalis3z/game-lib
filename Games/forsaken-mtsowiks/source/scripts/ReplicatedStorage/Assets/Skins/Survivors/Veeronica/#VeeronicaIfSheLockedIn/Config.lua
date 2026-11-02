-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:59 2025 ]]
local v0 = {
    DisplayName = "Veeronica", 
    Quote = "SKATTINNGGGGGGG", 
    Credits = "Maus4lia, Agrovient, ffPrankster, voxov_tired", 
    Class = "Survivalist", 
    RenderImage = "rbxassetid://108549015865130", 
    Price = 750, 
    Exclusive = true, 
    NotReplicated = false, 
    Health = 100, 
    Speed = 12, 
    TVScreenSpeed = 1, 
    TVScreenInterpolationTime = 2, 
    VandalismCooldown = 0.65, 
    VandalismPostCooldown = 15, 
    VandalismPreset = script.Vandalism_PRESET, 
    VandalismSprayBeam = script.SprayBeam_PRESET, 
    VandalismDistanceCheck = 10, 
    VandalismHealth = 5, 
    VandalismSprayDrain = 0, 
    VandalismSprayDistance = 150, 
    VandalismSprayWait = 0.35, 
    VandalismSprayAnchorTime = 6.3, 
    VandalismSprayOffset = 0.025, 
    VandalismSprayImages = {
        "rbxassetid://73782115919441", 
        "rbxassetid://131590876829922", 
        "rbxassetid://136154888235055", 
        "rbxassetid://81977797734418", 
        "rbxassetid://83241802024833", 
        "rbxassetid://80625367785567", 
        "rbxassetid://136253618010857", 
        "rbxassetid://114566772220660", 
        "rbxassetid://114208341643680", 
        "rbxassetid://109500406786628", 
        "rbxassetid://95744668143682", 
        "rbxassetid://126965984054565", 
        "rbxassetid://94795583765109", 
        "rbxassetid://110291822474947", 
        "rbxassetid://86760468781244", 
        "rbxassetid://108528126969003"
    }, 
    VandalismRareSprayImages = {
        "rbxassetid://302666936", 
        "rbxassetid://5641193985", 
        "rbxassetid://107525379854621", 
        "rbxassetid://13443001858", 
        "rbxassetid://6799068822", 
        "rbxassetid://83450503791840", 
        "rbxassetid://124800105503230"
    }, 
    VandalismZoneVisual = script.ZonePole, 
    VandalismSprayIndicationColors = {
        IN = Color3.fromRGB(13, 255, 0), 
        OUT = Color3.fromRGB(255, 46, 46)
    }, 
    Sk8CD = 0.5, 
    Sk8Speed = 1.2, 
    Sk8SpeedExhaust = 1.15, 
    Sk8StaminaLossOut = 0.5, 
    Sk8StaminaLoss = 0.25, 
    Sk8TurnControl = 0.8, 
    Sk8BonkDamage = 5, 
    Sk8BonkStatuses = {
        Slowness = {
            Level = 4, 
            Duration = 2.5
        }
    }, 
    Sk8TrickTurnControl = 67, 
    Sk8TrickAirborneSpeed = 2, 
    Sk8TrickPower = 90, 
    Sk8TrickJump = 0.45, 
    Sk8TrickGravity = 0.38, 
    Sk8TrickCooldown = 0.01, 
    Sk8TrickStamina = 20, 
    Sk8TrickHighlightData = {
        TrickReady = {
            FillTransparency = 0.55, 
            FillColor = Color3.fromRGB(241, 85, 255), 
            OutlineTransparency = 0.5, 
            OutlineColor = Color3.fromRGB(255, 104, 252)
        }, 
        TrickCooldownFlash = {
            FillTransparency = 0.4, 
            FillColor = Color3.fromRGB(248, 206, 255), 
            OutlineTransparency = 0.2, 
            OutlineColor = Color3.fromRGB(248, 170, 255)
        }, 
        TrickCooldownDecay = {
            FillTransparency = 0.4, 
            FillColor = Color3.fromRGB(134, 40, 132), 
            OutlineTransparency = 0.25, 
            OutlineColor = Color3.fromRGB(83, 49, 85)
        }, 
        TrickCooldownFail = {
            FillTransparency = 0.5, 
            FillColor = Color3.fromRGB(255, 67, 70), 
            OutlineTransparency = 0.25, 
            OutlineColor = Color3.fromRGB(255, 0, 0)
        }
    }, 
    Sk8PhaseReboundDamage = 5, 
    Sk8PhaseUses = 1, 
    Sk8PhaseTime = 0.5, 
    Sk8PhaseStatuses = {
        Resistance = {
            Duration = 3, 
            Level = 2
        }, 
        Speed = {
            Duration = 1, 
            Level = 4
        }
    }, 
    Sk8PhaseChargedStatuses = {
        Resistance = {
            Duration = 3, 
            Level = 4
        }, 
        Speed = {
            Duration = 1, 
            Level = 4
        }
    }, 
    Sk8BumpDamage = 5, 
    Sk8BumpPower = 10, 
    Sk8BumpBattery = 15, 
    Sk8BumpStatuses = {
        Slowness = {
            Level = 2, 
            Duration = 3
        }
    }, 
    Sk8BumpChargedDamage = 15, 
    Sk8BumpChargedPower = 15, 
    Sk8BumpChargedBattery = 15, 
    Sk8BumpChargedStatuses = {
        Slowness = {
            Level = 1, 
            Duration = 2
        }
    }, 
    Sk8TonyStamina = 0, 
    Sk8TonyTurnDuration = 1, 
    Sk8TonyChargedTurnDuration = 2, 
    Sk8TonyChargedStamina = 0, 
    Sk8TonyBonkDamage = 15, 
    BroadcastTypeData = {
        [1] = {
            Name = "[Phase]", 
            Icon = "rbxassetid://99218231350350"
        }, 
        [2] = {
            Name = "[Bumper]", 
            Icon = "rbxassetid://115049033276951"
        }, 
        [3] = {
            Name = "[Mobile]", 
            Icon = "rbxassetid://70948225384237"
        }
    }, 
    ActivateBatteryCooldown = 55, 
    BatteryRechargeRate = 1.5, 
    BatteryUITemplate = script.BatteryUI_PRESET, 
    BatteryGeneratorCharge = 5, 
    Sk8UITemplate = script.SkateUI_PRESET, 
    S8EffectsTemplate = script.S8VFX, 
    Expressions = {
        Happy = "rbxassetid://122882514249818", 
        Default = "rbxassetid://73908351202687", 
        Hurt = "rbxassetid://102932408723202", 
        Injured = "rbxassetid://88469391773512", 
        Dead = "rbxassetid://1179108573", 
        Drinking = "rbxassetid://78573485331724"
    }, 
    Animations = {
        Idle = "rbxassetid://118046260829399", 
        BroadcastSwitch = "rbxassetid://71348269591184", 
        CanTakeout = "rbxassetid://92821021022136", 
        CanIdle = "rbxassetid://75244451733228", 
        CanSpray = "rbxassetid://134397909857375", 
        CanWipe = "rbxassetid://103311019661591", 
        Sk8Start = "rbxassetid://105436524190821", 
        Sk8Skating = "rbxassetid://93372328203594", 
        Sk8Speedup = "rbxassetid://72672458293891", 
        Sk8Trick1 = "rbxassetid://81113903767127", 
        Sk8Trick2 = "rbxassetid://104564482616085", 
        Sk8TrickLand = "rbxassetid://130378526027609"
    }, 
    Sounds = {
        ChannelSwitch = "rbxassetid://97554827250708", 
        VandalismEquip = "rbxassetid://9119523840", 
        VandalismInterrupted = "rbxassetid://105726690559537", 
        VandalismSpray = "rbxassetid://9119525650", 
        VandalismWipe = "rbxassetid://139229941035255", 
        VandalismZoneCreated = "rbxassetid://2499538809", 
        VandalismZoneDestroyed = "rbxassetid://154146535", 
        VandalismDenied = "rbxassetid://550209561", 
        SprayProgression = "rbxassetid://9067256917", 
        SprayWiping = "rbxassetid://5347824216", 
        SprayDestroyed = "rbxassetid://9117624545", 
        SprayCompleted = "rbxassetid://6684542570", 
        Sk8Start = "rbxassetid://9119183335", 
        Sk8Loop = {
            SoundId = "rbxassetid://139684281021591", 
            PlaybackSpeed = 0.09
        }, 
        Sk8Stop = "rbxassetid://8317474498", 
        Sk8Trick = "rbxassetid://6380285152", 
        Sk8Bump = "rbxassetid://8899349982", 
        Sk8Bonk = "rbxassetid://18716317515", 
        Sk8Phase = "rbxassetid://74077625892520", 
        Sk8Rebound = "rbxassetid://127696107334782", 
        Sk8CooldownFail = "rbxassetid://118668067149378", 
        Sk8CooldownFlash = "rbxassetid://993959716", 
        Sk8CooldownReady = "rbxassetid://123591869173944", 
        BatteryStart = "rbxassetid://126468398066211", 
        BatteryLoop = "rbxassetid://125491655137359", 
        BatteryDischarged = "rbxassetid://9061162181", 
        BatteryFinished = "rbxassetid://5857614116", 
        BatteryInterrupted = "rbxassetid://9120985853", 
        ActivateBatteryFailure = "rbxassetid://9118491909"
    }, 
    KillEffects = {
        Veeronica = true
    }, 
    Voicelines = {
        Died = {
            "rbxassetid://17871250897"
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "VEERONICA", 
        Text = "sk8r girl"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "ROBOTIC", 
        Quote = "roger roger", 
        Text = "Veeronica cannot use standard healing items like Medkits or Elliot's Pizza.\n" .. "Instead, Veeronica has a rechargeable battery that she can use to heal herself, up to 50 HP at 100% charge.\n" .. "Veeronica will begin the round with 70% of her Battery charged.\n" .. ("Completing Generator puzzles will fill %*%% of her Battery."):format(v0.BatteryGeneratorCharge)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Header = "VANDALISM", 
        Quote = "HEY! *whistle*", 
        Text = "Veeronica will equip/unequip her spray paint, at which point she can spray Graffiti onto a wall by left clicking and holding.\n" .. "Veeronica is able to destroy her own Graffiti by holding [Space] and holding near her Graffiti with her can out.\n" .. ("Graffiti can be placed a maximum of %* studs away from eachother.\n"):format(v0.VandalismSprayDistance) .. "Graffiti have 5 health and can be destroyed by the Killer.\n" .. "Once three Graffiti are placed, a Zone will appear.\n" .. "While Veeronica is in this Zone:\n" .. " * She is able to use Sk8\n" .. " * Sk8 uses much less stamina\n" .. " * Broadcast abilities are amplified\n" .. "Additionally, her Battery will gain charge while the Killer is inside this zone.\n" .. ("If any of her Graffiti are destroyed while a Zone is active, the Zone will immediately disappear and this move will go on cooldown for %*s."):format(v0.VandalismPostCooldown)
    }, 
    {
        Header = "SK8", 
        Quote = "subway surfers gameplay in the corner", 
        Text = ("Cooldown: %*s\n"):format(v0.Sk8CD) .. "Can only be used when inside a Graffiti Zone.\n" .. "Veeronica begins skating at 1.15x her running speed, while using 0.85/1.15x her stamina while inside/outside the Zone.\n" .. "While skating, Veeronica has extremely limited turn control.\n" .. ("Upon crashing into a wall or the Killer, Veeronica will take %* self-damage and <b>Slowness IV</b> for 2.5s.\n"):format(v0.Sk8BonkDamage) .. "Veeronica can stop skating at any time by recasting the ability.\n" .. "If Veeronica runs out of Stamina, <b>Sk8 will end immediately.</b>"
    }, 
    {
        Header = "SK8 - TRICK", 
        Quote = "NO WAY....", 
        Text = ("Cooldown: %*s\n"):format(v0.Sk8TrickCooldown) .. "When approaching a collidable surface, Veeronica will glow and can perform a Trick with Spacebar to rebound off of it!\n" .. ("Doing this grants her full air control while airborne, as well as %* Stamina and a speed boost while in the air.\n"):format(v0.Sk8TrickStamina) .. "Attempting to Trick on nothing will still place Trick on cooldown."
    }, 
    {
        Header = "BROADCAST", 
        Quote = "subway surfers gameplay in the corner", 
        Text = "Cooldown: 1s\n" .. "Switches between 3 channels, which affect the behavior of Sk8:\n" .. " \t\t <b>Phase</b>\n" .. "   - Upon colliding with a Killer, gain <b>Resistance II</b> for 3s and <b>Speed IV</b> for 1s and phase through them.\n" .. "   - If Veeronica is inside her Zone when she phases through a Killer, the <b>Resistance</b> level will be increased to <b>IV</b>.\n" .. "   - This effect can only be used once per Sk8.\n" .. ("\t- Additionally, Veeronica will rebound off walls that she collides with instead of crashing into them, though this will still deal %* self-damage.\n"):format(v0.Sk8PhaseReboundDamage) .. " \t\t <b>Bumper</b>\n" .. ("   - Upon crashing into a Killer, Veeronica will knock them back, and charge her Battery by %*%%.\n"):format(v0.Sk8BumpBattery) .. "   - Crashing into a Killer this way will deal no self damage, but will still inflict Veeronica with <b>Slowness II</b> for 3s.\n" .. "   - If Veeronica is inside her Zone, knockback power will be increased by 50% and <b>Slowness</b> on crash decreased to <b>I</b> for 2s.\n" .. "   - Sk8 will immediately end once Veeronica crashes into a Killer." .. "\t\t <b>Mobile</b>\n" .. "   - Trick's increased turn control lingers for 1s after landing.\n" .. "   - If Veeronica is inside her Zone, turn control lingers for 2s.\n" .. "\t- Veeronica will take <b>3x</b> more self damage from crashing while on this channel.\n" .. "These effects <b>cannot</b> be switched through during Sk8."
    }, 
    {
        Header = "ACTIVATE BATTERY", 
        Quote = "oktoberfest", 
        Text = ("Cooldown: %*s\n"):format(v0.ActivateBatteryCooldown) .. "Veeronica begins slowly healing herself with her Battery.\n" .. "Healing will stop if maximum health is reached, Battery charge runs out, or Veeronica takes damage."
    }
};
return v0;