-- Reconstructed low-overhead backend for the decompiled Avatar Maker place.
-- The original server source was not present in the saved place.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local AvatarEditorService = game:GetService("AvatarEditorService")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local TextService = game:GetService("TextService")
local DataStoreService = game:GetService("DataStoreService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- ===== ADMIN PANEL PERMISSIONS =====
-- Add Roblox user IDs below. ONLY these users will see the admin panel button.
local ADMIN_USER_IDS = {
	0, -- Your friends UserID
}

-- The game creator always has admin. Usernames below are a legacy fallback;
-- remove entries if you want the ID list to be the only way in.
local ADMIN_USERNAMES = {
	"Username",
}

local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers")
if not HiddenPlayers then
	HiddenPlayers = Instance.new("Folder")
	HiddenPlayers.Name = "HiddenPlayers"
	HiddenPlayers.Parent = ReplicatedStorage
end

local handlers = {}
local rateWindows = {}

local ZERO_STATISTICS = {
	Playtime = 0,
	Likes = 0,
	Sessions = 0,
	DaysPlayed = 0,
	Customizations = 0,
	RobuxSpent = 0,
	RobuxSavedByPlus = 0,
	RobloxPlusUpsellDismissedAt = 0,
}

local function fallback(name, ...)
	local first = select(1, ...)
	if name == "GetFlag" then
		return true, false
	elseif name == "GetSettings" or name == "GetConfig" or name == "GetRecentItems" then
		return {}
	elseif name == "GetHistoryState" then
		return { canUndo = false, canRedo = false }
	elseif name == "IsPrivateServer" then
		return game.PrivateServerId ~= ""
	elseif name == "GetStatistics" then
		return table.clone(ZERO_STATISTICS)
	elseif name == "ShoppingCartAction" then
		if first == "GetCart" then return {} end
		return false, "Server is still loading."
	elseif name == "OnboardingAction" then
		if first == "Get" then return {} end
		return true
	elseif name == "AccessoryAdjustmentAction" then
		if type(first) == "table" and first.Action == "GetCurrentAdjustments" then return {} end
		return false, "Server is still loading."
	elseif name == "GetFavorites" then
		return true, {}
	elseif name == "SavedOutfitAction" then
		if type(first) == "table" and first.Action == "Get" then
			return true, { Outfits = {}, Tags = {} }
		end
		return false, "Server is still loading."
	elseif name == "SavedPoseAction" then
		if type(first) == "table" and first.Action == "Get" then return true, {} end
		return false, "Server is still loading."
	elseif name == "GetBundleDetails" then
		return false, "Bundle unavailable."
	elseif name == "GetBundleDetailsBatch" or name == "GetAssetBundlePriceBatch" then
		return true, {}
	elseif name == "GetAssetBundlePrice" or name == "GetCharacterCFrame" or name == "GetHumanoidDescription" then
		return nil
	elseif name == "GetMovementAnimations" then
		return {}
	elseif name == "GetRecommendedAssets" or name == "GetRobloxOutfits" then
		return true, {}
	elseif name == "GetGroupInfo" or name == "GetEmote" then
		return false, "Unavailable."
	elseif name == "GetUserProfileInfo" then
		return {
			UserInfo = { DisplayName = "", Description = "", HasVerifiedBadge = false },
			FollowerCount = 0,
			FriendCount = 0,
		}
	elseif name == "GetRobloxFavorites" then
		return false, "alreadyImported"
	elseif name == "LikeAction" then
		if first == "GetLikes" then return 0 end
		return false
	elseif name == "RemoveItemsBulk" then
		return 0
	elseif name == "CommunityOutfitsAction" then
		if first == "IsFavorited" then return false end
		return true, {}
	elseif name == "CreditsAction" then
		return true, {
			Balance = 0, Earned = 0, Tier = 0, TierThreshold = 0,
			NextTier = 0, NextTierThreshold = 0, MemberSince = os.time(),
		}
	elseif name == "BuildAction" then
		if first == "CanManage" then return false end
		return { success = first == "List", builds = {} }
	elseif name == "CheckOutfitPrivacy" then
		return true
	elseif name == "AcknowledgeWarning" then
		return nil
	elseif name == "BodyPresetAction" then
		return true, {}
	elseif name == "WearLatestOutfitResponse" then
		return true
	elseif name == "UpdateSettings" then
		return true, {}
	end

	return false, "Feature unavailable."
end

local BOOTSTRAP_REMOTE = {
	GetFlag = true,
	GetSettings = true,
	GetConfig = true,
	GetHistoryState = true,
	IsPrivateServer = true,
}

local function requestAllowed(player, remoteName)
	if BOOTSTRAP_REMOTE[remoteName] then return true end
	local userId = player.UserId
	local userWindows = rateWindows[userId]
	if not userWindows then
		userWindows = {}
		rateWindows[userId] = userWindows
	end

	local now = os.clock()
	local window = userWindows[remoteName]
	if not window or now - window.started >= 1 then
		userWindows[remoteName] = { started = now, count = 1 }
		return true
	end

	window.count += 1
	local limit = remoteName == "SetBodyAdjustment" and 60 or 30
	return window.count <= limit
end

for _, remote in Remotes:GetChildren() do
	if remote:IsA("RemoteFunction") then
		local remoteName = remote.Name
		remote.OnServerInvoke = function(player, ...)
			if not requestAllowed(player, remoteName) then
				return fallback(remoteName, ...)
			end

			local handler = handlers[remoteName]
			if not handler then
				return fallback(remoteName, ...)
			end

			local result = table.pack(pcall(handler, player, ...))
			if not result[1] then
				warn(string.format("[AvatarMaker] %s failed for %d: %s", remoteName, player.UserId, tostring(result[2])))
				return fallback(remoteName, ...)
			end

			return table.unpack(result, 2, result.n)
		end
	end
end

local DEFAULT_SETTINGS = {
	Profile = {
		ChatTagText = "", ChatTagColor = "", ChatNameColor = "", ChatTextColor = "",
		RoleplayName = "", Speed = 16, JumpPower = 50, Gravity = 196.2,
		Privacy = { WhoCanViewOutfit = "Everyone", WhoCanTryOnOutfit = "Everyone" },
		AnonymizeAnnouncements = false,
	},
	Interface = {
		ReduceFrontPageVibrancy = false, AvatarPreviewOnRight = false,
		AvatarSectionBackground = "", Theme = "Dark", FrontPageScrollStyle = "Step",
		LargerCatalogItems = false, ShowAdjustBodyButton = true, ShowCatalogFrontPage = true,
		PreviewItemOnHover = false, ItemPreviewDelay = 0, HideSameTypeOnPreview = true,
		PreviewCurrentlyWearing = false,
	},
	Catalog = { CategorySelectionMode = "HorizontalScroll" },
	Audio = {
		UIVolume = 50, MusicVolume = 35, SFXVolume = 50,
		EnableButtonHoverSounds = true, EnableButtonClickSounds = true,
	},
	World = { Shadows = false, ClockTime = 14.5, Map = "baseplate" },
	Camera = {
		FollowHead = false, FieldOfView = 70, Saturation = 0, Contrast = 0,
		Brightness = 0, Bloom = 0, Blur = 0, OffsetX = 0, OffsetY = 0, OffsetZ = 0,
		DepthOfField = {
			Enabled = false, FarIntensity = 75, NearIntensity = 75,
			FocusDistance = 16, InFocusRadius = 30,
		},
	},
	Miscellaneous = {
		DefaultSaveAsGameOutfit = "Ask", WearLatestOutfitOnReset = false,
		EnableLikeVFX = true, EnableOutfitUpdateVFX = true,
		GearScriptsInPrivateServer = false, HideOtherPlayers = false,
		ShowActivityAboveHead = false, HidePlayerNametags = false,
		HidePurchaseAnnouncements = false, HideBlocksInTransformMode = true,
	},
}

local function cloneValue(value, depth)
	depth = depth or 0
	if type(value) ~= "table" then return value end
	if depth >= 8 then return {} end
	local result = {}
	for key, child in pairs(value) do
		if type(key) == "string" or type(key) == "number" then
			result[key] = cloneValue(child, depth + 1)
		end
	end
	return result
end

local function sanitizeValue(value, depth, budget)
	depth = depth or 0
	budget = budget or { count = 0 }
	budget.count += 1
	if budget.count > 256 or depth > 6 then return nil end

	local kind = typeof(value)
	if kind == "boolean" then return value end
	if kind == "number" then
		if value ~= value or value == math.huge or value == -math.huge then return nil end
		return value
	end
	if kind == "string" then return string.sub(value, 1, 200) end
	if kind == "Color3" then return "#" .. value:ToHex() end
	if kind ~= "table" then return nil end

	local result = {}
	for key, child in pairs(value) do
		if type(key) == "string" or type(key) == "number" then
			local clean = sanitizeValue(child, depth + 1, budget)
			if clean ~= nil then result[key] = clean end
		end
	end
	return result
end

local function mergeKnown(target, patch, schema)
	if type(patch) ~= "table" or type(schema) ~= "table" then return end
	for key, value in pairs(patch) do
		local schemaValue = schema[key]
		if schemaValue ~= nil then
			if type(schemaValue) == "table" and type(value) == "table" then
				target[key] = type(target[key]) == "table" and target[key] or {}
				mergeKnown(target[key], value, schemaValue)
			elseif type(schemaValue) ~= "table" and type(value) == type(schemaValue) then
				target[key] = value
			end
		end
	end
end

local function newSession()
	return {
		settings = cloneValue(DEFAULT_SETTINGS),
		favorites = {}, cart = {}, recents = {}, onboarding = {}, adjustments = {},
		savedOutfits = { Outfits = {}, Tags = {} }, savedPoses = {}, bodyPresets = {}, builds = {},
		credits = {
			Balance = 0, Earned = 0, Tier = 0, TierThreshold = 0,
			NextTier = 0, NextTierThreshold = 0, MemberSince = os.time(),
		},
		undo = {}, redo = {}, baseline = nil, busy = false, dirty = false,
	}
end

local sessions = {}

local function sessionFor(player)
	local session = sessions[player]
	if not session then
		session = newSession()
		sessions[player] = session
	end
	return session
end

local function applyPlayerAttributes(player, settings)
	local profile = settings.Profile or {}
	for _, key in ipairs({ "RoleplayName", "ChatTagText", "ChatTagColor", "ChatNameColor", "ChatTextColor" }) do
		player:SetAttribute(key, type(profile[key]) == "string" and profile[key] or "")
	end
	player:SetAttribute("HudStrokeVariant", "A")
	player:SetAttribute("CreditChipEnabled", false)
	player:SetAttribute("CreditsEarnRate", 0)
	player:SetAttribute("ExclusiveShopEnabled", false)
	player:SetAttribute("StaffRole", "")
	player:SetAttribute("StaffVanished", false)
	player:SetAttribute("AvatarAutoHidden", false)
	player:SetAttribute("AvatarAutoHiddenScore", 0)

	local isCreator = game.CreatorType == Enum.CreatorType.User and game.CreatorId > 0 and player.UserId == game.CreatorId

	-- User ID check (primary permission method)
	local isAdminById = false
	for _, adminId in ipairs(ADMIN_USER_IDS) do
		if player.UserId == tonumber(adminId) then
			isAdminById = true
			break
		end
	end

	-- Username check (legacy fallback)
	local isAdminByUsername = false
	for _, username in ipairs(ADMIN_USERNAMES) do
		if string.lower(player.Name) == string.lower(username) then
			isAdminByUsername = true
			break
		end
	end

	player:SetAttribute("IsAdministrator", isCreator or isAdminById or isAdminByUsername)
	player:SetAttribute("IsContentModerator", false)
	player:SetAttribute("IsContentAdministrator", false)
	player:SetAttribute("IsTrialModerator", false)
end

local function remoteEvent(name)
	local remote = Remotes:FindFirstChild(name)
	return remote and remote:IsA("RemoteEvent") and remote or nil
end

local DESCRIPTION_PROPERTIES = {
	"BackAccessory", "BodyTypeScale", "ClimbAnimation", "DepthScale", "Face", "FaceAccessory",
	"FallAnimation", "FrontAccessory", "GraphicTShirt", "HairAccessory", "HatAccessory", "Head",
	"HeadColor", "HeadScale", "HeightScale", "IdleAnimation", "JumpAnimation", "LeftArm",
	"LeftArmColor", "LeftLeg", "LeftLegColor", "MoodAnimation", "NeckAccessory", "Pants",
	"ProportionScale", "RightArm", "RightArmColor", "RightLeg", "RightLegColor", "RunAnimation",
	"Shirt", "ShouldersAccessory", "StaticFacialAnimation", "SwimAnimation", "Torso", "TorsoColor",
	"WaistAccessory", "WalkAnimation", "WidthScale",
}

local DESCRIPTION_PROPERTY = {
	Pants = "Pants", Shirt = "Shirt", TShirt = "GraphicTShirt", GraphicTShirt = "GraphicTShirt",
	Face = "Face", Head = "Head", DynamicHead = "Head", Torso = "Torso",
	LeftArm = "LeftArm", RightArm = "RightArm", LeftLeg = "LeftLeg", RightLeg = "RightLeg",
	MoodAnimation = "MoodAnimation", ClimbAnimation = "ClimbAnimation", FallAnimation = "FallAnimation",
	IdleAnimation = "IdleAnimation", JumpAnimation = "JumpAnimation", RunAnimation = "RunAnimation",
	SwimAnimation = "SwimAnimation", WalkAnimation = "WalkAnimation",
}

local BODY_COLORS = {
	Head = "HeadColor", LeftArm = "LeftArmColor", RightArm = "RightArmColor",
	LeftLeg = "LeftLegColor", RightLeg = "RightLegColor", Torso = "TorsoColor",
}

local BODY_SCALE_LIMITS = {
	HeightScale = { 0.6, 1.3 }, WidthScale = { 0.6, 1.3 }, DepthScale = { 0.6, 1.2 },
	ProportionScale = { 0, 1 }, BodyTypeScale = { 0, 1 }, HeadScale = { 0.8, 1.1 },
}

local LAYER_PRIORITY = {
	Eyelash = 1, Eyebrow = 2, LeftShoe = 3, RightShoe = 3,
	Pants = 4, Shorts = 5, DressSkirt = 6, TShirt = 7,
	Shirt = 8, Sweater = 9, Jacket = 10,
}

local catalogUtilities = nil
task.defer(function()
	local module = ReplicatedStorage:FindFirstChild("CatalogUtilities")
	if not module then return end
	local success, result = pcall(require, module)
	if success then catalogUtilities = result end
end)

local function serializeDescription(description, rigType, adjustments)
	local data = { RigType = (rigType or Enum.HumanoidRigType.R15).Name, Accessories = {} }
	for _, property in ipairs(DESCRIPTION_PROPERTIES) do
		pcall(function()
			local value = description[property]
			if typeof(value) == "Color3" then
				data[property] = value:ToHex()
			elseif type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
				data[property] = value
			end
		end)
	end

	pcall(function()
		for _, accessory in ipairs(description:GetAccessories(true)) do
			local entry = {}
			for key, value in pairs(accessory) do
				local kind = typeof(value)
				if kind == "EnumItem" then entry[key] = value.Name
				elseif kind == "Vector3" then entry[key] = { value.X, value.Y, value.Z }
				elseif kind == "number" or kind == "string" or kind == "boolean" then entry[key] = value end
			end
			table.insert(data.Accessories, entry)
		end
	end)

	pcall(function() data.Emotes = description:GetEmotes() end)
	pcall(function() data.EquippedEmotes = description:GetEquippedEmotes() end)

	local makeup = {}
	for _, child in ipairs(description:GetChildren()) do
		if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head and child.HeadShape ~= "" then
			data.HeadShape = child.HeadShape
		elseif child:IsA("MakeupDescription") then
			table.insert(makeup, { AssetId = child.AssetId, MakeupType = child.MakeupType.Name, Order = child.Order })
		end
	end
	if #makeup > 0 then data.Makeup = makeup end
	if type(adjustments) == "table" then data.AccessoryAdjustments = sanitizeValue(adjustments) or {} end

	local success, encoded = pcall(HttpService.JSONEncode, HttpService, data)
	return success and encoded or nil
end

local function deserializeDescription(serialized)
	if type(serialized) ~= "string" or #serialized > 200000 then return nil end
	local success, data = pcall(HttpService.JSONDecode, HttpService, serialized)
	if not success or type(data) ~= "table" then return nil end

	local description = Instance.new("HumanoidDescription")
	for _, property in ipairs(DESCRIPTION_PROPERTIES) do
		local value = data[property]
		if value ~= nil then
			pcall(function()
				if string.find(property, "Color", 1, true) and type(value) == "string" then
					description[property] = Color3.fromHex(value)
				else
					description[property] = value
				end
			end)
		end
	end

	if type(data.Accessories) == "table" then
		local accessories = {}
		for _, raw in ipairs(data.Accessories) do
			if type(raw) == "table" and type(raw.AssetId) == "number" and #accessories < 20 then
				local accessoryType = Enum.AccessoryType:FromName(tostring(raw.AccessoryType or "Unknown"))
				if accessoryType and accessoryType ~= Enum.AccessoryType.Unknown then
					table.insert(accessories, {
						AssetId = math.floor(raw.AssetId), AccessoryType = accessoryType,
						Order = tonumber(raw.Order), Puffiness = tonumber(raw.Puffiness),
					})
				end
			end
		end
		pcall(description.SetAccessories, description, accessories, true)
	end

	if type(data.Emotes) == "table" then pcall(description.SetEmotes, description, data.Emotes) end
	if type(data.EquippedEmotes) == "table" then pcall(description.SetEquippedEmotes, description, data.EquippedEmotes) end
	if type(data.HeadShape) == "string" and data.HeadShape ~= "" then
		pcall(function()
			local bodyPart = Instance.new("BodyPartDescription")
			bodyPart.BodyPart = Enum.BodyPart.Head
			bodyPart.AssetId = description.Head
			bodyPart.HeadShape = data.HeadShape
			bodyPart.Parent = description
		end)
	end
	if type(data.Makeup) == "table" then
		for index, raw in ipairs(data.Makeup) do
			if index > 10 then break end
			if type(raw) == "table" and tonumber(raw.AssetId) then
				pcall(function()
					local makeupType = Enum.MakeupType:FromName(tostring(raw.MakeupType or ""))
					if not makeupType then return end
					local makeup = Instance.new("MakeupDescription")
					makeup.AssetId = math.floor(tonumber(raw.AssetId))
					makeup.MakeupType = makeupType
					makeup.Order = math.clamp(math.floor(tonumber(raw.Order) or index), 1, 20)
					makeup.Parent = description
				end)
			end
		end
	end
	return description, Enum.HumanoidRigType:FromName(tostring(data.RigType or "R15")) or Enum.HumanoidRigType.R15
end

local function destroyDescriptions(list)
	for _, description in ipairs(list) do
		if typeof(description) == "Instance" then description:Destroy() end
	end
	table.clear(list)
end

local function historyState(session)
	return { canUndo = #session.undo > 0, canRedo = #session.redo > 0 }
end

local function fireHistory(player, session)
	local event = remoteEvent("HistoryStateUpdated")
	if event then event:FireClient(player, historyState(session)) end
end

local function pushUndo(player, session, description)
	table.insert(session.undo, description)
	while #session.undo > 8 do
		local expired = table.remove(session.undo, 1)
		expired:Destroy()
	end
	destroyDescriptions(session.redo)
	fireHistory(player, session)
end

local function getHumanoid(player)
	local character = player.Character
	if not character then return nil end
	return character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
end

local function applyToHumanoid(humanoid, description)
	local success, result = pcall(function()
		humanoid:ApplyDescriptionResetAsync(description)
	end)
	if not success then
		success, result = pcall(function() humanoid:ApplyDescriptionReset(description) end)
	end
	return success, result
end

local function refreshParentedDescription(player)
	local humanoid = getHumanoid(player)
	if not humanoid then return end
	local success, description = pcall(humanoid.GetAppliedDescription, humanoid)
	if not success or not description then return end
	description.Name = "HumanoidDescription"
	local previous = humanoid:FindFirstChild("HumanoidDescription")
	if previous then previous:Destroy() end
	description.Parent = humanoid
end

local function descriptionUpdated(player)
	refreshParentedDescription(player)
	local event = remoteEvent("HumanoidDescriptionUpdated")
	if event then event:FireClient(player) end
end

local function mutateDescription(player, mutator)
	local session = sessionFor(player)
	if session.busy then return false, "Avatar is busy. Please try again." end
	local humanoid = getHumanoid(player)
	if not humanoid then return false, "Character is not ready." end

	session.busy = true
	local gotCurrent, current = pcall(humanoid.GetAppliedDescription, humanoid)
	if not gotCurrent or not current then
		session.busy = false
		return false, "Avatar description is unavailable."
	end
	local cloned, before = pcall(current.Clone, current)
	if not cloned or not before then
		current:Destroy()
		session.busy = false
		return false, "Avatar description could not be copied."
	end
	local mutation = table.pack(pcall(mutator, current, session))
	if not mutation[1] or mutation[2] == false then
		current:Destroy()
		before:Destroy()
		session.busy = false
		return false, mutation[1] and (mutation[3] or "Invalid avatar change.") or "Avatar change failed."
	end

	local success = applyToHumanoid(humanoid, current)
	current:Destroy()
	session.busy = false
	if not success then
		before:Destroy()
		return false, "Roblox could not apply that avatar item."
	end

	pushUndo(player, session, before)
	session.customizations = (session.customizations or 0) + 1
	session.dirty = true
	descriptionUpdated(player)
	return true
end

local function replaceDescription(player, replacement)
	local session = sessionFor(player)
	if session.busy then replacement:Destroy(); return false, "Avatar is busy." end
	local humanoid = getHumanoid(player)
	if not humanoid then replacement:Destroy(); return false, "Character is not ready." end

	session.busy = true
	local gotCurrent, before = pcall(humanoid.GetAppliedDescription, humanoid)
	if not gotCurrent or not before then
		replacement:Destroy()
		session.busy = false
		return false, "Avatar description is unavailable."
	end
	local success = applyToHumanoid(humanoid, replacement)
	replacement:Destroy()
	session.busy = false
	if not success then before:Destroy(); return false, "Roblox could not apply that avatar." end

	pushUndo(player, session, before)
	session.customizations = (session.customizations or 0) + 1
	session.dirty = true
	descriptionUpdated(player)
	return true
end

local assetTypeCache = {}
local assetTypeOrder = {}
local bundleCache = {}
local bundleOrder = {}

local function cachePut(cache, order, key, value, maximum)
	for index = #order, 1, -1 do
		if order[index] == key then table.remove(order, index) end
	end
	table.insert(order, key)
	cache[key] = { value = value, expires = os.clock() + 900 }
	while #order > maximum do
		local expired = table.remove(order, 1)
		cache[expired] = nil
	end
end

local function cacheGet(cache, key)
	local entry = cache[key]
	if entry and entry.expires > os.clock() then return entry.value end
	cache[key] = nil
	return nil
end

local function normalizeAssetType(value)
	if typeof(value) == "EnumItem" then return value.Name end
	if type(value) == "string" then return value end
	if type(value) == "number" then
		local enumItem = Enum.AvatarAssetType:FromValue(value) or Enum.AssetType:FromValue(value)
		return enumItem and enumItem.Name or nil
	end
	return nil
end

local function resolveAssetType(assetId, hint)
	local cached = cacheGet(assetTypeCache, assetId)
	if cached then return cached end

	local resolved = nil
	pcall(function()
		local details = AvatarEditorService:GetItemDetailsAsync(assetId, Enum.AvatarItemType.Asset)
		resolved = normalizeAssetType(details.AssetType or details.AssetTypeId)
	end)
	if not resolved then
		pcall(function()
			local info = MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
			resolved = normalizeAssetType(info.AssetTypeId)
		end)
	end
	if not resolved and type(hint) == "string" and #hint <= 40 then resolved = hint end
	if resolved then cachePut(assetTypeCache, assetTypeOrder, assetId, resolved, 96) end
	return resolved
end

local function getBundleDetails(bundleId)
	local cached = cacheGet(bundleCache, bundleId)
	if cached then return true, cloneValue(cached) end

	local raw = nil
	pcall(function()
		raw = AvatarEditorService:GetItemDetailsAsync(bundleId, Enum.AvatarItemType.Bundle)
	end)
	if not raw then
		pcall(function() raw = MarketplaceService:GetProductInfo(bundleId, Enum.InfoType.Bundle) end)
	end
	if type(raw) ~= "table" then return false, "Bundle details unavailable." end

	local rawItems = raw.Items or raw.BundledItems or {}
	local items = {}
	for _, item in ipairs(rawItems) do
		if #items >= 25 then break end
		local id = tonumber(item.AssetId or item.Id)
		local itemType = tostring(item.Type or item.ItemType or "Asset")
		if id and id > 0 and itemType == "Asset" then
			local assetType = resolveAssetType(math.floor(id), normalizeAssetType(item.AssetType or item.AssetTypeId))
			table.insert(items, {
				Id = math.floor(id), AssetId = math.floor(id), Name = tostring(item.Name or "Item"),
				Type = "Asset", AssetType = assetType, AssetTypeName = assetType,
			})
		end
	end

	local bundleType = normalizeAssetType(raw.BundleType) or tostring(raw.BundleType or "")
	if bundleType == "" or bundleType == "nil" then
		local hasBody, hasAnimation, hasLeftShoe, hasRightShoe, hasHead = false, false, false, false, false
		for _, item in ipairs(items) do
			local kind = item.AssetTypeName or ""
			hasBody = hasBody or DESCRIPTION_PROPERTY[kind] ~= nil and not string.find(kind, "Animation$")
			hasAnimation = hasAnimation or string.find(kind, "Animation$") ~= nil
			hasLeftShoe = hasLeftShoe or kind == "LeftShoeAccessory"
			hasRightShoe = hasRightShoe or kind == "RightShoeAccessory"
			hasHead = hasHead or kind == "DynamicHead" or kind == "Head"
		end
		if hasLeftShoe and hasRightShoe then bundleType = "Shoes"
		elseif hasAnimation then bundleType = "AvatarAnimations"
		elseif hasHead and #items <= 3 then bundleType = "DynamicHead"
		elseif hasBody then bundleType = "BodyParts"
		else bundleType = "Bundle" end
	end

	local details = {
		Id = bundleId, Name = tostring(raw.Name or "Bundle"), BundleType = bundleType, Items = items,
	}
	cachePut(bundleCache, bundleOrder, bundleId, details, 64)
	return true, cloneValue(details)
end

local function accessoryTypeFor(assetTypeName)
	local enumItem = Enum.AvatarAssetType:FromName(assetTypeName)
	if not enumItem and string.match(assetTypeName, "Accessory$") then
		enumItem = Enum.AvatarAssetType:FromName(string.gsub(assetTypeName, "Accessory$", ""))
	end
	if not enumItem then return nil end
	local success, accessoryType = pcall(AvatarEditorService.GetAccessoryType, AvatarEditorService, enumItem)
	if success and accessoryType ~= Enum.AccessoryType.Unknown then return accessoryType end
	return nil
end

local function setAsset(description, baseline, assetId, assetTypeName, removing)
	assetTypeName = tostring(assetTypeName or "")
	if assetTypeName == "" then return false, "Unknown avatar item type." end
	if assetTypeName == "Gear" then return false, "Gear scripts are disabled in safe mode." end

	if assetTypeName == "HeadShape" then
		local shapeKey = catalogUtilities and catalogUtilities.HeadShapeAssetIdToKey
		shapeKey = shapeKey and shapeKey[assetId] or ""
		for _, child in ipairs(description:GetChildren()) do
			if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
				child.HeadShape = removing and "" or shapeKey
				return true
			end
		end
		if not removing and shapeKey ~= "" then
			local bodyPart = Instance.new("BodyPartDescription")
			bodyPart.BodyPart = Enum.BodyPart.Head
			bodyPart.AssetId = description.Head
			bodyPart.HeadShape = shapeKey
			bodyPart.Parent = description
		end
		return true
	end

	local makeupTypeName = ({ FaceMakeup = "Face", EyeMakeup = "Eye", LipMakeup = "Lip" })[assetTypeName]
	if makeupTypeName then
		for _, child in ipairs(description:GetChildren()) do
			if child:IsA("MakeupDescription") and (child.AssetId == assetId or child.MakeupType.Name == makeupTypeName) then
				child:Destroy()
			end
		end
		if not removing then
			local makeupType = Enum.MakeupType:FromName(makeupTypeName)
			if makeupType then
				local makeup = Instance.new("MakeupDescription")
				makeup.AssetId = assetId
				makeup.MakeupType = makeupType
				makeup.Order = 1
				makeup.Parent = description
			end
		end
		return true
	end

	local accessoryType = accessoryTypeFor(assetTypeName)
	if accessoryType then
		local accessories = description:GetAccessories(true)
		local filtered = {}
		for _, accessory in ipairs(accessories) do
			if accessory.AssetId ~= assetId then table.insert(filtered, accessory) end
		end
		if not removing then
			if #filtered >= 20 then return false, "Accessory limit reached." end
			table.insert(filtered, {
				AssetId = assetId, AccessoryType = accessoryType,
				Order = LAYER_PRIORITY[accessoryType.Name],
			})
		end
		description:SetAccessories(filtered, true)
		return true
	end

	local property = DESCRIPTION_PROPERTY[assetTypeName]
	if property then
		if removing then
			local fallbackValue = 0
			if baseline then pcall(function() fallbackValue = baseline[property] end) end
			if description[property] == assetId or assetTypeName:find("Animation$") then
				description[property] = fallbackValue
			end
		else
			description[property] = assetId
		end
		return true
	end

	return false, "This avatar item type is not supported."
end

local function applyAssetOrBundle(player, assetId, itemType, typeHint, removing)
	assetId = tonumber(assetId)
	if not assetId or assetId < 1 or assetId > 9007199254740991 then return false, "Invalid item ID." end
	assetId = math.floor(assetId)
	itemType = tostring(itemType or "Asset")

	return mutateDescription(player, function(description, session)
		if itemType == "Bundle" then
			local success, details = getBundleDetails(assetId)
			if not success then return false, details end
			for _, item in ipairs(details.Items or {}) do
				local ok, reason = setAsset(description, session.baseline, item.AssetId, item.AssetTypeName, removing)
				if not ok and reason ~= "Gear scripts are disabled in safe mode." then return false, reason end
			end
			return true
		end

		local resolvedType = resolveAssetType(assetId, typeHint)
		return setAsset(description, session.baseline, assetId, resolvedType, removing)
	end)
end

handlers.GetFlag = function(player, flagName)
	local allowed = {
		IsAdministrator = true, IsContentModerator = true,
		IsContentAdministrator = true, IsTrialModerator = true,
	}
	return true, allowed[flagName] and player:GetAttribute(flagName) == true or false
end

handlers.GetSettings = function(player)
	return cloneValue(sessionFor(player).settings)
end

handlers.UpdateSettings = function(player, patch)
	local clean = sanitizeValue(patch)
	if type(clean) ~= "table" then return false, "Invalid settings." end
	local session = sessionFor(player)
	mergeKnown(session.settings, clean, DEFAULT_SETTINGS)
	session.dirty = true
	applyPlayerAttributes(player, session.settings)
	local snapshot = cloneValue(session.settings)
	local event = remoteEvent("SettingsUpdated")
	if event then event:FireClient(player, snapshot) end
	return true, snapshot
end

handlers.GetConfig = function()
	return {}
end

handlers.GetHistoryState = function(player)
	return historyState(sessionFor(player))
end

handlers.GetHumanoidDescription = function(player)
	local humanoid = getHumanoid(player)
	if not humanoid then return nil end
	local description = humanoid:GetAppliedDescription()
	local serialized = serializeDescription(description, humanoid.RigType, sessionFor(player).adjustments)
	description:Destroy()
	return serialized
end

handlers.TryOnItem = function(player, id, itemType, assetTypeName)
	return applyAssetOrBundle(player, id, itemType, assetTypeName, false)
end

handlers.TakeOffItem = function(player, id, itemType, assetTypeName)
	return applyAssetOrBundle(player, id, itemType, assetTypeName, true)
end

handlers.ResetAvatar = function(player)
	local replacement = nil
	pcall(function() replacement = Players:GetHumanoidDescriptionFromUserIdAsync(player.UserId) end)
	if not replacement then
		local baseline = sessionFor(player).baseline
		if baseline then replacement = baseline:Clone() end
	end
	if not replacement then return false, "Your Roblox avatar could not be loaded." end
	return replaceDescription(player, replacement)
end

handlers.TryOnRobloxAvatar = function(player, userId)
	userId = tonumber(userId)
	if not userId or userId < 1 then return false, "Invalid user." end
	local replacement = nil
	pcall(function() replacement = Players:GetHumanoidDescriptionFromUserIdAsync(math.floor(userId)) end)
	if not replacement then return false, "Avatar unavailable." end
	return replaceDescription(player, replacement)
end

handlers.TryOnPlayerOutfit = function(player, target)
	local userId = typeof(target) == "Instance" and target:IsA("Player") and target.UserId or tonumber(target)
	return handlers.TryOnRobloxAvatar(player, userId)
end

handlers.TryOnOutfit = function(player, outfitId)
	outfitId = tonumber(outfitId)
	if not outfitId or outfitId < 1 then return false, "Invalid outfit." end
	local replacement = nil
	pcall(function() replacement = Players:GetHumanoidDescriptionFromOutfitIdAsync(math.floor(outfitId)) end)
	if not replacement then return false, "Outfit unavailable." end
	return replaceDescription(player, replacement)
end

handlers.SetBodyAdjustment = function(player, request)
	if type(request) ~= "table" then return false, "Invalid adjustment." end
	if request.Type == "BodyScale" and type(request.Properties) == "table" then
		return mutateDescription(player, function(description)
			local count = 0
			for property, value in pairs(request.Properties) do
				local limits = BODY_SCALE_LIMITS[property]
				if limits and type(value) == "number" and value == value then
					count += 1
					if count > 6 then return false, "Too many values." end
					description[property] = math.clamp(value, limits[1], limits[2])
				end
			end
			return count > 0, "No valid body scale supplied."
		end)
	elseif request.Type == "StaticFacialAnimation" then
		return mutateDescription(player, function(description)
			description.StaticFacialAnimation = request.Value == true
			return true
		end)
	elseif request.Type == "RigType" then
		return false, "Rig switching is unavailable in safe mode."
	end
	return false, "Unknown body adjustment."
end

handlers.CreateAvatarApply = function(player, changes)
	if type(changes) ~= "table" then return false end
	local success = mutateDescription(player, function(description, session)
		if type(changes.Scale) == "table" then
			for property, limits in pairs(BODY_SCALE_LIMITS) do
				local value = tonumber(changes.Scale[property])
				if value and value == value then description[property] = math.clamp(value, limits[1], limits[2]) end
			end
		end
		if type(changes.BodyParts) == "table" then
			for property in pairs(DESCRIPTION_PROPERTY) do
				local value = tonumber(changes.BodyParts[property])
				if value and DESCRIPTION_PROPERTY[property] then description[DESCRIPTION_PROPERTY[property]] = math.floor(value) end
			end
		end
		local head = tonumber(changes.HeadAssetId or changes.HeadId or changes.BodyHeadId)
		if head then description.Head = math.floor(head) end
		if changes.HeadlessHead == true then description.Head = 0 end
		if typeof(changes.SkinColor) == "Color3" then
			for _, property in pairs(BODY_COLORS) do description[property] = changes.SkinColor end
		end
		if type(changes.HairIds) == "table" then
			for _, id in ipairs(changes.HairIds) do
				id = tonumber(id)
				if id then
					local ok, reason = setAsset(description, session.baseline, math.floor(id), "HairAccessory", false)
					if not ok then return false, reason end
				end
			end
		end
		return true
	end)
	return success == true
end

handlers.GetBundleDetails = function(_, bundleId)
	bundleId = tonumber(bundleId)
	if not bundleId or bundleId < 1 then return false, "Invalid bundle." end
	return getBundleDetails(math.floor(bundleId))
end

handlers.GetBundleDetailsBatch = function(_, bundleIds)
	if type(bundleIds) ~= "table" then return false, "Invalid bundle list." end
	local result, seen = {}, {}
	for _, id in ipairs(bundleIds) do
		id = tonumber(id)
		if id and id > 0 and not seen[id] and #result < 25 then
			seen[id] = true
			local success, details = getBundleDetails(math.floor(id))
			if success then table.insert(result, details) end
		end
	end
	return true, result
end

handlers.GetEmote = function(_, assetId)
	assetId = tonumber(assetId)
	if not assetId or assetId < 1 then return false, "Invalid emote." end
	local name = "Emote"
	pcall(function()
		local info = MarketplaceService:GetProductInfo(math.floor(assetId), Enum.InfoType.Asset)
		name = tostring(info.Name or name)
	end)
	return true, { EmoteId = "rbxassetid://" .. tostring(math.floor(assetId)), EmoteName = name }
end

handlers.GetMovementAnimations = function(_, assetId)
	assetId = tonumber(assetId)
	if not assetId or assetId < 1 then return {} end
	return { { Id = "rbxassetid://" .. tostring(math.floor(assetId)), Weight = 1 } }
end

handlers.GetFavorites = function(player)
	return true, cloneValue(sessionFor(player).favorites)
end

handlers.SetFavorited = function(player, id, itemType, assetType, isFavorited)
	id = tonumber(id)
	if not id or id < 1 then return false, "Invalid item." end
	local session = sessionFor(player)
	local key = tostring(math.floor(id))
	if isFavorited == true then
		session.favorites[key] = {
			ItemType = tostring(itemType or "Asset"), AssetType = tostring(assetType or ""), FavoritedAt = os.time(),
		}
	else
		session.favorites[key] = nil
	end
	session.dirty = true
	local event = remoteEvent("FavoritesUpdated")
	if event then event:FireClient(player, cloneValue(session.favorites), false) end
	return true
end

handlers.GetRecentItems = function(player)
	return cloneValue(sessionFor(player).recents)
end

handlers.ShoppingCartAction = function(player, action, id, itemType, selected)
	local session = sessionFor(player)
	if action == "GetCart" then return cloneValue(session.cart) end
	if action == "Checkout" then return next(session.cart) ~= nil end
	id = tonumber(id)
	if not id or id < 1 then return false, "Invalid item." end
	local key = tostring(math.floor(id))
	if action == "AddItem" then
		if not session.cart[key] then
			local count = 0
			for _ in pairs(session.cart) do count += 1 end
			if count >= 100 then return false, "Cart is full." end
			session.cart[key] = { ItemType = tostring(itemType or "Asset"), IsSelected = true, Index = count + 1 }
		end
	elseif action == "RemoveItem" then
		session.cart[key] = nil
	elseif action == "SetItemSelected" then
		local item = session.cart[key]
		if not item then return false, "Item is not in cart." end
		item.IsSelected = selected == true
		session.dirty = true
		local event = remoteEvent("ShoppingCartUpdated")
		if event then event:FireClient(player, cloneValue(session.cart)) end
		return true, item.IsSelected
	else
		return false, "Unknown cart action."
	end
	session.dirty = true
	local event = remoteEvent("ShoppingCartUpdated")
	if event then event:FireClient(player, cloneValue(session.cart)) end
	return true
end

local function fireSessionSnapshot(player, eventName, value)
	local event = remoteEvent(eventName)
	if event then event:FireClient(player, cloneValue(value)) end
end

local function cleanLabel(player, value, fallbackValue)
	value = type(value) == "string" and string.sub(value, 1, 40) or fallbackValue
	value = string.gsub(value, "[%c<>]", "")
	value = string.match(value, "^%s*(.-)%s*$") or fallbackValue
	if value == "" then value = fallbackValue end
	local filtered = nil
	pcall(function()
		filtered = TextService:FilterStringAsync(value, player.UserId):GetNonChatStringForUserAsync(player.UserId)
	end)
	return type(filtered) == "string" and filtered ~= "" and string.sub(filtered, 1, 40) or value
end

local function boundedRuntimeValue(value, depth, budget)
	depth = depth or 0
	budget = budget or { count = 0 }
	budget.count += 1
	if depth > 5 or budget.count > 192 then return nil end
	local kind = typeof(value)
	if kind == "boolean" or kind == "string" then return value end
	if kind == "number" then
		return value == value and value ~= math.huge and value ~= -math.huge and value or nil
	end
	if kind == "Vector3" or kind == "CFrame" or kind == "Color3" then return value end
	if kind ~= "table" then return nil end
	local result = {}
	for key, child in pairs(value) do
		if type(key) == "string" or type(key) == "number" then
			local clean = boundedRuntimeValue(child, depth + 1, budget)
			if clean ~= nil then result[key] = clean end
		end
	end
	return result
end

local function accessoryKey(accessory)
	if typeof(accessory) ~= "Instance" then return nil end
	local assetId = accessory:GetAttribute("AssetId") or accessory:GetAttribute("assetId")
	if tonumber(assetId) then return tostring(math.floor(tonumber(assetId))) end
	local fromName = string.match(accessory.Name, "%d+")
	return fromName or accessory.Name
end

handlers.AccessoryAdjustmentAction = function(player, request)
	if type(request) ~= "table" then return false, "invalidRequest" end
	local action = request.Action
	local session = sessionFor(player)
	if action == "GetCurrentAdjustments" then
		return boundedRuntimeValue(session.adjustments) or {}
	elseif action == "GetInstanceFromDescription" then
		local description = request.AccessoryDescription
		local assetId = typeof(description) == "Instance" and tonumber(description.AssetId) or nil
		local wantedType = typeof(description) == "Instance" and description.AccessoryType or nil
		for _, child in ipairs((player.Character and player.Character:GetChildren()) or {}) do
			if child:IsA("Accessory") then
				local key = tonumber(accessoryKey(child))
				if (assetId and key == assetId) or (wantedType and child.AccessoryType == wantedType) then return child end
			end
		end
		return nil
	elseif action == "ResetAdjustments" then
		local accessory = request.Accessory
		if typeof(accessory) ~= "Instance" or not player.Character or not accessory:IsDescendantOf(player.Character) then
			return false, "invalidAccessory"
		end
		session.adjustments[accessoryKey(accessory) or accessory.Name] = nil
		local handle = accessory:FindFirstChild("Handle")
		if handle and handle:IsA("BasePart") then
			handle.Material = Enum.Material.Plastic
			handle.Transparency = 0
			handle.Reflectance = 0
		end
		for _, name in ipairs({ "Adjustment_UseColor", "Adjustment_Neon", "Adjustment_Hue", "Adjustment_SaturationValue", "Adjustment_Transparency", "Adjustment_Reflectance", "Adjustment_CustomTextureId", "Adjustment_Color" }) do
			accessory:SetAttribute(name, nil)
		end
	elseif action == "ApplyTransformAdjustment" then
		local clean = boundedRuntimeValue(request.Adjustments)
		if type(clean) ~= "table" or next(clean) == nil then return false, "noAdjustments" end
		local accepted, count = {}, 0
		for key, adjustment in pairs(clean) do
			if count >= 20 then break end
			if type(adjustment) == "table" then
				local position = typeof(adjustment.Position) == "Vector3" and adjustment.Position or Vector3.zero
				local rotation = typeof(adjustment.Rotation) == "Vector3" and adjustment.Rotation or Vector3.zero
				local scale = typeof(adjustment.Scale) == "Vector3" and adjustment.Scale or Vector3.one
				accepted[tostring(key)] = {
					Position = Vector3.new(math.clamp(position.X, -3, 3), math.clamp(position.Y, -3, 3), math.clamp(position.Z, -3, 3)),
					Rotation = Vector3.new(math.clamp(rotation.X, -180, 180), math.clamp(rotation.Y, -180, 180), math.clamp(rotation.Z, -180, 180)),
					Scale = Vector3.new(math.clamp(scale.X, 0.25, 3), math.clamp(scale.Y, 0.25, 3), math.clamp(scale.Z, 0.25, 3)),
				}
				count += 1
			end
		end
		if count == 0 then return false, "noAdjustments" end
		for key, adjustment in pairs(accepted) do
			session.adjustments[key] = session.adjustments[key] or {}
			session.adjustments[key].Transform = adjustment
		end
	elseif action == "ApplyPropertyAdjustment" then
		local accessory = request.Accessory
		if typeof(accessory) ~= "Instance" or not player.Character or not accessory:IsDescendantOf(player.Character) then
			return false, "invalidAccessory"
		end
		local key = accessoryKey(accessory) or accessory.Name
		local propertyData = {
			ActionType = tostring(request.ActionType or ""), UseColorEnabled = request.UseColorEnabled == true,
			IsEnabled = request.IsEnabled == true, Value = math.clamp(tonumber(request.Value) or 0, 0, 100),
			AssetId = string.sub(tostring(request.AssetId or ""), 1, 30),
			CustomTextureId = string.sub(tostring(request.CustomTextureId or ""), 1, 80),
		}
		if typeof(request.Color) == "Color3" then propertyData.Color = request.Color end
		session.adjustments[key] = session.adjustments[key] or {}
		session.adjustments[key].Properties = propertyData
		local handle = accessory:FindFirstChild("Handle")
		if handle and handle:IsA("BasePart") then
			if propertyData.ActionType == "Color" and propertyData.Color then
				handle.Color = propertyData.Color
				accessory:SetAttribute("Adjustment_Color", propertyData.Color)
				accessory:SetAttribute("Adjustment_UseColor", propertyData.UseColorEnabled)
			elseif propertyData.ActionType == "Neon" then
				handle.Material = propertyData.IsEnabled and Enum.Material.Neon or Enum.Material.Plastic
				accessory:SetAttribute("Adjustment_Neon", propertyData.IsEnabled)
			elseif propertyData.ActionType == "Transparency" then
				handle.Transparency = propertyData.Value / 100
				accessory:SetAttribute("Adjustment_Transparency", propertyData.Value)
			elseif propertyData.ActionType == "Reflectance" then
				handle.Reflectance = propertyData.Value / 100
				accessory:SetAttribute("Adjustment_Reflectance", propertyData.Value)
			elseif propertyData.ActionType == "CustomTexture" then
				accessory:SetAttribute("Adjustment_CustomTextureId", propertyData.AssetId)
			end
		end
	else
		return false, "unknownAction"
	end
	session.dirty = true
	fireSessionSnapshot(player, "AccessoryAdjustmentsChanged", session.adjustments)
	return true
end

handlers.GetCharacterCFrame = function(_, userId)
	local target = Players:GetPlayerByUserId(math.floor(tonumber(userId) or 0))
	local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	return root and root.CFrame or nil
end

handlers.GetStatistics = function(player)
	local result = cloneValue(ZERO_STATISTICS)
	local session = sessionFor(player)
	result.Playtime = math.max(0, math.floor(os.clock() - (session.joinedAt or os.clock())))
	result.Sessions = 1
	result.Customizations = session.customizations or 0
	return result
end

handlers.IsPrivateServer = function()
	return game.PrivateServerId ~= ""
end

handlers.GetGroupInfo = function(_, groupId)
	groupId = tonumber(groupId)
	if not groupId or groupId < 1 then return false, "Invalid group." end
	local success, info = pcall(GroupService.GetGroupInfoAsync, GroupService, math.floor(groupId))
	return success and type(info) == "table", success and info or "Group unavailable."
end

handlers.GetUserProfileInfo = function(_, userId)
	userId = math.floor(tonumber(userId) or 0)
	local result = {
		UserInfo = { Id = userId, Username = "", DisplayName = "", Description = "", HasVerifiedBadge = false },
		FollowerCount = 0, FriendCount = 0,
	}
	if userId < 1 then return result end
	pcall(function()
		local infos = Players:GetUserInfosByUserIdsAsync({ userId })
		local info = infos and infos[1]
		if info then
			result.UserInfo.Username = tostring(info.Username or "")
			result.UserInfo.DisplayName = tostring(info.DisplayName or info.Username or "")
			result.UserInfo.HasVerifiedBadge = info.HasVerifiedBadge == true
		end
	end)
	return result
end

handlers.GetRecommendedAssets = function()
	return true, {}
end

handlers.GetRobloxOutfits = function()
	return true, {}
end

handlers.GetRobloxFavorites = function()
	return false, "alreadyImported"
end

handlers.GetAssetBundlePrice = function(_, bundleId)
	bundleId = tonumber(bundleId)
	if not bundleId or bundleId < 1 then return nil end
	local price = nil
	pcall(function()
		local info = MarketplaceService:GetProductInfo(math.floor(bundleId), Enum.InfoType.Bundle)
		price = tonumber(info.PriceInRobux)
	end)
	return price
end

handlers.GetAssetBundlePriceBatch = function(_, ids)
	if type(ids) ~= "table" then return true, {} end
	local result, seen, count = {}, {}, 0
	for _, rawId in pairs(ids) do
		local id = math.floor(tonumber(rawId) or 0)
		if id > 0 and not seen[id] and count < 20 then
			seen[id], count = true, count + 1
			local price = handlers.GetAssetBundlePrice(nil, id)
			if price ~= nil then result[tostring(id)] = price end
		end
	end
	return true, result
end

local function currentOutfitRecord(player, name, id, created)
	local humanoid = getHumanoid(player)
	if not humanoid then return nil, "noCharacter" end
	local description = humanoid:GetAppliedDescription()
	local serialized = serializeDescription(description, humanoid.RigType, sessionFor(player).adjustments)
	description:Destroy()
	if not serialized then return nil, "serializeFailed" end
	return {
		Id = id, Name = cleanLabel(player, name, "New Outfit"), HumanoidDescription = serialized,
		RigType = humanoid.RigType.Name, Created = created or os.time(), Updated = os.time(),
		Tags = {}, IsFavorited = false,
	}
end

local function fireSavedOutfits(player, session)
	fireSessionSnapshot(player, "SavedOutfitsUpdated", session.savedOutfits)
end

handlers.SavedOutfitAction = function(player, request)
	if type(request) ~= "table" then return false, "invalidRequest" end
	local session = sessionFor(player)
	local data = session.savedOutfits
	local action = request.Action
	if action == "Get" then return true, cloneValue(data) end
	if action == "Save" then
		local count = 0
		for _ in pairs(data.Outfits) do count += 1 end
		if count >= 50 then return false, "full" end
		local id = HttpService:GenerateGUID(false)
		local record = nil
		if request.SourceType == "RobloxOutfit" and tonumber(request.SourceId) then
			local description = nil
			pcall(function() description = Players:GetHumanoidDescriptionFromOutfitIdAsync(math.floor(tonumber(request.SourceId))) end)
			if description then
				local serialized = serializeDescription(description, Enum.HumanoidRigType.R15, {})
				description:Destroy()
				if serialized then
					record = { Id = id, Name = cleanLabel(player, request.Name, "New Outfit"), HumanoidDescription = serialized, RigType = "R15", Created = os.time(), Updated = os.time(), Tags = {}, IsFavorited = false }
				end
			end
		elseif request.SourceType == "RobloxAvatar" and tonumber(request.SourceId) then
			local description = nil
			pcall(function() description = Players:GetHumanoidDescriptionFromUserIdAsync(math.floor(tonumber(request.SourceId))) end)
			if description then
				local serialized = serializeDescription(description, Enum.HumanoidRigType.R15, {})
				description:Destroy()
				if serialized then
					record = { Id = id, Name = cleanLabel(player, request.Name, "New Outfit"), HumanoidDescription = serialized, RigType = "R15", Created = os.time(), Updated = os.time(), Tags = {}, IsFavorited = false }
				end
			end
		else
			record = currentOutfitRecord(player, request.Name, id)
		end
		if not record then return false, "noCharacter" end
		data.Outfits[id] = record
	elseif action == "Update" then
		local old = data.Outfits[tostring(request.Id)] or data.Outfits[request.Id]
		if not old then return false, "notFound" end
		local replacement, reason = currentOutfitRecord(player, old.Name, old.Id, old.Created)
		if not replacement then return false, reason end
		replacement.Tags = cloneValue(old.Tags or {})
		replacement.IsFavorited = old.IsFavorited == true
		data.Outfits[old.Id] = replacement
		session.dirty = true
		fireSavedOutfits(player, session)
		return true, cloneValue(replacement)
	elseif action == "Delete" then
		local key = tostring(request.Id)
		if not data.Outfits[key] and data.Outfits[request.Id] then key = request.Id end
		if not data.Outfits[key] then return false, "notFound" end
		data.Outfits[key] = nil
	elseif action == "BulkDelete" then
		if type(request.Ids) ~= "table" then return false, "invalidIds" end
		for index, rawId in ipairs(request.Ids) do
			if index > 50 then break end
			data.Outfits[tostring(rawId)] = nil
			data.Outfits[rawId] = nil
		end
	elseif action == "Rename" then
		local outfit = data.Outfits[tostring(request.Id)] or data.Outfits[request.Id]
		if not outfit then return false, "notFound" end
		outfit.Name, outfit.Updated = cleanLabel(player, request.Name, outfit.Name), os.time()
	elseif action == "Favorite" then
		local outfit = data.Outfits[tostring(request.Id)] or data.Outfits[request.Id]
		if not outfit then return false, "notFound" end
		outfit.IsFavorited = request.IsFavorited == nil and not outfit.IsFavorited or request.IsFavorited == true
	elseif action == "IsFavorited" then
		local outfit = data.Outfits[tostring(request.Id)] or data.Outfits[request.Id]
		return outfit and outfit.IsFavorited == true or false
	elseif action == "CreateTag" then
		local tag = cleanLabel(player, request.Name or request.Tag, "Group")
		if not table.find(data.Tags, tag) and #data.Tags < 30 then table.insert(data.Tags, tag) end
	elseif action == "RenameTag" then
		local oldName = tostring(request.Name or "")
		local newName = cleanLabel(player, request.NewName, "Group")
		local index = table.find(data.Tags, oldName)
		if not index then return false, "notFound" end
		data.Tags[index] = newName
		for _, outfit in pairs(data.Outfits) do
			for i, tag in ipairs(outfit.Tags or {}) do if tag == oldName then outfit.Tags[i] = newName end end
		end
	elseif action == "DeleteTag" then
		local tagName = tostring(request.Name or request.Tag or "")
		local index = table.find(data.Tags, tagName)
		if index then table.remove(data.Tags, index) end
		for _, outfit in pairs(data.Outfits) do
			for i = #(outfit.Tags or {}), 1, -1 do if outfit.Tags[i] == tagName then table.remove(outfit.Tags, i) end end
		end
	elseif action == "TagOutfit" or action == "UntagOutfit" or action == "BulkTagOutfit" or action == "BulkUntagOutfit" then
		local tag = cleanLabel(player, request.Tag, "Group")
		if action == "TagOutfit" or action == "BulkTagOutfit" then
			if not table.find(data.Tags, tag) and #data.Tags < 30 then table.insert(data.Tags, tag) end
		end
		local ids = type(request.Ids) == "table" and request.Ids or { request.Id }
		for index, rawId in ipairs(ids) do
			if index > 50 then break end
			local outfit = data.Outfits[tostring(rawId)] or data.Outfits[rawId]
			if outfit then
				outfit.Tags = outfit.Tags or {}
				local tagIndex = table.find(outfit.Tags, tag)
				if (action == "TagOutfit" or action == "BulkTagOutfit") and not tagIndex then table.insert(outfit.Tags, tag)
				elseif tagIndex then table.remove(outfit.Tags, tagIndex) end
			end
		end
	else
		return false, "unknownAction"
	end
	session.dirty = true
	fireSavedOutfits(player, session)
	return true, cloneValue(data)
end

handlers.TryOnSavedOutfit = function(player, id)
	local outfit = sessionFor(player).savedOutfits.Outfits[tostring(id)] or sessionFor(player).savedOutfits.Outfits[id]
	if not outfit then return false, "Outfit not found." end
	local description = deserializeDescription(outfit.HumanoidDescription)
	if not description then return false, "Outfit is damaged." end
	return replaceDescription(player, description)
end

local function fireSavedPoses(player, session)
	fireSessionSnapshot(player, "SavedPosesUpdated", session.savedPoses)
end

local function sanitizePose(raw)
	if type(raw) ~= "table" then return nil end
	local result, count = {}, 0
	for jointName, transform in pairs(raw) do
		if count >= 32 then break end
		if type(jointName) == "string" and #jointName <= 40 and type(transform) == "table" then
			local rotation, position = transform.R, transform.P
			if type(rotation) == "table" and type(position) == "table" and #rotation >= 12 and #position >= 3 then
				local cleanR, valid = {}, true
				for i = 1, 12 do
					local value = tonumber(rotation[i])
					if not value or value ~= value or math.abs(value) > 10000 then valid = false break end
					cleanR[i] = value
				end
				if valid then
					result[jointName] = { R = cleanR, P = { math.clamp(tonumber(position[1]) or 0, -10, 10), math.clamp(tonumber(position[2]) or 0, -10, 10), math.clamp(tonumber(position[3]) or 0, -10, 10) } }
					count += 1
				end
			end
		end
	end
	return result
end

handlers.SavedPoseAction = function(player, request)
	if type(request) ~= "table" then return false, "invalidRequest" end
	local session = sessionFor(player)
	local action = request.Action
	if action == "Get" then return true, cloneValue(session.savedPoses) end
	local id = tostring(request.Id or "")
	local foundIndex = nil
	for index, pose in ipairs(session.savedPoses) do if tostring(pose.Id) == id then foundIndex = index break end end
	if action == "Create" then
		if #session.savedPoses >= 30 then return false, "full" end
		local joints = sanitizePose(request.Joints)
		if not joints then return false, "invalidPose" end
		table.insert(session.savedPoses, { Id = HttpService:GenerateGUID(false), Name = cleanLabel(player, request.Name, "New Pose"), RigType = request.RigType == "R6" and "R6" or "R15", Joints = joints, Created = os.time() })
	elseif not foundIndex then
		return false, "notFound"
	elseif action == "Delete" then
		table.remove(session.savedPoses, foundIndex)
	elseif action == "Rename" then
		session.savedPoses[foundIndex].Name = cleanLabel(player, request.Name, session.savedPoses[foundIndex].Name)
	elseif action == "Update" then
		local joints = sanitizePose(request.Joints)
		if not joints then return false, "invalidPose" end
		local pose = session.savedPoses[foundIndex]
		pose.RigType, pose.Joints, pose.Updated = request.RigType == "R6" and "R6" or "R15", joints, os.time()
	else
		return false, "unknownAction"
	end
	session.dirty = true
	fireSavedPoses(player, session)
	return true, cloneValue(session.savedPoses)
end

local function captureBodyPreset(player, name, id)
	local humanoid = getHumanoid(player)
	if not humanoid then return nil end
	local description = humanoid:GetAppliedDescription()
	local parts, scales = {}, {}
	for _, property in ipairs({ "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Face" }) do parts[property] = description[property] end
	for property in pairs(BODY_SCALE_LIMITS) do scales[property] = description[property] end
	description:Destroy()
	return { Id = id, Name = cleanLabel(player, name, "Body Preset"), Parts = parts, Scale = scales, Rig = humanoid.RigType.Name }
end

handlers.BodyPresetAction = function(player, request)
	if type(request) ~= "table" then return false, "invalidRequest" end
	local session, action = sessionFor(player), request.Action
	if action == "Get" then return true, cloneValue(session.bodyPresets) end
	local id = tostring(request.Id or "")
	if action == "Add" then
		local count = 0
		for _ in pairs(session.bodyPresets) do count += 1 end
		if count >= 30 then return false, "full" end
		id = HttpService:GenerateGUID(false)
		local preset = captureBodyPreset(player, request.Name, id)
		if not preset then return false, "noCharacter" end
		session.bodyPresets[id] = preset
	elseif not session.bodyPresets[id] then
		return false, "notFound"
	elseif action == "Update" then
		local current = session.bodyPresets[id]
		local preset = captureBodyPreset(player, current.Name, id)
		if not preset then return false, "noCharacter" end
		session.bodyPresets[id] = preset
	elseif action == "Rename" then
		session.bodyPresets[id].Name = cleanLabel(player, request.Name, session.bodyPresets[id].Name)
	elseif action == "Delete" then
		session.bodyPresets[id] = nil
	else
		return false, "unknownAction"
	end
	session.dirty = true
	return true, cloneValue(session.bodyPresets)
end

handlers.OnboardingAction = function(player, action, key)
	local session = sessionFor(player)
	if type(action) == "table" then key, action = action.Key or action.Name, action.Action end
	if action == "Get" then return cloneValue(session.onboarding) end
	if action == "MarkSeen" then
		session.onboarding[tostring(key or "Default")] = true
		session.dirty = true
		return true
	end
	return false
end

handlers.CreditsAction = function(player, action)
	if type(action) == "table" then action = action.Action end
	if action == "Get" then return true, cloneValue(sessionFor(player).credits) end
	return false, "unsupported"
end

local serverLikes = 0
local likedPlayers = {}
handlers.LikeAction = function(player, action)
	if type(action) == "table" then action = action.Action end
	if action == "GetLikes" then return serverLikes end
	if action == "IsLiked" then return likedPlayers[player.UserId] == true end
	if action == "ToggleLike" then
		likedPlayers[player.UserId] = not likedPlayers[player.UserId]
		serverLikes = math.max(0, serverLikes + (likedPlayers[player.UserId] and 1 or -1))
		return likedPlayers[player.UserId]
	end
	return false
end

handlers.CheckOutfitPrivacy = function()
	return true
end

handlers.AcknowledgeWarning = function()
	return nil
end

handlers.CommandAction = function()
	return false, "Commands are unavailable in safe mode."
end

handlers.DevPlusAction = function()
	return false, "Unavailable."
end

handlers.WearLatestOutfitResponse = function()
	return true
end

handlers.RemoveItemsBulk = function(player, items)
	if type(items) ~= "table" then return 0 end
	local removed = 0
	local success = mutateDescription(player, function(description, session)
		for index, item in pairs(items) do
			if removed >= 20 then break end
			if type(item) == "table" then
				local id = math.floor(tonumber(item.Id or item.AssetId) or 0)
				if id > 0 then
					local assetType = item.AssetTypeName or item.AssetType or resolveAssetType(id, nil)
					local ok = setAsset(description, session.baseline, id, assetType, true)
					if ok then removed += 1 end
				end
			elseif tonumber(item) then
				local id = math.floor(tonumber(item))
				local ok = setAsset(description, session.baseline, id, resolveAssetType(id, nil), true)
				if ok then removed += 1 end
			end
			if type(index) == "number" and index >= 50 then break end
		end
		return removed > 0, "No removable items."
	end)
	return success and removed or 0
end

handlers.BuildAction = function(player, action, payload)
	if type(action) == "table" then payload, action = action, action.Action end
	local canManage = player:GetAttribute("IsAdministrator") == true or (game.PrivateServerOwnerId ~= 0 and game.PrivateServerOwnerId == player.UserId)
	if action == "CanManage" then return canManage end
	if action == "List" then return { success = true, builds = cloneValue(sessionFor(player).builds) } end
	if not canManage then return { success = false, error = "notAuthorized" } end
	local session = sessionFor(player)
	if action == "Save" then
		local clean = sanitizeValue(payload)
		if type(clean) ~= "table" then return { success = false, error = "invalidBuild" } end
		local id = HttpService:GenerateGUID(false)
		clean.Id = id
		session.builds[id] = clean
		session.dirty = true
		return { success = true, build = cloneValue(clean) }
	elseif action == "Delete" then
		local id = tostring(type(payload) == "table" and payload.Id or payload)
		session.builds[id] = nil
		session.dirty = true
		return { success = true }
	elseif action == "Load" then
		local id = tostring(type(payload) == "table" and payload.Id or payload)
		return { success = session.builds[id] ~= nil, build = cloneValue(session.builds[id]) }
	end
	return { success = false, error = "unknownAction" }
end

local communityOutfits = {}
local communityByCode = {}
handlers.CommunityOutfitsAction = function(player, action, payload)
	if type(action) == "table" then payload, action = action, action.Action end
	action = tostring(action or "")
	if action == "GetTopicPreviews" then return true, {} end
	if action == "SearchOutfits" or action == "Get" then
		local result = {}
		for _, outfit in pairs(communityOutfits) do if #result < 30 then table.insert(result, cloneValue(outfit)) end end
		return true, result
	elseif action == "GetOutfit" then
		local id = tostring(type(payload) == "table" and (payload.Id or payload.OutfitId) or payload)
		return communityOutfits[id] ~= nil, cloneValue(communityOutfits[id])
	elseif action == "GetOutfitByCode" then
		local code = tostring(type(payload) == "table" and payload.Code or payload)
		local id = communityByCode[code]
		return id ~= nil, id and cloneValue(communityOutfits[id]) or nil
	elseif action == "PublishOutfit" then
		local id, code = HttpService:GenerateGUID(false), string.upper(string.sub(HttpService:GenerateGUID(false):gsub("%-", ""), 1, 8))
		local record = currentOutfitRecord(player, type(payload) == "table" and payload.Name or "Community Outfit", id)
		if not record then return false, "noCharacter" end
		record.CreatorId, record.CreatorName, record.Code, record.Likes = player.UserId, player.DisplayName, code, 0
		communityOutfits[id], communityByCode[code] = record, id
		return true, cloneValue(record)
	elseif action == "TryOnOutfit" then
		local id = tostring(type(payload) == "table" and (payload.Id or payload.OutfitId) or payload)
		local outfit = communityOutfits[id]
		if not outfit then return false, "notFound" end
		local description = deserializeDescription(outfit.HumanoidDescription)
		if not description then return false, "invalidOutfit" end
		return replaceDescription(player, description)
	elseif action == "IsFavorited" or action == "IsLiked" then
		return false
	elseif action == "AreOutfitsFavorited" then
		return true, {}
	elseif action == "Favorite" or action == "SetFavorited" or action == "ToggleLike" or action == "ReportOutfit" then
		return true
	end
	return true, {}
end

local function historyAction(player, action)
	local session = sessionFor(player)
	if session.busy then return end
	local from = action == "undo" and session.undo or action == "redo" and session.redo or nil
	local into = action == "undo" and session.redo or action == "redo" and session.undo or nil
	if not from or #from == 0 then fireHistory(player, session); return end
	local humanoid = getHumanoid(player)
	if not humanoid then return end
	session.busy = true
	local target = table.remove(from)
	local current = humanoid:GetAppliedDescription()
	local success = applyToHumanoid(humanoid, target)
	target:Destroy()
	if success then
		table.insert(into, current)
		while #into > 8 do local expired = table.remove(into, 1); expired:Destroy() end
		session.dirty = true
		descriptionUpdated(player)
	else
		current:Destroy()
	end
	session.busy = false
	fireHistory(player, session)
end

local function bindEvent(name, callback)
	local event = remoteEvent(name)
	if not event then return end
	event.OnServerEvent:Connect(function(player, ...)
		if requestAllowed(player, name) then
			local success, errorMessage = pcall(callback, player, ...)
			if not success then warn(string.format("[AvatarMaker] event %s failed: %s", name, tostring(errorMessage))) end
		end
	end)
end

bindEvent("HistoryAction", historyAction)

bindEvent("TrackRecentItem", function(player, item)
	local clean = sanitizeValue(item)
	if type(clean) ~= "table" then return end
	local id = tonumber(clean.Id or clean.AssetId)
	if not id or id < 1 then return end
	local session = sessionFor(player)
	for index = #session.recents, 1, -1 do
		local existing = session.recents[index]
		if tonumber(existing.Id or existing.AssetId) == id then table.remove(session.recents, index) end
	end
	table.insert(session.recents, 1, clean)
	while #session.recents > 50 do table.remove(session.recents) end
	session.dirty = true
end)

bindEvent("SetSkinTones", function(player, colors)
	if type(colors) ~= "table" then return end
	mutateDescription(player, function(description)
		local changed = false
		for key, property in pairs(BODY_COLORS) do
			local color = colors[key] or colors[property]
			if typeof(color) == "BrickColor" then color = color.Color end
			if typeof(color) == "Color3" then description[property], changed = color, true end
		end
		return changed, "No valid colors."
	end)
end)

bindEvent("SetLayeredClothingOrder", function(player, orders)
	if type(orders) ~= "table" then return end
	mutateDescription(player, function(description)
		local accessories, changed = description:GetAccessories(true), false
		for _, accessory in ipairs(accessories) do
			local order = tonumber(orders[tostring(accessory.AssetId)])
			if order then accessory.Order, changed = math.clamp(math.floor(order), 1, 20), true end
		end
		if changed then description:SetAccessories(accessories, true) end
		return changed, "No valid clothing order."
	end)
end)

bindEvent("SetMakeupOrder", function(player, orders)
	if type(orders) ~= "table" then return end
	mutateDescription(player, function(description)
		local changed = false
		for _, child in ipairs(description:GetChildren()) do
			if child:IsA("MakeupDescription") then
				local order = tonumber(orders[tostring(child.AssetId)])
				if order then child.Order, changed = math.clamp(math.floor(order), 1, 20), true end
			end
		end
		return changed, "No valid makeup order."
	end)
end)

bindEvent("PurchaseItem", function(player, itemType, id)
	id = math.floor(tonumber(id) or 0)
	if id < 1 then return end
	if tostring(itemType) == "Bundle" then MarketplaceService:PromptBundlePurchase(player, id)
	else MarketplaceService:PromptPurchase(player, id) end
end)

bindEvent("PromptBulkPurchase", function(player)
	local notify = remoteEvent("Notify")
	if notify then notify:FireClient(player, "Bulk checkout is unavailable; purchase items one at a time.") end
end)

bindEvent("PoseAnimatorAction", function(player, action, transforms)
	if type(transforms) ~= "table" or not player.Character then return end
	local count = 0
	for jointName, value in pairs(transforms) do
		if count >= 32 then break end
		if type(jointName) == "string" and typeof(value) == "CFrame" then
			local joint = player.Character:FindFirstChild(jointName, true)
			if joint and joint:IsA("Motor6D") then joint.C0 = value; count += 1 end
		end
	end
end)

for _, name in ipairs({ "ActivityAction", "AnalyticsEvent", "GroupJoinConfirmed" }) do
	bindEvent(name, function() end)
end

MarketplaceService.PromptPurchaseFinished:Connect(function(player, assetId, purchased)
	local event = remoteEvent("PurchaseFinished")
	if event then event:FireClient(player, assetId, "Asset", purchased == true) end
end)

pcall(function()
	MarketplaceService.PromptBundlePurchaseFinished:Connect(function(player, bundleId, purchased)
		local event = remoteEvent("PurchaseFinished")
		if event then event:FireClient(player, bundleId, "Bundle", purchased == true) end
	end)
end)

local persistence = nil
if not RunService:IsStudio() then
	pcall(function() persistence = DataStoreService:GetDataStore("AvatarMaker_Reconstructed_v1") end)
end

local function loadSession(player, session)
	if not persistence then return end
	local success, data = pcall(persistence.GetAsync, persistence, "u_" .. player.UserId)
	if not success or type(data) ~= "table" or sessions[player] ~= session then return end
	if type(data.settings) == "table" then mergeKnown(session.settings, data.settings, DEFAULT_SETTINGS) end
	for _, key in ipairs({ "favorites", "recents", "onboarding", "savedOutfits", "savedPoses", "bodyPresets", "builds", "credits" }) do
		if type(data[key]) == "table" then session[key] = data[key] end
	end
	session.savedOutfits.Outfits = type(session.savedOutfits.Outfits) == "table" and session.savedOutfits.Outfits or {}
	session.savedOutfits.Tags = type(session.savedOutfits.Tags) == "table" and session.savedOutfits.Tags or {}
	applyPlayerAttributes(player, session.settings)
	fireSessionSnapshot(player, "SettingsUpdated", session.settings)
	fireSavedOutfits(player, session)
	fireSavedPoses(player, session)
end

local function saveSession(player, session)
	if not persistence or not session or not session.dirty then return end
	local data = {
		settings = session.settings, favorites = session.favorites, recents = session.recents,
		onboarding = session.onboarding, savedOutfits = session.savedOutfits, savedPoses = session.savedPoses,
		bodyPresets = session.bodyPresets, builds = session.builds, credits = session.credits,
	}
	local clean = sanitizeValue(data, 0, { count = 0 })
	local success = pcall(persistence.SetAsync, persistence, "u_" .. player.UserId, clean)
	if success then session.dirty = false end
end

local function sanitizeCharacter(player, character)
	local function inspect(descendant)
		if descendant:IsA("BaseScript") and descendant.Name ~= "Animate" then
			descendant:Destroy()
		elseif descendant:IsA("Tool") then
			descendant:Destroy()
		end
	end
	for _, descendant in ipairs(character:GetDescendants()) do inspect(descendant) end
	character.DescendantAdded:Connect(inspect)
	task.defer(function()
		local humanoid = character:WaitForChild("Humanoid", 8)
		if not humanoid or character ~= player.Character then return end
		local profile = sessionFor(player).settings.Profile or {}
		humanoid.WalkSpeed = math.clamp(tonumber(profile.Speed) or 16, 0, 50)
		humanoid.JumpPower = math.clamp(tonumber(profile.JumpPower) or 50, 0, 100)
		refreshParentedDescription(player)
	end)
end

local function playerAdded(player)
	local session = sessionFor(player)
	session.joinedAt = os.clock()
	applyPlayerAttributes(player, session.settings)
	if player.Character then sanitizeCharacter(player, player.Character) end
	player.CharacterAdded:Connect(function(character) sanitizeCharacter(player, character) end)
	player.CharacterAppearanceLoaded:Connect(function(character)
		if character ~= player.Character then return end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then return end
		if session.baseline then session.baseline:Destroy() end
		session.baseline = humanoid:GetAppliedDescription()
		refreshParentedDescription(player)
	end)
	task.spawn(loadSession, player, session)
end

Players.PlayerAdded:Connect(playerAdded)
for _, player in ipairs(Players:GetPlayers()) do task.spawn(playerAdded, player) end

Players.PlayerRemoving:Connect(function(player)
	local session = sessions[player]
	saveSession(player, session)
	if session then
		if session.baseline then session.baseline:Destroy() end
		destroyDescriptions(session.undo)
		destroyDescriptions(session.redo)
	end
	sessions[player], rateWindows[player.UserId], likedPlayers[player.UserId] = nil, nil, nil
end)

game:BindToClose(function()
	for player, session in pairs(sessions) do saveSession(player, session) end
end)

print("[AvatarMaker] reconstructed low-overhead server ready")
