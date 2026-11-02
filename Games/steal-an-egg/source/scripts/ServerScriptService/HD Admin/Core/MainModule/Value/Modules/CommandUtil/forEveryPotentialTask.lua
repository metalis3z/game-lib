
local mainValue = script:FindFirstAncestor("MainModule").Value
local modules = mainValue.Modules
local services = mainValue.Services
local parser = modules.Parser
local ParserTypes = require(parser.ParserTypes)
local Task = require(modules.Objects.Task)

type Statement = ParserTypes.ParsedStatement
type Command = Task.Command
type ArgGroup = {[string]: {string}}
type Task = Task.Class
type EntryKind = "permPinned" | "joinPlayers" | "joinServer"
type Properties = Task.Properties

return function(callerUserId: number | string, statement: Statement, callback: (command: Command, arguments: ArgGroup, optionalTargetUserId: number?, entryKind: EntryKind?) -> (boolean?))
	local Commands = require(services.Commands :: any)
	local Args = require(parser.Args)
	local tasks: {any} = {}
	for commandName, arguments in statement.commands do

		local command = Commands.getCommand(commandName) :: Command?
		if not command or typeof(command.args) ~= "table" then
			continue
		end

		local getEffectiveModifiers = require(modules.CommandUtil.getEffectiveModifiers)
		local effectiveModifiers: ArgGroup = getEffectiveModifiers(command, (statement.modifiers or {}) :: ArgGroup) :: ArgGroup

		-- PermSpawn pins the players matched right now (one potential task per user,
		-- so the saved entry can follow that user across servers and respawns). Every
		-- other perm shape acts at the game level with one joinServer entry that runs
		-- everywhere now and replays on every startup, resolving its qualifiers fresh
		-- each time. Perm with join stores one joinPlayers entry covering everyone here
		-- now plus every future joiner on every server. Join alone is no entry at all,
		-- its single task watches this server's joins until cancelled
		local entryKind: EntryKind? = nil
		local splitIntoUsers = false
		local firstArgNameOrDetail = command.args[1]
		local firstArg = Args.get(firstArgNameOrDetail)
		local hasPlayerArg = if firstArg then firstArg.playerArg == true else false
		local runForEachPlayer = if firstArg then hasPlayerArg and firstArg.runForEachPlayer else false
		if effectiveModifiers.perm and effectiveModifiers.join then
			entryKind = "joinPlayers"
		elseif effectiveModifiers.perm then
			if effectiveModifiers.spawn and runForEachPlayer then
				entryKind = "permPinned"
				splitIntoUsers = true
			else
				entryKind = "joinServer"
			end
		elseif not effectiveModifiers.join then
			splitIntoUsers = runForEachPlayer
		end

		-- Define the properties that we'll create the task from arguments
		local args = (arguments or {}) :: ArgGroup
		local qualifiers = (statement.qualifiers or {}) :: ArgGroup
		local modifiers = effectiveModifiers

		-- Create task wrapper
		local function newPotentialTask(optionalTargetUserId: number?)
			return callback(command, args, optionalTargetUserId, entryKind)
		end

		-- Tasks are split into separate players (such as those with the 'Player' arg),
		-- while some do not (such as those with the 'Players' arg, or without any type
		-- of player arg at all)
		if not splitIntoUsers then
			newPotentialTask()
		else
			local targetPlayers = if firstArg then firstArg:parse(statement.qualifiers, callerUserId) else {}
			for _, plr in targetPlayers do
				local keepRunning = newPotentialTask(plr.UserId)
				if keepRunning == false then
					break
				end
			end
		end
	end
end