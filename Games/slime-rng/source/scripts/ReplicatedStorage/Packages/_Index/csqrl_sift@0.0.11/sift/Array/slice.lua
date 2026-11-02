-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: slice, time of decompilation: Sun May  3 10:10:06 2026 ]]
return function(t1: {[any]: any}, n1: number?, n2: number?) --[[ slice ]] -- line: 21
	local v4 = #t1
	local t2 = {}

	if type(n1) ~= "number" then
		n1 = 1
	end

	if type(n2) ~= "number" then
		n2 = v4
	end

	if n1 < 1 then
		n1 += v4
	end

	if n2 < 1 then
		n2 += v4
	end

	for i = n1, n2 do
		table.insert(t2, t1[i])
	end

	return t2
end
