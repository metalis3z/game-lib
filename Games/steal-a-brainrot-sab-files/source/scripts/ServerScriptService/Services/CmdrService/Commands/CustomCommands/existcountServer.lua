local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animals     = require(ReplicatedStorage.Datas.Animals)
local Mutations   = require(ReplicatedStorage.Datas.Mutations)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

local HoverInfoService = require(game:GetService("ServerScriptService").Services.HoverInfoService)

return function(context, animal)
	if not Animals[animal] then
		return ("'%s' is not a valid animal key."):format(animal)
	end

	local displayName = Animals[animal].DisplayName or animal
	local total = HoverInfoService:GetExistCount(animal)

	local output = {
		("🔍 %s Exist Counts:"):format(displayName),
		("━━━━━━━━━━━━━━━━━━━━"),
		("📊 Total: %s"):format(NumberUtils:Comma(total)),
		("")
	}

	local noneCount = HoverInfoService:GetExistCount(animal, "None")
	if noneCount > 0 then
		table.insert(output, ("✨ Normal: %s"):format(NumberUtils:Comma(noneCount)))
	end

	for mutationKey, mutationData in pairs(Mutations) do
		local count = HoverInfoService:GetExistCount(animal, mutationKey)
		if count > 0 then
			table.insert(output, ("✨ %s: %s"):format(mutationKey, NumberUtils:Comma(count)))
		end
	end

	return table.concat(output, "\n")
end