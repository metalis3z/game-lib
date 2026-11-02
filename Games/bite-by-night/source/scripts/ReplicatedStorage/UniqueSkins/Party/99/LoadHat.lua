-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Load"] = function(p1)
		local v2 = script:WaitForChild("PartyHat"):Clone()
		v2:FindFirstChild("Handle"):FindFirstChild("Weld").Part0 = p1.Character:FindFirstChild("Head")
		v2.Parent = p1.Character
	end
}