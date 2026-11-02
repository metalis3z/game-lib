-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3, p4, p5) --[[ Line: 2 ]]
	local Settings = p4.Settings
	local Stiffness = Settings.Stiffness
	local Elasticity = Settings.Elasticity
	local v1 = p4.Bones[p1.ParentIndex]

	if v1 then
		local FreeLength = p1.FreeLength

		if Stiffness > 0 or Elasticity > 0 then
			local v2 = CFrame.new(v1.Position) * v1.TransformOffset.Rotation
			local v3 = if p3 then p3 else (v2 * CFrame.new(p1.LocalTransformOffset.Position)).Position

			p2 = p2 + (v3 - p2) * (Elasticity * p5)

			if Stiffness > 0 then
				local v4 = v3 - p2
				local Magnitude = v4.Magnitude
				local v5 = FreeLength * (1 - Stiffness) * 2

				if v5 < Magnitude then
					p2 = p2 + v4 * ((Magnitude - v5) / Magnitude)
				end
			end
		end

		local v6 = v1.Position - p2
		local Magnitude = v6.Magnitude

		if Magnitude > 0 then
			p2 = p2 + v6 * ((Magnitude - FreeLength) / Magnitude)
		end
	end

	return p2
end