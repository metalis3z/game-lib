-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: freezeDeep, time of decompilation: Sun May  3 10:10:14 2026 ]]
require(script.Parent.Parent.Types)

local function freezeDeep(p1) -- line: 22
	-- upvalues: freezeDeep (copy)
	local t1 = {}

	for k, v in pairs(p1) do
		if type(v) == "table" then
			t1[k] = freezeDeep(v)
		else
			t1[k] = v
		end
	end

	table.freeze(t1)

	return t1
end

return freezeDeep
