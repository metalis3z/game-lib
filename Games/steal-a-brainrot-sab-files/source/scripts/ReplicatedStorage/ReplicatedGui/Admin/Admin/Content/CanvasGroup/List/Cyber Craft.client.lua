local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local animalData             = require(ReplicatedStorage.Datas.Animals)
local raritiesData           = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton         = require(ReplicatedStorage.Classes.AnimatedButton)
local Net                    = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local GameData               = require(ReplicatedStorage.GameData)

local SetRecipeRemote = Net:RemoteFunction("CraftingMachineService/SetRecipe")
local RemoveRecipeRemote = Net:RemoteFunction("CraftingMachineService/RemoveRecipe")
local SpawnBrainrot = script.Parent.Craft.Frame

local mainIngredientsLabel = SpawnBrainrot.mainName
local mainResultLabel      = SpawnBrainrot.mainResult
local mainStockLabel = SpawnBrainrot.mainStock
local mainCostlabel = SpawnBrainrot.mainCost
local mainDurationLabel = SpawnBrainrot.mainDuration
local player          = Players.LocalPlayer
local blacklisted     = GameData.UnSpawnableBrainrots
local COOLDOWN_TIME   = 5
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID     = RobuxShopData.GetId("Cooldown")
local AUTHORIZED_USERS = { [0] = true, [1215597321] = true }


local function getGradientTag(animalName: string): string?
	local animal = animalData[animalName]
	if not animal then
		for _, v in pairs(animalData) do
			if v.DisplayName == animalName then
				animal = v
				break
			end
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

local function isBlacklisted(name: string): boolean
	if AUTHORIZED_USERS[player.UserId] then return false end
	if blacklisted[name] then return true end

	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end

	return false
end

local function checkGamepassOwnership(): boolean
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)
	return success and ownsPass
end

local function cleanText(text: string): string?
	local trimmed = text:match("^%s*(.-)%s*$")
	if trimmed == "" or trimmed == "Label" then return nil end
	return trimmed
end

local function parseIngredients(rawText: string, slotLabel: string): ({string}?, string?)
	local result = {}

	for entry in rawText:gmatch("[^,]+") do
		local trimmed = entry:match("^%s*(.-)%s*$")
		if trimmed ~= "" then
			if not animalData[trimmed] then
				return nil, ("%s - Invalid brainrot: %s"):format(slotLabel, trimmed)
			end
			if isBlacklisted(trimmed) then
				return nil, ("%s - Blacklisted brainrot: %s"):format(slotLabel, trimmed)
			end
			table.insert(result, trimmed)
		end
	end

	if #result == 0 then
		return nil, ("%s: Must have at least one ingredient!"):format(slotLabel)
	end

	if #result > 4 then
		return nil, ("%s: Maximum of 4 ingredients allowed!"):format(slotLabel)
	end

	return result, nil
end

local function formatDisplayName(name: string): string
	local tag = getGradientTag(name)
	if tag then
		return ("<%s>%s</%s>"):format(tag, name, tag)
	end
	return name
end


local nameList = {}

for _, v in pairs(animalData) do
	local restricted   = blacklisted[v.DisplayName]
	local isAuthorized = AUTHORIZED_USERS[player.UserId]

	if not restricted or isAuthorized then
		table.insert(nameList, v)
	end
end

table.sort(nameList, function(a, b)
	local weightA = raritiesData[a.Rarity] and raritiesData[a.Rarity].Weight or 0
	local weightB = raritiesData[b.Rarity] and raritiesData[b.Rarity].Weight or 0
	if weightA == weightB then
		return a.DisplayName < b.DisplayName
	end
	return weightA < weightB
end)


local lastExecution = 0

local function onSetRecipeClicked()
	local isPrivateServer = false
	local currentTime     = os.clock()
	local ownsGamepass    = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error(
				("Recipe setting is on cooldown! Wait %ds."):format(timeLeft)
			)
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local rawText1 = cleanText(mainIngredientsLabel.Text)
	if not rawText1 then
		NotificationController:Error("Must have at least one ingredient!")
		return
	end

	local recipe, recipeErr = parseIngredients(rawText1, "Recipe")
	if not recipe then
		NotificationController:Error(recipeErr)
		return
	end

	local output = cleanText(mainResultLabel.Text)
	if not output then
		NotificationController:Error("Must have a result!")
		return
	end
	if isBlacklisted(output) then
		NotificationController:Error("Blacklisted result: " .. output)
		return
	end

	local animalEntry = animalData[output]
	local rarity      = animalEntry and animalEntry.Rarity or "Legendary"
	local cost = tonumber(mainCostlabel.Text)
	local duration = tonumber(mainDurationLabel.Text)
	
	local success, message = SetRecipeRemote:InvokeServer(output, recipe, rarity, tonumber(mainStockLabel.Text), cost, duration )

	if success then
		lastExecution = currentTime

		local valentineData = raritiesData["Valentine"]
		local valHex = (valentineData and valentineData.Color)
			and valentineData.Color:ToHex()
			or "ff00ff"
	else
		NotificationController:Error(message or "An unknown error occurred.")
	end
end
local function onRemoveRecipeClicked()
	local output = cleanText(mainResultLabel.Text)
	if not output then
		NotificationController:Error("Select a result brainrot to remove!")
		return
	end

	if not animalData[output] then
		NotificationController:Error("Invalid brainrot: " .. output)
		return
	end

	local animalEntry = animalData[output]
	local rarity      = animalEntry and animalEntry.Rarity or "Legendary"

	local success, message = RemoveRecipeRemote:InvokeServer(output, rarity)

	if not success then
		NotificationController:Error(message or "An unknown error occurred.")
	end
end


local SetButton = AnimatedButton.new(SpawnBrainrot.Set)
SetButton:Animate()
SetButton.OnActivated:Connect(onSetRecipeClicked)
local RemoveButton = AnimatedButton.new(SpawnBrainrot.UnSet)
RemoveButton:Animate()
RemoveButton.OnActivated:Connect(onRemoveRecipeClicked)

local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_SetRecipe", SpawnBrainrot.Set, onSetRecipeClicked)
kb:RegisterButton(script.Name .. "_RemoveRecipe", SpawnBrainrot.UnSet, onRemoveRecipeClicked)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()


SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		mainIngredientsLabel.Text = selectedName
	end, "multiple", mainIngredientsLabel.Text, nil, true)
end)

SpawnBrainrot.ResultText.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if type(selectedName) == "table" then
			mainResultLabel.Text = selectedName.Name or selectedName.DisplayName or "Unknown"
		else
			mainResultLabel.Text = tostring(selectedName)
		end
	end)
end)