local VerifyUtil = require(script.Parent)
local processMaxSize = require(script.Parent.processMaxSize)
return function (incomingData, customLimit): (boolean, number)
	local limit = customLimit or VerifyUtil.KEY_MAX_CHARACTERS
	return processMaxSize(incomingData, limit)
end