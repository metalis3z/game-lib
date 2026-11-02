local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)

local UPGRADE_ALIASES = {
	goldenRolls = "cloverRolls",
}

local UPGRADE_COSTS = {
	slots           = { [0]=0, [2]=200,    [3]=500,    [4]=1500,   [5]=5000,   [6]=15000,  [7]=50000   },
	enemyCount      = { [0]=0, [2]=300,    [3]=900,    [4]=2700,   [5]=8100,   [6]=24300,  [7]=72900   },
	enemySpawnSpeed = { [0]=0, [1]=500,    [2]=2000,   [3]=8000                                         },
	slimeTargetRange= { [0]=0, [1]=600,    [2]=2400,   [3]=9600                                         },
	luck            = { [0]=0, [1]=100,    [2]=300,    [3]=1000,   [4]=3000,   [5]=10000,  [6]=30000,
		[7]=100000, [8]=300000, [9]=1000000, [10]=3000000, [11]=10000000,
		[12]=30000000, [13]=100000000, [14]=300000000, [15]=1000000000          },
	rollSpeed       = { [0]=0, [1]=200,    [2]=600,    [3]=2000,   [4]=6000,   [5]=20000,  [6]=60000   },
	cloverRolls     = { [0]=0, [1]=400,    [2]=1200,   [3]=4000,   [4]=12000,  [5]=40000               },
	bonusRolls      = { [0]=0, [1]=800,    [2]=2400,   [3]=8000                                         },
	extraRollChance = { [0]=0, [1]=1000,   [2]=3000,   [3]=10000                                        },
	coinIncome      = { [0]=0, [1]=150,    [2]=450,    [3]=1500,   [4]=4500,   [5]=15000,  [6]=45000,
		[7]=150000, [8]=450000, [9]=1500000, [10]=4500000, [11]=15000000,
		[12]=45000000, [13]=150000000, [14]=450000000, [15]=1500000000          },
	walkSpeed       = { [0]=0, [1]=1000,   [2]=5000,   [3]=20000                                        },
	magnetRadius    = { [0]=0, [1]=500,    [2]=2000,   [3]=8000                                         },
	overkill        = { [0]=0, [1]=500,    [2]=2000,   [3]=8000,   [4]=30000,  [5]=100000, [6]=300000,
		[7]=1000000, [8]=3000000                                                 },
	friendLuck      = { [0]=0, [1]=200,    [2]=600,    [3]=2000,   [4]=6000,   [5]=20000,  [6]=60000,
		[7]=200000, [8]=600000, [9]=2000000                                      },
	friendLuckBoost = { [0]=0, [1]=5000,   [2]=20000,  [3]=80000,  [4]=300000                          },
	goopDropRate    = { [0]=0, [1]=200,    [2]=600,    [3]=2000,   [4]=6000,   [5]=20000,  [6]=60000,
		[7]=200000                                                               },
	offlineLootAmount={ [0]=0, [1]=300,    [2]=1000,   [3]=3000,   [4]=10000,  [5]=30000               },
	bigEnemyChance  = { [0]=0, [1]=2000,   [2]=10000,  [3]=50000                                        },
	shinyEnemyChance= { [0]=0, [1]=5000,   [2]=25000                                                    },
	hugeEnemyChance = { [0]=0, [1]=5000,   [2]=25000                                                    },
	invertedEnemyChance={ [0]=0, [1]=10000, [2]=50000                                                   },
	-- Boolean one-time upgrades (number = cost)
	backpack         = 200,
	autoRoll         = 400,
	goop             = 1000,
	bigSlimes        = 5000,
	hugeSlimes       = 50000,
	shinySlimes      = 20000,
	invertedSlimes   = 200000,
	bigEnemies       = 5000,
	hugeEnemies      = 50000,
	shinyEnemies     = 20000,
	invertedEnemies  = 200000,
	craftingMachine  = 10000,
	xpTransferMachine= 50000,
}

local function getNextLevel(costData, currentLevel)
	local next = math.huge
	for k in pairs(costData) do
		if type(k) == "number" and k > currentLevel and k < next then
			next = k
		end
	end
	return next == math.huge and nil or next
end

local function getUpgradeCost(upgradeId, currentLevel)
	local costData = UPGRADE_COSTS[upgradeId]
	if costData == nil then return nil, nil end
	if type(costData) == "number" then
		return costData, nil
	end
	local nextLevel = getNextLevel(costData, currentLevel)
	if nextLevel == nil then return nil, nil end
	return costData[nextLevel], nextLevel
end

local function parseUpgradeKey(rawKey)
	local aliased = UPGRADE_ALIASES[rawKey]
	if aliased then
		rawKey = aliased
	end

	if UPGRADE_COSTS[rawKey] ~= nil then
		return rawKey, nil
	end

	local bestBase = nil
	local bestLevel = nil

	for baseId in pairs(UPGRADE_COSTS) do
		if type(UPGRADE_COSTS[baseId]) == "table" then
			local baseLen = #baseId
			if string.sub(rawKey, 1, baseLen) == baseId then
				local suffix = string.sub(rawKey, baseLen + 1)
				local level = tonumber(suffix)
				if level ~= nil then
					if bestBase == nil or #baseId > #bestBase then
						bestBase = baseId
						bestLevel = level
					end
				end
			end
		end
	end

	if bestBase then
		return bestBase, bestLevel
	end

	return nil, nil
end

local UpgradeService = {}

function UpgradeService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[UpgradeService] Could not find _remotes")
		return
	end

	local upgradeRemotes = remotes:WaitForChild("UpgradeService", 10)
	if not upgradeRemotes then
		warn("[UpgradeService] Could not find UpgradeService remotes")
		return
	end

	local remoteFunction = upgradeRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[UpgradeService] Invoked - method:", method, "player:", player.Name)
			if method == "requestUnlock"
				or method == "requestPurchaseUpgrade"
				or method == "unlock" then
				return self:requestUnlock(player, ...)
			end
			warn("[UpgradeService] Unknown method:", method)
			return false, nil
		end
		print("[UpgradeService] OnServerInvoke set successfully")
	else
		warn("[UpgradeService] RemoteFunction not found")
	end

	local remoteEvent = upgradeRemotes:FindFirstChild("RemoteEvent")
	if remoteEvent then
		remoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestUnlock"
				or method == "requestPurchaseUpgrade"
				or method == "unlock" then
				self:requestUnlock(player, ...)
			end
		end)
	end

	print("[UpgradeService] Initialized")
end

function UpgradeService:requestUnlock(player: Player, rawUpgradeId: string)
	if type(rawUpgradeId) ~= "string" then
		warn("[UpgradeService] Invalid upgradeId for", player.Name)
		return false, "invalid"
	end

	local data = DataService:waitForData(player)
	if not data then
		warn("[UpgradeService] No data for", player.Name)
		return false, "nodata"
	end

	local tutorialData = data:get("tutorial")
	local upgrades     = data:get("upgrades") or {}

	local baseId, requestedLevel = parseUpgradeKey(rawUpgradeId)

	if baseId == nil then
		warn("[UpgradeService] Unknown upgrade:", rawUpgradeId, "for", player.Name)
		return false, "unknown"
	end

	if not TutorialServiceUtils.canUnlockUpgrade(tutorialData, baseId) then
		warn("[UpgradeService] Tutorial blocked:", baseId, "for", player.Name)
		return false, "tutorial"
	end

	local costData = UPGRADE_COSTS[baseId]
	local isBoolean = type(costData) == "number"
	local currentLevel = 0

	if isBoolean then
		if upgrades[baseId] == true then
			warn("[UpgradeService] Already owns:", baseId, "- resyncing client")
			DataService:set(player, "upgrades", upgrades)
			return false, "owned"
		end
	else
		currentLevel = UpgradeServiceUtils.getUpgradeLevel(baseId, upgrades)

		local maxLevel = 0
		for k in pairs(costData) do
			if type(k) == "number" and k > maxLevel then maxLevel = k end
		end
		if currentLevel >= maxLevel then
			warn("[UpgradeService] Max level:", baseId, "at", currentLevel)
			return false, "maxlevel"
		end
	end

	local cost, nextLevel = getUpgradeCost(baseId, currentLevel)
	if cost == nil then
		warn("[UpgradeService] No cost for:", baseId, "above level", currentLevel)
		return false, "nocost"
	end

	if not isBoolean and requestedLevel ~= nil and requestedLevel ~= nextLevel then
		warn("[UpgradeService] Level mismatch for", baseId,
			"- client wants level", requestedLevel,
			"but next available is", nextLevel, "(proceeding with correct level)")
	end

	local coins = data:get("coins") or 0
	if cost > 0 and coins < cost then
		warn("[UpgradeService] Not enough coins:", coins, "need", cost, "for", baseId)
		return false, "broke"
	end

	if cost > 0 then
		DataService:set(player, "coins", coins - cost)
	end

	local newUpgrades = {}
	for k, v in pairs(upgrades) do
		newUpgrades[k] = v
	end

	local appliedKey

	if isBoolean then
		newUpgrades[baseId] = true
		appliedKey = baseId
		print("[UpgradeService]", player.Name, "unlocked:", baseId, "for", cost, "coins")
	else
		local upgradeKey = baseId .. tostring(nextLevel)
		newUpgrades[upgradeKey] = true
		appliedKey = upgradeKey
		print("[UpgradeService]", player.Name, "upgraded:", upgradeKey,
			"(was level", currentLevel, ") for", cost, "coins")
	end

	DataService:set(player, "upgrades", newUpgrades)

	return true, rawUpgradeId
end

return UpgradeService