local DataStoreService = game:GetService("DataStoreService")
local MonthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local UI = script.Parent
local Leaderboard = UI.Content.Leaderboard
local Ranks = Leaderboard.Ranks

local function SetNewLeader()
	--gets current month
	local dateValue = os.date("!*t")
	local CurrentMonth = MonthNames[dateValue["month"]]
	local CurrentYear = dateValue["year"]
	--Main stuff
	local CurrentMonthLeaderStats
	local s, e = pcall(function()
		CurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
	end)
	if s then
		local s_pages, pages = pcall(function()
			return CurrentMonthLeaderStats:GetSortedAsync(false, 20)
		end)
		if s_pages and pages then
			--print("Loaded Current Month LeaderStats!")
			local data = pages:GetCurrentPage()
			local a = 0
			for _, item	in pairs(data) do
				a += 1
				Ranks[`Rank{tostring(a)}`].PlayerName.Text = item.key
				Ranks[`Rank{tostring(a)}`].XPEarned.Text = item.value
			end
		end
	else
		error(e)
		return
	end
end

SetNewLeader()
while wait(60) do
	SetNewLeader()
end