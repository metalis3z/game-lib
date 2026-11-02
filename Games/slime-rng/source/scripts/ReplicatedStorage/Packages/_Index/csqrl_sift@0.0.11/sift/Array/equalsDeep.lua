-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: equalsDeep, time of decompilation: Sun May  3 10:09:54 2026 ]]
local ParentParent = script.Parent.Parent
local Util = require(ParentParent.Util)

local function compareDeep(p1, p2) -- line: 6
	-- upvalues: compareDeep (copy)
	if type(p1) ~= "table" or type(p2) ~= "table" then
		return p1 == p2
	end

	local v6 = #p1

	if v6 ~= #p2 then
		return false
	end

	for i = 1, v6 do
		if not compareDeep(p1[i], p2[i]) then
			return false
		end
	end

	return true
end

return function(...) --[[ equalsDeep ]] -- line: 44
	-- upvalues: Util (copy), compareDeep (copy)
	if Util.equalObjects(...) then
		return true
	end

	local v8 = select("#", ...)
	local v9 = select(1, ...)

	for i = 2, v8 do
		local v11 = select(i, ...)

		if not compareDeep(v9, v11) then
			return false
		end
	end

	return true
end
