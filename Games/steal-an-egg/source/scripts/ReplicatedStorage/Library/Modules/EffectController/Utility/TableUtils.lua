-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.deepCopy(p1) --[[ deepCopy | Line: 3 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "table" then
		return p1
	end

	local t2 = {}

	for k, v in pairs(p1) do
		t2[k] = t.deepCopy(v)
	end

	return t2
end
function t.deepEquals(p1, p2) --[[ deepEquals | Line: 15 | Upvalues: t (copy) ]]
	if typeof(p1) == "table" and typeof(p2) == "table" then
		for k, v in pairs(p1) do
			if not t.deepEquals(v, p2[k]) then
				return false
			end
		end

		for k, v in pairs(p2) do
			if not t.deepEquals(v, p1[k]) then
				return false
			end
		end

		return true
	end

	return p1 == p2
end
function t.getDictionaryLength(p1) --[[ getDictionaryLength | Line: 33 ]]
	local count = 0

	for k in pairs(p1) do
		count = count + 1
	end

	return count
end

return t