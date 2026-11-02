-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Rotation"] = function(p1, p2)
		local v3 = p2.delta or 1
		local v4 = p2.rotation.X
		local v5 = p2.rotation.Y
		local v6 = p2.rotation.Z
		local v7 = CFrame.Angles(v4 * v3, v5 * v3, v6 * v3)
		local v8 = p1.Model
		v8.CFrame = v8.CFrame * v7
	end
}
