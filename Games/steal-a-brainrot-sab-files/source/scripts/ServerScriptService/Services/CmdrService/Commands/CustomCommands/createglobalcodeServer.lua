return function(context, code, brainrot, mutation, quantity)
	if not code or code == "" then
		return "Missing code."
	end
	if not brainrot or brainrot == "" then
		return "Missing brainrot."
	end

	local cleanMutation = mutation
	if not cleanMutation or cleanMutation == "" or cleanMutation == "Default" or cleanMutation == "None" then
		cleanMutation = nil
	end

	local cleanQuantity = tonumber(quantity)
	if cleanQuantity ~= nil and cleanQuantity <= 0 then
		cleanQuantity = nil
	end

	local CodesService = require(game:GetService("ServerScriptService").Services.CodesService)

	local ok, err = CodesService.CreateGlobalCode(code, brainrot, cleanMutation, cleanQuantity)
	if not ok then
		return "Failed: " .. tostring(err or "unknown error")
	end

	return string.format(
		"Global code '%s' created ✅  brainrot=%s%s  stock=%s",
		string.upper(code),
		brainrot,
		cleanMutation and ("  mutation=" .. cleanMutation) or "",
		cleanQuantity and tostring(cleanQuantity) or "Unlimited"
	)
end