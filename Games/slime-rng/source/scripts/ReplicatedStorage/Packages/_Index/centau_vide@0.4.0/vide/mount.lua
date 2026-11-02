-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: mount, time of decompilation: Sun May  3 10:09:42 2026 ]]
local root = require("./root")
local apply = require("./apply")

return function(p1: ((...any) -> ...any), p2) --[[ mount ]] -- line: 4
	-- upvalues: root (copy), apply (copy)
	return root(function() -- line: 5
		-- upvalues: p1 (copy), p2 (copy), apply (copy)
		local v5 = p1()

		if p2 then
			apply(p2, { v5 })
		end
	end)
end
