local VerifyUtil = require(script.Parent)
local HttpService = game:GetService("HttpService")
return function (incomingData, customLimit): (boolean, number)
	local limit = customLimit or VerifyUtil.KEY_MAX_CHARACTERS*2
	local success, result = pcall(function()
		return HttpService:JSONEncode(incomingData)
	end)
	if success and result then
		local size = #result
		if size <= limit then
			return true, size
		else
			return false, size
		end
	end
	return false, 0
end