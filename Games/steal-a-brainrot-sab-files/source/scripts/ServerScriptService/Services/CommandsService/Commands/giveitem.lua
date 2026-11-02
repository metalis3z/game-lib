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
		callback = function(player, toolName)

			if not player or not player:IsA("Player") then
				return false, "Invalid player"
			end

			local tool = ItemsFolder:FindFirstChild(toolName)
			if not tool or not tool:IsA("Tool") then
				return false, ("Tool '%s' not found."):format(tostring(toolName))
			end

			local toolClone = tool:Clone()
			toolClone.Parent = player:WaitForChild("Backpack")

			task.wait()

			for _, obj in ipairs(toolClone:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					obj.Disabled = false
				end
			end

			local BlockedTools = {
				["Flying Carpet"] = true,
				["Witch's Broom"] = true,
			}

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