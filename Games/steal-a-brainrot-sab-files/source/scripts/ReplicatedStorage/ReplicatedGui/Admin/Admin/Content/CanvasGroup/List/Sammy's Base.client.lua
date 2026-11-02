
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local animalData         = require(ReplicatedStorage.Datas.Animals)
local raritiesData       = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton     = require(ReplicatedStorage.Classes.AnimatedButton)
local Net                = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local GameData           = require(ReplicatedStorage.GameData)
local Synchronizer       = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager     = require(ReplicatedStorage.Modules.KeybindManager)

local blacklisted   = GameData.UnSpawnableBrainrots
local player        = Players.LocalPlayer

local SammyBaseOverrideRemote = Net:RemoteFunction("SammyBaseService/SetSammyBase")

local SammyFrame       = script.Parent["Sammy Base"].Frame
local mainAnimalsLabel = SammyFrame.mainName
local skinInput        = SammyFrame.skinName
local nameInput        = SammyFrame.baseName


local function isBlacklisted(name: string): boolean
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local function trimText(textbox): string
	return textbox.Text:match("^%s*(.-)%s*$") or ""
end


local SetButton = AnimatedButton.new(SammyFrame.Set)
SetButton:Animate()

local function DoSetButton()
	local rawAnimals = trimText(mainAnimalsLabel)

	local animals = {}
	for entry in rawAnimals:gmatch("[^,]+") do
		local trimmed = entry:match("^%s*(.-)%s*$")
		if trimmed ~= "" then
			table.insert(animals, trimmed)
		end
	end

	if #animals > 27 then
		NotificationController:Error("Maximum 27 brainrots allowed! You provided " .. #animals .. ".")
		return
	end

	for i, name in ipairs(animals) do
		if not animalData[name] then
			NotificationController:Error("Slot " .. i .. " – Invalid brainrot: " .. name)
			return
		end
		if isBlacklisted(name) then
			NotificationController:Error("Slot " .. i .. " – Blacklisted brainrot: " .. name)
			return
		end
	end

	local skin        = trimText(skinInput)
	local displayName = trimText(nameInput)
	local actualName  = displayName ~= "" and displayName or nil
	local success, message = SammyBaseOverrideRemote:InvokeServer(animals, skin, actualName)

	if not success then
		NotificationController:Error(message or "An unknown error occurred.")
	end
end

SetButton.OnActivated:Connect(DoSetButton)


local nameList = {}
for _, v in pairs(animalData) do
	local isRestricted      = blacklisted[v.DisplayName]
	local isAuthorizedUser  = (player.UserId == 0 or player.UserId == 1215597321)
	if not isRestricted or isAuthorizedUser then
		table.insert(nameList, v)
	end
end

table.sort(nameList, function(a, b)
	local wa = raritiesData[a.Rarity].Weight
	local wb = raritiesData[b.Rarity].Weight
	if wa == wb then
		return a.DisplayName < b.DisplayName
	end
	return wa < wb
end)

SammyFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if selectedName == "None" or selectedName == "" then
			mainAnimalsLabel.Text = selectedName
			return
		end

		local count = 0
		for _ in selectedName:gmatch("[^,]+") do count = count + 1 end

		if count > 27 then
			NotificationController:Error("Maximum 27 animals allowed!")
			return
		end

		mainAnimalsLabel.Text = selectedName
	end, "multiple", mainAnimalsLabel.Text, nil, true)
end)
local BaseSkins = require(ReplicatedStorage.Datas.Index)

local skinList = {}
for skinKey, skinData in pairs(BaseSkins) do
	table.insert(skinList, {
		DisplayName = skinKey,
		Icon        = "",
		Color       = skinData.MainColor or Color3.fromRGB(60, 60, 60),
		_skinKey    = skinKey,
	})
end

table.sort(skinList, function(a, b)
	local orderA = (BaseSkins[a._skinKey] and BaseSkins[a._skinKey].Order) or 999
	local orderB = (BaseSkins[b._skinKey] and BaseSkins[b._skinKey].Order) or 999
	if orderA == orderB then
		return a.DisplayName < b.DisplayName
	end
	return orderA < orderB
end)

SammyFrame.skintext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(
		skinList,
		function(selectedName)
			local name = tostring(selectedName):match("^%s*(.-)%s*$") or ""
			if name ~= "" and name ~= "None" then
				skinInput.Text = name
			end
		end,
		"single",
		nil,
		nil,
		false
	)
end)
local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")
local playerSync    = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_ServerStart", SammyFrame.Set, DoSetButton)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()