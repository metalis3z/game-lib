-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: freezeDeep, time of decompilation: Sun May  3 10:09:58 2026 ]]
local function freezeDeep(t1: {[any]: any}) -- line: 21
	-- upvalues: freezeDeep (copy)
	local t2 = {}

	for i = 1, #t1 do
		local v5 = t1[i]

		if type(v5) == "table" then
			table.insert(t2, freezeDeep(v5))
		else
			table.insert(t2, v5)
		end
	end

	table.freeze(t2)

	return t2
end

return freezeDeep
