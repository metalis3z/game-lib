local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("givepernamentitem", {
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
					type = "Item",
					name = "Item",
				}
		end,
		callback = function(player, toolArg)
			local BlockedTools = {
				["Flying Carpet"] = true,
				["Witch's Broom"] = true,
			}

			if not player or not player:IsA("Player") then
				return "Invalid player"
			end

			local toolName =
				typeof(toolArg) == "Instance" and toolArg.Name
				or typeof(toolArg) == "string" and toolArg
				or nil

			if not toolName then
				return "Invalid tool argument"
			end

			local tool = ItemsFolder:FindFirstChild(toolName)

			if not tool or not tool:IsA("Tool") then
				return ("Tool '%s' not found."):format(toolName)
			end

			local backpack = player:FindFirstChild("Backpack")
			local character = player.Character

			-- Get player's data channel
			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return "Player data not ready, please try again."
			end

			-- Check if player already has the item permanently
			if playerChannel:Get(string.format("Items.%s", toolName)) then
				-- Item already owned, just give it if they don't have it equipped
				if (backpack and backpack:FindFirstChild(toolName))
					or (character and character:FindFirstChild(toolName)) then
					return ("Player already has '%s' (permanent)"):format(toolName)
				end
			else
				-- Add to Items data (permanent ownership)
				playerChannel:InsertOnDictionary("Items", toolName, true)
				-- Enable AutoBuy so it's kept permanently
				playerChannel:Set(string.format("AutoBuy.%s", toolName), true)
			end

			-- Give the tool to the player
			local toolClone = tool:Clone()
			toolClone.Parent = backpack or player:WaitForChild("Backpack")

			for _, obj in ipairs(toolClone:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					if obj.Name == "RemovalMonitor" and BlockedTools[toolClone.Name] then
						obj.Disabled = true
					else
						obj.Enabled = true
					end
				end
			end

			return ("given permanently: %s"):format(toolName)
		end
	})
end

return module