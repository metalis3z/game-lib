local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local RitualService = require(ServerScriptService.Services.RitualService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)

	print("[RitualCommands] Loading ritual commands...")

	
	local ritualTypes = {}
	for ritualName, _ in pairs(RitualService.RitualConfigs or {}) do
		table.insert(ritualTypes, ritualName)
	end
	table.sort(ritualTypes)
	print("[RitualCommands] Loaded", #ritualTypes, "ritual types")


	local function parsePlayerList(input)
		if not input or input == "" then
			return {}
		end

		local playerNames = string.split(input, ",")
		local players = {}

		for _, name in ipairs(playerNames) do
			name = string.gsub(name, "^%s+", "") 
			name = string.gsub(name, "%s+$", "") 

			local player = Players:FindFirstChild(name)
			if player then
				table.insert(players, player)
			end
		end

		return players
	end

	Conch.register("ritualstart", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = ritualTypes,
			}, {
				kind = "argument",
				type = "string",
				name = "PlayerList",
				description = "Comma-separated player names",
			}
		end,
		callback = function(ritualType, playerListInput)
			local players = parsePlayerList(playerListInput)

			if #players == 0 then
				return false, "No valid players found. Use comma-separated names (e.g., Player1,Player2,Player3)"
			end

			local config = RitualService.RitualConfigs and RitualService.RitualConfigs[ritualType]
			if not config then
				return false, string.format("Ritual type '%s' not found. Available: %s", 
					ritualType, table.concat(ritualTypes, ", "))
			end

			if #players ~= config.RequiredPlayers then
				return false, string.format("%s ritual requires exactly %d players (got %d)", 
					ritualType, config.RequiredPlayers, #players)
			end

			local success = RitualService:ForceRitual(ritualType, players)

			if success then
				local playerNames = {}
				for _, player in ipairs(players) do
					table.insert(playerNames, player.Name)
				end
				return true, string.format("✓ Started %s ritual with players: %s", 
					ritualType, table.concat(playerNames, ", "))
			else
				return false, "Failed to start ritual. It might be on cooldown or invalid."
			end
		end
	})
	print("[RitualCommands] ✓ Registered: ritualstart")

	Conch.register("ritualforce", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = ritualTypes,
			}, {
				kind = "argument",
				type = "string",
				name = "PlayerList",
				description = "Comma-separated player names",
			}
		end,
		callback = function(ritualType, playerListInput)
			local players = parsePlayerList(playerListInput)

			if #players == 0 then
				return false, "No valid players found. Use comma-separated names (e.g., Player1,Player2,Player3)"
			end


			RitualService:ResetCooldown(ritualType)


			local success = RitualService:ForceRitual(ritualType, players)

			if success then
				local playerNames = {}
				for _, player in ipairs(players) do
					table.insert(playerNames, player.Name)
				end
				return true, string.format("✓ Forced %s ritual with players: %s (cooldown bypassed)", 
					ritualType, table.concat(playerNames, ", "))
			else
				return false, "Failed to force ritual."
			end
		end
	})
	print("[RitualCommands] ✓ Registered: ritualforce")

	Conch.register("ritualevent", {
		permissions = { "admin" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "Action",
				suggestions = { "start", "stop" },
			}, {
				kind = "argument",
				type = "number",
				name = "Duration",
				optional = true,
				default = 600,
				description = "Duration in seconds (default: 600)"
			}
		end,
		callback = function(action, duration)
			action = string.lower(action)

			if action == "start" then
				RitualService:ActivateSpecialEvent(duration or 600)
				return true, string.format("✓ Special event activated for %d seconds! 1x1x1x1 ritual now available.", duration or 600)
			elseif action == "stop" then
				ReplicatedStorage:SetAttribute("SpecialEventActive", false)
				return true, "✓ Special event deactivated."
			else
				return false, "Invalid action. Use 'start' or 'stop'."
			end
		end
	})
	print("[RitualCommands] ✓ Registered: ritualevent")

	Conch.register("ritualreset", {
		permissions = { "admin" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = ritualTypes,
				optional = true,
				description = "Leave empty to reset all"
			}
		end,
		callback = function(ritualType)
			if ritualType and ritualType ~= "" then
				RitualService:ResetCooldown(ritualType)
				return true, string.format("✓ Reset cooldown for %s ritual", ritualType)
			else
			
				for ritualName, _ in pairs(RitualService.RitualConfigs or {}) do
					RitualService:ResetCooldown(ritualName)
				end
				return true, "✓ Reset all ritual cooldowns"
			end
		end
	})
	print("[RitualCommands] ✓ Registered: ritualreset")


	Conch.register("ritualcooldowns", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local cooldownInfo = {}
			table.insert(cooldownInfo, "═══ Ritual Cooldowns ═══")
			table.insert(cooldownInfo, "")

			local now = os.time()
			local hasActive = false

			for ritualName, config in pairs(RitualService.RitualConfigs or {}) do
				local lastTime = RitualService.RitualCooldowns and RitualService.RitualCooldowns[ritualName]

				if lastTime then
					local timeSince = now - lastTime
					local timeLeft = 60 - timeSince 

					if timeLeft > 0 then
						hasActive = true
						table.insert(cooldownInfo, string.format("• %s: %d seconds remaining", 
							ritualName, timeLeft))
					else
						table.insert(cooldownInfo, string.format("• %s: Ready", ritualName))
					end
				else
					table.insert(cooldownInfo, string.format("• %s: Ready", ritualName))
				end
			end

			if not hasActive then
				table.insert(cooldownInfo, "All rituals are ready!")
			end

			return true, table.concat(cooldownInfo, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: ritualcooldowns")


	Conch.register("rituallist", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = ritualTypes,
				optional = true,
			}
		end,
		callback = function(ritualType)
			if ritualType and ritualType ~= "" then
				
				local config = RitualService.RitualConfigs and RitualService.RitualConfigs[ritualType]
				if not config then
					return false, "Ritual type not found"
				end

				local details = {
					string.format("═══ %s Ritual Details ═══", ritualType),
					"",
					string.format("Required Players: %d", config.RequiredPlayers),
					string.format("Required Brainrot: %s", config.RequiredBrainrot),
					string.format("Formation: %s", config.Formation),
					string.format("Reward: %s", config.SpawnReward),
				}

				if config.RareSpawnReward then
					table.insert(details, string.format("Rare Reward: %s (%.1f%% chance)", 
						config.RareSpawnReward, (config.RareChance or 0) * 100))
				end

				if config.SecretSpawnReward then
					table.insert(details, string.format("Secret Reward: %s (%.1f%% chance)", 
						config.SecretSpawnReward, (config.SecretChance or 0) * 100))
				end

				if config.Legendary then
					table.insert(details, "LEGENDARY RITUAL")
				end

				if config.RequiresSpecialEvent then
					table.insert(details, "Requires Special Event")
				end

				return true, table.concat(details, "\n")
			else
			
				local list = {"═══ Available Rituals ═══", ""}

				for _, name in ipairs(ritualTypes) do
					local config = RitualService.RitualConfigs[name]
					if config then
						local legendary = config.Legendary and " ⚡" or ""
						table.insert(list, string.format("• %s%s - %d players, %s", 
							name, legendary, config.RequiredPlayers, config.Formation))
					end
				end

				table.insert(list, "")
				table.insert(list, "Use /rituallist <ritual> for details")

				return true, table.concat(list, "\n")
			end
		end
	})
	print("[RitualCommands] ✓ Registered: rituallist")


	Conch.register("ritualhelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local help = {
				"═══════════ Ritual Commands Help ═══════════",
				"",
				"▸ /ritualstart <ritual> <player1,player2,...>",
				"  Start a ritual with specific players",
				"  Example: /ritualstart Matteo Player1,Player2,Player3",
				"",
				"▸ /ritualforce <ritual> <player1,player2,...>",
				"  Force start a ritual (bypass cooldown)",
				"  Example: /ritualforce LaVacca Player1,Player2,Player3",
				"",
				"▸ /ritualevent <start/stop> [duration]",
				"  Activate/deactivate special event for 1x1x1x1 ritual",
				"  Example: /ritualevent start 300",
				"",
				"▸ /ritualreset [ritual]",
				"  Reset cooldown for a ritual (or all rituals)",
				"  Example: /ritualreset Matteo",
				"",
				"▸ /ritualcooldowns",
				"  Check current ritual cooldowns",
				"",
				"▸ /rituallist [ritual]",
				"  List all rituals or view ritual details",
				"  Example: /rituallist 1x1x1x1",
				"",
				"═══════════════════════════════════════════",
			}
			return true, table.concat(help, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: ritualhelp")

	print("═══════════════════════════════════════════")
	print("[RitualCommands] ✓ All ritual commands loaded successfully!")
	print("[RitualCommands] Available commands:")
	print("  • ritualstart     - Start a ritual")
	print("  • ritualforce     - Force start a ritual (bypass cooldown)")
	print("  • ritualevent     - Toggle special event")
	print("  • ritualreset     - Reset ritual cooldowns")
	print("  • ritualcooldowns - Check cooldowns")
	print("  • rituallist      - List rituals")
	print("  • ritualhelp      - Show help")
	print("═══════════════════════════════════════════")
end

return module