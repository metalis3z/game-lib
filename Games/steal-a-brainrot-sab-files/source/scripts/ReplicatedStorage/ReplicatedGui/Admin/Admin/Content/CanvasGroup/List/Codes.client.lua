local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local animalData             = require(ReplicatedStorage.Datas.Animals)
local mutationData           = require(ReplicatedStorage.Datas.Mutations)
local raritiesData           = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton         = require(ReplicatedStorage.Classes.AnimatedButton)
local Net                    = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local GameData               = require(ReplicatedStorage.GameData)

local CreateCodeRemote = Net:RemoteFunction("AdminService/CreateCode")
local DeleteCodeRemote = Net:RemoteFunction("AdminService/DeleteCode")

local CodesFrame = script.Parent.Code.Frame

local codeNameLabel      = CodesFrame.CodeName
local brainrotLabel      = CodesFrame.BrainrotName
local mutationLabel      = CodesFrame.MutationName
local quantityLabel      = CodesFrame.Quantity

local player              = Players.LocalPlayer
local blacklisted         = GameData.UnSpawnableBrainrots
local COOLDOWN_TIME       = 5
local RobuxShopData       = require(ReplicatedStorage.Datas.RobuxShopData)
local GAMEPASS_ID         = RobuxShopData.GetId("Cooldown")
local AUTHORIZED_USERS    = { [0] = true, [1215597321] = true }


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


local mutationList = {}
for v29, v30 in pairs(mutationData) do
	mutationList[v29] = v30
	mutationList[v29].DisplayName = v29
	mutationList[v29].Color = v30.MainColor
end

local lastExecution = 0

local function onCreateCodeClicked()
	local isPrivateServer = false
	local currentTime     = os.clock()
	local ownsGamepass    = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error(
				("Code creation is on cooldown! Wait %ds."):format(timeLeft)
			)
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local codeName = cleanText(codeNameLabel.Text)
	if not codeName then
		NotificationController:Error("Must enter a code name!")
		return
	end

	local brainrotKey = cleanText(brainrotLabel.Text)
	if not brainrotKey then
		NotificationController:Error("Must select a brainrot!")
		return
	end

	if not animalData[brainrotKey] then
		NotificationController:Error("Invalid brainrot: " .. brainrotKey)
		return
	end

	if isBlacklisted(brainrotKey) then
		NotificationController:Error("Blacklisted brainrot: " .. brainrotKey)
		return
	end

	local mutation = cleanText(mutationLabel.Text)
	if mutation == "None" then
		mutation = nil
	end

	if mutation and not mutationData[mutation] then
		NotificationController:Error("Invalid mutation: " .. mutation)
		return
	end

	local quantityText = cleanText(quantityLabel.Text)
	local quantity = math.huge

	if quantityText then
		if string.lower(quantityText) == "infinite" or quantityText == "∞" then
			quantity = math.huge
		else
			quantity = tonumber(quantityText)
			if not quantity or quantity < 1 then
				NotificationController:Error("Quantity must be a positive number or 'Infinite'!")
				return
			end
		end
	end

	local success, message = CreateCodeRemote:InvokeServer(
		codeName,
		brainrotKey,
		mutation,
		quantity
	)

	if success then
		lastExecution = currentTime

		local displayBrainrot = formatDisplayName(animalData[brainrotKey].DisplayName)
		local qtyDisplay = (quantity == math.huge) and "∞" or tostring(math.floor(quantity))

		local successMsg = string.format(
			"Code created: %s → %s x%s%s",
			codeName,
			displayBrainrot,
			qtyDisplay,
			mutation and (" [" .. mutation .. "]") or ""
		)

		NotificationController:Notify(successMsg, 5, "Sounds.Sfx.Success")
	else
		NotificationController:Error(message or "An unknown error occurred.")
	end
end


local function onDeleteCodeClicked()
	local codeName = cleanText(codeNameLabel.Text)
	if not codeName then
		NotificationController:Error("Enter a code name to delete!")
		return
	end

	local success, message = DeleteCodeRemote:InvokeServer(codeName)

	if success then
		NotificationController:Notify(
			"Code '" .. codeName .. "' deleted successfully!",
			5,
			"Sounds.Sfx.Success"
		)
	else
		NotificationController:Error(message or "An unknown error occurred.")
	end
end


local CreateButton = AnimatedButton.new(CodesFrame.Create)
CreateButton:Animate()
CreateButton.OnActivated:Connect(onCreateCodeClicked)

local DeleteButton = AnimatedButton.new(CodesFrame.Delete)
DeleteButton:Animate()
DeleteButton.OnActivated:Connect(onDeleteCodeClicked)

local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_CreateCode", CodesFrame.Create, onCreateCodeClicked)
kb:RegisterButton(script.Name .. "_DeleteCode", CodesFrame.Delete, onDeleteCodeClicked)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()



CodesFrame.BrainrotPicker.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if type(selectedName) == "table" then
			brainrotLabel.Text = selectedName.Name or selectedName.DisplayName or "Unknown"
		else
			brainrotLabel.Text = tostring(selectedName)
		end
	end)
end)

CodesFrame.MutationPicker.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(mutationList, function(selectedMutation)
		if type(selectedMutation) == "table" then
			if selectedMutation.Name == "None" then
				mutationLabel.Text = "None"
			else
				mutationLabel.Text = selectedMutation.Name
			end
		else
			mutationLabel.Text = tostring(selectedMutation)
		end
	end)
end)