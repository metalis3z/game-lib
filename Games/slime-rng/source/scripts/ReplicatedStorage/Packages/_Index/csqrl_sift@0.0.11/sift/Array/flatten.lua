-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: flatten, time of decompilation: Sun May  3 10:09:57 2026 ]]
local function flatten(t1: {[any]: any}, n1: number?) -- line: 24
	-- upvalues: flatten (copy)
	if type(n1) ~= "number" then
		n1 = 1e999
	end

	local t2 = {}

	for _, v in ipairs(t1) do
		if type(v) == "table" and n1 > 0 then
			local v7 = flatten(v, n1 - 1)

			for _, v2 in ipairs(v7) do
				table.insert(t2, v2)
			end
		else
			table.insert(t2, v)
		end
	end

	return t2
end

return flatten
