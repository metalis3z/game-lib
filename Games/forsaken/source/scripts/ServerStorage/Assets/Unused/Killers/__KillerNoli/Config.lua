-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Noli",
	["Quote"] = "\"And so darkness decends.\"",
	["Credits"] = "By: c2o & Marcy",
	["RenderImage"] = "rbxassetid://113686001078195",
	["Price"] = 1100,
	["Exclusive"] = true,
	["Health"] = 1111,
	["Speed"] = 5,
	["SprintSpeed"] = 35,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 10,
	["RevealSurvivorsOnKillTime"] = 3,
	["StaminaGetOnStardrivenHit"] = 50,
	["MaxStamina"] = 60,
	["MinStamina"] = -30,
	["MovementAnimSpeed"] = 1.5,
	["AttackDamage"] = 40,
	["StabDamage"] = 25,
	["StabCooldown"] = 2,
	["StunTimeAfterLosingStamina"] = 1.25,
	["StunTimeAfterFailingStardriven"] = 1.5,
	["SpeedTimeAfterStaminaLossStun"] = 2
}
local v2 = {
	[2] = {
		["Distance"] = 75,
		["Lifetime"] = 0.4,
		["Damage"] = 12
	},
	[1] = {
		["Distance"] = 75,
		["Lifetime"] = 0.625,
		["Damage"] = 24
	}
}
v1.StardrivenTokenData = v2
v1.StardrivenHallucinationDuration = 7
v1.StardrivenCooldown = 15
v1.ImplantBaseDamage = 28.98
v1.ImplantBombThrowBaseRange = 30
v1.ImplantKnockback = 2
v1.ImplantCooldown = 15
v1.ImplantDecayTime = 30
v1.HallucinationCooldown = 20
v1.HallucinationDuration = 5
v1.HallucinationAuraRevealDuration = 3
v1.HallucinationMaxDistance = 45
v1.IntroLighting = script.IntroLighting
local v3 = {
	["Idle"] = "rbxassetid://138324063953647",
	["Walk"] = "rbxassetid://137847957097255",
	["Run"] = "rbxassetid://137847957097255",
	["Stab"] = "rbxassetid://109539066680081",
	["StardrivenTendrilStart"] = "rbxassetid://75407080631670",
	["StardrivenTendrilLoop"] = "rbxassetid://134886218841388",
	["StardrivenCharge1Start"] = "rbxassetid://107933671616451",
	["StardrivenCharge1Loop"] = "rbxassetid://84229504225722",
	["StardrivenCharge1Hit"] = "rbxassetid://129857215854574",
	["StardrivenCharge2Start"] = "rbxassetid://119658701116416",
	["StardrivenCharge2Loop"] = "rbxassetid://98196878867450",
	["StardrivenCharge2HitNoli"] = "rbxassetid://111770787657351",
	["StardrivenCharge2HitVictim"] = "rbxassetid://125458517900841",
	["StardrivenChargeMiss"] = "rbxassetid://105789017715176",
	["Implant"] = "rbxassetid://76844337943462",
	["ImplantDash"] = "rbxassetid://132804454049817",
	["ImplantAttackNoli"] = "rbxassetid://104272323944287",
	["ImplantAttackVictim"] = "rbxassetid://132436844568785",
	["Hallucination"] = "rbxassetid://88967915173337",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://90748798474439",
		["CameraRig"] = "rbxassetid://95540863421188"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://85954500240783",
		["PlayerRig"] = "rbxassetid://91105150526088",
		["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://126012795677080",
		["Loop"] = "rbxassetid://101608781938610",
		["End"] = "rbxassetid://83196710521511"
	},
}
v1.Animations = v3
local v4 = {
	["Idle"] = "rbxassetid://73235255020546",
	["Footsteps"] = { "rbxassetid://78445821037697", "rbxassetid://73139563266141" },
	["StardrivenMiss"] = {
		"rbxassetid://133282047531480",
		"rbxassetid://84356091936643",
		"rbxassetid://101539015108735",
		"rbxassetid://116029878839715"
	},
	["Execution"] = "rbxassetid://81732651056519",
	["Swing"] = "rbxassetid://78077785822926",
	["Hit"] = "rbxassetid://81392465258509",
	["Implant"] = "rbxassetid://90768093259753",
	["ImplantInject"] = "rbxassetid://115601890176860",
	["Explosion"] = "rbxassetid://80681665937470",
	["Hallucination"] = "rbxassetid://90860171281026",
	["SecondHit"] = "rbxassetid://139521789303730"
}
local v5 = {
	[60] = {
		["ID"] = "rbxassetid://116407319415350",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://79896992348210",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://133882159249889",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://98695169686427",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v4.TerrorRadiusThemes = v5
v4.Introduction = "rbxassetid://121004024017568"
v1.Sounds = v4
v1.Voicelines = {
	["KillTaph"] = { "rbxassetid://102171832250883" },
	["Kill"] = { "", "rbxassetid://129665749632167" },
	["Stunned"] = { "rbxassetid://89381939404164", "rbxassetid://121789164880676" }
}
v1.Assets = {
	["DecayCC"] = script.Decay
}
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "NOLI",
		["Text"] = "And so darkness descends."
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*(+30)\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
	},
	{
		["Separator"] = "PASSIVES"
	},
	{
		["Header"] = "FIFTH SEQUENCE",
		["Quote"] = "\"N/A\" - N/A",
		["Text"] = ("Stamina loss is increased to %*.\nStamina gain is decreased to %*.\n"):format(v1.StaminaLoss, v1.StaminaGain) .. ("Stamina can go into the negatives but if you run enough, your screen turns progressively more black, purple, and jittery. This effect covers GUI elements that notify the user of their stamina. If reaching %* Stamina, Noli is stunned for %* seconds. \n"):format(v1.MinStamina, v1.StunTimeAfterLosingStamina) .. ("On survivor kill, reveal the location of remaining survivors for %* seconds and gain %* stamina.\n"):format(v1.RevealSurvivorsOnKillTime, v1.StaminaGetOnExecution)
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Header"] = "STAB",
		["Image"] = "rbxassetid://135239660832992",
		["Quote"] = "\"N/A\" - N/A",
		["Text"] = ("Cooldown: %*s\n"):format(v1.StabCooldown) .. ("Damage: %*\n"):format(v1.StabDamage) .. ("%* uses his Shadow Tendril to stab a Survivor and gains %* stamina.\n"):format("<font color=\"rgb(118, 64, 165)\">Noli</font>", v1.StaminaGetOnStab)
	},
	{
		["Header"] = "STARDRIVEN",
		["Image"] = "rbxassetid://77714746717084",
		["Quote"] = "\"N/A\" - N/A",
		["Text"] = ("Cooldown: %*s\n"):format(v1.StardrivenCooldown) .. ("1st Damage: %*\n"):format(v1.StardrivenTokenData[2].Damage) .. ("2nd Damage: %*\n"):format(v1.StardrivenTokenData[1].Damage) .. ("%* charges their Shadow Tendril, charges forwards, and attempts to hit a Survivor for %* damage. \nIf the hit connects, recover %* stamina and reuse ability a second time. \nIf the hit connects a second time, slam survivor into the ground for %* damage. \n If the hit fails, %* gets stunned.\n"):format("<font color=\"rgb(118, 64, 165)\">Noli</font>", v1.StardrivenTokenData[2].Damage, v1.StaminaGetOnStardrivenHit, v1.StardrivenTokenData[1].Damage, "<font color=\"rgb(118, 64, 165)\">Noli</font>")
	},
	{
		["Header"] = "IMPLANT",
		["Image"] = "rbxassetid://88651731892734",
		["Quote"] = "\"N/A\" - N/A",
		["Text"] = ("Cooldown: %*s\n"):format(v1.ImplantCooldown) .. ("Damage: %*\n"):format(v1.ImplantBaseDamage) .. ("%* places a Void Star trap that, when a Survivor is in the radius of, explodes. \n%* can also manually detonate it by placing another one, exploding the previous trap in the process. \nIf %* is moving while using Implant, dash forward and place the trap instead. \n%* can also use this ability to place his Void Star inside a survivor, turning them into a \'walking bomb\'.\n"):format("<font color=\"rgb(118, 64, 165)\">Noli</font>", "<font color=\"rgb(118, 64, 165)\">Noli</font>", "<font color=\"rgb(118, 64, 165)\">Noli</font>", "<font color=\"rgb(118, 64, 165)\">Noli</font>")
	},
	{
		["Header"] = "HALLUCINATION",
		["Image"] = "rbxassetid://107117927290267",
		["Quote"] = "\"N/A\" - N/A",
		["Text"] = ("Cooldown: %*s\n"):format(v1.HallucinationCooldown) .. ("Distance: %*\n"):format(v1.HallucinationMaxDistance) .. ("%* uses his Void Star to give all Survivors in a %* stud radius a hallucination.\n For every survivor that gets hit with Hallucination, he gains %* stamina.\n"):format("<font color=\"rgb(118, 64, 165)\">Noli</font>", v1.HallucinationMaxDistance, v1.StaminaGetOnHallucination) .. "\nHallucination 1: Footsteps getting progressively closer. After the footsteps end, play laugh. \nHallucination 2: Flickers Survivors\226\128\153 camera. Play laugh instantly. \nHallucination 3: \'take damage\' (Survivor takes 98 fixed damage, recover it in an instant. There is no actual damage being done.) When damage is recovered, play laugh. \nAll hallucinations show a laughing mask with a distorted laughing sound cue after they are done.\n"
	}
}
return v1
