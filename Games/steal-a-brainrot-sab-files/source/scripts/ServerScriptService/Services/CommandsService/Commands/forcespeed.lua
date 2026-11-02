local module = function(Conch, Config)
	_G.forcedSpeeds = _G.forcedSpeeds or {}
	_G.loops = _G.loops or {}

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
				return ("Forced WalkSpeed disabled for %s"):format(player.Name)
			end

			_G.forcedSpeeds[player] = speed

			if not _G.loops[player] then
				_G.loops[player] = true

				task.spawn(function()
					while _G.loops[player] and player.Parent do
						local char = player.Character
						if char then
							local hum = char:FindFirstChildOfClass("Humanoid")
							if hum then
								hum.WalkSpeed = _G.forcedSpeeds[player]
							end
						end
						task.wait(0.1)
					end

					_G.loops[player] = nil
					_G.forcedSpeeds[player] = nil
				end)
			end

			return "forced"
		end
	})
end

return module