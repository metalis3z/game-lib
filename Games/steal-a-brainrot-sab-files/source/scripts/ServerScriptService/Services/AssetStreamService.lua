local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local RequestRemoteEvent = Net:RemoteEvent("AssetStreamService/Request")
local AckRemoteEvent = Net:RemoteEvent("AssetStreamService/Ack")

local AssetStreamService = {}

local ASSET_STORAGE_FOLDER_NAME = "__AssetLibrary"
local PLAYER_GUI_CONTAINER_NAME = "__AssetStream"

local STALE_COPY_SECONDS = 8

local playerSentAssets = {}

local assetStorage = nil

local function initializeAssetStorage()
	assetStorage = ServerStorage:FindFirstChild(ASSET_STORAGE_FOLDER_NAME)
	if not assetStorage then
		assetStorage = Instance.new("Folder")
		assetStorage.Name = ASSET_STORAGE_FOLDER_NAME
		assetStorage.Parent = ServerStorage
		warn("[AssetStreamService] Created asset storage folder in ServerStorage")
	end
end

local function getPlayerContainer(player)
	local playerGui = player:FindFirstChild("PlayerGui")
	if not playerGui then
		return nil
	end

	local container = playerGui:FindFirstChild(PLAYER_GUI_CONTAINER_NAME)
	if not container then
		container = Instance.new("ScreenGui")
		container.Name = PLAYER_GUI_CONTAINER_NAME
		container.ResetOnSpawn = false
		container.IgnoreGuiInset = true
		container.Enabled = false
		container.Parent = playerGui
	end

	return container
end

local function streamAssetToPlayer(player, category, key)
	if not player.Parent then
		return
	end

	if playerSentAssets[player]
		and playerSentAssets[player][category]
		and playerSentAssets[player][category][key] then
		return
	end

	local categoryFolder = assetStorage:FindFirstChild(category)
	if not categoryFolder then
		warn(string.format("[AssetStreamService] Category '%s' not found", category))
		return
	end

	local asset
	if key:find("\1") then
		local sep = key:find("\1")
		local traitName = key:sub(1, sep - 1)
		local animalName = key:sub(sep + 1)
		local traitFolder = categoryFolder:FindFirstChild(traitName)
		asset = traitFolder and traitFolder:FindFirstChild(animalName)
	else
		asset = categoryFolder:FindFirstChild(key)
	end

	if not asset then
		warn(string.format("[AssetStreamService] Asset '%s/%s' not found", category, key))
		return
	end

	local container = getPlayerContainer(player)
	if not container then
		warn(string.format("[AssetStreamService] Could not get container for player %s", player.Name))
		return
	end

	local existing
	for _, child in ipairs(container:GetChildren()) do
		if child:GetAttribute("__cat") == category and child:GetAttribute("__key") == key then
			existing = child
			break
		end
	end
	if existing then
		if os.clock() - (existing:GetAttribute("__sentAt") or 0) < STALE_COPY_SECONDS then
			return
		end
		existing:Destroy()
	end

	local success, clonedAsset = pcall(function()
		return asset:Clone()
	end)

	if not success then
		warn(string.format("[AssetStreamService] Failed to clone asset '%s/%s': %s", category, key, tostring(clonedAsset)))
		return
	end

	clonedAsset:SetAttribute("__cat", category)
	clonedAsset:SetAttribute("__key", key)
	clonedAsset:SetAttribute("__sentAt", os.clock())

	local descendants = clonedAsset:GetDescendants()
	if #descendants > 0 then
		clonedAsset:SetAttribute("__count", #descendants)
	end

	clonedAsset.Parent = container
end

local function onAssetRequested(player, category, keys)
	if type(category) ~= "string" then
		warn("[AssetStreamService] Invalid category type from " .. player.Name)
		return
	end

	if type(keys) ~= "table" then
		warn("[AssetStreamService] Invalid keys type from " .. player.Name)
		return
	end

	for _, key in ipairs(keys) do
		if type(key) == "string" then
			task.spawn(streamAssetToPlayer, player, category, key)
		end
	end
end

local function onAssetAcknowledged(player, category, keys)
	if type(category) ~= "string" or type(keys) ~= "table" then
		return
	end

	local container = player:FindFirstChild("PlayerGui")
		and player.PlayerGui:FindFirstChild(PLAYER_GUI_CONTAINER_NAME)

	for _, key in ipairs(keys) do
		if type(key) == "string" then
			if not playerSentAssets[player] then
				playerSentAssets[player] = {}
			end
			if not playerSentAssets[player][category] then
				playerSentAssets[player][category] = {}
			end
			playerSentAssets[player][category][key] = true

			if container then
				for _, child in container:GetChildren() do
					if child:GetAttribute("__cat") == category and child:GetAttribute("__key") == key then
						child:Destroy()
						break
					end
				end
			end
		end
	end
end

local function onPlayerRemoving(player)
	playerSentAssets[player] = nil
end

function AssetStreamService.RegisterAsset(category, key, asset)
	if not assetStorage then
		warn("[AssetStreamService] Asset storage not initialized")
		return false
	end

	if type(category) ~= "string" or type(key) ~= "string" then
		warn("[AssetStreamService] Invalid category or key")
		return false
	end

	if not asset or not asset:IsA("Instance") then
		warn("[AssetStreamService] Invalid asset instance")
		return false
	end

	local categoryFolder = assetStorage:FindFirstChild(category)
	if not categoryFolder then
		categoryFolder = Instance.new("Folder")
		categoryFolder.Name = category
		categoryFolder.Parent = assetStorage
	end

	local targetFolder = categoryFolder
	local assetName = key

	if key:find("\1") then
		local parts = key:split("\1")
		assetName = parts[2]
		local subFolder = categoryFolder:FindFirstChild(parts[1])
		if not subFolder then
			subFolder = Instance.new("Folder")
			subFolder.Name = parts[1]
			subFolder.Parent = categoryFolder
		end
		targetFolder = subFolder
	end

	local existing = targetFolder:FindFirstChild(assetName)
	if existing then
		existing:Destroy()
	end

	local storedAsset = asset:Clone()
	storedAsset.Name = assetName
	storedAsset.Parent = targetFolder

	return true
end

function AssetStreamService.RegisterAssets(category, assetsTable)
	for key, asset in pairs(assetsTable) do
		AssetStreamService.RegisterAsset(category, key, asset)
	end
end

function AssetStreamService.LoadFromFolder(folder)
	for _, categoryFolder in folder:GetChildren() do
		if categoryFolder:IsA("Folder") then
			for _, asset in categoryFolder:GetChildren() do
				if asset:IsA("Folder") then
					for _, subAsset in asset:GetChildren() do
						local subKey = asset.Name .. "\1" .. subAsset.Name
						AssetStreamService.RegisterAsset(categoryFolder.Name, subKey, subAsset)
					end
				else
					AssetStreamService.RegisterAsset(categoryFolder.Name, asset.Name, asset)
				end
			end
		end
	end
end

function AssetStreamService:Start()
	initializeAssetStorage()

	RequestRemoteEvent.OnServerEvent:Connect(onAssetRequested)
	AckRemoteEvent.OnServerEvent:Connect(onAssetAcknowledged)

	Players.PlayerRemoving:Connect(onPlayerRemoving)

end

return AssetStreamService