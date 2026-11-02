-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ProductCache = require(script.Parent.ProductCache)

return function(p1, p2) --[[ Line: 3 | Upvalues: ProductCache (copy) ]]
	local v2 = ProductCache.getProductInfo(p1, p2 and Enum.InfoType.Product or Enum.InfoType.GamePass)
	local v3 = if v2 then v2.Info else v2

	if not v3 then
		warn("Failed to grab price for ID (" .. p1 .. ")")

		return 0, false
	end

	if not v3.IsForSale then
		return 0, false
	end

	local PriceInRobux = v3.PriceInRobux

	if type(PriceInRobux) == "number" then
		return PriceInRobux, true
	end

	return 0, false
end