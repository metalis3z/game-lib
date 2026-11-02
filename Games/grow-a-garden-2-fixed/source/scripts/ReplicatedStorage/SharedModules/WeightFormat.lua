--credit to quartz games studio
return {
	FormatGrams = function(p1) --[[ FormatGrams | Line: 3 ]]
		return string.format("%.2fkg", math.floor((tonumber(p1) or 0) * 100 + 0.5) / 100)
	end
}