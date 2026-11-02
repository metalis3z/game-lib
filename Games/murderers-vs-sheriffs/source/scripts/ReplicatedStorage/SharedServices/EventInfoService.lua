local _ = require(
	game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType")
)
local tbl_upv_1 = {}
tbl_upv_1.Initialized = false
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local tbl_upv_6 = {}
function tbl_upv_1.GetMainEvent(a1)
	for _, value_1 in tbl_upv_2 do
		if (value_1.Priority ~= "Main") then
			continue
		end
		return value_1
	end
	return nil
end
function tbl_upv_1.GetActiveEvents(a1)
	return tbl_upv_3
end
function tbl_upv_1.IsEventActive(a1, a2)
	return tbl_upv_3[a2.Title] ~= nil
end
function tbl_upv_1.IsEventTypeActive(a1, a2)
	for _, value_2 in tbl_upv_2 do
		if (value_2.Name ~= a2 or not (tbl_upv_1:IsEventActive(value_2))) then
			continue
		end
		return true
	end
	return false
end
function tbl_upv_1.GetLeaderboardStatus(a1, a2)
	local v1 = math.floor(workspace:GetServerTimeNow())
	local v2 = nil
	local PauseStartTime_1 = a2.EventStartInfo.Leaderboards.Points.PauseStartTime
	local PauseEndTime_1 = a2.EventStartInfo.Leaderboards.Points.PauseEndTime
	local EndTime_1 = a2.EventStartInfo.Leaderboards.Points.EndTime
	local v3 = nil
	if (v1 >= PauseStartTime_1) then
		if (PauseStartTime_1 > v1 or v1 >= PauseEndTime_1) then
			if (PauseEndTime_1 > v1 or v1 > EndTime_1) then
				if (EndTime_1 <= v1) then
					v3, v2 = "ended", 0
				end
			else
				v3, v2 = "endingSoon", EndTime_1 - v1
			end
		else
			v3, v2 = "paused", PauseEndTime_1 - v1
		end
	else
		v3, v2 = "pausingSoon", PauseStartTime_1 - v1
	end
	return v3, v2
end
function tbl_upv_1.IsLeaderboardActive(a1, a2)
	if (not a2.EventStartInfo or not a2.EventStartInfo.Leaderboards) then
		return false
	end
	local v4 = tbl_upv_1:GetLeaderboardStatus(a2)
	if (v4 ~= "pausingSoon" and v4 ~= "endingSoon") then
		return false
	end
	return true
end
function tbl_upv_1.GetTimeElapsedSinceEventStart(a1, a2)
	return (math.max(DateTime.now().UnixTimestamp - a2.EventStartTime, 0))
end
function tbl_upv_1.GetTimeElapsedSinceEventEnd(a1, a2)
	return (math.max(DateTime.now().UnixTimestamp - a2.EventEndTime, 0))
end
function tbl_upv_1.GetTimeUntilEventStart(a1, a2)
	local UnixTimestamp_1 = DateTime.now().UnixTimestamp
	local EventStartTime_1 = a2.EventStartTime
	return (math.clamp(EventStartTime_1 - UnixTimestamp_1, 0, EventStartTime_1))
end
function tbl_upv_1.GetTimeUntilEventEnd(a1, a2)
	local UnixTimestamp_2 = DateTime.now().UnixTimestamp
	local EventEndTime_1 = a2.EventEndTime
	return (math.clamp(EventEndTime_1 - UnixTimestamp_2, 0, EventEndTime_1))
end
function tbl_upv_1.GetEventStatus(a1, a2)
	local UnixTimestamp_3 = DateTime.now().UnixTimestamp
	if (UnixTimestamp_3 >= a2.EventStartTime) then
		if (UnixTimestamp_3 >= a2.EventEndTime) then
			return "Ended"
		end
		return "Active"
	end
	return "NotStarted"
end
function tbl_upv_1.RegisterEvent(a1, a2, a3)
	tbl_upv_2[a2] = a3
end
function tbl_upv_1.GetEvent(a1, a2)
	return tbl_upv_2[a2]
end
function tbl_upv_1.GetRegisteredEvents(a1)
	return tbl_upv_2
end
function tbl_upv_1._StartEvent(a1, a2)
	for _, value_3 in tbl_upv_4 do
		task.spawn(value_3, a2)
	end
	if (a2.Priority == "Main") then
		for _, value_4 in tbl_upv_5 do
			task.spawn(value_4, a2)
		end
	end
	tbl_upv_3[a2.Title] = a2
end
function tbl_upv_1._EndEvent(a1, a2)
	for _, value_5 in tbl_upv_6 do
		task.spawn(value_5, a2)
	end
	tbl_upv_3[a2.Title] = nil
end
function tbl_upv_1.WaitForInitializedAsync(a1)
	while (not (tbl_upv_1.Initialized)) do
		task.wait()
	end
	return tbl_upv_1
end
function tbl_upv_1.OnMainEventStarted(a1, a2)
	tbl_upv_1:WaitForInitializedAsync()
	local v5 = tbl_upv_1:GetMainEvent()
	if (v5) then
		task.spawn(a2, v5)
	end
	table.insert(tbl_upv_5, a2)
end
function tbl_upv_1.OnEventStarted(a1, a2)
	tbl_upv_1:WaitForInitializedAsync()
	for _, value_6 in tbl_upv_2 do
		if (value_6.Status == "Started") then
			task.spawn(a2, value_6)
		end
	end
	table.insert(tbl_upv_4, a2)
end
function tbl_upv_1.OnEventEnded(a1, a2)
	tbl_upv_1:WaitForInitializedAsync()
	for _, value_7 in tbl_upv_2 do
		if (value_7.Status == "Ended") then
			task.spawn(a2, value_7)
		end
	end
	table.insert(tbl_upv_6, a2)
end
return tbl_upv_1