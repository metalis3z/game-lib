-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeIndex, time of decompilation: Sun May  3 10:10:02 2026 ]]
return function(t1: {[any]: any}, n1: number) --[[ removeIndex ]] -- line: 19
	local v3 = #t1
	local t2 = {}

	if n1 < 1 then
		n1 += v3
	end

	for i, v in ipairs(t1) do
		if i ~= n1 then
			table.insert(t2, v)
		end
	end

	return t2
end
