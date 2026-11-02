--credit to quartz games studio
local t = {
	"k",
	"m",
	"b",
	"t",
	"q",
	"Qt",
	"Sx",
	"Sp",
	"o",
	"n",
	"d",
	"u",
	"Du",
	"Tr"
}

return function(p1, p2, p3) --[[ FormatAbbreviated | Line: 26 | Upvalues: t (copy) ]]
	assert(if type(p1) == "number" then true else false)
	assert(if p2 == nil then true elseif type(p2) == "number" then true else false)
	assert(if p3 == nil then true elseif type(p3) == "number" then true else false)

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v4 = p2 or 3
	local v8 = math.max(math.abs(p1), (math.pow(10, -#t * 3)))
	local v12 = 10 ^ (math.min(math.ceil((math.log10(v8))), #t * 3 + v4) - (p3 or 0) - v4)
	local v13 = math.round(v8 / v12) * v12
	local v18 = math.min(math.floor(math.log10((math.max(v13, 1))) / 3), #t)
	local v20 = string.format("%f", v13 * math.sign(p1) / 10 ^ (v18 * 3)):gsub("%.?0+$", "")

	if v18 >= 1 then
		return v20 .. t[v18]
	end

	return v20
end