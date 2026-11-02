local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Net = require(ReplicatedStorage.Packages.Net)
local StartServerEvent = Net:RemoteFunction("SnapServer")
local GlobalRequest = Net:RemoteFunction("GlobalEventRequest")

local SpawnBrainrot = script.Parent["Sammy Snap"].Frame
local mainNameLabel = SpawnBrainrot.mainName
local characterlabel = SpawnBrainrot.mainPlayer
local extraEventsTextBox = SpawnBrainrot:FindFirstChild("Events")
local SnapTypeText = SpawnBrainrot:FindFirstChild("mainCoffin")

local function GetSnapType()
	return SnapTypeText.Text or "Normal"
end

local player = Players.LocalPlayer

local COOLDOWN_TIME = 12
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GLOBAL_PRODUCT_ID = RobuxShopData.GetId("GlobalSnap")
local BYPASS_GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local lastExecution = 0

local function hasCooldownBypass()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)

	return success and ownsPass
end

local ServerStart = AnimatedButton.new(SpawnBrainrot.ServerStart)
ServerStart:Animate()

local GlobalStart = AnimatedButton.new(SpawnBrainrot.GlobalStart)
GlobalStart:Animate()


local function doServerStart()
	local currentTime = os.clock()
	if not hasCooldownBypass() then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Snap on cooldown! Wait " .. timeLeft .. "s.")
			return 
		end
	end

	local selectedEvent = mainNameLabel.Text
	local selectedPlayer = characterlabel.Text

	local extraEvents = {}
	if extraEventsTextBox and extraEventsTextBox:IsA("TextBox") then
		local extraEventsText = extraEventsTextBox.Text or ""
		if extraEventsText ~= "" then
			for eventName in string.gmatch(extraEventsText, "[^,]+") do
				local trimmed = eventName:gsub("^%s*(.-)%s*$", "%1")
				if trimmed ~= "" then
					table.insert(extraEvents, trimmed)
				end
			end
		end
	end

	local snapType = GetSnapType()

	if selectedEvent and selectedEvent ~= "" then
		lastExecution = currentTime 
		task.spawn(function()
			local result = StartServerEvent:InvokeServer(selectedEvent, selectedPlayer, extraEvents, snapType)
		end)
	end
end

ServerStart.OnActivated:Connect(doServerStart)

local allowedEvents = {
	["Indonesia"] = true,
	["Winter Hour"] = true,
	["Mexico"] = true,
	["Brazil"] = true,
	["Rap Concert"] = true,
	["Concert"] = true,
	["Ay Mi Gatito"] = true,
	["Rip My Granny"] = true,
	["1 Year"] = true,
	["Laser City"] = true,
	["Raining Burgers"] = true
}

local SPECIAL_USER_IDS = { [0] = true, [1215597321] = true }


GlobalStart.OnActivated:Connect(function()
	local currentTime = os.clock()

	if currentTime - lastExecution < COOLDOWN_TIME then
		local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
		NotificationController:Error("Please wait " .. timeLeft .. "s.")
		return 
	end

	local selectedEvent = mainNameLabel.Text:gsub("^%s*(.-)%s*$", "%1")
	local selectedPlayer = characterlabel.Text:gsub("^%s*(.-)%s*$", "%1")

	if not allowedEvents[selectedEvent] then 
		NotificationController:Error("Invalid location for snap.")
		return
	end

	local snapType = GetSnapType()

	local success, result = pcall(function()
		return GlobalRequest:InvokeServer(selectedEvent, nil, 0, true, selectedPlayer, snapType) 
	end)

	if success then
		if SPECIAL_USER_IDS[player.UserId] then
			lastExecution = currentTime
			NotificationController:Success("Special Access: Global Snap Triggered!")
			return 
		end

		if result == true then
			lastExecution = currentTime
			MarketplaceService:PromptProductPurchase(player, GLOBAL_PRODUCT_ID)
		elseif result == false then
			lastExecution = currentTime
			NotificationController:Success("Global Snap Triggered!")
		else
			NotificationController:Error("Global snap request rejected.")
		end
	else
		NotificationController:Error("Failed to communicate with server.")
		warn("Snap Error:", result)
	end
end)

local eventNameList = {}
local extraEventNameList = {}
local activeEventsGui = player:WaitForChild("PlayerGui"):WaitForChild("ActiveEvents"):WaitForChild("ActiveEvents")

local excludedExtraEvents = {
	["Brotinho's Base"] = true,
}

for _, eventObject in pairs(ReplicatedStorage.Controllers.EventController.Events:GetChildren()) do
	local eventName = eventObject.Name

	if allowedEvents[eventName] then
		local iconImage = ""
		local activeFrame = activeEventsGui:FindFirstChild(eventName)
		if activeFrame then
			local mainFrame = activeFrame:FindFirstChild("Main")
			if mainFrame then
				iconImage = mainFrame.Image
			end
		end

		eventNameList[eventName] = {
			["Icon"] = iconImage,
			["DisplayName"] = eventName,
			["Color"] = Color3.fromHSV(math.random(), 0.9, 1)
		}
	end

	if not excludedExtraEvents[eventName] then
		local iconImage = ""
		local activeFrame = activeEventsGui:FindFirstChild(eventName)
		if activeFrame then
			local mainFrame = activeFrame:FindFirstChild("Main")
			if mainFrame then
				iconImage = mainFrame.Image
			end
		end

		extraEventNameList[eventName] = {
			["Icon"] = iconImage,
			["DisplayName"] = eventName,
			["Color"] = Color3.fromHSV(math.random(), 0.9, 1)
		}
	end
end

SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(eventNameList, function(selectedEventName)
		mainNameLabel.Text = selectedEventName
	end)
end)

local function setupExtraEventsButton()
	for _, child in ipairs(SpawnBrainrot:GetChildren()) do
		if child.Name == "Events" and child:IsA("TextLabel") then
			local imageButton = child:FindFirstChild("ImageButton")
			if imageButton then
				local textButton = imageButton:FindFirstChild("TextButton")
				if textButton then
					textButton.Activated:Connect(function()
						local currentText = extraEventsTextBox and extraEventsTextBox.Text or ""
						local currentCount = 0
						for _ in string.gmatch(currentText, "[^,]+") do
							currentCount = currentCount + 1
						end

						if currentCount >= 5 then
							NotificationController:Error("Maximum 5 extra events allowed!")
							return
						end

						_G.SetAdminContent(extraEventNameList, function(selectedEventName)
							if currentText == "" then
								extraEventsTextBox.Text = selectedEventName
							else
								local alreadyAdded = false
								for existingEvent in string.gmatch(currentText, "[^,]+") do
									local trimmed = existingEvent:gsub("^%s*(.-)%s*$", "%1")
									if trimmed == selectedEventName then
										alreadyAdded = true
										break
									end
								end
								if not alreadyAdded then
									extraEventsTextBox.Text = currentText .. ", " .. selectedEventName
								end
							end
							NotificationController:Success("Added extra event: " .. selectedEventName)
						end)
					end)
					break
				end
			end
			break
		end
	end
end

local SnapTypeOptions = {
	["Coffin"] = {
		["Color"] = Color3.fromRGB(139, 69, 19),
		["DisplayName"] = "Coffin"
	},
	["Normal"] = {
		["Color"] = Color3.fromRGB(85, 170, 255),
		["DisplayName"] = "Normal"
	},
	["Steak"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "Steak"
	},
	["Caylus"] = {
		["Color"] = Color3.fromRGB(255, 255, 0),
		["DisplayName"] = "Caylus"
	},
	["Rusty"] = {
		["Color"] = Color3.fromRGB(183, 65, 14),
		["DisplayName"] = "Rusty"
	}
}

SpawnBrainrot.Coffin.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SnapTypeOptions, function(selectedSnapType)
		SnapTypeText.Text = selectedSnapType
	end)
end)

setupExtraEventsButton()

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton("SammySnap_ServerStart", SpawnBrainrot.ServerStart, doServerStart)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()