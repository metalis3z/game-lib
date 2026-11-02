local REQUIRED_MODULES = {
	"Item",
	"Pets",
	"Effects",
	"Emotes",
	"Perks",
	"Radios",
	"Materials",
	"Toys",
	"Rarity",
	"Rarities",
	"ItemPacks",
	"Shop",
	"MysteryBox",
	"Maps",
	"Eggs",
	"EliteRewards",
	"Featured",
	"XboxFeatured",
	"Recipes",
	"SalvageRewards",
	"DevProducts",
	"Badge",
	"Codes",
	"Currencies",
	"NameTags",
	"SlotInfo",
	"GameModes",
	"Outfits",
	"Banned",
	"GamepassShop",
	"TimeRewards",
	"NewShop",
	"FollowRewards",
	"Summer2024Event",
}

local Sync = {}
local missingModules = {}
local failedModules = {}

local function safeRequire(name, fallback)
	local module = script:FindFirstChild(name)
	if not module or not module:IsA("ModuleScript") then
		missingModules[name] = true
		warn(("[Sync] Missing data module %s; using fallback table."):format(name))
		return fallback or {}
	end

	local ok, result = pcall(require, module)
	if ok and result ~= nil then
		return result
	end

	failedModules[name] = tostring(result)
	warn(("[Sync] Failed to require %s (%s); using fallback table."):format(module:GetFullName(), tostring(result)))
	return fallback or {}
end

for _, moduleName in ipairs(REQUIRED_MODULES) do
	Sync[moduleName] = safeRequire(moduleName, {})
end

-- Codex transfer: merge cool game weapon data overlay
local coolGameItemOverlay = safeRequire("Item_CoolGameTransfer", {})
if type(coolGameItemOverlay) == "table" then
	for itemId, itemData in pairs(coolGameItemOverlay) do
		if Sync.Item[itemId] == nil then
			Sync.Item[itemId] = itemData
		end
	end
end
Sync.Item_CoolGameTransfer = coolGameItemOverlay

Sync.Weapons = Sync.Item
Sync.Data = Sync

for _, module in ipairs(script:GetChildren()) do
	if module:IsA("ModuleScript") and Sync[module.Name] == nil then
		Sync[module.Name] = safeRequire(module.Name, {})
		warn("[Sync] Loaded extra unregistered data module: " .. module.Name)
	end
end

function Sync.GetLoadStatus()
	return {
		Missing = missingModules,
		Failed = failedModules,
	}
end

return Sync
