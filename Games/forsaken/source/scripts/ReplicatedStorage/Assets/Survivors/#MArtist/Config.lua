-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Martial Artist",
	["Quote"] = "\"literally just kai guy\"",
	["Credits"] = "",
	["Class"] = "Sentinel",
	["RenderImage"] = "rbxassetid://12702707829",
	["Price"] = 500,
	["Exclusive"] = true,
	["Health"] = 900,
	["Speed"] = 12
}
local v2 = {
	["Idle"] = "rbxassetid://112525050687951",
	["Walk"] = "rbxassetid://126588373713474",
	["Run"] = "rbxassetid://133731129920585",
	["QuickAttack"] = "rbxassetid://121393534664326",
	["GashingWoundStart"] = "rbxassetid://96847672076759",
	["GashingWound"] = {
		["KillerRig"] = "rbxassetid://102217908627778",
		["PlayerRig"] = "rbxassetid://112904042427189"
	}
}
v1.Animations = v2
v1.Sounds = {
	["GashingWoundSwing"] = "rbxassetid://129697992204296",
	["GashingWoundMiss"] = "rbxassetid://84353899757208",
	["GashingWoundHit1"] = "rbxassetid://8595980577",
	["GashingWoundHit2"] = "rbxassetid://8595983255",
	["GashingWoundHit3"] = "rbxassetid://8595977193",
	["GashingWoundHit4"] = "rbxassetid://441202925"
}
return v1
