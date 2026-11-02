-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Data.Types.RarityTypes)
local v5 = {
	["MoonGlow"] = {
		["DisplayName"] = "Moon Glow",
		["Description"] = "Gives a small boost to money earned on this Brainrot",
		["Color"] = Color3.fromRGB(215, 131, 255),
		["Icon"] = "rbxassetid://139866299084982",
		["Multiplier"] = 2,
		["Chance"] = 15,
		["Rarity"] = "Common",
		["VFXCallback"] = function(p2)
			script.SetupTraitVFX:FireAllClients(p2, script.MoonGlowVFX)
			return p2
		end
	},
	["Signed_Caylus"] = {
		["DisplayName"] = "Signed Caylus",
		["Description"] = "Gives a big boost to money earned on this Brainrot",
		["Color"] = Color3.fromRGB(0, 253, 255),
		["Icon"] = "rbxassetid://72325994445844",
		["Multiplier"] = 4,
		["Chance"] = 0,
		["Rarity"] = "Common",
		["VFXCallback"] = function(p3)
			script.SetupTraitVFX:FireAllClients(p3, script.Signed_Caylus)
			return p3
		end
	},
	["Signed_Steak"] = {
		["DisplayName"] = "Signed Steak",
		["Description"] = "Gives a big boost to money earned on this Brainrot",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["Icon"] = "rbxassetid://94831708806618",
		["Multiplier"] = 2,
		["Chance"] = 0,
		["Rarity"] = "Common",
		["VFXCallback"] = function(p4)
			script.SetupTraitVFX:FireAllClients(p4, script.Signed_Steak)
			return p4
		end
	}
}
return v5
