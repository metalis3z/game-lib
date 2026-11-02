-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Betrayed",
	["Description"] = "What if 1x1x1x1 was BETRAYED by their MINIONS and TRAPPED in the Hyperbolic Time Chamber for 1000 YEARS?",
	["RenderImage"] = "rbxassetid://71249871529079",
	["Price"] = 1750,
	["ShockwaveTemplate"] = script.shockwave,
	["IntroHeadTemplate"] = script.ShedletskyHead
}
local v2 = {
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://115767034978741",
		["CameraRig"] = "rbxassetid://100930424949543"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://81477052159423",
		["PlayerRig"] = "rbxassetid://87675470206257"
	}
}
v1.Animations = v2
local v3 = {
	["Execution"] = "rbxassetid://110207124817125"
}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://107070302987454",
		["BPM"] = 180,
		["Volume"] = 0.5
	},
	[40] = {
		["ID"] = "rbxassetid://134585079565548",
		["BPM"] = 180,
		["Volume"] = 0.55
	},
	[20] = {
		["ID"] = "rbxassetid://92439253798173",
		["BPM"] = 180,
		["Volume"] = 0.6
	},
	[6] = {
		["ID"] = "rbxassetid://133520003838281",
		["BPM"] = 180,
		["Chase"] = true,
		["Volume"] = 0.6
	}
}
v3.TerrorRadiusThemes = v4
v1.Sounds = v3
v1.ZombieSounds = {
	"rbxassetid://126017196582189",
	"rbxassetid://134761246576517",
	"rbxassetid://84984386102819",
	"rbxassetid://140580104368114",
	"rbxassetid://125605651219976"
}
v1.Voicelines = {
	["Entanglement"] = { "rbxassetid://106994272980327" },
	["UnstableEye"] = { "rbxassetid://129901035191749" },
	["RejuvenateTheRotten"] = { "rbxassetid://78041913533698" },
	["MassInfection"] = { "rbxassetid://114646008406304" },
	["Idle"] = {
		"rbxassetid://113118853313205",
		"rbxassetid://77328137307964",
		"rbxassetid://136607111188033",
		"rbxassetid://101901762179556",
		"rbxassetid://134529403692715",
		"rbxassetid://109485927366688",
		"rbxassetid://76009425717754",
		"rbxassetid://119198843869076",
		"rbxassetid://92202221274287",
		"rbxassetid://134414371505497",
		"rbxassetid://92825683059116",
		"rbxassetid://112114580217969",
		"rbxassetid://129423678164502",
		"rbxassetid://83391713442330"
	},
	["KillTwoTime"] = { "rbxassetid://131210668728776" },
	["Kill007n7"] = { "rbxassetid://132523322140563" },
	["KillBuilderman"] = { "rbxassetid://71640525380963" },
	["KillElliot"] = { "rbxassetid://99132664911059" },
	["KillChance"] = { "rbxassetid://90624633641932" },
	["Kill"] = { "rbxassetid://98461790463705" },
	["LastSurvivor"] = { "rbxassetid://75060445259647" },
	["Stunned"] = {
		"rbxassetid://109107749559883",
		"rbxassetid://108318954633386",
		"rbxassetid://133438861695706",
		"rbxassetid://105012462066802",
		"rbxassetid://140101251977240",
		"rbxassetid://120316975343699",
		"rbxassetid://100461477121647",
		"rbxassetid://82159624096158",
		"rbxassetid://82257745823344",
		"rbxassetid://103877325558951",
		"rbxassetid://109107749559883",
		"rbxassetid://108318954633386",
		"rbxassetid://133438861695706",
		"rbxassetid://105012462066802",
		"rbxassetid://140101251977240",
		"rbxassetid://120316975343699",
		"rbxassetid://100461477121647",
		"rbxassetid://82159624096158",
		"rbxassetid://82257745823344",
		"rbxassetid://103877325558951",
		"rbxassetid://118354887061853",
		"rbxassetid://128730548457552"
	}
}
return v1