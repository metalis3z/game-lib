local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server

local BOOST_DURATIONS = {
	luck      = 3600,
	ultraLuck = 3600,
	currency  = 3600,
	rollSpeed = 3600,
}

-- Valid boost kinds
local VALID_BOOST_KINDS = {
	luck      = true,
	ultraLuck = true,
	currency  = true,
	rollSpeed = true,
}

local BoostService = {}

function BoostService:applyBoost(player: Player, boostKind: string, charges: number)
	local data = DataService:waitForData(player)
	if not data then
		warn("[BoostService] applyBoost: no data for", player.Name)
		return false
	end

	local duration = BOOST_DURATIONS[boostKind] or 3600
	local boosts = data:get("boosts") or {}
	local existing = type(boosts[boostKind]) == "table" and boosts[boostKind] or {}

	local currentAmount     = type(existing.amount)        == "number" and existing.amount        or 0
	local currentExpiration = type(existing.expirationTime) == "number" and existing.expirationTime or 0

	local now       = os.time()
	local baseExpiry = math.max(currentExpiration, now)
	local newExpiry  = baseExpiry + (duration * charges)
	local newRemaining = newExpiry - now

	DataService:set(player, { "boosts", boostKind, "amount"         }, currentAmount + charges)
	DataService:set(player, { "boosts", boostKind, "timeRemaining"  }, newRemaining)
	DataService:set(player, { "boosts", boostKind, "expirationTime" }, newExpiry)

	print(string.format(
		"[BoostService] applyBoost '%s': +%d charges | timeRemaining: %ds | expires: %d | player: %s",
		boostKind, charges, newRemaining, newExpiry, player.Name
		))
	return true
end

function BoostService:requestUseBoost(player: Player, boostKind: string)
	print("[BoostService] requestUseBoost:", boostKind, "| player:", player.Name)

	if type(boostKind) ~= "string" or not VALID_BOOST_KINDS[boostKind] then
		warn("[BoostService] Invalid boostKind:", boostKind)
		return false, "Invalid boost"
	end

	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local boosts = data:get("boosts") or {}
	local boostData = boosts[boostKind]

	local parts = {}
	for k, v in pairs(boosts) do
		if type(v) == "table" then
			table.insert(parts, k .. "={amount=" .. tostring(v.amount) .. ",remaining=" .. tostring(v.timeRemaining) .. "}")
		else
			table.insert(parts, k .. "=" .. tostring(v))
		end
	end
	print(string.format("[BoostService] DEBUG boosts for %s: {%s}", player.Name, table.concat(parts, ", ")))

	local currentAmount = 0
	if type(boostData) == "table" then
		currentAmount = type(boostData.amount) == "number" and boostData.amount or 0
	elseif type(boostData) == "number" then
		if boostData > 0 then
			print("[BoostService] Boost", boostKind, "already active (legacy format) for", player.Name)
			return true
		end
		return false, "No boosts available"
	end

	if currentAmount <= 0 then
		warn("[BoostService] Player", player.Name, "has no charges for boostKind:", boostKind,
			"| boostData:", tostring(boostData))
		return false, "No boosts available"
	end

	local duration = BOOST_DURATIONS[boostKind] or 3600
	local now       = os.time()
	local existing  = type(boostData) == "table" and boostData or {}
	local currentExpiration = type(existing.expirationTime) == "number" and existing.expirationTime or 0

	local baseExpiry  = math.max(currentExpiration, now)
	local newExpiry   = baseExpiry + duration
	local newRemaining = newExpiry - now
	local newAmount   = currentAmount - 1

	DataService:set(player, { "boosts", boostKind, "amount"         }, newAmount)
	DataService:set(player, { "boosts", boostKind, "timeRemaining"  }, newRemaining)
	DataService:set(player, { "boosts", boostKind, "expirationTime" }, newExpiry)

	print(string.format(
		"[BoostService] Used boost '%s' for %s | charges remaining: %d | active for %ds (expires %d)",
		boostKind, player.Name, newAmount, newRemaining, newExpiry
		))
	return true
end

function BoostService:getBoostTimeRemaining(player: Player, boostKind: string)
	local data = DataService:waitForData(player)
	if not data then return 0 end
	local boosts = data:get("boosts") or {}
	local boostData = boosts[boostKind]
	if type(boostData) == "table" then
		local expiry = type(boostData.expirationTime) == "number" and boostData.expirationTime or 0
		return math.max(expiry - os.time(), 0)
	elseif type(boostData) == "number" then
		-- Legacy flat format
		return math.max(boostData, 0)
	end
	return 0
end

local function tickBoosts()
	while true do
		task.wait(1)
		local now = os.time()
		for _, player in ipairs(Players:GetPlayers()) do
			local data = DataService:waitForData(player)
			if data then
				local boosts = data:get("boosts") or {}
				local changed = false
				local newBoosts = table.clone(boosts)

				for kind, boostData in pairs(newBoosts) do
					if type(boostData) == "table" then
						local expiry = type(boostData.expirationTime) == "number" and boostData.expirationTime or 0
						local remaining = math.max(expiry - now, 0)
						if remaining ~= (boostData.timeRemaining or 0) then
							newBoosts[kind] = table.clone(boostData)
							newBoosts[kind].timeRemaining = remaining
							changed = true
						end
					elseif type(boostData) == "number" and boostData > 0 then
						local newVal = math.max(boostData - 1, 0)
						if newVal ~= boostData then
							newBoosts[kind] = newVal > 0 and newVal or nil
							changed = true
						end
					end
				end

				if changed then
					DataService:set(player, "boosts", newBoosts)
				end
			end
		end
	end
end

function BoostService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[BoostService] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("BoostService", 10)
	if not svcRemotes then
		warn("[BoostService] BoostService remotes not found")
		return
	end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			print("[BoostService] Invoked:", method, "| player:", player.Name)
			if method == "requestUseBoost" then
				return self:requestUseBoost(player, ...)
			elseif method == "getBoostTimeRemaining" then
				return self:getBoostTimeRemaining(player, ...)
			end
			warn("[BoostService] Unknown method:", method)
			return false, "unknown"
		end
		print("[BoostService] OnServerInvoke set")
	else
		warn("[BoostService] RemoteFunction not found")
	end

	task.spawn(tickBoosts)

	print("[BoostService] Initialized")
end

return BoostService