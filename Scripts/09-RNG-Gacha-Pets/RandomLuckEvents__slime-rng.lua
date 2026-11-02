-- Game: slime-rng
-- Original: ServerScriptService/Services/AutoLuckService.lua
-- What it does: Every 5-10 minutes picks a weighted luck multiplier (x2 common ... x50 rare) and turns on a 5 minute server luck event through the admin luck service.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- ─── Config ───────────────────────────────────────────────────────────────────

local CONFIG = {
	eventDuration = 5 * 60, -- 5 minutes

	minWaitBetween = 5 * 60,  -- 5 minutes
	maxWaitBetween = 10 * 60, -- 10 minutes

	possibleMultipliers = { 2, 5, 10, 25, 50 },

	multiplierWeights = {
		[2]  = 40, -- very common event
		[5]  = 30, -- common
		[10] = 18, -- uncommon
		[25] = 9,  -- rare
		[50] = 3,  -- very rare
	},
}

local _adminLuckService = nil
local function getAdminLuckService()
	if _adminLuckService then return _adminLuckService end
	local ok, svc = pcall(function()
		local services = ServerScriptService:FindFirstChild("Services")
		local mod = services and services:FindFirstChild("AdminLuckService")
		return mod and require(mod)
	end)
	if ok and svc then
		_adminLuckService = svc
		print("[AutoLuckService] AdminLuckService linked")
	else
		warn("[AutoLuckService] Could not link AdminLuckService")
	end
	return _adminLuckService
end

local function pickRandomMultiplier(): number
	local totalWeight = 0
	for _, mult in ipairs(CONFIG.possibleMultipliers) do
		totalWeight += (CONFIG.multiplierWeights[mult] or 1)
	end

	local r = math.random() * totalWeight
	local cumulative = 0
	for _, mult in ipairs(CONFIG.possibleMultipliers) do
		cumulative += (CONFIG.multiplierWeights[mult] or 1)
		if r <= cumulative then
			return mult
		end
	end
	return CONFIG.possibleMultipliers[1]
end

local function formatTime(seconds: number): string
	local m = math.floor(seconds / 60)
	local s = seconds % 60
	if m > 0 then
		return string.format("%dm %ds", m, s)
	end
	return string.format("%ds", s)
end

local AutoLuckService = {}

local isRunning = false

local function runLoop()
	task.wait(30)

	while isRunning do
		local waitTime = math.random(CONFIG.minWaitBetween, CONFIG.maxWaitBetween)
		print(string.format(
			"[AutoLuckService] Next event in %s",
			formatTime(waitTime)
			))
		task.wait(waitTime)

		if not isRunning then break end

		local mult = pickRandomMultiplier()
		local dur  = CONFIG.eventDuration

		local als = getAdminLuckService()
		if not als then
			warn("[AutoLuckService] AdminLuckService not available, skipping event")
			task.wait(60)
			continue
		end

		als:setState(mult, dur, "Auto Event")

		print(string.format(
			"[AutoLuckService] 🍀 Event started! x%d luck for %s",
			mult, formatTime(dur)
			))

		task.wait(dur)

		if not isRunning then break end

		local ok = pcall(function() als:clearState() end)
		if ok then
			print("[AutoLuckService] Event ended, luck cleared")
		end

		task.wait(5)
	end

	print("[AutoLuckService] Loop stopped")
end

function AutoLuckService:init()
	if isRunning then
		warn("[AutoLuckService] Already running")
		return
	end

	isRunning = true
	task.spawn(runLoop)

	print(string.format(
		"[AutoLuckService] Initialized | events every %s-%s | duration: %s | multipliers: x%s",
		formatTime(CONFIG.minWaitBetween),
		formatTime(CONFIG.maxWaitBetween),
		formatTime(CONFIG.eventDuration),
		table.concat(CONFIG.possibleMultipliers, "/x")
		))
end

function AutoLuckService:stop()
	isRunning = false
	local als = getAdminLuckService()
	if als then pcall(function() als:clearState() end) end
	print("[AutoLuckService] Stopped")
end

return AutoLuckService
