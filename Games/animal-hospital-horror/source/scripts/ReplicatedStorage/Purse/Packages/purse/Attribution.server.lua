local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

if not RunService:IsStudio() and RunService:IsClient() then
	print("\240\159\145\155 Running Purse v1.1.6 by @WinnersTakesAll")
end

local ok, result = pcall(function() --[[ Line: 44 | Upvalues: MarketplaceService (copy) ]]
	return MarketplaceService:GetProductInfoAsync(112061170330936)
end)
local v1 = if ok then string.match(result.Name, "v(%d+%.%d+%.%d+)") else nil

if not v1 or v1 == "1.1.6" then
	return
end

warn((("A new version of Purse (v1.1.6 -> v%*) is available: https://create.roblox.com/store/asset/112061170330936"):format(v1)))