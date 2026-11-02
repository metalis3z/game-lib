-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: differenceSymmetric, time of decompilation: Sun May  3 10:10:24 2026 ]]
require(script.Parent.Parent.Types)

return function(p1, ...) --[[ differenceSymmetric ]] -- line: 21
	local v2 = table.clone(p1)

	for _, v4 in { ... } do
		if typeof(v4) == "table" then
			for v5 in v4 do
				v2[v5] = v2[v5] == nil
			end
		end
	end

	for v6, v7 in v2 do
		v2[v6] = not not v7 or nil
	end

	return v2
end
