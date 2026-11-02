-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: equals, time of decompilation: Sun May  3 10:10:11 2026 ]]
local ParentParent = script.Parent.Parent
local Util = require(ParentParent.Util)

require(ParentParent.Types)

local function compare(p1, p2) -- line: 7
	if type(p1) ~= "table" or type(p2) ~= "table" then
		return p1 == p2
	end

	for k, v in pairs(p1) do
		if v ~= p2[k] then
			return false
		end
	end

	for k, v in pairs(p2) do
		if v ~= p1[k] then
			return false
		end
	end

	return true
end

return function(...) --[[ equals ]] -- line: 45
	-- upvalues: Util (copy), compare (copy)
	if Util.equalObjects(...) then
		return true
	end

	local v10 = select("#", ...)
	local v11 = select(1, ...)

	for i = 2, v10 do
		local v13 = select(i, ...)

		if not compare(v11, v13) then
			return false
		end
	end

	return true
end
