-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["BulkSetNoCollision"] = function(_, p1, p2)
		local v3 = {}
		for _, v4 in next, p2 do
			local v5 = Instance.new("NoCollisionConstraint")
			v5.Part0 = p1
			v5.Part1 = v4
			v5.Parent = p1
			v3[#v3 + 1] = v5
		end
		return v3
	end
}