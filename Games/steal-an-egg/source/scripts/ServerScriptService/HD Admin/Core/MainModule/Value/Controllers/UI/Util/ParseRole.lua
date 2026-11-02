--!strict

--[[

	The custom parser for the role settings page Data popup

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local DEFAULT_ROLE = require(modules.References.defaultRole)


-- TOKENIZER
type Token = {
	type: string, -- "punct" | "ident" | "number" | "string" | "keyword"
	value: any,
	pos: number,
}

local PUNCTS: {[string]: true} = {
	["{"] = true, ["}"] = true, ["("] = true, [")"] = true,
	[","] = true, ["="] = true, ["."] = true,
}
local KEYWORDS: {[string]: true} = {
	["true"] = true, ["false"] = true, ["return"] = true, ["nil"] = true,
}

local function tokenize(src: string): (boolean, {Token} | string)
	local tokens: {Token} = {}
	local index = 1
	local srcLength = #src
	while index <= srcLength do
		local char = src:sub(index, index)
		if char == " " or char == "\t" or char == "\n" or char == "\r" then
			index += 1
		elseif char == "-" and src:sub(index + 1, index + 1) == "-" then
			while index <= srcLength and src:sub(index, index) ~= "\n" do index += 1 end
		elseif PUNCTS[char] then
			table.insert(tokens, { type = "punct", value = char, pos = index })
			index += 1
		elseif char == '"' or char == "'" then
			local quote = char
			local start = index
			index += 1
			local parts: {string} = {}
			while index <= srcLength do
				local ch = src:sub(index, index)
				if ch == "\\" then
					local nxt = src:sub(index + 1, index + 1)
					if nxt == "n" then table.insert(parts, "\n")
					elseif nxt == "t" then table.insert(parts, "\t")
					elseif nxt == "r" then table.insert(parts, "\r")
					elseif nxt == "\\" then table.insert(parts, "\\")
					elseif nxt == quote then table.insert(parts, quote)
					elseif nxt == "0" then table.insert(parts, "\0")
					else table.insert(parts, nxt) end
					index += 2
				elseif ch == quote then
					index += 1
					table.insert(tokens, { type = "string", value = table.concat(parts), pos = start })
					break
				elseif ch == "\n" then
					return false, `Unterminated string at position {start}`
				else
					table.insert(parts, ch)
					index += 1
				end
			end
		elseif char:match("[%-%d]") and (char ~= "-" or src:sub(index + 1, index + 1):match("%d")) then
			local start = index
			if char == "-" then index += 1 end
			while index <= srcLength and src:sub(index, index):match("[%d%.]") do index += 1 end
			local numStr = src:sub(start, index - 1)
			local num = tonumber(numStr)
			if not num then
				return false, `Invalid number '{numStr}' at position {start}`
			end
			table.insert(tokens, { type = "number", value = num, pos = start })
		elseif char:match("[%a_]") then
			local start = index
			while index <= srcLength and src:sub(index, index):match("[%w_]") do index += 1 end
			local word = src:sub(start, index - 1)
			if KEYWORDS[word] then
				table.insert(tokens, { type = "keyword", value = word, pos = start })
			else
				table.insert(tokens, { type = "ident", value = word, pos = start })
			end
		else
			return false, `Unexpected character '{char}' at position {index}`
		end
	end
	return true, tokens
end


-- PARSER
type ParseState = { tokens: {Token}, index: number }

local parseValue: (ParseState) -> (boolean, any)
local parseTable: (ParseState) -> (boolean, any)

local function peek(state: ParseState): Token?
	return state.tokens[state.index]
end
local function consume(state: ParseState): Token?
	local token = state.tokens[state.index]
	state.index += 1
	return token
end
local function expect(state: ParseState, ttype: string, tvalue: any?): (boolean, any)
	local token = peek(state)
	if not token then return false, `Unexpected end of input (expected {ttype}{if tvalue ~= nil then ` '{tvalue}'` else ""})` end
	if token.type ~= ttype then
		return false, `Expected {ttype} at position {token.pos}, got {token.type} '{tostring(token.value)}'`
	end
	if tvalue ~= nil and token.value ~= tvalue then
		return false, `Expected '{tvalue}' at position {token.pos}, got '{tostring(token.value)}'`
	end
	state.index += 1
	return true, token
end

parseValue = function(state: ParseState): (boolean, any)
	local token = peek(state)
	if not token then return false, "Unexpected end of input while parsing value" end
	if token.type == "keyword" then
		if token.value == "true" then state.index += 1; return true, true end
		if token.value == "false" then state.index += 1; return true, false end
		if token.value == "nil" then state.index += 1; return true, nil end
		return false, `Unexpected keyword '{token.value}' at position {token.pos}`
	end
	if token.type == "number" then state.index += 1; return true, token.value end
	if token.type == "string" then state.index += 1; return true, token.value end
	if token.type == "ident" and token.value == "Color3" then
		state.index += 1
		local ok, err = expect(state, "punct", "."); if not ok then return false, err end
		local methodToken = peek(state)
		if not methodToken or methodToken.type ~= "ident" or methodToken.value ~= "fromRGB" then
			return false, `Expected 'fromRGB' after 'Color3.' at position {if methodToken then methodToken.pos else 0}`
		end
		state.index += 1
		ok, err = expect(state, "punct", "("); if not ok then return false, err end
		local okR, red = parseValue(state); if not okR then return false, red end
		ok, err = expect(state, "punct", ","); if not ok then return false, err end
		local okG, green = parseValue(state); if not okG then return false, green end
		ok, err = expect(state, "punct", ","); if not ok then return false, err end
		local okB, blue = parseValue(state); if not okB then return false, blue end
		ok, err = expect(state, "punct", ")"); if not ok then return false, err end
		if typeof(red) ~= "number" or typeof(green) ~= "number" or typeof(blue) ~= "number" then
			return false, "Color3.fromRGB arguments must be numbers"
		end
		return true, Color3.fromRGB(red, green, blue)
	end
	if token.type == "punct" and token.value == "{" then
		return parseTable(state)
	end
	return false, `Unexpected token '{tostring(token.value)}' at position {token.pos}`
end

parseTable = function(state: ParseState): (boolean, any)
	local ok, err = expect(state, "punct", "{"); if not ok then return false, err end
	local result: any = {}
	local token = peek(state)
	if token and token.type == "punct" and token.value == "}" then
		state.index += 1
		return true, result
	end
	local isArray = true
	local arrIndex = 1
	while true do
		local tok = peek(state)
		if not tok then return false, "Unexpected end of input inside table" end
		if tok.type == "ident" and state.tokens[state.index + 1]
			and state.tokens[state.index + 1].type == "punct"
			and state.tokens[state.index + 1].value == "=" then
			isArray = false
			local key = tok.value
			state.index += 2 -- consume ident and "="
			local okV, value = parseValue(state); if not okV then return false, value end
			result[key] = value
		else
			if not isArray then
				return false, `Mixed array/dict syntax at position {tok.pos}`
			end
			local okV, value = parseValue(state); if not okV then return false, value end
			result[arrIndex] = value
			arrIndex += 1
		end
		tok = peek(state)
		if not tok then return false, "Unexpected end of input inside table" end
		if tok.type == "punct" and tok.value == "," then
			state.index += 1
			local nxt = peek(state)
			if nxt and nxt.type == "punct" and nxt.value == "}" then
				state.index += 1
				return true, result
			end
		elseif tok.type == "punct" and tok.value == "}" then
			state.index += 1
			return true, result
		else
			return false, `Expected ',' or '}' at position {tok.pos}`
		end
	end
end


-- PUBLIC
-- Returns (true, roleTable, fieldCount) on success, (false, errorMessage) on failure
return function(src: string): (boolean, any, number?)
	local okTok, tokensOrErr = tokenize(src)
	if not okTok then return false, tokensOrErr :: string end
	local tokens = tokensOrErr :: {Token}
	local state: ParseState = { tokens = tokens, index = 1 }
	local first = peek(state)
	if first and first.type == "keyword" and first.value == "return" then
		state.index += 1
	end
	local ok, result = parseTable(state)
	if not ok then return false, result :: string end
	local trailing = peek(state)
	if trailing then
		return false, `Unexpected token '{tostring(trailing.value)}' after top-level table at position {trailing.pos}`
	end
	-- Only fields that exist in DEFAULT_ROLE (plus name) are accepted, the rest are dropped
	local filtered: {[string]: any} = {}
	local count = 0
	for key, value in result do
		if typeof(key) ~= "string" then continue end
		if key == "key" or key == "rank" or key == "useDefaults" then continue end
		if DEFAULT_ROLE[key] == nil and key ~= "name" then continue end
		filtered[key] = value
		count += 1
	end
	return true, filtered, count
end
