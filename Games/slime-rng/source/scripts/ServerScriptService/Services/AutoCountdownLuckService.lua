local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local AutoCountdownLuckService = {}

-- ─── Config ───────────────────────────────────────────────────────────────────
local CONFIG = {
	waitDuration  = 2 * 60,  
	boostDuration = 2 * 60, 

	possibleMultipliers = { 2, 5, 10, 25, 50 },
	multiplierWeights   = {
		[2]  = 40,
		[5]  = 30,
		[10] = 18,
		[25] = 9,
		[50] = 3,
	},
}

local _als = nil
local function getALS()
	if _als then return _als end
	local ok, svc = pcall(function()
		local s = ServerScriptService:FindFirstChild("Services")
		local m = s and s:FindFirstChild("AdminLuckService")
		return m and require(m)
	end)
	if ok and svc then _als = svc end
	return _als
end

local function pickMult(): number
	local total = 0
	for _, m in ipairs(CONFIG.possibleMultipliers) do
		total += CONFIG.multiplierWeights[m] or 1
	end
	local r, cum = math.random() * total, 0
	for _, m in ipairs(CONFIG.possibleMultipliers) do
		cum += CONFIG.multiplierWeights[m] or 1
		if r <= cum then return m end
	end
	return CONFIG.possibleMultipliers[1]
end

local function runLoop()
	task.wait(5) -- let all services init first

	while true do
		print(string.format(
			"[AutoCountdownLuck] Waiting %d minutes before next boost...",
			CONFIG.waitDuration / 60
			))
		task.wait(CONFIG.waitDuration)

		-- ── PHASE 2: Boost active ─────────────────────────────────────────
		local mult = pickMult()
		local als  = getALS()

		if als then
			als:setState(mult, CONFIG.boostDuration, "Auto Event")
			print(string.format(
				"[AutoCountdownLuck] Boost ACTIVE: x%d for %d minutes",
				mult, CONFIG.boostDuration / 60
				))
		else
			warn("[AutoCountdownLuck] AdminLuckService unavailable — skipping boost")
		end

		task.wait(CONFIG.boostDuration)

		if als then
			pcall(function() als:clearState() end)
			print("[AutoCountdownLuck] Boost ended, cleared.")
		end

		task.wait(2) -- small gap before next cycle
	end
end

function AutoCountdownLuckService:init()
	task.spawn(runLoop)
	print("[AutoCountdownLuckService] Initialized — 2min wait / 2min boost cycle")
end

return AutoCountdownLuckService