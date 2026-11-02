return {
	A = function(_, totalSeconds)
		totalSeconds = math.ceil(totalSeconds);
		local days = math.floor(totalSeconds / 86400);
		totalSeconds = totalSeconds % 86400;
		local hours = math.floor(totalSeconds / 3600);
		totalSeconds = totalSeconds % 3600;
		local minutes = math.floor(totalSeconds / 60);
		totalSeconds = totalSeconds % 60;
		local result = "";
		if days >= 1 then
			result = result .. ("%*d "):format(days);
		end;
		if days >= 1 or hours >= 1 then
			result = result .. ("%*h "):format(hours);
		end;
		if hours >= 1 or minutes >= 1 then
			result = result .. ("%*m "):format(minutes);
		end;
		if hours <= 0 and minutes <= 0 and days <= 0 then
			result = result .. ("%*s"):format(totalSeconds);
		end;
		return result;
	end, 
	B = function(_, totalSeconds)
		totalSeconds = math.ceil(totalSeconds);
		local days = math.floor(totalSeconds / 86400);
		totalSeconds = totalSeconds % 86400;
		local hours = math.floor(totalSeconds / 3600);
		totalSeconds = totalSeconds % 3600;
		local minutes = math.floor(totalSeconds / 60);
		totalSeconds = totalSeconds % 60;
		local result = "";
		if days >= 1 then
			result = result .. string.format("%d:", days);
		end;
		if days >= 1 or hours >= 1 then
			result = result .. string.format("%02d:", hours);
		end;
		if hours >= 1 or minutes >= 1 or days >= 1 then
			result = result .. string.format("%02d:", minutes);
		end;
		return result .. string.format("%02d", totalSeconds);
	end, 
	C = function(_, totalSeconds)
		totalSeconds = math.max(0, (math.floor((math.ceil(totalSeconds)))));
		return (string.format("%ds", totalSeconds));
	end, 
	D = function(_, totalSeconds)
		totalSeconds = math.max(0, (math.floor((math.ceil(totalSeconds)))));
		local days = math.floor(totalSeconds / 86400);
		totalSeconds = totalSeconds % 86400;
		local hours = math.floor(totalSeconds / 3600);
		totalSeconds = totalSeconds % 3600;
		local minutes = math.floor(totalSeconds / 60);
		totalSeconds = totalSeconds % 60;
		local result = "";
		if days > 0 then
			return ((result .. ("%*d "):format(days)) .. ("%*h "):format(hours)) .. ("%*m"):format(minutes);
		elseif hours > 0 then
			return ((result .. ("%*h "):format(hours)) .. ("%*m "):format(minutes)) .. ("%*s"):format(totalSeconds);
		elseif minutes > 0 then
			return (result .. ("%*m "):format(minutes)) .. ("%*s"):format(totalSeconds);
		else
			return result .. ("%*s"):format(totalSeconds);
		end;
	end, 
	E = function(_, totalSeconds)
		totalSeconds = totalSeconds < 0 and 0 or totalSeconds // 1;
		local days = totalSeconds // 86400;
		totalSeconds = totalSeconds % 86400;
		local hours = totalSeconds // 3600;
		totalSeconds = totalSeconds % 3600;
		local minutes = totalSeconds // 60;
		totalSeconds = totalSeconds % 60;
		local result = "";
		if days > 0 then
			result = result .. ("%*d"):format(days);
			if hours > 0 then
				return result .. (" %*h"):format(hours);
			end;
		elseif hours > 0 then
			result = result .. ("%*h"):format(hours);
			if minutes > 0 then
				return result .. (" %*m"):format(minutes);
			end;
		elseif minutes > 0 then
			result = result .. ("%*m"):format(minutes);
			if totalSeconds > 0 then
				return result .. (" %*s"):format(totalSeconds);
			end;
		else
			result = result .. ("%*s"):format(totalSeconds);
		end;
		return result;
	end
};