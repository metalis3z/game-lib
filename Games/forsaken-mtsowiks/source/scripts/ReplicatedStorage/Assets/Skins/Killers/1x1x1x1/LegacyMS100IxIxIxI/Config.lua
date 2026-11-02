-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Legacy Milestone IV",
	["RenderImage"] = "rbxassetid://134723107602507",
	["Price"] = -4,
	["Exclusive"] = true,
	["ZombieTemplate"] = script.Zombie
}
local v2 = {}
local v3 = {
	[60] = {
		["ID"] = "rbxassetid://134401618182127",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://98233008447765",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://116767422395352",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://119288731635823",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v2.TerrorRadiusThemes = v3
v1.Sounds = v2
return v1