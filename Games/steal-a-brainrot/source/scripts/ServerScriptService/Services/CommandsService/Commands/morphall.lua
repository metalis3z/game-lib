local module = function(Conch, Config)
	local Players = game:GetService("Players")

	local function morphPlayer(targetPlayer, morphUsername, userId, desc)
		local oldChar = targetPlayer.Character
		if not oldChar then
			return false, targetPlayer.Name .. ": character not loaded"
		end
		local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
		if not oldHum or oldHum.RigType ~= Enum.HumanoidRigType.R15 then
			return false, targetPlayer.Name .. ": only R15"
		end
		local root = oldChar:FindFirstChild("HumanoidRootPart")
		local savedCFrame = root and root.CFrame

		targetPlayer:LoadCharacter()
		repeat
			task.wait()
		until targetPlayer.Character and targetPlayer.Character ~= oldChar

		local newChar = targetPlayer.Character
		local hum = newChar:WaitForChild("Humanoid")
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
			newChar:WaitForChild("HumanoidRootPart").CFrame = savedCFrame
		end

		return true
	end

	Conch.register("morphall", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
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
			local results = {}

			for _, plr in ipairs(Players:GetPlayers()) do
				local success, err = morphPlayer(plr, morphUsername, userId, desc)
				table.insert(results, success and (plr.Name .. ": ok") or err)
			end

			return table.concat(results, ", ")
		end,
	})
end

return module