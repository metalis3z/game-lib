-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: changed, time of decompilation: Sun May  3 10:09:38 2026 ]]
local v1 = require("./action")()
local cleanup = require("./cleanup")

return function(s1: string, p1: ((...any) -> ...any)) --[[ changed ]] -- line: 4
	-- upvalues: v1 (copy), cleanup (copy)
	return v1(function(p2) -- line: 5
		-- upvalues: s1 (copy), p1 (copy), cleanup (copy)
		local connection = p2:GetPropertyChangedSignal(s1):Connect(function() -- line: 6
			-- upvalues: p1 (copy), p2 (copy), s1 (copy)
			p1(p2[s1])
		end)

		cleanup(function() -- line: 10
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
		p1(p2[s1])
	end)
end
