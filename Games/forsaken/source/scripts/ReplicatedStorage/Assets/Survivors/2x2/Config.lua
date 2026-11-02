	local v0 = {
	["DisplayName"] = "2x2", 
	["Quote"] = "Robloxia was built out of nothing from the images of Two-by-Two.", 
	["Credits"] = "Made By: Ace1Dev, pash & Frost", 
	["Class"] = "Support", 
	["RenderImage"] = "rbxassetid://102307731887853", 
	["Price"] = 950,
	["Exclusive"] = true,
	["Health"] = 90, 
	["Speed"] = 10,

	["F3XBuildStart"] = 2,
	["F3XBuildEnd"] = 50,

	["WallHealth"] = 55,
	["WallTemplate"] = script.Wall,

	["LUACooldown"] = 50,

	["HighlightCooldown"] = 30,

	["WarningTemplate"] = script.Warning, 
	["Animations"] = {
		["Lua"] = "rbxassetid://78457791991781",
		["F3X"] = "rbxassetid://92728165666854"
	},
	["DelayBeforeLUASFX"] = 0.45,
	["Sounds"] = {
		["WallSpawned"] = "rbxasset://12221944",
		["LuaWriting"] = "rbxassetid://72834259394748",
		["Highlight"] = "rbxassetid://92548770928411"
	},
	TextInteractions = {
		Requests = {
			ElliotPizza = {
				"Hey buddy, could you provide some pizza?", 
				"One pizza please.",
				"Pizza for a full family, perhaps?",
				"If you want a promotion, throw me some pizza.",
			}, 
			BuildermanSentry = {
				"Mind building sentry here?",
				"Show them what you're made of.",
				"Imagination flows throught your mind, show them.",
				"You're a builder, not a coward.",
			}, 
			BuildermanDispenser = {
				"Mind building dispenser here?",
				"That fountain of yours could be useful here.",
				"Got spare parts for a dispenser?",
				"We aren't tanks, give us some heal.", 
			}, 
			DusekkarProtection = {
				"Could you use some magic to protect me?",
				"Hunted Pumpkin, Could you use your magic to protect me?",
				"Hello, may you please cast a spell on me?",
				"Regardless of your origin, can you cast a spell to protect me?",				
			}
		}, 
		Thanks = {
			Regular = {
				"Thanks.", 
				"I owe you.", 
				"Thank you.",
				"I'll make sure you are all protected.", 
				"All appreaciated.", 
				"Thank you for trusting me.", 
				"I assure you, I am more useful than two time.", 
			}
		}
	}
};
v0.Information = {
	{
		Separator = "GENERAL INFO"
	}, 
    {
		Header = "2x2",
		Text = "A clone of the real 2x2, it was enough to fool the spectre to bring them to this realm, armed with a script and a pencil, able to provide buffs and support. This Support class character uses F3X to build protective walls, LUA to empower teammates, and Highlight to reveal survivor locations, 2x2 excels at strategic gameplay and team assistance."
	}, 
	{
		Header = "STATS", 
		Text = "Difficulty: ★★★☆☆\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
	}, 
	{
		Separator = "ABILITIES"
	}, 
	{
		Image = "rbxassetid://119339667794819", 
		Header = "F3X", 
		Quote = "\"Copied, pasted, and recolored a million times.\" - The Chronicles of Roblox, VI.203", 
		Text = ("Cooldown: %*s\n"):format(v0.F3XBuildEnd) .. ("%* uses F3X to build a wall with %* HP. Survivors can phase through the wall, but killers cannot.\n"):format("2x2", v0.WallHealth)
	}, 
	{
		Image = "rbxassetid://120565969647024", 
		Header = "LUA", 
		Quote = "\"Spoken of only in hushed tones, and known simply as 'Lua' - the tongue of the gods.\" - The Chronicles of Roblox, VIII.512", 
		Text = ("Cooldown: %*s\n"):format(v0.LUACooldown) .. "Provides buffs to nearby teammates. The type of buff depends on the teammate's class (e.g., Sentinel receives a Strength buff). The buff level is determined by proximity."
	}, 
	{
		Image = "rbxassetid://91098605189229", 
		Header = "Highlight", 
		Quote = "\"In the darkness, a glimmer of hope shines through.\" - The Chronicles of Roblox, IX.317", 
		Text = ("Cooldown: %*s\n"):format(v0.HighlightCooldown) .. "Reveals auras for all survivors for a short period, but killers cannot see these auras."
	},
};
return v0;