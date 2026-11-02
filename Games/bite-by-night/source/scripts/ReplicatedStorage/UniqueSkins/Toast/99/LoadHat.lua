-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Load"] = function(p1)
		local v2 = script:FindFirstChild("Toast"):Clone()
		v2.Weld.Part0 = p1.RootPart
		v2.Parent = p1.Character
		v2.VFX.Enabled = true
	end
}