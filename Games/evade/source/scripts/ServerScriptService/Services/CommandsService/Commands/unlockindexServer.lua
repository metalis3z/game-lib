local module = function(Conch, Config)
	Conch.register("unlockindex", {
		permissions = { (Config and Config.RequiredRole) or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "players",
					name = "players",
				},
			{
				kind = "argument",
				type = "string",
				name = "variant",
				optional = true,
			}
		end,
		callback = function(players, variantStr)
			-- replicate original unlock-index logic inside Conch callback
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
				candy = "Candy",
				all = "*"
			}

			local ALL_VARIANTS = {"Default", "Gold", "Diamond", "Rainbow", "Candy"}

			if not variantStr then
				return "❌ You must specify a variant (default/rainbow/gold/diamond/all)"
			end

			variantStr = string.lower(tostring(variantStr))
			local mapped = VARIANT_MAP[variantStr]
			if mapped == nil and not (variantStr == "default" or variantStr == "none" or variantStr == "vanilla") then
				return string.format("❌ Unknown variant '%s'", variantStr)
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

			-- Expecting `players` to be a table/array of Player instances (same as your original)
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

			local response = string.format("✅ Unlocked index (%s) for %d player(s)", variantStr, successCount)
			if #failedPlayers > 0 then
				response ..= "\n❌ Failed for: " .. table.concat(failedPlayers, ", ")
			end

			return response
		end,
	})
end

return module
