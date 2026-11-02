local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local MutationsData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Mutations"))
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local StartRainRemote = Net:RemoteFunction("MutationRain")
local StopRainRemote = Net:RemoteFunction("StopMutationRain")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local MutationFrame = script.Parent.Mutations.Frame
local InputName = MutationFrame.mainName
local InputAmount = MutationFrame.mainDuration

local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local COOLDOWN_TIME = 5
local DEFAULT_AMOUNT = 10
local lastExecution = 0

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

local function checkGamepassOwnership()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(Players, "Cooldown")
	end)
	return success and ownsPass
end

local function PerformStartRain()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error(" is on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(Players, GAMEPASS_ID)
			return
		end
	end

	local selectedMutation = InputName.Text:gsub("^%s*(.-)%s*$", "%1")
	local amount = tonumber(InputAmount.Text) or DEFAULT_AMOUNT

	if amount <= 0 then
		NotificationController:Error("Amount must be greater than 0.")
		return
	end

	if selectedMutation ~= "" and not MutationsData[selectedMutation] then
		NotificationController:Error("Invalid mutation to start.")
		return
	end

	local success = StartRainRemote:InvokeServer(selectedMutation, amount)
	if success then
		lastExecution = currentTime
	else
		NotificationController:Error("Failed to start .")
	end
end

local function PerformStopRain()
	local selectedMutation = InputName.Text:gsub("^%s*(.-)%s*$", "%1")

	if selectedMutation ~= "" and not MutationsData[selectedMutation] then
		NotificationController:Error("Invalid mutation to stop.")
		return
	end

	local success = StopRainRemote:InvokeServer(selectedMutation)
	if not success then
		NotificationController:Error("Failed to stop .")
	end
end

local StartBtn = AnimatedButton.new(MutationFrame.ServerStart)
StartBtn:Animate()
StartBtn.OnActivated:Connect(PerformStartRain)

local StopBtn = AnimatedButton.new(MutationFrame.ServerStop)
StopBtn:Animate()
StopBtn.OnActivated:Connect(PerformStopRain)

local MutationListFormatted = {}
for name, data in pairs(MutationsData) do
	MutationListFormatted[name] = data
	MutationListFormatted[name].DisplayName = name
	MutationListFormatted[name].Color = data.MainColor
end

MutationFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(MutationListFormatted, function(selectedName)
		InputName.Text = selectedName
	end)
end)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_ServerStart", MutationFrame.ServerStart, PerformStartRain)
kb:RegisterButton(script.Name .. "_ServerStop", MutationFrame.ServerStop, PerformStopRain)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
