-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Noob",
	["Quote"] = "\"Bottoms up! Cant get worse than this, right?\"",
	["Credits"] = "",
	["Class"] = "Survivalist",
	["RenderImage"] = "rbxassetid://78235240844505",
	["Price"] = 0,
	["Health"] = 100,
	["Speed"] = 12,
	["BloxyColaCooldown"] = 50,
	["BloxyColaSpeedTime"] = 10,
	["DrinkingColaSpeedMultiplier"] = 0.9,
	["BloxyColaAwardThreshold"] = 140,
	["SlateskinPotionCooldown"] = 55,
	["SlateskinEffectDuration"] = 6,
	["SlateskinSpeedDuration"] = 2,
	["SlateskinLevel"] = 2,
	["DrinkingSlateskinSpeedMultiplier"] = 0.6,
	["GhostburgerCooldown"] = 45,
	["GhostburgerUndetectableTime"] = 10,
	["GhostburgerInvisibilityTime"] = 10,
	["EatingSpeedMultiplier"] = 0.6,
	["Expressions"] = {
		["Happy"] = "rbxassetid://71475106359341",
		["Default"] = "rbxassetid://112904982368692",
		["Hurt"] = "rbxassetid://101124864542865",
		["Injured"] = "rbxassetid://87716232019856",
		["Dead"] = "rbxassetid://86936166426860",
		["Drinking"] = "rbxassetid://109402953259825",
		["EatStart"] = "rbxassetid://77577482028526",
		["Eating"] = "rbxassetid://140728535975340"
	},
	["Animations"] = {
		["Drinking1"] = "rbxassetid://72664176232879",
		["Drinking2"] = "rbxassetid://107756957977722",
		["Eating"] = "rbxassetid://88441526729222"
	},
	["Sounds"] = {
		["GhostburgerEffect"] = "rbxassetid://89796139014135"
	}
}
local v2 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"N-Need pizza..!",
			"I r-really could use some pizza...",
			"P-Pizza..! Please!!",
			"Need pizza! Quick!!",
			"I-I need pizza..!"
		},
		["BuildermanSentry"] = {
			"Get the sentry going over here..!",
			"O-Over here! Sentry!",
			"Sentry here..!",
			"Place a sentry here..!",
			"N-Need a sentry!"
		},
		["BuildermanDispenser"] = {
			"G-Get the dispenser going over here..!",
			"Dispenser! H-Here..!",
			"Need a d-dispenser over here!",
			"Dispenser here..!",
			"Place the dispenser here! H-Hurry!!"
		},
		["DusekkarProtection"] = {
			"P-Protect me with your force field..!",
			"I need some magic..! P-Please..!",
			"C-Cast your force field..!",
			"N-need a defense..!",
			"Cast your magical shield..!"
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"T-Thank you..",
			"Thanks..",
			"Phew.. t-thanks..",
			"Thank you...",
			"I-I dunno how I could repay you..",
			"Thank you..!"
		}
	}
}
v1.TextInteractions = v2
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "NOOB",
		["Text"] = "A big snack person at heart, Noob has a handful of food items at their disposal. Sneaking by with their ghostburger, moving faster with their cola, and tanking damage with their slateskin, they\'re scared, but still pushes on, wanting to find an escape.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health or 100) .. ("Regular Speed: %*\n"):format(v1.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v1.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain or 20)
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://133994175153795",
		["Header"] = "BLOXY COLA",
		["Quote"] = "\"Warning: Bloxy Cola may be habit-forming.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v1.BloxyColaCooldown) .. ("%* pulls out a Bloxy Cola and takes a sip of it to gain <b>Speed I</b> for %*s.\n"):format("Noob", v1.BloxyColaSpeedTime) .. "10% less speed & cannot sprint while drinking.\nAny pre-existing <b>Slowness</b> status is removed upon consumption.\nDrinking a Bloxy Cola item will put this move on cooldown and grant less Speed."
	},
	{
		["Image"] = "rbxassetid://133354880475554",
		["Header"] = "SLATESKIN POTION",
		["Quote"] = "\"IM ROCK SOLID!!\" - Homeless Guy",
		["Text"] = ("Cooldown: %*s\n"):format(v1.SlateskinPotionCooldown) .. ("%* pulls out a Slate-skin Potion and takes a sip of it to gain <b>Slateskin II</b> for %*s.\n"):format("Noob", v1.SlateskinEffectDuration) .. ("If the slateskin effect wears off naturally, %* gains <b>Speed II</b> for %*s.\n"):format("Noob", v1.SlateskinSpeedDuration) .. ("%* can also instead activate the ability again to cancel its effects early, gaining <b>Speed I</b> for the same duration.\n"):format("Noob") .. "40% less speed & cannot sprint while drinking.\n"
	},
	{
		["Image"] = "rbxassetid://112547374697556",
		["Header"] = "GHOSTBURGER",
		["Quote"] = "\"What happens if you eat a ghost? You\'ll find out.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v1.GhostburgerCooldown) .. ("%* takes a bite of a Ghostburger and gains <b>Undetectable I</b> for %*s and <b>Invisibility IV</b> for %*s.\n"):format("Noob", v1.GhostburgerUndetectableTime, v1.GhostburgerInvisibilityTime) .. "40% less speed & cannot sprint while eating.\n"
	}
}
return v1
