-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
({}).__index = {}

return function(p1, p2) --[[ Line: 9 ]]
	local t = {}

	for k, v in pairs(p1) do
		for i, v2 in ipairs(v) do
			t[v2] = t[v2] or {}
			t[v2][k] = p2(k, v2)
		end
	end

	local function getScoredDistances(p1) --[[ getScoredDistances | Line: 19 | Upvalues: t (copy) ]]
		local t2 = {
			[p1] = 0
		}
		local t3 = {}

		for k, v in pairs(t) do
			if k ~= p1 then
				t2[k] = (1 / 0)
				table.insert(t3, k)
			end
		end

		local function v1(p12, p2) --[[ scoreStep | Line: 31 | Upvalues: p1 (copy), t2 (copy), t (ref), v1 (copy) ]]
			if p12 == p1 then
				return
			end

			if not (t2[p12] and p2 < t2[p12]) then
				return
			end

			t2[p12] = p2

			for k, v in pairs(t[p12]) do
				v1(k, p2 + v)
			end
		end

		for k, v in pairs(t[p1]) do
			v1(k, v)
		end

		return t2
	end

	local t2 = {}
	local t3 = {}

	return function(p12, p2) --[[ Line: 51 | Upvalues: t2 (copy), t3 (copy), getScoredDistances (copy), p1 (copy) ]]
		local list = {}
		local v1 = t2

		v1[p12] = t2[p12] or {}

		if t2[p12][p2] == nil then
			if t3[p2] == nil then
				t3[p2] = getScoredDistances(p2)
			end

			local v3 = t3[p2]

			local function v4(p13) --[[ assemblePath | Line: 68 | Upvalues: list (copy), t2 (ref), p12 (copy), p2 (copy), p1 (ref), v3 (copy), v4 (copy) ]]
				table.insert(list, p13)
				table.insert(t2[p12][p2], p13)

				if p13 == p2 then
					return
				end

				local v32 = nil

				for v6, v7 in ipairs(p1[p13] or {}) do
					if v3[v7] < (1 / 0) then
						v32 = v7
					end
				end

				if not v32 then
					return
				end

				v4(v32)
			end

			t2[p12][p2] = {}
			v4(p12)

			local t = {}

			for i, v in ipairs(list) do
				t[#list - i + 1] = v
			end

			local v5 = t2

			v5[p2] = t2[p2] or {}
			t2[p2][p12] = t
		else
			for i, v in ipairs(t2[p12][p2]) do
				table.insert(list, v)
			end
		end

		return list
	end
end