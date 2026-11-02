local module = {}
local powers = {}
local abbreviations = {
	"K",
	"M",
	"B",
	"T",
	"Qd"
}

for i = 1, #abbreviations do
	table.insert(powers, 1000^i)
	local function CheckNumber(number)
		if not tonumber(number) then
			return false
		end
		if number ~= number then
			return false
		end
		return true
	end

	function module.FormatWithAbbreviation(number)
		if not CheckNumber(number) then
			return
		end
		local absolute = math.abs(number)
		if absolute < 1000 then
			return tostring(number)
		end
		local power = math.min(math.floor(math.log10(absolute) / 3), #abbreviations)
		local num = math.floor(absolute / powers[power] * 100) / 100
		local formatted = num * math.sign(number) .. abbreviations[power]
		return formatted
	end
end

return module