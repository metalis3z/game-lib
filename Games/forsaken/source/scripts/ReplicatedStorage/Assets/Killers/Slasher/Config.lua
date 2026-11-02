-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = workspace:GetAttribute("JasonSpecialDay")
local v3 = {
	["DisplayName"] = "Slasher",
	["Quote"] = v1 and "\"... :)\"" or "\"...\"",
	["Credits"] = "Made By: HowsLifeJosh, BakedMesh and koekonaut",
	["RenderImage"] = v1 and "rbxassetid://72479363542015" or "rbxassetid://140658179418889",
	["Price"] = 0,
	["Health"] = v1 and 3000 or 1250,
	["Speed"] = v1 and 10 or 9,
	["SprintSpeed"] = v1 and 30 or 28,
	["StaminaLoss"] = 9.5,
	["StaminaGain"] = 21,
	["MaxStamina"] = v1 and 40 or 110,
	["SlashDamage"] = v1 and 40 or 20,
	["SlashCooldown"] = v1 and 3.5 or 1.9,
	["SlashStatusTime"] = 5,
	["SlashWindup"] = 0.2,
	["SlashLinger"] = 0.25,
	["EnragedSlashDamage"] = v1 and 50 or 25,
	["EnragedSlashCooldown"] = v1 and 1.5 or 0.8,
	["EnragedSlashLungeForce"] = v1 and 85 or 65,
	["BeheadDamage"] = v1 and 50 or 20,
	["BeheadCooldown"] = v1 and 24 or 18.5,
	["BeheadLunge"] = v1 and 1.7 or 1.3,
	["BeheadStatusTime"] = 8,
	["BeheadWindup"] = 0.45,
	["BeheadLinger"] = 0.15,
	["EnragedBeheadDamage"] = v1 and 75 or 35,
	["EnragedBeheadLunge"] = v1 and 2.2 or 2,
	["EnragedBeheadCooldown"] = v1 and 18 or 12,
	["GashingWoundDamage"] = v1 and 150 or 50,
	["GashingWoundCooldown"] = v1 and 60 or 40,
	["GashingWoundStatusTime"] = 8,
	["GashingWoundHitData"] = function()
		local v2 = {
			[0.333] = {
				["DamageDivisor"] = 5,
				["Time"] = 0.15,
				["DoLunge"] = true
			},
			[0.75] = {
				["DamageDivisor"] = 5,
				["Time"] = 0.15,
				["DoLunge"] = true
			},
			[1.533] = {
				["DamageDivisor"] = 5,
				["Time"] = 0.15,
				["DoLunge"] = true
			},
			[1.966] = {
				["DamageDivisor"] = 10,
				["Time"] = 0.15,
				["DoLunge"] = true
			},
			[2.333] = {
				["DamageDivisor"] = 10,
				["Time"] = 0.15
			},
			[2.983] = {
				["DamageDivisor"] = 5,
				["Time"] = 0.15,
				["DoLunge"] = true
			}
		}
		return v2
	end,
	["EnragedGashingWoundDamage"] = v1 and 250 or 70,
	["EnragedGashingWoundCooldown"] = v1 and 50 or 32,
	["RagingPaceCooldown"] = v1 and 55 or 30,
	["EnragedSpeed"] = v1 and 26 or 19.5,
	["EnragedTime"] = v1 and 8 or 14,
	["EnragedStartup"] = 0.223,
	["EnragedAuraLingerTime"] = v1 and 10 or 2,
	["EnragedStaminaCap"] = v1 and 15 or 70,
	["EnragedStaminaCapLerpTime"] = 6.5,
	["Animations"] = {
		["Idle"] = "rbxassetid://101839167361703",
		["Walk"] = "rbxassetid://100308842445817",
		["Run"] = "rbxassetid://103867731959142",
		["InjuredIdle"] = "rbxassetid://101839167361703",
		["InjuredWalk"] = "rbxassetid://100308842445817",
		["InjuredRun"] = "rbxassetid://103867731959142",
		["EnragedStart"] = "rbxassetid://108442971056721",
		["EnragedIdle"] = "rbxassetid://108344327532413",
		["EnragedWalk"] = "rbxassetid://78229911613231",
		["EnragedRun"] = "rbxassetid://103867731959142",
		["Introduction"] = {
			["KillerRig"] = "rbxassetid://94373293343189",
			["CameraRig"] = "rbxassetid://103018531897309"
		},
		["Victory"] = {
			["KillerRig"] = "rbxassetid://78559816639242",
			["CameraRig"] = "rbxassetid://117177195557691"
		},
		["Execution"] = {
			["KillerRig"] = "rbxassetid://113097396320733",
			["PlayerRig"] = "rbxassetid://71908227364423"
		},
		["ExecutionGuest1337"] = {
			["KillerRig"] = "rbxassetid://115388656828599",
			["PlayerRig"] = "rbxassetid://94770178763736",
			["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5)
		},
		["Stunned"] = {
			["Start"] = "rbxassetid://86911387183212",
			["Loop"] = "rbxassetid://101664194433123",
			["End"] = "rbxassetid://137346143309075"
		},
		["Slash"] = "rbxassetid://70522167514808",
		["Behead"] = "rbxassetid://135453627113711",
		["GashingWoundStart"] = "rbxassetid://138591357203880",
		["GashingWound"] = {
			["KillerRig"] = "rbxassetid://135067288185523",
			["PlayerRig"] = "rbxassetid://92945827393884"
		}
	},
	["Sounds"] = {
		["Footsteps"] = { "rbxassetid://72457886454761", "rbxassetid://98852761114513" },
		["TerrorRadiusThemes"] = {
			[45] = {
				["ID"] = "rbxassetid://121292620130330",
				["BPM"] = 72
			},
			[30] = {
				["ID"] = "rbxassetid://85477377169399",
				["BPM"] = 72
			},
			[15] = {
				["ID"] = "rbxassetid://114692287462245",
				["BPM"] = 72
			},
			[6] = {
				["ID"] = "rbxassetid://76249201626879",
				["BPM"] = 72,
				["Chase"] = true
			}
		},
		["Execution"] = "rbxassetid://80903632607907",
		["Stunned"] = "rbxassetid://136281175461752",
		["Introduction"] = "rbxassetid://70658180298709",
		["VictoryTheme"] = {
			["ID"] = "rbxassetid://90514540386506",
			["Properties"] = {
				["Volume"] = 1.45,
				["Looped"] = false
			}
		},
		["Swing"] = "rbxassetid://112809109188560",
		["Hit"] = "rbxassetid://101633163910404",
		["EnragedStart"] = "rbxassetid://112390922764994",
		["GashingWoundSwing"] = "rbxassetid://102228729296384",
		["GashingWoundMiss"] = "rbxassetid://84353899757208",
		["GashingWoundHit"] = "rbxassetid://127648610882555"
	}
}
v3.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "SLASHER",
		["Text"] = "A man who\'s identity is covered by a crude hockey mask. Wielding several tools at his disposal, along with his thirst for the cat-and-mouse chase, his hands and/or tools are always seen bloody. He enters his damnation wielding his infamous machete & a chainsaw he found in a cabin.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v3.Health) .. ("Regular Speed: %*\n"):format(v3.Speed) .. ("Sprinting Speed: %*\n"):format(v3.SprintSpeed) .. ("Max Stamina: %*\n"):format(v3.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v3.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v3.StaminaGain) .. "Terror Radius: 45 studs\n"
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://97183429269286",
		["Header"] = "SLASH",
		["Quote"] = "\"Make them remember!\" - Mother",
		["Text"] = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.SlashCooldown, v3.EnragedSlashCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.SlashDamage, v3.EnragedSlashDamage) .. ("Windup: %*s\n"):format(v3.SlashWindup) .. ("Linger: %*s\n"):format(v3.SlashLinger) .. "Length: 7 studs\n<font color=\"rgb(200,150,20)\">Slasher</font> does a basic slash with his machete; inflicts <b>Bleeding I</b> for 5 seconds.\nThis slash can hit through multiple people at once.\nA lunge is added to this attack if it\'s used while <font color=\"rgb(200,150,20)\">Slasher\'s</font> <font color=\"rgb(255,50,50)\">ENRAGED</font>.\n"
	},
	{
		["Image"] = "rbxassetid://115283980500353",
		["Header"] = "BEHEAD",
		["Quote"] = "\"No place to hide.\" - Mother",
		["Text"] = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.BeheadCooldown, v3.EnragedBeheadCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.BeheadDamage, v3.EnragedBeheadDamage) .. "<font color=\"rgb(200,150,20)\">Slasher</font> winds up a strong horizontal swing to the head of his target.\nBEHEAD inflicts <b>Helpless I</b> for 14 seconds.\nAfter this attack, <font color=\"rgb(200,150,20)\">Slasher</font>, regardless if it hit, gains <b>Slowness I</b> for 2 seconds.\n"
	},
	{
		["Image"] = "rbxassetid://96900331272883",
		["Header"] = "GASHING WOUND",
		["Quote"] = "\"It\'ll be easier for you than it was for him.\" - Mother",
		["Text"] = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.GashingWoundCooldown, v3.EnragedGashingWoundCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v3.GashingWoundDamage, v3.EnragedGashingWoundDamage) .. "<font color=\"rgb(200,150,20)\">Slasher</font> does a combination of slashes, starting with 2 hits from his machete, then quickly jams his chainsaw into the victim.\n" .. ("Each slash deals around 1/5 of the attack\'s total damage, but they all add up to either %* or %* depending on if <font color=\"rgb(200,150,20)\">Slasher\'s</font> <font color=\"rgb(255,50,50)\">ENRAGED</font>.\n"):format(v3.GashingWoundDamage, v3.EnragedGashingWoundDamage)
	},
	{
		["Image"] = "rbxassetid://86530225037587",
		["Header"] = "RAGING PACE",
		["Quote"] = "\"Kill them!\" - Mother",
		["Text"] = ("Cooldown: %*s\n"):format(v3.RagingPaceCooldown) .. "<font color=\"rgb(200,150,20)\">Slasher</font> becomes <font color=\"rgb(255,0,0)\">ENRAGED.</font>\n" .. ("On activation, <font color=\"rgb(200,150,20)\">Slasher</font>\'s speed becomes %* for %* seconds, and the aura of the nearest survivor is revealed to him. The aura remains revealed until his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state ends, in which it\'ll linger for an additional %*s.\n"):format(v3.EnragedSpeed, v3.EnragedTime, v3.EnragedAuraLingerTime) .. ("While in effect, <font color=\"rgb(200,150,20)\">Slasher</font> becomes immune to stuns, has his sprinting disabled, and has his stamina slowly become capped at %* over the span of %*s. The cap is removed once he leaves his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state.\n"):format(v3.EnragedStaminaCap, v3.EnragedStaminaCapLerpTime)
	}
}
return v3
