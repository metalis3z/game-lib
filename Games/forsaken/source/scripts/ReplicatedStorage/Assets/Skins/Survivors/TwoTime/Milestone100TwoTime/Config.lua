-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Milestone IV",
	["Description"] = "\"im sorry.\"",
	["RenderImage"] = "rbxassetid://101877729013693",
	["Price"] = -8,
	["Exclusive"] = true,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	{
		["Happy"] = "rbxassetid://100081868146027",
		["Default"] = "rbxassetid://122997300217527",
		["Hurt"] = "rbxassetid://96068134201022",
		["Injured"] = "rbxassetid://120755463690929",
		["Dead"] = "rbxassetid://103821172765374",
		["Drinking"] = "rbxassetid://102870335831035"
	},
	{
		["Happy"] = "rbxassetid://90557137985216",
		["Default"] = "rbxassetid://105800773101443",
		["Hurt"] = "rbxassetid://80889323166477",
		["Injured"] = "rbxassetid://127648530379756",
		["Dead"] = "rbxassetid://81402891638823",
		["Drinking"] = "rbxassetid://128336080486102"
	}
}
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
return v1
