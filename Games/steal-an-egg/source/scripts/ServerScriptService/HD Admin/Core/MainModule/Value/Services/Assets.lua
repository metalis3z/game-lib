--!strict
-- LOCAL
local Assets = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local permittedAssets: {[string]: true} = {}


-- FUNCTIONS
function Assets.permitAsset(assetId: number)
	permittedAssets[tostring(assetId)] = true
end

function Assets.isValidAsset(assetId: number)
	return permittedAssets[tostring(assetId)] == true
end


-- SETUP
Remote.new("ExpectPurchase", "Event")

-- PromptBulkPurchase can only be called from the server, hence this remote, however
-- it's also important we verify that the incoming assetId is related to a valid-hd product
-- otherwise we reject the prompt (for example, the game dev may have their own private UGC)
local promptBulkPurchaseAsync = require(modules.AssetUtil.promptBulkPurchaseAsync)
Remote.new("PromptBulkPurchase", "Function"):onServerInvoke(function(player: Player, assetId: unknown)
	if typeof(assetId) ~= "number" then
		return false, "Invalid assetId number"
	end
	local isValid = Assets.isValidAsset(assetId)
	if not isValid then
		return false, `BulkPrompting of assetId {assetId} is not permitted`
	end
	local success, warning = promptBulkPurchaseAsync(assetId, player)
	return success, warning
end)

-- Same for prompting products
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
Remote.new("PromptProduct", "Function"):onServerInvoke(function(player: Player, assetId: unknown, infoTypeName: unknown)
	if typeof(assetId) ~= "number" then
		return false, "Invalid assetId number"
	end
	local isValid = Assets.isValidAsset(assetId)
	if not isValid then
		return false, `Prompting of assetId {assetId} is not permitted`
	end
	local infoType: Enum.InfoType? = nil
	if typeof(infoTypeName) == "string" then
		local ok, enumItem = pcall(function() return (Enum.InfoType :: any)[infoTypeName] end)
		if ok and typeof(enumItem) == "EnumItem" then
			infoType = enumItem
		end
	end
	local success, warning = promptPurchaseAsync(assetId, player, infoType)
	return success, warning
end)

local products = require(modules.References.products)
local specialAccessories: {{id: number, name: string, order: number, comingSoon: boolean?}} = {}
for _, productInfo in products do
	Assets.permitAsset(productInfo.id)
	if productInfo.accessoryName then
		table.insert(specialAccessories, {
			id = productInfo.id,
			name = productInfo.accessoryName,
			order = productInfo.accessoryOrder or math.huge,
			comingSoon = productInfo.comingSoon,
		})
	end
end
table.sort(specialAccessories, function(left, right)
	return left.order < right.order
end)
local User = require(modules.Objects.User)
User.everyone:set("SpecialAccessories", specialAccessories)

require(modules.AssetUtil.registerSound)


return Assets