-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Soulmates",
	["Description"] = "\"Together Forever.\"",
	["RenderImage"] = "rbxassetid://132878432127886",
	["Price"] = 550,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	{
		["Happy"] = "rbxassetid://73801419823334",
		["Default"] = "rbxassetid://107817080140362",
		["Hurt"] = "rbxassetid://95754545239052",
		["Injured"] = "rbxassetid://128733580391339",
		["Dead"] = "rbxassetid://138106940272221",
		["Drinking"] = "rbxassetid://131775960481658"
	},
	{
		["Happy"] = "rbxassetid://73801419823334",
		["Default"] = "rbxassetid://107817080140362",
		["Hurt"] = "rbxassetid://95754545239052",
		["Injured"] = "rbxassetid://128733580391339",
		["Dead"] = "rbxassetid://138106940272221",
		["Drinking"] = "rbxassetid://131775960481658"
	}
}
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
return v1
