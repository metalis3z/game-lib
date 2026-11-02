-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Milestone III",
	["Description"] = "\"You trusted me in the same way that I did with you, so...\"",
	["RenderImage"] = "rbxassetid://104142688052646",
	["Price"] = -7,
	["Exclusive"] = true,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	{
		["Happy"] = "rbxassetid://107373406815990",
		["Default"] = "rbxassetid://78529874926911",
		["Hurt"] = "rbxassetid://94147533931285",
		["Injured"] = "rbxassetid://94947623246188",
		["Dead"] = "rbxassetid://120354269801368",
		["Drinking"] = "rbxassetid://78003037092465"
	},
	{
		["Happy"] = "rbxassetid://91814717165580",
		["Default"] = "rbxassetid://119334962407174",
		["Hurt"] = "rbxassetid://123297604838681",
		["Injured"] = "rbxassetid://131670668989528",
		["Dead"] = "rbxassetid://76654746338543",
		["Drinking"] = "rbxassetid://119958305378369"
	}
}
v1.ExpressionsTable = v2
v1.Expressions = v1.ExpressionsTable[1]
return v1
