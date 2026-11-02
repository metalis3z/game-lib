local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local EventsConfig = require(ReplicatedStorage:WaitForChild("EventsConfig"))
local XPMultiplierManager = require(game.ServerScriptService:WaitForChild("XPMultiplierManager"))
local WinsMultiplierManager = require(game.ServerScriptService:WaitForChild("WinsMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")
local UpdateSpeed = Remotes:WaitForChild("UpdateSpeed")
local WinsEventUpdate = Remotes:WaitForChild("WinsEventUpdate")
local BonusUpdate = ReplicatedStorage:WaitForChild("BonusUpdate")
local TreadmillSignal = Remotes:WaitForChild("TreadmillSignal")
local RequestCheckpointTp = Remotes:WaitForChild("RequestCheckpointTp")
local CheckpointTpSuccess = Remotes:WaitForChild("CheckpointTpSuccess")
local RequestInitialData = Remotes:WaitForChild("RequestInitialData")
local SetCustomSpeed = Remotes:WaitForChild("SetCustomSpeed")
local Rebirth = Remotes:WaitForChild("Rebirth")
local TikfinitySaveBinds = Remotes:WaitForChild("TikfinitySaveBinds")
local TikfinityLoadBinds = Remotes:WaitForChild("TikfinityLoadBinds")
local TikfinityAction = Remotes:WaitForChild("TikfinityAction")

local function formatNumber(n)
	local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"}
	if n < 1000 then return tostring(math.floor(n)) end
	local i = math.floor(math.log10(n) / 3)
	local suffix = suffixes[i + 1] or "inf"
	local val = n / 10 ^ (i * 3)
	return string.format("%.1f%s", val, suffix):gsub("%.0", "")
end

local function syncLeaderstats(player, data)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		if leaderstats:FindFirstChild("Speed") then leaderstats.Speed.Value = formatNumber(data.TotalXP) end
		if leaderstats:FindFirstChild("Wins") then leaderstats.Wins.Value = data.Wins end
		if leaderstats:FindFirstChild("Rebirths") then leaderstats.Rebirths.Value = data.Rebirths end
	end
end

local function getTierMultiplier(data)
	if data.CurrentSpeedTier and data.CurrentSpeedTier > 0 then
		local tierData = Config.SPEED_UPGRADES[data.CurrentSpeedTier]
		if tierData then
			return tierData.Multiplier
		end
	end
	return 1
end

local function getTrailMultiplier(trailKey)
	if not trailKey or trailKey == "None" then return 1 end
	local trailData = Config.TRAILS[trailKey]
	if not trailData then
		for _, v in ipairs(EventsConfig.Trails or {}) do
			if v.Key == trailKey then
				trailData = v
				break
			end
		end
	end
	return trailData and trailData.Multiplier or 1
end

local function handleUpdateSpeed(player, mode)
	local data = DataHandler.Get(player)
	if not data then return end
	
	local amount = 1
	if mode == "GoldTreadmill" then amount = 3
	elseif mode == "DiamondTreadmill" then amount = 9
	elseif mode == "CandyTreadmill" then amount = 25
	elseif mode == "KittyTreadmill" then amount = 150
	elseif mode == "FranceTreadmill" then amount = 180
	elseif mode == "AdminTreadmill" then amount = 100
	end
	
	local trailMult = getTrailMultiplier(data.EquippedTrail)
	local speedBoostMult = data.SpeedBoostMultiplier or 1
	local rebirthMult = data.Multiplier or 1
	
	local xpMult = XPMultiplierManager.Get()
	local gain = amount * data.StepBonus * speedBoostMult * rebirthMult * trailMult * xpMult
	
	data.XP = data.XP + gain
	data.TotalXP = data.TotalXP + gain
	
	local xpReq = Config.GetXPRequired(data.Level)
	while data.XP >= xpReq do
		data.XP = data.XP - xpReq
		data.Level = data.Level + 1
		xpReq = Config.GetXPRequired(data.Level)
		
		if (not data.CustomWalkSpeed or data.CustomWalkSpeed == 0) and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
		end
	end
	
	UpdateUI:FireClient(player, {
		XP = data.XP,
		TotalXP = data.TotalXP,
		Level = data.Level,
		XPRequired = xpReq
	})
	
	syncLeaderstats(player, data)
end

local function handleRebirth(player)
	local data = DataHandler.Get(player)
	if not data then return end
	
	local nextRebirthIndex = (data.Rebirths or 0) + 1
	local tier = Config.REBIRTH_TIERS[nextRebirthIndex]
	
	if tier and data.Level >= tier.level then
		data.Rebirths = nextRebirthIndex
		data.Multiplier = tier.multiplier
		
		data.Level = 1
		data.XP = 0
		data.TotalXP = 0
		data.Checkpoint = 0
		data.CustomWalkSpeed = 0
		
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
			local spawnPos = workspace:FindFirstChild("SpawnLocation") and workspace.SpawnLocation.Position or Vector3.new(0, 10, 0)
			player.Character:MoveTo(spawnPos + Config.SPAWN_OFFSET)
		end
		
		UpdateUI:FireClient(player, {
			Rebirths = data.Rebirths,
			Multiplier = data.Multiplier,
			Level = data.Level,
			XP = data.XP,
			TotalXP = data.TotalXP,
			Checkpoint = data.Checkpoint,
			CustomWalkSpeed = data.CustomWalkSpeed
		})
		
		syncLeaderstats(player, data)
	end
end

UpdateSpeed.OnServerEvent:Connect(handleUpdateSpeed)
Rebirth.OnServerEvent:Connect(handleRebirth)

RequestInitialData.OnServerEvent:Connect(function(player)
	local data = DataHandler.Get(player)
	if data then
		UpdateUI:FireClient(player, data)
		-- Send current global multipliers so joining players see active events
		UpdateUI:FireClient(player, { BonusWinsMultiplier = WinsMultiplierManager.Get() })
		-- Send current wins event status to joining player
		WinsEventUpdate:FireClient(player, WinsMultiplierManager.GetStatus())
		-- Send current XP multiplier status to joining player
		local xpStatus = XPMultiplierManager.GetStatus()
		if xpStatus.active then
			local remaining = 0
			if xpStatus.endTime > os.time() then
				remaining = xpStatus.endTime - os.time()
			end
			BonusUpdate:FireClient(player, {
				XP = { mult = xpStatus.multiplier, remaining = remaining }
			})
		end
		-- Auto-claim trails from gamepasses the player already owns
		task.spawn(function()
			local changed = false
			local function checkTrail(trailKey, gamepassId)
				if table.find(data.OwnedTrails or {}, trailKey) then return end
				local success, owns = pcall(function()
					return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
				end)
				if success and owns then
					table.insert(data.OwnedTrails, trailKey)
					changed = true
				end
				task.wait(0.1)
			end
			for trailKey, trailData in pairs(Config.TRAILS) do
				if trailData.Gamepass and trailData.Gamepass > 0 then
					checkTrail(trailKey, trailData.Gamepass)
				end
			end
			for _, trailData in ipairs(EventsConfig.Trails or {}) do
				if trailData.Gamepass and trailData.Gamepass > 0 then
					checkTrail(trailData.Key, trailData.Gamepass)
				end
			end
			if changed then
				UpdateUI:FireClient(player, {OwnedTrails = data.OwnedTrails})
			end
		end)
		-- Check speed tier gamepasses on join
		task.spawn(function()
			local currentTier = data.CurrentSpeedTier or 0
			local tierChanged = false
			for i, tierData in ipairs(Config.SPEED_UPGRADES) do
				if i > currentTier and tierData.ID and tierData.ID > 0 then
					local success, owns = pcall(function()
						return MarketplaceService:UserOwnsGamePassAsync(player.UserId, tierData.ID)
					end)
					if success and owns then
						currentTier = i
						tierChanged = true
					end
					task.wait(0.1)
				end
			end
			if tierChanged then
				data.CurrentSpeedTier = currentTier
				local tierData = Config.SPEED_UPGRADES[currentTier]
				local newMult = tierData.Multiplier
				if data.SpecialSpeedBoost then
					newMult = newMult + 1000
				end
				data.SpeedBoostMultiplier = newMult
				UpdateUI:FireClient(player, {
					CurrentSpeedTier = currentTier,
					SpeedBoostMultiplier = newMult
				})
				syncLeaderstats(player, data)
			end
			-- Check special x1000 gamepass on join
		local specialId = Config.GAMEPASS_IDS.SPEED_X1000
		if specialId and specialId ~= 0 then
			local spSuccess, spOwns = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, specialId)
			end)
			if spSuccess and spOwns then
				data.SpecialSpeedBoost = true
				local newMult = getTierMultiplier(data) + 1000
				data.SpeedBoostMultiplier = newMult
				UpdateUI:FireClient(player, {
					SpeedBoostMultiplier = newMult,
					SpecialSpeedBoost = true
				})
				syncLeaderstats(player, data)
			end
		end
		end)
	end
end)

TreadmillSignal.OnServerEvent:Connect(function(player, active, treadmillType)
	local data = DataHandler.Get(player)
	if data then
		data.onTreadmill = active
	end
	-- Set attributes on character so they replicate to all clients
	-- This allows other players to see the walk/run animation
	local char = player.Character
	if char then
		char:SetAttribute("IsOnTreadmill", active)
		if active and treadmillType then
			char:SetAttribute("TreadmillType", treadmillType)
		else
			char:SetAttribute("TreadmillType", nil)
		end
	end
end)

SetCustomSpeed.OnServerEvent:Connect(function(player, speed)
	local data = DataHandler.Get(player)
	if data then
		local maxSpeed = Config.MAX_LEVEL_SPEED_CAP
		data.CustomWalkSpeed = math.clamp(speed, Config.DEFAULT_WALKSPEED, maxSpeed)
		
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = data.CustomWalkSpeed
		end
	end
end)

RequestCheckpointTp.OnServerEvent:Connect(function(player, checkpointIndex, mode)
	local data = DataHandler.Get(player)
	if not data then return end
	
	local checkpoint = Config.CHECKPOINTS[checkpointIndex]
	if not checkpoint then return end
	
	if mode == "wins" then
		if data.Wins >= checkpoint.WinPrice then
			data.Wins = data.Wins - checkpoint.WinPrice
			data.Checkpoint = checkpointIndex

			-- Auto-downgrade award if wins dropped below requirement
			data.StepBonus = Config.GetBestStepBonus(data.Wins)

			local stagePart = workspace:FindFirstChild("Stages") and workspace.Stages:FindFirstChild(checkpoint.Name)
			if stagePart then
				player.Character:MoveTo(stagePart.Position + Vector3.new(0, 5, 0))
			end

			UpdateUI:FireClient(player, {Wins = data.Wins, Checkpoint = data.Checkpoint, StepBonus = data.StepBonus})
			CheckpointTpSuccess:FireClient(player)
			syncLeaderstats(player, data)
		end
	elseif mode == "robux" then
		MarketplaceService:PromptProductPurchase(player, checkpoint.RobuxProductId)
	end
end)

local purchaseRemotes = {
	"PromptWinsBoost", "Prompt150KSpeed", "Prompt1MSpeed", 
	"Prompt10MSpeed", "Prompt50MSpeed", "Prompt500MSpeed", "Prompt1BSpeed"
}

for _, remoteName in ipairs(purchaseRemotes) do
	local remote = Remotes:FindFirstChild(remoteName)
	if remote then
		remote.OnServerEvent:Connect(function(player)
			local productId = 0
			if remoteName == "Prompt150KSpeed" then productId = Config.DEV_PRODUCTS.SPEED_150K
			elseif remoteName == "Prompt1MSpeed" then productId = Config.DEV_PRODUCTS.SPEED_1M
			elseif remoteName == "Prompt10MSpeed" then productId = Config.DEV_PRODUCTS.SPEED_10M
			elseif remoteName == "Prompt50MSpeed" then productId = Config.DEV_PRODUCTS.SPEED_50M
			elseif remoteName == "Prompt500MSpeed" then productId = Config.DEV_PRODUCTS.SPEED_500M
			elseif remoteName == "Prompt1BSpeed" then productId = Config.DEV_PRODUCTS.SPEED_1B
			end
			
			if productId ~= 0 then
				MarketplaceService:PromptProductPurchase(player, productId)
			end
		end)
	end
end

-- Handle SpeedBoost gamepass recheck (after purchase or on join)
local speedBoostRemote = Remotes:FindFirstChild("PromptSpeedBoost")
if speedBoostRemote then
	speedBoostRemote.OnServerEvent:Connect(function(player)
		local data = DataHandler.Get(player)
		if not data then return end
		local gamepassId = Config.GAMEPASS_IDS.SPEED_X2
		local legacyId = Config.LEGACY_GAMEPASS_IDS and Config.LEGACY_GAMEPASS_IDS.SPEED_X2 or 0
		
		local speedOwned = false
		if gamepassId and gamepassId ~= 0 then
			local success, owns = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
			end)
			if success and owns then
				speedOwned = true
			end
		end
		if not speedOwned and legacyId and legacyId ~= 0 then
			local legacySuccess, legacyOwns = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, legacyId)
			end)
			if legacySuccess and legacyOwns then
				speedOwned = true
			end
		end
		
		if speedOwned then
			local newMult = 2
			if data.SpecialSpeedBoost then
				newMult = newMult + 1000
			end
			data.SpeedBoostMultiplier = newMult
			UpdateUI:FireClient(player, {SpeedBoostMultiplier = newMult})
			syncLeaderstats(player, data)
		end
	end)
end

-- Handle Special x1000 Speed Boost gamepass purchase
local specialBoostRemote = Remotes:FindFirstChild("PromptSpecialSpeedBoost")
if specialBoostRemote then
	specialBoostRemote.OnServerEvent:Connect(function(player)
		local data = DataHandler.Get(player)
		if not data then return end
		
		local gamepassId = Config.GAMEPASS_IDS.SPEED_X1000
		if not gamepassId or gamepassId == 0 then return end
		
		local success, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		
		if success and owns then
			data.SpecialSpeedBoost = true
			local newMult = getTierMultiplier(data) + 1000
			data.SpeedBoostMultiplier = newMult
			UpdateUI:FireClient(player, {
				SpeedBoostMultiplier = newMult,
				SpecialSpeedBoost = true
			})
			syncLeaderstats(player, data)
		end
	end)
end

-- Handle Speed Tier Upgrade gamepass purchases
local speedTierRemote = Remotes:FindFirstChild("PromptSpeedTierUpgrade")
if speedTierRemote then
	speedTierRemote.OnServerEvent:Connect(function(player)
		local data = DataHandler.Get(player)
		if not data then return end
		
		local currentTier = data.CurrentSpeedTier or 0
		local nextTierIndex = currentTier + 1
		local tierData = Config.SPEED_UPGRADES[nextTierIndex]
		if not tierData then return end
		
		-- Verify gamepass ownership
		local gamepassId = tierData.ID
		local owns = false
		local success, result = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		if success and result then
			owns = true
		end
		
		if owns then
			data.CurrentSpeedTier = nextTierIndex
			local newMult = tierData.Multiplier
			if data.SpecialSpeedBoost then
				newMult = newMult + 1000
			end
			data.SpeedBoostMultiplier = newMult
			UpdateUI:FireClient(player, {
				CurrentSpeedTier = nextTierIndex,
				SpeedBoostMultiplier = newMult
			})
			syncLeaderstats(player, data)
		end
	end)
end

Remotes.BuyTrail.OnServerInvoke = function(player, trailKey, buyType)
	local data = DataHandler.Get(player)
	if not data then return false, "Data not loaded" end
	for _, owned in ipairs(data.OwnedTrails or {}) do
		if owned == trailKey then return false, "Already owned" end
	end
	local trailData = Config.TRAILS[trailKey]
	if not trailData then
		for _, v in ipairs(EventsConfig.Trails) do
			if v.Key == trailKey then
				trailData = v
				break
			end
		end
	end
	if not trailData then return false, "Trail not found" end
	if buyType == "Wins" then
		local price = trailData.Price or 0
		if price == 0 then return false, "This trail requires a gamepass" end
		if data.Wins >= price then
			data.Wins = data.Wins - price
			table.insert(data.OwnedTrails, trailKey)

			-- Auto-downgrade award if wins dropped below requirement
			data.StepBonus = Config.GetBestStepBonus(data.Wins)

			UpdateUI:FireClient(player, {Wins = data.Wins, OwnedTrails = data.OwnedTrails, StepBonus = data.StepBonus})
			syncLeaderstats(player, data)
			return true
		else
			return false, "Not enough Wins"
		end
	elseif buyType == "Currency" then
		local priceData = trailData.CurrencyPrice
		if priceData then
			local currencyKey = priceData.Key
			local amount = priceData.Amount
			if data[currencyKey] and data[currencyKey] >= amount then
				data[currencyKey] = data[currencyKey] - amount
				table.insert(data.OwnedTrails, trailKey)
				local update = {OwnedTrails = data.OwnedTrails}
				update[currencyKey] = data[currencyKey]
				UpdateUI:FireClient(player, update)
				return true
			else
				return false, "Not enough " .. currencyKey
			end
		end
	end
	return false, "Invalid purchase type"
end

Remotes.EquipTrail.OnServerEvent:Connect(function(player, trailKey)
	local data = DataHandler.Get(player)
	if not data then return end
	local owned = false
	if trailKey == "None" then
		owned = true
	else
		for _, v in ipairs(data.OwnedTrails or {}) do
			if v == trailKey then
				owned = true
				break
			end
		end
		if not owned then
			local trailData = Config.TRAILS[trailKey]
			if not trailData then
				for _, v in ipairs(EventsConfig.Trails) do
					if v.Key == trailKey then
						trailData = v
						break
					end
				end
			end
			if trailData and trailData.Gamepass and trailData.Gamepass > 0 then
				local success, owns = pcall(function()
					return MarketplaceService:UserOwnsGamePassAsync(player.UserId, trailData.Gamepass)
				end)
				if success and owns then
					owned = true
					table.insert(data.OwnedTrails, trailKey)
				end
			end
		end
	end
	if owned then
		data.EquippedTrail = trailKey
		if player.Character then
			player.Character:SetAttribute("EquippedTrail", trailKey)
		end
		UpdateUI:FireClient(player, {EquippedTrail = trailKey, OwnedTrails = data.OwnedTrails})
	end
end)

local function setupCharacterTrail(player, char)
	local data = DataHandler.Get(player)
	if data and data.EquippedTrail then
		char:SetAttribute("EquippedTrail", data.EquippedTrail)
	end
end

local function onPlayerAddedTrail(player)
	player.CharacterAdded:Connect(function(char)
		setupCharacterTrail(player, char)
	end)
end

Players.PlayerAdded:Connect(onPlayerAddedTrail)

for _, player in Players:GetPlayers() do
	onPlayerAddedTrail(player)
	if player.Character then
		setupCharacterTrail(player, player.Character)
	end
end

TikfinitySaveBinds.OnServerEvent:Connect(function(player, binds)
	local data = DataHandler.Get(player)
	if data then
		data.TikfinityBinds = binds
	end
end)

TikfinityLoadBinds.OnServerInvoke = function(player)
	local data = DataHandler.Get(player)
	return data and data.TikfinityBinds or {}
end

TikfinityAction.OnServerEvent:Connect(function(player, action)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	
	if action == "Explode" then
		local ex = Instance.new("Explosion")
		ex.Position = char.HumanoidRootPart.Position
		ex.Parent = workspace
	end
end)
