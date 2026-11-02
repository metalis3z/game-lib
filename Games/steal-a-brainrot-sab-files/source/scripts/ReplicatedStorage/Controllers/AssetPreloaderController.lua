-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local AssetPreloaderController = {}

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local FOLDERS_TO_LOAD = {
	{ Parent = ReplicatedStorage, FolderName = "Animations", ClassName = "Animation" },
	{ Parent = ReplicatedStorage, FolderName = "Sounds",      ClassName = "Sound"     },
	{ Parent = Workspace,         FolderName = "Sounds",      ClassName = "Sound"     },
}

local ASSETS_PER_SECOND = 100

local function IsMobile()
	return not UserInputService.KeyboardEnabled
		or not UserInputService.MouseEnabled
		or UserInputService.TouchEnabled
end

local function GatherAssetsFromFolder(parentObject, folderName, className)
	local assets = {}

	if not parentObject then
		warn(string.format("[Preload] Invalid parent service specified for '%s'!", folderName))
		return assets
	end

	local folder = parentObject:WaitForChild(folderName, 10)

	if not folder then
		warn(string.format("[Preload] '%s' folder not found in %s after 10 seconds!", folderName, parentObject.Name))
		return assets
	end

	for _, object in ipairs(folder:GetDescendants()) do
		if object:IsA(className) then
			table.insert(assets, object)
		end
	end

	return assets
end

AssetPreloaderController.Load = function()
	if IsMobile() then
		print("IsMobile")
		return
	end

	task.spawn(function()
		local masterQueue = {}

		for _, config in ipairs(FOLDERS_TO_LOAD) do
			local assets = GatherAssetsFromFolder(config.Parent, config.FolderName, config.ClassName)
			for _, asset in ipairs(assets) do 
				table.insert(masterQueue, asset) 
			end
		end

		local totalAssets = #masterQueue

		if totalAssets == 0 then
			return
		end

		local assetsLoaded = 0
		local assetIndex = 1
		local assetBudget = 0

		while assetIndex <= totalAssets do
			local deltaTime = task.wait() 

			assetBudget = assetBudget + (ASSETS_PER_SECOND * deltaTime)

			local batch = {}
			while assetBudget >= 1 and assetIndex <= totalAssets do
				table.insert(batch, masterQueue[assetIndex])
				assetIndex = assetIndex + 1
				assetBudget = assetBudget - 1
			end

			if #batch > 0 then
				local success, result = pcall(function()
					ContentProvider:PreloadAsync(batch, function(assetId, status)
						assetsLoaded = assetsLoaded + 1
					end)
				end)

				if not success then
					warn("[Preload] An error occurred during PreloadAsync: " .. tostring(result))
				end
			end
		end
	end)
end

return AssetPreloaderController