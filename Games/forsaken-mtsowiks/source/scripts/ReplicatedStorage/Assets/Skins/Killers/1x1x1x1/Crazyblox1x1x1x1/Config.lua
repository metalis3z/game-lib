-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Crazyblox",
	["Description"] = "Play my game.",
	["RenderImage"] = "rbxassetid://76399528506168",
	["CollabInfo"] = "FE2",
	["Price"] = 0,
	["Exclusive"] = true,
	["HighlightDisabled"] = true,
	["ShockwaveTemplate"] = script.Shockwave,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["PopupsFolder"] = script.Popups,
	["ForcedIntroTime"] = 5.48
}
local v2 = {}
local v3 = {
	[60] = {
		["ID"] = "rbxassetid://108116995839367",
		["BPM"] = 162
	},
	[40] = {
		["ID"] = "rbxassetid://109012506302912",
		["BPM"] = 162
	},
	[20] = {
		["ID"] = "rbxassetid://118943226495805",
		["BPM"] = 162
	},
	[6] = {
		["ID"] = "rbxassetid://97069344009582",
		["BPM"] = 162,
		["Chase"] = true
	}
}
v2.TerrorRadiusThemes = v3
v2.Ambience = "rbxassetid://84297011042368"
v2.ExecutionShedletsky = "rbxassetid://101937735233107"
v2.ExecutionCrazybloxShedletsky = "rbxassetid://70661308751431"
v2.Execution = "rbxassetid://79211255653744"
v2.EntanglementActivate = "rbxassetid://91488514366191"
v2.EntanglementProjectile = "rbxassetid://106187557897417"
v2.Swing = "rbxassetid://98111231282218"
v2.RejuvenateTheRottenActivate = "rbxassetid://135436619867662"
v2.MassInfectionActivate = "rbxassetid://117606000968679"
v2.MassInfectionProjectile = "rbxassetid://70417421101522"
v2.UnstableEyeActivate = "rbxassetid://81232859122579"
v2.Introduction = "rbxassetid://78510662636242"
v2.VictoryTheme = "rbxassetid://134019136653513"
v1.Sounds = v2
local v4 = {
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://103523977603471",
		["MoveablesRig"] = "rbxassetid://130602902331269",
		["CameraRig"] = "rbxassetid://102336221520624"
	},
	["Victory"] = {
		["KillerRig"] = "rbxassetid://121286048169497",
		["CameraRig"] = "rbxassetid://104395428591968",
		["GuideRig"] = "rbxassetid://100865760174595"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://75608161132144",
		["PlayerRig"] = "rbxassetid://110102218456056"
	},
	["ExecutionCrazybloxShedletsky"] = {
		["KillerRig"] = "rbxassetid://126140499221265",
		["PlayerRig"] = "rbxassetid://91185687119345"
	}
}
v1.Animations = v4
v1.Relations = { "CrazybloxShedletsky" }
local v5 = {
	["ThemeID"] = "rbxassetid://109769273701218",
	["ThemeProperties"] = {
		["Volume"] = 1.2
	},
	["RoundTime"] = 91
}
v1.LastManStandingEmotionalData = v5
v1.Voicelines = {
	["Entanglement"] = { "rbxassetid://73409686638926", "rbxassetid://103416353954959" },
	["UnstableEye"] = { "rbxassetid://82043393693463", "rbxassetid://78192648316735", "rbxassetid://112303848066233" },
	["RejuvenateTheRotten"] = { "rbxassetid://87193796108132", "rbxassetid://115350578493464" },
	["MassInfection"] = { "rbxassetid://111174583105136", "rbxassetid://101095408881855" },
	["Idle"] = {
		"rbxassetid://135951207232930",
		"rbxassetid://138714968970362",
		"rbxassetid://96449501593383",
		"rbxassetid://124901081421048",
		"rbxassetid://81878271020097",
		"rbxassetid://81620047104048",
		"rbxassetid://128321109926458",
		"rbxassetid://80249697784930"
	},
	["KillTwoTime"] = { "rbxassetid://110308422783733", "rbxassetid://108228138167292", "rbxassetid://99469207903913" },
	["KillVeeronica"] = { "rbxassetid://96747959709799", "rbxassetid://115118676683527" },
	["KillGuest1337"] = { "rbxassetid://85304117420723" },
	["KillBuilderman"] = { "rbxassetid://122103455212469" },
	["KillElliot"] = { "rbxassetid://89355829217703", "rbxassetid://127247723711794" },
	["KillChance"] = { "rbxassetid://90214315945812", "rbxassetid://113997514631977" },
	["Kill"] = {
		"rbxassetid://86208179038221",
		"rbxassetid://122678258079204",
		"rbxassetid://78679840027408",
		"rbxassetid://96413289770166",
		"rbxassetid://91330251320850",
		"rbxassetid://107583807107354"
	},
	["KillCrazybloxShedletsky"] = {
		"rbxassetid://100678421884758",
		"rbxassetid://112858146390421",
		"rbxassetid://96858590738629",
		"rbxassetid://95201266860079",
		"rbxassetid://133807372451007",
		"rbxassetid://99319991501244",
		"rbxassetid://110529687439548"
	},
	["LastSurvivor"] = { "rbxassetid://127048709274933", "rbxassetid://134336400831341" },
	["LastSurvivorCrazybloxShedletsky"] = { "rbxassetid://79299738080097" },
	["Stunned"] = {
		"rbxassetid://92009986613560",
		"rbxassetid://97869400102171",
		"rbxassetid://81946887354028",
		"rbxassetid://86030413803829"
	},
	["StunnedCrazybloxShedletsky"] = { "rbxassetid://74059878269089", "rbxassetid://71337349363311", "rbxassetid://138771805421889" }
}
return v1