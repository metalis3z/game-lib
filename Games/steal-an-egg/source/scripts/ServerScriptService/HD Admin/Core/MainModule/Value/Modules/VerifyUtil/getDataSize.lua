local HttpService = game:GetService("HttpService")
return function (incomingData): number
	local ok, encoded = pcall(HttpService.JSONEncode, HttpService, incomingData)
	if not ok then
		return math.huge
	end
	return #encoded
end
