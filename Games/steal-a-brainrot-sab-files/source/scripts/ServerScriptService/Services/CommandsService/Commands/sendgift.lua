local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Animals = require(
		ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Animals")
	)

	local Mutations = require(
		ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Mutations")
	)

	local ValentinesShopService = require(
		ServerScriptService:WaitForChild("Services"):WaitForChild("ValentinesShopService")
	)

	Conch.register("sendgift", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Message",
				optional = true
			}
		end,

		callback = function(player, brainrot, mutation, message)

			if not player then
				return false, "Invalid player specified"
			end

			if not ValentinesShopService then
				return false, "ValentinesShopService not loaded"
			end

			if typeof(ValentinesShopService.GiveAdminGift) ~= "function" then
				return false, "GiveAdminGift method missing"
			end

			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data
					break
				end
			end

			if not AnimalData then
				return false, string.format(
					"Brainrot '%s' not found.",
					tostring(brainrot)
				)
			end

			local mutParam = nil
			if mutation ~= nil
				and mutation ~= ""
				and mutation ~= "Normal"
				and mutation ~= "Default" then

				if not Mutations[mutation] then
					return false, string.format(
						"Mutation '%s' not found.",
						tostring(mutation)
					)
				end

				mutParam = mutation
			end

			local executor

			if typeof(Conch.GetExecutor) == "function" then
				executor = Conch:GetExecutor()
			elseif typeof(Conch.getExecutor) == "function" then
				executor = Conch:getExecutor()
			else
				executor = player
			end

			local ok, success, err = pcall(function()
				return ValentinesShopService:GiveAdminGift(
					player,
					executor,
					AnimalData.Name or brainrot,
					mutParam,
					message
				)
			end)

			if not ok then
				return false, "Internal error while sending gift"
			end

			if success then
				local parts = {}

				if mutParam then
					table.insert(parts, mutParam)
				end

				table.insert(parts, AnimalData.DisplayName or brainrot)

				local msg = string.format(
					"Successfully sent %s to %s!",
					table.concat(parts, " "),
					player.Name
				)

				if message and message ~= "" then
					msg ..= string.format(' Message: "%s"', message)
				end

				return "send"
			else
				return "Failed to send gift: " .. tostring(err)
			end
		end,
	})
end

return module