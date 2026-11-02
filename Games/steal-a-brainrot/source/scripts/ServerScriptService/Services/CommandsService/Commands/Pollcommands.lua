local module = function(Conch, Config)
	local PollService = require(game.ServerScriptService.Services.PollService)

	-- ============================================================
	-- COMMANDE : startpoll (sondage local au serveur)
	-- ============================================================
	Conch.register("startpoll", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Question",
				},
			{
				kind = "argument",
				type = "string",
				name = "Option1",
			},
			{
				kind = "argument",
				type = "string",
				name = "Option2",
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				optional = true,
			},
			{
				kind = "argument",
				type = "boolean",
				name = "AllowSwitch",
				optional = true,
			}
		end,
		callback = function(question, option1, option2, duration, allowSwitch)
			if not question or question == "" then
				return false, "invalid question"
			end
			if not option1 or option1 == "" then
				return false, "invalid option1"
			end
			if not option2 or option2 == "" then
				return false, "invalid option2"
			end
			if duration ~= nil and (type(duration) ~= "number" or duration < 5) then
				return false, "duration must be a number of at least 5"
			end
			local pollID = PollService.startPoll({
				question        = question,
				option1         = option1,
				option2         = option2,
				option1colorHex = "2197ff",
				option2colorHex = "da261a",
				duration        = duration or 30,
				allowSwitch     = allowSwitch ~= false,
			})
			if not pollID then
				return false, "failed to start poll"
			end
			return "poll started"
		end,
	})

	-- ============================================================
	-- COMMANDE : endpoll (termine le sondage local)
	-- ============================================================
	Conch.register("endpoll", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
		end,
		callback = function()
			PollService.endActivePoll()
			return "poll ended"
		end,
	})

	-- ============================================================
	-- COMMANDE : startglobalpoll (sondage global sur tous les serveurs)
	-- Les votes de tous les serveurs sont centralisés et affichés ensemble
	-- ============================================================
	Conch.register("startglobalpoll", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Question",
				},
			{
				kind = "argument",
				type = "string",
				name = "Option1",
			},
			{
				kind = "argument",
				type = "string",
				name = "Option2",
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				optional = true,
			},
			{
				kind = "argument",
				type = "boolean",
				name = "AllowSwitch",
				optional = true,
			}
		end,
		callback = function(question, option1, option2, duration, allowSwitch)
			if not question or question == "" then
				return false, "invalid question"
			end
			if not option1 or option1 == "" then
				return false, "invalid option1"
			end
			if not option2 or option2 == "" then
				return false, "invalid option2"
			end
			if duration ~= nil and (type(duration) ~= "number" or duration < 5) then
				return false, "duration must be a number of at least 5"
			end
			local pollID = PollService.startGlobalPoll({
				question        = question,
				option1         = option1,
				option2         = option2,
				option1colorHex = "2197ff",
				option2colorHex = "da261a",
				duration        = duration or 30,
				allowSwitch     = allowSwitch ~= false,
			})
			if not pollID then
				return false, "failed to start global poll"
			end
			return "global poll started"
		end,
	})

	-- ============================================================
	-- COMMANDE : endglobalpoll (termine le sondage sur tous les serveurs)
	-- ============================================================
	Conch.register("endglobalpoll", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
		end,
		callback = function()
			PollService.endGlobalPoll()
			return "global poll ended"
		end,
	})
end

return module