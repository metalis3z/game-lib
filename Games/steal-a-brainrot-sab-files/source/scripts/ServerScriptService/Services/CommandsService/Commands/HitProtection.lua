--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150]

local module = function(Conch, Config)

	local Players = game:GetService("Players")

	local protectedPlayers = {}

	local function protectCharacter(character)
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				if part:GetAttribute("OriginalCanTouch") == nil then
					part:SetAttribute("OriginalCanTouch", part.CanTouch)
				end
				part.CanTouch = false
			end
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if humanoid:GetAttribute("OriginalMaxHealth") == nil then
				humanoid:SetAttribute("OriginalMaxHealth", humanoid.MaxHealth)
			end
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
		end
	end

	local function restoreCharacter(character)
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				local original = part:GetAttribute("OriginalCanTouch")
				if original ~= nil then
					part.CanTouch = original
					part:SetAttribute("OriginalCanTouch", nil)
				end
			end
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local originalHealth = humanoid:GetAttribute("OriginalMaxHealth")
			if originalHealth then
				humanoid.MaxHealth = originalHealth
				humanoid.Health = originalHealth
				humanoid:SetAttribute("OriginalMaxHealth", nil)
			end
		end
	end

	local function protectPlayer(player)
		protectedPlayers[player] = true

		if player.Character then
			protectCharacter(player.Character)
		end

		player.CharacterAdded:Connect(function(char)
			task.wait()
			if protectedPlayers[player] then
				protectCharacter(char)
			end
		end)
	end

	local function unprotectPlayer(player)
		protectedPlayers[player] = nil

		if player.Character then
			restoreCharacter(player.Character)
		end
	end


	Conch.register("hitprotection", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player"
				},
			{
				kind = "argument",
				type = "string",
				name = "State"
			}
		end,

		callback = function(targetPlayer, state)

			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			if state == "on" or state == "On" then
				protectPlayer(targetPlayer)
				return "HitProtection enabled for " .. targetPlayer.Name
			end

			if state == "off" or state == "Off" then
				unprotectPlayer(targetPlayer)
				return "HitProtection disabled for " .. targetPlayer.Name
			end

			return false, "Use: hitprotection Player on/off"
		end
	})

end

return module
