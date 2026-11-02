-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: show, time of decompilation: Sun May  3 10:09:44 2026 ]]
local source = require("./source")
local derive = require("./derive")
local effect = require("./effect")

require("./untrack")

local switch = require("./switch")

return function(p1: ((...any) -> ...any), p2: ((...any) -> ...any), p3: ((...any) -> ...any)?) --[[ show ]] -- line: 10
	-- upvalues: source (copy), effect (copy), derive (copy), switch (copy)
	local v8 = source()

	effect(function() -- line: 17
		-- upvalues: p1 (copy), v8 (copy)
		local v10 = p1()

		if v10 then
			v8(v10)
		end
	end)

	local v9 = derive(function() -- line: 24
		-- upvalues: p1 (copy)
		return not not p1()
	end)

	return switch(v9)({
		[true] = function(p4) -- line: 29
			-- upvalues: p2 (copy), v8 (copy)
			return p2(v8, p4)
		end,
		[false] = p3
	})
end
