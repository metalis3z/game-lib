local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local ItemsFolder = ReplicatedStorage:WaitForChild("Items")

	Conch.register("giveitem", {
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

			if (backpack and backpack:FindFirstChild(toolName))
				or (character and character:FindFirstChild(toolName)) then
				return ("Player already has '%s'"):format(toolName)
			end

			local toolClone = tool:Clone()
			toolClone.Parent = backpack or player:WaitForChild("Backpack")

			for _, obj in ipairs(toolClone:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					if obj.Name == "RemovalMonitor" and BlockedTools[toolClone.Name] then
						obj.Disabled = true
					else
						obj.Disabled = false
					end
				end
			end

			return "given"
		end
	})
end

return module