--credit to quartz games studio
local function IsEqual(p1, p2) --[[ IsEqual | Line: 23 ]]
	if rawequal(p1, p2) then
		return true
	end

	return type(p1) == "number" and (type(p2) == "number" and (p1 ~= p1 and p2 ~= p2))
end

local function IsASCII(p1) --[[ IsASCII | Line: 37 ]]
	for i = 1, string.len(p1) do
		local v1 = string.byte(p1, i)

		if v1 < 32 or v1 > 126 then
			return false
		end
	end

	return true
end

local function IsFinite(p1) --[[ IsFinite | Line: 49 ]]
	return if p1 == p1 and p1 ~= (1 / 0) then p1 ~= (-1 / 0) else false
end

local function IsInteger(p1) --[[ IsInteger | Line: 55 ]]
	return if math.floor(p1) == p1 and p1 ~= (1 / 0) then p1 ~= (-1 / 0) else false
end

local function IsCFrameFinite(p1) --[[ IsCFrameFinite | Line: 59 ]]
	local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = p1:GetComponents()
	local v13 = v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12

	return if v13 == v13 and v13 ~= (1 / 0) then v13 ~= (-1 / 0) else false
end

local function IsVector2Finite(p1) --[[ IsVector2Finite | Line: 67 ]]
	local v1 = p1.X + p1.Y

	return if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false
end

local function IsVector3Finite(p1) --[[ IsVector3Finite | Line: 71 ]]
	local v1 = p1.X + p1.Y + p1.Z

	return if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false
end

local function LuaString(p1) --[[ LuaString | Line: 76 ]]
	local v1, _ = string.format("%q", p1):gsub("\n", "n")

	return v1
end

local function StringRep(p1) --[[ StringRep | Line: 81 ]]
	if type(p1) == "string" then
		local v1, _ = string.format("%q", p1):gsub("\n", "n")

		return v1
	end

	if typeof(p1) == "Instance" then
		return p1:GetFullName()
	end

	return tostring(p1)
end

local function SafeKeyStringRep(p1) --[[ SafeKeyStringRep | Line: 90 ]]
	if type(p1) == "number" or type(p1) == "boolean" then
		return ("%*"):format(p1)
	end

	if type(p1) == "string" then
		local v1 = utf8.len(p1)

		if not v1 then
			return "InvalidUTF8"
		end

		local v2, v3, v4, _, v5, _2

		for i = 1, string.len(p1) do
			local v6 = string.byte(p1, i)

			if v6 < 32 or v6 > 126 then
				v2 = false

				if not v2 then
					return "NonASCII"
				end

				if v1 > 30 then
					v3 = string.sub(p1, 1, 30)
					v4, _ = string.format("%q", v3):gsub("\n", "n")

					return ("%*...%*"):format(v4, v1 - 30)
				end

				v5, _2 = string.format("%q", p1):gsub("\n", "n")

				return v5
			end
		end

		v2 = true

		if not v2 then
			return "NonASCII"
		end

		if v1 > 30 then
			v3 = string.sub(p1, 1, 30)
			v4, _ = string.format("%q", v3):gsub("\n", "n")

			return ("%*...%*"):format(v4, v1 - 30)
		end

		v5, _2 = string.format("%q", p1):gsub("\n", "n")

		return v5
	end

	if typeof(p1) == "Instance" then
		return p1:GetFullName()
	end

	return ("UnknownType(%*)"):format((typeof(p1)))
end

local function StripErrorSource(p1) --[[ StripErrorSource | Line: 111 ]]
	local v1 = tostring(p1)
	local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")

	if v2 and v3 then
		v1 = v3
	end

	return v1
end

local function ParseError(p1) --[[ ParseError | Line: 122 ]]
	local v1 = tostring(p1)
	local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")

	if v2 and v3 then
		v1 = v3
	end

	local v4, v5 = string.match(v1, "^(.+) $(%[.+)$")

	return if v4 then if v5 then v4 else v1 else v1, v5
end

local function MakeError(p1, p2) --[[ MakeError | Line: 134 ]]
	return ("%* $%*"):format(p1, p2)
end

local t = {
	IsCFrameFinite = IsCFrameFinite,
	IsVector2Finite = IsVector2Finite,
	IsVector3Finite = IsVector3Finite
}

function t.Array(p1) --[[ Array | Line: 145 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)

	return function(p12) --[[ Line: 149 | Upvalues: SafeKeyStringRep (ref), p1 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local v1 = rawlen(p12)
		local count = 0

		for k, v in pairs(p12) do
			count = count + 1

			if k ~= count then
				error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end

			if v1 < count then
				error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
			end

			local ok, result = pcall(p1, v)

			if not ok then
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				local v5, v6 = string.match(v2, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v5 then if v6 then v5 else v2 else v2, (("[%*]%*"):format(count, v6 or ""))), 2)
			end
		end

		if v1 == count then
			return p12
		end

		error("LengthMismatch", 2)
	end
end
function t.ArrayCoerce(p1) --[[ ArrayCoerce | Line: 179 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)

	return function(p12) --[[ Line: 183 | Upvalues: SafeKeyStringRep (ref), p1 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local v1 = rawlen(p12)
		local count = 0
		local t = {}

		for k, v in pairs(p12) do
			count = count + 1

			if k ~= count then
				error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end

			if v1 < count then
				error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
			end

			local ok, result = pcall(p1, v)

			if not ok then
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				local v5, v6 = string.match(v2, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v5 then if v6 then v5 else v2 else v2, (("[%*]%*"):format(count, v6 or ""))), 2)
			end

			t[k] = result
		end

		if v1 == count then
			return t
		end

		error("LengthMismatch", 2)
	end
end
function t.UniqueArray(p1) --[[ UniqueArray | Line: 215 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)

	return function(p12) --[[ Line: 219 | Upvalues: SafeKeyStringRep (ref), p1 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local v1 = rawlen(p12)
		local count = 0
		local t = {}

		for k, v in pairs(p12) do
			count = count + 1

			if k ~= count then
				error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end

			if v1 < count then
				error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
			end

			if t[v] then
				error(("UniqueArray $%*"):format((("[%*]"):format(count))), 2)
			end

			t[v] = true

			if not t[v] then
				error(("InvalidKey $%*"):format((("[%*]"):format(count))), 2)
			end

			local ok, result = pcall(p1, v)

			if not ok then
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				local v5, v6 = string.match(v2, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v5 then if v6 then v5 else v2 else v2, (("[%*]%*"):format(count, v6 or ""))), 2)
			end
		end

		if v1 == count then
			return p12
		end

		error("LengthMismatch", 2)
	end
end
function t.UniqueArrayCoerce(p1) --[[ UniqueArrayCoerce | Line: 257 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)

	return function(p12) --[[ Line: 261 | Upvalues: SafeKeyStringRep (ref), p1 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local v1 = rawlen(p12)
		local count = 0
		local t = {}
		local t2 = {}

		for k, v in pairs(p12) do
			count = count + 1

			if k ~= count then
				error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end

			if v1 < count then
				error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
			end

			if t[v] then
				error(("UniqueArray $%*"):format((("[%*]"):format(count))), 2)
			end

			t[v] = true

			if not t[v] then
				error(("InvalidKey $%*"):format((("[%*]"):format(count))), 2)
			end

			local ok, result = pcall(p1, v)

			if not ok then
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				local v5, v6 = string.match(v2, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v5 then if v6 then v5 else v2 else v2, (("[%*]%*"):format(count, v6 or ""))), 2)
			end

			t2[k] = result
		end

		if v1 == count then
			return t2
		end

		error("LengthMismatch", 2)
	end
end
function t.Map(p1, p2, p3) --[[ Map | Line: 302 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)
	t.Function(p2)
	t.Optional(t.IntegerPositive)(p3)

	local v1 = p3 or (1 / 0)

	return function(p12) --[[ Line: 312 | Upvalues: v1 (copy), p1 (copy), SafeKeyStringRep (ref), p2 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local count = 0

		for k, v in pairs(p12) do
			count = count + 1

			if v1 < count then
				error(("LengthLimit(%*)"):format(v1), 2)
			end

			local ok, result = pcall(p1, k)

			if not ok then
				local v12 = tostring(result)
				local v2, v3 = string.match(v12, "^(.*:%d+): (.+)$")

				if v2 and v3 then
					v12 = v3
				end

				local v4, v5 = string.match(v12, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v4 then if v5 then v4 else v12 else v12, (("<%*>%*"):format(SafeKeyStringRep(k), v5 or ""))), 2)
			end

			local ok2, result2 = pcall(p2, v)

			if not ok2 then
				local v7 = tostring(result2)
				local v8, v9 = string.match(v7, "^(.*:%d+): (.+)$")

				if v8 and v9 then
					v7 = v9
				end

				local v10, v11 = string.match(v7, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v10 then if v11 then v10 else v7 else v7, (("[%*]%*"):format(SafeKeyStringRep(k), v11 or ""))), 2)
			end
		end

		return p12
	end
end
function t.MapCoerce(p1, p2, p3) --[[ MapCoerce | Line: 347 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.Function(p1)
	t.Function(p2)
	t.Optional(t.IntegerPositive)(p3)

	local v1 = p3 or (1 / 0)

	return function(p12) --[[ Line: 357 | Upvalues: v1 (copy), p1 (copy), SafeKeyStringRep (ref), p2 (copy) ]]
		if type(p12) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p12) ~= nil then
			error("metatable", 2)
		end

		local count = 0
		local t = {}

		for k, v in pairs(p12) do
			count = count + 1

			if v1 < count then
				error(("LengthLimit(%*)"):format(v1), 2)
			end

			local ok, result = pcall(p1, k)

			if not ok then
				local v12 = tostring(result)
				local v2, v3 = string.match(v12, "^(.*:%d+): (.+)$")

				if v2 and v3 then
					v12 = v3
				end

				local v4, v5 = string.match(v12, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v4 then if v5 then v4 else v12 else v12, (("<%*>%*"):format(SafeKeyStringRep(k), v5 or ""))), 2)
			end

			local ok2, result2 = pcall(p2, v)

			if not ok2 then
				local v7 = tostring(result2)
				local v8, v9 = string.match(v7, "^(.*:%d+): (.+)$")

				if v8 and v9 then
					v7 = v9
				end

				local v10, v11 = string.match(v7, "^(.+) $(%[.+)$")

				error(("%* $%*"):format(if v10 then if v11 then v10 else v7 else v7, (("[%*]%*"):format(SafeKeyStringRep(k), v11 or ""))), 2)
			end

			t[result] = result2
		end

		return t
	end
end
function t.Table(p1) --[[ Table | Line: 394 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.NoMetatable(p1)

	for k, v in pairs(p1) do
		t.Function(v)
	end

	local v1 = table.clone(p1)

	return function(p1) --[[ Line: 403 | Upvalues: v1 (ref), SafeKeyStringRep (ref) ]]
		if type(p1) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p1) ~= nil then
			error("metatable", 2)
		end

		if rawlen(v1) ~= rawlen(p1) then
			error("LengthMismatch", 2)
		end

		for k, v in pairs(p1) do
			if not v1[k] then
				error(("UnknownKey $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end
		end

		for k, v in pairs(v1) do
			local v2
			local ok, result = pcall(v, p1[k])

			if not ok then
				local v4 = tostring(result)
				local v5, v6 = string.match(v4, "^(.*:%d+): (.+)$")

				if v5 and v6 then
					v4 = v6
				end

				local v7, v8 = string.match(v4, "^(.+) $(%[.+)$")
				local v10 = error

				if type(k) == "string" then
					local v122, _ = string.format("%q", k):gsub("\n", "n")

					v2 = v122
				else
					v2 = if typeof(k) == "Instance" then k:GetFullName() else tostring(k)
				end

				v10(("%* $%*"):format(if v7 then if v8 then v7 else v4 else v4, (("[%*]%*"):format(v2, v8 or ""))), 2)
			end
		end

		return p1
	end
end
function t.TablePermissive(p1) --[[ TablePermissive | Line: 431 | Upvalues: t (copy) ]]
	t.NoMetatable(p1)

	for k, v in pairs(p1) do
		t.Function(v)
	end

	local v1 = table.clone(p1)

	return function(p1) --[[ Line: 440 | Upvalues: v1 (ref) ]]
		if type(p1) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p1) ~= nil then
			error("metatable", 2)
		end

		if rawlen(v1) ~= rawlen(p1) then
			error("LengthMismatch", 2)
		end

		for k, v in pairs(v1) do
			local v2
			local ok, result = pcall(v, p1[k])

			if not ok then
				local v4 = tostring(result)
				local v5, v6 = string.match(v4, "^(.*:%d+): (.+)$")

				if v5 and v6 then
					v4 = v6
				end

				local v7, v8 = string.match(v4, "^(.+) $(%[.+)$")
				local v10 = error

				if type(k) == "string" then
					local v122, _ = string.format("%q", k):gsub("\n", "n")

					v2 = v122
				else
					v2 = if typeof(k) == "Instance" then k:GetFullName() else tostring(k)
				end

				v10(("%* $%*"):format(if v7 then if v8 then v7 else v4 else v4, (("[%*]%*"):format(v2, v8 or ""))), 2)
			end
		end

		return p1
	end
end
function t.TableCoerce(p1) --[[ TableCoerce | Line: 469 | Upvalues: t (copy), SafeKeyStringRep (copy) ]]
	t.NoMetatable(p1)

	for k, v in pairs(p1) do
		t.Function(v)
	end

	local v1 = table.clone(p1)

	return function(p1) --[[ Line: 478 | Upvalues: v1 (ref), SafeKeyStringRep (ref) ]]
		if type(p1) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p1) ~= nil then
			error("metatable", 2)
		end

		if rawlen(v1) ~= rawlen(p1) then
			error("LengthMismatch", 2)
		end

		local t = {}

		for k, v in pairs(p1) do
			if not v1[k] then
				error(("UnknownKey $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
			end
		end

		for k, v in pairs(v1) do
			local v2
			local ok, result = pcall(v, p1[k])

			if not ok then
				local v4 = tostring(result)
				local v5, v6 = string.match(v4, "^(.*:%d+): (.+)$")

				if v5 and v6 then
					v4 = v6
				end

				local v7, v8 = string.match(v4, "^(.+) $(%[.+)$")
				local v10 = error

				if type(k) == "string" then
					local v122, _ = string.format("%q", k):gsub("\n", "n")

					v2 = v122
				else
					v2 = if typeof(k) == "Instance" then k:GetFullName() else tostring(k)
				end

				v10(("%* $%*"):format(if v7 then if v8 then v7 else v4 else v4, (("[%*]%*"):format(v2, v8 or ""))), 2)
			end

			t[k] = result
		end

		return t
	end
end
function t.IsASCII(p1) --[[ IsASCII | Line: 508 ]]
	local v1

	if type(p1) == "string" then
		for i = 1, string.len(p1) do
			local v2 = string.byte(p1, i)

			if v2 < 32 or v2 > 126 then
				return false
			end
		end

		v1 = true
	else
		v1 = false
	end

	return v1
end
function t.IsFinite(p1) --[[ IsFinite | Line: 511 ]]
	return if type(p1) == "number" and (p1 == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false
end
function t.IsInteger(p1) --[[ IsInteger | Line: 514 ]]
	return if type(p1) == "number" and (math.floor(p1) == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false
end
function t.IsCFrameFinite(p1) --[[ IsCFrameFinite | Line: 517 ]]
	local v1

	if typeof(p1) == "CFrame" then
		local v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 = p1:GetComponents()
		local v14 = v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12 + v13

		v1 = if v14 == v14 and v14 ~= (1 / 0) then v14 ~= (-1 / 0) else false
	else
		v1 = false
	end

	return v1
end
function t.IsVector2Finite(p1) --[[ IsVector2Finite | Line: 520 ]]
	local v1

	if typeof(p1) == "Vector2" then
		local v2 = p1.X + p1.Y

		v1 = if v2 == v2 and v2 ~= (1 / 0) then v2 ~= (-1 / 0) else false
	else
		v1 = false
	end

	return v1
end
function t.Optional(p1) --[[ Optional | Line: 524 ]]
	if type(p1) == "function" then
		return function(p13) --[[ Line: 526 | Upvalues: p1 (copy) ]]
			if p13 == nil then
				return nil
			end

			local ok, result = pcall(p1, p13)

			if not ok then
				local v1 = error
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				v1(v2, 2)
			end

			return result
		end
	end

	error("function", 2)
end
function t.Default(p1, p2) --[[ Default | Line: 538 ]]
	if type(p1) == "function" then
		local v1

		v1 = p1(p2)

		return function(p13) --[[ Line: 544 | Upvalues: v1 (copy), p1 (copy) ]]
			if p13 == nil then
				return v1
			end

			local ok, result = pcall(p1, p13)

			if not ok then
				local v12 = error
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				v12(v2, 2)
			end

			return result
		end
	end

	error("function", 2)
end
function t.AnyOf(...) --[[ AnyOf | Line: 556 ]]
	local v1 = table.pack(...)

	for i = 1, v1.n do
		assert(type(v1[i]) == "function", "function")
	end

	assert(v1.n > 0)

	return function(p1) --[[ Line: 562 | Upvalues: v1 (copy) ]]
		for i = 1, v1.n do
			local ok, result = pcall(v1[i], p1)

			if ok then
				return result
			end
		end

		error("AnyOf", 2)
	end
end
function t.AllOf(...) --[[ AllOf | Line: 573 ]]
	local v1 = table.pack(...)

	for i = 1, v1.n do
		assert(type(v1[i]) == "function", "function")
	end

	assert(v1.n > 0)

	return function(p1) --[[ Line: 579 | Upvalues: v1 (copy) ]]
		for i = 1, v1.n do
			local ok, result = pcall(v1[i], p1)

			if not ok then
				local v12 = error
				local v2 = tostring(result)
				local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")

				if v3 and v4 then
					v2 = v4
				end

				v12(v2, 2)
			end
		end

		return p1
	end
end
function t.AnyTable(p1) --[[ AnyTable | Line: 591 ]]
	if type(p1) == "table" then
		return p1
	end

	error("table", 2)
end
function t.Number(p1) --[[ Number | Line: 597 ]]
	if type(p1) == "number" then
		return p1
	end

	error("number", 2)
end
function t.Boolean(p1) --[[ Boolean | Line: 603 ]]
	if type(p1) == "boolean" then
		return p1
	end

	error("boolean", 2)
end
function t.Buffer(p1) --[[ Buffer | Line: 609 ]]
	if type(p1) == "buffer" then
		return p1
	end

	error("buffer", 2)
end
function t.Function(p1) --[[ Function | Line: 615 ]]
	if type(p1) == "function" then
		return p1
	end

	error("function", 2)
end
function t.Thread(p1) --[[ Thread | Line: 621 ]]
	if type(p1) == "thread" then
		return p1
	end

	error("thread", 2)
end
function t.String(p1) --[[ String | Line: 628 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	if utf8.len(p1) then
		return p1
	end

	error("UTF8", 2)
end
function t.RawString(p1) --[[ RawString | Line: 638 ]]
	if type(p1) == "string" then
		return p1
	end

	error("string", 2)
end
function t.Any(p1) --[[ Any | Line: 645 ]]
	return p1
end
function t.Equals(p1) --[[ Equals | Line: 649 ]]
	return function(p12) --[[ Line: 650 | Upvalues: p1 (copy) ]]
		local v1 = p1

		if rawequal(p12, v1) or type(p12) == "number" and (type(v1) == "number" and (p12 ~= p12 and v1 ~= v1)) then
			return p12
		end

		error("Equals", 2)
	end
end
function t.Set(p1) --[[ Set | Line: 656 | Upvalues: t (copy) ]]
	t.Array(t.Any)

	local t2 = {}

	for i, v in ipairs(p1) do
		if v ~= v then
			error("InvalidKeyNaN", 2)
		end

		t2[v] = true

		if not t2[v] then
			error("InvalidKey", 2)
		end
	end

	return function(p1) --[[ Line: 668 | Upvalues: t2 (copy) ]]
		if t2[p1] then
			return p1
		end

		error("Set", 2)
	end
end
function t.Pattern(p1) --[[ Pattern | Line: 674 | Upvalues: t (copy) ]]
	t.String(p1)

	return function(p12) --[[ Line: 676 | Upvalues: p1 (copy) ]]
		if type(p12) ~= "string" then
			error("string", 2)
		end

		if not utf8.len(p12) then
			error("UTF8", 2)
		end

		if string.find(p12, p1) then
			return p12
		end

		error("Pattern", 2)
	end
end
function t.NoMetatable(p1) --[[ NoMetatable | Line: 684 ]]
	if type(p1) ~= "table" then
		error("table", 2)
	end

	if getmetatable(p1) == nil then
		return p1
	end

	error("metatable", 2)
end
function t.Finite(p1) --[[ Finite | Line: 691 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if if p1 == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false then
		return p1
	end

	error("Finite", 2)
end
function t.FinitePositive(p1) --[[ FinitePositive | Line: 698 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if not (if p1 == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false) then
		error("Finite", 2)
	end

	if p1 > 0 then
		return p1
	end

	error("Positive", 2)
end
function t.FiniteNonNegative(p1) --[[ FiniteNonNegative | Line: 706 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if not (if p1 == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false) then
		error("Finite", 2)
	end

	if p1 >= 0 then
		return p1
	end

	error("NonNegative", 2)
end
function t.Positive(p1) --[[ Positive | Line: 714 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if p1 > 0 then
		return p1
	end

	error("Positive", 2)
end
function t.NonNegative(p1) --[[ NonNegative | Line: 721 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if p1 >= 0 then
		return p1
	end

	error("NonNegative", 2)
end
function t.Real(p1) --[[ Real | Line: 728 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if p1 == p1 then
		return p1
	end

	error("Real", 2)
end
function t.Range(p1, p2) --[[ Range | Line: 735 | Upvalues: t (copy) ]]
	t.Real(p1)
	t.Real(p2)

	if p1 <= p2 then
		return function(p13) --[[ Line: 739 | Upvalues: p1 (copy), p2 (copy) ]]
			if type(p13) ~= "number" then
				error("number", 2)
			end

			if not (p1 <= p13 and p13 <= p2) then
				error(("Range(%*,%*)"):format(p1, p2), 2)
			end

			return p13
		end
	end

	error("a<=b", 2)
end
function t.Integer(p1) --[[ Integer | Line: 747 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if if math.floor(p1) == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false then
		return p1
	end

	error("Integer", 2)
end
function t.Unsigned32(p1) --[[ Unsigned32 | Line: 754 ]]
	if bit32.bor(p1, 0) == p1 then
		return p1
	end

	error("Unsigned32", 2)
end
function t.IntegerPositive(p1) --[[ IntegerPositive | Line: 761 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if not (if math.floor(p1) == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false) then
		error("Integer", 2)
	end

	if p1 >= 1 then
		return p1
	end

	error("Positive", 2)
end
function t.Index(p1) --[[ Index | Line: 769 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if not (if math.floor(p1) == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false) then
		error("Integer", 2)
	end

	if p1 >= 1 then
		return p1
	end

	error("Positive", 2)
end
function t.IntegerNonNegative(p1) --[[ IntegerNonNegative | Line: 777 ]]
	if type(p1) ~= "number" then
		error("number", 2)
	end

	if not (if math.floor(p1) == p1 and p1 ~= (1 / 0) then if p1 == (-1 / 0) then false else true else false) then
		error("Integer", 2)
	end

	if p1 >= 0 then
		return p1
	end

	error("NonNegative", 2)
end
function t.IntegerRange(p1, p2) --[[ IntegerRange | Line: 785 | Upvalues: t (copy) ]]
	t.Integer(p1)
	t.Integer(p2)

	if p1 <= p2 then
		return function(p13) --[[ Line: 789 | Upvalues: p1 (copy), p2 (copy) ]]
			if type(p13) ~= "number" then
				error("number", 2)
			end

			if not (if math.floor(p13) == p13 and p13 ~= (1 / 0) then if p13 == (-1 / 0) then false else true else false) then
				error("Integer", 2)
			end

			if not (p1 <= p13 and p13 <= p2) then
				error(("Range(%*,%*)"):format(p1, p2), 2)
			end

			return p13
		end
	end

	error("a<=b", 2)
end
function t.UInt32() --[[ UInt32 | Line: 797 ]]
	return function(p1) --[[ Line: 798 ]]
		if type(p1) ~= "number" then
			error("number", 2)
		end

		if bit32.bor(p1, 0) == p1 then
			return p1
		end

		error("UInt32", 2)
	end
end
function t.StringRange(p1, p2) --[[ StringRange | Line: 806 | Upvalues: t (copy) ]]
	t.Integer(p1)
	t.Integer(p2)

	if p1 <= p2 then
		return function(p13) --[[ Line: 810 | Upvalues: p1 (copy), p2 (copy) ]]
			if type(p13) ~= "string" then
				error("string", 2)
			end

			local v1 = utf8.len(p13)

			if not v1 then
				error("UTF8", 2)
			end

			if not (p1 <= v1 and v1 <= p2) then
				error(("StringRange(%*,%*)"):format(p1, p2), 2)
			end

			return p13
		end
	end

	error("a<=b", 2)
end
function t.ASCII(p1) --[[ ASCII | Line: 823 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	for i = 1, string.len(p1) do
		local v1 = string.byte(p1, i)

		if v1 < 32 or v1 > 126 then
			error("ASCII", 2)
		end
	end

	return p1
end
function t.ASCIIRange(p1, p2) --[[ ASCIIRange | Line: 835 | Upvalues: t (copy) ]]
	t.Integer(p1)
	t.Integer(p2)

	if p1 <= p2 then
		return function(p13) --[[ Line: 839 | Upvalues: p1 (copy), p2 (copy) ]]
			if type(p13) ~= "string" then
				error("string", 2)
			end

			local v1 = string.len(p13)

			if not (p1 <= v1 and v1 <= p2) then
				error(("ASCIIRange(%*,%*)"):format(p1, p2), 2)
			end

			for i = 1, v1 do
				local v2 = string.byte(p13, i)

				if v2 < 32 or v2 > 126 then
					error("ASCII", 2)
				end
			end

			return p13
		end
	end

	error("a<=b", 2)
end
function t.CFrame(p1) --[[ CFrame | Line: 855 ]]
	if typeof(p1) == "CFrame" then
		return p1
	end

	error("CFrame", 2)
end
function t.CFrameFinite(p1) --[[ CFrameFinite | Line: 861 ]]
	if typeof(p1) ~= "CFrame" then
		error("CFrame", 2)
	end

	local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = p1:GetComponents()
	local v13 = v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12

	if if v13 == v13 and v13 ~= (1 / 0) then v13 ~= (-1 / 0) else false then
		return p1
	end

	error("CFrameFinite", 2)
end
function t.Vector2(p1) --[[ Vector2 | Line: 870 ]]
	if typeof(p1) == "Vector2" then
		return p1
	end

	error("Vector2", 2)
end
function t.Vector2Finite(p1) --[[ Vector2Finite | Line: 876 ]]
	if typeof(p1) ~= "Vector2" then
		error("Vector2", 2)
	end

	local v1 = p1.X + p1.Y

	if if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false then
		return p1
	end

	error("Vector2Finite", 2)
end
function t.Vector2Unit(p1) --[[ Vector2Unit | Line: 885 ]]
	if typeof(p1) ~= "Vector2" then
		error("Vector2", 2)
	end

	local v1 = p1.X + p1.Y

	if not (if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false) then
		error("Vector2Finite", 2)
	end

	if not (math.abs(p1.Magnitude - 1) > 1e-6) then
		return p1
	end

	error("Vector2Unit", 2)
end
function t.Vector3(p1) --[[ Vector3 | Line: 897 ]]
	if typeof(p1) == "Vector3" then
		return p1
	end

	error("Vector3", 2)
end
function t.Vector3Finite(p1) --[[ Vector3Finite | Line: 903 ]]
	if typeof(p1) ~= "Vector3" then
		error("Vector3", 2)
	end

	local v1 = p1.X + p1.Y + p1.Z

	if if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false then
		return p1
	end

	error("Vector3Finite", 2)
end
function t.Vector3Unit(p1) --[[ Vector3Unit | Line: 912 ]]
	if typeof(p1) ~= "Vector3" then
		error("Vector3", 2)
	end

	local v1 = p1.X + p1.Y + p1.Z

	if not (if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false) then
		error("Vector3Finite", 2)
	end

	if not (math.abs(p1.Magnitude - 1) > 1e-6) then
		return p1
	end

	error("Vector3Unit", 2)
end
function t.Vector3Positive(p1) --[[ Vector3Positive | Line: 924 ]]
	if typeof(p1) ~= "Vector3" then
		error("Vector3", 2)
	end

	local v1 = p1.X + p1.Y + p1.Z

	if not (if v1 == v1 and v1 ~= (1 / 0) then v1 ~= (-1 / 0) else false) then
		error("Vector3Finite", 2)
	end

	if p1.X <= 0 or (p1.Y <= 0 or p1.Z <= 0) then
		error("Vector3Positive")
	end

	return p1
end
function t.Vector3int16(p1) --[[ Vector3int16 | Line: 936 ]]
	if typeof(p1) == "Vector3int16" then
		return p1
	end

	error("Vector3int16", 2)
end
function t.Vector2int16(p1) --[[ Vector2int16 | Line: 942 ]]
	if typeof(p1) == "Vector2int16" then
		return p1
	end

	error("Vector2int16", 2)
end
function t.Region3(p1) --[[ Region3 | Line: 948 ]]
	if typeof(p1) == "Region3" then
		return p1
	end

	error("Region3", 2)
end
function t.Region3int16(p1) --[[ Region3int16 | Line: 954 ]]
	if typeof(p1) == "Region3int16" then
		return p1
	end

	error("Region3int16", 2)
end
function t.UDim(p1) --[[ UDim | Line: 960 ]]
	if typeof(p1) == "UDim" then
		return p1
	end

	error("UDim", 2)
end
function t.UDim2(p1) --[[ UDim2 | Line: 966 ]]
	if typeof(p1) == "UDim2" then
		return p1
	end

	error("UDim2", 2)
end
function t.Rect(p1) --[[ Rect | Line: 972 ]]
	if typeof(p1) == "Rect" then
		return p1
	end

	error("Rect", 2)
end
function t.PhysicalProperties(p1) --[[ PhysicalProperties | Line: 978 ]]
	if typeof(p1) == "PhysicalProperties" then
		return p1
	end

	error("PhysicalProperties", 2)
end
function t.Storable(p1, p2) --[[ Storable | Line: 988 | Upvalues: SafeKeyStringRep (copy), t (copy) ]]
	if type(p1) == "boolean" then
		return p1
	end

	if type(p1) == "number" then
		return p1
	end

	if type(p1) == "string" then
		if not utf8.len(p1) then
			error("UTF8", 2)
		end
	else
		if type(p1) == "buffer" then
			return p1
		end

		if type(p1) == "table" then
			if type(p1) ~= "table" then
				error("table", 2)
			end

			if getmetatable(p1) ~= nil then
				error("metatable", 2)
			end

			local v1 = if p2 then p2 else {}

			if v1[p1] then
				error("Loop", 2)
			end

			v1[p1] = true

			local v2 = rawlen(p1)

			if v2 > 0 then
				local count = 0

				for k, v in pairs(p1) do
					count = count + 1

					if k ~= count then
						error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
					end

					if v2 < count then
						error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
					end

					local ok, result = pcall(t.Storable, v, v1)

					if not ok then
						local v3 = tostring(result)
						local v4, v5 = string.match(v3, "^(.*:%d+): (.+)$")

						if v4 and v5 then
							v3 = v5
						end

						local v6, v7 = string.match(v3, "^(.+) $(%[.+)$")

						error(("%* $%*"):format(if v6 then if v7 then v6 else v3 else v3, (("[%*]%*"):format(count, v7 or ""))), 2)
					end
				end

				if v2 ~= count then
					error("LengthMismatch", 2)
				end
			else
				for k, v in pairs(p1) do
					if type(k) ~= "string" then
						error(("KeyString $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
					end

					if not utf8.len(k) then
						error(("KeyUTF8 $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
					end

					local ok, result = pcall(t.Storable, v, v1)

					if not ok then
						local v9 = tostring(result)
						local v10, v11 = string.match(v9, "^(.*:%d+): (.+)$")

						if v10 and v11 then
							v9 = v11
						end

						local v12, v13 = string.match(v9, "^(.+) $(%[.+)$")

						error(("%* $%*"):format(if v12 then if v13 then v12 else v9 else v9, (("[%*]%*"):format(SafeKeyStringRep(k), v13 or ""))), 2)
					end
				end

				return p1
			end
		else
			error("Storable", 2)
		end
	end

	return p1
end

local t2 = {
	boolean = true,
	number = true,
	string = true,
	buffer = true,
	Color3 = true,
	Instance = true,
	NumberRange = true,
	Rect = true,
	Region3 = true,
	Region3int16 = true,
	UDim = true,
	UDim2 = true,
	CFrame = true,
	Vector2 = true,
	Vector2int16 = true,
	Vector3 = true,
	Vector3int16 = true,
	EnumItem = true
}

table.freeze(t2)
function t.Networkable(p1, p2) --[[ Networkable | Line: 1084 | Upvalues: SafeKeyStringRep (copy), t (copy), t2 (copy) ]]
	if type(p1) == "string" then
		if not utf8.len(p1) then
			error("UTF8", 2)
		end
	elseif type(p1) == "table" then
		if type(p1) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p1) ~= nil then
			error("metatable", 2)
		end

		local v1 = if p2 then p2 else {}

		if v1[p1] then
			error("Loop", 2)
		end

		v1[p1] = true

		local v2 = rawlen(p1)

		if v2 > 0 then
			local count = 0

			for k, v in pairs(p1) do
				count = count + 1

				if k ~= count then
					error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
				end

				if v2 < count then
					error(("IndexOverflow $%*"):format((("[%*]"):format(count))), 2)
				end

				local ok, result = pcall(t.Networkable, v, v1)

				if not ok then
					local v3 = tostring(result)
					local v4, v5 = string.match(v3, "^(.*:%d+): (.+)$")

					if v4 and v5 then
						v3 = v5
					end

					local v6, v7 = string.match(v3, "^(.+) $(%[.+)$")

					error(("%* $%*"):format(if v6 then if v7 then v6 else v3 else v3, (("[%*]%*"):format(count, v7 or ""))), 2)
				end
			end

			if v2 ~= count then
				error("LengthMismatch", 2)
			end
		else
			for k, v in pairs(p1) do
				if type(k) ~= "string" then
					error(("KeyString $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
				end

				if not utf8.len(k) then
					error(("KeyUTF8 $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
				end

				local ok, result = pcall(t.Networkable, v, v1)

				if not ok then
					local v9 = tostring(result)
					local v10, v11 = string.match(v9, "^(.*:%d+): (.+)$")

					if v10 and v11 then
						v9 = v11
					end

					local v12, v13 = string.match(v9, "^(.+) $(%[.+)$")

					error(("%* $%*"):format(if v12 then if v13 then v12 else v9 else v9, (("[%*]%*"):format(SafeKeyStringRep(k), v13 or ""))), 2)
				end
			end

			return p1
		end
	elseif not t2[typeof(p1)] then
		error("Networkable", 2)
	end

	return p1
end
function t.Enum(p1) --[[ Enum | Line: 1150 ]]
	if typeof(p1) == "Enum" then
		return function(p13) --[[ Line: 1152 | Upvalues: p1 (copy) ]]
			if typeof(p13) ~= "EnumItem" then
				error("EnumItem", 2)
			end

			if p13.EnumType == p1 then
				return p13
			end

			error(tostring(p1), 2)
		end
	end

	error("Enum", 2)
end
function t.EnumValue(p1) --[[ EnumValue | Line: 1159 ]]
	if typeof(p1) ~= "Enum" then
		error("Enum", 2)
	end

	local t = {}

	for i, v in ipairs(p1:GetEnumItems()) do
		t[v.Value] = v
	end

	return function(p1) --[[ Line: 1165 | Upvalues: t (copy) ]]
		if typeof(p1) ~= "number" then
			error("number", 2)
		end

		if t[p1] then
			return p1
		end

		error("EnumValue", 2)
	end
end
function t.Player(p1) --[[ Player | Line: 1172 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Player") then
		error("Player", 2)
	end

	return p1
end
function t.BasePart(p1) --[[ BasePart | Line: 1178 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("BasePart") then
		error("BasePart", 2)
	end

	return p1
end
function t.Part(p1) --[[ Part | Line: 1184 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Part") then
		error("Part", 2)
	end

	return p1
end
function t.MeshPart(p1) --[[ MeshPart | Line: 1190 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("MeshPart") then
		error("MeshPart", 2)
	end

	return p1
end
function t.Model(p1) --[[ Model | Line: 1196 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Model") then
		error("Model", 2)
	end

	return p1
end
function t.Animation(p1) --[[ Animation | Line: 1202 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Animation") then
		error("Animation", 2)
	end

	return p1
end
function t.Humanoid(p1) --[[ Humanoid | Line: 1208 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Humanoid") then
		error("Humanoid", 2)
	end

	return p1
end
function t.ParticleEmitter(p1) --[[ ParticleEmitter | Line: 1214 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("ParticleEmitter") then
		error("ParticleEmitter", 2)
	end

	return p1
end
function t.Sound(p1) --[[ Sound | Line: 1220 ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Sound") then
		error("Sound", 2)
	end

	return p1
end
function t.Instance(p1) --[[ Instance | Line: 1226 ]]
	if typeof(p1) == "Instance" then
		return p1
	end

	error("Instance", 2)
end
function t.InstanceOf(p1) --[[ InstanceOf | Line: 1234 | Upvalues: t (copy) ]]
	t.String(p1)

	return function(p12) --[[ Line: 1236 | Upvalues: p1 (copy) ]]
		if typeof(p12) ~= "Instance" then
			error("Instance", 2)
		end

		if p12:IsA(p1) then
			return p12
		end

		error(p1, 2)
	end
end
function t.InstanceClass(p1) --[[ InstanceClass | Line: 1243 | Upvalues: t (copy) ]]
	t.String(p1)

	return function(p12) --[[ Line: 1245 | Upvalues: p1 (copy) ]]
		if typeof(p12) ~= "Instance" then
			error("Instance", 2)
		end

		if p12.ClassName == p1 then
			return p12
		end

		error(p1, 2)
	end
end
function t.HexLower(p1) --[[ HexLower | Line: 1253 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	for i = 1, string.len(p1) do
		local v1 = string.byte(p1, i)

		if not (v1 >= 48 and v1 <= 57 or v1 >= 97 and v1 <= 102) then
			error("HexLower", 2)
		end
	end

	return p1
end
function t.HexUpper(p1) --[[ HexUpper | Line: 1267 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	for i = 1, string.len(p1) do
		local v1 = string.byte(p1, i)

		if not (v1 >= 48 and v1 <= 57 or v1 >= 65 and v1 <= 70) then
			error("HexUpper", 2)
		end
	end

	return p1
end
function t.UUIDStripped(p1) --[[ UUIDStripped | Line: 1281 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	local v1 = string.len(p1)

	if v1 ~= 32 then
		error("Length32", 2)
	end

	for i = 1, v1 do
		local v2 = string.byte(p1, i)

		if not (v2 >= 48 and v2 <= 57 or v2 >= 97 and v2 <= 102) then
			error("HexLower", 2)
		end
	end

	return p1
end
function t.UUID(p1) --[[ UUID | Line: 1295 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	if string.len(p1) ~= 36 then
		error("Length36", 2)
	end

	if p1:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
		return p1
	end

	error("UUID", 2)
end
function t.Base64(p1) --[[ Base64 | Line: 1306 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	if string.len(p1) % 4 ~= 0 then
		error("Base64Length", 2)
	end

	if not string.match(p1, "^[A-Za-z0-9+/]*=?=?$") or string.match(p1, "[^=]=+[^=]") then
		error("Base64", 2)
	end

	return p1
end
function t.ToNumber(p1) --[[ ToNumber | Line: 1317 ]]
	return function(p12) --[[ Line: 1320 | Upvalues: p1 (copy) ]]
		local v1 = tonumber(p12)

		if not v1 then
			error("tonumber", 2)
		end

		local ok, result = pcall(p1, v1)

		if not ok then
			local v2 = error
			local v3 = tostring(result)
			local v4, v5 = string.match(v3, "^(.*:%d+): (.+)$")

			if v4 and v5 then
				v3 = v5
			end

			v2(v3, 2)
		end

		return result
	end
end
function t.IsoDate(p1) --[[ IsoDate | Line: 1333 ]]
	if DateTime.fromIsoDate(p1) then
		return p1
	end

	error("IsoDate", 2)
end

return table.freeze(t)