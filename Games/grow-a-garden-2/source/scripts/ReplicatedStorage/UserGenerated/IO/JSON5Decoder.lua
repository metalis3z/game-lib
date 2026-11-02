--credit to leon games studio
local list = {
	"\225\154\128",
	"\226\128\128",
	"\226\128\129",
	"\226\128\130",
	"\226\128\131",
	"\226\128\132",
	"\226\128\133",
	"\226\128\134",
	"\226\128\135",
	"\226\128\136",
	"\226\128\137",
	"\226\128\138",
	"\226\128\168",
	"\226\128\169",
	"\226\128\175",
	"\226\129\159",
	"\227\128\128",
	"\194\160",
	"\r\n",
	"\t",
	"\n",
	"\11",
	"\f",
	"\r",
	" "
}

local function MAKE_LOOKUP(p1) --[[ MAKE_LOOKUP | Line: 68 ]]
	local t = {}

	for i, v in ipairs(p1) do
		t[v] = true
	end

	return t
end

local t = {}
local list2 = { "\226\128\168", "\226\128\169", "\r\n", "\r", "\n" }

for i, v in ipairs(list) do
	t[v] = true
end

local t2 = {}

for i, v in ipairs(list2) do
	t2[v] = true
end

local v1 = t2
local t3 = {
	["0"] = "\0",
	["\'"] = "\'",
	["\""] = "\"",
	["\\"] = "\\",
	b = "\8",
	f = "\f",
	n = "\n",
	r = "\r",
	t = "\t",
	v = "\11"
}

local function Q(p1) --[[ Q | Line: 92 ]]
	return string.format("%q", p1):gsub("\r", "\\r"):gsub("\n", "\\n")
end

local function formatError(p1, p2) --[[ formatError | Line: 98 ]]
	return string.format("%s at line %d col %d", p1, p2[1], p2[2])
end

local function advanceNewline(p1, p2) --[[ advanceNewline | Line: 107 | Upvalues: v1 (copy) ]]
	if v1[p1] then
		p2[1] = p2[1] + 1
		p2[2] = 1

		return true
	end

	return false
end

local function getNewline(p1, p2) --[[ getNewline | Line: 122 | Upvalues: list2 (copy), v1 (copy) ]]
	for i, v in ipairs(list2) do
		local v12

		if p1:sub(1, #v) == v then
			if v1[v] then
				p2[1] = p2[1] + 1
				p2[2] = 1
				v12 = true
			else
				v12 = false
			end

			if v12 then
				return v
			end
		end
	end

	return nil
end

local function getWhitespace(p1, p2) --[[ getWhitespace | Line: 137 | Upvalues: list (copy), v1 (copy) ]]
	if #p1 == 0 then
		return nil
	end

	for i, v in ipairs(list) do
		if p1:sub(1, #v) == v then
			p2[2] = p2[2] + #v

			if v1[v] then
				p2[1] = p2[1] + 1
				p2[2] = 1
			end

			return v
		end
	end

	return nil
end

local function stripWhitespace(p1, p2) --[[ stripWhitespace | Line: 158 | Upvalues: getWhitespace (copy) ]]
	while true do
		local v1 = getWhitespace(p1, p2)

		if v1 == nil then
			break
		end

		p1 = p1:sub(#v1 + 1)
	end

	return p1
end

local function stripInlineComments(p1, p2) --[[ stripInlineComments | Line: 178 | Upvalues: getNewline (copy) ]]
	while #p1 ~= 0 do
		local v1 = getNewline(p1, p2)

		if v1 then
			return p1:sub(#v1 + 1)
		end

		local v2 = p1:sub(2)

		p2[2] = p2[2] + 1
		p1 = v2
	end

	return p1
end

local function stripBlockComments(p1, p2) --[[ stripBlockComments | Line: 205 | Upvalues: getNewline (copy), formatError (copy) ]]
	while #p1 > 0 do
		if p1:sub(1, 2) == "*/" then
			p2[2] = p2[2] + 2

			return p1:sub(3)
		end

		local v1 = getNewline(p1, p2)

		if v1 then
			p1 = p1:sub(#v1 + 1)
		else
			p2[2] = p2[2] + 1
			p1 = p1:sub(2)
		end
	end

	error(formatError("missing multiline comment close tag", p2))
end

local function codepointToutf8(p1) --[[ codepointToutf8 | Line: 232 ]]
	if p1 <= 127 then
		return string.char(p1)
	end

	if p1 <= 2047 then
		return string.char(math.floor(p1 / 64) + 192, p1 % 64 + 128)
	end

	if p1 <= 65535 then
		local v2 = math.floor(p1 / 4096) + 224

		return string.char(v2, math.floor(p1 % 4096 / 64) + 128, p1 % 64 + 128)
	end

	if p1 <= 1114111 then
		local v4 = math.floor(p1 / 262144) + 240
		local v5 = math.floor(p1 % 262144 / 4096) + 128

		return string.char(v4, v5, math.floor(p1 % 4096 / 64) + 128, p1 % 64 + 128)
	end

	return nil, string.format("invalid unicode codepoint \'%x\'", p1)
end

local function parseUnicodeImpl(p1, p2) --[[ parseUnicodeImpl | Line: 257 | Upvalues: formatError (copy) ]]
	local v1 = p1:match("^\\u(%x%x%x%x)")

	if not v1 then
		error(formatError("invalid unicode hex escape sequence", p2))
	end

	local v2 = tonumber(v1, 16)

	if not v2 then
		error(formatError("invalid unicode hex escape sequence", p2))
	end

	p2[2] = p2[2] + 6

	return v2, p1:sub(7)
end

local function getSurrogatePair(p1, p2) --[[ getSurrogatePair | Line: 277 ]]
	return (p2 - 55296) * 1024 + (p1 - 56320) + 65536
end

local function parseUnicode(p1, p2) --[[ parseUnicode | Line: 283 | Upvalues: parseUnicodeImpl (copy), codepointToutf8 (copy), formatError (copy) ]]
	local v3, v4 = parseUnicodeImpl(p1, p2)
	local v5, v6

	if v3 >= 55296 and v3 < 56320 then
		local v7, v8 = parseUnicodeImpl(v4, p2)

		if v7 and (v7 >= 56320 and v7 <= 57343) then
			v5 = (v3 - 55296) * 1024 + (v7 - 56320) + 65536
			v6 = v8
		else
			v5 = v3
			v6 = v8
		end
	else
		v5 = v3
		v6 = v4
	end

	local v9, v10 = codepointToutf8(v5)

	if v9 then
		return v9, v6
	end

	error(formatError(assert(v10), { p2[1], p2[2] }))
end

local function parseStringImpl(p1, p2, p3, p4) --[[ parseStringImpl | Line: 316 | Upvalues: t3 (copy), formatError (copy), parseUnicode (copy), getNewline (copy) ]]
	local t = {}

	while not p2(p1) do
		local v1 = p1:sub(1, 1)

		if v1 == "\\" then
			local v2 = p1:sub(2, 2)

			p4[2] = p4[2] + 1

			if t3[v2] then
				p4[2] = p4[2] + 1

				if p3 then
					error(formatError("escape sequence not allowed", p4))
				end

				t[#t + 1] = t3[v2]
				p1 = p1:sub(3)

				continue
			end

			if v2 == "u" then
				local v4, v5 = parseUnicode(p1, p4)

				t[#t + 1] = v4
				p1 = v5

				continue
			end

			if v2 == "x" then
				if p3 then
					error(formatError("hex escape sequence not allowed", p4))
				end

				p4[2] = p4[2] + 2

				local v7 = tonumber(p1:sub(2, 3), 16)

				if not v7 then
					error(formatError("invalid hex escape sequence", p4))
				end

				t[#t + 1] = string.char(v7)
				p4[2] = p4[2] + 2
				p1 = p1:sub(5)

				continue
			end

			if p3 then
				error(formatError("invalid escape sequence", p4))
			end

			local v9 = getNewline(p1:sub(2), p4)

			p1 = p1:sub(if v9 then #v9 + 2 else 2)
		else
			if v1:byte(1, 1) < 32 then
				error(formatError("control character found", p4))
			end

			t[#t + 1] = v1

			local v12 = p1:sub(2)

			p4[2] = p4[2] + 1
			p1 = v12
		end
	end

	return table.concat(t), p1
end

local function parseString(p1, p2) --[[ parseString | Line: 395 | Upvalues: parseStringImpl (copy) ]]
	local v1 = p1:sub(1, 1)

	local function stopCriterion(p1) --[[ stopCriterion | Line: 403 | Upvalues: v1 (copy) ]]
		return p1:sub(1, 1) == v1
	end

	local v2, v3 = parseStringImpl(p1:sub(2), stopCriterion, false, p2)

	p2[2] = p2[2] + 1

	return v2, v3:sub(2)
end

local function parseNumber(p1, p2) --[[ parseNumber | Line: 416 | Upvalues: getWhitespace (copy), formatError (copy) ]]
	local v1 = 1
	local v2 = p1:sub(1, 1)
	local v3 = p2[1]
	local v4 = p2[2]

	if v2 == "+" then
		local v5 = p1:sub(2)

		p2[2] = p2[2] + 1
		p1 = v5
		v1 = 1
	elseif v2 == "-" then
		local v6 = p1:sub(2)

		p2[2] = p2[2] + 1
		p1 = v6
		v1 = -1
	end

	if p1:sub(1, 3) == "NaN" then
		p2[2] = p2[2] + 3

		return (0 / 0), p1:sub(4)
	end

	if p1:find("Infinity", 1, true) == 1 then
		p2[2] = p2[2] + 8

		return (1 / 0) * v1, p1:sub(9)
	end

	local v7, v8 = p1, 0

	while not getWhitespace(v7, p2) do
		local v9 = v7:sub(1, 1)

		if v9 == "" or (v9 == "," or (v9 == "]" or v9 == "}")) then
			break
		end

		local v10 = v7:sub(2)

		p2[2] = p2[2] + 1
		v7, v8 = v10, v8 + 1
	end

	local v11 = p1:sub(1, v8)
	local v12 = if v11:sub(1, 1) == "0" and v11:sub(2):find("^%d+$") then nil else tonumber(v11)

	if v12 ~= nil then
		p2[2] = p2[2] + v8

		return v12 * v1, p1:sub(v8 + 1)
	end

	error(formatError("invalid number sequence " .. string.format("%q", v11):gsub("\r", "\\r"):gsub("\n", "\\n"), { v3, v4 }))
end

local function parseNull(p1, p2, p3) --[[ parseNull | Line: 486 | Upvalues: formatError (copy) ]]
	if p1:sub(1, 4) ~= "null" then
		error(formatError("invalid null literal", p2))
	end

	p2[2] = p2[2] + 1

	return p3, p1:sub(5)
end

local function parseBoolean(p1, p2) --[[ parseBoolean | Line: 501 | Upvalues: formatError (copy) ]]
	if p1:sub(1, 4) == "true" then
		p2[2] = p2[2] + 4

		return true, p1:sub(5)
	end

	if p1:sub(1, 5) == "false" then
		p2[2] = p2[2] + 5

		return false, p1:sub(6)
	end

	error(formatError("invalid boolean literal", p2))
end

local function stripComments(p1, p2) --[[ stripComments | Line: 518 | Upvalues: stripInlineComments (copy), stripBlockComments (copy) ]]
	local v1 = p1:sub(1, 2)

	if v1 == "//" then
		p2[2] = p2[2] + 2

		return stripInlineComments(p1:sub(3), p2)
	end

	if v1 == "/*" then
		p2[2] = p2[2] + 2

		return stripBlockComments(p1:sub(3), p2)
	end

	return p1
end

local function stripWhitespaceAndComments(p1, p2) --[[ stripWhitespaceAndComments | Line: 536 | Upvalues: stripWhitespace (copy), stripComments (copy) ]]
	while true do
		local v1 = stripComments(stripWhitespace(p1, p2), p2)

		if v1 == p1 then
			break
		end

		p1 = v1
	end

	return p1
end

local v2 = nil

local function parseArray(p1, p2, p3) --[[ parseArray | Line: 564 | Upvalues: stripWhitespaceAndComments (copy), v2 (ref), formatError (copy) ]]
	local v1 = p1:sub(2)

	p2[2] = p2[2] + 1

	local v22, v3 = v1, {}
	local v4, v5

	while true do
		v4 = stripWhitespaceAndComments(v22, p2)

		if v4:sub(1, 1) == "]" then
			break
		end

		local v6, v7 = v2(v4, p2, p3)
		local v8 = stripWhitespaceAndComments(v7, p2)

		v3[#v3 + 1] = v6

		local v9 = v8:sub(1, 1)
		local v10 = v8:sub(2)

		if v9 == "]" then
			p2[2] = p2[2] + 1
			v5 = v10

			return v3, v10
		end

		if v9 ~= "," then
			error(formatError("expected comma got " .. string.format("%q", v9):gsub("\r", "\\r"):gsub("\n", "\\n"), p2))
		end

		p2[2] = p2[2] + 1
		v22 = v10
	end

	p2[2] = p2[2] + 1
	v5 = v4:sub(2)

	return v3, v5
end

local function testIdentifier(p1) --[[ testIdentifier | Line: 610 ]]
	local v1 = p1:byte(1, 1)

	if v1 >= 48 and v1 <= 57 then
		return false
	end

	for i = 1, #p1 do
		local v2 = p1:byte(i, i)

		if v2 < 36 then
			return false
		end

		if v2 >= 37 and v2 <= 47 then
			return false
		end

		if v2 >= 58 and v2 <= 64 then
			return false
		end

		if v2 >= 91 and v2 <= 94 then
			return false
		end

		if v2 == 96 then
			return false
		end

		if v2 >= 123 and v2 <= 128 then
			return false
		end
	end

	return true
end

local function stopIdentifier(p1) --[[ stopIdentifier | Line: 649 | Upvalues: getWhitespace (copy) ]]
	return if p1:sub(1, 1) == ":" then true else getWhitespace(p1, { 0, 0 }) ~= nil
end

local function parseIdentifier(p1, p2) --[[ parseIdentifier | Line: 657 | Upvalues: parseString (copy), parseStringImpl (copy), stopIdentifier (copy), testIdentifier (copy), formatError (copy) ]]
	local v1 = p1:sub(1, 1)
	local v2, v3

	if v1 == "\'" or v1 == "\"" then
		local v4, v5 = parseString(p1, p2)

		v2 = v4
		v3 = v5
	else
		local v6 = p2[1]
		local v7 = p2[2]
		local v8, v9 = parseStringImpl(p1, stopIdentifier, true, p2)

		if not testIdentifier(v8) then
			error(formatError("invalid identifier " .. string.format("%q", v8):gsub("\r", "\\r"):gsub("\n", "\\n"), { v6, v7 }))
		end

		v2 = v8
		v3 = v9
	end

	return v2, v3
end

local t4 = {
	["-"] = parseNumber,
	["+"] = parseNumber,
	["."] = parseNumber,
	["0"] = parseNumber,
	["1"] = parseNumber,
	["2"] = parseNumber,
	["3"] = parseNumber,
	["4"] = parseNumber,
	["5"] = parseNumber,
	["6"] = parseNumber,
	["7"] = parseNumber,
	["8"] = parseNumber,
	["9"] = parseNumber,
	N = parseNumber,
	I = parseNumber,
	n = parseNull,
	t = parseBoolean,
	f = parseBoolean,
	["\'"] = parseString,
	["\""] = parseString,
	["["] = parseArray,
	["{"] = function(p1, p2, p3) --[[ parseObject | Line: 685 | Upvalues: stripWhitespaceAndComments (copy), parseIdentifier (copy), formatError (copy), v2 (ref) ]]
		p2[2] = p2[2] + 1

		local v22, v3 = p1:sub(2), {}
		local v4, v5

		while true do
			v4 = stripWhitespaceAndComments(v22, p2)

			if v4:sub(1, 1) == "}" then
				break
			end

			local v6, v7 = parseIdentifier(v4, p2)
			local v8 = stripWhitespaceAndComments(v7, p2)

			if v8:sub(1, 1) ~= ":" then
				error(formatError("expected colon after identifier, got " .. string.format("%q", (v8:sub(1, 1))):gsub("\r", "\\r"):gsub("\n", "\\n"), p2))
			end

			p2[2] = p2[2] + 1

			local v13, v14 = v2(stripWhitespaceAndComments(v8:sub(2), p2), p2, p3)
			local v15 = stripWhitespaceAndComments(v14, p2)

			v3[v6] = v13

			local v16 = v15:sub(1, 1)
			local v17 = v15:sub(2)

			if v16 == "}" then
				p2[2] = p2[2] + 1
				v5 = v17

				return v3, v17
			end

			if v16 ~= "," then
				error(formatError("expected comma got " .. string.format("%q", v16):gsub("\r", "\\r"):gsub("\n", "\\n"), p2))
			end

			p2[2] = p2[2] + 1
			v22 = v17
		end

		p2[2] = p2[2] + 1
		v5 = v4:sub(2)

		return v3, v5
	end,
	[""] = function(p1, p2) --[[ catchEOF | Line: 752 | Upvalues: formatError (copy) ]]
		error(formatError("unexpected eof", p2))
	end
}

v2 = function(p1, p2, p3) --[[ Line: 786 | Upvalues: stripWhitespaceAndComments (copy), t4 (copy), formatError (copy) ]]
	local v1 = stripWhitespaceAndComments(p1, p2)
	local v2 = v1:sub(1, 1)
	local v3 = t4[v2]

	if not v3 then
		error(formatError("invalid value literal " .. string.format("%q", v2):gsub("\r", "\\r"):gsub("\n", "\\n"), p2))
	end

	return v3(v1, p2, p3)
end

local t5 = {
	Null = newproxy(false),
	Decode = function(p1, p2) --[[ Decode | Line: 821 | Upvalues: stripWhitespaceAndComments (copy), v2 (ref), formatError (copy) ]]
		local t = { 1, 1 }
		local v1, v22 = v2(stripWhitespaceAndComments(p1, t), t, p2)

		if not (#stripWhitespaceAndComments(v22, t) > 0) then
			return v1
		end

		error(formatError("trailing garbage", t))
	end
}

return table.freeze(t5)