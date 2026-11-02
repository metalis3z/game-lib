-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Spiral",
	["Description"] = "Swirly swirly swirly swirl",
	["RenderImage"] = "rbxassetid://106665727250445",
	["Price"] = 600,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	{
		["Happy"] = "rbxassetid://81896815825257",
		["Default"] = "rbxassetid://73483634925418",
		["Hurt"] = "rbxassetid://93421870784694",
		["Injured"] = "rbxassetid://133089396665213",
		["Dead"] = "rbxassetid://133611309054814",
		["Drinking"] = "rbxassetid://99335439385081"
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
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
return v1
