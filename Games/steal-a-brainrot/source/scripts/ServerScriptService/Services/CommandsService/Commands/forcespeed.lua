local module = function(Conch, Config)
	_G.forcedSpeeds = _G.forcedSpeeds or {}
	_G.loops = _G.loops or {}

	local Players = game:GetService("Players")
	local DEFAULT_SPEED = 35

	if not _G.__forcespeedCleanupBound then
		_G.__forcespeedCleanupBound = true
		Players.PlayerRemoving:Connect(function(plr)
			_G.loops[plr] = nil
			_G.forcedSpeeds[plr] = nil
		end)
	end

	Conch.register("forcespeed", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Speed",
			}
		end,

		callback = function(player, speed)
			speed = tonumber(speed)

			if not player or not player:IsA("Player") or not speed then
				return false, "Invalid player or speed"
			end

			if speed == 0 then
				_G.loops[player] = nil
				_G.forcedSpeeds[player] = nil
				player:SetAttribute("IgnoredByAntiCheat", nil)

				local char = player.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				if hum then
					hum.WalkSpeed = DEFAULT_SPEED
				end

				return ("Forced WalkSpeed reset to default for %s"):format(player.Name)
			end

			_G.forcedSpeeds[player] = speed
			player:SetAttribute("IgnoredByAntiCheat", true)

			if not _G.loops[player] then
				_G.loops[player] = true

				task.spawn(function()
					while _G.loops[player] and player.Parent do
						local char = player.Character
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if hum then
							hum.WalkSpeed = _G.forcedSpeeds[player]
						end
						task.wait(0.1)
					end

					player:SetAttribute("IgnoredByAntiCheat", nil)
					_G.loops[player] = nil
					_G.forcedSpeeds[player] = nil
				end)
			end

			return ("Forced WalkSpeed set to %s for %s"):format(speed, player.Name)
		end,
	})
end

return module