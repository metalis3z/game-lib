-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: shuffle, time of decompilation: Sun May  3 10:10:05 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}) --[[ shuffle ]] -- line: 19
	-- upvalues: copy (copy)
	local random = Random.new(os.time() * #t1)
	local v4 = copy(t1)

	for i = #v4, 1, -1 do
		local v6 = random:NextInteger(1, i)
		local v7 = v4[i]

		v4[i] = v4[v6]
		v4[v6] = v7
	end

	return v4
end
