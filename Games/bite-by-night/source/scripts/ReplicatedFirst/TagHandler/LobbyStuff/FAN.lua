-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["OnFrame"] = function(p1, p2)
		p1.CFrame = p1.CFrame * CFrame.identity:Lerp(p1:GetAttribute("Rotation"), p2 * 50)
	end
}