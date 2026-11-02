-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Guest 1337",
	["Quote"] = "\"Be strong. Always be strong.\"",
	["Credits"] = "",
	["Class"] = "Sentinel",
	["RenderImage"] = "rbxassetid://132482363978492",
	["Price"] = 500,
	["Health"] = 115,
	["Speed"] = 12,
	["BlockCooldown"] = 24,
	["BlockDuration"] = 1,
	["BlockSpeedLevel"] = 1,
	["BlockSpeedDuration"] = 2,
	["ResistanceLevel"] = 5,
	["SlownessDuration"] = 2,
	["KillerSlownessPercent"] = 70,
	["KillerSlownessDuration"] = 1,
	["PunchCooldown"] = 5,
	["PunchWindupTime"] = 0.8,
	["PunchDashForce"] = 40,
	["PunchKnockback"] = 5,
	["PunchDamage"] = 20,
	["PunchStunTime"] = 2,
	["ParryWindupTime"] = 0.625,
	["ParryDashForce"] = 80,
	["ParryKnockback"] = 10,
	["ParryDamage"] = 35,
	["ParryStunTime"] = 3.5,
	["ChargeCooldown"] = 40,
	["ChargingSpeed"] = 34,
	["ChargingTurnSpeed"] = 2,
	["ChargingDuration"] = 1.5,
	["ChargeDamage"] = 20,
	["ChargeKnockback"] = 12.5,
	["ChargePunishmentDistanceInterval"] = 13,
	["ChargePunishmentSlownessDurationMultiplier"] = 3,
	["ChargePunishmentSlownessMaxDuration"] = 15,
	["ChargePunishmentSlownessLevel"] = 2,
	["KillerChargeResistanceDuration"] = 10,
	["KillerChargeResistanceDamage"] = 15,
	["Expressions"] = {
		["Happy"] = "rbxassetid://78520156813388",
		["Default"] = "rbxassetid://125192226174994",
		["Hurt"] = "rbxassetid://95483212511743",
		["Injured"] = "rbxassetid://75250671298406",
		["Dead"] = "rbxassetid://100662400255518",
		["Drinking"] = "rbxassetid://80694060854519"
	},
	["Animations"] = {
		["Block"] = "rbxassetid://70599344704389",
		["Punch"] = "rbxassetid://114322097806642",
		["ParryPunch"] = "rbxassetid://114322097806642",
		["Charge"] = "rbxassetid://87286938534212"
	},
	["Sounds"] = {
		["BlockStart"] = "rbxassetid://8028421882",
		["BlockSuccess"] = "rbxassetid://132298811847315",
		["PunchWindup"] = "rbxassetid://609342351",
		["Punch"] = "rbxassetid://133398613783505",
		["Parry"] = "rbxassetid://116900970230089",
		["ChargingStart"] = "rbxassetid://128024617021237",
		["ChargingHit"] = "rbxassetid://99002580763000",
		["ChargingCollide"] = "rbxassetid://9113225979",
		["ChargingTimeout"] = "rbxassetid://127506392754179"
	}
}
local v2 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"Your pizza is a necessity around here. I\226\128\153d like to ask for one.",
			"A pizza slice would be nice right about now.",
			"I can keep pushing through if I get a pizza.",
			"Can I have a slice? I would be grateful for one.",
			"A soldier knows when to appreciate the smaller moments. A pizza is one of them, if you\226\128\153d let me have one."
		},
		["BuildermanSentry"] = {
			"Builder, this spot is good for a sentry. ",
			"Over here\226\128\153s a good place for a sentry.",
			"A sentry over here would be good.",
			"Builder, putting a sentry over here would do some good.",
			"One of your sentries over here would be good."
		},
		["BuildermanDispenser"] = {
			"Builder, a dispenser over here would be beneficial.",
			"One of your dispensers in this spot would do good.",
			"Your dispenser here would be good.",
			"Builder, your dispenser built here would be great for the others.",
			"A spot like this is good for a dispenser.",
			"Requesting a dispenser over on my position."
		},
		["DusekkarProtection"] = {
			"One of your force fields could be good, I can fight them off better that way.",
			"A force field from you is needed. It\226\128\153s for a good cause.",
			"Your forcefield is good, I\226\128\153d like to have it casted on me for a bit.",
			"I need some assistance in fighting them off. One of your force fields should do the trick.",
			"A little help from you in defending me from the killer from afar would be appreciated."
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"I won\226\128\153t forget what you\226\128\153ve done for me, thanks.",
			"Trust that I\226\128\153ll have your back for this.",
			"Thank you for your service. You\226\128\153d have made a fine recruit.",
			"I appreciate the gesture. I\226\128\153ll do my best out there.",
			"Your help is greatly appreciated.",
			"I promise to keep everyone safe after this. Thank you for your work."
		}
	}
}
v1.TextInteractions = v2
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "GUEST 1337",
		["Text"] = "A hardened veteran with battle scars from wars long ago. He has a tendency to sacrifice himself in order to keep those around him safe. With Guest\'s sturdiness, he can block, bash, and punch the killer to keep it away from harming his allies.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health or 100) .. ("Regular Speed: %*\n"):format(v1.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v1.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain or 20)
	},
	{
		["Separator"] = "PASSIVES"
	},
	{
		["Header"] = "MADE TO LAST",
		["Quote"] = "\"Be strong. Always be strong.\" - Guest 1337",
		["Text"] = ("%* has an extra +15 HP!\n"):format("Guest 1337")
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://137576632569674",
		["Header"] = "BLOCK",
		["Quote"] = "\"Stay strong, friend. I got your back.\" - Guest 1337",
		["Text"] = ("Cooldown: %*s\n"):format(v1.BlockCooldown) .. ("%* braces for impact, applying <b>Resistance V</b> (aka Invincibility) for %*s and has their movement reduced by 80%% for %*s.\n"):format("Guest 1337", v1.BlockDuration, v1.SlownessDuration) .. ("Upon successfully blocking an attack, %* has their movement speed restored, their <b>Resistance</b> status removed, and the attacking Killer has their movement speed reduced by 30%% for %*s.\n"):format("Guest 1337", v1.KillerSlownessDuration) .. ("Successful blocks restore a charge for %*\'s <b>Punch</b> ability and grant <b>Speed I</b> for %*s.\n"):format("Guest 1337", v1.BlockSpeedDuration) .. "<b>Projectiles CANNOT be blocked.\n</b>"
	},
	{
		["Image"] = "rbxassetid://73254549946762",
		["Header"] = "CHARGE",
		["Quote"] = "\"Incoming! Look out!\" - Guest 1337",
		["Text"] = ("Cooldown: %*s\n"):format(v1.ChargeCooldown) .. ("%* dashes forward in a shoulder-bash pose for %*s.\n"):format("Guest 1337", v1.ChargingDuration) .. ("If %* collides with a killer during his charge, then the killer is knocked back and has their abilities locked for 1.25s. %* also becomes invincible for 1.25s.\n"):format("Guest 1337", "Guest 1337") .. ("<b>If %* charges into a killer whom was already charged into %* seconds prior, then they will take %* damage and the charge\'s effects will be nullified.</b>"):format("Guest 1337", v1.KillerChargeResistanceDuration, v1.KillerChargeResistanceDamage) .. ("Not landing a charge on an enemy inflicts %* with <b>Slowness II</b> that lasts for %* times %*\'s distance from the nearest killer divided by %*.\n"):format("Guest 1337", v1.ChargePunishmentSlownessDurationMultiplier, "Guest 1337", v1.ChargePunishmentDistanceInterval) .. "Charge ends automatically if you crash into a wall.\n" .. ("%* cannot gain stamina while charging.\n"):format("Guest 1337")
	},
	{
		["Image"] = "rbxassetid://86535502112498",
		["Header"] = "PUNCH",
		["Quote"] = "\"FALCAWN PAAWNCH\" - random guy",
		["Text"] = ("%* winds up his fist for %*s and punches forward, stunning any killer within range of his punch for %*s.\n"):format("Guest 1337", v1.PunchWindupTime, v1.PunchStunTime) .. ("If this ability is used within %*s of a successful block, then it becomes a Parry.\n"):format(v1.BlockDuration) .. ("Parried punches have a windup time of %*s and stun the killer for %*s.\n"):format(v1.ParryWindupTime, v1.ParryStunTime)
	}
}
return v1
