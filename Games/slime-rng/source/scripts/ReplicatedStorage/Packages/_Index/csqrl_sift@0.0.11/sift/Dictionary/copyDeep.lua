-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: copyDeep, time of decompilation: Sun May  3 10:10:10 2026 ]]
local function copyDeep(p1) -- line: 20
	-- upvalues: copyDeep (copy)
	local v3 = table.clone(p1)

	for k, v in pairs(p1) do
		if type(v) == "table" then
			v3[k] = copyDeep(v)
		end
	end

	return v3
end

return copyDeep
