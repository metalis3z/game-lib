--!strict

--[[
 
	Client helpers for command modifiers (un, loop, spawn, delay, preview, random).
	Modifiers are concatenated onto the command name (";unfly", ";loopkill"), so the
	cmdbar needs to peel them back off to find the base command and to suggest
	modifier-prefixed variants as you type one

]]


-- CONFIG
local DESCRIPTION_LIMIT = 60
local PERM_WITHOUT_REACH: { [string]: true } = {
	perm = true,
	permloop = true,
	permdelay = true,
	permschedule = true,
}
local REACH_MODIFIERS: { [string]: true } = {
	global = true,
	perm = true,
	join = true,
	permjoin = true,
	permspawn = true,
	permschedule = true,
	permloop = true,
	permdelay = true,
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Permissions = require(script.Parent.Parent.Permissions)
local ModifierUtil = {}
local Modifiers: any = nil
local Args: any = nil
local sortedNames: { string }? = nil
local descriptions: { [string]: string } = {}
local argFilters: { [string]: (args: { any }) -> { any } } = {
	firstPlayerArg = function(args: { any }): { any }
		local firstArgName = args[1]
		local firstArg = firstArgName ~= nil and Args and Args.get(firstArgName)
		if firstArg and firstArg.playerArg and firstArg.runForEachPlayer then
			return { firstArgName }
		end
		return {}
	end,
}


-- LOCAL FUNCTIONS
local function safeRequire(module: Instance): any
	local ok, result = pcall(require, module)
	return ok and result or nil
end

local function ensureLoaded()
	if sortedNames then
		return
	end
	Modifiers = safeRequire(modules.Parser.Modifiers)
	Args = safeRequire(modules.Parser.Args)
	sortedNames = {}
	if not Modifiers then
		return
	end
	sortedNames = Modifiers.getSortedNameAndAliasLengthArray() -- longest-first
	for _, name in sortedNames :: { string } do
		local item = Modifiers.get(name :: any)
		if item and typeof(item.description) == "string" then
			descriptions[name:lower()] = item.description
		end
	end
end

-- Only the first sentence, capped, so a wordy blurb can't crush the row's name
local function shortDescription(text: any): string?
	if typeof(text) ~= "string" or text == "" then
		return nil
	end
	local firstSentence = text:match("^(.-)%. ") or text
	if #firstSentence > DESCRIPTION_LIMIT then
		return firstSentence:sub(1, DESCRIPTION_LIMIT - 3) .. "..."
	end
	return firstSentence
end

local function stripCapsule(text: string): string
	if text:sub(1, 1) == "(" then
		local closeParen = text:find(")", 1, true)
		if closeParen then
			return text:sub(closeParen + 1)
		end
	end
	return text
end


-- FUNCTIONS
function ModifierUtil.runsForEachPlayer(command: any): boolean
	ensureLoaded()
	local args = if typeof(command) == "table" and typeof(command.args) == "table" then command.args else {}
	local firstArg = Args and Args.get(args[1])
	return firstArg ~= nil and firstArg.playerArg == true and firstArg.runForEachPlayer == true
end
function ModifierUtil.isRejectedOn(modifierName: any, command: any): boolean
	local lowered = tostring(modifierName):lower()
	if typeof(command) == "table" then
		if (command :: any).disableModifiers == true then
			return true
		end
		if (command :: any).disableGlobalModifiers == true and REACH_MODIFIERS[lowered] then
			return true
		end
	end
	if not PERM_WITHOUT_REACH[lowered] then
		return false
	end
	return ModifierUtil.runsForEachPlayer(command)
end

-- A direct command match wins, so a command literally named "unstuck" beats un+stuck
function ModifierUtil.resolve(token: string, byKey: { [string]: any }): (any?, { string })
	ensureLoaded()
	local names = sortedNames :: { string }
	local modifiersApplied: { string } = {}
	local rest = token:lower()
	-- Lookups see through the token's own capsule, even a half typed unclosed one
	local function lookup(name: string): any
		local direct = byKey[name]
		if direct then
			return direct
		end
		local noCapsule = name:gsub("%b()", ""):gsub("%(.*$", "")
		return byKey[noCapsule]
	end
	while not lookup(rest) do
		local peeled = false
		for _, modName in names do
			local lowered = modName:lower()
			if #rest > #lowered and rest:sub(1, #lowered) == lowered then
				table.insert(modifiersApplied, lowered)
				rest = stripCapsule(rest:sub(#lowered + 1))
				peeled = true
				break
			end
		end
		if not peeled then
			return nil, modifiersApplied
		end
	end
	return lookup(rest), modifiersApplied
end

local function isCapsuleArg(argName: any): boolean
	local detail = Args and Args.get(argName)
	return detail ~= nil and detail.hidden == true and not detail.playerArg
end

function ModifierUtil.effectiveArgs(command: any, modifierNames: { string }): { any }
	ensureLoaded()
	local args = if typeof(command) == "table" and typeof(command.args) == "table" then command.args else {}
	if Modifiers then
		for _, modName in modifierNames do
			local modifier = Modifiers.get(modName)
			local flag = modifier and (modifier :: any).affectsArgs
			local filter = if typeof(flag) == "string" then argFilters[flag] else nil
			if filter then
				args = filter(args)
				break
			end
		end
	end
	-- Hidden non player args live in the capsule so they never take a positional slot
	local out: { any } = {}
	for _, argName in args do
		if not isCapsuleArg(argName) then
			table.insert(out, argName)
		end
	end
	return out
end

-- The args a command takes inside its own capsule, in declaration order
function ModifierUtil.capsuleArgs(command: any): { any }
	ensureLoaded()
	local out: { any } = {}
	local args = if typeof(command) == "table" and typeof(command.args) == "table" then command.args else {}
	for _, argName in args do
		if isCapsuleArg(argName) then
			table.insert(out, argName)
		end
	end
	return out
end

-- Insert skips the trailing space because the command concatenates onto the end
function ModifierUtil.modifierCandidates(query: string): { any }
	ensureLoaded()
	local out: { any } = {}
	if not Modifiers or query == "" then
		return out
	end
	local lowered = query:lower()
	for _, modName in sortedNames :: { string } do
		local modifier = modName:lower()
		if #modifier >= #lowered and modifier:sub(1, #lowered) == lowered then
			local item = Modifiers.get(modifier)
			if item and Permissions.canUseModifierNow(item) then
				local needsCapsule = (item :: any).requiresCapsule == true
				local rightLabel = "Modifier"
				local blurb = shortDescription(descriptions[modifier])
				if blurb then
					rightLabel = `Modifier ({blurb})`
				end
				table.insert(out, {
					keys = { modifier },
					text = modifier,
					display = (item :: any).key or modName,
					insert = if needsCapsule then modifier .. "()" else modifier,
					advance = false,
					caretBack = if needsCapsule then 1 else 0,
					kind = "modifier",
					description = rightLabel,
				})
			end
		end
	end
	return out
end

-- A bare modifier ("un") stays quiet on purpose to avoid noise
function ModifierUtil.expand(query: string, commandCandidates: { any }): { any }
	ensureLoaded()
	local out: { any } = {}
	local lowered = query:lower()
	for _, modName in sortedNames :: { string } do
		local modifier = modName:lower()
		if #lowered > #modifier and lowered:sub(1, #modifier) == modifier then
			-- The server would reject the statement anyway
			local item = Modifiers and Modifiers.get(modifier)
			if item and not Permissions.canUseModifierNow(item) then
				break
			end
			local commandPart = lowered:sub(#modifier + 1)
			if commandPart ~= "" then
				for _, baseCandidate in commandCandidates do
					local baseText = baseCandidate.text
					if typeof(baseText) == "string" and baseText:sub(1, #commandPart) == commandPart then
						if ModifierUtil.isRejectedOn(modifier, baseCandidate.command) then
							continue
						end
						local full = modifier .. baseText
						table.insert(out, {
							keys = { full },
							text = full,
							insert = full,
							display = modifier .. (baseCandidate.display or baseText),
							kind = "command",
							command = baseCandidate.command,
							locked = baseCandidate.locked,
							runState = baseCandidate.runState,
							description = shortDescription(descriptions[modifier]) or baseCandidate.description,
						})
					end
				end
			end
			break -- only the first (longest) matching modifier
		end
	end
	return out
end


return ModifierUtil
