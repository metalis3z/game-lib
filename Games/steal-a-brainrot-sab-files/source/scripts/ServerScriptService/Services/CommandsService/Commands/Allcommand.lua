local module = function(Conch, Config)
	local ReplicatedStorage   = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players             = game:GetService("Players")

	local AdminboardService     = require(ServerScriptService.Services.AdminboardService)
	local CupidsMachineService  = require(ServerScriptService.Services.CupidsMachineService)
	local CoinsShopService      = require(ServerScriptService.Services.CoinsShopService)
	local Synchronizer          = require(ReplicatedStorage.Packages.Synchronizer)
	local Net                   = require(ReplicatedStorage.Packages.Net)

	-- Remotes we need to fire directly for CursedEvent
	local CursedSpin = Net:RemoteEvent("CursedEventService/Spin")

	print("[ServiceCommands] Loading all service commands...")

	-- ────────────────────────────────────────────────────────────────────────────
	-- ADMINBOARD COMMANDS
	-- ────────────────────────────────────────────────────────────────────────────

	--------------------------------------------------------------------------------
	-- boardspin  — force the adminboard to spin immediately
	--------------------------------------------------------------------------------
	Conch.register("boardspin", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			local ok = AdminboardService:ForceSpin()
			if not ok then
				return false, "Cannot spin right now — events are currently active. Use /boardstatus to check."
			end
			return true, "✓ Adminboard spin triggered!"
		end
	})
	print("[ServiceCommands] ✓ boardspin")

	--------------------------------------------------------------------------------
	-- boardskip  — skip the current wait timer so the next spin happens immediately
	--------------------------------------------------------------------------------
	Conch.register("boardskip", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			local ok = AdminboardService:SkipWait()
			if not ok then
				return false, "Cannot skip — board is not in wait phase (events may be active)."
			end
			return true, "✓ Wait timer skipped. Board will spin shortly."
		end
	})
	print("[ServiceCommands] ✓ boardskip")

	--------------------------------------------------------------------------------
	-- boardstatus  — show current adminboard state
	--------------------------------------------------------------------------------
	Conch.register("boardstatus", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			local state = AdminboardService:GetState()

			local lines = {
				"═══ Adminboard Status ═══",
				string.format("Can Activate : %s", tostring(state.canActivate)),
				string.format("Next Event   : %s", state.nextEventFormatted),
				string.format("Cycle Lists  : Events=%d  Luck=%d  Items=%d",
					state.cycleListsSizes.events,
					state.cycleListsSizes.luck,
					state.cycleListsSizes.items),
			}

			if state.activeCycleData then
				local c = state.activeCycleData
				table.insert(lines, "")
				table.insert(lines, "Active Cycle:")
				table.insert(lines, string.format("  Event : %s", c.EventName or "none"))
				table.insert(lines, string.format("  Luck  : %s", c.LuckName  or "none"))
				table.insert(lines, string.format("  Item  : %s", c.ItemName  or "none"))
				table.insert(lines, string.format("  Ends  : %s", os.date("%X", c.EndsAt)))
			else
				table.insert(lines, "")
				table.insert(lines, "No active cycle.")
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[ServiceCommands] ✓ boardstatus")

	--------------------------------------------------------------------------------
	-- boardrefresh  — rebuild the event/luck/item cycle lists from scratch
	--------------------------------------------------------------------------------
	Conch.register("boardrefresh", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			AdminboardService:RefreshCycleLists()
			local state = AdminboardService:GetState()
			return true, string.format(
				"✓ Cycle lists refreshed — Events: %d  Luck: %d  Items: %d",
				state.cycleListsSizes.events,
				state.cycleListsSizes.luck,
				state.cycleListsSizes.items
			)
		end
	})
	print("[ServiceCommands] ✓ boardrefresh")

	-- ────────────────────────────────────────────────────────────────────────────
	-- CURSED EVENT COMMANDS
	-- ────────────────────────────────────────────────────────────────────────────

	--------------------------------------------------------------------------------
	-- cursedgive  — give free spins to a player (or everyone)
	--------------------------------------------------------------------------------
	Conch.register("cursedgive", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Spins",
				optional = true,
			}
		end,
		callback = function(targetPlayer, amount)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local spins = tonumber(amount) or 1
			if spins < 1 or spins > 100 then
				return false, "Amount must be between 1 and 100."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			chan:Increase("CursedSpinWheel.Spins", spins)
			local newTotal = chan:Get("CursedSpinWheel.Spins") or spins

			return true, string.format(
				"✓ Gave %d spin%s to %s (total: %d)",
				spins, spins == 1 and "" or "s", targetPlayer.Name, newTotal
			)
		end
	})
	print("[ServiceCommands] ✓ cursedgive")

	--------------------------------------------------------------------------------
	-- cursedgiveall  — give free spins to ALL players
	--------------------------------------------------------------------------------
	Conch.register("cursedgiveall", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return {
				kind = "argument",
				type = "number",
				name = "Spins",
				optional = true,
			}
		end,
		callback = function(amount)
			local spins = tonumber(amount) or 1
			if spins < 1 or spins > 100 then
				return false, "Amount must be between 1 and 100."
			end

			local count = 0
			for _, player in ipairs(Players:GetPlayers()) do
				local chan = Synchronizer:Get(player)
				if chan then
					chan:Increase("CursedSpinWheel.Spins", spins)
					count += 1
				end
			end

			return true, string.format(
				"✓ Gave %d spin%s to %d player%s.",
				spins, spins == 1 and "" or "s",
				count, count == 1 and "" or "s"
			)
		end
	})
	print("[ServiceCommands] ✓ cursedgiveall")

	--------------------------------------------------------------------------------
	-- cursedcheck  — check how many spins a player has
	--------------------------------------------------------------------------------
	Conch.register("cursedcheck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			local spins = chan:Get("CursedSpinWheel.Spins") or 0
			return true, string.format("%s has %d Cursed Spin%s.", targetPlayer.Name, spins, spins == 1 and "" or "s")
		end
	})
	print("[ServiceCommands] ✓ cursedcheck")

	-- ────────────────────────────────────────────────────────────────────────────
	-- CUPIDS MACHINE COMMANDS
	-- ────────────────────────────────────────────────────────────────────────────

	--------------------------------------------------------------------------------
	-- cupidscheck  — check a player's Cupids Machine state
	--------------------------------------------------------------------------------
	Conch.register("cupidscheck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			local machineData = chan:Get("CupidsMachine") or {}
			local podiums     = chan:Get("AnimalPodiums") or {}

			local now = workspace:GetServerTimeNow()
			local startTime  = machineData.StartTime  or 0
			local finishTime = machineData.FinishTime or 0
			local skips      = machineData.InstantSkips or 0

			local brainrotsInMachine = {}
			for _, pod in pairs(podiums) do
				if type(pod) == "table" and pod.Machine and pod.Machine.Type == "Cupids" then
					table.insert(brainrotsInMachine, string.format(
						"%s (active: %s)", pod.Index, tostring(pod.Machine.Active == true)))
				end
			end

			local lines = {
				string.format("═══ %s's Cupids Machine ═══", targetPlayer.Name),
				string.format("Running       : %s", tostring(startTime ~= 0 and now < finishTime)),
				string.format("Instant Skips : %d", skips),
			}

			if startTime ~= 0 then
				local remaining = math.max(0, finishTime - now)
				table.insert(lines, string.format("Time Left     : %.1fs", remaining))
			end

			if #brainrotsInMachine > 0 then
				table.insert(lines, "In Machine:")
				for _, name in ipairs(brainrotsInMachine) do
					table.insert(lines, "  • " .. name)
				end
			else
				table.insert(lines, "In Machine    : (empty)")
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[ServiceCommands] ✓ cupidscheck")

	--------------------------------------------------------------------------------
	-- cupidsgiveskip  — give instant skips to a player
	--------------------------------------------------------------------------------
	Conch.register("cupidsgiveskip", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true,
			}
		end,
		callback = function(targetPlayer, amount)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local skips = tonumber(amount) or 1
			if skips < 1 or skips > 50 then
				return false, "Amount must be between 1 and 50."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			local machineData = chan:Get("CupidsMachine") or { StartTime=0, FinishTime=0, InstantSkips=0 }
			machineData.InstantSkips = (machineData.InstantSkips or 0) + skips
			chan:Set("CupidsMachine", machineData)

			return true, string.format(
				"✓ Gave %d instant skip%s to %s (total: %d)",
				skips, skips == 1 and "" or "s",
				targetPlayer.Name, machineData.InstantSkips
			)
		end
	})
	print("[ServiceCommands] ✓ cupidsgiveskip")

	--------------------------------------------------------------------------------
	-- cupidsreset  — clear a player's Cupids Machine state
	--------------------------------------------------------------------------------
	Conch.register("cupidsreset", {
		permissions = { "admin" },
		arguments   = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			-- Clear machine state
			chan:Set("CupidsMachine", { StartTime=0, FinishTime=0, InstantSkips=0 })

			-- Remove all Cupids podium flags
			local podiums = chan:Get("AnimalPodiums") or {}
			for i, pod in pairs(podiums) do
				if type(pod) == "table" and pod.Machine and pod.Machine.Type == "Cupids" then
					pod.Machine = nil
					podiums[i] = pod
				end
			end
			chan:Set("AnimalPodiums", podiums)
			chan:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

			return true, string.format("✓ Reset Cupids Machine state for %s.", targetPlayer.Name)
		end
	})
	print("[ServiceCommands] ✓ cupidsreset")

	-- ────────────────────────────────────────────────────────────────────────────
	-- COINS SHOP COMMANDS
	-- ────────────────────────────────────────────────────────────────────────────

	--------------------------------------------------------------------------------
	-- shopgive  — give a shop item directly to a player (bypasses cost check)
	--------------------------------------------------------------------------------
	Conch.register("shopgive", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Item",
			}
		end,
		callback = function(targetPlayer, itemName)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			if not itemName or itemName == "" then
				return false, "Item name cannot be empty."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			-- Special handling for Trap (uses counter)
			if itemName == "Trap" then
				local current = targetPlayer:GetAttribute("TrapCount") or 0
				if current >= 5 then
					return false, string.format("%s already has the maximum 5 traps.", targetPlayer.Name)
				end
				local newCount = current + 1
				targetPlayer:SetAttribute("TrapCount", newCount)
				chan:InsertOnDictionary("SessionTraps", tostring(newCount), true)
				chan:InsertOnDictionary("Items", itemName, true)
				return true, string.format("✓ Gave Trap to %s (trap count: %d/5).", targetPlayer.Name, newCount)
			end

			chan:InsertOnDictionary("Items", itemName, true)
			return true, string.format("✓ Gave '%s' to %s.", itemName, targetPlayer.Name)
		end
	})
	print("[ServiceCommands] ✓ shopgive")

	--------------------------------------------------------------------------------
	-- shoptake  — remove a shop item from a player
	--------------------------------------------------------------------------------
	Conch.register("shoptake", {
		permissions = { "admin" },
		arguments   = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Item",
			}
		end,
		callback = function(targetPlayer, itemName)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			local items = chan:Get("Items") or {}
			if not items[itemName] then
				return false, string.format("%s does not have '%s'.", targetPlayer.Name, itemName)
			end

			items[itemName] = nil
			chan:Set("Items", items)

			return true, string.format("✓ Removed '%s' from %s.", itemName, targetPlayer.Name)
		end
	})
	print("[ServiceCommands] ✓ shoptake")

	--------------------------------------------------------------------------------
	-- shopcheck  — check what shop items a player owns
	--------------------------------------------------------------------------------
	Conch.register("shopcheck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			local items    = chan:Get("Items")    or {}
			local autoBuy  = chan:Get("AutoBuy")  or {}

			local ownedList = {}
			for name, _ in pairs(items) do
				local autoBuyStr = autoBuy[name] and " [AutoBuy ✓]" or ""
				table.insert(ownedList, "  • " .. name .. autoBuyStr)
			end

			table.sort(ownedList)

			if #ownedList == 0 then
				return true, string.format("%s owns no shop items.", targetPlayer.Name)
			end

			local lines = {
				string.format("═══ %s's Shop Items (%d) ═══", targetPlayer.Name, #ownedList),
			}
			for _, line in ipairs(ownedList) do
				table.insert(lines, line)
			end

			return true, table.concat(lines, "\n")
		end
	})
	print("[ServiceCommands] ✓ shopcheck")

	--------------------------------------------------------------------------------
	-- shopclearitems  — remove ALL shop items from a player (except permanent ones)
	--------------------------------------------------------------------------------
	Conch.register("shopclearitems", {
		permissions = { "admin" },
		arguments   = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local chan = Synchronizer:Get(targetPlayer)
			if not chan then
				return false, "Player data not loaded yet."
			end

			-- Keep permanent items (matching CoinsShopService keepItems logic)
			local keepItems = {
				["Bat"] = true,
				["Blackhole Slap"] = true,
				["Flying Carpet"] = true,
				["Laser Gun"] = true,
				["Ban Hammer"] = true,
			}

			local items    = chan:Get("Items")   or {}
			local autoBuy  = chan:Get("AutoBuy") or {}
			local newItems = {}

			for name, val in pairs(items) do
				if keepItems[name] or autoBuy[name] then
					newItems[name] = val
				end
			end

			chan:Set("Items", newItems)

			return true, string.format("✓ Cleared session items from %s (permanent items kept).", targetPlayer.Name)
		end
	})
	print("[ServiceCommands] ✓ shopclearitems")



	Conch.register("servicehelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			return true, table.concat({
				"═══════════ Service Commands ═══════════",
				"",
				"── Adminboard ──",
				"  /boardspin         Force the board to spin immediately",
				"  /boardskip         Skip the wait timer",
				"  /boardstatus       Show current board state",
				"  /boardrefresh      Rebuild event/luck/item cycle lists",
				"",
				"── Cursed Event ──",
				"  /cursedgive <player> [amount]    Give spins to a player",
				"  /cursedgiveall [amount]           Give spins to ALL players",
				"  /cursedcheck <player>             Check a player's spin count",
				"",
				"── Cupids Machine ──",
				"  /cupidscheck <player>             Check machine state",
				"  /cupidsgiveskip <player> [amt]    Give instant skips",
				"  /cupidsreset <player>             Reset machine (Admin only)",
				"",
				"── Coins Shop ──",
				"  /shopgive <player> <item>         Give item to player (free)",
				"  /shoptake <player> <item>         Remove item from player (Admin)",
				"  /shopcheck <player>               List player's owned items",
				"  /shopclearitems <player>          Clear session items (Admin)",
				"",
				"═══════════════════════════════════════",
			}, "\n")
		end
	})
	print("[ServiceCommands] ✓ servicehelp")

	print("═══════════════════════════════════════════")
	print("[ServiceCommands] ✓ All commands loaded!")
	print("  Adminboard : boardspin, boardskip, boardstatus, boardrefresh")
	print("  Cursed     : cursedgive, cursedgiveall, cursedcheck")
	print("  Cupids     : cupidscheck, cupidsgiveskip, cupidsreset")
	print("  Shop       : shopgive, shoptake, shopcheck, shopclearitems")
	print("  Help       : servicehelp")
	print("═══════════════════════════════════════════")
end

return module