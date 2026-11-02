-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Mad Murderer",
	["Description"] = "\"He's a murderer... who's mad.\"",
	["RenderImage"] = "rbxassetid://98492192710389",
	["Price"] = 1000,
	["LifeAppearances"] = { script.Life1, script.Life2 },
	["DaggerTemplate"] = script.GhostFire,
}
local v3 = {
	{
		["Happy"] = "rbxassetid://66319713",
		["Default"] = "rbxassetid://66319713",
		["Hurt"] = "rbxassetid://66319713",
		["Injured"] = "rbxassetid://66319713",
		["Dead"] = "rbxassetid://66319713",
		["Drinking"] = "rbxassetid://66319713"
	},
	{
		["Happy"] = "",
		["Default"] = "",
		["Hurt"] = "",
		["Injured"] = "",
		["Dead"] = "",
		["Drinking"] = ""
	}
}
v1.ExpressionsTable = v3
v1.Expressions = v1.ExpressionsTable[1]
return v1
