--!strict
-- LOCATION: ReplicatedStorage/Modules/NumberFormatter

local NumberFormatter = {}

local SUFFIXES = {
	"", "k", "M", "B", "T",
	"Qa", "Qi", "Sx", "Sp", "Oc", "No",
	"Dc", "Ud", "Dd", "Td", "Qad", "Qid", "Sxd", "Spd", "Ocd", "Nod",
	"Vg", "Uvg", "Dvg", "Tvg", "Qavg", "Qivg", "Sxvg", "Spvg", "Ocvg", "Novg",
	"Tg", "Utg", "Dtg", "Ttg", "Qatg", "Qitg", "Sxtg", "Sptg", "Octg", "Notg",
	"Qag", "Uqag", "Dqag", "Tqag", "Qaqag", "Qiqag", "Sxqag", "Spqag", "Ocqag", "Noqag",
	"Qig", "Uqig", "Dqig", "Tqig", "Qaqig", "Qiqig", "Sxqig", "Spqig", "Ocqig", "Noqig",
	"Sxg", "Usxg", "Dsxg", "Tsxg", "Qasxg", "Qisxg", "Sxsxg", "Spsxg", "Ocsxg", "Nosxg",
	"Spg", "Uspg", "Dspg", "Tspg", "Qaspg", "Qispg", "Sxspg", "Spspg", "Ocspg", "Nospg",
	"Ocg", "Uocg", "Docg", "Tocg", "Qaocg", "Qiocg", "Sxocg", "Spocg", "Ococg", "Noocg",
	"Nog", "Unog", "Dnog", "Tnog", "Qanog", "Qinog", "Sxnog", "Spnog", "Ocnog", "Nonog",
	"Ce"
}

function NumberFormatter.Format(n: number): string
	if not n then
		return "0"
	end

	n = math.floor(n)

	if n < 1000 then
		return tostring(n)
	end

	local i = math.floor(math.log(n) / math.log(1000))

	if i >= #SUFFIXES then
		return string.format("%.2e", n)
	end

	local divisor = 1000 ^ i
	local value = n / divisor

	local text
	if value >= 100 then
		text = string.format("%.0f", value)
	elseif value >= 10 then
		text = string.format("%.1f", value)
	else
		text = string.format("%.2f", value)
	end

	text = text:gsub("%.?0+$", "")

	return text .. SUFFIXES[i + 1]
end

return NumberFormatter