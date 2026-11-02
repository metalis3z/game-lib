-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: signal, time of decompilation: Sun May  3 10:10:49 2026 ]]
local spawn = require("./spawn")

return function() --[[ signal ]] -- line: 6
	-- upvalues: spawn (copy)
	local t1 = {}
	local n1 = 0

	return function(p1: ((...any) -> ...any)) --[[ subscribe ]] -- line: 10
		-- upvalues: t1 (copy), n1 (ref)
		table.insert(t1, p1)
		n1 += 1

		return function() -- line: 14
			-- upvalues: t1 (copy), p1 (copy), n1 (ref)
			local v6 = table.find(t1, p1)

			if v6 then
				t1[v6] = t1[n1]
				t1[n1] = nil
				n1 -= 1
			end
		end
	end, function(...) --[[ fire ]] -- line: 25
		-- upvalues: n1 (ref), spawn (copy), t1 (copy)
		for i = n1, 1, -1 do
			spawn(t1[i], ...)
		end
	end
end
