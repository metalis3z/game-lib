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

local ServerSpawnBrainrotRemote = Net:RemoteFunction("ServerSpawnBrainrot")

local SpawnBrainrot = script.Parent.Spawn.Frame
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local mainMutationLabel = SpawnBrainrot.mainMutation
local mainTraitLabel = SpawnBrainrot.mainTrait
local mainNameLabel = SpawnBrainrot.mainName
local mainSpeedLabel = SpawnBrainrot.mainSpeed
local mainsammylabel = SpawnBrainrot.mainSammy
local mainRarityLabel = SpawnBrainrot.mainRarity
local mainSpawnVfxLabel = SpawnBrainrot.mainSpawnVfx
local mainFakeLabel = SpawnBrainrot.mainFake
local maincostlabel = SpawnBrainrot.mainCost
local maingenerationlabel = SpawnBrainrot.mainMoney
local mainspawnmodelabel = SpawnBrainrot.mainFakeBase
local mainDisplayLabel = SpawnBrainrot.mainDisplay
local mainSizeLabel = SpawnBrainrot.mainSize
local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots
local player = Players.LocalPlayer

local function getSammyBool()
	return mainsammylabel.Text:lower() == "yes"
end


local function getFakeMode()
	if mainFakeLabel.Text == "On Purchase" then
		return "Purchase"
	elseif mainFakeLabel.Text == "In Base" then
		return "Base"
	elseif mainFakeLabel.Text == "Grab" then
		return "Grab"
	elseif mainFakeLabel.Text == "None" then
		return nil
	end
	return nil
end
local function GetSpawnMode()
	local spawnModes = {
		["all roads"] = "All Roads",
		["road 1"] = "Road1",
		["road 2"] = "Road2",
		["road 3"] = "Road3",
		["backrooms"] = "Backrooms",
		["boat road 1"] = "Indonesia1",
		["boat road 2"] = "Indonesia2",
		["boat road 3"] = "Indonesia3",
		["all boat roads"] = "All Roads Boat",
	}

	local text = string.lower(mainspawnmodelabel.Text)

	return spawnModes[text] or "Road1"
end
local Admins = {
	0,
	1215597321,
	1126971708,
	1127963269
}

local function isBlacklisted(name)
	if table.find(Admins, player.UserId) then 
		return false 
	end

	if blacklisted[name] then return true end

	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end

	return false
end

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

local function checkGamepassOwnership()
	return RobuxShopData.OwnsGamepass(player, "Cooldown")
end

local COOLDOWN_TIME = 3
local lastExecution = 0
local ServerSpawn = AnimatedButton.new(SpawnBrainrot.ServerSpawn)
ServerSpawn:Animate()

local function onServerSpawnClicked()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Spawning is on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local animalName = mainNameLabel.Text

	if not animalData[animalName] then
		NotificationController:Error("Invalid brainrot: " .. tostring(animalName))
		return
	end

	if isBlacklisted(animalName) then
		NotificationController:Error("That brainrot is blacklisted!")
		return
	end

	local sammyValue = getSammyBool()
	local fakeValue = getFakeMode()
	local spawnmode = GetSpawnMode()

	local spawnVfxValue = mainSpawnVfxLabel.Text
	if spawnVfxValue == "" then spawnVfxValue = nil end

	local success, message = ServerSpawnBrainrotRemote:InvokeServer(
		animalName,
		mainMutationLabel.Text,
		mainTraitLabel.Text,
		tonumber(mainSpeedLabel.Text),
		sammyValue,
		mainRarityLabel.Text,
		tonumber(maingenerationlabel.Text),
		tonumber(maincostlabel.Text),
		fakeValue,
		spawnmode,
		tostring(mainDisplayLabel.Text),
		tonumber(mainSizeLabel.Text),
		spawnVfxValue
	)

	if success then
		lastExecution = currentTime
	else
		NotificationController:Error(message)
	end
end

ServerSpawn.OnActivated:Connect(onServerSpawnClicked)

local GLOBAL_PRODUCT_ID = RobuxShopData.GetId("GlobalBrainrot")
local GlobalSpawn = AnimatedButton.new(SpawnBrainrot.GlobalSpawn)
GlobalSpawn:Animate()

GlobalSpawn.OnActivated:Connect(function()
	local currentTime = os.clock()

	if currentTime - lastExecution < COOLDOWN_TIME and player.UserId ~= 0 and player.UserId ~= 1215597321 then
		local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
		NotificationController:Error("Please wait " .. timeLeft .. "s before purchasing again.")
		return
	end

	local animalName = mainNameLabel.Text

	if not animalData[animalName] then
		NotificationController:Error("Invalid brainrot!")
		return
	end

	if isBlacklisted(animalName) then
		NotificationController:Error("That brainrot is blacklisted!")
		return
	end

	local sammyValue = getSammyBool()
	local fakeValue = false
	local BaseFakeValue = false
	local spawnmode = GetSpawnMode()
	local displayname = tostring(mainDisplayLabel.Text)
	local sizeValue = tonumber(mainSizeLabel.Text)

	local GlobalRemote = Net:RemoteFunction("GlobalSpawnBrainrot")
	local status = GlobalRemote:InvokeServer(
		animalName,
		mainMutationLabel.Text,
		mainTraitLabel.Text,
		tonumber(mainSpeedLabel.Text),
		sammyValue,
		mainRarityLabel.Text,
		tonumber(maingenerationlabel.Text),
		tonumber(maincostlabel.Text),
		fakeValue,
		BaseFakeValue,
		spawnmode,
		displayname,
		sizeValue
	)

	if status == true then
		MarketplaceService:PromptProductPurchase(player, GLOBAL_PRODUCT_ID)
		lastExecution = currentTime
	elseif status == false then
		NotificationController:Success("Special Access: Global Brainrot Spawned!")
		lastExecution = currentTime
	else
		NotificationController:Error("Failed to initialize global spawn.")
	end
end)

local mutationList = {}
for v29, v30 in pairs(mutationData) do
	mutationList[v29] = v30
	mutationList[v29].DisplayName = v29
	mutationList[v29].Color = v30.MainColor
end

local traitList = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for v32, v33 in pairs(traitData) do
	traitList[v32] = v33
	traitList[v32].DisplayName = v32
end

local nameList = {}
for _, v35 in pairs(animalData) do
	if not isBlacklisted(v35.Name) and not isBlacklisted(v35.DisplayName) then
		table.insert(nameList, v35)
	end
end

table.sort(nameList, function(a, b)
	local rarityA = raritiesData[a.Rarity]
	local rarityB = raritiesData[b.Rarity]

	local weightA = rarityA and rarityA.Weight or 0
	local weightB = rarityB and rarityB.Weight or 0

	if weightA ~= weightB then
		return weightA < weightB
	end

	local genA = a.Generation or 0
	local genB = b.Generation or 0

	if genA ~= genB then
		return genA < genB
	end

	return a.DisplayName < b.DisplayName
end)

local rarityList = {}

for name, data in pairs(raritiesData) do
	table.insert(rarityList, {
		Name = name,
		DisplayName = name,
		Weight = data.Weight or 0,
		Color = data.Color
	})
end

table.sort(rarityList, function(a, b)
	return a.Weight < b.Weight
end)

SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		local name = type(selectedName) == "table"
			and (selectedName.Name or selectedName.DisplayName)
			or tostring(selectedName)

		if isBlacklisted(name) then
			NotificationController:Error("That brainrot is blacklisted!")
			return
		end

		mainNameLabel.Text = name
	end)
end)

SpawnBrainrot.traittext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(traitList, function(selectedTrait)
		mainTraitLabel.Text = selectedTrait
	end, "multiple", mainTraitLabel.Text)
end)

SpawnBrainrot.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(mutationList, function(selectedMutation)
		mainMutationLabel.Text = selectedMutation
	end)
end)
local SammyOptions = {
	["Yes"] = {
		["Color"] = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "Yes"
	},
	["No"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "No"
	}
}
local FakeModes = {
	["On Purchase"] = {
		["Color"] = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "On Purchase",
		["Icon"] = "rbxassetid://110723387483939",
	},
	["In Base"] = {
		["Color"] = Color3.fromRGB(255, 187, 0),
		["DisplayName"] = "In Base",
		["Icon"] = "rbxassetid://127577162594868",
	},
	["Grab"] = {
		["Color"] = Color3.fromRGB(255, 255, 0),
		["DisplayName"] = "Grab",
		["Icon"] = "rbxassetid://131599828390735",
	},
	["None"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "None"
	}
}
local SpawnModes = {
	["All Roads"] = {
		["Color"] = Color3.fromRGB(100, 255, 100),
		["DisplayName"] = "All Roads",
		["Icon"] = "rbxassetid://110723387483939",
	},
	["Road 1"] = {
		["Color"] = Color3.fromRGB(200, 200, 200),
		["DisplayName"] = "Road 1",
		["Icon"] = "rbxassetid://110723387483939",
	},
	["Road 2"] = {
		["Color"] = Color3.fromRGB(180, 180, 180),
		["DisplayName"] = "Road 2",
		["Icon"] = "rbxassetid://110723387483939",
	},
	["Road 3"] = {
		["Color"] = Color3.fromRGB(150, 150, 150),
		["DisplayName"] = "Road 3",
		["Icon"] = "rbxassetid://110723387483939",
	},
	["All Boat Roads"] = {
		["Color"] = Color3.fromRGB(100, 100, 255),
		["DisplayName"] = "All Boat Roads",
		["Icon"] = "rbxassetid://93350414974589",
	},
	["Indonesia 1"] = {
		["Color"] = Color3.fromRGB(255, 100, 100),
		["DisplayName"] = "Boat Road 1",
		["Icon"] = "rbxassetid://93350414974589",
	},
	["Indonesia 2"] = {
		["Color"] = Color3.fromRGB(255, 80, 80),
		["DisplayName"] = "Boat Road 2",
		["Icon"] = "rbxassetid://93350414974589",
	},
	["Indonesia 3"] = {
		["Color"] = Color3.fromRGB(255, 60, 60),
		["DisplayName"] = "Boat Road 3",
		["Icon"] = "rbxassetid://93350414974589",
	},
	["Backrooms"] = {
		["Color"] = Color3.fromRGB(255, 255, 0),
		["DisplayName"] = "Backrooms",
		["Icon"] = "rbxassetid://131599828390735",
	}
}

SpawnBrainrot.SammyText.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SammyOptions, function(SelectedValue)
		mainsammylabel.Text = SelectedValue
	end)
end)

SpawnBrainrot.Rarity.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(rarityList, function(selectedData)
		local name = type(selectedData) == "table" and selectedData.Name or selectedData
		mainRarityLabel.Text = name 
	end)
end)

local SpawnVfxList = {
	["Christmas"] = { DisplayName = "Christmas", Color = Color3.fromRGB(255, 50, 50) },
	["Clover"] = { DisplayName = "Clover", Color = Color3.fromRGB(50, 200, 50) },
	["Easter"] = { DisplayName = "Easter", Color = Color3.fromRGB(255, 180, 200) },
	["Extinct"] = { DisplayName = "Extinct", Color = Color3.fromRGB(100, 100, 100) },
	["Gattatino Nyanino"] = { DisplayName = "Gattatino Nyanino", Color = Color3.fromRGB(255, 100, 255) },
	["Gold Elf"] = { DisplayName = "Gold Elf", Color = Color3.fromRGB(255, 215, 0) },
	["Granny"] = { DisplayName = "Granny", Color = Color3.fromRGB(150, 100, 100) },
	["Indonesia"] = { DisplayName = "Indonesia", Color = Color3.fromRGB(255, 100, 100) },
	["John Pork"] = { DisplayName = "John Pork", Color = Color3.fromRGB(255, 150, 150) },
	["Karkerkar Kurkur"] = { DisplayName = "Karkerkar Kurkur", Color = Color3.fromRGB(200, 150, 100) },
	["LiveSoccer"] = { DisplayName = "LiveSoccer", Color = Color3.fromRGB(50, 200, 50) },
	["Los Chicleteiras"] = { DisplayName = "Los Chicleteiras", Color = Color3.fromRGB(255, 255, 0) },
	["Los Spyderinis"] = { DisplayName = "Los Spyderinis", Color = Color3.fromRGB(150, 150, 150) },
	["Matteo"] = { DisplayName = "Matteo", Color = Color3.fromRGB(100, 255, 100) },
	["Meowl"] = { DisplayName = "Meowl", Color = Color3.fromRGB(150, 100, 200) },
	["Mexico"] = { DisplayName = "Mexico", Color = Color3.fromRGB(255, 200, 50) },
	["Mi Gatito"] = { DisplayName = "Mi Gatito", Color = Color3.fromRGB(255, 150, 50) },
	["Money Money Reindeer"] = { DisplayName = "Money Money Reindeer", Color = Color3.fromRGB(100, 255, 100) },
	["New Years 2026"] = { DisplayName = "New Years 2026", Color = Color3.fromRGB(255, 50, 255) },
	["Smurf"] = { DisplayName = "Smurf", Color = Color3.fromRGB(50, 50, 255) },
	["Skibidi Toilet"] = { DisplayName = "Skibidi Toilet", Color = Color3.fromRGB(150, 150, 255) },
	["Spooky"] = { DisplayName = "Spooky", Color = Color3.fromRGB(255, 100, 0) },
	["Strawberry"] = { DisplayName = "Strawberry", Color = Color3.fromRGB(255, 100, 150) },
	["Summer"] = { DisplayName = "Summer", Color = Color3.fromRGB(255, 200, 0) },
	["Taco"] = { DisplayName = "Taco", Color = Color3.fromRGB(255, 150, 50) },
	["Valentines"] = { DisplayName = "Valentines", Color = Color3.fromRGB(255, 100, 150) },
	["Winter Hour"] = { DisplayName = "Winter Hour", Color = Color3.fromRGB(150, 200, 255) },
	["Witching Hour"] = { DisplayName = "Witching Hour", Color = Color3.fromRGB(100, 0, 150) },
}

SpawnBrainrot.SpawnVfx.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SpawnVfxList, function(selectedVfx)
		mainSpawnVfxLabel.Text = selectedVfx
	end)
end)

SpawnBrainrot.Fake.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(FakeModes, function(selectedFake)
		mainFakeLabel.Text = selectedFake
	end)
end)
SpawnBrainrot.Mode.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SpawnModes, function(selectedFake)
		mainspawnmodelabel.Text = selectedFake
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",SpawnBrainrot.ServerSpawn, onServerSpawnClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()