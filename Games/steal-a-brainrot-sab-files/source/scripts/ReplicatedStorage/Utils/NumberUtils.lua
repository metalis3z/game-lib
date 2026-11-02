local SUFFIXES = {
    "", 
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
    "Tvg"
}

return {
  ToString = function(_, value, decimalPlaces)
		if value ~= value then return "NaN" end
		if value == math.huge then return "Infinity" end
		if value == -math.huge then return "-Infinity" end

		decimalPlaces = decimalPlaces or 1
		
		local index = math.floor(math.log(math.max(1, math.abs(value)), 1000))
		
		local suffix = SUFFIXES[index + 1] or ("e+" .. (index * 3))
		
		local shortValue = math.floor(value * (10 ^ decimalPlaces / 1000 ^ index)) / 10 ^ decimalPlaces
		
		return ("%." .. decimalPlaces .. "f"):format(shortValue):gsub("%.?0+$", "") .. suffix
	end,

    Comma = function(_, value)
        local formatted = tostring(value)
        local replacements = -1
        
        while replacements ~= 0 do
            local result, count = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
            formatted = result
            replacements = count
        end
        
        return formatted
    end
}