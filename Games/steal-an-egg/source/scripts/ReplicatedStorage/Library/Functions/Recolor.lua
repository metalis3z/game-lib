-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local v1 = Vector3.new(p1.R, p1.G, p1.B)
	local sum = 0
	local list = {}

	for i, v in ipairs(p2) do
		local a = v.a
		local v3 = 1 - math.clamp((v1 - Vector3.new(a.R, a.G, a.B)).Magnitude / 1.7320508075688772, 0, 1)

		if v.response then
			v3 = math.clamp(v.response(v3), 0, 1)
		end

		if (v.threshold or 1e-6) < v3 and v3 == v3 then
			local v6 = v.weight and v3 * v.weight or v3

			table.insert(list, {
				ratio = v3,
				weight = v6,
				keypoint = v
			})
			sum = sum + v6
		end
	end

	if sum <= 0 then
		return p1
	end

	local sum2 = Vector3.new(0, 0, 0)

	for i, v in ipairs(list) do
		local b = v.keypoint.b

		sum2 = sum2 + (v1 * (1 - v.ratio) + Vector3.new(b.R, b.G, b.B) * v.ratio) * v.weight
	end

	local v8 = sum2 / sum

	return Color3.new(math.clamp(v8.X, 0, 1), math.clamp(v8.Y, 0, 1), (math.clamp(v8.Z, 0, 1)))
end