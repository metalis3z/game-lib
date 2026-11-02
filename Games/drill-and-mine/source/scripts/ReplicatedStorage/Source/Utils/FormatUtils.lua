local FormatUtils = {}

function FormatUtils.FormatNumber(number)
	if not number then return "0" end
	local s = tostring(number)
	local len = #s
	local result = ""
	for i = 1, len do
		local c = s:sub(len - i + 1, len - i + 1)
		result = c .. result
		if i % 3 == 0 and i < len then
			result = "," .. result
		end
	end
	return result
end

function FormatUtils.FormatTime(seconds)
	if seconds < 0 then seconds = 0 end
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = math.floor(seconds % 60)

	if hours > 0 then
		return string.format("%d:%02d:%02d", hours, minutes, secs)
	else
		return string.format("%02d:%02d", minutes, secs)
	end
end

function FormatUtils.Abbreviate(number)
	if not number or number == 0 then return "0" end
	if number < 0 then return "-" .. FormatUtils.Abbreviate(-number) end
	if number < 1000 then
		return tostring(math.floor(number))
	end

	local suffixes = {"k", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No",
		"Dc", "Ud", "Dd", "Td", "Qad", "Qnd", "Sxd", "Spd", "Ocd", "Nod",
		"Vg", "Uvg", "Dvg", "Tvg", "Qavg", "Qnvg", "Sxvg", "Spvg", "Ocvg", "Novg",
		"Tg", "Utg", "Dtg", "Ttg", "Qatg", "Qntg", "Sxtg", "Sptg", "Octg", "Notg",
		"Qag", "Uqag", "Dqag", "Tqag", "Qaqag", "Qnqag", "Sxqag", "Spqag", "Ocqag", "Noqag"}
	local magnitude = math.floor(math.log10(number) / 3)
	magnitude = math.min(magnitude, #suffixes)

	if magnitude == 0 then
		return tostring(math.floor(number))
	end

	local divisor = 10 ^ (magnitude * 3)
	local shortened = number / divisor

	return string.format("%.1f%s", shortened, suffixes[magnitude])
end

return FormatUtils