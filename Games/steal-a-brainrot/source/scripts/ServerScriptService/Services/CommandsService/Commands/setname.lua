local module = function(Conch, Config)
	local Players = game:GetService("Players")
	Conch.register("setname", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Target",
				},
			{
				kind = "argument",
				type = "string",
				name = "Name",
			}
		end,
		callback = function(targetPlayer, newName)
			local char = targetPlayer.Character
			if not char then
				return false, "character not loaded"
			end
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hum then
				return false, "no humanoid found"
			end

			hum.DisplayName = newName
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer

			local leaderstats = targetPlayer:FindFirstChild("leaderstats")
			if leaderstats then
				local nameVal = leaderstats:FindFirstChild("DisplayName")
				if nameVal then
					nameVal.Value = newName
				end
			end

			return ("set")
		end,
	})
end
return module