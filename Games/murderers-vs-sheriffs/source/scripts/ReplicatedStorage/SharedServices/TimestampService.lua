local tbl_1 = {}
function tbl_1.GetCurrentDayPST(a1)
	local v1 = DateTime.now()
	local _ = v1:ToUniversalTime()
	local v2 = DateTime.fromUnixTimestamp(v1.UnixTimestamp + -28800):ToUniversalTime()
	return DateTime.fromUniversalTime(v2.Year, v2.Month, v2.Day, 0, 0, 0, 0).UnixTimestamp - -28800
end
function tbl_1.GetCurrentPeriodStartPST(a1, a2, a3)
	local v3 = (a3 or 0) + -28800
	local v4 = v3 - v3 % 86400
	local v5 = DateTime.now().UnixTimestamp + -28800 - v4
	return (v4 + (v5 - (v5 % a2))) - -28800
end
function tbl_1.GetCurrentDayUTC(a1)
	local v6 = DateTime.now():ToUniversalTime()
	return DateTime.fromUniversalTime(v6.Year, v6.Month, v6.Day, 0, 0, 0, 0).UnixTimestamp
end
function tbl_1.FormatTimeLeftInSeconds(a1, a2)
	local v7 = math.floor(a2 / 3600)
	local v8 = math.floor((a2 % 3600) / 60)
	if (v7 <= 0) then
		if (v8 <= 0) then
			return string.format("%ds", a2 % 60)
		end
		return string.format("%dm", v8)
	end
	return string.format("%dh, %dm", v7, v8)
end
function tbl_1.GetTimeLeftText(a1, a2)
	local v9 = math.floor(a2 / 86400)
	local v10 = math.floor((a2 % 86400) / 3600)
	local v11 = math.floor((a2 % 3600) / 60)
	local v12 = math.floor(a2 % 60)
	if (v9 <= 0) then
		if (v10 <= 0) then
			if (v11 <= 0) then
				return (string.format("%ds", v12))
			elseif (v11 > 5) then
				return (string.format("%dm", v11))
			else
				return (string.format("%dm, %ds", v11, v12))
			end
		end
		return (string.format("%dh, %dm", v10, v11))
	end
	return (string.format("%dd, %dh, %dm", v9, v10, v11))
end
function tbl_1.GetLeaderboardTimeText(a1, a2)
	local v13 = math.floor(a2 / 86400)
	local v14 = math.floor((a2 % 86400) / 3600)
	local v15 = v13 .. "d, " .. v14 .. "h"
	if (v13 < 1) then
		local v16 = v14 .. "h"
		if (v14 ~= 1) then
			v15 = v16
		else
			v15 = "Less than 2 hours"
		end
	end
	if (a2 <= 3600) then
		v15 = "Less than 1 hour!"
	end
	if (a2 <= 0) then
		v15 = "ENDED!"
	end
	return v15
end
return tbl_1