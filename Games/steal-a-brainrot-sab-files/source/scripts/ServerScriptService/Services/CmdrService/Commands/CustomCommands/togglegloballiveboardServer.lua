
local ServerScriptService = game:GetService("ServerScriptService")

local function getAnimalService()
	return require(ServerScriptService.Services.AnimalService)
end

local FILTERED_ANIMALS = {
	"Strawberry Elephant",
	"John Pork",
	"Meowl",
	"Skibidi Toilet",
}

return function(context, enabled: boolean, jobid: string?)

	local AnimalService = getAnimalService()
	jobid = (jobid and jobid ~= "") and jobid or nil
	local toggleOk = AnimalService.SetGlobalLiveboardFilter(enabled, jobid)
	if not toggleOk then
		return string.format("invalid jobid '%s'.", jobid)
	end

	local animalList = table.concat(FILTERED_ANIMALS, ", ")

	if enabled then
		return string.format(
			"✅ Liveboard filter ENABLED.\n"
				.. "The following animals will no longer appear on the global liveboard:\n"
				.. "  %s\n"
				.. "They can still spawn locally. State saved and synced to all active servers.",
			animalList
		)
	else
		return string.format(
			"✅ Liveboard filter DISABLED.\n"
				.. "All animals (%s and others) will now broadcast globally as normal.\n"
				.. "State saved and synced to all active servers.",
			animalList
		)
	end
end