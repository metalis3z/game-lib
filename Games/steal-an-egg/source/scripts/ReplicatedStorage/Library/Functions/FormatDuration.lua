-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = { 0, 2, 2, 2 }

function FormatDuration(p1) --[[ FormatDuration | Line: 3 | Upvalues: t (copy) ]]
	assert(type(p1) == "number")

	local v3 = math.ceil((math.max(0, p1)))

	if v3 == (1 / 0) then
		return "inf"
	end

	if v3 ~= v3 then
		return "nan"
	end

	local v4 = v3 % 60
	local v5 = v3 // 60
	local v7 = v5 // 60
	local list = {
		v7 // 24,
		v7 % 24,
		v5 % 60,
		v4
	}
	local v8 = #list

	for i, v in ipairs(list) do
		if v > 0 then
			v8 = i

			break
		end
	end

	if v8 == #list then
		return tostring(v4) .. "s"
	end

	local v10 = tostring(list[v8])

	for i = v8 + 1, #list do
		local v12 = tostring(list[i])

		while #v12 < t[i] do
			v12 = "0" .. v12
		end

		v10 = v10 .. ":" .. v12
	end

	return v10
end

return FormatDuration