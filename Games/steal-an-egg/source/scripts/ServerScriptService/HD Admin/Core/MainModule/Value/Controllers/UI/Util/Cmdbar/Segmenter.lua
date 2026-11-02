--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local ParserSettings = require(modules.Parser.ParserSettings)
local isValidPrefix = require(modules.CommandUtil.isValidPrefix)
local spaceSetting = ParserSettings.SpaceSeparator
local collectiveSetting = ParserSettings.Collective
local Segmenter = {}


-- TYPES
export type Token = {
	kind: "prefix" | "command" | "arg",
	text: string,
	start: number,
	finish: number,
	argIndex: number?,
}
export type Item = {
	text: string,
	start: number,
	finish: number,
}
export type Scan = {
	tokens: { Token },
	hasPrefix: boolean,
	prefixChar: string?,
	commandText: string?,
	argCount: number,
}


-- FUNCTIONS
function Segmenter.scan(text: string): Scan
	local tokens: { Token } = {}
	local scan: Scan = { tokens = tokens, hasPrefix = false, prefixChar = nil, commandText = nil, argCount = 0 }
	local length = #text
	local index = 1
	while index <= length do
		if text:sub(index, index) == spaceSetting then
			index += 1
			continue
		end
		local startPos = index
		while index <= length and text:sub(index, index) ~= spaceSetting do
			index += 1
		end
		local finishPos = index - 1
		local tokenText = text:sub(startPos, finishPos)

		if scan.commandText == nil then
			local firstChar = tokenText:sub(1, 1)
			if isValidPrefix(firstChar) then
				scan.hasPrefix = true
				scan.prefixChar = firstChar
				table.insert(tokens, { kind = "prefix", text = firstChar, start = startPos, finish = startPos })
				local commandText = tokenText:sub(2)
				table.insert(tokens, { kind = "command", text = commandText, start = startPos + 1, finish = finishPos })
				scan.commandText = commandText
			else
				table.insert(tokens, { kind = "command", text = tokenText, start = startPos, finish = finishPos })
				scan.commandText = tokenText
			end
		else
			scan.argCount += 1
			table.insert(tokens, { kind = "arg", text = tokenText, start = startPos, finish = finishPos, argIndex = scan.argCount })
		end
	end
	return scan
end

function Segmenter.listItems(argText: string, argStart: number): { Item }
	local items: { Item } = {}
	local cursor = 1
	local length = #argText
	while cursor <= length do
		local nextComma = argText:find(collectiveSetting, cursor, true)
		local itemFinish = if nextComma then nextComma - 1 else length
		table.insert(items, {
			text = argText:sub(cursor, itemFinish),
			start = argStart + cursor - 1,
			finish = argStart + itemFinish - 1,
		})
		if not nextComma then
			break
		end
		cursor = nextComma + 1
	end
	-- A trailing comma opens a fresh empty item
	if length == 0 or argText:sub(length, length) == collectiveSetting then
		table.insert(items, {
			text = "",
			start = argStart + length,
			finish = argStart + length - 1,
		})
	end
	return items
end


return Segmenter
