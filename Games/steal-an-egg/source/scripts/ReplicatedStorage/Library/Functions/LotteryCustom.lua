-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new()

return function(p1, ...) --[[ Line: 16 | Upvalues: v1 (copy) ]]
	local list = { ... }

	if #list == 1 then
		local v2 = list[1]

		if type(v2) == "table" and type(v2[2]) ~= "number" then
			list = v2
		end
	end

	local count = 0
	local v4 = 0
	local v5 = 0

	for i, v in ipairs(list) do
		local v6 = v[2]

		assert(if type(v6) == "number" then true else false, "Weight must be a number")

		if v6 > 0 and (v6 == v6 and v6 ~= (1 / 0)) then
			count, v4, v5 = count + 1, v4 + v6, i
		end
	end

	if count == 0 then
		return nil, 0, 0, 0, 0
	end

	local v8 = (if p1 then p1 else v1):NextNumber(0, v4)
	local sum = v8

	for i, v in ipairs(list) do
		local v9 = v[2]

		if v9 > 0 and (v9 == v9 and v9 ~= (1 / 0)) then
			sum = sum - v9

			if sum <= 0 or i == v5 then
				return v[1], v8 / v4, v9 / v4, i, v9
			end
		end
	end

	error("Lottery selection failed - impossible state reached")
end