-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Dusekkar", 
    Quote = "\"Destiny's powerful hand has made the bed of my future, and it's up to me to lie in it.\"", 
    Credits = "", 
    Class = "Support", 
    RenderImage = "rbxassetid://85126349683293", 
    Price = 600, 
    Requests = {
        DusekkarProtection = {
            AbilityName = "SpawnProtection", 
            RequestTitle = "Request Forcefield", 
            NotificationTitle = "PLAYERNAME wants a force field!", 
            Order = 1
        }
    }, 
    Speed = 12, 
    Health = 90, 
    WarningTemplate = script.Warning, 
    VFXTemplate = script.VFX, 
    SpawnProtectionCooldown = 35, 
    SpawnProtectionSpeedReductionWhileInUse = 75, 
    SpawnProtectionSlownessData = {
        Level = 1, 
        Duration = 8
    }, 
    SpawnProtectionTimeUntilProtectableAgain = 20, 
    SpawnProtectionMaxPlayers = 3, 
    SpawnProtectionOverflowDebuffDuration = 7, 
    SpawnProtectionMaxDuration = 10, 
    SpawnProtectionTimeUntilBrokenByWallInterference = 2, 
    SpawnProtectionEffectMaxDistance = 275, 
    SpawnProtectionScaleRadius = 0.4, 
    SpawnProtectionRadiusTemplate = script.MouseRadius, 
    SpawnProtectionIndicatorTemplate = script.Indicator, 
    PlasmaBeamCooldown = 20, 
    PlasmaBeamSpeedData = {
        Level = 1, 
        Duration = 4
    }, 
    PlasmaBeamSlownessData = {
        Level = 2, 
        Duration = 3
    }, 
    PlasmaBeamSpeedReductionWhileInUse = 85, 
    PlasmaBeamHitboxSize = 1.5, 
    PlasmaBeamHitboxRange = 150, 
    PlasmaBeamColor1 = Color3.fromRGB(0, 47, 255), 
    PlasmaBeamColor2 = Color3.fromRGB(0, 157, 255), 
    Animations = {
		Idle = "rbxassetid://100175715870007", 
		Walk = "rbxassetid://98373605607558", 
		Run = "rbxassetid://127709225553169", 
		InjuredIdle = "rbxassetid://130959974982479", 
		InjuredWalk = "rbxassetid://96318170034869", 
		InjuredRun = "rbxassetid://97549479350385", 
		StaffShot = "rbxassetid://89012386511118", 
		StaffStartup = "rbxassetid://124803372245574", 
		StaffLoop = "rbxassetid://113663308294164"
    }, 
    Sounds = {
        SpawnProtectionActivate = "rbxassetid://88967578065672", 
        SpawnProtectionLoop = "rbxassetid://121942568988816", 
        SpawnProtectionShieldBreak = "rbxassetid://72368725251506", 
        PlasmaBeamShoot = "rbxassetid://91174954264731"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "Hand me a slice, and make it fast, for I don\226\128\153t know how long I\226\128\153ll last.", 
                "I could help the others in a flick, but first I need pizza; make it quick.", 
                "My power\226\128\153s drained and my soul feels weak; pass me a slice so things won\226\128\153t seem bleak.", 
                "Thunder and lightning, northwinds blow! A slice of your pizza, go, go, go!", 
                "My body aches, my arms are in pain; hand me a slice, so I may work again."
            }, 
            BuildermanSentry = {
                "The path ahead will be tough. Place a sentry, here in the rough.", 
                "The killer\226\128\153s games are on display. A sentry here, then we get away.", 
                "A monster\226\128\153s presence is lurking near. Build a sentry, right over here.", 
                "All the materials are right in your hands. Build it quick, so we may escape these lands.", 
                "Your machines are strong, and built to last. Place one quick, and do it fast."
            }, 
            BuildermanDispenser = {
                "The others are wounded, that I can tell. Place a dispenser, and let's survive this hell.", 
                "My power is weakened, my health is drained. Build a dispenser & spare me from pain.", 
                "The killer is strong, we're all in pain; make a dispenser & fix us up again.", 
                "Our group's forces together are not enough. Build a dispenser, and make it tough.", 
                "A healing dispenser made of your average materials\226\128\166 that could surprise anyone, even ethereals."
            }, 
            DusekkarProtection = {
                "Your magic is needed upon this day. Cast your spell upon my say.", 
                "A magic touch should keep me at ease. Could you cast the spell for me, please?", 
                "Spells like force fields are just your fort\195\168. Cast it on me, and let's be on our way.", 
                "Magic is strong, so you must be wise; do it wrong or it may spell your demise.", 
                "You\226\128\153d be wise to protect another. But I still must ask, if it's not a bother."
            }
        }, 
        Thanks = {
            Regular = {
                "May the hope of others be your guide, for you have stayed true to my side.", 
                "You listened well, that much is true. I'd like to offer my thanks to you.", 
                "I'm ever grateful for the work you do. Someday, I may return the favor, too.", 
                "You\226\128\153ve heeded the demands that I've requested. Surely, now, we will not be bested.", 
                "With all the words that I could possibly use, it could not equate to the thanks I owe you."
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "DUSEKKAR", 
        Text = "pumpkn guy (:"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "LEVITATION", 
        Quote = "\"The cursed spirit is doomed to walk the Earth until it has hunted it's hunter.\" - Ghosdeeri", 
        Text = ("%* levitates naturally, meaning that they don't make footstep sounds.\n"):format("Dusekkar")
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Header = "SPAWN PROTECTION", 
        Image = "rbxassetid://136501603087283", 
        Quote = "\"Let be be finale of seem, seems to me.\" - Darkseed", 
        Text = ("Cooldown: %*s\n"):format(v0.SpawnProtectionCooldown) .. ("%* casts upon his magic to create a shield around a Survivor of their choice for up to %*s.\n"):format("Dusekkar", v0.SpawnProtectionMaxDuration) .. ("%* has their movement speed reduced by %*%% and cannot sprint while protecting a Survivor.\n"):format("Dusekkar", v0.SpawnProtectionSpeedReductionWhileInUse) .. ("This ability has a range of %* studs.\n"):format(v0.SpawnProtectionEffectMaxDistance) .. ("The protected Survivor receives <b>Resistance IV</b> for as long as they're protected, however, the <b>Resistance</b> decreases by a level for every other Survivor that's currently being protected by another %*.\n"):format("Dusekkar") .. ("If there is to ever be a point where %* %*s are all protecting Survivors at once, then all of their shields break and they all get inflicted with <b>Blindness III</b> and <b>Slowness III</b> for %*s.\n"):format(v0.SpawnProtectionMaxPlayers, "Dusekkar", v0.SpawnProtectionOverflowDebuffDuration) .. ("Survivors who receive protection cannot be protected again until %*s pass from since they were last protected.\n"):format(v0.SpawnProtectionTimeUntilProtectableAgain)
    }, 
    {
        Header = "PLASMA BEAM", 
        Image = "rbxassetid://83030778673034", 
        Quote = "\"And you don't fight destiny.\" - the guy from the movie", 
        Text = ("Cooldown: %*s\n"):format(v0.PlasmaBeamCooldown) .. ("%* channels his powers to shoot out a beam of plasma energy at either a Survivor or the Killer.\n"):format("Dusekkar") .. ("This ability has a range of %* studs and can only hit one player at a time.\n"):format(v0.PlasmaBeamHitboxRange) .. ("Hitting a Survivor with this ability inflicts them with <b>Speed I</b> for %*s.\n"):format(v0.PlasmaBeamSpeedData.Duration) .. ("Hitting a Killer with this ability inflicts them with <b>Slowness II</b> for %*s. The duration is lowered by 0.5s for every other %* that's alive. If the <b>Slowness</b> duration is less than or equal to 0.5s, then nothing happens.\n"):format(v0.PlasmaBeamSlownessData.Duration, "Dusekkar")
    }
};
return v0;