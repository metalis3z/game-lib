local module = function(Conch, Config)
	local Players = game:GetService("Players")

	Conch.register("morph", {
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
				name = "User",
			}
		end,

		callback = function(targetPlayer, morphUsername)
			local oldChar = targetPlayer.Character
			if not oldChar then
				return false, "character not loaded"
			end

			local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
			if not oldHum or oldHum.RigType ~= Enum.HumanoidRigType.R15 then
				return false, "only R15"
			end

			local root = oldChar:FindFirstChild("HumanoidRootPart")
			local savedCFrame = root and root.CFrame

			local userId
			local ok = pcall(function()
				userId = Players:GetUserIdFromNameAsync(morphUsername)
			end)
			if not ok or not userId then
				return false, "user not found"
			end

			local desc = Players:GetHumanoidDescriptionFromUserId(userId)

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

			return ("morphed %s -> %s"):format(
				targetPlayer.Name,
				morphUsername
			)
		end,
	})
end

return module