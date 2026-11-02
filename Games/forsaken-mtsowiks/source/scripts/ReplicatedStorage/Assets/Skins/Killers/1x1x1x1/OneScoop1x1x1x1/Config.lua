-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "One Scoop",
	["Description"] = "Born from hatred of being locked within a freezer.",
	["RenderImage"] = "rbxassetid://86619242937134",
	["Price"] = 1500,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["PopupsFolder"] = script.Popups,
	["ShockwaveTemplate"] = script.Shockwave,
	["Exclusive"] = true,
	["Christmas"] = true,
	["CollabInfo"] = "C00lChristmas",
	["HighlightDisabled"] = true,
	["Gradient"] = "Christmas"
}
local v2 = {
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://95656923529826",
		["CameraRig"] = "rbxassetid://118564065879511"
	}
}
v1.Animations = v2
v1.Sounds = {
	["EntanglementHit"] = "rbxassetid://129108619555351",
	["Hit"] = "rbxassetid://97809050326435",
	["Introduction"] = "rbxassetid://100194690312380"
}
return v1