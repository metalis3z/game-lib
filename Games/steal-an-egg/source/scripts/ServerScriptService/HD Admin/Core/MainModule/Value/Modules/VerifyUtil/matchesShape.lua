--!strict

--[[

	Checks a value against a "shape" describing what you expect. Anything
	the shape doesn't mention is rejected, metatables are ignored entirely,
	and you get back (true, cleanedValue) or (false, errorString)

]]



-- CONFIG
local MAX_DEPTH = 8
local DEFAULT_ARRAY_MAX = 1000


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local isStringSafe = require(script.Parent.isStringSafe)
local isNumberSafe = require(script.Parent.isNumberSafe)
local check: (value: any, shape: any, depth: number, visited: {[any]: true}) -> (boolean, any)


-- LOCAL FUNCTIONS
local function rawNext(container: any, key: any)
	return next(container, key)
end

local function eachKey(container: any): () -> any
	local key: any = nil
	return function()
		key = rawNext(container, key)
		return key
	end
end

local function checkAtomString(value: any): (boolean, any)
	if not isStringSafe(value) then
		return false, "expected safe string"
	end
	return true, value
end

local function checkAtomSafeNumber(value: any): (boolean, any)
	if not isNumberSafe(value) then
		return false, "expected safe number"
	end
	return true, value
end

local function checkAtomPositiveInteger(value: any): (boolean, any)
	if not isNumberSafe(value) then
		return false, "expected positive integer"
	end
	if value <= 0 or value ~= math.floor(value) then
		return false, "expected positive integer"
	end
	return true, value
end

local function checkAtomNonNegativeInteger(value: any): (boolean, any)
	if not isNumberSafe(value) then
		return false, "expected non-negative integer"
	end
	if value < 0 or value ~= math.floor(value) then
		return false, "expected non-negative integer"
	end
	return true, value
end

local function checkAtomBoolean(value: any): (boolean, any)
	if typeof(value) ~= "boolean" then
		return false, "expected boolean"
	end
	return true, value
end

local function checkAtomColor3(value: any): (boolean, any)
	if typeof(value) ~= "Color3" then
		return false, "expected Color3"
	end
	return true, value
end

local function checkOneOf(value: any, options: any): (boolean, any)
	if typeof(options) ~= "table" then
		return false, "malformed shape: oneOf needs a list"
	end
	local optionIndex = 0
	while true do
		optionIndex += 1
		local allowed = rawget(options, optionIndex)
		if allowed == nil then break end
		if value == allowed then return true, value end
	end
	return false, "value not in allowed list"
end

local function checkArray(value: any, arrayShape: any, depth: number, visited: {[any]: true}): (boolean, any)
	if typeof(value) ~= "table" then
		return false, "expected an array"
	end
	if visited[value] then
		return false, "cyclic reference"
	end
	visited[value] = true
	local maxEntries = rawget(arrayShape, "max")
	if typeof(maxEntries) ~= "number" then maxEntries = DEFAULT_ARRAY_MAX end
	local innerShape = rawget(arrayShape, "array")
	local keyCount = 0
	for _ in eachKey(value) do
		keyCount += 1
	end
	-- #value is unreliable with __len or nil gaps, so we never use it
	if keyCount > maxEntries then
		return false, `array too long (max {maxEntries})`
	end
	local cleaned: {any} = {}
	for entryIndex = 1, keyCount do
		local entry = rawget(value, entryIndex)
		if entry == nil then
			return false, "array must have contiguous integer keys 1..n"
		end
		local ok, cleanedEntry = check(entry, innerShape, depth + 1, visited)
		if not ok then
			return false, `entry {entryIndex}: {cleanedEntry}`
		end
		table.insert(cleaned, cleanedEntry)
	end
	for key in eachKey(value) do
		if typeof(key) ~= "number" or key ~= math.floor(key) or key < 1 or key > keyCount then
			return false, `array has unexpected key '{tostring(key)}'`
		end
	end
	return true, cleaned
end

local function checkObject(value: any, objectShape: any, depth: number, visited: {[any]: true}): (boolean, any)
	if typeof(value) ~= "table" then
		return false, "expected an object"
	end
	if visited[value] then
		return false, "cyclic reference"
	end
	visited[value] = true
	for key in eachKey(value) do
		if typeof(key) ~= "string" then
			return false, `unexpected non-string key '{tostring(key)}'`
		end
		if rawget(objectShape, key) == nil then
			return false, `unexpected key '{key}'`
		end
	end
	local cleaned: {[string]: any} = {}
	for shapeKey in eachKey(objectShape) do
		if typeof(shapeKey) ~= "string" then
			return false, `malformed shape: non-string key '{tostring(shapeKey)}'`
		end
		local innerShape = rawget(objectShape, shapeKey)
		local isOptional = typeof(innerShape) == "table" and rawget(innerShape, "optional") ~= nil
		local actualInner = if isOptional then rawget(innerShape, "optional") else innerShape
		local fieldValue = rawget(value, shapeKey)
		if fieldValue == nil then
			if isOptional then continue end
			return false, `missing required key '{shapeKey}'`
		end
		local ok, cleanedField = check(fieldValue, actualInner, depth + 1, visited)
		if not ok then
			return false, `field '{shapeKey}': {cleanedField}`
		end
		cleaned[shapeKey] = cleanedField
	end
	return true, cleaned
end


-- CORE HANDLER
local ATOMS: {[string]: (any) -> (boolean, any)} = {
	string = checkAtomString,
	safeNumber = checkAtomSafeNumber,
	positiveInteger = checkAtomPositiveInteger,
	nonNegativeInteger = checkAtomNonNegativeInteger,
	boolean = checkAtomBoolean,
	Color3 = checkAtomColor3,
}

check = function(value: any, shape: any, depth: number, visited: {[any]: true}): (boolean, any)
	if depth > MAX_DEPTH then
		return false, "exceeded max nesting depth"
	end
	if typeof(shape) == "string" then
		local atom = ATOMS[shape]
		if not atom then
			return false, `malformed shape: unknown atom '{shape}'`
		end
		return atom(value)
	end
	if typeof(shape) ~= "table" then
		return false, `malformed shape: expected string or table, got {typeof(shape)}`
	end
	if rawget(shape, "oneOf") ~= nil then
		return checkOneOf(value, rawget(shape, "oneOf"))
	end
	if rawget(shape, "array") ~= nil then
		return checkArray(value, shape, depth, visited)
	end
	if rawget(shape, "shape") ~= nil then
		return checkObject(value, rawget(shape, "shape"), depth, visited)
	end
	return checkObject(value, shape, depth, visited)
end


-- RETURN FUNCTION
-- Returns (true, cleanedValue) or (false, errorString)
return function(value: any, shape: any): (boolean, any)
	local pcallOk, validOrErr, cleanedOrErr = pcall(check, value, shape, 0, {})
	if not pcallOk then
		return false, "internal error during validation"
	end
	return validOrErr, cleanedOrErr
end