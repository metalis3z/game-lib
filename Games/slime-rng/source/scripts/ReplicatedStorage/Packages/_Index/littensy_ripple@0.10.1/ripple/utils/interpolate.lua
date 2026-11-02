-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: interpolate, time of decompilation: Sun May  3 10:10:48 2026 ]]
local oklab = require("./oklab")

require("../types")

return function(p1, p2, n1: number) --[[ interpolate ]] -- line: 6
	-- upvalues: oklab (copy)
	local v5 = typeof(p1)

	if v5 == "number" or (v5 == "vector" or v5 == "Vector3" or v5 == "Vector2") then
		return p1 + (p2 - p1) * n1
	end

	if v5 == "Color3" then
		local v6 = oklab.fromSRGB((vector.create(p1.R, p1.G, p1.B)))
		local v7 = oklab.fromSRGB((vector.create(p2.R, p2.G, p2.B)))

		return oklab.toSRGB(v6 + (v7 - v6) * n1)
	end

	if v5 == "UDim2" or v5 == "CFrame" then
		return p1:Lerp(p2, n1)
	end

	if v5 == "UDim" then
		return UDim.new(math.lerp(p1.Scale, p2.Scale, n1), (math.lerp(p1.Offset, p2.Offset, n1)))
	end

	if v5 == "Rect" then
		return Rect.new(math.lerp(p1.Min.X, p2.Min.X, n1), math.lerp(p1.Min.Y, p2.Min.Y, n1), math.lerp(p1.Max.X, p2.Max.X, n1), (math.lerp(p1.Max.Y, p2.Max.Y, n1)))
	end

	if v5 == "table" then
		local v8 = p1

		for v9, v10 in p2 do
			local v11 = p1[v9]

			if v11 then
				local v12 = v11 + (v10 - v11) * n1

				if v12 ~= v8[v9] then
					if v8 == p1 then
						v8 = table.clone(p1)
					end

					v8[v9] = v12
				end
			end
		end

		return v8
	end

	error(`Unsupported type for interpolation: { v5 }`)
end
