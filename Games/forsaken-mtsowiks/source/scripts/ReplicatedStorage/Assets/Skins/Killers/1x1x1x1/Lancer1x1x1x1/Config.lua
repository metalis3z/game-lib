-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Lancer",
	["Description"] = "Gloria aeterna.",
	["CollabInfo"] = "Postmortem",
	["RenderImage"] = "rbxassetid://76033903185884",
	["Price"] = 1000,
	["Exclusive"] = false,
	["ZombieTemplate"] = script.Zombie,
	["IntroLighting"] = script.IntroLighting,
	["ShockwaveTemplate"] = script.Shockwave,
	["SwordsTemplate"] = script.Swords,
	["OutroLighting"] = script.OutroLighting,
	["OutroVFXFolder"] = script.OutroVFX,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(30, 30, 30),
		["OutlineColor"] = Color3.fromRGB(0, 0, 0),
		["FillTransparency"] = 5,
		["OutlineTransparency"] = 0.9
	},
	["ZombieAnimations"] = {
		["Idle"] = "rbxassetid://123853125836836",
		["Walk"] = "rbxassetid://82612942454422",
		["Run"] = "rbxassetid://131960707845050",
		["Attack"] = "rbxassetid://117010369333208",
		["Summon"] = "rbxassetid://128255194692185"
	},
	["ZombieSounds"] = {
		"rbxassetid://76300129914700",
		"rbxassetid://75031980306465",
		"rbxassetid://114884175043486",
		"rbxassetid://72464646842373",
		"rbxassetid://86796573151190",
		"rbxassetid://91635979840182",
		"rbxassetid://75031980306465",
		"rbxassetid://125446525810875",
		"rbxassetid://111164522467133",
		"rbxassetid://71792042432481",
		"rbxassetid://108085609328658",
		"rbxassetid://110860811084243"
	},
	["VoicelineVolume"] = 1.5,
	["Voicelines"] = {
		["KillPhilosopherTwotime"] = { "rbxassetid://114245972291102" },
		["KillMarvinDusekkar"] = { "rbxassetid://99621514500103" },
		["KillSuspicious007n7"] = { "rbxassetid://85316675007573" },
		["Slash"] = { "rbxassetid://137083809753977", "rbxassetid://91949672222834", "rbxassetid://89566015128317" },
		["Entanglement"] = { "rbxassetid://82390508720025", "rbxassetid://97553574746097" },
		["UnstableEye"] = { "rbxassetid://92942997397368", "rbxassetid://109833791295561" },
		["RejuvenateTheRotten"] = { "rbxassetid://113625683543509", "rbxassetid://90002573666818" },
		["MassInfection"] = { "rbxassetid://76012830600098", "rbxassetid://130993493562570" },
		["Idle"] = { "rbxassetid://87138405389179", "rbxassetid://76754359605984", "rbxassetid://81323229054212" },
		["Kill"] = { "rbxassetid://126380071020179", "rbxassetid://134352619919972", "rbxassetid://97525634554293" },
		["LastSurvivor"] = { "rbxassetid://123077413337179", "rbxassetid://98169746540851" },
		["Stunned"] = { "rbxassetid://101258282713414", "rbxassetid://90928132196219", "rbxassetid://83170190575273" }
	},
	["Sounds"] = {
		["EntanglementActivate"] = "rbxassetid://119524750889728",
		["RejuvenateTheRottenActivate"] = "rbxassetid://87209446803906",
		["MassInfectionActivate"] = "rbxassetid://71076595488781",
		["Swing"] = "rbxassetid://109431876587852"
	}
}
local v2 = {
	["Idle"] = "rbxassetid://84576483754206",
	["Walk"] = "rbxassetid://78699039349450",
	["Run"] = "rbxassetid://80760033755588",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://108772454550279",
		["CameraRig"] = "rbxassetid://92426226316147"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://134292666158183",
		["PlayerRig"] = "rbxassetid://93666484604456"
	},
	["Slash"] = "rbxassetid://85395695347005",
	["Entanglement"] = "rbxassetid://113745645636988",
	["UnstableEye"] = "rbxassetid://138017110758980",
	["RejuvenateTheRotten"] = "rbxassetid://137895497709601",
	["MassInfection"] = "rbxassetid://84312301245713",
	["Stunned"] = {
		["Start"] = "rbxassetid://91666868901845",
		["Loop"] = "rbxassetid://109962431018151",
		["End"] = "rbxassetid://91325129676721"
	}
}
v1.Animations = v2
return v1