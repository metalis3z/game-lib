--!strict

--[[

	This runs both vote and globalVote

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Task = require(modules.Objects.Task)
local Prompt = require(modules.Prompt)
local Vote = require(modules.Prompt.Vote)
local Players = game:GetService("Players")
local taskLibrary = task
local GLOBAL_COMMAND_KEY = "globalvote"


-- LOCAL FUNCTIONS
local function buildStatement(task: Task.Class, modifiers: {[string]: any}): any
	local taskAny = task :: any
	return {
		isValid = true,
		isConverted = true,
		commands = {[task.commandKey] = taskAny.args},
		modifiers = modifiers,
		qualifiers = taskAny.qualifiers or {},
	}
end


return function(task: Task.Class)
	local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
	local question = task:getArg("Text")
	local options = task:getArg("Fields")
	local caller = task.caller
	if typeof(question) ~= "string" or question:gsub(" ", "") == "" then
		if caller then
			Prompt.error(caller, "Votes need a question, like ;vote Best colour? || Red | Blue")
		end
		return
	end
	if typeof(options) ~= "table" or #options < 1 then
		if caller then
			Prompt.error(caller, "Votes need at least 1 answer, like ;vote Best colour? || Red | Blue")
		end
		return
	end
	-- An empty or invalid capsule parses to 0 rather than nil, so the 2 minute
	-- default lands here instead of through the arg
	local voteTime = math.floor(tonumber(task:getArg("OptionalVoteTime")) or 0)
	local duration = math.clamp(if voteTime < 1 then 120 else voteTime, 1, 604800)
	local taskAny = task :: any
	local modifiers = if typeof(taskAny.modifiers) == "table" then taskAny.modifiers else {}
	local isGlobalPoll = task.commandKey == GLOBAL_COMMAND_KEY
	local globalUID = if typeof(modifiers.globalUID) == "string" then modifiers.globalUID else nil
	local isCollector = true
	if isGlobalPoll and globalUID then
		isCollector = modifiers.globalOrigin == true
	elseif isGlobalPoll then
		local Modifiers = require(modules.Parser.Modifiers) :: any
		local statement = buildStatement(task, {global = {}})
		-- Our question and answers are already filtered, so they bypass a secondary check
		local filteredOverrides = {}
		local textIndex = task:getArgIndex("Text")
		local fieldsIndex = task:getArgIndex("Fields")
		if textIndex then
			filteredOverrides[tostring(textIndex)] = question
		end
		if fieldsIndex then
			filteredOverrides[tostring(fieldsIndex)] = options
		end
		statement.argOverrides = {[task.commandKey] = filteredOverrides}
		Modifiers.broadcastGlobalStatement(task.callerUserId, statement)
		local stampedUID = statement.modifiers.globalUID
		globalUID = if typeof(stampedUID) == "string" then stampedUID else nil
	end
	local fromUserId = if typeof(task.callerUserId) == "number" then task.callerUserId else nil
	local shareResults = task:getArg("OptionalShareResults") == true
	local colorSeed = globalUID or require(modules.DataUtil.generateUID)(10)
	local endedEarly = false
	local finishedNaturally = false
	if isGlobalPoll and isCollector and globalUID then
		task:onEnded(function()
			if finishedNaturally then
				return
			end
			local GlobalStatements = require(modules.Parent.Services.Tasks.GlobalStatements) :: any
			GlobalStatements.broadcast(task.callerUserId, buildStatement(task, {undo = {}}))
		end)
	end
	if caller then
		task:bindPrompt({
			title = `Poll Details: "{question}"`,
			text = "",
			audience = caller,
			deactivate = false,
			duration = duration, -- the card's bar drains alongside the poll it opened
			votePreview = {question = question, options = options, duration = duration, fromUserId = fromUserId, colorSeed = colorSeed},
			buttons = {
				{
					label = "End",
					style = "Neutral",
					confirm = true,
					onActivate = function()
						endedEarly = true
						-- We can't use the task's own wait here because its hold would block
						-- the destroy we wait on
						local heldFor = 0
						while task.isActive and heldFor < 10 do
							taskLibrary.wait(0.2)
							heldFor += 0.2
						end
					end,
				},
			},
		})
	end

	local session = Vote.open(task, {
		question = question,
		options = options,
		duration = duration,
		targets = targets,
		fromUserId = fromUserId,
		colorSeed = colorSeed,
	})
	local voteEndsAt = session.deadline
	while task.isActive and os.clock() < voteEndsAt and not endedEarly do
		task.wait(0.5)
		if Vote.allResponded(session) then
			break
		end
	end
	Vote.finish(session)
	if not task.isActive then
		return
	end
	finishedNaturally = true
	local scores, didNotVote = Vote.tally(session)

	if not globalUID then
		local results = Vote.buildResults(options, scores, didNotVote)
		local payload = {question = question, results = results, fromUserId = fromUserId, colorSeed = colorSeed}
		if caller and caller.Parent then
			Vote.displayResults(caller, payload)
		end
		if shareResults then
			for _, target in targets do
				if target.Parent and target ~= caller then
					Vote.displayResults(target, payload)
				end
			end
		end
		return
	end

	if isCollector then
		-- Receiving servers start about a second late, so this lets their final
		-- tallies land in the table before we add everything
		local collectAt = voteEndsAt + Vote.GLOBAL_GRACE
		while task.isActive and os.clock() < collectAt and not endedEarly do
			task.wait(1)
		end
		if not task.isActive then
			return
		end
		local summedScores, summedDidNotVote = Vote.collectTallies(globalUID, #options)
		for index = 1, #options do
			summedScores[index] += scores[index] or 0
		end
		summedDidNotVote += didNotVote
		local results = Vote.buildResults(options, summedScores, summedDidNotVote)
		local payload = {question = question, results = results, fromUserId = fromUserId, showToEveryone = shareResults, colorSeed = colorSeed}
		Vote.publishResults(globalUID, payload)
		if caller and caller.Parent then
			Vote.displayResults(caller, payload)
		end
		if shareResults then
			for _, player in Players:GetPlayers() do
				if player ~= caller then
					Vote.displayResults(player, payload)
				end
			end
		end
	else
		Vote.publishTally(globalUID, scores, didNotVote)
		while task.isActive and os.clock() < voteEndsAt do
			task.wait(1)
		end
		local pollDeadline = voteEndsAt + Vote.GLOBAL_GRACE + Vote.RESULTS_POLL_TIMEOUT
		local payload: any = nil
		while task.isActive and os.clock() < pollDeadline do
			task.wait(Vote.RESULTS_POLL_INTERVAL)
			payload = Vote.fetchResults(globalUID)
			if payload ~= nil then
				break
			end
		end
		if not task.isActive or typeof(payload) ~= "table" or payload.showToEveryone ~= true then
			return
		end
		if typeof(payload.results) ~= "table" or typeof(payload.question) ~= "string" then
			return
		end
		for _, player in Players:GetPlayers() do
			Vote.displayResults(player, payload)
		end
	end
end
