local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local DataManagement = require(ServerScriptService.Services.DataManagment)
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	local VARIANT_MAP = {
		default = "Default",
		vanilla = "Default",
		none = "Default",
		raw = "Default",
		gold = "Gold",
		diamond = "Diamond",
		rainbow = "Rainbow",
	    yinyang = "YinYang"
	}

	local ALL_VARIANTS = {"Default", "Gold", "Diamond", "Rainbow", "YinYang"}

	Conch.register("unlockindex", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "players",
				name = "Players",
			}, {
				kind = "argument",
				type = "string",
				name = "Variant",
			}
		end,
		callback = function(players, variantStr)
			if not variantStr then
				return false, "You must specify a variant (Default/Rainbow/Gold/Diamond/YinYang/all)"
			end

			variantStr = string.lower(tostring(variantStr))
			local mapped = VARIANT_MAP[variantStr]
			if mapped == nil and not (variantStr == "default" or variantStr == "none" or variantStr == "vanilla") then
				return false, string.format("Unknown variant '%s'", variantStr)
			end

			local unlockVariants = {}
			if mapped == "*" then
				unlockVariants = ALL_VARIANTS
			else
				unlockVariants = {mapped}
			end

			local animalNames = {}
			for name, _ in pairs(Animals) do
				table.insert(animalNames, name)
			end

			local successCount = 0
			local failedPlayers = {}

			for _, player in ipairs(players) do
				if not DataManagement.isDataReady(player) then
					table.insert(failedPlayers, player.Name .. " (data not ready)")
					continue
				end

				for _, animalName in ipairs(animalNames) do
					for _, mut in ipairs(unlockVariants) do
						DataManagement.addToIndex(player, animalName, mut)
					end
				end

				local profile = DataManagement.GetDataMan(player)
				local sync = Synchronizer:Get(player)
				if sync and profile and profile.Data and profile.Data.Index then
					sync:Set("Index", profile.Data.Index)
				end

				successCount = successCount + 1
			end

			local response = string.format("Unlocked index (%s) for %d player(s)", variantStr, successCount)
			if #failedPlayers > 0 then
				response = response .. "\nFailed for: " .. table.concat(failedPlayers, ", ")
			end

			return true, response
		end,
	})

	return module
end

return module