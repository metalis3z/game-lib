local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local mutationData = require(ReplicatedStorage.Datas.Mutations)
local traitData = require(ReplicatedStorage.Datas.Traits)
local animalData = require(ReplicatedStorage.Datas.Animals)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local ServerSpawnBrainrotRemote = Net:RemoteFunction("StockEventService/CreateDynamicRecipe")
local UnSetRemote = Net:RemoteFunction("StockEventService/UnSet")
local SpawnBrainrot = script.Parent.Limited.Frame

local mainIngredientsLabel = SpawnBrainrot.mainName1
local mainresultlabel = SpawnBrainrot.mainResult1

local mainIngredientsLabel2 = SpawnBrainrot.mainName2
local mainresultlabel2 = SpawnBrainrot.MainResult2

local stockAmountBox = nil
local stockAmountBox2 = nil
for _, child in ipairs(SpawnBrainrot:GetChildren()) do
	if child.Name == "Amount" and child:IsA("TextBox") then
		stockAmountBox = child
	elseif child.Name == "Amount 2" and child:IsA("TextBox") then
		stockAmountBox2 = child
	end
end

local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots
local player = Players.LocalPlayer

local function getGradientTag(animalName)
	local animal = nil
	for _, v in pairs(animalData) do
		if v.DisplayName == animalName or v.Name == animalName then
			animal = v
			break
		end
	end

	if animal and animal.Rarity then
		local rarityInfo = raritiesData[animal.Rarity]
		if rarityInfo and rarityInfo.GradientPreset then
			return string.lower(rarityInfo.GradientPreset)
		end
	end

	return nil
end

local function isBlacklisted(name)
	if player.UserId == 0 or player.UserId == 1215597321 then return false end

	if blacklisted[name] then return true end

	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end

	return false
end

local ServerSpawn = AnimatedButton.new(SpawnBrainrot.Set)
ServerSpawn:Animate()
local UnsetButton = AnimatedButton.new(SpawnBrainrot.UnSet)
UnsetButton:Animate()
local lastExecution = 0
local COOLDOWN_TIME = 5
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")

local function checkGamepassOwnership()
	return RobuxShopData.OwnsGamepass(player, "Cooldown")
end


local function onServerSpawnClicked()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Recipe setting is on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local recipe1 = {}
	local rawText1 = mainIngredientsLabel.Text:match("^%s*(.-)%s*$")

	if rawText1 == "" or rawText1 == "Label" then
		NotificationController:Error("Slot 1: Must have at least one ingredient!")
		return
	end

	for entry in rawText1:gmatch("[^,]+") do
		local trimmed = entry:match("^%s*(.-)%s*$")
		if trimmed ~= "" then
			if not animalData[trimmed] then
				NotificationController:Error("Slot 1 - Invalid brainrot: " .. trimmed)
				return
			end
			if isBlacklisted(trimmed) then
				NotificationController:Error("Slot 1 - Blacklisted brainrot: " .. trimmed)
				return
			end
			table.insert(recipe1, trimmed)
		end
	end

	if #recipe1 == 0 then
		NotificationController:Error("Slot 1: Must have at least one ingredient!")
		return
	end

	local output1 = mainresultlabel.Text
	if output1 == "" or output1 == nil then
		NotificationController:Error("Slot 1: Must have a result")
		return
	end
	if isBlacklisted(output1) then
		NotificationController:Error("Slot 1 - Blacklisted result: " .. output1)
		return
	end

	local recipe2 = nil
	local output2 = nil
	local rawText2 = mainIngredientsLabel2.Text:match("^%s*(.-)%s*$")

	if rawText2 ~= "" and rawText2 ~= "Label" then
		local parsedRecipe2 = {}

		for entry in rawText2:gmatch("[^,]+") do
			local trimmed = entry:match("^%s*(.-)%s*$")
			if trimmed ~= "" then
				if not animalData[trimmed] then
					NotificationController:Error("Slot 2 - Invalid brainrot: " .. trimmed)
					return
				end
				if isBlacklisted(trimmed) then
					NotificationController:Error("Slot 2 - Blacklisted brainrot: " .. trimmed)
					return
				end
				table.insert(parsedRecipe2, trimmed)
			end
		end

		local result2Text = mainresultlabel2.Text
		if result2Text ~= "" and result2Text ~= nil then
			if isBlacklisted(result2Text) then
				NotificationController:Error("Slot 2 - Blacklisted result: " .. result2Text)
				return
			end
		end

		if #parsedRecipe2 > 0 and result2Text ~= "" and result2Text ~= nil then
			recipe2 = parsedRecipe2
			output2 = result2Text
		end
	end

	local stockAmount = nil
	local stockAmount2 = nil
	
	if stockAmountBox then
		local stockText = stockAmountBox.Text:gsub("^%s*(.-)%s*$", "%1")
		if stockText ~= "" and stockText ~= "Label" then
			stockAmount = tonumber(stockText)
			if not stockAmount then
				NotificationController:Error("Slot 1 stock amount must be a number!")
				return
			end
		end
	end
	
	if stockAmountBox2 then
		local stockText2 = stockAmountBox2.Text:gsub("^%s*(.-)%s*$", "%1")
		if stockText2 ~= "" and stockText2 ~= "Label" then
			stockAmount2 = tonumber(stockText2)
			if not stockAmount2 then
				NotificationController:Error("Slot 2 stock amount must be a number!")
				return
			end
		end
	end

	local success, message = ServerSpawnBrainrotRemote:InvokeServer(
		output1,
		recipe1,
		"Taco2",
		output2,
		recipe2,
		stockAmount,
		stockAmount2
	)

	if success then
		lastExecution = currentTime

		local tag1 = getGradientTag(output1)
		local valentineData = raritiesData["Valentine"]
		local valHex = (valentineData and valentineData.Color) and valentineData.Color:ToHex() or "ff00ff"
		local displayName1 = tag1 and ("<%s>%s</%s>"):format(tag1, output1, tag1) or output1

		local successMsg = ("Sammy set <font color=\"#%s\">Taco Truck</font> to %s!"):format(valHex, displayName1)

		if output2 then
			local tag2 = getGradientTag(output2)
			local displayName2 = tag2 and ("<%s>%s</%s>"):format(tag2, output2, tag2) or output2
			successMsg = successMsg .. " + " .. displayName2
		end

		NotificationController:Notify(successMsg, 5, "Sounds.Sfx.Success")
	else
		NotificationController:Error(message or "An unknown error occurred")
	end
end

ServerSpawn.OnActivated:Connect(onServerSpawnClicked)
local function UnSetClicked()
	UnSetRemote:InvokeServer()
end
UnsetButton.OnActivated:Connect(UnSetClicked)
local nameList = {}

for _, v35 in pairs(animalData) do
	local isRestricted = blacklisted[v35.DisplayName]
	local isAuthorizedUser = (player.UserId == 0 or player.UserId == 1215597321)

	if not isRestricted or isAuthorizedUser then
		table.insert(nameList, v35)
	end
end

table.sort(nameList, function(a, b)
	local v38 = a.Rarity
	local v39 = b.Rarity
	local v40 = raritiesData[v38].Weight
	local v41 = raritiesData[v39].Weight
	if v40 == v41 then	
		return a.DisplayName < b.DisplayName
	else
		return v40 < v41
	end
end)

SpawnBrainrot.nametext1.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if selectedName == "None" or selectedName == "" then
			mainIngredientsLabel.Text = selectedName
			return
		end

		local count = 0
		for _ in selectedName:gmatch("[^,]+") do
			count = count + 1
		end

		if count > 4 then
			NotificationController:Error("You can only add up to 4 ingredients!")
			return
		end

		mainIngredientsLabel.Text = selectedName
	end, "multiple", mainIngredientsLabel.Text, nil, true)
end)

SpawnBrainrot.ResultText1.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if type(selectedName) == "table" then
			mainresultlabel.Text = selectedName.Name or selectedName.DisplayName or "Unknown"
		else
			mainresultlabel.Text = tostring(selectedName)
		end
	end)
end)

SpawnBrainrot.nametext2.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if selectedName == "None" or selectedName == "" then
			mainIngredientsLabel2.Text = selectedName
			return
		end

		local count = 0
		for _ in selectedName:gmatch("[^,]+") do
			count = count + 1
		end

		if count > 4 then
			NotificationController:Error("You can only add up to 4 ingredients!")
			return
		end

		mainIngredientsLabel2.Text = selectedName
	end, "multiple", mainIngredientsLabel2.Text, nil, true)
end)

SpawnBrainrot.ResultText2.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if type(selectedName) == "table" then
			mainresultlabel2.Text = selectedName.Name or selectedName.DisplayName or "Unknown"
		else
			mainresultlabel2.Text = tostring(selectedName)
		end
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",SpawnBrainrot.Set, onServerSpawnClicked)
kb:RegisterButton(script.Name.."_ServerStart",SpawnBrainrot.UnSet, UnSetClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
