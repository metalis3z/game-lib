
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimatedButton         = require(ReplicatedStorage.Classes.AnimatedButton)
local Net                    = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local SpawnMachineRemote = Net:RemoteFunction("AdminService/SpawnMachine")

local SpawnFrame = script.Parent.Machines.Frame

local mainNameLabel = SpawnFrame.mainName

local GiveButton = AnimatedButton.new(SpawnFrame.Give)
GiveButton:Animate()

local function DoGiveButton()
	local success, message = SpawnMachineRemote:InvokeServer(mainNameLabel.Text, "add")
end

GiveButton.OnActivated:Connect(DoGiveButton)

local TakeButton = AnimatedButton.new(SpawnFrame.Take)
TakeButton:Animate()

local function DoTakeButton()
	local success, message = SpawnMachineRemote:InvokeServer(mainNameLabel.Text, "remove")
end

TakeButton.OnActivated:Connect(DoTakeButton)

local itemList = {}
local processedNames = {}

local machineNames = {
	{ DisplayName = "Divine Fuse",     SortValue = 1,   Icon = "rbxassetid://133058451981698", Category = "Machines" },
	{ DisplayName = "Normal Fuse",     SortValue = 2,   Icon = "rbxassetid://122450736808192", Category = "Machines" },
	{ DisplayName = "Summer Fuse",     SortValue = 3,   Icon = "rbxassetid://133077924666782", Category = "Machines" },
	{ DisplayName = "Santa Fuse",      SortValue = 4,   Icon = "rbxassetid://85728936284496", Category = "Machines" },
	{ DisplayName = "Witch Fuse",      SortValue = 5,   Icon = "rbxassetid://90217745566943", Category = "Machines" },

	{ DisplayName = "Cyber Craft",     SortValue = 6,   Icon = "rbxassetid://128168639073846", Category = "Machines" },
	{ DisplayName = "OG Craft",        SortValue = 7,   Icon = "rbxassetid://91121125539296",  Category = "Machines" },
	{ DisplayName = "Brainrot Trader", SortValue = 8,   Icon = "rbxassetid://139847934898650", Category = "Machines" },
	{ DisplayName = "Cupid's Machine", SortValue = 9,   Icon = "rbxassetid://81641382604997",  Category = "Machines" },
	{ DisplayName = "Santa Merchant",  SortValue = 10,  Icon = "rbxassetid://75454308964579",  Category = "Machines" },
}

for _, machine in ipairs(machineNames) do
	if not processedNames[machine.DisplayName] then
		table.insert(itemList, machine)
		processedNames[machine.DisplayName] = true
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

local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player         = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", SpawnFrame.Give, DoGiveButton)
kb:RegisterButton(script.Name.."_ServerStop",  SpawnFrame.Take, DoTakeButton)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()