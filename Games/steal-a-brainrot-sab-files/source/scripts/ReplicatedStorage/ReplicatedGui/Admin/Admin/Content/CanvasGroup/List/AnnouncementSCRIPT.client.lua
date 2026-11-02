local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local AnnounceGlobal = Net:RemoteFunction("AnnounceGlobal")
local AnnounceServer = Net:RemoteFunction("AnnounceServer")

local SpawnBrainrot = script.Parent.Announcement.Frame
local player = Players.LocalPlayer

local SERVER_COOLDOWN = 5
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local nextAvailableTime = 0 

local Global = AnimatedButton.new(SpawnBrainrot.Global)
Global:Animate()

local Server = AnimatedButton.new(SpawnBrainrot.Server)
Server:Animate()


local function DoServerSpawn()
	local currentTime = os.clock()

	local hasPass = false
	local success, result = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)

	if success then
		hasPass = result
	end

	if not hasPass and currentTime < nextAvailableTime then 
		local timeLeft = math.ceil(nextAvailableTime - currentTime)
		NotificationController:Error("Wait " .. timeLeft .. " more second(s)")
		return 
	end

	local text = SpawnBrainrot.main.Text
	local name = SpawnBrainrot.mainName.Text
	if text ~= "" then
		if not hasPass then
			nextAvailableTime = currentTime + SERVER_COOLDOWN
		end

		AnnounceServer:InvokeServer(text, name)
	end
end

Server.OnActivated:Connect(DoServerSpawn)


Global.OnActivated:Connect(function()
	local text = SpawnBrainrot.main.Text
	local name = SpawnBrainrot.mainName.Text
	if text ~= "" then
		local result = AnnounceGlobal:InvokeServer(text, name)
		if result == "admin" then
			NotificationController:Success("Special Access: Global Announcement Sent Free!")
		end
	end
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", SpawnBrainrot.Server, DoServerSpawn)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
