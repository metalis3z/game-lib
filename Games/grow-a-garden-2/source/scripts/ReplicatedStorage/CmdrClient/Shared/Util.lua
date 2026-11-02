--credit to leon games studio
local TextService = game:GetService("TextService")
local t = {
	MakeDictionary = function(p1) --[[ MakeDictionary | Line: 6 ]]
		local t = {}

		for i = 1, #p1 do
			t[p1[i]] = true
		end

		return t
	end,
	DictionaryKeys = function(p1) --[[ DictionaryKeys | Line: 17 ]]
		local t = {}

		for k in pairs(p1) do
			table.insert(t, k)
		end

		return t
	end
}

local function transformInstanceSet(p1) --[[ transformInstanceSet | Line: 28 ]]
	local t = {}

	for i = 1, #p1 do
		t[i] = p1[i].Name
	end

	return t, p1
end

function t.MakeFuzzyFinder(p1) --[[ MakeFuzzyFinder | Line: 42 ]]
	local v1 = nil
	local t = {}

	if typeof(p1) == "Enum" then
		p1 = p1:GetEnumItems()
	end

	if typeof(p1) == "Instance" then
		local v3 = p1:GetChildren()
		local t2 = {}

		for i = 1, #v3 do
			t2[i] = v3[i].Name
		end

		t = v3
		v1 = t2
	elseif typeof(p1) == "table" then
		local v5, v6

		if typeof(p1[1]) == "Instance" then
			v5 = p1
			v6 = {}

			for j = 1, #p1 do
				v6[j] = v5[j].Name
			end

			t = v5
			v1 = v6
		elseif typeof(p1[1]) == "EnumItem" or typeof(p1[1]) == "table" and typeof(p1[1].Name) == "string" then
			v5 = p1
			v6 = {}

			for j = 1, #p1 do
				v6[j] = v5[j].Name
			end

			t = v5
			v1 = v6
		else
			local v9

			v9 = p1[1]

			if type(v9) == "string" then
				v1 = p1
			elseif p1[1] == nil then
				v1 = {}
			else
				error("MakeFuzzyFinder only accepts tables of instances or strings.")
			end
		end
	else
		error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
	end

	return function(p1, p2) --[[ Line: 70 | Upvalues: v1 (ref), t (ref) ]]
		local t2 = {}

		for k, v in pairs(v1) do
			local v12 = t and t[k] or v

			if v:lower() == p1:lower() then
				if p2 then
					return v12
				end

				table.insert(t2, 1, v12)

				continue
			end

			if v:lower():find(p1:lower(), 1, true) then
				t2[#t2 + 1] = v12
			end
		end

		if p2 then
			return t2[1]
		end

		return t2
	end
end
function t.GetNames(p1) --[[ GetNames | Line: 98 ]]
	local t = {}

	for i = 1, #p1 do
		local v1 = p1[i].Name

		if not v1 then
			v1 = tostring(p1[i])
		end

		t[i] = v1
	end

	return t
end
function t.SplitStringSimple(p1, p2) --[[ SplitStringSimple | Line: 109 ]]
	if p2 == nil then
		p2 = "%s"
	end

	local t = {}
	local count = 1

	for v1 in string.gmatch(p1, "([^" .. p2 .. "]+)") do
		t[count] = v1
		count = count + 1
	end

	return t
end

local function charCode(p1) --[[ charCode | Line: 122 ]]
	return utf8.char((tonumber(p1, 16)))
end

function t.ParseEscapeSequences(p1) --[[ ParseEscapeSequences | Line: 127 | Upvalues: charCode (copy) ]]
	return p1:gsub("\\(.)", {
		t = "\t",
		n = "\n"
	}):gsub("\\u(%x%x%x%x)", charCode):gsub("\\x(%x%x)", charCode)
end
function t.EncodeEscapedOperator(p1, p2) --[[ EncodeEscapedOperator | Line: 136 ]]
	return p1:gsub("(" .. ("%" .. p2:sub(1, 1)) .. "+)(" .. p2:gsub(".", "%%%1") .. ")", function(p1, p2) --[[ Line: 141 ]]
		return (p1:sub(1, #p1 - 1) .. p2):gsub(".", function(p1) --[[ Line: 142 ]]
			return "\\u" .. string.format("%04x", string.byte(p1), 16)
		end)
	end)
end

local t2 = { "&&", "||", ";" }

function t.EncodeEscapedOperators(p1) --[[ EncodeEscapedOperators | Line: 149 | Upvalues: t2 (copy), t (copy) ]]
	for i, v in ipairs(t2) do
		p1 = t.EncodeEscapedOperator(p1, v)
	end

	return p1
end

local function encodeControlChars(p1) --[[ encodeControlChars | Line: 157 ]]
	return p1:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___")
end

local function decodeControlChars(p1) --[[ decodeControlChars | Line: 167 ]]
	return p1:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
end

function t.SplitString(p1, p2) --[[ SplitString | Line: 177 | Upvalues: t (copy) ]]
	local v1 = nil
	local v2 = nil
	local t2 = {}
	local v3 = p2 or (1 / 0)

	for v5 in p1:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
		local v4
		local v6 = t.ParseEscapeSequences(v5)
		local v7 = v6:match("^([\'\"])")
		local v8 = v6:match("([\'\"])$")
		local v9 = v6:match("(\\*)[\'\"]$")

		if v7 and not (v1 or v8) then
			v2 = v6
			v1 = v7
			v4 = v6
		elseif v2 and (v8 == v1 and #v9 % 2 == 0) then
			v2 = nil
			v1 = nil
			v4 = v2 .. " " .. v6
		elseif v2 then
			v2, v4 = v2 .. " " .. v6, v6
		else
			v4 = v6
		end

		if not v2 then
			t2[#t2 + (if v3 < #t2 then 0 else 1)] = v4:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
		end
	end

	if v2 then
		t2[#t2 + (if v3 < #t2 then 0 else 1)] = v2:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
	end

	return t2
end
function t.MashExcessArguments(p1, p2) --[[ MashExcessArguments | Line: 209 ]]
	local t = {}

	for i = 1, #p1 do
		if p2 < i then
			t[p2] = ("%s %s"):format(t[p2] or "", p1[i])

			continue
		end

		t[i] = p1[i]
	end

	return t
end
function t.TrimString(p1) --[[ TrimString | Line: 222 ]]
	local _, v1 = string.find(p1, "^%s*")

	if v1 == #p1 then
		return ""
	end

	return string.match(p1, ".*%S", v1 + 1)
end
function t.GetTextSize(p1, p2, p3) --[[ GetTextSize | Line: 229 | Upvalues: TextService (copy) ]]
	return TextService:GetTextSize(p1, p2.TextSize, p2.Font, if p3 then p3 else Vector2.new(p2.AbsoluteSize.X, 0))
end
function t.MakeEnumType(p1, p2) --[[ MakeEnumType | Line: 234 | Upvalues: t (copy) ]]
	local v1 = t.MakeFuzzyFinder(p2)

	return {
		Validate = function(p12) --[[ Validate | Line: 237 | Upvalues: v1 (copy), p1 (copy) ]]
			return v1(p12, true) ~= nil, ("Value %q is not a valid %s."):format(p12, p1)
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 240 | Upvalues: v1 (copy), t (ref) ]]
			local v12 = v1(p1)

			return type(v12[1]) ~= "string" and t.GetNames(v12) or v12
		end,
		Parse = function(p1) --[[ Parse | Line: 244 | Upvalues: v1 (copy) ]]
			return v1(p1, true)
		end
	}
end
function t.ParsePrefixedUnionType(p1, p2) --[[ ParsePrefixedUnionType | Line: 251 | Upvalues: t (copy) ]]
	local v1 = t.SplitStringSimple(p1)
	local t2 = {}

	for i = 1, #v1, 2 do
		t2[#t2 + 1] = {
			prefix = v1[i - 1] or "",
			type = v1[i]
		}
	end

	table.sort(t2, function(p1, p2) --[[ Line: 265 ]]
		return #p1.prefix > #p2.prefix
	end)

	for j = 1, #t2 do
		local v2 = t2[j]

		if p2:sub(1, #v2.prefix) == v2.prefix then
			return v2.type, p2:sub(#v2.prefix + 1), v2.prefix
		end
	end
end
function t.MakeListableType(p1, p2) --[[ MakeListableType | Line: 280 ]]
	local t = {
		Listable = true,
		Transform = p1.Transform,
		Validate = p1.Validate,
		ValidateOnce = p1.ValidateOnce,
		Autocomplete = p1.Autocomplete,
		Default = p1.Default,
		ArgumentOperatorAliases = p1.ArgumentOperatorAliases,
		Parse = function(...) --[[ Parse | Line: 289 | Upvalues: p1 (copy) ]]
			return { p1.Parse(...) }
		end
	}

	if p2 then
		for k, v in pairs(p2) do
			t[k] = v
		end
	end

	return t
end

local function encodeCommandEscape(p1) --[[ encodeCommandEscape | Line: 303 ]]
	return p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
end

local function decodeCommandEscape(p1) --[[ decodeCommandEscape | Line: 307 ]]
	return p1:gsub("___!CMDR_DOLLAR!___", "$")
end

function t.RunCommandString(p1, p2) --[[ RunCommandString | Line: 311 | Upvalues: t (copy) ]]
	local v2 = t.EncodeEscapedOperators((t.ParseEscapeSequences(p2))):split("&&")
	local v3 = ""

	for i, v in ipairs(v2) do
		local v4 = v3:gsub("%$", "\\x24"):gsub("%%", "%%%%")
		local v9 = tostring(p1:EvaluateAndRun((t.RunEmbeddedCommands(p1, (v:gsub("||", v3:find("%s") and ("%q"):format(v4) or v4))))))

		if i == #v2 then
			return v9
		end

		v3 = v9
	end
end
function t.RunEmbeddedCommands(p1, p2) --[[ RunEmbeddedCommands | Line: 338 | Upvalues: t (copy) ]]
	local v1 = p2:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local t2, v2 = {}, v1

	for v4 in v1:gmatch("$(%b{})") do
		local v3
		local v5 = v4:sub(2, #v4 - 1)

		if v5:match("^{.+}$") then
			v5, v3 = v5:sub(2, #v5 - 1), false
		else
			v3 = true
		end

		t2[v4] = t.RunCommandString(p1, v5)

		if v3 and (t2[v4]:find("%s") or t2[v4] == "") then
			t2[v4] = string.format("%q", t2[v4])
		end
	end

	return v2:gsub("$(%b{})", t2):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.SubstituteArgs(p1, p2) --[[ SubstituteArgs | Line: 366 ]]
	local v1 = p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local v2

	if type(p2) == "table" then
		v2 = v1

		for i = 1, #p2 do
			local v3 = tostring(i)

			p2[v3] = p2[i]

			if p2[v3]:find("%s") then
				p2[v3] = string.format("%q", p2[v3])
			end
		end
	else
		v2 = v1
	end

	return v2:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p2):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.MakeAliasCommand(p1, p2) --[[ MakeAliasCommand | Line: 383 | Upvalues: t (copy) ]]
	local v1, v2 = unpack(p1:split("|"))
	local v3 = t.EncodeEscapedOperators(p2)
	local t2 = {}
	local t3 = {}

	for v9 in v3:gmatch("$(%d+)") do
		local v4, v5, v6, v7, v8

		if t2[v9] == nil then
			t2[v9] = true

			local v10 = v3:match((("$%*(%%b{})"):format(v9)))

			if v10 then
				local v12, v13, v14 = unpack(v10:sub(2, #v10 - 1):split("|"))

				v4 = v12
				v5 = v13
				v6 = v14
			else
				v4 = nil
				v5 = nil
				v6 = nil
			end

			local v15 = if v4 then v4:match("%?$") and true or false else v4

			v7 = if v4 then v4:match("^%w+") else "string"
			v8 = v5 or ("Argument %*"):format(v9)
			table.insert(t3, {
				Type = v7,
				Name = v8,
				Description = v6 or "",
				Optional = v15
			})
		end
	end

	return {
		Group = "UserAlias",
		Name = v1,
		Aliases = {},
		Description = ("<Alias> %*"):format(v2 or v3),
		Args = t3,
		Run = function(p1) --[[ Run | Line: 422 | Upvalues: t (ref), v3 (ref) ]]
			return t.RunCommandString(p1.Dispatcher, t.SubstituteArgs(v3, p1.RawArguments))
		end
	}
end
function t.MakeSequenceType(p1) --[[ MakeSequenceType | Line: 429 | Upvalues: t (copy) ]]
	local v2 = p1 or {}
	local v3 = if v2.Parse == nil then if v2.Constructor == nil then false else true else true

	assert(v3, "MakeSequenceType: Must provide one of: Constructor, Parse")
	v2.TransformEach = v2.TransformEach or (function(...) --[[ Line: 434 ]]
		return ...
	end)
	v2.ValidateEach = v2.ValidateEach or (function() --[[ Line: 438 ]]
		return true
	end)

	local t2 = {
		Prefixes = v2.Prefixes,
		Transform = function(p1) --[[ Transform | Line: 445 | Upvalues: t (ref), v2 (ref) ]]
			return t.Map(t.SplitPrioritizedDelimeter(p1, { ",", "%s" }), function(p1) --[[ Line: 446 | Upvalues: v2 (ref) ]]
				return v2.TransformEach(p1)
			end)
		end,
		Validate = function(p1) --[[ Validate | Line: 451 | Upvalues: v2 (ref) ]]
			if v2.Length and #p1 > v2.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(v2.Length)
			end

			for i = 1, v2.Length or #p1 do
				local v3, v4 = v2.ValidateEach(p1[i], i)

				if not v3 then
					return false, v4
				end
			end

			return true
		end
	}

	t2.Parse = v2.Parse or (function(p1) --[[ Line: 467 | Upvalues: v2 (ref) ]]
		return v2.Constructor(unpack(p1))
	end)

	return t2
end
function t.SplitPrioritizedDelimeter(p1, p2) --[[ SplitPrioritizedDelimeter | Line: 475 | Upvalues: t (copy) ]]
	for i, v in ipairs(p2) do
		if p1:find(v) or i == #p2 then
			return t.SplitStringSimple(p1, v)
		end
	end
end
function t.Map(p1, p2) --[[ Map | Line: 484 ]]
	local t = {}

	for i, v in ipairs(p1) do
		t[i] = p2(v, i)
	end

	return t
end
function t.Each(p1, ...) --[[ Each | Line: 495 ]]
	local t = {}

	for i, v in ipairs({ ... }) do
		t[i] = p1(v)
	end

	return unpack(t)
end
function t.EmulateTabstops(p1, p2) --[[ EmulateTabstops | Line: 504 ]]
	local v1 = #p1
	local v2 = table.create(v1)
	local sum = 0

	for i = 1, v1 do
		local v3 = string.sub(p1, i, i)

		if v3 == "\t" then
			local v4 = p2 - sum % p2

			table.insert(v2, string.rep(" ", v4))
			sum = sum + v4

			continue
		end

		table.insert(v2, v3)

		if v3 == "\n" then
			sum = 0

			continue
		end

		if v3 ~= "\r" then
			sum = sum + 1
		end
	end

	return table.concat(v2)
end
function t.Mutex() --[[ Mutex | Line: 526 ]]
	local t = {}
	local v1 = false

	return function() --[[ Line: 530 | Upvalues: v1 (ref), t (copy) ]]
		if v1 then
			table.insert(t, coroutine.running())
			coroutine.yield()
		else
			v1 = true
		end

		return function() --[[ Line: 538 | Upvalues: t (ref), v1 (ref) ]]
			if #t > 0 then
				coroutine.resume(table.remove(t, 1))
			else
				v1 = false
			end
		end
	end
end

return t