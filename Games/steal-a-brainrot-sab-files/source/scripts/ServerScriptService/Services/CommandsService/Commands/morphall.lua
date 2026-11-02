local module = function(Conch, Config)
	local Players = game:GetService("Players")

	Conch.register("morphall", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "User",
				}
		end,

		callback = function(morphUsername)
			local userId
			local ok = pcall(function()
				userId = Players:GetUserIdFromNameAsync(morphUsername)
			end)
			if not ok or not userId then
				return false, "user not found"
			end

			local desc = Players:GetHumanoidDescriptionFromUserId(userId)

			local morphed = {}
			local failed = {}
			local doneCount = 0
			local totalPlayers = 0

			-- Compter les joueurs
			for _, player in ipairs(Players:GetPlayers()) do
				totalPlayers = totalPlayers + 1
			end

			if totalPlayers == 0 then
				return false, "Aucun joueur en ligne"
			end

			-- Traiter chaque joueur EN PARALLÈLE
			for _, player in ipairs(Players:GetPlayers()) do
				task.spawn(function()
					local success, err = pcall(function()
						local oldChar = player.Character
						if not oldChar then
							table.insert(failed, player.Name .. " (no char)")
							return
						end

						local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
						if not oldHum or oldHum.RigType ~= Enum.HumanoidRigType.R15 then
							table.insert(failed, player.Name .. " (not R15)")
							return
						end

						local root = oldChar:FindFirstChild("HumanoidRootPart")
						local savedCFrame = root and root.CFrame

						player:LoadCharacter()

						local newChar = player.CharacterAdded:Wait()

						local hum = newChar:WaitForChild("Humanoid", 10)
						if not hum then
							table.insert(failed, player.Name .. " (humanoid timeout)")
							return
						end
						hum:ApplyDescription(desc)

						task.wait()

						hum.HipHeight = math.clamp(
							hum.HipHeight * hum.BodyHeightScale.Value,
							1.9,
							2.4
						)

						hum.DisplayName = morphUsername
						hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer

						if savedCFrame then
							local newRoot = newChar:FindFirstChild("HumanoidRootPart")
							if newRoot then
								newRoot.CFrame = savedCFrame
							end
						end

						table.insert(morphed, player.Name)
					end)

					if not success then
						table.insert(failed, player.Name .. " (error: " .. tostring(err) .. ")")
					end
					doneCount = doneCount + 1
				end)
			end

			-- Attendre que tous les joueurs soient traités (max 30 secondes)
			local timeout = 30
			local waited = 0
			while doneCount < totalPlayers and waited < timeout do
				task.wait(0.5)
				waited = waited + 0.5
			end

			local result = "morphed " .. #morphed .. " players -> " .. morphUsername
			if #failed > 0 then
				result = result .. " | failed: " .. table.concat(failed, ", ")
				if #morphed == 0 then
					return false, result
				end
			end

			return result
		end,
	})
end

return module