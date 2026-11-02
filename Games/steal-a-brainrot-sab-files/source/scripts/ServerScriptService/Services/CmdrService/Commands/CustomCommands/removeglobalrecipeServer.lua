return function(context, key, jobid)
	if not (context.Executor.UserId == 0 or context.Executor.UserId == 1215597321) then
		return "Unauthorized."
	end

	if not key or key == "" then
		return "Missing key."
	end

	local CraftingMachineService = require(game.ServerScriptService.Services.CraftingMachineService)

	local ok, err = CraftingMachineService:RemoveGlobalStock(key, (jobid and jobid ~= "") and jobid or nil)

	if not ok then
		return "Failed: " .. tostring(err)
	end
	return string.format("Global recipe removed: key=%s", key)
end