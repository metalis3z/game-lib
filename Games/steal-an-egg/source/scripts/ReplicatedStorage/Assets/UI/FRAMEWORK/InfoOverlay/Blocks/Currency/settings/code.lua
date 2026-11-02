-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CurrencyUtil = require(game.ReplicatedStorage.Library.Util.CurrencyUtil)

return function(p1, p2, p3, p4) --[[ Line: 2 | Upvalues: CurrencyUtil (copy) ]]
	local v1 = if p4 then p4 else p3:GetAmount()

	CurrencyUtil.SetupPriceFrame(p1, p3:GetId(), v1, 2)
end