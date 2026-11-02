-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: getDataSource, time of decompilation: Sun May  3 10:11:05 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local client = require(ReplicatedStorage.Packages.DataService).client

return function(p1) -- line: 6
	-- upvalues: Vide (copy), client (copy)
	local v5 = Vide.source(client:get(p1))
	local connection = client:getChangedSignal(p1):Connect(function(p2) -- line: 9
		-- upvalues: v5 (copy)
		v5(p2)
	end)

	Vide.cleanup(function() -- line: 13
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return v5
end
