-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/PodiumService.lua  (1970 lines)
-- What it does: Offline cash = income per second x offline seconds (capped at 12h) x boosts x a 1/6 offline rate, a gamepass multiplier and auto-collect, a 'measured earning pace' fallback, a claim-all popup endpoint, and LastLogin bookkeeping on join/leave.
-- Excerpt of lines 209-318, 1266-1354, 1805-1840, 1934-1950 (only the relevant part of a bigger script).

local OFFLINE_DEFAULT_MAX_SECONDS = 12 * 60 * 60
-- Offline earnings = 1/6 of the live online rate per user request "6x less".
-- Override per-place by setting GameConfig.OfflineCash.IncomeRate.
local OFFLINE_DEFAULT_INCOME_RATE = 1 / 6

local function calcOfflineCash(player, playerData)
	local lastLogin = playerData.LastLogin or 0
	if lastLogin <= 0 then return nil end

	local now = os.time()
	local offlineSeconds = now - lastLogin
	if offlineSeconds <= 60 then return nil end

	local offlineCfg = GameConfig.OfflineCash or {}
	local maxSeconds = offlineCfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local rebirthMult = RebirthService.GetCashMultiplier(player)
	local boostMult = CashBoostService.GetMultiplier(player)
	local offlineRate = offlineCfg.IncomeRate or OFFLINE_DEFAULT_INCOME_RATE

	-- x5Offline gamepass: bonus multiplier applied only to offline accumulation.
	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	local placed = playerData.PlacedBrainrot
	if not placed then return nil end

	local result = {}
	local hasAny = false
	local best = getBestOwnedCps(playerData)

	for key, entry in pairs(placed) do
		local podiumIndex = tonumber(key)
		if not podiumIndex then continue end

		local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, best)
		local cps = getCashPerSec(baseCps, entry.Level or 1)
		local amount = math.floor(cps * offlineSeconds * rebirthMult * boostMult * offlineRate * offlinePassMult)

		if amount > 0 then
			result[podiumIndex] = amount
			hasAny = true
		end
	end

	if not hasAny then return nil end
	return result
end

-- Offline strength for the Earnings popup: the player is treated as clicking
-- GameConfig.OfflineStrength.ClicksPerSecond times per second at their live
-- per-click value (same formula as StrengthClickServer: (1 + drill Power) *
-- trail boost * rebirth multiplier * x2 pass). Reads the mirrored attributes,
-- so it must run a beat AFTER ProfileLoaded (see the task.delay in Init).
local function calcOfflineStrength(player, offlineSeconds)
	local cfg = GameConfig.OfflineStrength or {}
	if offlineSeconds < (cfg.MinOfflineSeconds or 10) then return 0 end
	local clicksPerSec = cfg.ClicksPerSecond or 1
	local maxSeconds = cfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local perClick = (1 + math.max(tonumber(player:GetAttribute("DrillPower")) or 0, 0))
		* math.max(tonumber(player:GetAttribute("TrailBoost")) or 1, 1)
		* math.max(tonumber(player:GetAttribute("StrengthMultiplier")) or 1, 1)
		* math.max(tonumber(player:GetAttribute("StrengthLadderMult")) or 1, 1)

	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	return math.floor(perClick * clicksPerSec * offlineSeconds * offlinePassMult)
end

-- Flat offline cash: the player's measured earning pace (OfflineCashRate,
-- saved on leave from the session's TotalCash delta) * offline time *
-- RateFraction. The x5Offline gamepass multiplies it like podium cash.
local function calcOfflineFlatCash(player, playerData, offlineSeconds)
	local cfg = GameConfig.OfflineCash or {}
	if offlineSeconds < (cfg.MinOfflineSeconds or 10) then return 0 end
	local rate = tonumber(playerData.OfflineCashRate) or 0
	if rate <= 0 then
		-- No session-measured rate yet (fresh profile, or every prior session
		-- was too short to save one). Fall back to the LIFETIME average earning
		-- pace -- available on any profile that has earned cash and logged
		-- playtime, so the money row works on the very first rejoin. The
		-- MinSessionSeconds floor keeps a tiny playtime from spiking the rate.
		local totalCash = tonumber(playerData.TotalCash) or 0
		local playtime = math.max(tonumber(playerData.TotalPlaytime) or 0, cfg.MinSessionSeconds or 120)
		if totalCash > 0 then
			rate = totalCash / playtime
		end
	end
	if rate <= 0 then return 0 end
	local maxSeconds = cfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	return math.floor(rate * offlineSeconds * (cfg.RateFraction or 1 / 100) * offlinePassMult)
end

-- ... (lines 319-1265 skipped) ...

local function autoCollectOfflineIfOwned(plr)
	if plr:GetAttribute("OwnsGamepass_AutoCollect") ~= true then return end
	local pending = offlineCashPending[plr]
	if not pending then return end

	local total = 0
	for podiumIndex, amount in pairs(pending) do
		local rounded = math.floor(amount or 0)
		if rounded > 0 then total = total + rounded end
		pending[podiumIndex] = nil
		OfflineCashEvent:FireClient(plr, podiumIndex, 0)
	end

	if total > 0 then
		PlayerDataService.AddStat(plr, "Cash", total)
		LeaderboardService.AddTotalCash(plr, total)
		offlineCashAutoCredited[plr] = (offlineCashAutoCredited[plr] or 0) + total
		-- keep auto-credited offline cash out of the session-rate measurement
		local rec = sessionEarnStart[plr]
		if rec then rec.totalCash = rec.totalCash + total end
	end
end

-- Aggregate query for the OfflineReward popup: sums every podium's pending
-- offline cash into one number for the "You earned $X while offline" UI.
local function onRequestOfflineTotal(player)
	local strength = math.floor(offlineStrengthPending[player] or 0)
	local total = (offlineFlatCashPending[player] or 0) + (offlineCashAutoCredited[player] or 0)
	local pending = offlineCashPending[player]
	if pending then
		for _, amount in pairs(pending) do
			total = total + (amount or 0)
		end
	end
	return math.floor(total), strength
end

-- Claim-all endpoint for the OfflineReward popup's single Claim button.
-- Credits every pending podium amount, zeroes the per-podium events so the
-- per-pad floating labels disappear, and returns the total credited.
local function onCollectAllOfflineCash(player)
	local strength = math.floor(offlineStrengthPending[player] or 0)
	offlineStrengthPending[player] = nil
	-- AutoCollect already credited this slice at join: it counts toward the
	-- returned/displayed cash but is never granted a second time.
	local auto = math.floor(offlineCashAutoCredited[player] or 0)
	offlineCashAutoCredited[player] = nil
	local flat = math.floor(offlineFlatCashPending[player] or 0)
	offlineFlatCashPending[player] = nil

	local pending = offlineCashPending[player]
	if not pending and strength <= 0 and auto <= 0 and flat <= 0 then return false, 0, 0 end

	local total = 0
	if pending then
		for podiumIndex, amount in pairs(pending) do
			total = total + (amount or 0)
			-- Tell every nearby client (and the owner) the per-pad amount is gone
			-- so PodiumController's OfflineRewardLabel hides cleanly.
			local idx = tonumber(podiumIndex) or podiumIndex
			OfflineCashEvent:FireClient(player, idx, 0)
		end
		offlineCashPending[player] = {}
	end
	local rounded = math.floor(total) + flat
	if rounded > 0 then
		PlayerDataService.AddStat(player, "Cash", rounded)
		LeaderboardService.AddTotalCash(player, rounded)
		-- Offline grants must not count as "earned this session": the next
		-- session's OfflineCashRate would otherwise include them and compound.
		local rec = sessionEarnStart[player]
		if rec then rec.totalCash = rec.totalCash + rounded end
	end

	-- Offline strength rides the same Claim: granted through StrengthClickServer's
	-- GrantStrength bindable so XP / levels / profile write-through behave exactly
	-- like the training pads' grants.
	if strength > 0 then
		local strengthScript = ServerScriptService:FindFirstChild("StrengthClickServer")
		local grant = strengthScript and strengthScript:FindFirstChild("GrantStrength")
		if grant then
			grant:Fire(player, strength)
		else
			strength = 0
		end
	end

	return true, rounded + auto, strength
end

-- ... (lines 1355-1804 skipped) ...

	PlayerDataService.ProfileLoaded.Event:Connect(function(plr)
		accumulatedCash[plr] = {}

		local playerData = PlayerDataService.GetPlayerData(plr)
		if playerData then
			playerData.EquippedItem = ""
			PlayerDataService.DataChanged:Fire(plr, "EquippedItem", "")

			-- Captured BEFORE LastLogin is overwritten below; the Earnings popup's
			-- strength amount is computed from it a beat later (see task.delay).
			local offlineSeconds = 0
			if (playerData.LastLogin or 0) > 0 then
				offlineSeconds = math.max(os.time() - playerData.LastLogin, 0)
			end

			-- Rejoin-only join popups: the daily-reward auto-open (client) keys
			-- off this attribute; a first-ever session shows NO popups on join.
			plr:SetAttribute("IsRejoin", (playerData.LastLogin or 0) > 0)
			sessionEarnStart[plr] = { totalCash = playerData.TotalCash or 0, clock = os.clock() }

			local okOffline, offlineTable = pcall(calcOfflineCash, plr, playerData)
			if okOffline and offlineTable then
				offlineCashPending[plr] = offlineTable
				-- The popup is the ONLY way to claim offline cash -- we intentionally
				-- do NOT call OfflineCashEvent:FireClient per podium here, so the
				-- per-pad "Offline Cash: $X" floating labels never appear and the
				-- player can't double-collect by walking onto each pad after using
				-- the popup. AutoCollect still works for that gamepass.
				autoCollectOfflineIfOwned(plr)
			elseif not okOffline then
				warn(string.format("[PodiumService] calcOfflineCash failed for %s: %s", plr.Name, tostring(offlineTable)))
			end
			playerData.LastLogin = os.time()

			-- Earnings popup: fire cash + strength together one beat later, so
			-- DrillShopService / TrailShopService / RebirthService have mirrored the

-- ... (lines 1841-1933 skipped) ...

	Players.PlayerRemoving:Connect(function(plr)

		local playerData = getPlayerData(plr)
		if playerData then
			playerData.LastLogin = os.time()
			-- Save this session's earning pace for the next join's offline cash
			-- (see GameConfig.OfflineCash). Short sessions keep the previous
			-- rate -- a 30s hop shouldn't wipe a real measurement.
			local rec = sessionEarnStart[plr]
			local cfg = GameConfig.OfflineCash or {}
			if rec then
				local seconds = os.clock() - rec.clock
				if seconds >= (cfg.MinSessionSeconds or 120) then
					local earned = math.max((playerData.TotalCash or 0) - rec.totalCash, 0)
					playerData.OfflineCashRate = earned / seconds
				end
			end
