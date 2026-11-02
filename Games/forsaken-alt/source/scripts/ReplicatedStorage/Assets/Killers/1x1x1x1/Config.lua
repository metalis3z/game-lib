-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_select_0 = select;
local function v6(v1, v2, ...)
    local v3, v4 = {
        ...
    }, l_select_0("#", ...);
    for v5 = v2, v2 + v4 - 1 do
        v1[v5] = v3[v5 - v2 + 1];
    end;
end;
local v7 = {
    DisplayName = "1x1x1x1", 
    Quote = "\"Then, in a footnote, <font color=\"rgb(200,200,0)\">he</font> mentions the evil 1x1x1x1.\"", 
    Credits = "By: AndrewDotWeb & nickelj", 
    RenderImage = "rbxassetid://129384396545278", 
    Price = 1250, 
    Health = 1100, 
    Speed = 8, 
    HighlightDisabled = false, 
    HighlightProperties = {
        FillColor = Color3.fromRGB(74, 74, 74), 
        OutlineColor = Color3.new(), 
        FillTransparency = 15, 
        OutlineTransparency = 0.95
    }, 
    SprintSpeed = 27, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = 110, 
    Relations = {
        "Shedletsky"
    }, 
    LastManStandingEmotionalData = {
        ThemeID = "rbxassetid://115884097233860", 
        ThemeProperties = {
            Volume = 0.5
        }, 
        RoundTime = 91
    }, 
    IntroLighting = script.IntroLighting, 
    IntroHeadTemplate = script.ShedletskyHead, 
    SlashDamage = 20, 
    SlashPoisonLevel = 1, 
    SlashPoisonDuration = 5, 
    SlashGlitchLevel = 1, 
    SlashGlitchDuration = 5, 
    SlashCooldown = 1.75, 
    MassInfectionCooldown = 14, 
    MassInfectionSlashDamage = 5, 
    MassInfectionSlashPoisonLevel = 5, 
    MassInfectionSlashPoisonDuration = 3, 
    MassInfectionSlashGlitchLevel = 2, 
    MassInfectionSlashGlitchDuration = 6, 
    MassInfectionShockwaveSpeed = 115, 
    MassInfectionShockwaveLifetime = 6, 
    MassInfectionShockwaveDamage = 35, 
    MassInfectionShockwavePoisonLevel = 1, 
    MassInfectionShockwavePoisonDuration = 5, 
    MassInfectionShockwaveGlitchLevel = 1, 
    MassInfectionShockwaveGlitchDuration = 5, 
    MassInfectionShockwaveAuraDuration = 2, 
    ShockwaveTemplate = script.Shockwave, 
    EntanglementCooldown = 18, 
    EntanglementSpeed = 125, 
    EntanglementLifetime = 10, 
    EntanglementDamage = 10, 
    EntanglementPoisonLevel = 2, 
    EntanglementPoisonDuration = 16, 
    EntanglementGlitchLevel = 3, 
    EntanglementGlitchDuration = 16, 
    EntanglementHelplessDuration = 10, 
    EntanglementAuraDuration = 2, 
    EntanglementSurvivorSpeedBuffDuration = 1.25, 
    EntanglementKillerSpeedBuffDuration = 3, 
    EntanglementPopupCount = 5, 
    SwordsTemplate = script.Swords, 
    PopupsFolder = script.Popups, 
    UnstableEyeCooldown = 25, 
    UnstableEyeBuffDuration = 6.5, 
    UnstableEyeDebuffDuration = 6.5, 
    UnstableEyeAuraDuration = 5, 
    RejuvenateTheRottenCooldown = 200, 
    ZombieHealth = 10, 
    ZombieWalkSpeed = 6, 
    ZombieSprintSpeed = 17.5, 
    ZombieAttackCooldown = 3, 
    ZombieAttackDamage = 14, 
    ZombieAttackRange = 5, 
    ZombieTargetRange = 30, 
    ZombieLoseFocusRange = 50, 
    ZombieKillSpeedLevel = 1, 
    ZombieKillSpeedDuration = 10, 
    ZombieTemplate = script.Zombie, 
    ZombieAnimations = {
        Idle = "rbxassetid://138465378316476", 
		Walk = "rbxassetid://114153579782630", 
		Run = "rbxassetid://118072658021841", 
		Attack = "rbxassetid://114337646764233", 
		Summon = "rbxassetid://114662443629416"
    }, 
    Animations = {
		Idle = "rbxassetid://86294163359670", 
		Walk = "rbxassetid://98631829280602", 
		Run = "rbxassetid://93417980054566", 
        Introduction = {
			KillerRig = "rbxassetid://137144583408740", 
			CameraRig = "rbxassetid://95418820313439"
        }, 
        Execution = {
			KillerRig = "rbxassetid://73637499092984", 
			PlayerRig = "rbxassetid://108253026512238"
        }, 
        BetterIdle = "rbxassetid://70823883582359", 
        BetterWalk = "rbxassetid://116474342285522", 
        BetterRun = "rbxassetid://75730348460206", 
		Slash = "rbxassetid://101505460496245", 
		Entanglement = "rbxassetid://116912975214569", 
		UnstableEye = "rbxassetid://129304317884261", 
		RejuvenateTheRotten = "rbxassetid://77836298359505", 
		MassInfection = "rbxassetid://137875696725804", 
        Stunned = {
			Start = "rbxassetid://128627596267573", 
			Loop = "rbxassetid://90001112823422", 
			End = "rbxassetid://127179096788385"
        }, 
        Victory = {
            KillerRig = "rbxassetid://109540233754090", 
            KillerRigLoop = "rbxassetid://114865517078252", 
            CameraRig = "rbxassetid://87964518952080"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://75457135715759", 
            "rbxassetid://95246424997069"
        }, 
        Stunned = "rbxassetid://102398799721605", 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://139957641994343", 
                BPM = 81
            }, 
            [40] = {
                ID = "rbxassetid://107607873139123", 
                BPM = 81
            }, 
            [20] = {
                ID = "rbxassetid://105551772469406", 
                BPM = 81
            }, 
            [6] = {
                ID = "rbxassetid://97690757653206", 
                BPM = 81, 
                Chase = true
            }
        }, 
        EntanglementActivate = "rbxassetid://128711903717226", 
        UnstableEyeActivate = "rbxassetid://128439277996285", 
        UnstableEyeMode = "rbxassetid://134037097890097", 
        RejuvenateTheRottenActivate = "rbxassetid://128226726836653", 
        MassInfectionActivate = "rbxassetid://79782181585087", 
        Chains = "rbxassetid://84279430446111", 
        Swing = "rbxassetid://101199185291628", 
        Hit = "rbxassetid://89828271975845", 
        Introduction = "rbxassetid://97851287933867"
    }
};
local function _(v8) --[[ Line: 197 ]] --[[ Name: statusLvl ]]
    return require(game.ReplicatedStorage.Modules.Util):IntToRoman(v8);
end;
local v10 = {};
local v11 = {
    Separator = "GENERAL INFO"
};
local v12 = {
    Header = "1x1x1x1", 
    Text = "The physical manifeststion of pure malice, hatred, and negativity himself; the one who despises no one else more than the former admin, Shedletsky. With the daemonshank in his hands, he can summon beings of rot from the deceased, as well as target survivors from afar, poisoning them in the process.\n"
};
local v13 = {
    Header = "STATS", 
    Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v7.Health) .. ("Regular Speed: %*\n"):format(v7.Speed) .. ("Sprinting Speed: %*\n"):format(v7.SprintSpeed) .. ("Max Stamina: %*\n"):format(v7.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v7.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v7.StaminaGain)
};
local v14 = {
    Separator = "PASSIVES"
};
local v15 = {
    Header = "PARASITIC", 
    Quote = "\"Keep the link to this forum. Distribute it. Tell people the truth.\" - Roblox Admin", 
    Text = ("Every attack that %* has inflicts <b>Glitched</b> and <b>Poisoned</b> to some degree.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
};
local v16 = {
    Separator = "ABILITIES"
};
local v17 = {
    Header = "SLASH", 
    Quote = "\"Turns out they fixed nothing but the floating plates and jump pads, and the exploits in this game are insane.\" - Concerned SFOTH Player"
};
local v18 = ("Cooldown: %*s\n"):format(v7.SlashCooldown);
local v19 = ("Damage: %*\n"):format(v7.SlashDamage);
local v20 = ("%* swings his sword infront of him.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>");
local v21 = "Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s.\n";
local l_SlashGlitchLevel_0 = v7.SlashGlitchLevel;
local v23 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_SlashGlitchLevel_0);
l_SlashGlitchLevel_0 = v7.SlashGlitchDuration;
local l_SlashPoisonLevel_0 = v7.SlashPoisonLevel;
v17.Text = v18 .. v19 .. v20 .. v21:format(v23, l_SlashGlitchLevel_0, require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_SlashPoisonLevel_0), v7.SlashPoisonDuration);
local v25 = {
    Header = "MASS INFECTION", 
    Quote = "\"Blame \226\150\136\226\150\136\226\150\136\226\150\136.\" - Roblox Admin"
};
v19 = ("Cooldown: %*s\n"):format(v7.MassInfectionCooldown);
v20 = ("Damage: %*\n"):format(v7.MassInfectionShockwaveDamage);
local v26 = ("Projectile Lifetime: %*\n"):format(v7.MassInfectionShockwaveLifetime);
v21 = ("Following a windup of 1.7s, %* takes his two swords and performs a horizontal split with them, creating a sharp shockwave that deals damage to those it hits.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>");
local v27 = "Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s if %* hits a player up close.\n";
local l_MassInfectionSlashGlitchLevel_0 = v7.MassInfectionSlashGlitchLevel;
local v29 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_MassInfectionSlashGlitchLevel_0);
l_MassInfectionSlashGlitchLevel_0 = v7.MassInfectionSlashGlitchDuration;
local l_MassInfectionSlashPoisonLevel_0 = v7.MassInfectionSlashPoisonLevel;
local v31 = v27:format(v29, l_MassInfectionSlashGlitchLevel_0, require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_MassInfectionSlashPoisonLevel_0), v7.MassInfectionSlashPoisonDuration, "<font color=\"rgb(50,225,50)\">1x1x1x1</font>");
v27 = "Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s if %* hits a player with the created shockwave.\n";
l_MassInfectionSlashGlitchLevel_0 = v7.MassInfectionShockwaveGlitchLevel;
v29 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_MassInfectionSlashGlitchLevel_0);
l_MassInfectionSlashGlitchLevel_0 = v7.MassInfectionShockwaveGlitchDuration;
l_MassInfectionSlashPoisonLevel_0 = v7.MassInfectionShockwavePoisonLevel;
v25.Text = v19 .. v20 .. v26 .. v21 .. v31 .. v27:format(v29, l_MassInfectionSlashGlitchLevel_0, require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_MassInfectionSlashPoisonLevel_0), v7.MassInfectionShockwavePoisonDuration, "<font color=\"rgb(50,225,50)\">1x1x1x1</font>") .. ("<b>It should be noted that the windup of this attack can be heard by all players within a 400 stud radius of %*.</b>\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>");
v18 = {
    Header = "ENTANGLEMENT", 
    Quote = "\"I joined him in Crossroads, and it started raining heads saying things along the lines of \"He's coming back!\" and \"1x1x1x1 is coming for you!\" and the likes.\" - Roblox Admin", 
    Text = ("Cooldown: %*s\n"):format(v7.EntanglementCooldown) .. ("Damage: %*\n"):format(v7.EntanglementDamage) .. ("Projectile Lifetime: %*\n"):format(v7.EntanglementLifetime) .. ("Following a windup of 0.75s, %* throws his two swords forwards at a speed of %* studs per second.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>", v7.EntanglementSpeed) .. ("If it hits a survivor, then %* gains <b>Speed II</b> for %*s, the hit survivor has their aura revealed to the killer for %*s, gains <b>Helpless I</b> for %*s, and gains <b>Slowness X</b>. The survivor is required to do a 'minigame' to have their <b>Slowness X</b> removed.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>", v7.EntanglementKillerSpeedBuffDuration, v7.EntanglementAuraDuration, v7.EntanglementHelplessDuration) .. ("The minigame requires the survivor to click on %* pop ups on their screen to free themselves.\n"):format(v7.EntanglementPopupCount) .. ("After a survivor escapes <b>ENTANGLEMENT</b>, they gain <b>Speed I</b> for %*s.\n"):format(v7.EntanglementSurvivorSpeedBuffDuration)
};
v19 = {
    Header = "UNSTABLE EYE", 
    Quote = "<b>\"I see you.\"</b>", 
    Text = ("Cooldown: %*s\n"):format(v7.UnstableEyeCooldown) .. ("%* digs into his glaring red eye and tears at it, inflicting himself with multiple buffs & debuffs afterwards.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>") .. ("Reveals the auras of all living players to you and applies <b>Speed I</b> for %*s while also applying <b>Blindness III</b> for %*s.\n"):format(v7.UnstableEyeBuffDuration, v7.UnstableEyeDebuffDuration)
};
v20 = {
    Header = "REJUVENATE THE ROTTEN", 
    Quote = "\"He sent me a message, telling me he had something to demonstrate.\" - Roblox Admin"
};
v21 = ("Cooldown: %*s\n"):format(v7.RejuvenateTheRottenCooldown);
v31 = ("%* forces his swords into himself and pulls them out, resurrecting any players that he killed in the form of rotten zombies that serve him.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>");
v23 = ("Summoned zombies wander aimlessly upon spawning and target players that are within a %* stud distance from them. They lose focus on their target if the distance between them & the target exceeds a distance of %* studs.\n"):format(v7.ZombieTargetRange, v7.ZombieLoseFocusRange);
l_SlashGlitchLevel_0 = ("Summoned zombies have %* Health and deal %* damage to players.\n"):format(v7.ZombieHealth, v7.ZombieAttackDamage);
v29 = "Although the zombies are loyal to %*, %* can kill them to gain <b>Speed %*</b> for %*s.\n";
local v32 = "<font color=\"rgb(50,225,50)\">1x1x1x1</font>";
l_MassInfectionSlashPoisonLevel_0 = "<font color=\"rgb(50,225,50)\">1x1x1x1</font>";
local l_ZombieKillSpeedLevel_0 = v7.ZombieKillSpeedLevel;
v20.Text = v21 .. v31 .. v23 .. l_SlashGlitchLevel_0 .. v29:format(v32, l_MassInfectionSlashPoisonLevel_0, require(game.ReplicatedStorage.Modules.Util):IntToRoman(l_ZombieKillSpeedLevel_0), v7.ZombieKillSpeedDuration) .. "This ability starts off with 0 charges and a charge is given on kill. Max of 1 charge.\n";
v6(v10, 1, v11, v12, v13, v14, v15, v16, v17, v25, v18, v19, v20);
v7.Information = v10;
return v7;