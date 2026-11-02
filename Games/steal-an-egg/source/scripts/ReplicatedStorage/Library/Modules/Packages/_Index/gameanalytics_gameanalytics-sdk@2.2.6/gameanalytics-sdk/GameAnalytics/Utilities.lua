-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	isStringNullOrEmpty = function(p1, p2) --[[ isStringNullOrEmpty | Line: 3 ]]
		return not p2 or #p2 == 0
	end,
	stringArrayContainsString = function(p1, p2, p3) --[[ stringArrayContainsString | Line: 7 ]]
		if #p2 == 0 then
			return false
		end

		for i, v in ipairs(p2) do
			if v == p3 then
				return true
			end
		end

		return false
	end,
	copyTable = function(p1, p2) --[[ copyTable | Line: 21 ]]
		local t = {}

		for k, v in pairs(p2) do
			if typeof(v) == "table" then
				t[k] = p1:copyTable(v)

				continue
			end

			t[k] = v
		end

		return t
	end
}