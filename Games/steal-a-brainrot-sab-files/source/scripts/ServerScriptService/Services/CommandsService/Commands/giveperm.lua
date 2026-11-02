local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
	local Synchronizer = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Synchronizer"))

	Conch.register("giveperm", {
		permissions = { Config.RequiredRole or "super-user" },

		-- ✅ ARGUMENTS AVEC AUTOCOMPLETE
		arguments = function()
			return {
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
				{
					kind = "argument",
					type = "string",
					name = "Item",

					autocomplete = function()
						local list = {}

						for _, item in ipairs(ItemsFolder:GetChildren()) do
							if item:IsA("Tool") then
								table.insert(list, item.Name)
							end
						end

						table.sort(list)
						return list
					end
				}
			}
		end,

		-- ✅ CALLBACK
		callback = function(targetPlayer, toolName)

			-- Vérif joueur
			if not targetPlayer or not targetPlayer:IsA("Player") then
				return false, "Invalid player"
			end

			-- Vérif tool
			local tool = ItemsFolder:FindFirstChild(toolName)
			if not tool or not tool:IsA("Tool") then
				return false, ("Tool '%s' not found."):format(toolName)
			end

			-- Charger data
			local playerChannel = Synchronizer:Get(targetPlayer)

			while not playerChannel do
				task.wait()
				playerChannel = Synchronizer:Get(targetPlayer)
			end

			-- Init table Items
			local items = playerChannel:Get("Items")
			if not items then
				playerChannel:Set("Items", {})
				items = {}
			end

			-- Anti doublon
			if items[toolName] then
				return false, ("Player already owns '%s'."):format(toolName)
			end

			-- Ajout permanent
			playerChannel:InsertOnDictionary("Items", toolName, true)

			-- 🔥 SAVE FORCÉ
			if playerChannel.Save then
				playerChannel:Save()
			end

			-- Donner tool
			local clone = tool:Clone()
			clone.Parent = targetPlayer:WaitForChild("Backpack")

			-- Activer scripts
			for _, obj in ipairs(clone:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					obj.Disabled = false
				end
			end

			return ("'%s' donné définitivement ✅"):format(toolName)
		end
	})
end

return module