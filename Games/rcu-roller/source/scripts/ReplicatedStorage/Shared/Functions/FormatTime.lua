return function(arg1)
	local var2 = arg1
	if var2 < 3600 then
		local mins = math.floor(var2 / 60)
		local secs = var2 % 60
		return string.format("%02i", mins)..':'..string.format("%02i", secs)
	end
	if var2 < 86400 then
		local totalMins = math.floor(var2 / 60)
		local hours = math.floor(totalMins / 60)
		local mins = totalMins % 60
		local secs = var2 % 60
		return string.format("%02i", hours)..':'..string.format("%02i", mins)..':'..string.format("%02i", secs)
	end
	local days = math.floor(var2 / 86400)
	local hours = math.floor((var2 % 86400) / 3600)
	local mins = math.floor((var2 % 3600) / 60)
	local secs = var2 % 60
	return string.format("%02i", days)..':'..string.format("%02i", hours)..':'..string.format("%02i", mins)..':'..string.format("%02i", secs)
end