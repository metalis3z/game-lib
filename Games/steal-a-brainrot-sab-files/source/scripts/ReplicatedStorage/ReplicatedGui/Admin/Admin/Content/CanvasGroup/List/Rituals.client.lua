local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local MutationsData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Mutations"))
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local animalData = require(ReplicatedStorage.Datas.Animals)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots
local StartMutationRemote = Net:RemoteFunction("RitualService/ForceStartRitual")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local MutationFrame = script.Parent.Ritual.Frame
local InputName = MutationFrame.mainName
local InputBrainrot = MutationFrame.mainDuration

local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local COOLDOWN_TIME = 5
local lastExecution = 0

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

local function isBlacklisted(name)
	if Players.UserId == 0 or Players.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end
local function checkGamepassOwnership()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(Players, "Cooldown")
	end)
	return success and ownsPass
end

local function PerformStartMutation()
	local isPrivateServer = false
	local currentTime = os.clock()
	local ownsGamepass = checkGamepassOwnership()

	if not isPrivateServer and not ownsGamepass then
		if currentTime - lastExecution < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - (currentTime - lastExecution))
			NotificationController:Error("Events are on cooldown! Wait " .. timeLeft .. "s.")
			MarketplaceService:PromptGamePassPurchase(Players, GAMEPASS_ID)
			return 
		end
	end

	local selectedEvent = InputName.Text:gsub("^%s*(.-)%s*$", "%1")
	local brainrot = InputBrainrot.Text:gsub("^%s*(.-)%s*$", "%1")
    if brainrot	== "" then brainrot = nil end
	local success, err = StartMutationRemote:InvokeServer(selectedEvent, brainrot)
	if success then
		lastExecution = currentTime
	else
		NotificationController:Error(tostring(err))
	end
end


local StartBtn = AnimatedButton.new(MutationFrame.ServerStart)
StartBtn:Animate()
StartBtn.OnActivated:Connect(PerformStartMutation)

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
MutationFrame.durationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		InputBrainrot.Text = selectedName
	end)
end)

local Rituals = {
	["1x1x1x1"] = {
		["Color"] = Color3.fromRGB(38, 255, 0),
		["DisplayName"] = "1x1x1x1",
		["Icon"] = "rbxassetid://109298418305415",
	},
	["Los Matteos"] = {
		["Color"] = Color3.fromRGB(0, 131, 9),
		["DisplayName"] = "Los Matteos",
		["Icon"] = "rbxassetid://115664804212096",
	},
}
MutationFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(Rituals, function(selectedName)
		InputName.Text = selectedName
	end)
end)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_ServerStart", MutationFrame.ServerStart, PerformStartMutation)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()