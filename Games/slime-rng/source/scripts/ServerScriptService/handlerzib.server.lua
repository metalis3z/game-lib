local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataService = require(ReplicatedStorage.Packages.DataService)
local DataTemplate = require(ReplicatedStorage.Source.Game.Items.DataTemplate)

-- Initialize Features folder services early (needed by CodeRewardCallbacks)
local featuresFolder = ServerScriptService:FindFirstChild("Features")
if featuresFolder then
	-- Initialize NotificationServiceServer
	local notificationsFolder = featuresFolder:FindFirstChild("Notifications")
	if notificationsFolder then
		local notificationServerModule = notificationsFolder:FindFirstChild("NotificationServiceServer")
		if notificationServerModule and notificationServerModule:IsA("ModuleScript") then
			local ok, notificationService = pcall(require, notificationServerModule)
			if ok and type(notificationService) == "table" and type(notificationService.init) == "function" then
				local initOk, err = pcall(function() notificationService:init() end)
				if initOk then
					print("[Server] Initialized service: NotificationServiceServer (PRIORITY)")
				else
					warn("[Server] Failed to init NotificationServiceServer:", err)
				end
			else
				warn("[Server] Failed to require NotificationServiceServer:", notificationService)
			end
		end
	end

	-- Initialize BoostServiceServer
	local boostsFolder = featuresFolder:FindFirstChild("Boosts")
	if boostsFolder then
		local boostServerModule = boostsFolder:FindFirstChild("BoostServiceServer")
		if boostServerModule and boostServerModule:IsA("ModuleScript") then
			local ok, boostService = pcall(require, boostServerModule)
			if ok and type(boostService) == "table" and type(boostService.init) == "function" then
				local initOk, err = pcall(function() boostService:init() end)
				if initOk then
					print("[Server] Initialized service: BoostServiceServer (PRIORITY)")
				else
					warn("[Server] Failed to init BoostServiceServer:", err)
				end
			else
				warn("[Server] Failed to require BoostServiceServer:", boostService)
			end
		end
	end

	-- Initialize InventoryServiceServer
	local inventoryFolder = featuresFolder:FindFirstChild("Inventory")
	if inventoryFolder then
		local inventoryServerModule = inventoryFolder:FindFirstChild("InventoryServiceServer")
		if inventoryServerModule and inventoryServerModule:IsA("ModuleScript") then
			local ok, inventoryService = pcall(require, inventoryServerModule)
			if ok and type(inventoryService) == "table" and type(inventoryService.init) == "function" then
				local initOk, err = pcall(function() inventoryService:init() end)
				if initOk then
					print("[Server] Initialized service: InventoryServiceServer (PRIORITY)")
				else
					warn("[Server] Failed to init InventoryServiceServer:", err)
				end
			else
				warn("[Server] Failed to require InventoryServiceServer:", inventoryService)
			end
		end
	end
end

DataService.server:init({
	profileStoreIndex = "PlayerData",
	template          = DataTemplate,
})

local remoteFunc = ReplicatedStorage.Packages._Index
["leifstout_networker@0.2.1"].networker
	:FindFirstChild("_remotes")
	:FindFirstChild("DataService")
	:FindFirstChild("RemoteFunction")

if remoteFunc then
	print("[Patch] Found RemoteFunction at:", remoteFunc:GetFullName())
	remoteFunc.OnServerInvoke = function(player: Player, method: string, ...)
		print("[Patch] INVOKED - method:", method, "player:", player.Name)
		local data = DataService.server:waitForData(player)
		if not data then
			warn("[Patch] No data for", player.Name)
			return nil
		end
		if method == "get" then
			local path = ...
			return data:get(path)
		end
		warn("[Patch] Unknown method:", method)
		return nil
	end
	print("[Patch] OnServerInvoke set successfully on:", remoteFunc:GetFullName())
else
	warn("[Patch] RemoteFunction not found in _remotes!")
	local nr = ReplicatedStorage.Packages._Index["leifstout_networker@0.2.1"].networker
	print("[Patch] networker children:")
	for _, c in ipairs(nr:GetChildren()) do
		print("  -", c.Name, c.ClassName)
		for _, cc in ipairs(c:GetChildren()) do
			print("    -", cc.Name, cc.ClassName)
			for _, ccc in ipairs(cc:GetChildren()) do
				print("      -", ccc.Name, ccc.ClassName)
			end
		end
	end
end

local Services = ServerScriptService:FindFirstChild("Services")

if Services then
	local relayModule = Services:FindFirstChild("DataServiceRelay", true)
	if relayModule and relayModule:IsA("ModuleScript") then
		local ok, relay = pcall(require, relayModule)
		if ok and type(relay) == "table" and type(relay.init) == "function" then
			local initOk, err = pcall(function() relay:init() end)
			if initOk then
				print("[Server] Initialized service: DataServiceRelay (PRIORITY)")
			else
				warn("[Server] Failed to init DataServiceRelay:", err)
			end
		else
			warn("[Server] Failed to require DataServiceRelay:", relay)
		end
	else
		warn("[Server] DataServiceRelay not found in Services — live coin updates WILL NOT WORK")
	end

	for _, module in ipairs(Services:GetDescendants()) do
		if module:IsA("ModuleScript") and module.Name ~= "DataServiceRelay" and module.Name ~= "NotificationServiceServer" then
			local ok, service = pcall(require, module)
			if ok and type(service) == "table" and type(service.init) == "function" then
				local initOk, err = pcall(function()
					service:init()
				end)
				if not initOk then
					warn("[Server] Failed to init service", module.Name, ":", err)
				else
					print("[Server] Initialized service:", module.Name)
				end
			elseif not ok then
				warn("[Server] Failed to require module", module.Name, ":", service)
			end
		end
	end
else
	warn("[Server] No 'Services' folder found in ServerScriptService.")
end