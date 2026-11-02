local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local RobuxShopData = require(ReplicatedStorage.Datas.RobuxShopData)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local containerFrame = script.Parent.Misc.Frame
local hideButtonUI = containerFrame:FindFirstChild("Hide Khols Admin")

if not hideButtonUI then
	warn("[Hide Khols Admin] Button not found!")
	return
end

local ownsPSPlus = RobuxShopData.OwnsGamepass(player, "VIP")

if not ownsPSPlus then
	hideButtonUI.Visible = false
	return
end


local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")
local playerSync = Synchronizer:Wait(player)

local isAdminHidden = false


local function findKohlsAdminButtons()
	local buttons = {}
	
	for _, screenGui in playerGui:GetChildren() do
		if screenGui:IsA("ScreenGui") then
			for _, descendant in pairs(screenGui:GetDescendants()) do
				local name = descendant.Name
				if name == "KADashboardButton" or name == "KACommandsButton" then
					table.insert(buttons, descendant)
				end
			end
		end
	end
	
	return buttons
end


local animatedHideButton = AnimatedButton.new(hideButtonUI)
animatedHideButton:Animate()

local function toggleAdminVisibility()
	isAdminHidden = not isAdminHidden

	local buttons = findKohlsAdminButtons()
	
	if #buttons == 0 then
		warn("[Hide Khols Admin] No Kohl's Admin buttons found!")
	else
		for _, button in buttons do
			button.Visible = not isAdminHidden
		end
	end
	
	if isAdminHidden then
		hideButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		hideButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end
end

animatedHideButton.OnActivated:Connect(toggleAdminVisibility)


local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_ServerStart", hideButtonUI, toggleAdminVisibility)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()