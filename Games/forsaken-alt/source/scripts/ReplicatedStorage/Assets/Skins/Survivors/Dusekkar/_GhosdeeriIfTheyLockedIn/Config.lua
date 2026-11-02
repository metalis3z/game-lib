-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "GhosdeeriIfTheyLockedIn", 
    Quote = "\"god i love this hat\"", 
    Credits = "kaiserdegurechaff", 
    Class = "Support", 
    RenderImage = "rbxassetid://130717225128406", 
    Price = 6000000, 
    Exclusive = true, 
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
    SpawnProtectionCooldown = 1, 
    SpawnProtectionSpeedReductionWhileInUse = 1, 
    SpawnProtectionSlownessData = {
        Level = 1, 
        Duration = 1
    }, 
    SpawnProtectionTimeUntilProtectableAgain = 1, 
    SpawnProtectionMaxPlayers = 3, 
    SpawnProtectionOverflowDebuffDuration = 2, 
    SpawnProtectionMaxDuration = 500, 
    SpawnProtectionTimeUntilBrokenByWallInterference = 10, 
    SpawnProtectionEffectMaxDistance = 2750, 
    SpawnProtectionScaleRadius = 0.4, 
    SpawnProtectionRadiusTemplate = script.MouseRadius, 
    SpawnProtectionIndicatorTemplate = script.Indicator, 
    PlasmaBeamCooldown = 1, 
    PlasmaBeamSpeedData = {
        Level = 10, 
        Duration = 4
    }, 
    PlasmaBeamSlownessData = {
        Level = 7, 
        Duration = 3
    }, 
    PlasmaBeamSpeedReductionWhileInUse = 0, 
    PlasmaBeamHitboxSize = 1500, 
    PlasmaBeamHitboxRange = 1500, 
    PlasmaBeamColor1 = Color3.fromRGB(0, 47, 255), 
    PlasmaBeamColor2 = Color3.fromRGB(0, 157, 255), 
    Animations = {
        Idle = "rbxassetid://104094087307928", 
        Walk = "rbxassetid://112711552067779", 
        Run = "rbxassetid://125869734469543", 
        InjuredIdle = "rbxassetid://139253834033097", 
        InjuredWalk = "rbxassetid://134622311631902", 
        InjuredRun = "rbxassetid://104349260778710", 
        StaffShot = "rbxassetid://99212613557105", 
        StaffStartup = "rbxassetid://119427796365822", 
        StaffLoop = "rbxassetid://138476918502034"
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
                "I NEED Health elliot."
            }, 
            BuildermanSentry = {
                "I NEED Sentries builderman."
            }, 
            BuildermanDispenser = {
                "I NEED Dispeners builderman."
            }, 
            DusekkarProtection = {
                "I NEED Shields dusekkar."
            }
        }, 
        Thanks = {
            Regular = {
                "my goat"
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