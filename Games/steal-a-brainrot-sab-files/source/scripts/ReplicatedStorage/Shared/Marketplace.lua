
local MarketplaceService = game:GetService("MarketplaceService")
local t1 = {}

return {
	RemoveCache = function(_: {[any]: any}, n1: number)
		t1[n1] = nil
	end,
	GetProductInfo = function(_: {[any]: any}, n2: number, s1: string)
		local v8 = t1[n2]

		if not v8 or os.time() - v8.LastUpdate >= 3600 then
			local ok, result = pcall(function()
				return MarketplaceService:GetProductInfo(n2, s1 == "Gamepass" and Enum.InfoType.GamePass or Enum.InfoType.Product)
			end)

			if ok and type(result) == "table" then
				t1[n2] = {
					PriceInRobux = result.PriceInRobux or 0,
					Title = result.Name or "Failed to load",
					Icon = (result.IconImageAssetId and result.IconImageAssetId ~= 0)
						and `rbxassetid://{ result.IconImageAssetId }` or nil,
					LastUpdate = os.time()
				}
			else
				return {
					PriceInRobux = nil,
					Title = "Failed to load",
					Icon = nil,
					LastUpdate = 0
				}
			end
		end

		return t1[n2]
	end
}
