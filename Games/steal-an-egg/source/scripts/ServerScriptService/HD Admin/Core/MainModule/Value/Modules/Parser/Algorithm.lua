--!nonstrict

--[[

Analyzes the given command name to determine whether or not it's appearance in a
commandstatement mandates that commandstatement to require a qualifierdescription
to be considered valid.

It is not always possible to determine qualifierdescription requirement solely from
the command name or the data associated with it but rather has to be confirmed further
from the information of the commandstatement it appears in.

1) If every argument for the command has playerArg ~= true then returns QualifierRequired.Never

2) If even one argument for the command has playerArg == true and hidden ~= true returns
	QualifierRequired.Always

3) If condition (1) and condition (2) are not satisfied, meaning every argument for
	the command has playerArg == true and hidden == true returns QualifierRequired.Sometimes

]]

local Algorithm = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local parserModules = modules.Parser
local Modifiers = require(parserModules.Modifiers)
local Qualifiers = require(parserModules.Qualifiers)
local ParserPatterns = require(parserModules.ParserPatterns)
local Commands = require(services.Commands)


function Algorithm.getCommandStatementsFromBatch(batch, prefixUsed)
	
	local ParserUtility =  require(modules.Parser.ParserUtility)
	-- Prefixes like '%' or '^' are valid setting, and we escape so they
	-- can't malform the pattern
	local escapedPrefix = ParserUtility.escapeSpecialCharacters(prefixUsed)
	local formattedPattern = string.format(
		ParserPatterns.commandStatementsFromBatchUnFormatted,
		escapedPrefix,
		escapedPrefix
	)
	local matches = ParserUtility.getMatches(batch, formattedPattern)
	return matches
end

function Algorithm.getDescriptionsFromCommandStatement(commandStatement)
	local ParserUtility = require(modules.Parser.ParserUtility)
	local descriptions = ParserUtility.getMatches(
		commandStatement,
		ParserPatterns.descriptionsFromCommandStatement
	)
	
	local extraArgumentDescription = {}
	local readFromIndex = 2 -- if parsedData.requiresQualifier LATER ON then remove the first index (so it becomes effectively 3)
	if #descriptions >= readFromIndex then
		for counter = readFromIndex, #descriptions do
			table.insert(extraArgumentDescription, descriptions[counter])
		end
	end

	return {
		descriptions[1] or "",
		descriptions[2] or "",
		extraArgumentDescription,
	}
end

function Algorithm.parseCommandDescription(commandDescription)
	local ParserUtility =  require(modules.Parser.ParserUtility)

	local commandsArr = Commands.getSortedNameAndAliasLengthArray()
	local modifiersArr = Modifiers.getSortedNameAndAliasLengthArray()
	local kindByLowerName: {[string]: string} = {}
	local combined: {string} = {}
	for _, name in commandsArr do
		local lower = (name :: string):lower()
		if not kindByLowerName[lower] then
			kindByLowerName[lower] = "command"
			table.insert(combined, name)
		end
	end
	for _, name in modifiersArr do
		local lower = (name :: string):lower()
		if not kindByLowerName[lower] then
			kindByLowerName[lower] = "modifier"
			table.insert(combined, name)
		end
	end
	table.sort(combined, function(nameA: string, nameB: string): boolean
		if #nameA == #nameB then return nameA < nameB end
		return #nameA > #nameB
	end)

	local capsuleCaptures, commandDescriptionResidue = ParserUtility.getCapsuleCaptures(commandDescription, combined)
	local plainCaptures, commandDescriptionResidue = ParserUtility.getPlainCaptures(commandDescriptionResidue, combined)

	local commandCaptures = {}
	local modifierCaptures = {}
	local function dispatch(captures)
		for _, capture in captures do
			for keyword in capture do
				local bucket = if kindByLowerName[tostring(keyword):lower()] == "modifier"
					then modifierCaptures
					else commandCaptures
				table.insert(bucket, capture)
				break
			end
		end
	end
	dispatch(capsuleCaptures)
	dispatch(plainCaptures)

	-- A longer modifier can eat into a command, like undo consuming ;undog and
	-- leaving 'g' with no command found. When the combined pass fails like that we
	-- retry with commands captured before modifiers, and only keep the retry if it
	-- takes the whole description
	if #commandCaptures == 0 or commandDescriptionResidue ~= "" then
		local retryCommandCapsules, retryResidue = ParserUtility.getCapsuleCaptures(commandDescription, commandsArr)
		local retryCommandPlains, retryResidue2 = ParserUtility.getPlainCaptures(retryResidue, commandsArr)
		local retryModifierCapsules, retryResidue3 = ParserUtility.getCapsuleCaptures(retryResidue2, modifiersArr)
		local retryModifierPlains, finalResidue = ParserUtility.getPlainCaptures(retryResidue3, modifiersArr)
		local retryCommandCaptures = {}
		local retryModifierCaptures = {}
		for _, captures in {retryCommandCapsules, retryCommandPlains} do
			for _, capture in captures do
				table.insert(retryCommandCaptures, capture)
			end
		end
		for _, captures in {retryModifierCapsules, retryModifierPlains} do
			for _, capture in captures do
				table.insert(retryModifierCaptures, capture)
			end
		end
		if #retryCommandCaptures > 0 and finalResidue == "" then
			commandCaptures = retryCommandCaptures
			modifierCaptures = retryModifierCaptures
			commandDescriptionResidue = finalResidue
		end
	end

	return {
		commandCaptures,
		modifierCaptures,
		commandDescriptionResidue,
	}
end

function Algorithm.parseQualifierDescription(qualifierDescription)
	local ParserUtility =  require(modules.Parser.ParserUtility)

	local qualifierCaptures, qualifierDescriptionResidue = ParserUtility.getCapsuleCaptures(
		qualifierDescription,
		Qualifiers.getSortedNameAndAliasLengthArray()
	)
	
	local qualifiers = ParserUtility.getMatches(
		qualifierDescriptionResidue,
		ParserPatterns.argumentsFromCollection
	)
	local unrecognizedQualifiers = {}

	local qualifierDictionary = Qualifiers.getLowercaseDictionary()
	for _, match in qualifiers do
		if match ~= "" then
			match = match :: any
			if not qualifierDictionary[match:lower()] then
				table.insert(unrecognizedQualifiers, match)
			end
			table.insert(qualifierCaptures, { [match] = {} })
		end
	end

	return {
		qualifierCaptures,
		unrecognizedQualifiers,
	}
end

function Algorithm.parseExtraArgumentDescription(extraArgumentDescription)
end


return Algorithm