local AdminUserIds = {
	24029404,
	7652185711,
    --these formats all work:
	-- 123456789,
	-- [123456789] = true,
	-- ["123456789"] = true,
}

local function isAdminUserId(userId)
	local numericUserId = tonumber(userId)
	local stringUserId = tostring(userId)

	if AdminUserIds[numericUserId] == true or AdminUserIds[stringUserId] == true then
		return true
	end

	for _, allowedUserId in pairs(AdminUserIds) do
		if tonumber(allowedUserId) == numericUserId then
			return true
		end
	end

	return false
end

return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		local executor = context.Executor
		if context.Group == "DefaultAdmin" and (not executor or not isAdminUserId(executor.UserId)) then
			return "You don't have permission to run this command"
		end
	end)
end
