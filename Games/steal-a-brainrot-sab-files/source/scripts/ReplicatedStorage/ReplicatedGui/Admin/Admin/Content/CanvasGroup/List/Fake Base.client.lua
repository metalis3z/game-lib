
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local player            = Players.LocalPlayer

local AnimalData     = require(ReplicatedStorage.Datas.Animals)
local RarityData     = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net            = require(ReplicatedStorage.Packages.Net)
local NotificationController   = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local GameData       = require(ReplicatedStorage.GameData)
local BasesData      = require(ReplicatedStorage.Datas.Bases)

local blacklisted = GameData.UnSpawnableBrainrots
local MAX_REBIRTH = 18

local BotBaseRemote = Net:RemoteFunction("BotBaseService/SpawnBotBase")
local RemoveBotBaseRemote = Net:RemoteFunction("BotBaseService/RemoveBotBase")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local Frame         = script.Parent.Bot.Frame
local UsernameInput = Frame.main
local BrainrotInput = Frame.mainName
local RebirthInput  = Frame.Mainrebirths
local PlotInput     = Frame:FindFirstChild("MainPlots")
local SkinInput     = Frame:FindFirstChild("MainSkins")
local ActivateBtn   = Frame.Server
local RemoveBtn     = Frame:FindFirstChild("Remove")

local SKIN_NAMES = {
	"Aquatic", "Candy", "Default", "Diamond", "Galaxy", "Gold", "Halloween",
	"Lava", "Radioactive", "Strawberry", "YinYang", "Gingerbread", "Meowl",
	"Cursed", "Headless", "Spyder", "Taco", "Rose", "Christmas", "Lucky",
	"Skibidi", "Pot of Gold", "Divine", "Bunny Basket", "Cyber", "John Pork",
	"Valentines",
}

local NUM_PLOTS = 8

local function isBlacklisted(name)
	if blacklisted[name] then return true end
	local animal = AnimalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local function trim(s)
	return (tostring(s):match("^%s*(.-)%s*$")) or ""
end

local SpawnBtn = AnimatedButton.new(ActivateBtn)
SpawnBtn:Animate()

local function onActivate()
	local username = trim(UsernameInput.Text)
	if username == "" then
		NotificationController:Error("Please enter a username for the fake base.")
		return
	end

	local rebirthText = trim(RebirthInput.Text)
	local rebirth = 0
	if rebirthText ~= "" then
		local n = tonumber(rebirthText)
		if not n then
			NotificationController:Error("Rebirths must be a number (0-" .. MAX_REBIRTH .. ").")
			return
		end
		rebirth = math.floor(n)
	end
	if rebirth < 0 or rebirth > MAX_REBIRTH then
		NotificationController:Error("Rebirths must be between 0 and " .. MAX_REBIRTH .. ".")
		return
	end

	local brainrots = {}
	for entry in trim(BrainrotInput.Text):gmatch("[^,]+") do
		local name = trim(entry)
		if name ~= "" then
			table.insert(brainrots, name)
		end
	end

	local plotText = PlotInput and trim(PlotInput.Text) or ""
	local plotNumber = nil
	if plotText ~= "" then
		local n = tonumber(plotText)
		if not n then
			NotificationController:Error("Plot number must be a number (1-" .. NUM_PLOTS .. ").")
			return
		end
		n = math.floor(n)
		if n < 1 or n > NUM_PLOTS then
			NotificationController:Error("Plot number must be between 1 and " .. NUM_PLOTS .. ".")
			return
		end
		plotNumber = n
	end

	local maxAnimals = (BasesData[rebirth] and BasesData[rebirth].MaxAnimals) or 10
	if #brainrots > maxAnimals then
		NotificationController:Error(("Too many brainrots for rebirth %d (max %d)."):format(rebirth, maxAnimals))
		return
	end
	for i, name in ipairs(brainrots) do
		if not AnimalData[name] then
			NotificationController:Error(("Slot %d - invalid brainrot: %s"):format(i, name))
			return
		end
		if isBlacklisted(name) then
			NotificationController:Error(("Slot %d - blacklisted brainrot: %s"):format(i, name))
			return
		end
	end

	local skin = SkinInput and trim(SkinInput.Text) or ""

	local ok, success, message = pcall(function()
		return BotBaseRemote:InvokeServer(username, brainrots, rebirth, plotNumber, skin)
	end)
	if not ok then
		NotificationController:Error("Something went wrong contacting the server.")
		return
	end

	if success then
		NotificationController:Success(message or "Fake base spawned!")
	else
		NotificationController:Error(message or "Failed to spawn fake base.")
	end
end

SpawnBtn.OnActivated:Connect(onActivate)

local function onRemove()
	local plotText = PlotInput and trim(PlotInput.Text) or ""
	if plotText == "" then
		NotificationController:Error("Enter the plot number (1-" .. NUM_PLOTS .. ") of the fake base to remove.")
		return
	end

	local n = tonumber(plotText)
	if not n then
		NotificationController:Error("Plot number must be a number (1-" .. NUM_PLOTS .. ").")
		return
	end
	n = math.floor(n)
	if n < 1 or n > NUM_PLOTS then
		NotificationController:Error("Plot number must be between 1 and " .. NUM_PLOTS .. ".")
		return
	end

	local ok, success, message = pcall(function()
		return RemoveBotBaseRemote:InvokeServer(n)
	end)
	if not ok then
		NotificationController:Error("Something went wrong contacting the server.")
		return
	end

	if success then
		NotificationController:Success(message or "Fake base removed!")
	else
		NotificationController:Error(message or "Failed to remove fake base.")
	end
end

if RemoveBtn then
	local RemoveAnimated = AnimatedButton.new(RemoveBtn)
	RemoveAnimated:Animate()
	RemoveAnimated.OnActivated:Connect(onRemove)
end

local SortedAnimals = {}
for _, data in pairs(AnimalData) do
	if not isBlacklisted(data.Name) and not isBlacklisted(data.DisplayName) then
		table.insert(SortedAnimals, data)
	end
end
table.sort(SortedAnimals, function(a, b)
	local wa = RarityData[a.Rarity].Weight
	local wb = RarityData[b.Rarity].Weight
	if wa == wb then
		return a.DisplayName < b.DisplayName
	end
	return wa < wb
end)

local brainrotLabel =  Frame.nametext

brainrotLabel.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SortedAnimals, function(selected)
		local name = type(selected) == "table"
			and (selected.Name or selected.DisplayName)
			or tostring(selected)
		if name == "None" or name == "" then
			BrainrotInput.Text = name == "None" and "" or name
			return
		end
		BrainrotInput.Text = name
	end, "multiple", BrainrotInput.Text, nil, true)
end)

local PlotSelectionList = {}
for i = 1, NUM_PLOTS do
	table.insert(PlotSelectionList, { DisplayName = tostring(i) })
end

local plotSelectLabel = Frame:FindFirstChild("Plot Selection")
if plotSelectLabel
	and plotSelectLabel:FindFirstChild("ImageButton")
	and plotSelectLabel.ImageButton:FindFirstChild("TextButton")
	and PlotInput
	and _G.SetAdminContent
then
	plotSelectLabel.ImageButton.TextButton.Activated:Connect(function()
		_G.SetAdminContent(PlotSelectionList, function(selected)
			local value = type(selected) == "table"
				and (selected.DisplayName or selected.Name)
				or tostring(selected)
			if value == "None" then
				PlotInput.Text = ""
				return
			end
			PlotInput.Text = value
		end)
	end)
end

local SkinSelectionList = {}
for _, skinName in ipairs(SKIN_NAMES) do
	table.insert(SkinSelectionList, { DisplayName = skinName })
end
table.sort(SkinSelectionList, function(a, b)
	return a.DisplayName < b.DisplayName
end)

local skinSelectLabel = Frame:FindFirstChild("Plot Skin")
if skinSelectLabel
	and skinSelectLabel:FindFirstChild("ImageButton")
	and skinSelectLabel.ImageButton:FindFirstChild("TextButton")
	and SkinInput
	and _G.SetAdminContent
then
	skinSelectLabel.ImageButton.TextButton.Activated:Connect(function()
		_G.SetAdminContent(SkinSelectionList, function(selected)
			local value = type(selected) == "table"
				and (selected.DisplayName or selected.Name)
				or tostring(selected)
			if value == "None" then
				SkinInput.Text = ""
				return
			end
			SkinInput.Text = value
		end)
	end)
end

local playerSync = Synchronizer:Wait(player)
local kb = KeybindManager.new(SaveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_Activate", ActivateBtn, onActivate)
if RemoveBtn then
	kb:RegisterButton(script.Name .. "_Remove", RemoveBtn, onRemove)
end
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
