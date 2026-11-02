-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: copyDeep, time of decompilation: Sun May  3 10:09:50 2026 ]]
local function copyDeep(t1: {[any]: any}) -- line: 20
	-- upvalues: copyDeep (copy)
	local v3 = table.clone(t1)

	for v4, v5 in t1 do
		if type(v5) == "table" then
			v3[v4] = copyDeep(v5)
		end
	end

	return v3
end

return copyDeep
