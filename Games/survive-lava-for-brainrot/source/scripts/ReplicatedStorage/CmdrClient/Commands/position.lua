-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v4 = {
	["Name"] = "position",
	["Aliases"] = { "pos" },
	["Description"] = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "Player",
			["Description"] = "The player to report the position of. Omit for your own position.",
			["Default"] = game:GetService("Players").LocalPlayer
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = p1.Character
		if not (v2 and v2:FindFirstChild("HumanoidRootPart")) then
			return ""
		end
		local v3 = v2.HumanoidRootPart.Position
		return tostring(v3):gsub("%s", "")
	end
}
return v4
