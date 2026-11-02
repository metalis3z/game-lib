-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: useProduct, time of decompilation: Sun May  3 10:12:04 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)

require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

local function readProduct(p1) -- line: 8
	-- upvalues: Vide (copy)
	if type(p1) == "function" then
		return Vide.read(p1)
	end

	return p1
end

return function(p2) -- line: 16
	-- upvalues: Vide (copy), readProduct (copy), MonetizationServiceClient (copy)
	local v7 = Vide.source(table.clone(readProduct(p2)))

	Vide.effect(function() -- line: 19
		-- upvalues: p2 (copy), Vide (copy), v7 (copy), MonetizationServiceClient (copy)
		local v8 = p2
		local v9 = if type(v8) ~= "function" then v8 else Vide.read(v8)

		v7(table.clone(v9))

		local connection = MonetizationServiceClient:getProductInfoChangedSignal(v9):Connect(function() -- line: 23
			-- upvalues: v7 (copy), v9 (copy)
			v7(table.clone(v9))
		end)

		Vide.cleanup(function() -- line: 27
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end)

	return v7
end
