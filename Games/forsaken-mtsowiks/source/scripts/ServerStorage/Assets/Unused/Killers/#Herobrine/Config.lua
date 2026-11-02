-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Herobrine",
	Information = {},
	["Quote"] = "\"Heh, I quite like that name, you wouldn\'t mind if I take it?\"",
	["Credits"] = "By: AndrewD0tWeb",
	["Price"] = 824,
	["Health"] = 1100,
	["Speed"] = 10,
	["SprintSpeed"] = 26,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 20,
	["MaxStamina"] = 85,
	["SeeYouDMG"] = 25,
	["FoundYouDMG"] = 35,
	["FlickCooldown"] = 3.5,
	["SeeYouCooldown"] = 1.5,
	["StopDMG"] = 15,
	["Error404"] = 25,
	["StopSpeed"] = 150,
	["Error404Speed"] = 100,
	["Flick"] = 20,
	["PizzaDeliveryGuyLifetime"] = 30,
	["PizzaDeliveryGuyAttackRadius"] = 6,
	["PizzaDeliveryGuySpeed"] = math.random(20, 30),
	["PizzaDeliveryGuyHealth"] = 20,
	["PizzaDeliveryGuyDamage"] = 10,
	["SteveRig"] = script.SteveRig,
	["PizzaDeliveryAnimations"] = {
		["Idle"] = "rbxassetid://71653833381679",
		["Walk"] = "rbxassetid://129296241165036",
		["Hit"] = "rbxassetid://131068219461510"
	},
	IntroLighting = script.IntroLighting
}
local v2 = {
	["Idle"] = "rbxassetid://71653833381679",
	["Walk"] = "rbxassetid://98414520694109",
	["Run"] = "rbxassetid://115654827946517",
	["BetterIdle"] = "rbxassetid://71653833381679",
	["BetterWalk"] = "rbxassetid://106303428199847",
	["BetterRun"] = "rbxassetid://88882568513645",
	["FoundYou"] = "rbxassetid://88972448530806",
	["SeeYou"] = "rbxassetid://131068219461510",
	["Stop"] = "rbxassetid://122958777437283",
	["Stunned"] = {
		["Start"] = "rbxassetid://129567564849167",
		["Loop"] = "rbxassetid://115543253597725",
		["End"] = "rbxassetid://113280467124378"
	},
	["Introduction"] = {
		["CameraRig"] = "rbxassetid://86232019426186",
		["KillerRig"] = "rbxassetid://75074346189205"
	},
	["Execution"] = {
		KillerRig = "rbxassetid://138281416003734", 
		PlayerRig = "rbxassetid://109348007876595",
	},
}
v1.Animations = v2
local v3 = {
	["Footsteps"] = { "rbxassetid://99809965759734", "rbxassetid://79222929114377" },
	["Swing"] = "rbxassetid://83336588073857",
	["Hit"] = "rbxassetid://77489039478990",
	["Hit2"] = "rbxassetid://123382023942074",
	["Flick"] = "rbxassetid://105559729303238",
	["Stop"] = "rbxassetid://106841831666549",
	Introduction = "rbxassetid://76708376628522"
}
local v4 = {
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
		["ID"] = "rbxassetid://101444285469398",
		["BPM"] = 72,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v1.Sounds = v3
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = v1.DisplayName,
		["Text"] = "A forgotten soul now manifested elsewhere, Herobrine is more than just a myth. Denied and betrayed by his own brother, he haunts the static between realms, searching for those who dare question his existence. Gifted with unauthorised access to operator commands, he phases through objects at the blink of an eye, summon entities, and give himself stockpiles of items at will.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "SEE YOU",
		["Quote"] = "\"Herobrine does not, and has never been a part of Minecraft, nor do I have a dead brother.\" - \226\150\136\226\150\136\226\150\136\226\150\136",
		["Text"] = "Cooldown: 1.5s\n" .. ("Damage: %*\n"):format(v1.FoundYouDMG) .. "<font color=\"rgb(0,164,186)\">Herobrine</font> Swings forward with his obsidian fist.\n"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "FLICK",
		["Quote"] = "\"Looking back at me was another character with the default skin, but his eyes were empty.\" - Forum User",
		["Text"] = "Cooldown: 2s\n" .. "<font color=\"rgb(0,164,186)\">Herobrine</font> instantly teleports "..tostring(v1.Flick).." studs in front of himself, phasing through any objects that may be in his way. \n"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "STOP",
		["Quote"] = "\"- Removed Herobrine\" - Beta 1.6.6 Changelog",
		["Text"] = "Cooldown: 15s\n" .. ("Damage: %*\n"):format(v1.StopDMG) .. "After a long windup, <font color=\"rgb(0,164,186)\">Herobrine</font> launches a high-speed cobblestone projectile. If it connects with a survivor, the survivor will gain <b>Slowness I</b> for 10 seconds and <b>Blindness I</b> for 5 seconds.\n"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "SUMMON",
		["Quote"] = "\"/summon minecraft:player\" - Herobrine",
		["Text"] = ("Cooldown: %*s\n"):format(35) .. ("Damage: %*\n"):format(v1.PizzaDeliveryGuyDamage) .. "After a windup of 0.75 seconds, <font color=\"rgb(0,164,186)\">Herobrine</font> summons two fake player entities. They automatically seek out the closest survivors.\nIf a survivor is damaged by a bot, their aura is revealed to <font color=\"rgb(0,164,186)\">Herobrine</font> for 7.5 seconds and gains <b>Slowness II</b> for 3 seconds.\n"
	}
}
return v1
