local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local UpgradeShopService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")

local LEVEL_KEYS = {
	Storage = "StorageLevel",
	Damage  = "DamageLevel",
	Carry   = "CarryLevel",
	Walkspeed = "WalkspeedLevel",
}

local ATTRIBUTE_KEYS = {
	Storage = "MaxStorage",
	Damage  = "BaseDamage",
	Carry   = "MaxCarry",
	Walkspeed = "WalkSpeed",
}

local UpgradeShopRemotes
local BuyUpgradeFunc
local RequestUpgradeDataFunc
local UpgradeUpdateEvent

local function ensureRemotes()
	UpgradeShopRemotes = Remotes:FindFirstChild("UpgradeShopService")
	if not UpgradeShopRemotes then
		UpgradeShopRemotes = Instance.new("Folder")
		UpgradeShopRemotes.Name = "UpgradeShopService"
		UpgradeShopRemotes.Parent = Remotes
	end

	BuyUpgradeFunc = UpgradeShopRemotes:FindFirstChild("BuyUpgrade")
	if not BuyUpgradeFunc then
		BuyUpgradeFunc = Instance.new("RemoteFunction")
		BuyUpgradeFunc.Name = "BuyUpgrade"
		BuyUpgradeFunc.Parent = UpgradeShopRemotes
	end

	RequestUpgradeDataFunc = UpgradeShopRemotes:FindFirstChild("RequestUpgradeData")
	if not RequestUpgradeDataFunc then
		RequestUpgradeDataFunc = Instance.new("RemoteFunction")
		RequestUpgradeDataFunc.Name = "RequestUpgradeData"
		RequestUpgradeDataFunc.Parent = UpgradeShopRemotes
	end

	UpgradeUpdateEvent = UpgradeShopRemotes:FindFirstChild("UpgradeUpdate")
	if not UpgradeUpdateEvent then
		UpgradeUpdateEvent = Instance.new("RemoteEvent")
		UpgradeUpdateEvent.Name = "UpgradeUpdate"
		UpgradeUpdateEvent.Parent = UpgradeShopRemotes
	end
end

local function getUpgradeConfig(statName)
	return GameConfig.Upgrades and GameConfig.Upgrades[statName]
end

local function getLevel(playerData, statName)
	local key = LEVEL_KEYS[statName]
	if not key then
		return 0
	end
	local v = playerData[key]
	if typeof(v) ~= "number" or v < 0 then
		return 0
	end
	-- Clamp to the config cap: saves written under an older, taller ladder
	-- (Storage used to go to L165) read back as maxed instead of overflowing.
	local cfg = getUpgradeConfig(statName)
	if cfg and cfg.MaxLevel then
		v = math.min(v, cfg.MaxLevel)
	end
	return math.floor(v)
end

local function getStatValue(statName, level)
	local cfg = getUpgradeConfig(statName)
	if not cfg then
		return 0
	end
	return (cfg.Base or 0) + level * (cfg.PerLevel or 0)
end

-- Cost = floor(rawCurve / 10) * 10 + offset. The snap-to-$10 + per-stat
-- offset guarantees no two upgrades across Storage/Damage/Carry/BaseUpgrades
-- ever share a price (offsets {7, 3, 1, 9} all differ mod 10).
--
-- The raw curve is piecewise when the config supplies CostMultiplierMid and
-- CostMultiplierLate (user-requested ramp: cheap 1-10, moderate 11-20,
-- aggressive 21+). A config that only sets CostMultiplier falls back to the
-- legacy single-rate exponential -- this keeps Carry's flat 5.5x curve and
-- any other stat that doesn't opt into the piecewise tuning.
local function costForLevel(statName, level)
	local cfg = getUpgradeConfig(statName)
	if not cfg then
		return math.huge
	end
	-- Explicit per-level price list (Storage): CostTable[level+1] is the raw
	-- cost to buy the NEXT level. Levels beyond the table fall through to the
	-- exponential curves below.
	local tableRaw = cfg.CostTable and cfg.CostTable[level + 1]
	if tableRaw then
		return math.floor(tableRaw / 10) * 10 + (cfg.CostOffset or 0)
	end
	local base = cfg.CostBase or 0
	local mEarly = cfg.CostMultiplierEarly or cfg.CostMultiplier or 1
	local mMid   = cfg.CostMultiplierMid
	local mLate  = cfg.CostMultiplierLate

	local raw
	if mMid and mLate then
		if level <= 10 then
			raw = base * (mEarly ^ level)
		elseif level <= 20 then
			local pivotL10 = base * (mEarly ^ 10)
			raw = pivotL10 * (mMid ^ (level - 10))
		else
			local pivotL10 = base * (mEarly ^ 10)
			local pivotL20 = pivotL10 * (mMid ^ 10)
			raw = pivotL20 * (mLate ^ (level - 20))
		end
	else
		raw = base * ((cfg.CostMultiplier or 1) ^ level)
	end

	local offset = cfg.CostOffset or 0
	return math.floor(raw / 10) * 10 + offset
end

local function costForRange(statName, fromLevel, count)
	return math.ceil(costForLevel(statName, fromLevel) * count)
end

-- Escalating Robux ladder (Storage/Walkspeed): entry [level+1] is the
-- product that buys the NEXT level; nil past MaxLevel or without a ladder.
local function robuxLadderEntry(cfg, level)
	local ladder = cfg and cfg.RobuxLadder
	if not ladder then
		return nil
	end
	return ladder[level + 1]
end

local function buildPayload(playerData)
	local payload = {}
	for statName in pairs(LEVEL_KEYS) do
		local cfg = getUpgradeConfig(statName)
		if cfg then
			local level = getLevel(playerData, statName)
			local ladderEntry = robuxLadderEntry(cfg, level)
			payload[statName] = {
				Level = level,
				MaxLevel = cfg.MaxLevel or 0,
				Value = getStatValue(statName, level),
				NextCost1  = costForRange(statName, level, 1),
				NextCost10 = costForRange(statName, level, 10),
				RobuxBulkAmount = cfg.RobuxBulkAmount,
				-- current-level Robux price for the UI's single-buy button
				RobuxPrice1 = ladderEntry and ladderEntry.Price or nil,
			}
		end
	end
	return payload
end

local function pushAttributes(player, playerData)
	for statName, attrName in pairs(ATTRIBUTE_KEYS) do
		local level = getLevel(playerData, statName)
		local value = getStatValue(statName, level)
		player:SetAttribute(attrName, value)
		-- The HUD backpack counter is the rarity-loot capacity
		-- (RarityItemSpawner gates pickups on MaxLootStorage), so the
		-- Storage upgrade must drive it -- not just the legacy MaxStorage.
		if statName == "Storage" then
			player:SetAttribute("MaxLootStorage", value)
		end
	end
end

local function pushUpdate(player, playerData)
	pushAttributes(player, playerData)
	if UpgradeUpdateEvent then
		UpgradeUpdateEvent:FireClient(player, buildPayload(playerData))
	end
end

local function setLevel(player, playerData, statName, newLevel)
	local key = LEVEL_KEYS[statName]
	if not key then
		return
	end
	-- Hard cap at the config MaxLevel: no write path can push a stat (and
	-- therefore storage) past its ceiling, whatever the caller computed.
	local capped = math.max(0, math.floor(newLevel))
	local cfg = getUpgradeConfig(statName)
	if cfg and cfg.MaxLevel then
		capped = math.min(capped, cfg.MaxLevel)
	end
	PlayerDataService.SetStat(player, key, capped)
end

local function buyWithCash(player, playerData, statName, count)
	local cfg = getUpgradeConfig(statName)
	if not cfg then
		return false
	end
	local level = getLevel(playerData, statName)
	local maxLevel = cfg.MaxLevel or 0
	if level >= maxLevel then
		NotEnoughCashEvent:FireClient(player, "Maximum upgrade reached")
		return false
	end
	local effectiveCount = math.min(count, maxLevel - level)
	local totalCost = costForRange(statName, level, effectiveCount)
	if (playerData.Cash or 0) < totalCost then
		NotEnoughCashEvent:FireClient(player)
		return false
	end
	local ok = PlayerDataService.AddStat(player, "Cash", -totalCost)
	if not ok then
		return false
	end
	setLevel(player, playerData, statName, level + effectiveCount)
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

local function buyWithRobux(player, playerData, statName, count, productId)
	local cfg = getUpgradeConfig(statName)
	if not cfg or not productId or productId == 0 then
		return false
	end
	local level = getLevel(playerData, statName)
	local maxLevel = cfg.MaxLevel or 0
	if level >= maxLevel then
		NotEnoughCashEvent:FireClient(player, "Maximum upgrade reached")
		return false
	end
	local okPS, PurchaseService = pcall(require, ServerScriptService.Source.Services.PurchaseService)
	if not okPS or not PurchaseService or not PurchaseService.PromptProduct then
		warn("[UpgradeShopService] PurchaseService unavailable for Robux upgrade")
		return false
	end
	PurchaseService.PromptProduct(player, productId, "Upgrade_" .. statName .. "_" .. count, function(success)
		if not success then
			return
		end
		local data = PlayerDataService.GetPlayerData(player)
		if not data then
			return
		end
		local current = getLevel(data, statName)
		local effectiveCount = math.min(count, maxLevel - current)
		if effectiveCount <= 0 then
			return
		end
		setLevel(player, data, statName, current + effectiveCount)
		PlayerDataService.ScheduleSave(player)
		pushUpdate(player, data)
	end)
	return true
end

local function notifyTutorial(player)
	-- Tutorial removed from the game: nothing to notify on upgrade purchase.
end

local function onBuyUpgrade(player, statName, kind)
	if type(statName) ~= "string" or type(kind) ~= "string" then
		warn(string.format("[UpgradeShopService] BuyUpgrade bad args: %s %s", type(statName), type(kind)))
		return false
	end
	local cfg = getUpgradeConfig(statName)
	if not cfg then
		warn(string.format("[UpgradeShopService] No config for %s", statName))
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		warn(string.format("[UpgradeShopService] No playerData for %s", player.Name))
		return false
	end

	if kind == "Cash1" then
		local success = buyWithCash(player, playerData, statName, 1)
		if success then notifyTutorial(player) end
		return success
	elseif kind == "Cash10" then
		local success = buyWithCash(player, playerData, statName, 10)
		if success then notifyTutorial(player) end
		return success
	elseif kind == "RobuxBulk" then
		local amount = cfg.RobuxBulkAmount or 0
		if amount <= 0 then
			return false
		end
		return buyWithRobux(player, playerData, statName, amount, cfg.RobuxBulkProductId)
	elseif kind == "RobuxSingle" then
		-- ladder stats (Storage/Walkspeed) charge an escalating per-level
		-- product; others keep the single flat product
		local ladderEntry = robuxLadderEntry(cfg, getLevel(playerData, statName))
		local productId = (ladderEntry and ladderEntry.ProductId) or cfg.RobuxSingleProductId
		return buyWithRobux(player, playerData, statName, 1, productId)
	end
	return false
end

local function onRequestUpgradeData(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return nil
	end
	pushAttributes(player, playerData)
	return buildPayload(playerData)
end

function UpgradeShopService.ResetForRebirth(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return
	end
	local changed = false
	for statName, key in pairs(LEVEL_KEYS) do
		local cfg = getUpgradeConfig(statName)
		if cfg and cfg.ResetOnRebirth and (playerData[key] or 0) ~= 0 then
			PlayerDataService.SetStat(player, key, 0)
			changed = true
		end
	end
	if changed then
		PlayerDataService.ScheduleSave(player)
		pushUpdate(player, playerData)
	end
end

local function ensureBaseline(playerData)
	for _, key in pairs(LEVEL_KEYS) do
		if type(playerData[key]) ~= "number" then
			playerData[key] = 0
		end
	end
end

-- Admin console grant (AdminCommandsService "giveupgrade"): bump a stat by
-- N levels for free, capped at the config MaxLevel like every other write
-- path (setLevel clamps). Pushes attributes + the shop payload like a buy.
function UpgradeShopService.GrantLevels(player, statName, count)
	local cfg = getUpgradeConfig(statName)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not cfg or not playerData then
		return false
	end
	ensureBaseline(playerData)
	local level = getLevel(playerData, statName)
	setLevel(player, playerData, statName, level + math.max(1, math.floor(tonumber(count) or 1)))
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

-- Server-initiated Robux upgrade prompt. Used by RarityItemSpawner to offer the
-- Storage upgrade the moment a pickup is blocked by full loot storage. Runs the
-- exact "RobuxSingle" buy path, so it picks the correct escalating ladder product
-- for the player's current level AND grants the level on success. buyWithRobux
-- no-ops (with a "Maximum upgrade reached" message) once the stat is maxed.
function UpgradeShopService.PromptRobuxUpgrade(player, statName)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end
	ensureBaseline(playerData)
	return onBuyUpgrade(player, statName, "RobuxSingle")
end

-- The Walkspeed upgrade writes the "WalkSpeed" attribute (via pushAttributes);
-- these hooks copy it onto the Humanoid on spawn and whenever it changes.
local function applyWalkSpeedToCharacter(player)
	local speed = player:GetAttribute("WalkSpeed")
	if typeof(speed) ~= "number" then
		return
	end
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speed
	end
end

local function hookWalkSpeed(player)
	player:GetAttributeChangedSignal("WalkSpeed"):Connect(function()
		applyWalkSpeedToCharacter(player)
	end)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid", 10)
		local speed = player:GetAttribute("WalkSpeed")
		if humanoid and typeof(speed) == "number" then
			humanoid.WalkSpeed = speed
		end
	end)
	applyWalkSpeedToCharacter(player)
end

function UpgradeShopService.Init()
	ensureRemotes()

	BuyUpgradeFunc.OnServerInvoke = function(player, statName, kind)
		local playerData = PlayerDataService.GetPlayerData(player)
		if playerData then
			ensureBaseline(playerData)
		end
		return onBuyUpgrade(player, statName, kind)
	end
	RequestUpgradeDataFunc.OnServerInvoke = function(player)
		local playerData = PlayerDataService.GetPlayerData(player)
		if playerData then
			ensureBaseline(playerData)
		end
		return onRequestUpgradeData(player)
	end

	PlayerDataService.ProfileLoaded.Event:Connect(function(player)
		local playerData = PlayerDataService.GetPlayerData(player)
		if not playerData then
			return
		end
		ensureBaseline(playerData)
		pushUpdate(player, playerData)
	end)

	for _, plr in ipairs(Players:GetPlayers()) do
		local data = PlayerDataService.GetPlayerData(plr)
		if data then
			ensureBaseline(data)
			pushUpdate(plr, data)
		end
	end

	Players.PlayerAdded:Connect(hookWalkSpeed)
	for _, plr in ipairs(Players:GetPlayers()) do
		hookWalkSpeed(plr)
	end
end

return UpgradeShopService
