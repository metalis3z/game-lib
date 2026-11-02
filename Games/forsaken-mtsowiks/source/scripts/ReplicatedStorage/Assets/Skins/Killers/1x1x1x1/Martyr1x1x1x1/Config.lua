-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Martyr",
	["Description"] = "I\'ll cut you into pieces!",
	["RenderImage"] = "rbxassetid://115707947869291",
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["IntroLighting"] = script.IntroLighting,
	["OutroLighting"] = script.OutroLighting,
	["ShockwaveTemplate"] = script.Shockwave,
	["PopupsFolder"] = script.Popups,
	["CollabInfo"] = "BattleBricks",
	["Price"] = 1750,
	["Exclusive"] = true,
	["HighlightDisabled"] = true
}
local v2 = {
	["Idle"] = "rbxassetid://106759832660887",
	["Walk"] = "rbxassetid://107444338681374",
	["Run"] = "rbxassetid://114248543820857",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://122016727011404",
		["CameraRig"] = "rbxassetid://125185304157516"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://82938627501519",
		["PlayerRig"] = "rbxassetid://136993093571748"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://93917098864216",
		["PlayerRig"] = "rbxassetid://83769713926145"
	},
	["Slash"] = "rbxassetid://81658439732301",
	["Entanglement"] = "rbxassetid://109851082100781",
	["UnstableEye"] = "rbxassetid://80937690905871",
	["RejuvenateTheRotten"] = "rbxassetid://127321595320030",
	["MassInfection"] = "rbxassetid://107168691980887",
	["Victory"] = {
		["KillerRig"] = "rbxassetid://82036231867030",
		["CameraRig"] = "rbxassetid://97990490336935"
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://114449687784580",
		["Loop"] = "rbxassetid://93517620997711",
		["End"] = "rbxassetid://90095415402041"
	}
}
v1.Animations = v2
local v3 = {}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://132490388017112",
		["BPM"] = 180,
		["Volume"] = 0.8
	},
	[40] = {
		["ID"] = "rbxassetid://132041167155216",
		["BPM"] = 180,
		["Volume"] = 0.8
	},
	[20] = {
		["ID"] = "rbxassetid://106263882846132",
		["BPM"] = 180,
		["Volume"] = 0.8
	},
	[6] = {
		["ID"] = "rbxassetid://124985292040656",
		["BPM"] = 180,
		["Chase"] = true,
		["Volume"] = 0.8
	}
}
v3.TerrorRadiusThemes = v4
v3.EntanglementActivate = {
	["SoundId"] = "rbxassetid://75675413747752",
	["Volume"] = 0.25
}
v3.EntanglementProjectile = "rbxassetid://79665854201966"
v3.UnstableEyeActivate = "rbxassetid://106754297283515"
v3.UnstableEyeMode = "rbxassetid://134037097890097"
v3.RejuvenateTheRottenActivate = {
	["SoundId"] = "rbxassetid://124122529017069",
	["Volume"] = 0.15
}
v3.RejuvenateTheRottenRevive = "rbxassetid://102233628962479"
v3.RejuvenateTheRottenMinionIdle = "rbxassetid://87377456253729"
v3.RejuvenateTheRottenMinionHit = "rbxassetid://132370686359251"
v3.MassInfectionActivate = "rbxassetid://87903108158897"
v3.MassInfectionProjectile = "rbxassetid://136644374644573"
v3.Chains = "rbxassetid://97061990471922"
v3.Stunned = {
	["Start"] = "rbxassetid://96088755180918",
	"rbxassetid://83448793881201",
	"rbxassetid://84090797830396",
	["End"] = "rbxassetid://102731091551965"
}
v3.Execution = "rbxassetid://131736403184280"
v3.ExecutionShedletsky = "rbxassetid://78213259762406"
v3.Swing = {
	["SoundId"] = "rbxassetid://121954639447247",
	["Volume"] = 0.25
}
v3.Hit = {
	["SoundId"] = "rbxassetid://121954639447247",
	["Volume"] = 0.25
}
v3.Introduction = "rbxassetid://78556814958046"
v3.VictoryTheme = "rbxassetid://83451901921830"
v1.Sounds = v3
return v1