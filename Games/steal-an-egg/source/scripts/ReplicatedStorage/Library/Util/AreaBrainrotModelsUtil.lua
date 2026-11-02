-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	GetBrainrotModel = function(p1) --[[ GetBrainrotModel | Line: 5 ]]
		local WorldAssetMobs = workspace:FindFirstChild("WorldAssetMobs")

		if not WorldAssetMobs then
			return nil
		end

		for i, v in ipairs(WorldAssetMobs:GetChildren()) do
			if v:IsA("Model") and v:GetAttribute("SpawnId") == p1 then
				return v
			end
		end

		return nil
	end,
	GetTopPosition = function(p1) --[[ GetTopPosition | Line: 22 ]]
		local v1 = p1:GetPivot()

		return v1.Position + Vector3.new(0, p1:GetExtentsSize().Y * 0.5, 0)
	end
}