--!strict
-- LOCAL
--[[

	Persists a purchased item onto the player's real Roblox account avatar via
	PromptSaveAvatar, so it survives respawn. PromptSaveAvatar REPLACES the whole
	avatar, so we always start from the current account description and add the
	new item, never build a blank one

--]]

local Players = game:GetService("Players")
local AvatarEditorService = game:GetService("AvatarEditorService")
local MarketplaceService = game:GetService("MarketplaceService")
local AssetService = game:GetService("AssetService")
local player = Players.LocalPlayer


-- CONFIG
local EMOTE_ASSET_TYPE = 61
local MAX_EQUIPPED_EMOTES = 8 -- the emote wheel caps at 8 slots
local SAVE_TIMEOUT = 120 -- seconds to wait for PromptSaveAvatarCompleted before giving up

-- Classic clothing AssetTypeId -> the HumanoidDescription property it sets
local CLOTHING_PROPERTY: {[number]: string} = {
	[2] = "GraphicTShirt",
	[11] = "Shirt",
	[12] = "Pants",
}

-- 64-72 are the layered-clothing accessory types, which need IsLayered and an Order
local ACCESSORY_TYPE_BY_ASSET_TYPE: {[number]: Enum.AccessoryType} = {
	[8] = Enum.AccessoryType.Hat,
	[41] = Enum.AccessoryType.Hair,
	[42] = Enum.AccessoryType.Face,
	[43] = Enum.AccessoryType.Neck,
	[44] = Enum.AccessoryType.Shoulder,
	[45] = Enum.AccessoryType.Front,
	[46] = Enum.AccessoryType.Back,
	[47] = Enum.AccessoryType.Waist,
	[64] = Enum.AccessoryType.TShirt,
	[65] = Enum.AccessoryType.Shirt,
	[66] = Enum.AccessoryType.Pants,
	[67] = Enum.AccessoryType.Jacket,
	[68] = Enum.AccessoryType.Sweater,
	[69] = Enum.AccessoryType.Shorts,
	[70] = Enum.AccessoryType.LeftShoe,
	[71] = Enum.AccessoryType.RightShoe,
	[72] = Enum.AccessoryType.DressSkirt,
}
local LAYERED_ASSET_TYPES: {[number]: boolean} = {
	[64] = true, [65] = true, [66] = true, [67] = true, [68] = true,
	[69] = true, [70] = true, [71] = true, [72] = true,
}


-- TYPES
export type EquipKind = "emote" | "accessory" | "clothing" | "bundle"
export type EquipContext = {
	kind: EquipKind,
	assetId: number,
	name: string,
	assetTypeId: number?, -- needed for accessory / clothing routing
}
-- A nil kind means not wearable, success notice only
export type ItemInfo = {
	name: string,
	assetId: number,
	kind: EquipKind?,
	assetTypeId: number?,
	typeLabel: string?,
}
export type EquipResult = "success" | "declined" | "failed" | "busy" | "wheelFull" | "noCharacter" | "error"


-- STATE
-- One session-wide handler, connecting per click would duplicate fires
local promptOpen = false
local pendingResolve: ((Enum.AvatarPromptResult) -> ())? = nil
AvatarEditorService.PromptSaveAvatarCompleted:Connect(function(result: Enum.AvatarPromptResult)
	promptOpen = false
	local resolve = pendingResolve
	pendingResolve = nil
	if resolve then
		resolve(result)
	end
end)

-- Name lookups yield + are rate-limited, so cache per session
local infoCache: {[number]: ItemInfo} = {}


-- MODULE
local EquipToAccount = {}

function EquipToAccount.classify(itemId: number, productType: Enum.MarketplaceProductType?): ItemInfo
	local cached = infoCache[itemId]
	if cached then
		return cached
	end
	local result: ItemInfo
	if productType == Enum.MarketplaceProductType.AvatarBundle then
		local ok, details = pcall(function()
			return AssetService:GetBundleDetailsAsync(itemId)
		end)
		local name = if ok and typeof(details) == "table" and details.Name then details.Name else "bundle"
		result = { name = name, assetId = itemId, kind = "bundle", typeLabel = "bundle" }
	else
		local ok, info: any = pcall(function()
			return MarketplaceService:GetProductInfo(itemId, Enum.InfoType.Asset)
		end)
		if not ok or typeof(info) ~= "table" then
			-- Unresolvable means notice only, no equip
			result = { name = "item", assetId = itemId }
		else
			local assetTypeId = info.AssetTypeId
			local kind: EquipKind? = nil
			local typeLabel: string? = nil
			if assetTypeId == EMOTE_ASSET_TYPE then
				kind = "emote"
				typeLabel = "emote"
			elseif ACCESSORY_TYPE_BY_ASSET_TYPE[assetTypeId] then
				kind = "accessory"
				typeLabel = "accessory"
			elseif CLOTHING_PROPERTY[assetTypeId] then
				kind = "clothing"
				typeLabel = "clothing"
			end
			result = { name = info.Name or "item", assetId = itemId, kind = kind, assetTypeId = assetTypeId, typeLabel = typeLabel }
		end
	end
	infoCache[itemId] = result
	return result
end

-- Name for a gamepass (its own InfoType), used only for the success notice text
function EquipToAccount.gamePassName(gamePassId: number): string
	local ok, info: any = pcall(function()
		return MarketplaceService:GetProductInfo(gamePassId, Enum.InfoType.GamePass)
	end)
	return if ok and typeof(info) == "table" and info.Name then info.Name else "gamepass"
end

-- LOCAL FUNCTIONS
-- mutate the player's current account description to include the new item, in place
local function buildDescription(desc: HumanoidDescription, context: EquipContext): (boolean, EquipResult?)
	local anyDesc: any = desc
	if context.kind == "emote" then
		-- Add to the emote library + a free wheel slot (skip if the wheel is full)
		local equipped = anyDesc:GetEquippedEmotes()
		local used: {[number]: boolean} = {}
		for _, slot in equipped do
			used[slot.Slot] = true
		end
		local freeSlot: number? = nil
		for slot = 1, MAX_EQUIPPED_EMOTES do
			if not used[slot] then
				freeSlot = slot
				break
			end
		end
		if not freeSlot then
			return false, "wheelFull"
		end
		local emoteName = context.name ~= "" and context.name or ("Emote " .. tostring(context.assetId))
		anyDesc:AddEmote(emoteName, context.assetId)
		table.insert(equipped, { Slot = freeSlot, Name = emoteName, Id = context.assetId })
		anyDesc:SetEquippedEmotes(equipped)
		return true, nil
	elseif context.kind == "accessory" then
		local accType = context.assetTypeId and ACCESSORY_TYPE_BY_ASSET_TYPE[context.assetTypeId]
		if not accType then
			return false, "error"
		end
		local isLayered = context.assetTypeId ~= nil and LAYERED_ASSET_TYPES[context.assetTypeId] == true
		local accessories = anyDesc:GetAccessories(true)
		local maxOrder = 0
		for _, accessory in accessories do
			if typeof(accessory.Order) == "number" and accessory.Order > maxOrder then
				maxOrder = accessory.Order
			end
		end
		local entry: any = { AssetId = context.assetId, AccessoryType = accType }
		if isLayered then
			entry.IsLayered = true
			entry.Order = maxOrder + 1
		end
		table.insert(accessories, entry)
		anyDesc:SetAccessories(accessories, true)
		return true, nil
	elseif context.kind == "clothing" then
		local property = context.assetTypeId and CLOTHING_PROPERTY[context.assetTypeId]
		if not property then
			return false, "error"
		end
		anyDesc[property] = context.assetId
		return true, nil
	end
	return false, "error"
end

-- Fetch the bundle's full outfit description (REPLACE behaviour - a bundle is a whole look)
local function fetchBundleDescription(bundleId: number): HumanoidDescription?
	local ok, result = pcall(function(): HumanoidDescription
		local details = AssetService:GetBundleDetailsAsync(bundleId)
		local outfitId: number? = nil
		for _, item in (details :: any).Items do
			if item.Type == "UserOutfit" then
				outfitId = item.Id
				break
			end
		end
		if not outfitId then
			error("Bundle has no outfit")
		end
		return Players:GetHumanoidDescriptionFromOutfitId(outfitId)
	end)
	return if ok and typeof(result) == "Instance" then result else nil
end


-- FUNCTIONS
-- YIELDS until the native save prompt is answered. returns an EquipResult. callers must
-- task.spawn this so the click handler isn't blocked while the Roblox prompt is open
function EquipToAccount.equip(context: EquipContext): EquipResult
	if promptOpen then
		return "busy"
	end
	promptOpen = true
	local function release(result: EquipResult): EquipResult
		promptOpen = false
		return result
	end

	-- The rig of the avatar we're saving (emotes are R15-centric, but pass the real rig)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid") :: Humanoid?
	if not humanoid then
		return release("noCharacter")
	end
	local rigType = humanoid.RigType

	-- The base description: the player's TRUE account avatar (not the session character,
	-- which HD may have modified). we add to this and save the whole thing back
	local desc: HumanoidDescription
	if context.kind == "bundle" then
		-- REPLACE: equipping a bundle means wearing its complete look
		local bundleDesc = fetchBundleDescription(context.assetId)
		if not bundleDesc then
			return release("error")
		end
		desc = bundleDesc
	else
		local ok, fetched = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(player.UserId)
		end)
		if not ok or typeof(fetched) ~= "Instance" then
			return release("error")
		end
		desc = fetched
		local built, failResult = buildDescription(desc, context)
		if not built then
			return release(failResult or "error")
		end
	end

	-- Conform to the platform avatar rules (fixes scaling / remaps classic head). best
	-- effort - if it errors we save the unconformed description rather than abort
	local conformed = desc
	local conformOk, conformedResult = pcall(function()
		return AvatarEditorService:ConformToAvatarRulesAsync(desc)
	end)
	if conformOk and typeof(conformedResult) == "Instance" then
		conformed = conformedResult
	end

	-- Fire the native save prompt and wait for its completion event
	local resultValue: Enum.AvatarPromptResult? = nil
	local done = false
	pendingResolve = function(promptResult)
		resultValue = promptResult
		done = true
	end
	local saveOk = pcall(function()
		AvatarEditorService:PromptSaveAvatar(conformed, rigType)
	end)
	if not saveOk then
		pendingResolve = nil
		return release("error")
	end
	local startClock = os.clock()
	while not done and os.clock() - startClock < SAVE_TIMEOUT do
		task.wait()
	end
	if not done then
		-- Never completed: drop the stale listener target and release the debounce
		pendingResolve = nil
		return release("failed")
	end
	-- promptOpen was already cleared by the completion handler
	if resultValue == Enum.AvatarPromptResult.Success then
		return "success"
	elseif resultValue == Enum.AvatarPromptResult.PermissionDenied then
		return "declined" -- the user backed out of the native prompt
	end
	return "failed"
end


return EquipToAccount
