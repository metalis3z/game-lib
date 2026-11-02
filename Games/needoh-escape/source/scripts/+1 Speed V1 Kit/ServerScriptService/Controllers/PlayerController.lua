--!strict
-- LOCATION: ServerScriptService/Controllers/PlayerController

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local ProfileStoreModule = require(ServerScriptService.Modules.ProfileStore)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local TrailConfigurations = require(ReplicatedStorage.Modules.TrailConfigurations)
local CarConfigurations = require(ReplicatedStorage.Modules.CarConfigurations)

local DATA_VERSION = "PlayerData_v16"

local BASE_WALKSPEED = 8
local SPEED_PER_LEVEL = 2.15
local BASE_XP_COST = 8
local COST_MULTIPLIER = 1.25
local REBIRTH_MULT_ADD = 0.8
local MAX_WALKSPEED = 350  -- WalkSpeed hard cap; Speed currency is uncapped

local BASE_RANGE = 1.5
local MIN_RANGE = 1

local REVIVE_DURATION = 8

local REBIRTH_EASY_STEP       = 3
local REBIRTH_EASY_LEVEL_STEP = 5
local REBIRTH_HARD_LEVEL_STEP = 8
local REBIRTH_EXP_START       = 10
local REBIRTH_EXP_SCALE       = 1.35

local REBIRTH_EXP_BASE = REBIRTH_EASY_STEP * REBIRTH_EASY_LEVEL_STEP
	+ (REBIRTH_EXP_START - REBIRTH_EASY_STEP) * REBIRTH_HARD_LEVEL_STEP

local function getRebirthRequiredLevel(rebirths: number): number
	local next = rebirths + 1
	if next <= REBIRTH_EASY_STEP then
		return next * REBIRTH_EASY_LEVEL_STEP
	elseif next <= REBIRTH_EXP_START then
		return REBIRTH_EASY_STEP * REBIRTH_EASY_LEVEL_STEP
			+ (next - REBIRTH_EASY_STEP) * REBIRTH_HARD_LEVEL_STEP
	else
		return math.floor(REBIRTH_EXP_BASE * (REBIRTH_EXP_SCALE ^ (next - REBIRTH_EXP_START)))
	end
end

local UPGRADE_ORDER = {
	"Button1","Button2","Button3","Button4","Button5","Button6",
	"Button7","Button8","Button9","Button10","Button11","Button12"
}

type PlayerData = {
	Speed: number,
	Level: number,
	Wins: number,
	Rebirths: number,
	SpeedBonus: number,
	Range: number,
	SpeedPeakLevel: number,
	OwnedUpgrades: {[string]: boolean},
	OwnedTrails: {[string]: boolean},
	EquippedTrail: string,
	OwnedCars: {[string]: boolean},
	EquippedCar: string,
	CubesSoundOff: boolean,
	KeyboardSoundOff: boolean,
	MusicOff: boolean,
	TimePlayed: number,
}

local Template: PlayerData = {
	Speed = 0,
	Level = 1,
	Wins = 0,
	Rebirths = 0,
	SpeedBonus = 0,
	Range = BASE_RANGE,
	SpeedPeakLevel = 1,
	OwnedUpgrades = {},
	OwnedTrails = {},
	EquippedTrail = "",
	OwnedCars = {["Gulf"] = true},
	EquippedCar = "Gulf",
	CubesSoundOff = false,
	KeyboardSoundOff = false,
	MusicOff = false,
	TimePlayed = 0,
}

local PlayerDataStore = ProfileStoreModule.New(DATA_VERSION, Template)

local PlayerController = {}
local profiles: {[Player]: any} = {}
local events: {[string]: any} = {}
local gamePassCache: {[number]: {[number]: boolean}} = {}
local TreadmillController: any = nil
local SpeedRunController: any = nil

local sessionStartTimes: {[Player]: number} = {}

PlayerController.isShuttingDown = false

-- [ REVIVE SYSTEM STATE ] -----------------------------------------------------

type ReviveData = {
	stageNumber: number,
	tpCFrame: CFrame,
	timer: thread?,
	active: boolean,
}

local pendingRevives: {[Player]: ReviveData} = {}

local StageHitbox = Workspace:WaitForChild("StageHitbox")
local StageTP = Workspace:WaitForChild("StageTP")

-- [ HELPERS ] ----------------------------------------------------------------

local function getExperienceForLevel(level: number): number
	if level == 1 then return 0 end
	local total = 0
	for i = 1, level - 1 do
		total += math.floor(BASE_XP_COST * (COST_MULTIPLIER ^ (i - 1)))
	end
	return total
end

local function getRebirthMultiplier(rebirths: number): number
	return 1 + (rebirths * REBIRTH_MULT_ADD)
end

local function getTrailMultiplier(trailId: string): number
	if trailId == "" then return 1 end
	local info = TrailConfigurations.GetTrailById(trailId)
	return info and info.SpeedBoost or 1
end

local function getCarMultiplier(carId: string): number
	if carId == "" then return 1 end
	local info = CarConfigurations.GetCarById(carId)
	return info and info.WinBoost or 1
end

local function getMaxRangeForTrail(trailId: string): number
	if trailId == "" then return BASE_RANGE end
	local info = TrailConfigurations.GetTrailById(trailId)
	if info and info.Range then return info.Range end
	return BASE_RANGE
end

-- Clamps the computed WalkSpeed to MAX_WALKSPEED.
-- Speed currency (leaderstats.Speed) is intentionally uncapped.
local function updatePhysicalSpeed(player: Player, level: number)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid and humanoid:IsA("Humanoid") then
		local raw = math.round(BASE_WALKSPEED + (level - 1) * SPEED_PER_LEVEL)
		humanoid.WalkSpeed = math.min(raw, MAX_WALKSPEED)
	end
end

local function checkGamePass(player: Player, passId: number): boolean
	if not gamePassCache[player.UserId] then gamePassCache[player.UserId] = {} end
	if gamePassCache[player.UserId][passId] == nil then
		local ok, result = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId)
		end)
		if ok then gamePassCache[player.UserId][passId] = result else return false end
	end
	return gamePassCache[player.UserId][passId]
end

local function refreshSpeedPeakLevel(player: Player)
	local profile = profiles[player]
	if not profile then return end
	local highest = 1
	for _, tier in ipairs(ProductConfigurations.SpeedPeakTiers) do
		if checkGamePass(player, tier.Id) and tier.Level > highest then
			highest = tier.Level
		end
	end
	profile.Data.SpeedPeakLevel = highest
	local h = player:FindFirstChild("HiddenStats")
	if h then
		local sp = h:FindFirstChild("SpeedPeakLevel")
		if sp then sp.Value = highest end
	end
end

local function flushTimePlayed(player: Player)
	local profile = profiles[player]
	local t = sessionStartTimes[player]
	if not profile or not t then return end
	local elapsed = math.floor(os.clock() - t)
	if elapsed <= 0 then return end
	profile.Data.TimePlayed = (profile.Data.TimePlayed or 0) + elapsed
	sessionStartTimes[player] = os.clock()
end

-- [ REVIVE HELPERS ] ----------------------------------------------------------

local function findStageNumberFromPart(part: BasePart): number?
	local current: Instance? = part
	while current do
		if current.Parent == StageHitbox then
			local num = current.Name:match("^Stage(%d+)$")
			if num then return tonumber(num) end
		end
		current = current.Parent
	end
	return nil
end

local function getCharacterPositionPart(character: Model): BasePart?
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
		or character:FindFirstChild("Torso") :: BasePart?
		or character:FindFirstChild("Head") :: BasePart?
end

local function findHitboxAtPosition(position: Vector3): number?
	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Include
	overlapParams.FilterDescendantsInstances = {StageHitbox}

	local region = Workspace:GetPartBoundsInBox(CFrame.new(position), Vector3.new(4, 8, 4), overlapParams)
	for _, part in ipairs(region) do
		local num = findStageNumberFromPart(part)
		if num then return num end
	end

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Include
	rayParams.FilterDescendantsInstances = {StageHitbox}

	local rayResult = Workspace:Raycast(position, Vector3.new(0, -50, 0), rayParams)
	if rayResult then
		local num = findStageNumberFromPart(rayResult.Instance :: BasePart)
		if num then return num end
	end

	return nil
end

local function cancelPendingTimer(player: Player)
	local data = pendingRevives[player]
	if data and data.timer then
		task.cancel(data.timer)
		data.timer = nil
	end
end

local function setupReviveOnDeath(player: Player, character: Model)
	local humanoid = character:WaitForChild("Humanoid") :: Humanoid

	humanoid.Died:Connect(function()
		cancelPendingTimer(player)
		pendingRevives[player] = nil

		local posPart = getCharacterPositionPart(character)
		if not posPart then return end

		local deathPosition = posPart.Position
		local stageNumber = findHitboxAtPosition(deathPosition)
		if not stageNumber then return end

		local tpPart = StageTP:FindFirstChild("Stage" .. tostring(stageNumber))
		if not tpPart then
			warn("No StageTP part found for Stage" .. tostring(stageNumber))
			return
		end

		local tpCFrame: CFrame?
		if tpPart:IsA("BasePart") then
			tpCFrame = (tpPart :: BasePart).CFrame
		else
			local basePart = tpPart:FindFirstChildWhichIsA("BasePart")
			if basePart then tpCFrame = basePart.CFrame end
		end

		if not tpCFrame then
			warn("StageTP part " .. tpPart.Name .. " has no CFrame to teleport to")
			return
		end

		local data: ReviveData = {
			stageNumber = stageNumber,
			tpCFrame = tpCFrame,
			timer = nil,
			active = true,
		}
		pendingRevives[player] = data

		if events.ShowRevive then events.ShowRevive:FireClient(player, REVIVE_DURATION) end

		data.timer = task.delay(REVIVE_DURATION, function()
			local current = pendingRevives[player]
			if current == data and current.active then
				current.active = false
				if events.HideRevive then events.HideRevive:FireClient(player) end
				pendingRevives[player] = nil
			end
		end)
	end)
end

-- [ PRIVATE LOGIC ] ----------------------------------------------------------

local function performRebirth(player: Player, profile: any)
	profile.Data.Speed = 0
	profile.Data.Level = 1
	profile.Data.Rebirths += 1
	player.leaderstats.Speed.Value = 0
	player.leaderstats.Level.Value = 1
	player.leaderstats.Rebirths.Value = profile.Data.Rebirths
	updatePhysicalSpeed(player, 1)
	if events.RebirthSuccess then events.RebirthSuccess:FireClient(player) end
end

local function checkLevelUp(player: Player, profile: any)
	local data = profile.Data
	local xpForNextLevel = getExperienceForLevel(data.Level + 1)
	if data.Speed >= xpForNextLevel then
		local oldLevel = data.Level
		data.Level += 1
		player.leaderstats.Level.Value = data.Level
		updatePhysicalSpeed(player, data.Level)
		events.LevelUp:FireClient(player, oldLevel, data.Level)
		checkLevelUp(player, profile)
	end
end

local function setupLeaderstats(player: Player, profileData: PlayerData)
	local leaderstats = Instance.new("Folder"); leaderstats.Name = "leaderstats"; leaderstats.Parent = player

	local speed    = Instance.new("IntValue"); speed.Name    = "Speed";    speed.Value    = profileData.Speed;    speed.Parent    = leaderstats
	local level    = Instance.new("IntValue"); level.Name    = "Level";    level.Value    = profileData.Level;    level.Parent    = leaderstats
	local wins     = Instance.new("IntValue"); wins.Name     = "Wins";     wins.Value     = profileData.Wins;     wins.Parent     = leaderstats
	local rebirths = Instance.new("IntValue"); rebirths.Name = "Rebirths"; rebirths.Value = profileData.Rebirths; rebirths.Parent = leaderstats

	local upgradesFolder = Instance.new("Folder"); upgradesFolder.Name = "Upgrades"; upgradesFolder.Parent = player
	for id in pairs(profileData.OwnedUpgrades) do
		local t = Instance.new("StringValue"); t.Name = id; t.Parent = upgradesFolder
	end

	local trailsFolder = Instance.new("Folder"); trailsFolder.Name = "Trails"; trailsFolder.Parent = player
	local equippedVal = Instance.new("StringValue"); equippedVal.Name = "Equipped"; equippedVal.Value = profileData.EquippedTrail; equippedVal.Parent = trailsFolder
	for id in pairs(profileData.OwnedTrails) do
		local t = Instance.new("StringValue"); t.Name = id; t.Parent = trailsFolder
	end

	local carsFolder = Instance.new("Folder"); carsFolder.Name = "Cars"; carsFolder.Parent = player
	local equippedCarVal = Instance.new("StringValue"); equippedCarVal.Name = "Equipped"; equippedCarVal.Value = profileData.EquippedCar; equippedCarVal.Parent = carsFolder
	for id in pairs(profileData.OwnedCars) do
		local t = Instance.new("StringValue"); t.Name = id; t.Parent = carsFolder
	end

	local hiddenStats = Instance.new("Folder"); hiddenStats.Name = "HiddenStats"; hiddenStats.Parent = player
	local range          = Instance.new("NumberValue"); range.Name          = "Range";          range.Value          = profileData.Range;               range.Parent          = hiddenStats
	local speedPeakLevel = Instance.new("IntValue");    speedPeakLevel.Name = "SpeedPeakLevel"; speedPeakLevel.Value = profileData.SpeedPeakLevel or 1; speedPeakLevel.Parent = hiddenStats
	local chosenSpeed    = Instance.new("IntValue");    chosenSpeed.Name    = "ChosenSpeed";    chosenSpeed.Value    = 0;                                chosenSpeed.Parent    = hiddenStats

	local cubesSoundOff    = Instance.new("BoolValue"); cubesSoundOff.Name    = "CubesSoundOff";    cubesSoundOff.Value    = profileData.CubesSoundOff or false;    cubesSoundOff.Parent    = hiddenStats
	local keyboardSoundOff = Instance.new("BoolValue"); keyboardSoundOff.Name = "KeyboardSoundOff"; keyboardSoundOff.Value = profileData.KeyboardSoundOff or false; keyboardSoundOff.Parent = hiddenStats
	local musicOff         = Instance.new("BoolValue"); musicOff.Name         = "MusicOff";         musicOff.Value         = profileData.MusicOff or false;         musicOff.Parent         = hiddenStats

	local maxRange = Instance.new("NumberValue"); maxRange.Name = "MaxRange"; maxRange.Value = getMaxRangeForTrail(profileData.EquippedTrail); maxRange.Parent = hiddenStats

	speed.Changed:Connect(function(v)          profileData.Speed          = v end)
	level.Changed:Connect(function(v)          profileData.Level          = v end)
	wins.Changed:Connect(function(v)           profileData.Wins           = v end)
	rebirths.Changed:Connect(function(v)       profileData.Rebirths       = v end)
	equippedVal.Changed:Connect(function(v)    profileData.EquippedTrail  = v end)
	equippedCarVal.Changed:Connect(function(v) profileData.EquippedCar    = v end)
	range.Changed:Connect(function(v)          profileData.Range          = v end)
	speedPeakLevel.Changed:Connect(function(v) profileData.SpeedPeakLevel = v end)
	cubesSoundOff.Changed:Connect(function(v)    profileData.CubesSoundOff    = v end)
	keyboardSoundOff.Changed:Connect(function(v) profileData.KeyboardSoundOff = v end)
	musicOff.Changed:Connect(function(v)         profileData.MusicOff         = v end)

	chosenSpeed.Changed:Connect(function(v)
		local char = player.Character
		if not char then return end
		local hum = char:FindFirstChild("Humanoid")
		if hum and hum:IsA("Humanoid") then
			if v > 0 then
				-- ChosenSpeed also respects the WalkSpeed cap
				hum.WalkSpeed = math.min(v, MAX_WALKSPEED)
			else
				updatePhysicalSpeed(player, profileData.Level)
			end
		end
	end)
end

-- [ SESSION MANAGEMENT ] -----------------------------------------------------

local function onPlayerAdded(player: Player)
	local profile = PlayerDataStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function() return player.Parent ~= Players end,
	})
	if not profile then player:Kick("Could not load data. Please rejoin."); return end
	profile:AddUserId(player.UserId)
	profile:Reconcile()

	if not profile.Data.OwnedCars["Gulf"] then
		profile.Data.OwnedCars["Gulf"] = true
		if profile.Data.EquippedCar == "" then profile.Data.EquippedCar = "Gulf" end
	end
	if profile.Data.Range == nil             then profile.Data.Range             = BASE_RANGE end
	if profile.Data.SpeedPeakLevel == nil    then profile.Data.SpeedPeakLevel    = 1          end
	if profile.Data.CubesSoundOff == nil     then profile.Data.CubesSoundOff     = false      end
	if profile.Data.KeyboardSoundOff == nil  then profile.Data.KeyboardSoundOff  = false      end
	if profile.Data.MusicOff == nil          then profile.Data.MusicOff          = false      end
	if profile.Data.TimePlayed == nil        then profile.Data.TimePlayed        = 0          end

	do
		local maxAllowed = getMaxRangeForTrail(profile.Data.EquippedTrail)
		if profile.Data.Range > maxAllowed then
			profile.Data.Range = maxAllowed
		elseif profile.Data.Range < MIN_RANGE then
			profile.Data.Range = MIN_RANGE
		end
	end

	profile.OnSessionEnd:Connect(function()
		profiles[player] = nil
		gamePassCache[player.UserId] = nil
		pendingRevives[player] = nil
		sessionStartTimes[player] = nil
		player:Kick("Profile session released.")
	end)

	if player.Parent == Players then
		profiles[player] = profile
		sessionStartTimes[player] = os.clock()
		setupLeaderstats(player, profile.Data)

		player.CharacterAdded:Connect(function(character)
			task.wait(0.1)
			local h = player:FindFirstChild("HiddenStats")
			local chosen = h and h:FindFirstChild("ChosenSpeed")
			if chosen and chosen.Value > 0 then
				local char = player.Character
				if char then
					local hum = char:FindFirstChild("Humanoid")
					if hum and hum:IsA("Humanoid") then
						hum.WalkSpeed = math.min(chosen.Value, MAX_WALKSPEED)
					end
				end
			else
				updatePhysicalSpeed(player, profile.Data.Level)
			end
			setupReviveOnDeath(player, character)
		end)

		if player.Character then
			updatePhysicalSpeed(player, profile.Data.Level)
			setupReviveOnDeath(player, player.Character)
		end

		task.spawn(function()
			checkGamePass(player, ProductConfigurations.DoubleWinsGP)
			for _, tier in ipairs(ProductConfigurations.SpeedPeakTiers) do
				checkGamePass(player, tier.Id)
			end
			refreshSpeedPeakLevel(player)
		end)
	else
		profile:EndSession()
	end
end

local function onPlayerRemoving(player: Player)
	flushTimePlayed(player)
	sessionStartTimes[player] = nil

	local profile = profiles[player]
	if profile then
		profile:EndSession()
		if not PlayerController.isShuttingDown then
			profiles[player] = nil
			gamePassCache[player.UserId] = nil
		end
	end
	cancelPendingTimer(player)
	pendingRevives[player] = nil
end

-- [ REVIVE: PERFORM REVIVE ] ---------------------------------------------------

local function performRevive(player: Player, data: ReviveData)
	cancelPendingTimer(player)
	if events.HideRevive then events.HideRevive:FireClient(player) end

	local targetCFrame = data.tpCFrame
	pendingRevives[player] = nil

	player:LoadCharacter()

	local character = player.Character
	if not character then
		character = player.CharacterAdded:Wait()
	end

	local hrp = character:WaitForChild("HumanoidRootPart", 5) :: BasePart?
	if hrp then
		task.defer(function()
			hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
		end)
	end

	if SpeedRunController then
		task.defer(function()
			SpeedRunController:ResumeAfterRevive(player)
		end)
	end
end

local function processReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then return Enum.ProductPurchaseDecision.NotProcessedYet end

	if receiptInfo.ProductId == ProductConfigurations.ReviveId then
		local data = pendingRevives[player]
		if data and data.active then
			data.active = false
			performRevive(player, data)
		end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local profile = profiles[player]
	if not profile then return Enum.ProductPurchaseDecision.NotProcessedYet end

	if receiptInfo.ProductId == ProductConfigurations.SkipRebirthId then
		performRebirth(player, profile)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local trailInfo = TrailConfigurations.GetTrailByProductId(receiptInfo.ProductId)
	if trailInfo then
		if not profile.Data.OwnedTrails[trailInfo.ID] then
			profile.Data.OwnedTrails[trailInfo.ID] = true
			local tf = player:FindFirstChild("Trails")
			if tf then local t = Instance.new("StringValue"); t.Name = trailInfo.ID; t.Parent = tf end
			if events.ShowNotification then events.ShowNotification:FireClient(player, "Unlocked " .. trailInfo.Name, "Success") end
		end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local carInfo = CarConfigurations.GetCarByProductId(receiptInfo.ProductId)
	if carInfo then
		if not profile.Data.OwnedCars[carInfo.ID] then
			profile.Data.OwnedCars[carInfo.ID] = true
			local cf = player:FindFirstChild("Cars")
			if cf then local t = Instance.new("StringValue"); t.Name = carInfo.ID; t.Parent = cf end
			if events.ShowNotification then events.ShowNotification:FireClient(player, "Unlocked " .. carInfo.Name, "Success") end
		end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	for _, prod in ipairs(ProductConfigurations.SpeedProducts) do
		if receiptInfo.ProductId == prod.Id then
			profile.Data.Speed += prod.Amount
			player.leaderstats.Speed.Value = profile.Data.Speed
			checkLevelUp(player, profile)
			if events.ShowNotification then events.ShowNotification:FireClient(player, "+" .. prod.Amount .. " Speed", "Success") end
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end

-- [ PUBLIC API ] -------------------------------------------------------------

function PlayerController:AddWins(player: Player, amount: number)
	local profile = profiles[player]
	if not profile then return end
	local mult = checkGamePass(player, ProductConfigurations.DoubleWinsGP) and 2 or 1
	local carMult = getCarMultiplier(profile.Data.EquippedCar)
	profile.Data.Wins += math.ceil(amount * mult * carMult)
	player.leaderstats.Wins.Value = profile.Data.Wins
end

function PlayerController:AddSpeedPoints(player: Player, customMult: number?)
	local profile = profiles[player]
	if not profile then return end
	local rebirthMult   = getRebirthMultiplier(profile.Data.Rebirths)
	local trailMult     = getTrailMultiplier(profile.Data.EquippedTrail)
	local treadmillMult = TreadmillController and TreadmillController:GetMultiplier(player) or 1
	local gamePassMult  = profile.Data.SpeedPeakLevel or 1
	local baseAmount    = 1 + profile.Data.SpeedBonus
	local extraMult     = customMult or 1
	local points = math.ceil(baseAmount * rebirthMult * trailMult * treadmillMult * gamePassMult * extraMult)
	player.leaderstats.Speed.Value += points
	checkLevelUp(player, profile)
end

function PlayerController:PurchaseUpgrade(player: Player, upgradeId: string, cost: number, bonus: number)
	local profile = profiles[player]
	if not profile then return end
	if profile.Data.OwnedUpgrades[upgradeId] then return end
	local rank = table.find(UPGRADE_ORDER, upgradeId)
	if rank and rank > 1 then
		local prev = UPGRADE_ORDER[rank - 1]
		if not profile.Data.OwnedUpgrades[prev] then
			if events.ShowNotification then events.ShowNotification:FireClient(player, "Locked! Buy previous upgrade first.", "Error") end
			return
		end
	end
	if profile.Data.Wins >= cost then
		profile.Data.Wins -= cost
		player.leaderstats.Wins.Value = profile.Data.Wins
		profile.Data.OwnedUpgrades[upgradeId] = true
		local uf = player:FindFirstChild("Upgrades")
		if uf then local t = Instance.new("StringValue"); t.Name = upgradeId; t.Parent = uf end
		if bonus > profile.Data.SpeedBonus then profile.Data.SpeedBonus = bonus end
		if events.UpgradeSuccess then events.UpgradeSuccess:FireClient(player) end
	else
		if events.ShowNotification then events.ShowNotification:FireClient(player, "Not enough Wins!", "Error") end
	end
end

function PlayerController:BuyTrailWithWins(player: Player, trailId: string)
	local profile = profiles[player]
	if not profile then return end
	local info = TrailConfigurations.GetTrailById(trailId)
	if not info then return end
	if profile.Data.OwnedTrails[trailId] then return end
	if profile.Data.Wins >= info.WinCost then
		profile.Data.Wins -= info.WinCost
		player.leaderstats.Wins.Value = profile.Data.Wins
		profile.Data.OwnedTrails[trailId] = true
		local tf = player:FindFirstChild("Trails")
		if tf then local t = Instance.new("StringValue"); t.Name = trailId; t.Parent = tf end
		if events.ShowNotification then events.ShowNotification:FireClient(player, "Bought " .. info.Name, "Success") end
	else
		if events.ShowNotification then events.ShowNotification:FireClient(player, "Not enough wins!", "Error") end
	end
end

function PlayerController:EquipTrail(player: Player, trailId: string)
	local profile = profiles[player]
	if not profile then return end
	if trailId ~= "" and not profile.Data.OwnedTrails[trailId] then return end
	profile.Data.EquippedTrail = trailId

	local maxAllowed = getMaxRangeForTrail(trailId)
	profile.Data.Range = maxAllowed

	local tf = player:FindFirstChild("Trails")
	if tf then local e = tf:FindFirstChild("Equipped"); if e then e.Value = trailId end end

	local h = player:FindFirstChild("HiddenStats")
	if h then
		local r = h:FindFirstChild("Range"); if r then r.Value = profile.Data.Range end
		local mr = h:FindFirstChild("MaxRange"); if mr then mr.Value = maxAllowed end
	end
end

function PlayerController:BuyCarWithWins(player: Player, carId: string)
	local profile = profiles[player]
	if not profile then return end
	local info = CarConfigurations.GetCarById(carId)
	if not info then return end
	if profile.Data.OwnedCars[carId] then return end
	if profile.Data.Wins >= info.WinCost then
		profile.Data.Wins -= info.WinCost
		player.leaderstats.Wins.Value = profile.Data.Wins
		profile.Data.OwnedCars[carId] = true
		local cf = player:FindFirstChild("Cars")
		if cf then local t = Instance.new("StringValue"); t.Name = carId; t.Parent = cf end
		if events.ShowNotification then events.ShowNotification:FireClient(player, "Bought " .. info.Name, "Success") end
	else
		if events.ShowNotification then events.ShowNotification:FireClient(player, "Not enough wins!", "Error") end
	end
end

function PlayerController:EquipCar(player: Player, carId: string)
	local profile = profiles[player]
	if not profile then return end
	if carId ~= "" and not profile.Data.OwnedCars[carId] then return end
	profile.Data.EquippedCar = carId
	local cf = player:FindFirstChild("Cars")
	if cf then local e = cf:FindFirstChild("Equipped"); if e then e.Value = carId end end
end

function PlayerController:SetRange(player: Player, value: number)
	local profile = profiles[player]
	if not profile then return end
	local maxAllowed = getMaxRangeForTrail(profile.Data.EquippedTrail)
	local clamped = math.clamp(value, MIN_RANGE, maxAllowed)
	profile.Data.Range = clamped
	local h = player:FindFirstChild("HiddenStats")
	if h then local r = h:FindFirstChild("Range"); if r then r.Value = clamped end end
	return clamped
end

function PlayerController:GetRange(player: Player): number
	local profile = profiles[player]
	if not profile then return BASE_RANGE end
	return profile.Data.Range or BASE_RANGE
end

function PlayerController:GetMaxRange(player: Player): number
	local profile = profiles[player]
	if not profile then return BASE_RANGE end
	return getMaxRangeForTrail(profile.Data.EquippedTrail)
end

function PlayerController:Notify(p: Player, m: string, t: string)
	if events.ShowNotification then events.ShowNotification:FireClient(p, m, t) end
end

function PlayerController:GetProfile(p: Player)
	return profiles[p]
end

function PlayerController:GetRebirthRequiredLevel(rebirths: number): number
	return getRebirthRequiredLevel(rebirths)
end

function PlayerController:FlushTimePlayed(player: Player)
	flushTimePlayed(player)
end

function PlayerController:Init(controllers: {[string]: any})
	TreadmillController = controllers.TreadmillController
	SpeedRunController  = controllers.SpeedRunController
end

function PlayerController:SetupSharedInstances()
	local e = ReplicatedStorage:FindFirstChild("Events")
	if not e then e = Instance.new("Folder"); e.Name = "Events"; e.Parent = ReplicatedStorage end
	local function mk(cl: string, nm: string)
		local x = Instance.new(cl); x.Name = nm; x.Parent = e; events[nm] = x
	end
	mk("RemoteEvent",    "AddSpeed")
	mk("RemoteEvent",    "LevelUp")
	mk("RemoteEvent",    "RebirthSuccess")
	mk("RemoteFunction", "RequestRebirth")
	mk("RemoteEvent",    "UpgradeSuccess")
	mk("RemoteEvent",    "ShowNotification")
	mk("RemoteEvent",    "TrailAction")
	mk("RemoteEvent",    "CarAction")
	mk("RemoteFunction", "GetRebirthRequiredLevel")
	mk("RemoteEvent",    "SetChosenSpeed")
	mk("RemoteEvent",    "SaveSetting")
	mk("RemoteEvent",    "ShowRevive")
	mk("RemoteEvent",    "HideRevive")
	mk("RemoteEvent",    "RequestRevive")
	mk("RemoteEvent", "SubmitReplay")
	mk("RemoteEvent", "RequestReplay")
	mk("RemoteEvent", "DeliverReplay")
end

function PlayerController:Start()
	MarketplaceService.ProcessReceipt = processReceipt

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, wasPurchased)
		if wasPurchased then
			if not gamePassCache[player.UserId] then gamePassCache[player.UserId] = {} end
			gamePassCache[player.UserId][passId] = true
			refreshSpeedPeakLevel(player)
			if events.ShowNotification then events.ShowNotification:FireClient(player, "Gamepass Active!", "Success") end
		end
	end)

	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
	for _, p in ipairs(Players:GetPlayers()) do task.spawn(onPlayerAdded, p) end

	task.spawn(function()
		while true do
			task.wait(60)
			for _, player in ipairs(Players:GetPlayers()) do
				flushTimePlayed(player)
			end
		end
	end)

	if events.AddSpeed then
		events.AddSpeed.OnServerEvent:Connect(function(player)
			if TreadmillController and TreadmillController:IsOnTreadmill(player) then return end
			PlayerController:AddSpeedPoints(player)
		end)
	end

	if events.RequestRebirth then
		events.RequestRebirth.OnServerInvoke = function(player)
			local profile = profiles[player]
			if not profile then return false end
			local req = getRebirthRequiredLevel(profile.Data.Rebirths)
			if profile.Data.Level >= req then performRebirth(player, profile); return true end
			return false
		end
	end

	if events.GetRebirthRequiredLevel then
		events.GetRebirthRequiredLevel.OnServerInvoke = function(player)
			local profile = profiles[player]
			if not profile then return 5 end
			return getRebirthRequiredLevel(profile.Data.Rebirths)
		end
	end

	if events.SetChosenSpeed then
		events.SetChosenSpeed.OnServerEvent:Connect(function(player, requestedSpeed: number)
			local profile = profiles[player]
			if not profile then return end
			local maxSpeed = math.min(
				math.round(BASE_WALKSPEED + (profile.Data.Level - 1) * SPEED_PER_LEVEL),
				MAX_WALKSPEED
			)
			local clamped = math.round(math.clamp(requestedSpeed, 0, maxSpeed))
			local h = player:FindFirstChild("HiddenStats")
			if h then
				local cs = h:FindFirstChild("ChosenSpeed")
				if cs then cs.Value = clamped end
			end
			local char = player.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				if hum and hum:IsA("Humanoid") then
					hum.WalkSpeed = clamped > 0 and clamped or maxSpeed
				end
			end
		end)
	end

	if events.TrailAction then
		events.TrailAction.OnServerEvent:Connect(function(p, a, t)
			if a == "BuyWins" then PlayerController:BuyTrailWithWins(p, t)
			elseif a == "Equip" then PlayerController:EquipTrail(p, t)
			elseif a == "Unequip" then PlayerController:EquipTrail(p, "") end
		end)
	end

	if events.CarAction then
		events.CarAction.OnServerEvent:Connect(function(p, a, t)
			if a == "BuyWins" then PlayerController:BuyCarWithWins(p, t)
			elseif a == "Equip" then PlayerController:EquipCar(p, t)
			elseif a == "Unequip" then PlayerController:EquipCar(p, "") end
		end)
	end

	if events.SaveSetting then
		events.SaveSetting.OnServerEvent:Connect(function(player, settingId: string, value: any)
			local profile = profiles[player]
			if not profile then return end
			local h = player:FindFirstChild("HiddenStats")

			if settingId == "CubesSoundOff" and typeof(value) == "boolean" then
				profile.Data.CubesSoundOff = value
				if h then local v = h:FindFirstChild("CubesSoundOff"); if v then v.Value = value end end

			elseif settingId == "KeyboardSoundOff" and typeof(value) == "boolean" then
				profile.Data.KeyboardSoundOff = value
				if h then local v = h:FindFirstChild("KeyboardSoundOff"); if v then v.Value = value end end

			elseif settingId == "MusicOff" and typeof(value) == "boolean" then
				profile.Data.MusicOff = value
				if h then local v = h:FindFirstChild("MusicOff"); if v then v.Value = value end end

			elseif settingId == "EditRange" and typeof(value) == "number" then
				PlayerController:SetRange(player, value)
			end
		end)
	end

	if events.RequestRevive then
		events.RequestRevive.OnServerEvent:Connect(function(player)
			local data = pendingRevives[player]
			if not data or not data.active then return end
			MarketplaceService:PromptProductPurchase(player, ProductConfigurations.ReviveId)
		end)
	end

	game:BindToClose(function()
		PlayerController.isShuttingDown = true
		for _, player in ipairs(Players:GetPlayers()) do
			flushTimePlayed(player)
		end
	end)
end

return PlayerController