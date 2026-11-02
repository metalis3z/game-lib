-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game.ReplicatedStorage.Library
local CurrencyUtil = require(Library.Util.CurrencyUtil)

require(Library.Items.CurrencyItem)

return function(p1, p2, p3, p4) --[[ SetupPriceFrameForCurrency | Line: 5 | Upvalues: CurrencyUtil (copy) ]]
	local v1 = if p4 then p4 else p3:GetAmount()

	CurrencyUtil.SetupPriceFrame(p1, p3:GetId(), v1, 2)
end