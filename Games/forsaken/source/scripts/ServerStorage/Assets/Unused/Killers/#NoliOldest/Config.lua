-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Noli",
	["Quote"] = "\"And so darkness decends.\"",
	["Credits"] = "By: c2o",
	["RenderImage"] = "rbxassetid://113686001078195",
	["Price"] = 1100,
	["Exclusive"] = true,
	["Health"] = 1111,
	["Speed"] = 24,
	["SprintSpeed"] = 28,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 10,
	["MaxStamina"] = 60,
	["MinStamina"] = -30,
	["MovementAnimSpeed"] = 1.5,
	["AttackDamage"] = 40,
	["StabDamage"] = 25,
	["StabCooldown"] = 2,
	["StunTimeAfterLosingStamina"] = 1.25,
	["SpeedTimeAfterStaminaLossStun"] = 2,
	["StardrivenDamage1"] = 12,
	["StardrivenDamage2"] = 24,
	["StardrivenCooldown"] = 2,
	["StardrivenTimeout"] = 24,
	["StardrivenSpeed"] = 60,
	["StardrivenRecoverTime"] = 0.5,
	["ImplantDamage"] = 15,
	["ImplantKnockback"] = 2,
	["ImplantCooldown"] = 15,
	["ImplantTime"] = 30,
	["ImplantInjectKnockback"] = 15,
	["ImplantInjectKnockbackDestroyTime"] = 0.15,
	["HallucinationCooldown"] = 1,
	["HallucinationDuration"] = 5,
	["HallucinationAuraRevealDuration"] = 3,
	["HallucinationMaxDistance"] = 45,
	["IntroLighting"] = script.IntroLighting
}
local v2 = {
	["Idle"] = "rbxassetid://70696117337177",
	["Walk"] = "rbxassetid://128048662213155",
	["Run"] = "rbxassetid://128048662213155",
	["Stab"] = "rbxassetid://119499460759955",
	["StardrivenTendrilStart"] = "rbxassetid://75950102061790",
	["StardrivenTendrilLoop"] = "rbxassetid://98634054770061",
	["StardrivenCharge1Start"] = "rbxassetid://134336106854518",
	["StardrivenCharge1Loop"] = "rbxassetid://136705081190532",
	["StardrivenCharge1Hit"] = "rbxassetid://106495427882232",
	["StardrivenCharge2Start"] = "rbxassetid://75498011160853",
	["StardrivenCharge2Loop"] = "rbxassetid://94810783168619",
	["StardrivenCharge2HitNoli"] = "rbxassetid://95158807382257",
	["StardrivenCharge2HitVictim"] = "rbxassetid://140026221586206",
	["StardrivenChargeMiss"] = "rbxassetid://139148005758689",
	["Implant"] = "rbxassetid://87361115931690",
	["ImplantAttackNoli"] = "rbxassetid://86281250263304",
	["ImplantAttackVictim"] = "rbxassetid://130455346354381",
	["Hallucination"] = "rbxassetid://79106969770422",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://124842870306885",
		["CameraRig"] = "rbxassetid://75474474741299"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://117739882729074",
		["PlayerRig"] = "rbxassetid://135353948520744",
		["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://112312412725108",
		["Loop"] = "rbxassetid://70781483842228",
		["End"] = "rbxassetid://126866602246595"
	}
}
v1.Animations = v2
local v3 = {
	["Idle"] = "rbxassetid://73235255020546",
	["Footsteps"] = { "rbxassetid://99809965759734", "rbxassetid://79222929114377" },
	["Execution"] = "rbxassetid://91549814855829",
	["Swing"] = "rbxassetid://118208498013260",
	["Hit"] = "rbxassetid://110759725172567",
	["Implant"] = "rbxassetid://90768093259753",
	["ImplantInject"] = "rbxassetid://114767134633867",
	["Explosion"] = "rbxassetid://99558901806521",
	["Hallucination"] = "rbxassetid://113926551867193"
}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://137984398736588",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://101639399549593",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://139278573219074",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://79001697227075",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v3.Introduction = "rbxassetid://97041392946745"
v1.Sounds = v3
v1.Assets = {
	["DecayCC"] = script.Decay
}
return v1
