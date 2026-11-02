-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Tester",
	["Description"] = "tester exclusive skin",
	["RenderImage"] = "rbxassetid://75356450551706",
	["Price"] = 700,
	["Expressions"] = false,
	["DaggerTemplate"] = script.GhostFire,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	["Requests"] = {
		["ElliotPizza"] = { "pizza." },
		["BuildermanSentry"] = { "sentry." },
		["BuildermanDispenser"] = { "dispenser." },
		["DusekkarProtection"] = { "shield." }
	},
	["Thanks"] = {
		["Regular"] = { "thanks." }
	}
}
v1.TextInteractions = v2
return v1
