-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ProductCache = require(script.Parent.ProductCache)

return function(p1, p2) --[[ Line: 3 | Upvalues: ProductCache (copy) ]]
	return ProductCache.getProductInfo(p1, if p2 then p2 else Enum.InfoType.Product).Info
end