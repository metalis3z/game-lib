-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Noli (Old)",
	["Quote"] = "\"And so darkness decends.\"",
	["Credits"] = "By: c2o",
	["RenderImage"] = "rbxassetid://113686001078195",
	["Price"] = 1100,
	["Exclusive"] = true,
	["Health"] = 1111,
	["Speed"] = 6,
	["SprintSpeed"] = 28,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 10,
	["MaxStamina"] = 60,
	["MinStamina"] = -30,
	["MovementAnimSpeed"] = 1.5,
	["AttackDamage"] = 40,
	["StabDamage"] = 25,
	["StabCooldown"] = 2,
	["StardrivenCooldown"] = 15,
	["StardrivenDashDistance"] = 60,
	["StardrivenDashTime"] = 1.15,
	["StardrivenWindup"] = 1,
	["StardrivenBar"] = script.StardrivenBar,
	["ImplantDetectRadius"] = 30,
	["ImplantDetonateRadius"] = 15,
	["ImplantCooldown"] = 15,
	["HallucinationCooldown"] = 1,
	["IntroLighting"] = script.IntroLighting,
	StardrivenTokenData = {
		[2] = {
			Distance = 75, 
			Lifetime = 0.4, 
			Damage = 15
		}, 
		[1] = {
			Distance = 75, 
			Lifetime = 0.625, 
			Damage = 35
		}
	}, 
}
local v2 = {
	["Idle"] = "rbxassetid://87385694745960",
	["Walk"] = "rbxassetid://109145733080371",
	["Run"] = "rbxassetid://101869159216767",
	["Stab"] = "rbxassetid://125366970248054",
	["StardrivenTendrilStart"] = "rbxassetid://133800478556571",
	["StardrivenTendrilLoop"] = "rbxassetid://103787296279179",
	["StardrivenCharge1Start"] = "rbxassetid://110801329028991",
	["StardrivenCharge1Loop"] = "rbxassetid://98382042398332",
	["StardrivenCharge1Hit"] = "rbxassetid://128210940853180",
	["StardrivenCharge2Start"] = "rbxassetid://105616130787522",
	["StardrivenCharge2Loop"] = "rbxassetid://122850671552914",
	["StardrivenCharge2HitNoli"] = "rbxassetid://100223076509898",
	["StardrivenCharge2HitVictim"] = "rbxassetid://117146057250465",
	["StardrivenChargeMiss"] = "rbxassetid://136826760706318",
	["Implant"] = "rbxassetid://75804229273191",
	["ImplantThrowLoop"] = "rbxassetid://126537359308678",
	["ImplantThrow"] = "rbxassetid://101279251661133",
	["ImplantAttackNoli"] = "rbxassetid://100245105802625",
	["ImplantAttackVictim"] = "rbxassetid://134445088616874",
	["Hallucination"] = "rbxassetid://109691136064182",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://74680048632986",
		["CameraRig"] = "rbxassetid://83125021872492"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://139585837255283",
		["PlayerRig"] = "rbxassetid://124886877342530",
		["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://85521749534266",
		["Loop"] = "rbxassetid://80254437937864",
		["End"] = "rbxassetid://98048416333542"
	}
}
v1.Animations = v2
local v3 = {
	["Ambience"] = "rbxassetid://73654465778424",
	["Footsteps"] = { "rbxassetid://99809965759734", "rbxassetid://79222929114377" },
	["Execution"] = "rbxassetid://78344423946580",
	["Swing"] = "rbxassetid://118208498013260",
	["Hit"] = "rbxassetid://110759725172567",
	["Implant"] = "rbxassetid://90768093259753",
	["ImplantInject"] = "rbxassetid://114767134633867",
	["Explosion"] = "rbxassetid://99558901806521",
	["Hallucination"] = "rbxassetid://113926551867193",
	["Stunned"] = {
		["Start"] = "rbxassetid://115332398454262",
		["End"] = "rbxassetid://113454045849271"
	}
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
