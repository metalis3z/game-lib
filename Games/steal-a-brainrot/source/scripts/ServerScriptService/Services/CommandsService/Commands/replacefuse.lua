local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local FuseMachineService = require(ServerScriptService.Services.FuseMachineService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	-- 1. Register the Dropdown List
	pcall(function()
		Conch.add_type("Brainrot", {
			transform = function(text)
				for name, _ in pairs(AnimalsData) do
					if name:lower() == text:lower() then return name end
				end
				return text
			end,
			suggestions = function()
				local list = {}
				for name, _ in pairs(AnimalsData) do table.insert(list, name) end
				table.sort(list)
				return list
			end
		})
	end)

	Conch.register("replacefuse", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{ kind = "argument", type = "string", name = "OldName" },
				{ kind = "argument", type = "Brainrot", name = "NewName" } --
			}
		end,

		callback = function(oldName, newName)
			if not AnimalsData[newName] then return false, "Brainrot not found." end

			-- 2. Update the Machine Pool
			local success, err = FuseMachineService:ReplaceSecretFusion(oldName, newName)
			if not success then return false, err end

			-- 3. THE GLOBAL ANNOUNCEMENT
			-- We loop through all players and use the exact format from your Luck script
			local message = oldName .. ' replaced with <font color="#FFD700">' .. newName .. '</font>!'

			for _, Player in ipairs(Players:GetPlayers()) do
				pcall(function()
					NotificationService.Notify(
						Player,
						message,
						5, -- Duration (5 seconds)
						"Sounds.Sfx.Success" -- Play the success sound
					)
				end)
			end

			return "Success: " .. message
		end
	})
end

return module