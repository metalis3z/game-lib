
local t = {}

function t.type(typeName)
	return function(value)
		local valueType = type(value)
		if valueType == typeName then
			return true
		end
		return false, string.format("%s expected, got %s", typeName, valueType)
	end
end

function t.typeof(typeName)
	return function(value)
		local valueType = typeof(value)
		if valueType == typeName then
			return true
		end
		return false, string.format("%s expected, got %s", typeName, valueType)
	end
end

function t.any(value)
	if value == nil then
		return false, "any expected, got nil"
	end
	return true
end

t.boolean = t.typeof("boolean")
t.buffer = t.typeof("buffer")
t.thread = t.typeof("thread")
t.callback = t.typeof("function")
t["function"] = t.callback
t.none = t.typeof("nil")
t["nil"] = t.none
t.string = t.typeof("string")
t.table = t.typeof("table")
t.userdata = t.type("userdata")
t.vector = t.type("vector")

local function number(value)
	local valueType = typeof(value)
	if valueType == "number" then
		if value == value then
			return true
		end
		return false, "unexpected NaN value"
	end
	return false, string.format("number expected, got %s", valueType)
end
t.number = number

local function nan(value)
	local valueType = typeof(value)
	if valueType == "number" then
		if value == value then
			return false, "unexpected non-NaN value"
		end
		return true
	end
	return false, string.format("number expected, got %s", valueType)
end
t.nan = nan

for _, name in ipairs({
	"Axes", "BrickColor", "CatalogSearchParams", "CFrame", "Color3",
	"ColorSequence", "ColorSequenceKeypoint", "DateTime",
	"DockWidgetPluginGuiInfo", "Enum", "EnumItem", "Enums", "Faces",
	"FloatCurveKey", "Font", "Instance", "NumberRange", "NumberSequence",
	"NumberSequenceKeypoint", "OverlapParams", "PathWaypoint",
	"PhysicalProperties", "Random", "Ray", "RaycastParams", "RaycastResult",
	"RBXScriptConnection", "RBXScriptSignal", "Rect", "Region3",
	"Region3int16", "TweenInfo", "UDim", "UDim2", "Vector2", "Vector2int16",
	"Vector3", "Vector3int16",
	}) do
	t[name] = t.typeof(name)
end

function t.literal(...)
	local argCount = select("#", ...)
	if argCount == 1 then
		local expected = ...
		return function(value)
			if value == expected then
				return true
			end
			return false, string.format("expected %s, got %s", tostring(expected), tostring(value))
		end
	end

	local checks = {}
	for i = 1, argCount do
		checks[i] = t.literal((select(i, ...)))
	end
	return t.union(table.unpack(checks, 1, argCount))
end
t.exactly = t.literal

function t.keyOf(keyTable)
	local keys, length = {}, 0
	for key in pairs(keyTable) do
		length += 1
		keys[length] = key
	end
	return t.literal(table.unpack(keys, 1, length))
end

function t.valueOf(valueTable)
	local values, length = {}, 0
	for _, value in pairs(valueTable) do
		length += 1
		values[length] = value
	end
	return t.literal(table.unpack(values, 1, length))
end

function t.integer(value)
	local ok, err = t.number(value)
	if not ok then
		return false, err or ""
	end
	if value % 1 == 0 then
		return true
	end
	return false, string.format("integer expected, got %s", value)
end

local function numberBound(limit, compare, message)
	return function(value)
		local ok, err = t.number(value)
		if not ok then
			return false, err or ""
		end
		if compare(limit, value) then
			return true
		end
		return false, string.format(message, limit, value)
	end
end

function t.numberMin(min)
	return numberBound(min, function(a, b) return a <= b end, "number >= %s expected, got %s")
end

function t.numberMax(max)
	return numberBound(max, function(a, b) return b <= a end, "number <= %s expected, got %s")
end

function t.numberMinExclusive(min)
	return numberBound(min, function(a, b) return a < b end, "number > %s expected, got %s")
end

function t.numberMaxExclusive(max)
	return numberBound(max, function(a, b) return b < a end, "number < %s expected, got %s")
end

t.numberPositive = t.numberMinExclusive(0)
t.numberNegative = t.numberMaxExclusive(0)

function t.numberConstrained(min, max)
	assert(t.number(min))
	assert(t.number(max))
	local minCheck = t.numberMin(min)
	local maxCheck = t.numberMax(max)

	return function(value)
		local ok, err = minCheck(value)
		if not ok then
			return false, err or ""
		end
		ok, err = maxCheck(value)
		if not ok then
			return false, err or ""
		end
		return true
	end
end

function t.numberConstrainedExclusive(min, max)
	assert(t.number(min))
	assert(t.number(max))
	local minCheck = t.numberMinExclusive(min)
	local maxCheck = t.numberMaxExclusive(max)

	return function(value)
		local ok, err = minCheck(value)
		if not ok then
			return false, err or ""
		end
		ok, err = maxCheck(value)
		if not ok then
			return false, err or ""
		end
		return true
	end
end

function t.match(pattern)
	assert(t.string(pattern))
	return function(value)
		local ok, err = t.string(value)
		if not ok then
			return false, err
		end
		if string.match(value, pattern) == nil then
			return false, string.format("%q failed to match pattern %q", value, pattern)
		end
		return true
	end
end

function t.optional(check)
	assert(t.callback(check))
	return function(value)
		if value == nil then
			return true
		end
		local ok, err = check(value)
		if ok then
			return true
		end
		return false, string.format("(optional) %s", err or "")
	end
end

function t.except(check)
	assert(t.callback(check))
	return function(value)
		if check(value) then
			return false, "(expect) checker to fail, but it succeeded."
		end
		return true
	end
end

local function tuple(...)
	local checks = { ... }
	return function(...)
		local values = { ... }
		for i, check in ipairs(checks) do
			local ok, err = check(values[i])
			if ok == false then
				return false, string.format("Bad tuple index #%s:\n\t%s", i, err or "")
			end
		end
		return true
	end
end
t.tuple = tuple

function t.keys(keyCheck)
	assert(t.callback(keyCheck))
	return function(value)
		local ok, err = t.table(value)
		if ok == false then
			return false, err or ""
		end
		for key in pairs(value) do
			local keyOk, keyErr = keyCheck(key)
			if keyOk == false then
				return false, string.format("bad key %s:\n\t%s", tostring(key), keyErr or "")
			end
		end
		return true
	end
end

function t.values(valueCheck)
	assert(t.callback(valueCheck))
	return function(value)
		local ok, err = t.table(value)
		if ok == false then
			return false, err or ""
		end
		for key, val in pairs(value) do
			local valOk, valErr = valueCheck(val)
			if valOk == false then
				return false, string.format("bad value for key %s:\n\t%s", tostring(key), valErr or "")
			end
		end
		return true
	end
end

function t.map(keyCheck, valueCheck)
	assert(t.callback(keyCheck))
	assert(t.callback(valueCheck))
	local keysCheck = t.keys(keyCheck)
	local valuesCheck = t.values(valueCheck)

	return function(value)
		local ok, err = keysCheck(value)
		if not ok then
			return false, err or ""
		end
		ok, err = valuesCheck(value)
		if not ok then
			return false, err or ""
		end
		return true
	end
end

function t.set(valueCheck)
	return t.map(valueCheck, t.literal(true))
end

local arrayKeysCheck = t.keys(t.integer)

function t.array(check)
	assert(t.callback(check))
	local valuesCheck = t.values(check)

	return function(value)
		local ok, err = arrayKeysCheck(value)
		if ok == false then
			return false, string.format("[array] %s", err or "")
		end

		local arraySize = 0
		for _ in ipairs(value) do
			arraySize += 1
		end

		for key in pairs(value) do
			if key < 1 or key > arraySize then
				return false, string.format("[array] key %s must be sequential", tostring(key))
			end
		end

		ok, err = valuesCheck(value)
		if not ok then
			return false, string.format("[array] %s", err or "")
		end
		return true
	end
end

function t.strictArray(...)
	local valueChecks = { ... }
	assert(t.array(t.callback)(valueChecks))

	return function(value)
		local ok, err = arrayKeysCheck(value)
		if ok == false then
			return false, string.format("[strictArray] %s", err or "")
		end

		if #valueChecks < #value then
			return false, string.format("[strictArray] Array size exceeds limit of %d", #valueChecks)
		end

		for index, check in pairs(valueChecks) do
			local valOk, valErr = check(value[index])
			if not valOk then
				return false, string.format("[strictArray] Array index #%d - %s", index, valErr or "")
			end
		end
		return true
	end
end

local callbackArray = t.array(t.callback)

function t.union(...)
	local checks = { ... }
	assert(callbackArray(checks))

	return function(value)
		for _, check in ipairs(checks) do
			if check(value) then
				return true
			end
		end
		return false, "bad type for union"
	end
end
t.some = t.union

function t.intersection(...)
	local checks = { ... }
	assert(callbackArray(checks))

	return function(value)
		for _, check in ipairs(checks) do
			local ok, err = check(value)
			if not ok then
				return false, err or ""
			end
		end
		return true
	end
end
t.every = t.intersection

local interfaceTableCheck = t.map(t.any, t.callback)

function t.interface(checkTable)
	assert(interfaceTableCheck(checkTable))

	return function(value)
		local ok, err = t.table(value)
		if ok == false then
			return false, err or ""
		end
		for key, check in pairs(checkTable) do
			local fieldOk, fieldErr = check(value[key])
			if fieldOk == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(key), fieldErr or "")
			end
		end
		return true
	end
end

function t.strictInterface(checkTable)
	assert(interfaceTableCheck(checkTable))

	return function(value)
		local ok, err = t.table(value)
		if ok == false then
			return false, err or ""
		end
		for key, check in pairs(checkTable) do
			local fieldOk, fieldErr = check(value[key])
			if fieldOk == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(key), fieldErr or "")
			end
		end
		for key in pairs(value) do
			if not checkTable[key] then
				return false, string.format("[interface] unexpected field %q", tostring(key))
			end
		end
		return true
	end
end

function t.instanceOf(className, childTable)
	assert(t.string(className))

	local childrenCheck
	if childTable ~= nil then
		childrenCheck = t.children(childTable)
	end

	return function(value)
		local ok, err = t.Instance(value)
		if not ok then
			return false, err or ""
		end

		if value.ClassName ~= className then
			return false, string.format("%s expected, got %s", className, value.ClassName)
		end

		if childrenCheck then
			local childOk, childErr = childrenCheck(value)
			if not childOk then
				return false, childErr
			end
		end
		return true
	end
end
t.instance = t.instanceOf

function t.instanceIsA(className, childTable)
	assert(t.string(className))

	local childrenCheck
	if childTable ~= nil then
		childrenCheck = t.children(childTable)
	end

	return function(value)
		local ok, err = t.Instance(value)
		if not ok then
			return false, err or ""
		end

		if not value:IsA(className) then
			return false, string.format("%s expected, got %s", className, value.ClassName)
		end

		if childrenCheck then
			local childOk, childErr = childrenCheck(value)
			if not childOk then
				return false, childErr
			end
		end
		return true
	end
end

function t.enum(enumType)
	assert(t.Enum(enumType))

	return function(value)
		local ok, err = t.EnumItem(value)
		if not ok then
			return false, err
		end
		if value.EnumType == enumType then
			return true
		end
		return false, string.format(
			"enum of %s expected, got enum of %s",
			tostring(enumType),
			tostring(value.EnumType)
		)
	end
end

local wrapArgsCheck = t.tuple(t.callback, t.callback)

function t.wrap(callback, checkArgs)
	assert(wrapArgsCheck(callback, checkArgs))
	return function(...)
		assert(checkArgs(...))
		return callback(...)
	end
end

function t.strict(check)
	return function(...)
		local ok, err = check(...)
		if not ok then
			warn("STRICT-FAIL:", tostring(err), "\n", debug.traceback("STRICT-FAIL-CALLER", 2))
		end
		assert(ok, err)
	end
end

local childrenTableCheck = t.map(t.string, t.callback)

function t.children(checkTable)
	assert(childrenTableCheck(checkTable))

	return function(value)
		local ok, err = t.Instance(value)
		if not ok then
			return false, err or ""
		end

		local childrenByName = {}
		for _, child in ipairs(value:GetChildren()) do
			local name = child.Name
			if checkTable[name] then
				if childrenByName[name] then
					return false, string.format("Cannot process multiple children with the same name %q", name)
				end
				childrenByName[name] = child
			end
		end

		for name, check in pairs(checkTable) do
			local childOk, childErr = check(childrenByName[name])
			if not childOk then
				return false, string.format("[%s.%s] %s", value:GetFullName(), name, childErr or "")
			end
		end
		return true
	end
end

return t