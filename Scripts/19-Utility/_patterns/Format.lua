--[[
	Format  (ModuleScript, shared: use it on server and client)

	Every number/time formatter a simulator UI needs, in one place.

	  Format.Abbreviate(1234567)          -> "1.23M"   (rounds, adaptive decimals)
	  Format.Abbreviate(1999, true)       -> "1.99K"   (truncate: never shows more than you have)
	  Format.Commas(1234567.5)            -> "1,234,567"
	  Format.Clock(3725)                  -> "1:02:05"   Format.Clock(65) -> "01:05"
	  Format.Short(93784)                 -> "1d 2h 3m"  (largest 3 units)
	  Format.Long(3725)                   -> "1 hour, 2 minutes"
	  Format.Ago(os.time() - 300)         -> "5 minutes ago"
	  Format.Percent(0.1234)              -> "12.3%"
	  Format.Odds(0.0004)                 -> "1 in 2.5K"
	  Format.Parse("2.5M")                -> 2500000   (for admin input / text boxes)
	  Format.Ordinal(22)                  -> "22nd"

	Credit: needoh-escape NumberFormatter (adaptive 0/1/2 decimals, trailing-zero strip, %.2e
	fallback, long suffix list), rcu-roller Suffixes (truncating floor so 1999 never shows "2K"),
	punching-simulator NumberUtility (commas via reverse+gsub, colon/short/long timers),
	drill-and-mine FormatUtils and LeaderboardService (playtime "1d 2h"), needoh-escape
	LeaderboardController (time strings), slime-rng ("1/" .. odds display idea).
]]

local Format = {}

local SUFFIXES = {
	"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No",
	"Dc", "Ud", "Dd", "Td", "Qad", "Qid", "Sxd", "Spd", "Ocd", "Nod",
	"Vg", "Uvg", "Dvg", "Tvg", "Qavg", "Qivg", "Sxvg", "Spvg", "Ocvg", "Novg",
	"Tg", "Utg", "Dtg",
}
Format.Suffixes = SUFFIXES

local function stripZeros(text)
	return (text:gsub("(%..-)0+$", "%1"):gsub("%.$", ""))
end

-- truncate = true floors instead of rounding (use for money the player owns).
function Format.Abbreviate(value, truncate)
	value = tonumber(value) or 0
	if value ~= value then
		return "NaN"
	end
	if value == math.huge or value == -math.huge then
		return if value > 0 then "inf" else "-inf"
	end
	local sign = if value < 0 then "-" else ""
	value = math.abs(value)
	if value < 1000 then
		return sign .. tostring(math.floor(value))
	end

	local tier = math.floor(math.log10(value) / 3)
	if tier + 1 > #SUFFIXES then
		return sign .. string.format("%.2e", value)
	end
	local scaled = value / 10 ^ (tier * 3)
	local decimals = if scaled >= 100 then 0 elseif scaled >= 10 then 1 else 2

	local text
	if truncate then
		local factor = 10 ^ decimals
		text = string.format("%." .. decimals .. "f", math.floor(scaled * factor) / factor)
	else
		text = string.format("%." .. decimals .. "f", scaled)
		if tonumber(text) >= 1000 and SUFFIXES[tier + 2] then
			-- 999.95K rounds to "1000K": move up a suffix instead.
			tier += 1
			text = "1"
		end
	end
	return sign .. stripZeros(text) .. SUFFIXES[tier + 1]
end

function Format.Commas(value)
	value = math.floor(tonumber(value) or 0)
	local sign = if value < 0 then "-" else ""
	local digits = string.format("%.0f", math.abs(value))
	local withCommas = digits:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return sign .. (withCommas:gsub("^,", ""))
end

function Format.Clock(seconds)
	seconds = math.max(0, math.floor(tonumber(seconds) or 0))
	local hours = seconds // 3600
	local minutes = (seconds % 3600) // 60
	local secs = seconds % 60
	if hours > 0 then
		return string.format("%d:%02d:%02d", hours, minutes, secs)
	end
	return string.format("%02d:%02d", minutes, secs)
end

local UNITS = {
	{ 86400, "d", "day" },
	{ 3600, "h", "hour" },
	{ 60, "m", "minute" },
	{ 1, "s", "second" },
}

-- "1d 2h 3m" - at most maxParts units, skipping zero units.
function Format.Short(seconds, maxParts)
	seconds = math.max(0, math.floor(tonumber(seconds) or 0))
	maxParts = maxParts or 3
	local parts = {}
	for _, unit in ipairs(UNITS) do
		local amount = seconds // unit[1]
		if amount > 0 then
			seconds -= amount * unit[1]
			table.insert(parts, amount .. unit[2])
			if #parts >= maxParts then
				break
			end
		end
	end
	return if #parts > 0 then table.concat(parts, " ") else "0s"
end

-- "1 hour, 2 minutes" - at most maxParts units.
function Format.Long(seconds, maxParts)
	seconds = math.max(0, math.floor(tonumber(seconds) or 0))
	maxParts = maxParts or 2
	local parts = {}
	for _, unit in ipairs(UNITS) do
		local amount = seconds // unit[1]
		if amount > 0 then
			seconds -= amount * unit[1]
			table.insert(parts, amount .. " " .. unit[3] .. (if amount == 1 then "" else "s"))
			if #parts >= maxParts then
				break
			end
		end
	end
	return if #parts > 0 then table.concat(parts, ", ") else "0 seconds"
end

function Format.Ago(timestamp)
	local delta = os.time() - (tonumber(timestamp) or 0)
	if delta < 60 then
		return "just now"
	end
	return Format.Long(delta, 1) .. " ago"
end

function Format.Percent(fraction, decimals)
	local text = string.format("%." .. (decimals or 1) .. "f", (tonumber(fraction) or 0) * 100)
	return stripZeros(text) .. "%"
end

-- Chance (0..1) as "1 in N", the way RNG games show rarity.
function Format.Odds(chance)
	chance = tonumber(chance) or 0
	if chance <= 0 then
		return "never"
	end
	if chance >= 1 then
		return "always"
	end
	local oneIn = 1 / chance
	return "1 in " .. (if oneIn < 1000 then stripZeros(string.format("%.1f", oneIn)) else Format.Abbreviate(oneIn))
end

-- Reverse of Abbreviate for typed input: "2.5m", "1,000", "3K" -> number (nil if invalid).
function Format.Parse(text)
	if type(text) ~= "string" then
		return nil
	end
	text = text:gsub(",", ""):gsub("%s", "")
	local number, suffix = text:match("^(-?[%d%.]+)(%a*)$")
	number = tonumber(number)
	if not number then
		return nil
	end
	if suffix == "" then
		return number
	end
	suffix = string.lower(suffix)
	for index, name in ipairs(SUFFIXES) do
		if string.lower(name) == suffix then
			return number * 10 ^ ((index - 1) * 3)
		end
	end
	return nil
end

function Format.Ordinal(n)
	n = math.floor(tonumber(n) or 0)
	local lastTwo = n % 100
	local suffix = "th"
	if lastTwo < 11 or lastTwo > 13 then
		local last = n % 10
		suffix = if last == 1 then "st" elseif last == 2 then "nd" elseif last == 3 then "rd" else "th"
	end
	return n .. suffix
end

return Format
