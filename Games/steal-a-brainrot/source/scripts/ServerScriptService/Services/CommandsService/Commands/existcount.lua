local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local HoverInfoService = require(ServerScriptService.Services.HoverInfoService)

local module = function(Conch, Config)
	Conch.register("existcount", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "animal",
				}
		end,
		callback = function(animal)
			if not Animals[animal] then
				return false, ("'%s' is not a valid animal key."):format(animal)
			end

			local displayName = Animals[animal].DisplayName or animal
			local total = HoverInfoService:GetExistCount(animal)

			local output = {
				("\xF0\x9F\x94\x8D %s Exist Counts:"):format(displayName),
				("\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81\xE2\x94\x81"),
				("Total: %s"):format(NumberUtils:Comma(total)),
				("")
			}

			local noneCount = HoverInfoService:GetExistCount(animal, "None")
			if noneCount > 0 then
				table.insert(output, ("Normal: %s"):format(NumberUtils:Comma(noneCount)))
			end

			for mutationKey, mutationData in pairs(Mutations) do
				local count = HoverInfoService:GetExistCount(animal, mutationKey)
				if count > 0 then
					table.insert(output, ("%s: %s"):format(mutationKey, NumberUtils:Comma(count)))
				end
			end

			return table.concat(output, "\n")
		end,
	})
end

return module