local module = function(Conch, Config)
	local Players = game:GetService("Players")

	Conch.register("removeitem", {
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

			if typeof(toolName) ~= "string" then
				return false, "Invalid item"
			end

			local backpack = player:FindFirstChild("Backpack")
			if backpack then
				local tool = backpack:FindFirstChild(toolName)
				if tool and tool:IsA("Tool") then
					tool:Destroy()
					return "removed"
				end
			end

			local character = player.Character
			if character then
				local tool = character:FindFirstChild(toolName)
				if tool and tool:IsA("Tool") then
					tool:Destroy()
					return "removed"
				end
			end

			return ("Item %s not found"):format(toolName)
		end,
	})
end

return module