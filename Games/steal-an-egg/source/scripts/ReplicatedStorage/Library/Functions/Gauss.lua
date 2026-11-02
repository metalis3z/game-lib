-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local v1 = table.clone(p1)
	local v2 = #p1

	for i, v in ipairs(v1) do
		v1[i] = table.clone(v)
	end

	local v3 = table.clone(p2)

	for i = 1, v2 - 1 do
		local v4 = i

		for j = i + 1, v2 do
			local v6 = math.abs(v1[j][i])

			if math.abs(v1[v4][i]) < v6 then
				v4 = j
			end
		end

		if i ~= v4 then
			local v9 = v1[i]

			v1[i] = v1[v4]
			v1[v4] = v9

			local v11 = v3[i]

			v3[i] = v3[v4]
			v3[v4] = v11
		end

		for k = i + 1, v2 do
			local v12 = v1[k][i] / v1[i][i]

			v3[k] = v3[k] - v12 * v3[i]

			for n = i, v2 do
				local v13 = v1[k]

				v13[n] = v13[n] - v12 * v1[i][n]
			end
		end
	end

	local v14 = table.create(v2, 0)

	for m = v2, 1, -1 do
		v14[m] = v3[m]

		for i = m + 1, v2 do
			v14[m] = v14[m] - v1[m][i] * v14[i]
		end

		v14[m] = v14[m] / v1[m][m]
	end

	return v14
end