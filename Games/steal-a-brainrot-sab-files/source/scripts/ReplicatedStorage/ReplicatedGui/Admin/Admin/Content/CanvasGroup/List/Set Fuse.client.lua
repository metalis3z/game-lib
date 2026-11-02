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

local ServerSpawnBrainrotRemote = Net:RemoteFunction("FuseMachineService/AdminForceFuse")
local SpawnBrainrot = script.Parent.Fuse.Frame
local mainnamelabel1 = SpawnBrainrot.mainName
local mainmutationlabel = SpawnBrainrot.mainMutation
local maintraitlabel = SpawnBrainrot.mainTrait

local COOLDOWN_TIME = 5
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local lastExecution = 0
local player = Players.LocalPlayer

local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots

local function isBlacklisted(name)
	if player.UserId == 0 or player.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local function checkGamepassOwnership()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)
	return success and ownsPass
end

local ServerSpawn = AnimatedButton.new(SpawnBrainrot.Set)
ServerSpawn:Animate()


local function DoServerSpawn()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Setting is on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local name = mainnamelabel1.Text

	if not animalData[name] then
		NotificationController:Error("Invalid brainrot: " .. tostring(name))
		return
	end

	if isBlacklisted(name) then
		NotificationController:Error("That brainrot is blacklisted!")
		return
	end

	local mutationText = mainmutationlabel.Text
	local mutation = (mutationText ~= "" and mutationText ~= "None" and mutationData[mutationText]) and mutationText or nil

	local traitText = maintraitlabel.Text
	local trait = nil

	if traitText ~= "" and traitText ~= "None" then
		local trimmed = traitText:match("^%s*(.-)%s*$")
		if string.lower(trimmed) == "all" then
			trait = "all"
		else
			local allValid = true
			for _, t in ipairs(string.split(trimmed, ",")) do
				local tTrimmed = t:match("^%s*(.-)%s*$")
				if tTrimmed ~= "" and not traitData[tTrimmed] then
					allValid = false
					break
				end
			end
			trait = allValid and trimmed or nil
		end
	end

	local success, message = ServerSpawnBrainrotRemote:InvokeServer(name, mutation, trait)

	if success then
		lastExecution = currentTime
		NotificationController:Success("Fuse Machine set successfully!")
	else
		NotificationController:Error(message)
	end
end

ServerSpawn.OnActivated:Connect(DoServerSpawn)

local nameList = {}
for _, brainrot in pairs(animalData) do
	if not isBlacklisted(brainrot.Name) and not isBlacklisted(brainrot.DisplayName) then
		table.insert(nameList, brainrot)
	end
end

table.sort(nameList, function(a, b)
	local v40 = raritiesData[a.Rarity].Weight
	local v41 = raritiesData[b.Rarity].Weight
	if v40 == v41 then
		return a.DisplayName < b.DisplayName
	else
		return v40 < v41
	end
end)

local function handleSelection(label)
	_G.SetAdminContent(nameList, function(selectedName)
		local name = type(selectedName) == "table"
			and (selectedName.Name or selectedName.DisplayName or "Unknown")
			or tostring(selectedName)

		if isBlacklisted(name) then
			NotificationController:Error("That brainrot is blacklisted!")
			return
		end

		label.Text = name
	end)
end

SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	handleSelection(mainnamelabel1)
end)
local mutationList = {}
for v29, v30 in pairs(mutationData) do
	mutationList[v29] = v30
	mutationList[v29].DisplayName = v29
	mutationList[v29].Color = v30.MainColor
end

local traitList = {
	["all"] = {
		["DisplayName"] = "all",
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

SpawnBrainrot.traittext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(traitList, function(selectedTrait)
		maintraitlabel.Text = selectedTrait
	end, "multiple", maintraitlabel.Text)
end)

SpawnBrainrot.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(mutationList, function(selectedMutation)
		mainmutationlabel.Text = selectedMutation
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", SpawnBrainrot.Set, DoServerSpawn)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()