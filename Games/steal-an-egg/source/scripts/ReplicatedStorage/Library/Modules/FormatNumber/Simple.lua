-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	"K",
	"M",
	"B",
	"T",
	"Qa",
	"Qi",
	"Sx",
	"Sp",
	"Oc",
	"No",
	"Dc",
	"Ud",
	"Dd",
	"Td",
	"Qad",
	"Qid",
	"Sxd",
	"Spd",
	"Ocd",
	"Nod",
	"Vg",
	"Uvg",
	"Dvg",
	"Tvg",
	"Qavg",
	"Qivg",
	"Sxvg",
	"Spvg",
	"Ocvg",
	"Novg",
	"Tg"
}
local Main = require(script.Parent.Main)
local t2 = {}
local t3 = {}
local t4 = {}

function t2.Format(p1, p2) --[[ Format | Line: 45 | Upvalues: t3 (copy), Main (copy) ]]
	assert(if type(p1) == "number" then true else false, "Value provided must be a number")

	if p2 == nil then
		p2 = ""
	end

	assert(if type(p2) == "string" then true else false, "Skeleton provided must be a string")

	local v3 = t3[p2]

	if not v3 then
		local v4, v5 = Main.NumberFormatter.forSkeleton(p2)

		assert(v4, v5)
		t3[p2] = v5
		v3 = v5
	end

	return v3:Format(p1)
end
function t2.FormatCompact(p1, p2) --[[ FormatCompact | Line: 72 | Upvalues: t4 (copy), Main (copy), t (copy) ]]
	assert(if type(p1) == "number" then true else false, "Value provided must be a number")

	if p2 == nil then
		p2 = ""
	end

	assert(if type(p2) == "string" then true else false, "Skeleton provided must be a string")
	assert(#t > 0, "Please provide suffix abbreviations for FormatCompact")

	local absolute = math.abs(p1)
	if p1 ~= p1 then
		return "NaN"
	end
	if absolute == math.huge then
		return tostring(p1)
	end

	-- The imported formatter drops digits for ordinary numbers (45 became 4)
	-- and suffixes for many non-round values. Format every finite value here.
	local suffixIndex = 0
	if absolute >= 1000 then
		suffixIndex = math.clamp(math.floor(math.log(absolute) / math.log(1000)), 1, #t)
	end
	local divisor = 1000 ^ suffixIndex
	local scaled = p1 / divisor
	local _, optionalDecimals = string.gsub(p2, "#", "")
	local decimals = math.clamp(optionalDecimals, 0, 3)
	local roundingPower = 10 ^ decimals
	scaled = math.round(scaled * roundingPower) / roundingPower
	if math.abs(scaled) >= 1000 and suffixIndex < #t then
		suffixIndex += 1
		scaled /= 1000
	end
	local formatted = string.format("%." .. decimals .. "f", scaled)
	if decimals > 0 then
		formatted = string.gsub(formatted, "%.?0+$", "")
	end
	local suffix = if suffixIndex > 0 then t[suffixIndex] else ""
	return formatted .. suffix
end

return table.freeze(t2)