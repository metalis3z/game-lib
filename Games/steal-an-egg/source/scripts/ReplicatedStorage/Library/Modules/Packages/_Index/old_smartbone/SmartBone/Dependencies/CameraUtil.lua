-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	WithinViewport = function(p1) --[[ WithinViewport | Line: 3 ]]
		local CurrentCamera = workspace.CurrentCamera
		local v1, v2

		if p1:IsA("Model") then
			local v3, v4 = p1:GetBoundingBox()

			v1 = v4
			v2 = v3
		else
			if not p1:IsA("BasePart") then
				warn("Object is neither a Model nor a BasePart! Disregarding Camera check!")

				return false
			end

			v2 = p1.CFrame
			v1 = p1.Size
		end

		for i = 1, 8 do
			if CurrentCamera:WorldToViewportPoint((v2 * CFrame.new(v1.X * (if i % 2 == 0 then 0.5 else -0.5), v1.Y * (if i % 4 > 1 then 0.5 else -0.5), v1.Z * (if i % 8 > 3 then 0.5 else -0.5))).Position) then
				return true
			end
		end

		return false
	end
}