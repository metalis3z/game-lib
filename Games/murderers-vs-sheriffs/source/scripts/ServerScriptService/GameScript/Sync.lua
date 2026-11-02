local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BaseSync = require(ReplicatedStorage.Database.Sync)
local Sync = table.clone(BaseSync)

local activeEventManagerOk, ActiveEventManager = pcall(require, "./DataModule/ActiveEventManager")
if not activeEventManagerOk then
	warn("[GameScript.Sync] ActiveEventManager failed to load; event Sync merge skipped: " .. tostring(ActiveEventManager))
	ActiveEventManager = nil
end

local function mergeIntoSync(syncModuleName, data)
	if type(data) ~= "table" then
		return
	end

	if type(Sync[syncModuleName]) ~= "table" then
		warn(("[GameScript.Sync] Creating missing Sync table for event module %s"):format(tostring(syncModuleName)))
		Sync[syncModuleName] = {}
	end

	for itemName, itemData in pairs(data) do
		Sync[syncModuleName][itemName] = itemData
	end
end

if ActiveEventManager and ActiveEventManager:IsEventActive() then
	local activeEventInfo = ActiveEventManager:GetActiveEventInfo()
	local eventStartInfo = activeEventInfo and activeEventInfo.EventStartInfo

	if type(eventStartInfo) == "table" then
		mergeIntoSync("NewShop", eventStartInfo.ShopData)

		for syncModuleName, syncModuleData in pairs(eventStartInfo.Items or {}) do
			mergeIntoSync(syncModuleName, syncModuleData)
		end
	else
		warn("[GameScript.Sync] Active event has no EventStartInfo; skipped event Sync merge.")
	end
end

Sync.Weapons = Sync.Item
Sync.Data = Sync

return Sync
