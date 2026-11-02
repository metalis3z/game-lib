local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Net = require(ReplicatedStorage.Packages.Net)

local Startallevents = Net:RemoteFunction("StartGlobalEvent")
local Stopallevents = Net:RemoteFunction("StopGlobalEvent")
local StartServerEvent = Net:RemoteFunction("StartServerEvent")
local StopServerEvent = Net:RemoteFunction("StopServerEvent")

local SpawnBrainrot = script.Parent.Events.Frame

local mainNameLabel = SpawnBrainrot.mainName
local mainDurationLabel = SpawnBrainrot.mainDuration
local delaylabel = SpawnBrainrot.mainDelay
local CustomEventIcons = {
	["Skip Fuse"] = "rbxassetid://107531914359472",
	["Skip Craft"] = "rbxassetid://94959630028141",
	["Refresh Craft"] = "rbxassetid://128168639073846",
	["1x1x1x1"] = "rbxassetid://109298418305415",
	["North Pole"] = "rbxassetid://136990856788823",
	["April Fools"] = "rbxassetid://88359483106258",
	["FatSammy"] = "rbxassetid://93511281721888",
	["TurkeyEvent"] = "rbxassetid://85734378378929"
}
local ServerStart = AnimatedButton.new(SpawnBrainrot.ServerStart)
ServerStart:Animate()
local GlobalStart = AnimatedButton.new(SpawnBrainrot.GlobalStart)
GlobalStart:Animate()
local lastExecution = 0
local COOLDOWN_TIME = 5
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local player = Players.LocalPlayer
local SPECIAL_USER_IDS = { [0] = true, [1215597321] = true }
local blacklist = require(game.ReplicatedStorage.GameData).adminevents 

local function isBlacklisted(eventName)
	for blacklistedName, _ in pairs(blacklist) do
		if string.lower(blacklistedName) == string.lower(eventName) then
			return true
		end
	end
	return false
end

local function checkGamepassOwnership()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)
	return success and ownsPass
end


local function doServerStart()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()
	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Events are on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return 
		end
	end

	local rawText = mainNameLabel.Text:gsub("^%s*(.-)%s*$", "%1")
	local selectedEvent = rawText
	local duration = tonumber(mainDurationLabel.Text) or nil
	local delay = tonumber(delaylabel.Text) or 0
    if isBlacklisted(selectedEvent) then
		NotificationController:Error("You cannot run this event.")
		return
	end
	
	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			if string.lower(selectedEvent) == "all" then
				lastExecution = currentTime
				return Startallevents:InvokeServer(duration, delay)
			else
				lastExecution = currentTime
				return StartServerEvent:InvokeServer(selectedEvent, duration, delay)		
			end
		end)

		if not success then
			warn("Failed to start server event:", result)
		end
	end
end

ServerStart.OnActivated:Connect(doServerStart)

local ServerStop = AnimatedButton.new(SpawnBrainrot.ServerStop)
ServerStop:Animate()

local function DoServerStop()
	local rawText = mainNameLabel.Text:gsub("^%s*(.-)%s*$", "%1")
	local selectedEvent = rawText

	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			if string.lower(selectedEvent) == "all" then
				return Stopallevents:InvokeServer()
			else
				return StopServerEvent:InvokeServer(selectedEvent)
			end
		end)

		if not success then
			warn("Failed to stop server event:", result)
		end
	end
end

ServerStop.OnActivated:Connect(DoServerStop)

local GLOBAL_EVENT_PRODUCT_ID = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData).GetId("GlobalEvent")


GlobalStart.OnActivated:Connect(function()
	local currentTime = os.clock()

	if currentTime - lastExecution < COOLDOWN_TIME and not SPECIAL_USER_IDS[player.UserId] then
		local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
		NotificationController:Error("Please wait " .. timeLeft .. "s.")
		return 
	end

	local selectedEvent = mainNameLabel.Text:gsub("^%s*(.-)%s*$", "%1")
	local duration = tonumber(mainDurationLabel.Text) or 150 
	local delay = tonumber(delaylabel.Text) or 0
	if isBlacklisted(selectedEvent) then
		NotificationController:Error("You cannot run this event.")
		return
	end

	if selectedEvent == "" or selectedEvent == "all" then
		NotificationController:Error("Please select a specific event for Global broadcast.")
		return
	end

	local GlobalEventRemote = Net:RemoteFunction("GlobalEventRequest")

	if not GlobalEventRemote then
		warn("[DEBUG] CRITICAL: GlobalEventRequest Remote NOT found!")
		NotificationController:Error("Service not ready.")
		return
	end

	local success, status = pcall(function()
		return GlobalEventRemote:InvokeServer(selectedEvent, duration, delay, false, nil)
	end)

	if not success then
		warn("[DEBUG] InvokeServer failed: " .. tostring(status))
		NotificationController:Error("Connection failed.")
		return
	end


	if SPECIAL_USER_IDS[player.UserId] then
		NotificationController:Success("Special Access: Global Event Started Free!")
		lastExecution = currentTime
		return 
	end

	if status == true then
		MarketplaceService:PromptProductPurchase(player, GLOBAL_EVENT_PRODUCT_ID)
	elseif status == false then
		NotificationController:Success("Global Event Processed!")
	else
		NotificationController:Error("Failed to initialize global event.")
	end
end)

local eventNameList = {}
local v23 = player:WaitForChild("PlayerGui"):WaitForChild("ActiveEvents"):WaitForChild("ActiveEvents")

for _, v24 in pairs(ReplicatedStorage.Controllers.EventController.Events:GetChildren()) do
    local v25 = v24.Name

	if isBlacklisted(v25) or v25 == "Phase 5: Sammy Snap" or v25 == "Lucky Base" or v25 == "W or L" or v25 == "Brotinho's Base" or string.find(v25, "Server Luck") or string.find(v25, "Lucky Block") then
        continue
    end

	local v26 = ""

	if CustomEventIcons[v25] then
		v26 = CustomEventIcons[v25]
	else
		local v27 = v23:FindFirstChild(v25)
		if v27 then
			local v28 = v27:FindFirstChild("Main")
			if v28 then
				v26 = v28.Image
			end
		end
	end

	eventNameList[v25] = {
		["Icon"] = v26,
		["DisplayName"] = v25,
		["Color"] = Color3.fromHSV(math.random(), 0.9, 1)
	}
end

SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(eventNameList, function(selectedEventName)
		mainNameLabel.Text = selectedEventName
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton("Events_ServerStart", SpawnBrainrot.ServerStart, doServerStart)
kb:RegisterButton("Events_GlobalStop", SpawnBrainrot.ServerStop, DoServerStop)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
