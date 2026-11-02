-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: zip, time of decompilation: Sun May  3 10:10:08 2026 ]]
local reduce = require(script.Parent.reduce)

return function(...) --[[ zip ]] -- line: 20
	-- upvalues: reduce (copy)
	local t1 = { ... }
	local t2 = {}

	if select("#", ...) == 0 then
		return t2
	end

	for i = 1, reduce(t1, function(p1, p2) -- line: 30
		return (math.min(p1, #p2))
	end, #t1[1]) do
		local t3 = {}

		for _, v in ipairs(t1) do
			table.insert(t3, v[i])
		end

		table.insert(t2, t3)
	end

	return t2
end
