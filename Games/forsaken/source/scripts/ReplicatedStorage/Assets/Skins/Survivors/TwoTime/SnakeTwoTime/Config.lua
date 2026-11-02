-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Snake",
	["Description"] = "A strong man doesn\'t need to read the future, he makes his own.",
	["RenderImage"] = "rbxassetid://124535764537598",
	["Price"] = 900,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	{
		["Happy"] = "rbxassetid://92317200600526",
		["Default"] = "rbxassetid://119681176655449",
		["Hurt"] = "rbxassetid://86191620969470",
		["Injured"] = "rbxassetid://102115140831237",
		["Dead"] = "rbxassetid://86191620969470",
		["Drinking"] = "rbxassetid://127683480058548"
	},
	{
		["Happy"] = "rbxassetid://130746088405205",
		["Default"] = "rbxassetid://98799720181504",
		["Hurt"] = "rbxassetid://81559636389968",
		["Injured"] = "rbxassetid://81579773553147",
		["Dead"] = "rbxassetid://110274952490633",
		["Drinking"] = "rbxassetid://73776620963624"
	}
}
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
return v1
