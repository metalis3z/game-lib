--!strict

--[[

	Shows the buyer a success notice after a HD purchase, with an Equip button
	for wearable items. Everything runs here on the client because PromptBulkPurchaseFinished
	only fires in a LocalScript

--]]


-- CONFIG
local PENDING_EXPIRY = 120 -- seconds a request stays valid


-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Prompt = require(modules.Prompt)
local Remote = require(modules.Objects.Remote)
local equipToAccount = require(frontend.Util.equipToAccount)
local pendingPurchases: {[number]: number} = {}
local PurchaseController = {}


-- LOCAL FUNCTIONS
local function expectPurchase(assetId: number)
	if typeof(assetId) == "number" then
		pendingPurchases[assetId] = os.clock()
	end
end

local function consumePurchase(assetId: number): boolean
	local requestedAt = pendingPurchases[assetId]
	if not requestedAt then
		return false
	end
	pendingPurchases[assetId] = nil
	return os.clock() - requestedAt <= PENDING_EXPIRY
end

local function escapeRich(text: string): string
	return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function notifyPurchase(info: equipToAccount.ItemInfo)
	local nameRich = `<b>{escapeRich(info.name)}</b>`
	-- Linger longer than a normal notice so there's time to read it and hit Equip
	local options: any = { duration = 15 }
	if info.kind ~= nil then
		local context: equipToAccount.EquipContext = {
			kind = info.kind,
			assetId = info.assetId,
			name = info.name,
			assetTypeId = info.assetTypeId,
		}
		-- PromptSaveAvatar yields, so the button spins until the prompt is answered
		options.equip = {
			label = "Equip",
			onActivate = function()
				local result = equipToAccount.equip(context)
				if result == "success" then
					Prompt.success(`Added {nameRich} to your avatar!`)
				elseif result == "wheelFull" then
					Prompt.warn("Your emote wheel is full (8/8). Unequip one in the Roblox avatar editor, then try again.")
				elseif result == "noCharacter" then
					Prompt.warn("Respawn, then try Equip again.")
				elseif result == "failed" or result == "error" then
					Prompt.error(`Couldn't add {nameRich} to your avatar - please try again.`)
				end
				-- "declined" and "busy" stay quiet
			end,
		}
	end
	local typeSuffix = if info.typeLabel and info.typeLabel ~= "" then ` {info.typeLabel}` else ""
	Prompt.success(`Purchased {nameRich}{typeSuffix}!`, options)
end

-- Name lookups yield, so resolve off the event thread
local function handlePurchasedAsset(assetId: number, productType: Enum.MarketplaceProductType?)
	if not consumePurchase(assetId) then
		return
	end
	task.spawn(function()
		notifyPurchase(equipToAccount.classify(assetId, productType))
	end)
end


-- SETUP
if not RunService:IsClient() then
	return PurchaseController
end

-- The server fires ExpectPurchase whenever HD shows a purchase prompt
Remote.get("ExpectPurchase"):onClientEvent(function(assetId)
	if typeof(assetId) == "number" then
		expectPurchase(assetId)
	end
end)

MarketplaceService.PromptBulkPurchaseFinished:Connect(function(_player, _status, results: any)
	local items = if typeof(results) == "table" then (results.Items or results) else nil
	if typeof(items) ~= "table" then
		return
	end
	for _, entry in items do
		if typeof(entry) ~= "table" then
			continue
		end
		local status = entry.status or entry.Status
		if status ~= Enum.MarketplaceItemPurchaseStatus.Success then
			continue
		end
		local itemId = tonumber(entry.id or entry.Id)
		if itemId then
			handlePurchasedAsset(itemId, entry.type or entry.Type)
		end
	end
end)

MarketplaceService.PromptPurchaseFinished:Connect(function(_player, assetId, isPurchased)
	if isPurchased and typeof(assetId) == "number" then
		handlePurchasedAsset(assetId, Enum.MarketplaceProductType.AvatarAsset)
	end
end)

MarketplaceService.PromptBundlePurchaseFinished:Connect(function(_player, bundleId, wasPurchased)
	if wasPurchased and typeof(bundleId) == "number" then
		handlePurchasedAsset(bundleId, Enum.MarketplaceProductType.AvatarBundle)
	end
end)

-- Gamepasses aren't wearable, so no Equip button
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(_player, gamePassId, wasPurchased)
	if not wasPurchased or typeof(gamePassId) ~= "number" then
		return
	end
	if not consumePurchase(gamePassId) then
		return
	end
	task.spawn(function()
		notifyPurchase({ name = equipToAccount.gamePassName(gamePassId), assetId = gamePassId, typeLabel = "gamepass" })
	end)
end)


return PurchaseController
