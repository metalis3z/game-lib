-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Knight",
	["Quote"] = "\"Shoo!\"",
	["Credits"] = "",
	["Class"] = "Sentinel",
	["RenderImage"] = "rbxassetid://90318481007675",
	["Price"] = 50000,
	["Exclusive"] = true,
	["Speed"] = 12,
	["SlashDamage"] = 75,
	["SlashWindupTime"] = 0.575,
	["SlashStunTime"] = 3.25,
	["SlashCooldown"] = 40,
	["FriedChickenCooldown"] = 70,
	["FriedChickenActivationRequirement"] = 40,
	["FriedChickenHealDelay"] = 1.75,
	["FriedChickenHealInitialAmount"] = 15,
	["FriedChickenHealOvertimeAmount"] = 25,
	["FriedChickenHealOvertimeDuration"] = 5,
	["Expressions"] = {
		["Happy"] = "rbxassetid://128277497",
		["Default"] = "rbxassetid://97216249743044",
		["Hurt"] = "rbxassetid://114904253860911",
		["Injured"] = "rbxassetid://134323061188067",
		["Dead"] = "rbxassetid://113700503533465",
		["Drinking"] = "rbxassetid://90280461790500",
		["StunnedKiller"] = "rbxassetid://93712847953609"
	},
	["Animations"] = {
		["Slash"] = "rbxassetid://94536759067259",
		["EatChicken"] = "rbxassetid://88441526729222"
	},
	["Sounds"] = {
		["Unsheath"] = "rbxassetid://12222225",
		["Slash"] = "rbxassetid://12222208",
		["Hit"] = "rbxassetid://17837549788",
		["EatFriedChicken"] = ""
	}
}
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "SHEDLETSKY",
		["Text"] = "Blame John.\nAn important figure in Roblox history, he wields a historical Linked Sword to cut the killer in it\'s tracks.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health or 100) .. ("Regular Speed: %*\n"):format(v1.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v1.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain or 20)
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://85282571177550",
		["Header"] = "SLASH",
		["Quote"] = "\"Death before dishonor.\" - Shedletsky",
		["Text"] = ("Cooldown: %*s\n"):format(v1.SlashCooldown) .. ("Stun Time: %*\n"):format(v1.SlashStunTime) .. ("Damage: %*\n"):format(v1.SlashDamage) .. ("%* equips one of his many SFOTH swords and slashes forward, stunning the killer if the attack hits.\n"):format("Shedletsky") .. ("<b>Resistance II</b> is applied for %*s on activation."):format(v1.SlashWindupTime) .. ("Slows down the player by 75%% for %*s while in use.\n"):format(v1.SlashWindupTime + 1)
	},
	{
		["Image"] = "rbxassetid://87451970500470",
		["Header"] = "FRIED CHICKEN",
		["Quote"] = "\"You won the annual chicken eat off hosted by Shedletsky!\" - Builderman",
		["Text"] = ("Cooldown: %*s\n"):format(v1.FriedChickenCooldown) .. ("%* pulls out a piece of fried chicken and takes a bite out of it, restoring %* HP upon consumption and %* HP over the span of %*s. If %* is hit by a Killer during the period of regaining HP, then the healing effect is cancelled.\n"):format("Shedletsky", v1.FriedChickenHealInitialAmount, v1.FriedChickenHealOvertimeAmount, v1.FriedChickenHealOvertimeDuration, "Shedletsky") .. "<b>This ability can only be used twice.</b>\n"
	}
}
return v1
