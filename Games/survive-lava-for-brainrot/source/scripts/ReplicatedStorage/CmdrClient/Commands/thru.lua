-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v7 = {
	["Name"] = "thru",
	["Aliases"] = { "t", "through" },
	["Description"] = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "Extra distance",
			["Description"] = "Go through the wall an additional X studs.",
			["Default"] = 0
		}
	},
	["ClientRun"] = function(p1, p2)
		local v3 = p1.Executor:GetMouse()
		local v4 = p1.Executor.Character
		if not (v4 and v4:FindFirstChild("HumanoidRootPart")) then
			return "You don\'t have a character."
		end
		local v5 = v4.HumanoidRootPart.Position
		local v6 = v3.Hit.p - v5
		v4:MoveTo(v6 * 2 + v6.unit * p2 + v5)
		return "Blinked!"
	end
}
return v7
