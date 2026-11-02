--!strict
-- CONFIG
local OFFER_DURATION = 900
local OFFER_RESET_AFTER = 36 * 60 * 60
local NUDGE_DELAY = 4


-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Remote = require(modules.Objects.Remote)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local openBoosterRemote = require(modules.References.openBoosterRemote)
local boosterUnlockedRemote = require(modules.References.boosterUnlockedRemote)
local showBoosterOfferRemote = require(modules.References.showBoosterOfferRemote)
local pendingNudges: {[Player]: boolean} = {}
local BoosterOffer = {}


-- LOCAL FUNCTIONS
local function getRoles(): any
	return require(script.Parent) :: any
end

local function holdsBooster(user: any): boolean
	local Roles = getRoles()
	for _, role in Roles.getRolesForUser(user) do
		if isInternalRole(role) then
			return true
		end
	end
	return false
end

local function isDiscountActive(user: any): boolean
	local startTime = user.perm:get("OfferStartTime")
	return typeof(startTime) == "number" and startTime > 0 and os.time() - startTime <= OFFER_DURATION
end

local function offerAvailable(user: any): boolean
	if RunService:IsStudio() then
		return true
	end
	local startTime = user.perm:get("OfferStartTime")
	if typeof(startTime) ~= "number" or startTime <= 0 then
		return true
	end
	local age = os.time() - startTime
	return age <= OFFER_DURATION or age > OFFER_RESET_AFTER
end

local function buildRoleProductIds(): {[number]: boolean}
	local Roles = getRoles()
	local Presets = require(modules.Parent.Controllers.UI.Config.Presets) :: any
	local ids: {[number]: boolean} = {}
	for _, role in Roles.getRoles() do
		if isInternalRole(role) then
			continue
		end
		local giveToProducts = (role :: any).giveToProducts
		if typeof(giveToProducts) ~= "table" then
			continue
		end
		for _, entry in giveToProducts :: {any} do
			if typeof(entry) ~= "table" then
				continue
			end
			local id = (entry :: any).id
			if typeof(id) == "number" then
				ids[id] = true
			elseif (entry :: any).type == "Preset" and typeof((entry :: any).preset) == "string" then
				local preset = Presets.products[(entry :: any).preset]
				if preset and typeof(preset.id) == "number" then
					ids[preset.id] = true
				end
			end
		end
	end
	return ids
end

local function offerMessage(user: any): string?
	if holdsBooster(user) then
		return nil
	end
	if isDiscountActive(user) then
		return "Get 20% off bonus chat commands.\nClick to view."
	end
	return "Unlock bonus chat commands.\nClick to view."
end

local function onProductPromptClosed(player: Player, productId: number)
	local user: any = User.getUser(player)
	if not user then
		return
	end
	if not buildRoleProductIds()[productId] then
		return
	end
	if pendingNudges[player] then
		return
	end
	pendingNudges[player] = true
	task.delay(NUDGE_DELAY, function()
		pendingNudges[player] = nil
		BoosterOffer.showOffer(player)
	end)
end


-- FUNCTIONS
function BoosterOffer.showOffer(player: Player)
	local user: any = User.getUser(player)
	if not user then
		return
	end
	local message = offerMessage(user)
	if message then
		showBoosterOfferRemote:fireClient(player, message, false)
	end
end

function BoosterOffer.prompt(player: Player, forceReopen: boolean?)
	local user: any = User.getUser(player)
	if not user or holdsBooster(user) then
		return
	end
	local productName = if isDiscountActive(user) then "BoosterDiscount" else "Booster"
	openBoosterRemote:fireClient(player, forceReopen == true, productName)
end

function BoosterOffer.onBoosterUnlocked(player: Player)
	local boosterDisplay = require(modules.CommandUtil.boosterDisplay)
	boosterUnlockedRemote:fireClient(player, boosterDisplay.getAll())
end


-- SETUP
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamePassId: number, _wasPurchased: boolean)
	onProductPromptClosed(player, gamePassId)
end)

MarketplaceService.PromptPurchaseFinished:Connect(function(player: Player, assetId: number, _isPurchased: boolean)
	onProductPromptClosed(player, assetId)
end)

MarketplaceService.PromptBundlePurchaseFinished:Connect(function(player: Player, bundleId: number, _wasPurchased: boolean)
	onProductPromptClosed(player, bundleId)
end)

require(modules.References.productPromptClosedRemote):onServerEvent(function(player: Player, productId: unknown)
	if typeof(productId) == "number" then
		onProductPromptClosed(player, productId)
	end
end)

require(modules.References.requestBoosterOfferRemote):onServerEvent(function(player: Player)
	local user: any = User.getUser(player)
	if not user or holdsBooster(user) then
		return
	end
	local message = if offerAvailable(user)
		then "Get 20% off bonus chat commands.\nClick to view."
		else "Unlock bonus chat commands.\nClick to view."
	showBoosterOfferRemote:fireClient(player, message, true)
end)

Remote.new("StartBoosterOffer", "Function"):onServerInvoke(function(player: Player)
	local user: any = User.getUser(player)
	if not user or holdsBooster(user) then
		return {offerActive = false}
	end
	local startTime = user.perm:get("OfferStartTime")
	local now = os.time()
	if typeof(startTime) ~= "number" or startTime <= 0 or now - startTime > OFFER_RESET_AFTER or RunService:IsStudio() then
		startTime = now
		user.perm:set("OfferStartTime", startTime)
	end
	return {offerActive = now - startTime <= OFFER_DURATION}
end)


return BoosterOffer
