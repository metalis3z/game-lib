-- The daily reset at 00:00 UTC, for players who join on a new day and for those online
-- when it ticks over: login reward claimable again, daily counters to zero, a fresh daily
-- shop and new daily tasks (TaskService.NewDay, which also keeps or breaks the task streak).
-- data.LastDailyReset holds the day number (os.time() // 86400) it last ran for.

local Players = game:GetService("Players")

local PlayerDataService = require(script.Parent.PlayerDataService)
local TaskService = require(script.Parent.TaskService)
local ShopService = require(script.Parent.ShopService)

local DAY = 86400
local CHECK_SECONDS = 15

local DAILY_DEFAULTS = {
	ClaimedLoginRewardToday = false,
	DailyShopRefreshesToday = 0,
	DailyShopSeedShift = 0,
	NumFreeWeaponTrialsFromVideoAdsToday = 0,
	BillboardVideoAdClaimedToday = 0,
	WinsFromDuelPadsToday = 0,
}

local DailyService = {}

function DailyService.Check(player: Player)
	local data = PlayerDataService.Get(player)
	if not data then
		return
	end

	local today = os.time() // DAY
	local last = data.LastDailyReset or 0
	if last == today then
		return
	end

	data.LastDailyReset = today
	for field, value in DAILY_DEFAULTS do
		PlayerDataService.Set(player, field, value)
	end

	-- A first-ever reset (last == 0) is not a missed day.
	TaskService.NewDay(player, last ~= 0 and today - last > 1)
	ShopService.PushDaily(player)
end

function DailyService.Start()
	PlayerDataService.Loaded:Connect(DailyService.Check)

	task.spawn(function()
		while true do
			task.wait(CHECK_SECONDS)
			for _, player in Players:GetPlayers() do
				task.spawn(DailyService.Check, player)
			end
		end
	end)
end

return DailyService
