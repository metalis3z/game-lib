local module = function(Conch, Config)
	local PollService = require(game.ServerScriptService.Services.PollService)
	local Net         = require(game.ReplicatedStorage.Packages.Net)

	local FakeVoteRemote = Net:RemoteEvent("PollService/FakeVotes")

	Conch.register("startfakepoll", {
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
				name = "VotesForOption1",
			},
			{
				kind = "argument",
				type = "number",
				name = "VotesForOption2",
			},
			{
				kind = "argument",
				type = "boolean",
				name = "KeepGoing", -- Yes = votes keep climbing for the full duration
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				optional = true,
			},
			{
				kind = "argument",
				type = "number",
				name = "AnimateOver",
				optional = true,
			}
		end,
		callback = function(question, option1, option2, votesA, votesB, keepGoing, duration, animateOver)
			if not question or question == "" then
				return false, "invalid question"
			end
			if not option1 or option1 == "" then
				return false, "invalid option1"
			end
			if not option2 or option2 == "" then
				return false, "invalid option2"
			end
			if type(votesA) ~= "number" or votesA < 0 then
				return false, "VotesForOption1 must be a non-negative number"
			end
			if type(votesB) ~= "number" or votesB < 0 then
				return false, "VotesForOption2 must be a non-negative number"
			end

			votesA      = math.floor(votesA)
			votesB      = math.floor(votesB)
			duration    = duration or 60
			animateOver = math.clamp(animateOver or 4, 1, duration - 1)

			local pollID = PollService.startPoll({
				question        = question,
				option1         = option1,
				option2         = option2,
				option1colorHex = "2197ff",
				option2colorHex = "da261a",
				duration        = duration,
				allowSwitch     = false,
			})

			if not pollID then
				return false, "failed to start poll"
			end

			task.delay(0.5, function()
				FakeVoteRemote:FireAllClients(votesA, votesB, animateOver, keepGoing, duration)
			end)

			return string.format(
				"fake poll started — animating to %s vs %s over %ds%s",
				votesA, votesB, animateOver,
				keepGoing and ", then keeping going for full duration" or ""
			)
		end,
	})
end

return module