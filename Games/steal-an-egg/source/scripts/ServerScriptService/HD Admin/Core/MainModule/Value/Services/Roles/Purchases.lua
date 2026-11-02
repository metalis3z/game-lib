--!strict

-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local assetOwnership = require(modules.PlayerUtil.assetOwnership)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)
local Purchases = {}


-- LOCAL FUNCTIONS
local function getRoles(): any
	return require(script.Parent) :: any
end

local function hasBoosterRole(roleKeys: {string}?): boolean
	if typeof(roleKeys) ~= "table" then return false end
	local Roles = getRoles()
	local isInternalRole = require(modules.RoleUtil.isInternalRole)
	for _, key in roleKeys do
		if isInternalRole(Roles.getRole(key)) then
			return true
		end
	end
	return false
end

local function reresolveRoles(player: Player)
	local user: any = User.getUser(player)
	if not user then return end
	local Roles = getRoles()
	local granted = Roles.resolveRolesForPlayer(player)
	local current = user.temp:get("Roles")
	if areValuesEqual(current, granted) then return end
	user.temp:set("Roles", granted)
	if hasBoosterRole(granted) and not hasBoosterRole(current) then
		require(script.Parent.BoosterOffer).onBoosterUnlocked(player)
	end
end


-- SETUP
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, _gamePassId: number, wasPurchased: boolean)
	if not wasPurchased then return end
	reresolveRoles(player)
end)

MarketplaceService.PromptPurchaseFinished:Connect(function(player: Player, assetId: number, isPurchased: boolean)
	if not isPurchased then return end
	assetOwnership.record(player, assetId, true)
	reresolveRoles(player)
end)

MarketplaceService.PromptBundlePurchaseFinished:Connect(function(player: Player, _bundleId: number, wasPurchased: boolean)
	if not wasPurchased then return end
	reresolveRoles(player)
end)

-- PromptBulkPurchaseFinished only fires on the client, so booster accessory buys never reach the handler below
local recheckBoosterPurchaseRemote = require(modules.References.recheckBoosterPurchaseRemote)
recheckBoosterPurchaseRemote:onServerEvent(function(player: Player)
	if RunService:IsStudio() then
		require(script.Parent.BoosterOffer).onBoosterUnlocked(player)
		return
	end
	local products = require(modules.References.products)
	local owns = false
	-- Ownership can lag for a beat right after the purchase, so give it a few tries
	for _ = 1, 5 do
		for _, productName in {"Booster", "BoosterDiscount"} do
			local id = (products :: any)[productName].id
			local ok, owned = pcall(MarketplaceService.PlayerOwnsAsset, MarketplaceService, player, id)
			if ok and owned == true then
				assetOwnership.record(player, id, true)
				owns = true
			end
		end
		if owns then break end
		task.wait(1)
	end
	if owns then
		reresolveRoles(player)
	end
end)

pcall(function()
	MarketplaceService.PromptBulkPurchaseFinished:Connect(function(player: Player, _status: any, results: any)
		if typeof(results) ~= "table" then return end
		local touched = false
		for _, item in (results :: {any}) do
			if typeof(item) ~= "table" then continue end
			local entry = item :: any
			local itemStatus = entry.status or entry.Status
			if itemStatus ~= Enum.MarketplaceItemPurchaseStatus.Success then continue end
			local itemType = entry.type or entry.Type
			local itemId = entry.id or entry.Id
			if typeof(itemId) ~= "number" then continue end
			if itemType == Enum.MarketplaceProductType.AvatarAsset then
				assetOwnership.record(player, itemId, true)
			end
			touched = true
		end
		if touched then
			reresolveRoles(player)
		end
	end)
end)


return Purchases
