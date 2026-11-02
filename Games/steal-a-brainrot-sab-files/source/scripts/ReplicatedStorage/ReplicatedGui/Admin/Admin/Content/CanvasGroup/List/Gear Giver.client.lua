
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local itemData = require(ReplicatedStorage.Datas.Items)
local shopData = require(ReplicatedStorage.Datas.ShopItems)
local rodData = require(ReplicatedStorage.Datas.RodsShopItems)

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local GiveGearRemote = Net:RemoteFunction("GiveGear")
local TakeGearRemote = Net:RemoteFunction("TakeGear")

local SpawnFrame = script.Parent.Gear.Frame

local mainNameLabel = SpawnFrame.mainName

local GiveButton = AnimatedButton.new(SpawnFrame.Give)
GiveButton:Animate()

local function DoGiveButton()
	local success, message = GiveGearRemote:InvokeServer(mainNameLabel.Text)
end

GiveButton.OnActivated:Connect(DoGiveButton)

local TakeButton = AnimatedButton.new(SpawnFrame.Take)
TakeButton:Animate()

local function DoTakeButton()
	local success, message = TakeGearRemote:InvokeServer(mainNameLabel.Text)
end

TakeButton.OnActivated:Connect(DoTakeButton)

local itemList = {}
local processedNames = {}

local function addItemsToList(sourceTable, categoryName)
	for itemName, data in pairs(sourceTable) do
		if not processedNames[itemName] then
			table.insert(itemList, {
				DisplayName = itemName,
				SortValue = data.Force or data.LayoutOrder or 0, 
				Icon = data.Icon,
				Category = categoryName
			})
			processedNames[itemName] = true
		end
	end
end

addItemsToList(itemData, "Base Items")
addItemsToList(shopData, "Shop")
addItemsToList(rodData, "Rods")

local manualItems = {
	{DisplayName = "Flying Carpet", SortValue = 999, Icon = "rbxassetid://124807886192972", Category = "Manual"}
}

for _, item in ipairs(manualItems) do
	if not processedNames[item.DisplayName] then
		table.insert(itemList, item)
		processedNames[item.DisplayName] = true
	end
end

local physicalItemsFolder = ReplicatedStorage:FindFirstChild("Items")
if physicalItemsFolder then
	for _, item in ipairs(physicalItemsFolder:GetChildren()) do
		if not processedNames[item.Name] then
			table.insert(itemList, {
				DisplayName = item.Name,
				SortValue = 1000,
				Icon = "",
				Category = "Folder"
			})
			processedNames[item.Name] = true
		end
	end
end

table.sort(itemList, function(a, b)
	if a.SortValue == b.SortValue then
		return a.DisplayName < b.DisplayName
	end
	return a.SortValue < b.SortValue
end)

SpawnFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(itemList, function(selectedItem)
		if type(selectedItem) == "table" then
			mainNameLabel.Text = selectedItem.DisplayName
		else
			mainNameLabel.Text = tostring(selectedItem)
		end
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", SpawnFrame.Give, DoGiveButton)
kb:RegisterButton(script.Name.."_ServerStop", SpawnFrame.Take, DoTakeButton)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
