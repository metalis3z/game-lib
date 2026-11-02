--!strict

--[[

To do:
	- Consider make inputObject return a function WHICH returns a table, so that
	  callerUserId specific considerations can be made (such as limits)
	  (but first consdier how this works with global networking)
	  
--]]

-- CONFIG
local DEFAULT_MAX_CHARACTERS = 100
local TEXT_MAX_CHARACTERS = 420
local KEYS_TO_MOVE_INTO_INPUT_OBJECT = { -- Make sure to also update 'ArgTypes.lua'
		"default",
		"min",
		"title",
		"max",
		"maxItems",
		"step",
		"useSlider",
		"logarithmic",

	}


-- LOCAL
local Args = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local hdConfig = script:FindFirstAncestor("HD Admin").Config
local LoaderArgs = require(hdConfig.Args)
local UI = modules.Parent.Controllers.UI
local InputObjects = require(UI.Config.InputObjects)
local ArgTypes = require(modules.Parser.Args.ArgTypes)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local requiresUpdating = true
local sortedNameAndAliasLengthArray = {}
local lowerCaseDictionary = {}
local isServer = RunService:IsServer()
local isTableEmpty = require(modules.TableUtil.isTableEmpty)
local splitByCollective = require(modules.Parser.splitByCollective)
local ParserSettings = require(modules.Parser.ParserSettings)
local endlessFieldsPattern = ParserSettings.EndlessFieldsPattern


-- LOCAL FUNCTIONS
local function register(item: ArgumentDetail): ArgumentDetail
	return item :: ArgumentDetail -- We do this to support type checking within the table
end

local function newParse(callback: (...any) -> (...any)): (...any) -> (...any)
	-- Makes sure every incoming string is safe so that we strip dangerous values like nan and inf
	return function(self, stringToParse, ...)
		local maxCharacters = self.maxCharacters
		if typeof(stringToParse) ~= "table" then
			-- Arg inputs for Players are already converted from strings to tables so ignore those
			stringToParse = Args.processStringToParse(stringToParse, maxCharacters)
		end
		return callback(self, stringToParse, ...)
	end
end

local function processDeveloperArg(argumentDetail: ArgumentDetail)
	-- Make sure newParse and all relevant properties are set on the developer's argumentDetail
	if typeof(argumentDetail) ~= "table" then
		argumentDetail = {} :: ArgumentDetail
	end
	local parse = argumentDetail.parse
	if typeof(parse) == "function" and argumentDetail.hasUpdatedParse ~= true then
		argumentDetail.hasUpdatedParse = true
		argumentDetail.parse = newParse(parse :: any)
	end
	return argumentDetail
end

local function moveMultiKeysIntoInputObject(argumentDetail: ArgumentDetail)
	argumentDetail = argumentDetail :: any
	for _, key in KEYS_TO_MOVE_INTO_INPUT_OBJECT do
		local value = argumentDetail[key]
		if value == nil then
			continue
		end
		local inputObject = argumentDetail.inputObject :: any
		if not argumentDetail.inputObject then
			inputObject = {}
			argumentDetail.inputObject = inputObject
		end
		-- Only fill gaps. A key declared directly on the inputObject wins, otherwise
		-- OptionalPlayers' "all" run page seed gets clobbered by its {} arg default
		if inputObject[key] == nil then
			inputObject[key] = value
		end
	end
	return argumentDetail
end

local function becomeArg(item: ArgumentDetail, toBecomeName: string)
	local argToBecome = Args.items[toBecomeName]
	local argKeyCorrected = item.key
	if not argToBecome then
		error(`Args: {argKeyCorrected} can not become alias because {toBecomeName} is not a valid argument`)
	end
	argToBecome = argToBecome :: any
	if (argToBecome :: any).mustCreateAliasOf then
		becomeArg(argToBecome, (argToBecome :: any).mustCreateAliasOf)
	end
	item = item :: any
	local deepCopyTable = require(modules.TableUtil.deepCopyTable)
	-- Move the alias's own top-level keys in before inheriting. The base's
	-- inputObject already holds its own moved-in values (like Number's 0
	-- default), so copying it first would have the gap-fill below discard
	-- the alias's overrides
	moveMultiKeysIntoInputObject(item)
	for key, value in argToBecome do
		if key == "inputObject" and typeof(value) == "table" and typeof(item.inputObject) == "table" then
			-- Merge per key instead of skipping, so the alias still inherits
			-- whatever it never set (like Number's inputType)
			for subKey, subValue in value :: {[string]: any} do
				if (item.inputObject :: any)[subKey] == nil then
					if typeof(subValue) == "table" then
						subValue = deepCopyTable(subValue)
					end
					(item.inputObject :: any)[subKey] = subValue
				end
			end
		elseif not item[key] then
			if typeof(value) == "table" then
				value = deepCopyTable(value) -- This is essential for example for inputObjects
			end
			item[key] = value
		end
	end
	item.mustCreateAliasOf = nil :: any
	item.aliasOf = toBecomeName
	moveMultiKeysIntoInputObject(item)
	processDeveloperArg(item)
end

-- A command can declare a table instead of an arg name to override that arg for itself,
-- like {arg = "Number", default = 50}. The merge runs on a copy so the registered arg
-- every other command shares stays untouched, and the copy is cached against the
-- declaration so every lookup hands back the same detail
local inlineArgs = {}
local function resolveInlineArg(declaration: any): ArgumentDetail?
	local cached = inlineArgs[declaration]
	if cached ~= nil then
		return cached
	end
	local baseName = declaration.arg
	if baseName == nil then
		-- A full argumentDetail written inline, which needs no base to merge onto
		return declaration :: ArgumentDetail
	end
	local baseArg = Args.get(baseName)
	local properBaseName = baseArg and baseArg.key
	if not baseArg or not properBaseName then
		warn(`HD Admin: command arg '{tostring(baseName)}' is not a valid argument`)
		return nil
	end
	local deepCopyTable = require(modules.TableUtil.deepCopyTable)
	local resolved = {} :: any
	for key, value in declaration do
		if key ~= "arg" then
			resolved[key] = if typeof(value) == "table" then deepCopyTable(value) else value
		end
	end
	resolved.key = properBaseName
	becomeArg(resolved, properBaseName)
	inlineArgs[declaration] = resolved
	return resolved :: ArgumentDetail
end

local function recordArg(argKey: string, argDetail)
	if Args.items[argKey] and isServer then
		warn(`HD Admin: Arg '{argKey}' already exists. Strongly consider renaming your Custom Arg to avoid conflicts.`)
	end
	Args.items[argKey] = argDetail
end

local function unparsePlayer(tableOfPlayersOrQualifiers: any): string
	-- We recommend passing in an array of Players and Qualifiers, like:
	-- {Players.ForeverHD, Players.ImAvafe, "others", "role(admin)"}
	if typeof(tableOfPlayersOrQualifiers) == "Instance" and tableOfPlayersOrQualifiers:IsA("Player") then
		tableOfPlayersOrQualifiers = {tableOfPlayersOrQualifiers}
	elseif typeof(tableOfPlayersOrQualifiers) == "string" then
		tableOfPlayersOrQualifiers = {tableOfPlayersOrQualifiers}
	elseif typeof(tableOfPlayersOrQualifiers) ~= "table" then
		tableOfPlayersOrQualifiers = {}
	end
	local PlayerSettings = require(modules.Parser.ParserSettings)
	local getGameSetting = require(modules.CommandUtil.getGameSetting)
	local playerIdentifier = tostring((getGameSetting("PlayerIdentifier") or ""))
	local collective = PlayerSettings.Collective
	local stringsArray: {string} = {}
	for _, playerOrPlayerString in (tableOfPlayersOrQualifiers) do
		local nameString
		if typeof(playerOrPlayerString) == "Instance" and playerOrPlayerString:IsA("Player") then
			-- This could be improved in the future by also accounting for PlayerDefinedSearch
			nameString = playerIdentifier..playerOrPlayerString.Name
		elseif typeof(playerOrPlayerString) == "string" then
			nameString = playerOrPlayerString
		elseif typeof(playerOrPlayerString) == "number" then
			nameString = playerIdentifier .. tostring(playerOrPlayerString)
		end
		if nameString then
			table.insert(stringsArray, nameString :: string)
		end
	end
	local originalString = table.concat(stringsArray, collective)
	return tostring(originalString)
end

local function parseStringIntoRoles(self, stringToParse): {any}
	if stringToParse == "" or stringToParse == " " then
		return {}
	end
	local roleStrings = splitByCollective(stringToParse)
	local roleStringsDict = {}
	for _, roleString in (roleStrings) do
		roleStringsDict[roleString:lower()] = true
	end
	local Roles = require(modules.Parent.Services.Roles)
	local selectedRolesDict = {}
	for _, role in Roles.getRoles() do
		local roleName = (role.name or ""):lower()
		local roleKey = (role.key or ""):lower()
		local dictKey = role.key or role.name
		-- Exact match by name OR key (key matters for roles whose display
		-- name contains whitespace so that the picker unparses those as keys)
		if (roleKey ~= "" and roleStringsDict[roleKey]) or roleStringsDict[roleName] then
			selectedRolesDict[dictKey] = role
			continue
		end
		-- Fuzzy prefix match by name (existing behaviour), plus exact key match
		for selectedRoleName, _ in (roleStringsDict) do
			local nameMatch = string.sub(roleName, 1, #selectedRoleName) == selectedRoleName
			local keysMatch = roleKey == selectedRoleName
			if nameMatch or keysMatch then
				selectedRolesDict[dictKey] = role
			end
		end
	end
	local selectedRoleNames: {any} = {}
	local maxItems = self.inputObject.maxItems or 100
	local totalItems = 0
	for _, role in selectedRolesDict do
		if totalItems >= maxItems then
			break
		end
		totalItems += 1
		table.insert(selectedRoleNames, role)
	end
	return selectedRoleNames
end


-- FUNCTIONS
function Args.update()
	if not requiresUpdating then
		return false
	end
	requiresUpdating = false
	local allItems = Args.getAll()
	sortedNameAndAliasLengthArray = {}
	lowerCaseDictionary = {}
	for itemNameOrAlias, item in allItems :: any do
		local lowerCaseName = tostring(itemNameOrAlias):lower()
		lowerCaseDictionary[lowerCaseName] = item
		table.insert(sortedNameAndAliasLengthArray, tostring(itemNameOrAlias))
	end
	table.sort(sortedNameAndAliasLengthArray, function(nameA: string, nameB: string): boolean
		return #nameA > #nameB
	end)
	return true
end

function Args.getSortedNameAndAliasLengthArray()
	Args.update()
	return sortedNameAndAliasLengthArray
end

function Args.getLowercaseDictionary()
	Args.update()
	return lowerCaseDictionary
end

function Args.processStringToParse(stringToParse: string?, maxCharacters: number?): string
	-- We make sure the string can't be abused by capping its length and stripping nan/inf/non-standard characters
	if typeof(stringToParse) ~= "string" then
		return ParserSettings.EmptyUnparsedValue
	end
	local charLimit = if typeof(maxCharacters) == "number" and maxCharacters > 1 then maxCharacters else DEFAULT_MAX_CHARACTERS
	if #stringToParse > charLimit then
		stringToParse = string.sub(stringToParse, 1, charLimit)
	end
	local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)
	if tonumber(stringToParse) and not isNumberSafe(stringToParse) then
		return "0"
	end
	return stringToParse
end

function Args.get(argKey: Argument | ArgumentDetail): ArgumentDetail?
	if typeof(argKey) == "table" then
		return resolveInlineArg(argKey)
	end
	local argKeyLower = tostring(argKey):lower()
	local ourDictionary = Args.getLowercaseDictionary()
	local item = ourDictionary[argKeyLower] :: ArgumentDetail?
	if not item then
		return nil
	end
	local toBecomeName = item.mustCreateAliasOf
	if toBecomeName then
		becomeArg(item, toBecomeName)
	end
	return item :: ArgumentDetail
end

function Args.getAll()
	-- We call .get so all aliases get registered and set up correctly
	for argKey, item in Args.items do
		if not item.key then
			item.key = argKey :: any
		end
		Args.get(argKey :: any)
	end
	local items = Args.items :: { [Argument]: ArgumentDetail }
	return items
end

function Args.create(argumentDetail: ArgumentDetail)
	moveMultiKeysIntoInputObject(argumentDetail)
	processDeveloperArg(argumentDetail)
	local name = argumentDetail.key
	if name then
		recordArg(name, argumentDetail)
	end
	return argumentDetail :: ArgumentDetail
end

function Args.createAliasOf(argKey: Argument, argumentDetail: ArgumentDetail?): ArgumentDetail
	if typeof(argumentDetail) ~= "table" then
		argumentDetail = {}
	end
	argumentDetail = argumentDetail :: ArgumentDetail
	task.defer(function()
		-- This servers as a warning as opposed to an actual error
		-- to let the developer know they inputted an invalid argKey
		if not Args.items[argKey] then
			error(`Args: {argKey} is not a valid argument`)
		end
	end)
	if Args.items :: any then
		becomeArg(argumentDetail, argKey)
	else
		-- We don't actually create a mirror table here as the data of items will have
		-- not yet gone into memory. Instead, we record the table as an alias, then
		-- set it's data once .get is called or 
		argumentDetail.mustCreateAliasOf = argKey
	end
	local name = argumentDetail.key
	if name then
		recordArg(name, argumentDetail)
	end
	return argumentDetail :: ArgumentDetail
end


-- PUBLIC
local items = {

	["Player"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Players",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = true,
		},
		description = "Accepts qualifiers (like 'raza', '@ForeverHD', 'others' from ';paint raza,@ForeverHD,others'), calls the command *for each player*, and returns a single Player instance.",
		playerArg = true,
		runForEachPlayer = true,
		unparse = function(self, arrayOfPlayers: {QualifierInput} | QualifierInput)
			return unparsePlayer(arrayOfPlayers)
		end,
		parse = function(self, qualifiers: any, callerUserId, additional: any)
			local ParserUtility = require(modules.Parser.ParserUtility)
			local defaultToMe = qualifiers == nil or isTableEmpty(qualifiers :: any)
			local ignoreDefault = if typeof(additional) == "table" then additional.ignoreDefault else nil
			if defaultToMe and not ignoreDefault then
				local players: { Player } = {}
				local callerPlayer = Players:GetPlayerByUserId(callerUserId)
				if callerPlayer then
					table.insert(players, callerPlayer)
				end
				return players
			end
			local targetsDict = {}
			local qualifiersTable = qualifiers or {}
			for qualifierName, qualifierArgs in qualifiersTable do
				if qualifierName == "" then
					continue
				end
				local Qualifiers = require(modules.Parser.Qualifiers)
				local qualifierDetail = Qualifiers.get(qualifierName)
				local targets
				if not qualifierDetail then
					qualifierDetail = Qualifiers.get("Default")
					if qualifierDetail then
						targets = qualifierDetail.getTargets(callerUserId, qualifierName)
					else
						targets = {}
					end	
				else
					targets = qualifierDetail.getTargets(callerUserId, unpack(qualifierArgs :: any))
				end
				for _, plr in targets do
					targetsDict[plr] = true
				end
			end
			local players: { Player } = {}
			for plr, _ in targetsDict do
				if typeof(plr) == "Instance" and plr:IsA("Player") then
					table.insert(players, plr :: Player)
				end
			end
			return players
		end,
	}),

	["Caller"] = Args.createAliasOf("Player"),

	["Players"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Players",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = true,
		},
		description = "Accepts qualifiers (like 'raza', '@ForeverHD', 'others' from ';paint raza,@ForeverHD,others') and returns an array of Player instances.",
		default = {},
		playerArg = true,
		runForEachPlayer = false,
		unparse = function(self, arrayOfPlayers: {QualifierInput})
			return unparsePlayer(arrayOfPlayers)
		end,
		parse = function(self, qualifiers, callerUserId)
			local ParserUtility = require(modules.Parser.ParserUtility)
			if isTableEmpty(qualifiers) then
				return nil
			end
			local argPlayer = Args.get("Player" :: any)
			local players = if argPlayer then argPlayer:parse(qualifiers, callerUserId, {ignoreDefault = true}) else {}
			return players
		end,
	}),

	["SinglePlayer"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Player",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = true,
			limitPickerToOneItem = true,
		},
		description = "Accepts qualifiers (like 'raza', '@ForeverHD', 'others' from ';paint raza,@ForeverHD,others') and returns a single Player instance (or nil).",
		default = {},
		playerArg = true,
		runForEachPlayer = true,
		unparse = function(self, arrayOfPlayers: {QualifierInput} | QualifierInput)
			return unparsePlayer(arrayOfPlayers)
		end,
		parse = function(self, qualifiers, callerUserId)
			local argPlayer = Args.get("Player" :: any)
			local players = if argPlayer then argPlayer:parse(qualifiers, callerUserId, {ignoreDefault = true}) else {}
			-- With nothing given we fall back to the caller, so a bare command still
			-- reaches run and can respond (like ;control explaining you can't control
			-- yourself) instead of silently creating no task
			local ParserUtility = require(modules.Parser.ParserUtility)
			if players[1] == nil and (typeof(qualifiers) ~= "table" or isTableEmpty(qualifiers)) then
				local callerPlayer = Players:GetPlayerByUserId(tonumber(callerUserId) or 0)
				return {callerPlayer}
			end
			return {players[1]} -- We return as an array as runForEachPlayer is true
			--return players[1]
		end,
	}),

	["OptionalPlayer"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Players",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = true,
			default = "all", -- run page seed so the reach is explicit
		},
		description = "Hides the players argument for general use and only displays it within the preview menu. If no player specified, defaults to me",
		playerArg = true,
		hidden = true,
		runForEachPlayer = true,
		unparse = function(self, arrayOfPlayers: {QualifierInput} | QualifierInput)
			return unparsePlayer(arrayOfPlayers)
		end,
		parse = function(self, qualifiers, callerUserId)
			-- Defaults to ME
			local defaultToMe = qualifiers == nil or isTableEmpty(qualifiers)
			if defaultToMe then
				local players: {Player} = {}
				local callerPlayer = Players:GetPlayerByUserId(callerUserId)
				if callerPlayer then
					table.insert(players, callerPlayer)
				end
				return players
			end
			local argPlayer = Args.get("Player" :: any)
			local players = if argPlayer then argPlayer:parse(qualifiers, callerUserId, {ignoreDefault = true}) else {}
			return players
		end,
	}),

	["OptionalPlayers"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Players",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = true,
			canAnyUserBeAddedToPicker = false,
			default = "all", -- run page seed, mirrors the send to everyone when omitted
		},
		description = "Hides the players argument for general use and only displays it within the preview menu. This is useful for message commands. For example, you can do ;m others Hello World, AND ;m Hello World",
		default = {},
		playerArg = true,
		hidden = true,
		runForEachPlayer = false,
		unparse = function(self, arrayOfPlayers: {QualifierInput})
			return unparsePlayer(arrayOfPlayers)
		end,
		parse = function(self, qualifiers, callerUserId)
			local defaultToAll = qualifiers == nil
			if typeof(qualifiers) ~= "table" or isTableEmpty(qualifiers) then
				return nil
			end
			local argPlayer = Args.get("Player" :: any)
			local players = if argPlayer then argPlayer:parse(qualifiers, callerUserId, {ignoreDefault = true}) else {}
			return players
		end,
	}),
	
	["AnyUser"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			displayServerPlayersInPicker = true,
			displayQualifiersInPicker = false,
			canAnyUserBeAddedToPicker = true,
			limitPickerToOneItem = true,
		},
		inputOptions = {},
		display = "User",
		description = "Accepts an @userName, display, userId or qualifier and returns a userId.",
		default = 0,
		unparse = function(self, userId: number)
			local id: any = if type(userId) == "table" then (userId :: any)[1] else userId
			if typeof(id) == "Instance" and (id :: any):IsA("Player") then
				id = (id :: any).UserId
			end
			local whenNumber = tonumber(id)
			local stringUserId = tostring(whenNumber) or ""
			return stringUserId
		end,
		parse = function(self, stringToParse, callerUserId): number?
			local userId = tonumber(stringToParse)
			if userId then
				return userId
			end
			local playerArg = Args.get("Player")
			local playersInServer = playerArg and playerArg:parse({[stringToParse] = {}}, callerUserId)
			local player = playersInServer[1]
			if player then
				return player.UserId
			end
			local User = require(modules.Objects.User)
			local callerUser = User.getUser(callerUserId)
			local ParserUtility = require(modules.Parser.ParserUtility)
			local approved, username = ParserUtility.verifyAndParseUsername(callerUser, stringToParse)
			if not approved then
				username = stringToParse
			end
			local getUserIdFromNameAsync = require(modules.PlayerUtil.getUserIdFromNameAsync)
			local success, finalUserId = getUserIdFromNameAsync(username :: string)
			if success and typeof(finalUserId) == "number" then
				return finalUserId
			end
			return nil
		end,
	}),

	["Roles"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Roles",
			pickerGetter = function()
				local clientUser = require(modules.References.clientUser)
				local success, roles = clientUser.everyone:fetchAsync("Roles")
				if typeof(roles) ~= "table" then return {} end
				local items: {any} = {}
				for _, role in roles do
					if typeof(role) ~= "table" then continue end
					local roleAny: any = role
					if typeof(roleAny.name) ~= "string" then continue end
					-- If the display name contains whitespace, the parser can't
					-- recover the role from a stringified command (a space would
					-- split it into multiple arg tokens). so we fall back to the role
					-- key in that case, keys are sanitised to alphanumerics
					-- elsewhere, so they complete cleanly
					local hasWhitespace = string.find(roleAny.name, "%s") ~= nil
					local rawValue: string = if hasWhitespace and typeof(roleAny.key) == "string"
						then roleAny.key
						else roleAny.name
					table.insert(items, {
						key = roleAny.key or roleAny.name,
						label = roleAny.name,
						header = roleAny.name,
						rawValue = rawValue,
						category = "qualifier",
						color = roleAny.color,
					})
				end
				return items
			end,
		},
		default = {},
		description = "Accepts a string and returns a table of roles.",
		unparse = function(self, roleNames: {string} | string)
			local PlayerSettings = require(modules.Parser.ParserSettings)
			local collective = PlayerSettings.Collective
			local arrayOfRoleNames: {string} = {}
			if typeof(roleNames) == "table" then
				arrayOfRoleNames = roleNames
			else
				arrayOfRoleNames = {tostring(roleNames)}
			end
			local rolesToString = table.concat(arrayOfRoleNames, collective)
			return rolesToString
		end,
		parse = function(self, stringToParse, callerUserId)
			return parseStringIntoRoles(self, stringToParse)
		end,
	}),

	["Role"] = Args.createAliasOf("Roles", register({
		maxItems = 1,
		default = false,
		parse = function(self, stringToParse, callerUserId)
			local roles = parseStringIntoRoles(self, stringToParse)
			local singleRole = roles[1]
			return singleRole
		end,
	})),

	["Text"] = Args.create({
		inputObject = {
			inputType = "TextInput",
			filterText = true,
		},
		description = "Accepts a string and broadcast filters it based upon the caller.",
		default = "",
		endlessArg = true,
		maxCharacters = TEXT_MAX_CHARACTERS,
		unparse = function(self, text: string)
			-- Strips anything matching endlessArgPattern out of text
			local endlessArgPattern = ParserSettings.EndlessArgPattern
			local stringSplit = text:split(endlessArgPattern)
			local processedText = table.concat(stringSplit, "")
			return processedText
		end,
		parse = function(self, textToFilter, callerUserId, _targetUserId: number?)
			if typeof(textToFilter) ~= "string" or textToFilter:match("^%s*$") ~= nil then
				return "Example"
			end
			local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
			local success, result = filterTextAsync(textToFilter, callerUserId)
			if not success then
				result = "####"
			end
			return result
		end,
	}),

	["String"] = Args.createAliasOf("Text"),

	["Reason"] = Args.createAliasOf("Text"),

	["PrivateText"] = Args.createAliasOf("Text", register({
		description = "Same as 'Text' but filters per recipient. Only use for one to one text like direct messages that nobody else sees.",
		parse = function(self, textToFilter, callerUserId, targetUserId: number?)
			if typeof(textToFilter) ~= "string" or textToFilter:match("^%s*$") ~= nil then
				return "Example"
			end
			local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
			local success, result = filterTextAsync(textToFilter, callerUserId, targetUserId)
			if not success then
				result = "####"
			end
			return result
		end,
	})),
	
	["SingleText"] = Args.create({
		inputObject = {
			title = "Text",
			inputType = "TextInput",
			filterText = true,
			preventWhitespaces = true,
		},
		description = "Accepts a non-endless string (a string with no whitespace gaps) and filters it based upon the caller and target.",
		default = "",
		endlessArg = false,
		unparse = function(self, text: string)
			return text
		end,
		parse = function(self, textToFilter)
			return textToFilter
		end,
	}),

	["UnfilteredSingleText"] = Args.create({
		inputObject = {
			title = "Text",
			inputType = "TextInput",
			filterText = false,
			preventWhitespaces = true,
		},
		description = "Accepts a non-endless string (a string with no whitespace gaps).",
		default = "",
		endlessArg = false,
		unparse = function(self, text: string)
			return text
		end,
		parse = function(self, textToFilter)
			return textToFilter
		end,
	}),

	["UnfilteredText"] = Args.create({
		inputObject = {
			title = "Text",
			inputType = "TextInput",
			filterText = false,
		},
		description = "Accepts a string and returns it unfiltered.",
		default = "",
		endlessArg = true,
		maxCharacters = TEXT_MAX_CHARACTERS,
		unparse = function(self, text: string)
			return text
		end,
		parse = function(self, stringToParse)
			return stringToParse
		end,
	}),

	["EmoteIdOrName"] = Args.createAliasOf("UnfilteredSingleText"),

	["Code"] = Args.createAliasOf("UnfilteredText"),

	["Number"] = Args.create({
		inputObject = {
			inputType = "NumberInput",
		},
		description = "Accepts a number string and returns a Number",
		default = 0,
		unparse = function(self, number: number)
			local safeNumberString = Args.processStringToParse(tostring(number))
			return safeNumberString
		end,
		parse = function(self, stringToParse, callerUserId): number?
			-- The stringToParse is already filtered of dangerous numbers thanks to
			-- Args.processStringToParse, so we don't need to worry about size limits
			-- or NaN/Inf values here
			local numberValue = tonumber(stringToParse)
			if not numberValue then
				return nil
			end
			local divAmount = self.divAmount
			if typeof(divAmount) == "number" then
				numberValue = numberValue % divAmount
			end
			local User = require(modules.Objects.User)
			local user = User.getUserByUserId(callerUserId)
			local Roles = require(modules.Parent.Services.Roles) :: any
			local canBypassLimits = Roles.hasPermission(user, "permitBypassLimits")
			local min = self.min or -math.huge
			local max = self.max or math.huge
			local clampedValue = if canBypassLimits then numberValue else math.clamp(numberValue, min, max)
			local step = self.step
			if typeof(step) == "number" then
				local roundToNearest = require(modules.MathUtil.roundToNearest)
				clampedValue = roundToNearest(clampedValue, step)
			end
			return clampedValue
		end,
	}),

	["Integer"] = Args.createAliasOf("Number", register({
		step = 1,
	})),

	["Speed"] = Args.createAliasOf("Number", register({
		min = 0,
		max = 100,
		step = 1,
		default = 10,
	})),

	["FlightSpeed"] = Args.createAliasOf("Number", register({
		display = "Speed",
		min = 0,
		max = 1000,
		step = 1,
		default = 50,
		logarithmic = true,
	})),

	["Unit"] = Args.createAliasOf("Number", register({
		display = "Number",
		min = 0,
		max = 1,
		step = 0.05,
		default = 0.5,
	})),

	["Degrees"] = Args.createAliasOf("Number", register({
		description = "Accepts a number and returns a value between 0 and 360.",
		min = 0,
		max = 360,
		divAmount = 360,
		step = 1,
		default = 180,
	})),

	["Duration"] = Args.create({
		inputObject = {
			inputType = "DurationSelector",
		},
		description = "Accepts a timestring (such as '5s7d8h') and returns the integer equivalent in seconds. Timestring letters are: seconds(s), minutes(m), hours(h), days(d), weeks(w), months(o) and years(y).",
		default = 0,
		unparse = function(self, seconds: number)
			local value = tonumber(seconds) or 0
			if value < 0 then
				value = 0
			end
			local convertSecondsToTimeString = require(modules.DataUtil.convertSecondsToTimeString)
			return convertSecondsToTimeString(value)
		end,
		parse = function(self, stringToParse)
			local convertTimeStringToSeconds = require(modules.DataUtil.convertTimeStringToSeconds)
			return convertTimeStringToSeconds(stringToParse)
		end,
	}),

	["Color"] = Args.create({
		inputObject = {
			inputType = "ColorPicker",
		},
		description = "Accepts a color name (such as 'red'), a hex code (such as '#FF0000') or an RGB capsule (such as '[255,0,0]') and returns a Color3.",
		default = Color3.fromRGB(255, 255, 255),
		unparse = function(self, color: Color3)
			if typeof(color) ~= "Color3" then
				color = Color3.fromRGB(255, 255, 255)
			end
			local colorToHex = require(modules.DataUtil.colorToHex)
			local rgbString = colorToHex(color)
			return rgbString
		end,
		parse = function(self, stringToParse: string): Color3?
			-- This checks for a predefined colour term within SystemSettings.colours, such as 'blue', 'red', etc
			local Config = require(modules.Parent.Services.Config)
			local lowerCommandColors = self.lowerCommandColors
			if not lowerCommandColors then
				local commandColors = Config.getSetting("CommandColors")
				lowerCommandColors = lowerCommandColors or {}
				self.lowerCommandColors = lowerCommandColors
				for colorName, color in commandColors do
					colorName = tostring(colorName)
					lowerCommandColors[colorName:lower()] = color
				end
			end
			local color3FromName = lowerCommandColors[stringToParse:lower()]
			if color3FromName then
				return color3FromName
			end
			-- This checks for an RGB capsule which will look like 'R,G,B' or 'R, G, B' (the square brackets are stripped within the Parser module)
			local rgbTable = stringToParse:gsub(" ", ""):split(",")
			if rgbTable then
				local red = tonumber(rgbTable[1])
				local green = tonumber(rgbTable[2])
				local blue = tonumber(rgbTable[3])
				if red and green and blue then
					return Color3.fromRGB(red, green, blue)
				end
			end
			-- This checks if the string is a Hex Code (such as #FF5733)
			if stringToParse:sub(1,1) ~= "#" then
				stringToParse = "#" .. stringToParse
			end
			local hexValue = stringToParse:sub(2, #stringToParse)
			local hexToColor = require(modules.DataUtil.hexToColor)
			local color3 = #stringToParse > 2 and hexToColor(stringToParse)
			if color3 then
				return color3
			end
			return nil
		end,
	}), 

	["Colour"] = Args.createAliasOf("Color"),

	["OptionalColor"] = Args.createAliasOf("Color", register({
		description = "Same as 'Color' but but must be wrapped in a command capsule. E.g. ';message(yellow) Hello World!'",
		default = Color3.fromRGB(255, 255, 255),
		display = "Color",
		hidden = true,
	})),

	["OptionalDuration"] = Args.createAliasOf("Number", register({
		inputObject = {
			inputType = "NumberInput",
			allowEmpty = true,
			placeholderText = "Auto",
		},
		description = "Same as 'Number' but must be wrapped in a command capsule. When left out the duration is worked out from the text length. A value of 0, or 3600 and above, keeps it up until dismissed, like ';notice(0) Hello World!'",
		display = "Duration",
		min = 0,
		max = 3600,
		step = 1,
		useSlider = false,
		hidden = true,
	})),

	["OptionalVoteTime"] = Args.createAliasOf("Duration", register({
		description = "Same as 'Duration' but must be wrapped in a command capsule. How long the poll stays open for, like ';vote(2m30s) Best colour? || Red | Blue'",
		default = 120,
		display = "Vote Time",
		hidden = true,
	})),

	["OptionalShareResults"] = Args.createAliasOf("Bool", register({
		description = "Same as 'Bool' but must be wrapped in a command capsule. When true the poll results are shown to everyone once it ends, like ';vote(30, yes) Best colour? || Red | Blue'",
		display = "Share Results with Voters",
		hidden = true,
	})),

	["Bool"] = Args.create({
		inputObject = {
			inputType = "Toggle",
		},
		description = "Accepts 'true', 'false', 'yes', 'y', 'no' or 'n' and returns a boolean.",
		default = false,
		unparse = function(self, bool: boolean)
			if bool == true then
				return "true"
			else
				return "false"
			end	
		end,
		parse = function(self, stringToParse): boolean?
			local stringLower = stringToParse:lower()
			local trueStrings = {
				["true"] = true,
				["t"] = true,
				["yes"] = true,
				["y"] = true,
			}
			local falseStrings = {
				["false"] = true,
				["f"] = true,
				["no"] = true,
				["n"] = true,
			}
			if trueStrings[stringLower] then
				return true
			elseif falseStrings[stringLower] then
				return false
			end
			return nil
		end,
	}),

	["Toggle"] = Args.createAliasOf("Bool"),

	["Options"] = Args.create({
		inputObject = {
			inputType = "Options",
			optionsArray = {"Yes", "No"},
		},
		description = "Accepts any value within the optionsArray and returns the value.",
		unparse = function(self, option: string)
			return option
		end,
		parse = function(self, stringToParse)
			local stringLower = stringToParse:lower()
			local stringLen = #stringLower :: any
			local optionsArray: {any} = self.inputObject.optionsArray or {}
			for _, option in optionsArray do
				if option:lower():sub(1,stringLen) == stringLower then
					return option
				end
			end
			local default = optionsArray[1] or "Empty"
			return default
		end,
	}),

	["BanImpact"] = Args.createAliasOf("Options", register({
		description = "Alts issues a Roblox-platform ban that catches alt accounts; User is HD record only",
		inputObject = {
			inputType = "Options",
			title = "Ban Impact",
			optionsArray = {"Alts", "User"},
			optionsDisplayArray = {"Alts (IP Ban)", "User-Only"},
		},
	})),
	
	["OptionalBanDuration"] = Args.createAliasOf("Duration", register({
		title = "Duration",
		uiHidden = true,
		revealedBy = { dependsOn = "BanOptions", equals = "Time" },
	})),

	["OptionalBanImpact"] = Args.createAliasOf("BanImpact", register({
		uiHidden = true,
		-- Time bans also issue Roblox IP bans by default, so the impact toggle is meaningful there too
		revealedBy = { dependsOn = "BanOptions", equalsAny = {"Perm", "Time"} },
	})),

	["BanOptions"] = Args.createAliasOf("Options", register({
		description = "Pick which ban command to apply (Server / Time / Perm). Each option requires permission to run the matching scope-locked command.",
		inputObject = {
			inputType = "Options",
			title = "Options",
			optionsArray = {"Perm", "Time", "Server"},
			optionCommands = {
				Server = "serverBan",
				Time   = "timeBan",
				Perm   = "permBan",
			},
		},
	})),

	["Leaderstat"] = Args.create({
		-- Accepts the names of stats within the player's leaderstats:
		-- https://create.roblox.com/docs/players/leaderboards
		-- Leaderstats may not exist within the player, so must be checked for
		inputObject = {
			inputType = "ItemSelector",
			title = "Leaderstat",
			limitPickerToOneItem = true,
			pickerGetter = function()
				local items: {any} = {}
				local localPlayer = Players.LocalPlayer
				local leaderstats = localPlayer:FindFirstChild("leaderstats")
				if not leaderstats then
					return items
				end
				for _, childStat in leaderstats:GetChildren() do
					table.insert(items, childStat.Name)
				end
				return items
			end,
		},
		description = "Accepts a valid stat name and returns the stat (defined in Server/Modules/StatHandler)",
		default = false,
		endlessArg = true,
		unparse = function(self, leaderstat: Instance? | {Instance}? | string? | {string}?)
			local singleReturnString: string? = nil
			if typeof(leaderstat) == "string" then
				singleReturnString = leaderstat
			elseif typeof(leaderstat) == "Instance" then
				singleReturnString = leaderstat.Name
			elseif typeof(leaderstat) == "table" then
				local firstLeaderstat = leaderstat[1]
				if typeof(firstLeaderstat) == "string" then
					singleReturnString = firstLeaderstat
				elseif typeof(firstLeaderstat) == "Instance" then
					singleReturnString = firstLeaderstat.Name
				end
			end
			if not singleReturnString then
				return ParserSettings.EmptyUnparsedValue
			end
			return singleReturnString
		end,
		parse = function(self, stringToParse, callerUserId, targetUserId: number?): Instance?
			local userIdToFind = tonumber(targetUserId or callerUserId)
			local targetPlayer = userIdToFind and Players:GetPlayerByUserId(userIdToFind)
			if not targetPlayer then
				return nil
			end
			local leaderstats = targetPlayer:FindFirstChild("leaderstats") or targetPlayer:FindFirstChild("Leaderstats")
			if not leaderstats then
				return nil
			end
			local stringLower = string.lower(stringToParse)
			-- An empty string prefix-matches every stat below, which silently picked
			-- the first one when nothing was typed
			if string.len(stringLower) == 0 then
				return nil
			end
			for _, childStat in leaderstats:GetChildren() do
				if string.lower(childStat.Name) == stringLower then
					return childStat
				end
			end
			for _, childStat in leaderstats:GetChildren() do
				if string.sub(string.lower(childStat.Name), 1, #stringLower) == stringLower then
					return childStat
				end
			end
			return nil
		end,
	}),

	["Team"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Team",
			limitPickerToOneItem = true,
			pickerGetter = function()
				local items: {any} = {}
				local Teams = game:GetService("Teams")
				for _, team in Teams:GetChildren() do
					if team:IsA("Team") then
						table.insert(items, team.Name)
					end
				end
				return items
			end,
		},
		display = "Team",
		description = "Accepts a valid team name and returns the team instance.",
		default = false,
		endlessArg = true,
		unparse = function(self, team: Team? | {Team}? | string? | {string}?)
			if typeof(team) == "string" then
				return team
			elseif typeof(team) == "Instance" then
				return team.Name
			end
			if typeof(team) == "table" then
				local firstTeam = team[1]
				if typeof(firstTeam) == "string" then
					return firstTeam
				elseif typeof(firstTeam) == "Instance" then
					return firstTeam.Name
				end
			end
			return ParserSettings.EmptyUnparsedValue
		end,
		parse = function(self, stringToParse): Team?
			local Teams = game:GetService("Teams")
			local stringToParseLower = string.lower(stringToParse)
			if string.len(stringToParseLower) > 0 then
				for _, team in Teams:GetChildren() do
					local teamName = string.lower(team.Name)
					if team:IsA("Team") and string.sub(teamName, 1, #stringToParseLower) == stringToParseLower then
						return team
					end
				end
			end
			return nil
		end,
	}),

	["Material"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Material",
			limitPickerToOneItem = true,
			pickerGetter = function()
				local items: {any} = Enum.Material:GetEnumItems()
				return items
			end,
		},
		description = "Accepts a valid material and returns a Material enum.",
		default = Enum.Material.Plastic,
		unparse = function(self, material: Enum.Material? | {Enum.Material}? | string? | {string}?)
			if typeof(material) == "string" then
				return material
			elseif typeof(material) == "EnumItem" then
				return material.Name
			end
			if typeof(material) == "table" then
				local firstMaterial = material[1]
				if typeof(firstMaterial) == "string" then
					return firstMaterial
				elseif typeof(firstMaterial) == "EnumItem" then
					return firstMaterial.Name
				end
			end
			return ParserSettings.EmptyUnparsedValue
		end,
		parse = function(self, stringToParse): Enum.Material?
			local materialEnumNamesLowercase = self.materialEnumNamesLowercase
			if not materialEnumNamesLowercase then
				materialEnumNamesLowercase = {}
				self.materialEnumNamesLowercase = materialEnumNamesLowercase
				for _, enumItem in Enum.Material:GetEnumItems() do
					materialEnumNamesLowercase[enumItem.Name:lower()] = enumItem :: any
				end
			end
			local stringLower = stringToParse:lower()
			local enumItem = materialEnumNamesLowercase[stringLower]
			if enumItem then
				return enumItem
			end
			for enumNameLower, enumItem in materialEnumNamesLowercase do
				if string.sub(enumNameLower, 1, #stringToParse) == stringLower then
					return enumItem
				end
			end
			return nil
		end,
	}),

	["Tools"] = Args.create({
		inputObject = {
			inputType = "ItemSelector",
			title = "Tools",
			pickerGetter = function()
				local getToolsInfoAsync = require(modules.CommandUtil.getToolsInfoAsync)
				local success, toolsInfo = getToolsInfoAsync()
				local items: {getToolsInfoAsync.ToolInfo} = {}
				if success and toolsInfo then
					items = toolsInfo :: {getToolsInfoAsync.ToolInfo}
				end
				return items
			end,
		},
		display = "Tool",
		description = "Accepts a name and returns a copy of any matching tools located in ServerStorage, ReplicatedStorage, StarterPack, Lighting. You MUST Clone the returned tool before using.",
		default = {},
		endlessArg = true,
		unparse = function(self, toolInfo: any)
			local function getName(item: any): string?
				if typeof(item) == "string" then return item end
				if typeof(item) == "Instance" then return item.Name end
				if typeof(item) == "table" then
					return item.name or item.Name
				end
				return nil
			end
			-- Array of tool names/instances (from ItemSelector)
			if typeof(toolInfo) == "table" and toolInfo[1] ~= nil then
				local collective = ParserSettings.Collective
				local parts: {string} = {}
				for _, item in toolInfo do
					local name = getName(item)
					if name then table.insert(parts, name) end
				end
				return table.concat(parts, collective)
			end
			return getName(toolInfo) or ""
		end,
		parse = function(self, stringToParse): any?
			local getToolsInfoAsync = require(modules.CommandUtil.getToolsInfoAsync)
			local success, toolsInfo = getToolsInfoAsync()
			if not success or not toolsInfo then
				return nil
			end
			if #stringToParse == 0 then
				return nil
			end
			local splitStrings = splitByCollective(stringToParse)
			local toolsDict = {}
			for _, stringSplit in splitStrings do
				local stringLower = stringSplit:lower()
				for _, toolInfo in toolsInfo do
					local toolNameLower = toolInfo.name:lower()
					-- Plain find so user input is never compiled as a pattern
					if stringLower == "all" or string.sub(toolNameLower, 1, #stringToParse) == stringLower or string.find(toolNameLower, stringLower, 1, true) then
						toolsDict[toolInfo.tool] = true
					end
				end
			end
			local toolsArray: {any} = {}
			for tool, _ in toolsDict do
				table.insert(toolsArray, tool)
			end
			return toolsArray
		end,
	}),

	["Fields"] = Args.create({
		inputObject = {
			inputType = "InputFields",
			filterText = true,
			maxItems = 10,
		},
		endlessArg = true,
		default = {},
		maxCharacters = TEXT_MAX_CHARACTERS,
		unparse = function(self, optionsArray: {string})
			local joinedString = table.concat(optionsArray, endlessFieldsPattern)
			return joinedString
		end,
		parse = function(self, stringToParse, callerUserId): {string}?
			if typeof(stringToParse) ~= "string" then
				return nil
			end
			local endlessArgsSplit = string.split(stringToParse, endlessFieldsPattern)
			-- Fields display to other players (like poll answers), so each one gets
			-- broadcast filtered just like Text
			local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
			local maxItems = (typeof(self.inputObject) == "table" and tonumber(self.inputObject.maxItems)) or 10
			local fields = {}
			for _, field in endlessArgsSplit do
				local trimmed = field:gsub("^%s+", ""):gsub("%s+$", "")
				if trimmed == "" then
					continue
				end
				local success, result = filterTextAsync(trimmed, callerUserId)
				if not success then
					result = "####"
				end
				table.insert(fields, result)
				if #fields >= maxItems then
					break
				end
			end
			return fields
		end,
	}),

	["Scale"] = Args.createAliasOf("Number", register({
		-- This can be exceeded if a user has a role with 'bypassLimits' enabled
		min = 0.1,
		max = 4,
		step = 0.1,
		logarithmic = true,
		default = 2,
	})),

	["CountdownTime"] = Args.createAliasOf("Number", register({
		display = "Time",
		min = 1,
		step = 1,
		max = 3600,
		default = 30,
		logarithmic = true,
	})),

	["AnimationSpeed"] = Args.createAliasOf("Number", register({
		display = "Speed",
		min = 0.5,
		max = 2,
		step = 0.1,
		default = 1,
	})),

	["SoundId"] = Args.createAliasOf("Number", register({
		display = "Sound ID",
		step = 1,
		default = 1837324500,
	})),

	["MusicVolume"] = Args.createAliasOf("Number", register({
		display = "Volume",
		min = 0,
		max = 5,
		step = 0.2,
		default = 1,
	})),

	["MusicSpeed"] = Args.createAliasOf("Number", register({
		display = "Pitch",
		min = 0,
		max = 3,
		step = 0.1,
		default = 1,
	})),

	["ClockTime"] = Args.createAliasOf("Number", register({

		display = "Time",
		min = 0,
		max = 24,
		step = 0.1,
		default = 14,
	})),

	["ServersOptions"] = Args.createAliasOf("Options", register({
		display = "Server",
		inputObject = {
			inputType = "Options",
			optionsArray = {"Current", "All"}
		},
	})),

	["BanLengthOptions"] = Args.createAliasOf("Options", register({
		display = "Length",
		inputObject = {
			inputType = "Options",
			optionsArray = {"Infinite", "Time"}
		},
	})),

}
Args.items = items


-- SETUP
-- Add the loader args to our items
local loaderItems = LoaderArgs(Args :: any)
for argKey, argDetail in loaderItems :: any do
	recordArg(argKey, argDetail)
end


-- TYPES
export type Argument = keyof<typeof(items)> | keyof<typeof(loaderItems)>
export type ArgumentDetail = ArgTypes.ArgumentDetail
type QualifierInput = Player | string


return Args
