local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local RitualService = require(ServerScriptService.Services.RitualService)

	print("[RitualCommands] Loading ritual commands...")


	local ritualList = {}
	do
		local state = RitualService:GetState()
		for name, _ in pairs(state.rituals) do
			table.insert(ritualList, name)
		end
		table.sort(ritualList)
	end
	print("[RitualCommands] Loaded", #ritualList, "ritual types")

	Conch.register("ritualforce", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "RitualType",
					suggestions = ritualList,
				},
			{
				kind = "argument",
				type = "players",   
				name = "Players",
			}
		end,
		callback = function(ritualType, targetPlayers)
	
			if typeof(targetPlayers) == "Instance" and targetPlayers:IsA("Player") then
				targetPlayers = { targetPlayers }
			end

			if type(targetPlayers) ~= "table" or #targetPlayers == 0 then
				return false, "Please provide at least one player."
			end

			local conf = RitualService:GetRitualConfig(ritualType)
			if not conf then
				return false, string.format("Unknown ritual type '%s'. Use /rituallist to see options.", ritualType)
			end

	
			local expectedCount = conf.playersNeeded
			local providedCount = #targetPlayers
			local warning = ""
			if providedCount ~= expectedCount then
				warning = string.format(" (⚠ ritual needs %d players, got %d)", expectedCount, providedCount)
			end

		
			RitualService:ResetCooldown(ritualType)

			local success = RitualService:ForceRitual(ritualType, targetPlayers)
			if not success then
				return false, string.format(
					"Failed to force ritual '%s'. It may still be on cooldown or a special event is required. Use /ritualreset first.",
					ritualType
				)
			end

			local playerNames = {}
			for _, p in ipairs(targetPlayers) do
				table.insert(playerNames, p.Name)
			end

			return true, string.format(
				"✓ Force-started ritual '%s' with players: %s%s",
				ritualType,
				table.concat(playerNames, ", "),
				warning
			)
		end
	})
	print("[RitualCommands] ✓ Registered: ritualforce")

	Conch.register("ritualreset", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = (function()
					local opts = { "all" }
					for _, v in ipairs(ritualList) do table.insert(opts, v) end
					return opts
				end)(),
				optional = true,
			}
		end,
		callback = function(ritualType)
			ritualType = ritualType or "all"

			if string.lower(ritualType) == "all" then
				for _, name in ipairs(ritualList) do
					RitualService:ResetCooldown(name)
				end
				return true, string.format("✓ Reset cooldowns for all %d rituals.", #ritualList)
			end

			local conf = RitualService:GetRitualConfig(ritualType)
			if not conf then
				return false, string.format("Unknown ritual type '%s'. Use /rituallist to see options.", ritualType)
			end

			RitualService:ResetCooldown(ritualType)
			return true, string.format("✓ Cooldown reset for ritual '%s'.", ritualType)
		end
	})
	print("[RitualCommands] ✓ Registered: ritualreset")

	Conch.register("rituallist", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local list = RitualService:GetRitualList()

			local lines = {
				string.format("═══ Rituals (%d) ═══", #list),
				""
			}

			for _, info in ipairs(list) do
				local statusIcon = info.onCooldown
					and string.format("⏳ %ds cd", info.cooldownRemaining)
					or "✅ ready"

				table.insert(lines, string.format(
					"▸ %s  [%s]",
					info.name, statusIcon
					))
				table.insert(lines, string.format(
					"   Players needed: %d | Animal: %s | Reward: %s",
					info.playersNeeded, info.animalNeeded, info.reward
					))
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: rituallist")

	Conch.register("ritualstatus", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local state = RitualService:GetState()

			local lines = {
				"═══ Ritual Server Status ═══",
				"",
				string.format("Active Rituals : %d", state.activeRituals),
				string.format("Busy Players   : %d", state.busyPlayers),
				"",
				"Cooldowns:",
			}

			local hasCooldown = false
			for name, lastTime in pairs(state.cooldowns) do
				local remaining = math.max(0, 60 - (os.time() - lastTime))
				if remaining > 0 then
					table.insert(lines, string.format("  • %s — %ds remaining", name, remaining))
					hasCooldown = true
				end
			end

			if not hasCooldown then
				table.insert(lines, "  (none)")
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: ritualstatus")

	Conch.register("ritualevent", {
		permissions = { "admin" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Action",
					suggestions = { "enable", "disable" },
				},
			{
				kind = "argument",
				type = "number",
				name = "Duration (seconds)",
				optional = true,
			}
		end,
		callback = function(action, duration)
			action = string.lower(action or "")

			if action == "enable" then
				local secs = tonumber(duration) or 600
				RitualService:ActivateSpecialEvent(secs)
				return true, string.format(
					"✓ Special event (1x1x1x1 ritual) enabled for %d seconds.",
					secs
				)
			elseif action == "disable" then
				ReplicatedStorage:SetAttribute("SpecialEventActive", false)
				return true, "✓ Special event disabled."
			else
				return false, "Invalid action. Use 'enable' or 'disable'."
			end
		end
	})
	print("[RitualCommands] ✓ Registered: ritualevent")

	Conch.register("ritualinfo", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "RitualType",
				suggestions = ritualList,
			}
		end,
		callback = function(ritualType)
			local conf = RitualService:GetRitualConfig(ritualType)
			if not conf then
				return false, string.format("Unknown ritual type '%s'. Use /rituallist to see all.", ritualType)
			end

			local lines = {
				string.format("═══ Ritual: %s ═══", ritualType),
				"",
				string.format("Players Needed : %d", conf.playersNeeded),
				string.format("Animal Needed  : %s", conf.animalNeeded),
				string.format("Style          : %s", conf.style),
				string.format("Reward         : %s", conf.reward),
			}

			if conf.rareReward then
				table.insert(lines, string.format("Rare Reward    : %s (%.0f%% chance)", conf.rareReward, (conf.rareChance or 0) * 100))
			end
			if conf.secretReward then
				table.insert(lines, string.format("Secret Reward  : %s (%.1f%% chance)", conf.secretReward, (conf.secretChance or 0) * 100))
			end
			if conf.wait then
				table.insert(lines, string.format("Completion Time: %ds", conf.wait))
			end
			if conf.needsEvent then
				local active = ReplicatedStorage:GetAttribute("SpecialEventActive")
				table.insert(lines, string.format("Special Event  : Required (currently %s)", active and "ACTIVE ✅" or "inactive ❌"))
			end
			if conf.conveyor then
				table.insert(lines, "Spawns on conveyor: yes")
			end
			if conf.buildPhase then
				table.insert(lines, "Build Phase: yes")
			end
			if conf.passRitualPosition then
				table.insert(lines, "Tree Spawn: at ritual location ")
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: ritualinfo")


	Conch.register("ritualhelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local help = {
				"═══════════ Ritual Commands Help ═══════════",
				"",
				"▸ /ritualforce <ritualType> <player(s)>",
				"  Force-start a ritual, bypassing position/animal checks.",
				"  Automatically resets cooldown before starting.",
				"  Example: /ritualforce Matteo Player1 Player2 Player3",
				"",
				"▸ /ritualreset [ritualType | all]",
				"  Reset the cooldown for one ritual or all rituals.",
				"  Example: /ritualreset Matteo",
				"  Example: /ritualreset all",
				"",
				"▸ /rituallist",
				"  List all rituals with requirements and cooldown status.",
				"",
				"▸ /ritualstatus",
				"  Show live server state: active rituals, busy players, cooldowns.",
				"",
				"▸ /ritualevent <enable|disable> [duration]",
				"  Enable or disable the special event required for 1x1x1x1.",
				"  Duration is in seconds (default 600). Admin only.",
				"  Example: /ritualevent enable 300",
				"",
				"▸ /ritualinfo <ritualType>",
				"  Show detailed config for a specific ritual.",
				"  Example: /ritualinfo DulDulDul",
				"",
				"▸ /ritualhelp",
				"  Show this help message.",
				"",
				"═══════════════════════════════════════════",
			}
			return true, table.concat(help, "\n")
		end
	})
	print("[RitualCommands] ✓ Registered: ritualhelp")

	print("═══════════════════════════════════════════")
	print("[RitualCommands] ✓ All commands loaded successfully!")
	print("[RitualCommands] Available commands:")
	print("  • ritualforce  - Force-start a ritual")
	print("  • ritualreset  - Reset ritual cooldowns")
	print("  • rituallist   - List all rituals")
	print("  • ritualstatus - Server ritual state")
	print("  • ritualevent  - Enable/disable special event (Admin)")
	print("  • ritualinfo   - Detailed ritual config")
	print("  • ritualhelp   - Show command help")
	print("═══════════════════════════════════════════")
end

return module