-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local MarketplaceService = game:GetService("MarketplaceService")
local t = {
	UpdateRate = 900,
	RetryRate = 900
}
local t2 = {}

function t.clear() --[[ clear | Line: 10 | Upvalues: t2 (ref) ]]
	t2 = {}
end
function t.getProductInfo(p1, p2) --[[ getProductInfo | Line: 14 | Upvalues: t2 (ref), t (copy), MarketplaceService (copy) ]]
	assert(if type(p1) == "number" then true else false)
	assert(if typeof(p2) == "EnumItem" then p2.EnumType == Enum.InfoType else false)

	local v3 = t2[p2]

	if not v3 then
		v3 = {}
		t2[p2] = v3
	end

	local v4 = v3[p1]

	if not v4 then
		v4 = {}
		v3[p1] = v4
	end

	if v4.Info and (v4.LastUpdated and time() - v4.LastUpdated < t.UpdateRate) then
		return v4, true
	end

	if v4.LastFailure and time() - v4.LastFailure < t.RetryRate then
		return v4, false
	end

	local ok, result = pcall(function() --[[ Line: 38 | Upvalues: MarketplaceService (ref), p1 (copy), p2 (copy) ]]
		return MarketplaceService:GetProductInfo(p1, p2)
	end)
	local v5 = time()

	if ok then
		v4.LastUpdated = v5
		v4.Info = result

		return v4, true
	end

	v4.LastFailure = v5
	warn(string.format("[ProductCache] Failed to retrieve: productId=%d infoType=%s error=\'%s\'", p1, p2.Name, (tostring(result))))

	return v4, false
end

return t