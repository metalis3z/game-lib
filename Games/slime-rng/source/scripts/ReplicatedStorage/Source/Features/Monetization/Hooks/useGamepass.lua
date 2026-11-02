-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: useGamepass, time of decompilation: Sun May  3 10:12:04 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)

require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

return function(p1) -- line: 8
	-- upvalues: Vide (copy), MonetizationServiceClient (copy)
	local v5 = Vide.source(MonetizationServiceClient:ownsGamepass(p1))
	local connection = MonetizationServiceClient:getProductInfoChangedSignal(p1):Connect(function() -- line: 11
		-- upvalues: v5 (copy), MonetizationServiceClient (copy), p1 (copy)
		v5(MonetizationServiceClient:ownsGamepass(p1))
	end)

	Vide.cleanup(function() -- line: 15
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return v5
end
