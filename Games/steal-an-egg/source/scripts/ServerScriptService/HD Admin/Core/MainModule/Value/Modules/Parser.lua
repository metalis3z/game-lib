--!strict
-- CONFIG
local MAX_CHARACTERS_PER_MESSAGE = 1000 -- max characters per message before trimming, stops abuse like pasting a 10,000+ char message


-- LOCAL
local Parser = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local ParserTypes = require(script.ParserTypes)


-- FUNCTIONS
function Parser.parse(message: string, optionalUser: any?): ParserTypes.ParsedBatch
	-- This is ONLY useable on the SERVER
	local services = modules.Parent.Services
	local Commands = require(services.Commands)
	local Config = require(modules.Parent.Services.Config)
	local Modifiers = require(modules.Parser.Modifiers)
	local User = require(modules.Objects.User)

	local Algorithm = require(script.Algorithm)
	local forEveryCommand = require(script.Parent.CommandUtil.forEveryCommand)
	local ParsedData = require(script.ParsedData)
	local allParsedDatas = {}

	if typeof(message) ~= "string" then
		message = ""
	end

	-- Trim message to avoid abuse
	if #message > MAX_CHARACTERS_PER_MESSAGE then
		message = string.sub(message, 1, MAX_CHARACTERS_PER_MESSAGE)
	end
	
	-- Player.Chatted processes ">" as "&gt;" and "<" as "&lt;"
	-- like , if someone chatted ">kill me", it produces "&gt;kill me"
	-- This reverts this behaviour so that these characters can be used as prefixes
	message = string.gsub(message, "&gt;", ">")
	message = string.gsub(message, "&lt;", "<")

	-- Account for 'silent' commands by supporting '/e' (like "/e ;fly me")
	if string.sub(message,1,3) == "/e " then
		message = string.sub(message,4)
	end

	-- Retrieve the first character of the message
	-- If blank, ignore
	local firstPos = string.find(message, "%S") :: number
	local firstChar = if firstPos then string.sub(message, firstPos, firstPos) else nil
	if firstChar == nil then
		return {}
	end

	-- Otherwise make sure the first character is a valid prefix
	-- If it's not valid, we ignore parsing entirely and save resources
	local secondChar = string.sub(message, firstPos+1, firstPos+1)
	local commandPrefixes = Commands.getCommandPrefixes()
	local validPrefixesForThisUser = {}
	local defaultGamePrefix = Config.getSetting("Prefix")
	local usersPrefix = Config.getSetting("Prefix", optionalUser)
	local isCommandSpecificPrefix = firstChar ~= defaultGamePrefix and firstChar ~= usersPrefix
	validPrefixesForThisUser[defaultGamePrefix] = true
	validPrefixesForThisUser[usersPrefix] = true
	for prefix, _ in commandPrefixes do
		validPrefixesForThisUser[prefix] = true
	end
	if not validPrefixesForThisUser[firstChar] then
		return {}
	end

	-- This is the main parser handler which breaks down the message into
	-- readable statements of information
	local givenPrefix = firstChar
	local statements = Algorithm.getCommandStatementsFromBatch(message, givenPrefix)
	for _, commandStatement in statements do
		
		-- Step 1
		local parsedData = ParsedData.generateEmptyParsedData(givenPrefix) :: any
		parsedData.commandStatement = commandStatement

		-- Step 2
		ParsedData.parseCommandStatement(parsedData)
		if not parsedData.isValid then
			table.insert(allParsedDatas, parsedData :: any)
			continue
		end

		-- Step 3
		ParsedData.parseCommandDescriptionAndSetFlags(parsedData :: any, optionalUser)
		if not parsedData.isValid then
			table.insert(allParsedDatas, parsedData)
			continue
		end

		-- Step 4
		ParsedData.parseQualifierDescription(parsedData :: any)
		if not parsedData.isValid then
			table.insert(allParsedDatas, parsedData)
			continue
		end

		-- Step 5
		parsedData = parsedData :: any
		ParsedData.parseExtraArgumentDescription(parsedData, allParsedDatas, message)
		table.insert(allParsedDatas, parsedData)
		if parsedData.hasTextArgument then
			break
		end
	end

	-- Step 6
	local parsedBatch = ParsedData.generateOrganizedParsedData(allParsedDatas)
	
	-- Step 7, final command configuration
	for _, statement in parsedBatch do
		local modifiers = statement.modifiers
		local namesToChange = {}
		local statementCommands = statement.commands
		for commandName, _ in statementCommands do

			-- Check each command in parsedData is runnable with the given prefix,
			-- otherwise convert it into an error statemen
			local originalCommandName = commandName
			local command, isOverride = Commands.getCommand(commandName, givenPrefix)
			if command == nil then
				ParsedData.invalidateStatement(statement, `Command '{commandName}' does not exist`)
				continue
			end
			local isValidWithPrefix = true
			local silencedCommand = command :: any
			local prefixes = silencedCommand.prefixes
			if isCommandSpecificPrefix and not isOverride then
				isValidWithPrefix = false
				if prefixes then
					for _, prefix in (prefixes :: any) do
						if prefix == firstChar then
							isValidWithPrefix = true
							break
						end
					end
				end
			end
			local userAndDefaultPrefixMatchButIsOverride = firstChar == secondChar -- We do this because prefix data is eliminated when parsed
			if isOverride or not isValidWithPrefix or userAndDefaultPrefixMatchButIsOverride then
				commandName = givenPrefix..commandName
				if not isValidWithPrefix then
					local overrideCommand = Commands.getCommand(commandName)
					if overrideCommand == nil then
						ParsedData.invalidateStatement(statement, `Override command '{commandName}' does not exist`)
						continue
					end
					isValidWithPrefix = true
				end
				namesToChange[originalCommandName] = commandName
			end
			if isValidWithPrefix == false then
				ParsedData.invalidateStatement(statement, `Command '{commandName}' is not valid with prefix '{firstChar}`)
				continue
			end

			-- If commandName is an undoAlias, make sure the command has an undo modifier
			local commandNameLower = commandName:lower()
			local undoAliases = command.undoAliases
			if typeof(undoAliases) == "table" and not modifiers.undo and not modifiers.un then
				for _, alias in undoAliases do
					if typeof(alias) == "string" and alias:lower() == commandNameLower then
						modifiers.undo = {}
					end
				end
			end

		end

		-- We replace override names at the end to guarantee the entire dictionary is first checked
		for originalName, newName in namesToChange do
			statementCommands[newName] = statementCommands[originalName]
			statementCommands[originalName] = nil
		end
	end

	return parsedBatch
end

function Parser.addCapsule(baseString: string, capsuleStringOrStrings: string | {string})
	-- This is useable on both server and client
	-- Wraps the capsule string within capsule brackets (), and if more than one item, also
	-- separates them with commas (or whatever the Collective is set to)
	local ParserSettings = require(modules.Parser.ParserSettings)
	local collective = ParserSettings.Collective
	local capsuleString = capsuleStringOrStrings
	if typeof(capsuleStringOrStrings) == "table" then
		capsuleString = table.concat(capsuleStringOrStrings, collective)
	end
	if capsuleString == "" or capsuleString == " " then
		return baseString
	end
	return `{baseString}({capsuleString})`
end

function Parser.unparse(commandName: string, modifiers: {string}, ...: any): string
	-- This is useable on both server and client
	-- It accepts a commandName, modifierStringArray, and arg results of that command,
	-- which we then turn into a stringified version of the command, like:
	-- ";globalPaint me,role(admin) 255,0,0"

	-- First we make sure the command is an actual command otherwise the args can't be unparsed
	local getCommand = require(modules.CommandUtil.getCommand)
	local command = getCommand(commandName)
	if not command then
		return ";unknownResult"
	end

	-- Now we organise each arg and prepare it to be parsed
	-- It's important we determine how many endlessArgs there are because
	-- this will require modifying their result if > 2
	local commandArgs = command.args
	local Args = require(modules.Parser.Args)
	local valuesToUnParse = {...}
	local parsedArray: {string} = {}
	local function forEveryArg(callback)
		for argIndex, argNameOrInfo in commandArgs do
			local argInfo = Args.get(argNameOrInfo) or argNameOrInfo
			argInfo = argInfo :: any
			callback(argInfo, argIndex)
		end
	end
	local totalEndlessArgs = 0
	local endlessArgStartIndex = 0
	forEveryArg(function(argInfo, argIndex)
		if argInfo.endlessArg then
			if totalEndlessArgs == 0 then
				endlessArgStartIndex = argIndex
			end
			totalEndlessArgs = totalEndlessArgs + 1
		end
	end)
	
	-- Now we unparse each arg with its given value (to become stringified)
	local ParserSettings = require(modules.Parser.ParserSettings)
	local totalArgs = #commandArgs
	local commandCapsuleArray = {}
	forEveryArg(function(argInfo, argIndex)
		local stringValue = ""
		local isCapsuleArg = argInfo and argInfo.hidden == true and not argInfo.playerArg
		local isEmptyValue = valuesToUnParse[argIndex] == ParserSettings.EmptyUnparsedValue
		-- For items like OptionalBanDuration
		if isEmptyValue and not isCapsuleArg then
			table.insert(parsedArray, ParserSettings.EmptyUnparsedValue)
			return
		end
		local unparse = argInfo and argInfo.unparse
		if unparse and not isEmptyValue then
			local newStringValue = argInfo:unparse(valuesToUnParse[argIndex])
			if typeof(newStringValue) == "string" then
				if argIndex >= endlessArgStartIndex and totalEndlessArgs > 1 and argIndex ~= totalArgs then
					newStringValue = newStringValue..ParserSettings.EndlessArgCutPattern
				end
				stringValue = newStringValue
			end
		end
		if argInfo.playerArg and stringValue == "" then
			return
		end
		if isCapsuleArg then
			-- We add to the command capsule (like ;paint(255,0,0) me) if it's
			-- an optionalArgument but not an optional player argument
			-- (such as 'OptionalColor' in the 'Hint' command)
			-- An empty value stays as "" so later capsule items keep their position,
			-- because the parser matches capsule items to hidden args by position
			table.insert(commandCapsuleArray, stringValue :: string)
		else
			table.insert(parsedArray, stringValue :: string)
		end
	end)

	-- Empty capsule slots at the end can be dropped, and when every slot is
	-- empty addCapsule then skips the capsule altogether
	for index = #commandCapsuleArray, 1, -1 do
		if commandCapsuleArray[index] ~= "" then
			break
		end
		table.remove(commandCapsuleArray, index)
	end

	-- It's important if >= 2 modifiers, that all modifiers contain a capsule, even
	-- if empty, so it's read properly by the parser
	if modifiers and #modifiers >= 2 then
		for index, modifier in modifiers do
			if not string.find(modifier, "%b()") then
				modifiers[index] = modifier.."()"
			end
		end
	end

	-- Next, we want to build the command string, which includes the command name
	-- and any modifiers (like global, loop, etc). For this, we capitalise each
	-- item *except* for the first item, which is lowercased, to make it easy
	-- and presentable to read
	local commandStartArray: {string} = {}
	local capitalize = require(modules.DataUtil.capitalize)
	if modifiers then
		for _, modifierAndCapsule in modifiers do
			local capitalizedModifier = capitalize(modifierAndCapsule)
			table.insert(commandStartArray, capitalizedModifier)
		end
	end
	local capitalizedCommandName = capitalize((command :: any).name or commandName)
	table.insert(commandStartArray, capitalizedCommandName)
	local firstItemLower = (commandStartArray[1] or ""):lower()
	commandStartArray[1] = firstItemLower

	-- Finally, we combine it all together and add that prefix at the start
	local spaceSeparator = ParserSettings.SpaceSeparator
	local unparsedArgsSpacedOut = table.concat(parsedArray, spaceSeparator)
	local commandStart = table.concat(commandStartArray, "")
	local commandCapsule = Parser.addCapsule("", commandCapsuleArray)
	local getYouSetting = require(modules.CommandUtil.getYouSetting)
	local prefix = (command :: any).prefix or getYouSetting("Prefix") or ""
	local unparsedString = `{prefix}{commandStart}{commandCapsule}{spaceSeparator}{unparsedArgsSpacedOut}`
	return unparsedString
end


return Parser