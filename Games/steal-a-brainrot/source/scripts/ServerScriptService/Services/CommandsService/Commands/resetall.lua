local module = function(Conch, Config)
	local Players = game:GetService("Players")

	Conch.register("resetall", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local results = {}

			for _, plr in ipairs(Players:GetPlayers()) do
				local oldChar = plr.Character
				if not oldChar then
					table.insert(results, plr.Name .. ": no character")
					continue
				end

				local ok = pcall(function()
					local desc = Players:GetHumanoidDescriptionFromUserId(plr.UserId)
					plr:LoadCharacter()
					repeat
						task.wait()
					until plr.Character and plr.Character ~= oldChar

					local newChar = plr.Character
					local hum = newChar:WaitForChild("Humanoid")
					hum:ApplyDescription(desc)
					hum.DisplayName = plr.DisplayName
					hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Default
				end)

				table.insert(results, ok and (plr.Name .. ": reset") or (plr.Name .. ": failed"))
			end

			return table.concat(results, ", ")
		end,
	})
end

return module