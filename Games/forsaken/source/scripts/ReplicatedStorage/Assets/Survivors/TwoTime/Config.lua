-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Two Time",
	["Quote"] = "\"Shadows die twice.\"",
	["Credits"] = "",
	["Class"] = "Sentinel",
	["RenderImage"] = "rbxassetid://100794675544132",
	["Price"] = 500,
	["Exclusive"] = false,
	["Health"] = 80,
	["Speed"] = 12,
	["DaggerCooldown"] = 30,
	["DaggerDamage"] = 10,
	["DaggerBackstabDamage"] = 20,
	["DaggerLungeForce"] = 110,
	["DaggerUncrouchedLungeForce"] = 35,
	["DaggerBackstabThreshold"] = 90,
	["DaggerLookDirectionAngle"] = 70,
	["DaggerStatusTime"] = 1,
	["DaggerBackstabStatusTime"] = 3.5,
	["DaggerLifestealFromFront"] = 10,
	["DaggerLifestealFromBack"] = 20,
	["DaggerResLevel"] = 1,
	["DaggerResDuration"] = 0.7,
	["BloodReqIncreasePerTwoTime"] = 1,
	["CrouchCooldown"] = 45,
	["CrouchMinCooldown"] = 35,
	["CrouchSpeed"] = 9,
	["CrouchRunSpeed"] = 15,
	["CrouchInvisibilityLevel"] = 3,
	["CrouchUndetectableLevel"] = 1,
	["CrouchSpeedCloseTime"] = 1,
	["CrouchStabAmplifyTime"] = 5,
	["CrouchRevealTime"] = 2,
	["CrouchDistances"] = {
		["CLOSE"] = { 0, 30 },
		["DEBUFF_SLOWNESS"] = { 75, -1 },
		["DEBUFF_HIGHLIGHT"] = { 125, -1 }
	},
	["CrouchSlownessDebuffMax"] = 150,
	["Lives"] = 2,
	["BloodRequiredForRespawn"] = 8,
	["BloodFromFront"] = 3,
	["BloodFromBack"] = 4.5,
	["RespawnLocationDistance"] = 10,
	["NextLifeHealthDivisor"] = 2,
	["InvincibilityDuration"] = 2,
	["LastSurvivorMaxHealth"] = 110,
	["LastSurvivorHealthBonus"] = 50,
	["RespawnLocation"] = script.Spawn,
	["HealthBar"] = script.Sidebar,
	["AudioReplication"] = script.AudioReplication,
	["VFX"] = script.TwoTimeVFX,
	["LifeAppearances"] = { script.Life1, script.Life2 },
	["DaggerTemplate"] = script.GhostFire,
	Animations = {
		CrouchStart = "rbxassetid://131611830332581", 
		CrouchIdle = "rbxassetid://115388598113220", 
		CrouchWalk = "rbxassetid://100491028037897", 
		CrouchRun = "rbxassetid://95726482669798", 
		Stab = "rbxassetid://139809766287709", 
		LungeStart = "rbxassetid://95436504900456", 
		LungeLoop = "rbxassetid://97114580550168", 
		LungeEnd = "rbxassetid://113560317345453", 
		Ritual = "rbxassetid://104898459586354"
	}, 
	Sounds = {
		Crouch = "rbxassetid://127883039795424", 
		Stand = "rbxassetid://112995614541035", 
		Mark = "rbxassetid://126819325465497", 
		Hit = "rbxassetid://96032371062643", 
		Stab = "rbxassetid://86710781315432", 
		CrouchStab = "rbxassetid://91261123012892", 
		Respawn = "rbxassetid://84260460113659"
	}, 
}
local v2 = {
	{
		["Happy"] = "rbxassetid://81896815825257",
		["Default"] = "rbxassetid://73483634925418",
		["Hurt"] = "rbxassetid://93421870784694",
		["Injured"] = "rbxassetid://133089396665213",
		["Dead"] = "rbxassetid://133611309054814",
		["Drinking"] = "rbxassetid://99335439385081"
	},
	{
		["Happy"] = "rbxassetid://79565455816327",
		["Default"] = "rbxassetid://131136664195288",
		["Hurt"] = "rbxassetid://120830873592415",
		["Injured"] = "rbxassetid://104452353265078",
		["Dead"] = "rbxassetid://123221349342396",
		["Drinking"] = "rbxassetid://127552301758353"
	}
}
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
local v3 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"Hey, hey. Pizza, pizza please.",
			"Pizza\226\128\153s something I haven\226\128\153t tried much, mind if I get a slice?",
			"I must ask for a pizza.",
			"Do you have pizza? I could use one!",
			"May I have a pizza slice?",
			"I really want a pizza! May I have one?"
		},
		["BuildermanSentry"] = {
			"Your turrets may be of use over here.",
			"A sentry here should be put to use. Place it here.",
			"Place your sentry over here. It will help against the foes.",
			"Put down a sentry here.",
			"Your sentry will be of use over here."
		},
		["BuildermanDispenser"] = {
			"I\226\128\153m in need of a dispenser in my position.",
			"I require a dispenser to be placed here.",
			"Dispenser here, please.",
			"Put down one of your dispensers here.",
			"Your dispenser is needed here."
		},
		["DusekkarProtection"] = {
			"Divine pumpkin, I humbly request your divine ability.",
			"Divine pumpkin, I implore you to cast your ability onto me.",
			"Divine pumpkin, I ask of thee to be blessed.",
			"Divine pumpkin, blessed be thy heart should you cast a spell unto me.",
			"Divine pumpkin, I ask for thy divine intervention."
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"Much appreciated.",
			"Very thankful for your service.",
			"May good fortune come your way for your generosity.",
			"The Spawn would be pleased with your acts of kindness.",
			"I thank you for your service.",
			"Oh give thanks to the Spawn, for he is good; for their steadfast love endures forever."
		},
		["DusekkarProtection"] = {
			{ "TwoTime: The Spawn would be pleased with your acts of kindness!", "Dusekkar: ...", "Dusekkar: Eugh..." },
			{ "TwoTime: Oh give thanks to the Spawn, for he is good; for their steadfast love endures forever.", "Dusekkar: ...", "Dusekkar: Ugh..." }
		}
	}
}
v1.TextInteractions = v3
local v4 = v1.BloodFromFront / v1.BloodRequiredForRespawn * 100
local v5 = math.floor(v4)
local v6 = v1.BloodFromBack / v1.BloodRequiredForRespawn * 100
local v7 = math.floor(v6)
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "TWO TIME",
		["Text"] = "A fragile cultist that holds a terrible secret. Bearing nothing other than a sleek dagger and manic smile, they\'re able to earn a second life through risk and sacrifice.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health or 100) .. ("Regular Speed: %*\n"):format(v1.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v1.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain or 20)
	},
	{
		["Separator"] = "PASSIVES"
	},
	{
		["Header"] = "OBLATION",
		["Quote"] = "\"You both shall set out on the grand step to rebirth.\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136",
		["Text"] = ("%* has a bar on the right side of the screen that, when filled, grants them a second life.\n"):format("Two Time") .. "The only way to fill this bar is by dealing damage to the Killer.\n" .. ("Landing a stab to the front will fill %*%% of the bar.\n"):format(v5) .. ("Landing a stab to the back will fill %*%% of the bar.\n"):format(v7) .. "In their second life, they only have <b>half</b> as much health (40) as they usually do (80).\n" .. "Upon activation:\n" .. " * Stamina is restored by 40%\n" .. " * All status effects are removed\n" .. (" * %* is made invincible for %* seconds \n"):format("Two Time", v1.InvincibilityDuration) .. " * <b>Speed II</b> is applied for 6 seconds\n * <b>Weakness V</b> is applied for 12 seconds\n"
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Header"] = "SACRIFICIAL DAGGER",
		["Quote"] = "\"Lookie, \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\128\148they gave us this cool knife!\" - Two Time",
		["Text"] = ("Cooldown: %*s\n"):format(v1.DaggerCooldown) .. ("%* instantly stabs forward and gains <b>Resistance %*</b> for %* seconds.\n"):format("Two Time", v1.DaggerResLevel, v1.DaggerResDuration) .. ("Landing a stab to the front will do %* damage, heal Two Time for %* HP, and apply <b>Slowness II</b> and <b>Helpless I</b> to the killer for 1s.\n"):format(v1.DaggerDamage, v1.DaggerLifestealFromFront) .. ("Landing a stab to the back will instead do %* damage, stun the killer for %*s, and heal Two Time for %* HP.\n"):format(v1.DaggerBackstabDamage, v1.DaggerBackstabStatusTime, v1.DaggerLifestealFromBack) .. "Using this ability while <b>crouched</b> quickly lunges you forward with a stab that has an increased windup time and increased endlag.\nLanding a stab on a summon does not grant <b>OBLATION</b> progress or healing.\n"
	},
	{
		["Header"] = "CROUCH",
		["Quote"] = "\"Quiet, Two Time! They\'re not supposed to see us in here, hehe!\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136",
		["Text"] = ("Cooldown: %*s\n"):format(v1.CrouchCooldown) .. ("%* crouches down to silence their footsteps and become stealthier.\n"):format("Two Time") .. ("%* remains <b>crouched</b> for at most %* seconds, but can uncrouch whenever they need to.\n"):format("Two Time", v1.CrouchCooldown - v1.CrouchMinCooldown) .. ("Crouching applies <b>Undetectable I</b> and <b>Invisibility III</b> for at most %* seconds.\n"):format(v1.CrouchCooldown - v1.CrouchMinCooldown) .. "Uncrouching manually will forcibly remove these statuses and do one of the following:\n" .. (" * If %* is far from the killer, uncrouching manually will briefly reveal %* and apply <b>Slowness II</b> for up to 15s depending on how far %* is from the killer.\n"):format("Two Time", "Two Time", "Two Time") .. (" * If %* is somewhat close to the killer, uncrouching manually will have no additional effects.\n"):format("Two Time") .. (" * If %* is very close to the killer, uncrouching manually will instead grant %* <b>Speed II</b> for 1s.\n"):format("Two Time", "Two Time")
	},
	{
		["Header"] = "RITUAL",
		["Quote"] = "\"Spawn will be eternally pleased at our devotion!\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136",
		["Text"] = ("%* inscribes a respawn location on the ground.\n"):format("Two Time") .. ("Dying with a full <b>OBLATION</b> bar will instantly teleport %* to this point.\n"):format("Two Time") .. "<b>This ability can only be used once per round.</b>\n" .. ("If %* becomes the last survivor alive and has not already entered their second life, <b>RITUAL</b> will automatically trigger regardless of whether <b>OBLATION</b> was full or not.\n"):format("Two Time") .. ("If this happens, %* will additionally have their maximum health increased to 110, be healed for up to 40 HP, and will not be afflicted with <b>Weakness V</b>.\n"):format("Two Time")
	}
}
return v1
