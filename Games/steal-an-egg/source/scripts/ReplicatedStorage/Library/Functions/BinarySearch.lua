-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Compare = function(p1, p2) --[[ Compare | Line: 3 ]]
		if p1 < p2 then
			return -1
		end

		if p2 < p1 then
			return 1
		end

		return 0
	end,
	Any = function(p1, p2, ...) --[[ Any | Line: 7 ]]
		local v1 = 1
		local v2 = #p1

		while v1 <= v2 do
			local v3 = v1 + (v2 - v1) // 2
			local v4 = p2(p1[v3], ...)

			if v4 > 0 then
				v2 = v3 - 1
			else
				if v4 == 0 then
					return v3
				end

				v1 = v3 + 1
			end
		end

		return -v1
	end,
	Left = function(p1, p2, ...) --[[ Left | Line: 24 ]]
		local v1 = 1
		local v2 = #p1
		local v3 = false

		while v1 <= v2 do
			local v4 = v1 + (v2 - v1) // 2
			local v5 = p2(p1[v4], ...)

			v2 = v4 - 1

			if not (v5 > 0) then
				if v5 < 0 then
					v1 = v4 + 1

					continue
				end

				v3 = true
			end
		end

		return if v3 and v1 then v1 else -v1
	end,
	Right = function(p1, p2, ...) --[[ Right | Line: 43 ]]
		local v1 = 1
		local v2 = #p1
		local v3 = false

		while v1 <= v2 do
			local v4 = v1 + (v2 - v1) // 2
			local v5 = p2(p1[v4], ...)

			if v5 > 0 then
				v2 = v4 - 1
			else
				if v5 < 0 then
					v1 = v4 + 1

					continue
				end

				v1 = v4 + 1
				v3 = true
			end
		end

		return if v3 and v1 then v1 else -v1
	end
}

function t.InsertAny(p1, p2, p3) --[[ InsertAny | Line: 62 | Upvalues: t (copy) ]]
	local v2 = math.abs((t.Any(p1, p2, p3)))

	table.insert(p1, v2, p3)

	return v2
end
function t.InsertLeft(p1, p2, p3) --[[ InsertLeft | Line: 69 | Upvalues: t (copy) ]]
	local v2 = math.abs((t.Left(p1, p2, p3)))

	table.insert(p1, v2, p3)

	return v2
end
function t.InsertRight(p1, p2, p3) --[[ InsertRight | Line: 76 | Upvalues: t (copy) ]]
	local v2 = math.abs((t.Right(p1, p2, p3)))

	table.insert(p1, v2, p3)

	return v2
end
function t.Remove(p1, p2, p3) --[[ Remove | Line: 83 | Upvalues: t (copy) ]]
	local v1 = t.Left(p1, p2, p3)

	if not (v1 > 0) then
		return false
	end

	for i = v1, #p1 do
		if p1[i] == p3 then
			table.remove(p1, i)

			return true
		end
	end

	return false
end
function t.NumberSearch(p1, p2) --[[ NumberSearch | Line: 96 ]]
	local v1 = 1
	local v2 = #p1

	while v1 <= v2 do
		local v3 = v1 + (v2 - v1) // 2
		local v4 = p1[v3]

		if p2 < v4 then
			v2 = v3 - 1
		else
			if v4 == p2 then
				return v3
			end

			v1 = v3 + 1
		end
	end

	return v1 - 1
end
function t.NumberAny(p1, p2) --[[ NumberAny | Line: 113 ]]
	local v1 = 1
	local v2 = #p1

	while v1 <= v2 do
		local v3 = v1 + (v2 - v1) // 2
		local v4 = p1[v3]

		if p2 < v4 then
			v2 = v3 - 1
		else
			if v4 == p2 then
				return v3
			end

			v1 = v3 + 1
		end
	end

	return -v1
end

return t