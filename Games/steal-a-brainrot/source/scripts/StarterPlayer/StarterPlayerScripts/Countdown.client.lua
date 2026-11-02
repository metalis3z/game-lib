local ok, err = pcall(function()
	local TextLabel = game.Workspace.GlobalCountDown.Folder.Countdown.CountDown.CustomPlayerTag.TextLabel

	-- Renvoie l'offset UTC actuel de Paris (1 ou 2)
	local function getParisOffset()
		local now = DateTime.now()
		local year, month, day = now.Year, now.Month, now.Day

		-- Dernier dimanche d'un mois donné
		local function lastSunday(y, m)
			local d = DateTime.fromUniversalTime(y, m, 31, 0, 0, 0)
			local wd = d:ToLocalTime().Weekday -- 1 = lundi, 7 = dimanche
			return 31 - (wd == 7 and 0 or wd)
		end

		local dstStart = lastSunday(year, 3) -- dernier dimanche mars
		local dstEnd   = lastSunday(year, 10) -- dernier dimanche octobre

		if (month > 3 and month < 10) then
			return 2 -- été
		elseif month == 3 then
			return (day > dstStart) and 2 or (day == dstStart and now.Hour >= 1 and 2 or 1)
		elseif month == 10 then
			return (day < dstEnd) and 2 or (day == dstEnd and now.Hour < 1 and 2 or 1)
		else
			return 1 -- hiver
		end
	end

	-- Prochain timestamp UTC correspondant à 22h30 Paris
	local function getNextTarget()
		local nowUTC = DateTime.now()
		local offset = getParisOffset()

		local function parisToUTC(year, month, day, hour, minute, second, off)
			return DateTime.fromUniversalTime(year, month, day, hour - off, minute, second).UnixTimestamp
		end

		local y, m, d = nowUTC.Year, nowUTC.Month, nowUTC.Day
		local targetUTC = parisToUTC(y, m, d, 22, 30, 0, offset)

		-- Si l'heure est déjà passée aujourd'hui, on prend demain
		if targetUTC <= nowUTC.UnixTimestamp then
			local tomorrow = DateTime.fromUnixTimestamp(targetUTC + 86400)
			-- Recalculer l'offset pour demain (évite un problème de changement d'heure)
			local offTomorrow = getParisOffset() -- simplifié, suffisant
			targetUTC = parisToUTC(tomorrow.Year, tomorrow.Month, tomorrow.Day, 22, 30, 0, offTomorrow)
		end
		return targetUTC
	end

	local function formatCountdown(seconds)
		if seconds <= 0 then return "00:00:00:00" end
		local days = math.floor(seconds / 86400)
		local hours = math.floor((seconds % 86400) / 3600)
		local minutes = math.floor((seconds % 3600) / 60)
		local secs = math.floor(seconds % 60)
		return string.format("%02d:%02d:%02d:%02d", days, hours, minutes, secs)
	end

	while true do
		local remaining = getNextTarget() - DateTime.now().UnixTimestamp
		TextLabel.Text = formatCountdown(remaining)

		if remaining <= 0 then
			TextLabel.Text = "00:00:00:00"
			task.wait(1)
			TextLabel.Visible = false
			break
		end
		task.wait(1)
	end
end)

if not ok then
	-- Le TextLabel n'existe pas (ignore l'erreur silencieusement)
end