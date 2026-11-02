-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Pursuer",
	["Description"] = "All of their prey shall be pursued too.",
	["RenderImage"] = "rbxassetid://133238058361890",
	["Price"] = 2500,
	--["Exclusive"] = true,
	["CollabInfo"] = "DieOfDeath"
}
local v2 = {
	["Idle"] = "rbxassetid://75980871118144",
	["Walk"] = "rbxassetid://74003488669165",
	["Run"] = "rbxassetid://104334895884470",
	["Stunned"] = {
		["Start"] = "rbxassetid://129419463516167",
		["Loop"] = "rbxassetid://71820566235013",
		["End"] = "rbxassetid://132585989175127"
	},
	["EnragedStart"] = "rbxassetid://100934751873804",
	["Execution"] = {
		["KillerRig"] = "rbxassetid://115813113414152",
		["PlayerRig"] = "rbxassetid://76248608885221"
	},
	["Slash"] = "rbxassetid://123129347700847",
	["Behead"] = "rbxassetid://86363613447373",
	["GashingWoundStart"] = "rbxassetid://118283090258503",
	["GashingWound"] = {
		["KillerRig"] = "rbxassetid://108734749479589",
		["PlayerRig"] = "rbxassetid://138383271901177"
	}
}
v1.Animations = v2
v1.Sounds = {
	["Footsteps"] = { "rbxassetid://99809965759734", "rbxassetid://79222929114377" }
}
return v1
