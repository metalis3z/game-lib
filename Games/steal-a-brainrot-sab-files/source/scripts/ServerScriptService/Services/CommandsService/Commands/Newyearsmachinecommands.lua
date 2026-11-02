local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local ReplicatedStorage   = game:GetService("ReplicatedStorage")

	local NewYearsMachineService = require(ServerScriptService.Services.NewYearsMachineService)
	local FFlags = require(ReplicatedStorage.Packages.FFlags)

	print("[NewYearsCommands] Loading...")

	--------------------------------------------------------------------------------
	-- nyesstatus  — show current machine state
	--------------------------------------------------------------------------------
	Conch.register("nyesstatus", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			local s = NewYearsMachineService:GetState()

			local fflagEnabled = FFlags:GetInstant("NewYearsMachine/Enabled", true)
			local fflagEndTime = FFlags:GetInstant("NewYearsMachine/EndTime", nil)

			local endTimeStr = "none"
			if fflagEndTime then
				endTimeStr = os.date("%X %x", fflagEndTime)
			end

			local lines = {
				"═══ New Years Machine Status ═══",
				string.format("Enabled      : %s", tostring(fflagEnabled)),
				string.format("End Time     : %s", endTimeStr),
				string.format("Event Active : %s", tostring(s.eventActive)),
				string.format("Event Name   : %s", s.eventName),
				string.format("Fill         : %d/%d  (%d%%)",
					s.fillCount, s.fillGoal, s.fillPercent),
				string.format("Fill (attr)  : %.3f", s.fillAttribute),
				string.format("Event Dur    : %ds", s.eventDuration),
			}

			return true, table.concat(lines, "\n")
		end
	})
	print("[NewYearsCommands] ✓ nyesstatus")

	--------------------------------------------------------------------------------
	-- nyesfill  — force-fill machine and trigger the event immediately
	--------------------------------------------------------------------------------
	Conch.register("nyesfill", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			local ok, err = NewYearsMachineService:ForceFill()
			if not ok then
				return false, "Cannot fill: " .. tostring(err)
			end
			return true, "✓ Machine force-filled! 2026 event triggered."
		end
	})
	print("[NewYearsCommands] ✓ nyesfill")

	--------------------------------------------------------------------------------
	-- nyesadd  — add N deliveries worth of fill without a player
	--------------------------------------------------------------------------------
	Conch.register("nyesadd", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function()
			return {
				kind     = "argument",
				type     = "number",
				name     = "Amount",
				optional = true,
			}
		end,
		callback = function(amount)
			local n = tonumber(amount) or 1
			if n < 1 or n > 100 then
				return false, "Amount must be between 1 and 100."
			end
			local ok, err = NewYearsMachineService:AddFill(n)
			if not ok then
				return false, "Cannot add fill: " .. tostring(err)
			end
			local s = NewYearsMachineService:GetState()
			return true, string.format(
				"✓ Added %d fill → %d/%d (%d%%)",
				n, s.fillCount, s.fillGoal, s.fillPercent)
		end
	})
	print("[NewYearsCommands] ✓ nyesadd")

	--------------------------------------------------------------------------------
	-- nyesreset  — reset fill to 0 and cancel the active event
	--------------------------------------------------------------------------------
	Conch.register("nyesreset", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			NewYearsMachineService:ForceReset()
			return true, "✓ Machine fill reset to 0. Event cleared."
		end
	})
	print("[NewYearsCommands] ✓ nyesreset")

	--------------------------------------------------------------------------------
	-- nyesgoal  — change how many deliveries are needed to fill the machine
	--------------------------------------------------------------------------------
	Conch.register("nyesgoal", {
		permissions = { "admin" },
		arguments   = function()
			return {
				kind = "argument",
				type = "number",
				name = "Goal",
			}
		end,
		callback = function(goal)
			local n = tonumber(goal)
			if not n or n < 1 or n > 500 then
				return false, "Goal must be a number between 1 and 500."
			end
			NewYearsMachineService:SetFillGoal(n)
			return true, string.format("✓ Fill goal set to %d deliveries.", n)
		end
	})
	print("[NewYearsCommands] ✓ nyesgoal")

	--------------------------------------------------------------------------------
	-- nyesenable / nyesdisable  — toggle the machine on or off via FFlag
	--------------------------------------------------------------------------------
	Conch.register("nyesenable", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			NewYearsMachineService:SetEnabled(true)
			return true, "✓ New Years Machine ENABLED."
		end
	})
	print("[NewYearsCommands] ✓ nyesenable")

	Conch.register("nyesdisable", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			NewYearsMachineService:SetEnabled(false)
			return true, "✓ New Years Machine DISABLED. Players can no longer deliver."
		end
	})
	print("[NewYearsCommands] ✓ nyesdisable")

	--------------------------------------------------------------------------------
	-- nyesduration  — change how long the 2026 event lasts
	--------------------------------------------------------------------------------
	Conch.register("nyesduration", {
		permissions = { "admin" },
		arguments   = function()
			return {
				kind = "argument",
				type = "number",
				name = "Seconds",
			}
		end,
		callback = function(secs)
			local n = tonumber(secs)
			if not n or n < 10 or n > 3600 then
				return false, "Duration must be between 10 and 3600 seconds."
			end
			NewYearsMachineService:SetEventDuration(n)
			return true, string.format("✓ Event duration set to %ds.", n)
		end
	})
	print("[NewYearsCommands] ✓ nyesduration")

	--------------------------------------------------------------------------------
	-- nyeshelp  — list all commands
	--------------------------------------------------------------------------------
	Conch.register("nyeshelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments   = function() return {} end,
		callback    = function()
			return true, table.concat({
				"═══ New Years Machine Commands ═══",
				"",
				"▸ /nyesstatus              Show fill %, event state, FFlags",
				"▸ /nyesfill               Force-fill → trigger 2026 event now",
				"▸ /nyesadd [amount]        Add N deliveries worth of fill (default 1)",
				"▸ /nyesreset              Reset fill to 0, clear event",
				"▸ /nyesenable             Enable the machine (FFlag on)",
				"▸ /nyesdisable            Disable the machine (FFlag off)",
				"▸ /nyesgoal <n>           Set fill goal (Admin only)",
				"▸ /nyesduration <secs>    Set event duration (Admin only)",
				"▸ /nyeshelp               Show this message",
				"",
				"══════════════════════════════════",
			}, "\n")
		end
	})
	print("[NewYearsCommands] ✓ nyeshelp")

	print("══════════════════════════════════════════")
	print("[NewYearsCommands] ✓ All commands loaded!")
	print("  nyesstatus  nyesfill  nyesadd  nyesreset")
	print("  nyesenable  nyesdisable  nyesgoal  nyesduration  nyeshelp")
	print("══════════════════════════════════════════")
end

return module