-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: zipAll, time of decompilation: Sun May  3 10:10:09 2026 ]]
local ParentParent = script.Parent.Parent
local reduce = require(script.Parent.reduce)
local None = require(ParentParent.None)

return function(...) --[[ zipAll ]] -- line: 24
	-- upvalues: reduce (copy), None (copy)
	local t1 = { ... }
	local t2 = {}

	if select("#", ...) == 0 then
		return t2
	end

	for i = 1, reduce(t1, function(p1, p2) -- line: 33
		return (math.max(p1, #p2))
	end, #t1[1]) do
		local t3 = {}

		for _, v in ipairs(t1) do
			local v10 = v[i]

			table.insert(t3, if v10 ~= nil then v10 else None)
		end

		table.insert(t2, t3)
	end

	return t2
end
