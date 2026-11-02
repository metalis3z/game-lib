--!strict
local modules = script:FindFirstAncestor("MainModule").Value.Modules

local function onlyHashesOrWhitespace(text: string): boolean
	for index = 1, #text do
		local char = text:sub(index, index)
		if char ~= "#" and char ~= " " then
			return false
		end
	end
	return true
end

-- Filters a command's text args once, in broadcast context, while the caller is
-- guaranteed online. The results ride entries and broadcast statements as
-- argOverrides so replays never refilter. FilterStringAsync throws when the
-- sender is offline, which is where replayed messages were turning to hashtags
return function(command: any, args: {[any]: any}, callerUserId: number | string): ({[string]: any}?, string?)
	local Args = require(modules.Parser.Args) :: any
	local commandArgs = if typeof(command) == "table" and typeof(command.args) == "table" then command.args else {}
	local overrides: {[string]: any}? = nil
	local firstArg: any = Args.get(commandArgs[1])
	local skipFirst = firstArg ~= nil and firstArg.playerArg == true
	for position, argNameOrDetail in commandArgs do
		local argItem: any = Args.get(argNameOrDetail)
		if not argItem or typeof(argItem.key) ~= "string" then
			continue
		end
		local inputObject = argItem.inputObject
		if typeof(inputObject) ~= "table" or inputObject.filterText ~= true then
			continue
		end
		local stringIndex = if skipFirst then position - 1 else position
		local raw = args[stringIndex]
		if typeof(raw) ~= "string" or raw == "" then
			continue
		end
		local filtered = argItem:parse(raw, callerUserId, nil)
		-- Fields args return an array of strings, so the joined fields stand in for
		-- the single string when judging a filter rejection
		local comparable: string? = nil
		if typeof(filtered) == "string" then
			comparable = filtered
		elseif typeof(filtered) == "table" then
			local allStrings = true
			for _, field in filtered :: {any} do
				if typeof(field) ~= "string" then
					allStrings = false
					break
				end
			end
			if allStrings then
				comparable = table.concat(filtered :: {string}, " ")
			end
		end
		if comparable == nil or (onlyHashesOrWhitespace(comparable) and not onlyHashesOrWhitespace(raw)) then
			local commandName = tostring(command.name or command.key)
			return nil, `The text for '{commandName}' was rejected by the filter, so nothing was saved`
		end
		if not overrides then
			overrides = {}
		end
		overrides[tostring(position)] = filtered
	end
	return overrides, nil
end
