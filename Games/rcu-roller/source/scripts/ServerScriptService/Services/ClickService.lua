--[[
	ClickService — Handles player clicks (manual and auto) for the pet simulator clicker.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Knit      = require(ReplicatedStorage.Packages.Knit)
local Variables = require(ReplicatedStorage.Shared.Variables)
local Pet       = require(ReplicatedStorage.Shared.Items.Pet)
local ClicksValue     = require(ReplicatedStorage.Shared.Values.Clicks)
local EpicClickChance = require(ReplicatedStorage.Shared.Values.EpicClickChance)

local EPIC_CLICK_MULTIPLIER = 2

local MAX_CLICKS_PER_SECOND = 25

local ClickService = Knit.CreateService({
	Name = "ClickService",
	Client = {
		click = Knit.CreateSignal(),
		setIsAutoClicking = Knit.CreateSignal(),
	},
	_dataService = nil,
	_clickCounts = {},
	_cleanupThreads = {},
})

local function calculateClickPower(player, data)
	-- 1. Sum multipliers of all equipped pets
	local petMultTotal = 0
	if data.equippedPets and data.inventory and data.inventory.pet then
		for petId, _ in data.equippedPets do
			local petData = data.inventory.pet[petId]
			if petData and type(petData) == "table" and petData.nm then
				local ok, petObj = pcall(function()
					return Pet(petData.nm):setData(petData)
				end)
				if ok and petObj then
					petMultTotal += petObj:getMultiplier(data)
				end
			end
		end
	end
	-- If no pets equipped, base pet power is 1
	if petMultTotal <= 0 then petMultTotal = 1 end

	-- 2. Get clicks bonus multiplier (VIP, upgrades, potions, aura, clan, etc.)
	local clicksBonus = ClicksValue(player, data) or 1

	return math.floor(petMultTotal * clicksBonus)
end

function ClickService:_consumeClickToken(player)
	local count = self._clickCounts[player] or 0
	if count >= MAX_CLICKS_PER_SECOND then
		return false
	end
	self._clickCounts[player] = count + 1
	return true
end

function ClickService:_startRateLimitLoop(player)
	local thread = task.spawn(function()
		while player.Parent do
			task.wait(1)
			if not player.Parent then break end
			self._clickCounts[player] = 0
		end
	end)
	self._cleanupThreads[player] = thread
end

function ClickService:_onPlayerRemoving(player)
	self._clickCounts[player] = nil
	local thread = self._cleanupThreads[player]
	if thread then
		task.cancel(thread)
		self._cleanupThreads[player] = nil
	end
end

function ClickService:KnitInit()
	self._dataService = Knit.GetService("DataService")

	-- Signal handler: client fires click → server processes → fires back result
	self.Client.click:Connect(function(player)
		local data = self._dataService:GetData(player)
		if not data then return end

		if not self:_consumeClickToken(player) then
			return
		end

		local clickAmount = calculateClickPower(player, data)

		-- Epic click check
		local popupType = "clicks"
		local epicChance = EpicClickChance(player, data)
		if epicChance > 0 and math.random() < epicChance then
			clickAmount = clickAmount * EPIC_CLICK_MULTIPLIER
			popupType = "clicksEpic"
		end

		local newClicks = (data.clicks or 0) + clickAmount
		self._dataService:Set(player, {"clicks"}, newClicks)

		local newTotal = (data.stats.totalClicks or 0) + clickAmount
		self._dataService:Set(player, {"stats", "totalClicks"}, newTotal)

		-- Prestige XP: every click gives XP equal to click amount
		local newXp = (data.prestigeXp or 0) + clickAmount
		self._dataService:Set(player, {"prestigeXp"}, newXp)

		-- Fire back to client: (popupType, clickAmount) to match createPopup(type, amount, pos)
		self.Client.click:Fire(player, popupType, clickAmount)
	end)

	-- Signal handler: client toggles auto-clicking
	self.Client.setIsAutoClicking:Connect(function(player, isAutoClicking)
		local data = self._dataService:GetData(player)
		if not data then return end
		if type(isAutoClicking) ~= "boolean" then return end
		self._dataService:Set(player, {"isAutoClicking"}, isAutoClicking)
	end)
end

function ClickService:KnitStart()
	for _, player in Players:GetPlayers() do
		self._clickCounts[player] = 0
		self:_startRateLimitLoop(player)
	end

	Players.PlayerAdded:Connect(function(player)
		self._clickCounts[player] = 0
		self:_startRateLimitLoop(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:_onPlayerRemoving(player)
	end)

	print("[ClickService] Started")
end

return ClickService
