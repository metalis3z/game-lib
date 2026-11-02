--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local isStringSafe = require(script.Parent.isStringSafe)
local isNumberSafe = require(script.Parent.isNumberSafe)
local isWithinMaxSize = require(script.Parent.isWithinMaxSize)
local matchesShape = require(script.Parent.matchesShape)
local filterTextAsync = require(script.Parent.filterTextAsync)


-- LOCAL FUNCTIONS
local function unwrapSingleArray(value: any): any
	if typeof(value) == "table" and #(value :: {any}) == 1 then
		return (value :: {any})[1]
	end
	return value
end


-- FUNCTIONS
local settingVerifiers = {}


-- BOOLEAN
function settingVerifiers.boolean()
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if typeof(value) ~= "boolean" then
			return false, "Expected a boolean"
		end
		return true, value
	end
end


-- COLOR3
function settingVerifiers.color3()
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if typeof(value) ~= "Color3" then
			return false, "Expected a Color3"
		end
		return true, value
	end
end


function settingVerifiers.integerRange(min: number, max: number)
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if not isNumberSafe(value) then
			return false, "Expected a number"
		end
		local rounded = math.round(value)
		if rounded ~= value then
			-- Accept whole-number floats but reject obvious decimals
			rounded = math.floor(value + 0.5)
		end
		local clamped = math.clamp(rounded, min, max)
		return true, clamped
	end
end


function settingVerifiers.numberRange(min: number, max: number)
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if not isNumberSafe(value) then
			return false, "Expected a number"
		end
		return true, math.clamp(value, min, max)
	end
end


function settingVerifiers.oneOfString(allowed: {string})
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		local unwrapped = unwrapSingleArray(value)
		if not isStringSafe(unwrapped) then return false, "Expected a string" end
		for _, allowedValue in allowed do
			if unwrapped == allowedValue then return true, unwrapped end
		end
		return false, "Value not in allowed list"
	end
end


function settingVerifiers.arrayOfOneOfString(allowed: {string}, maxEntries: number, maxBytes: number?)
	local allowedSet: {[string]: true} = {}
	for _, allowedValue in allowed do allowedSet[allowedValue] = true end
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if typeof(value) ~= "table" then return false, "Expected an array" end
		if maxBytes and not isWithinMaxSize(value, maxBytes) then return false, "Array too large" end
		local seen: {[string]: true} = {}
		local cleaned: {string} = {}
		for index = 1, #value do
			local entry = (value :: {any})[index]
			if not isStringSafe(entry) then return false, `Entry {index} is not a safe string` end
			-- We silently drop entries that aren't in the allowlist. This makes
			-- the verifier forward-compatible with renamed/removed allowlist
			-- members (e.g. if "MembersInServer" became "MembersServer")
			if not allowedSet[entry] then continue end
			if not seen[entry] then
				seen[entry] = true
				table.insert(cleaned, entry)
			end
		end
		if #cleaned > maxEntries then
			return false, `Too many entries (max {maxEntries})`
		end
		return true, cleaned
	end
end


function settingVerifiers.safeString(maxBytes: number)
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if not isStringSafe(value) then return false, "Expected a safe string" end
		if not isWithinMaxSize(value, maxBytes) then return false, "String too long" end
		return true, value
	end
end


function settingVerifiers.filteredText(maxBytes: number)
	return function(_inputObject: any, value: any, context: any?): (boolean, any)
		if not isStringSafe(value) then return false, "Expected a safe string" end
		if not isWithinMaxSize(value, maxBytes) then return false, "Too long" end
		if #(value :: string) == 0 then return false, "Cannot be empty" end
		if context and context.callerUserId then
			local ok, filtered = filterTextAsync(value, context.callerUserId)
			if not ok then return false, "Text was rejected by the filter" end
			return true, filtered
		end
		return true, value
	end
end


function settingVerifiers.taggedArray(
	shapesByType: {[string]: any},
	maxEntries: number,
	maxBytes: number,
	dedupKey: (any) -> string?
)
	return function(_inputObject: any, value: any, _context: any?): (boolean, any)
		if typeof(value) ~= "table" then return false, "Expected an array" end
		if not isWithinMaxSize(value, maxBytes) then return false, "Array too large" end
		local cleaned: {any} = {}
		local seen: {[string]: true} = {}
		for index = 1, #value do
			local entry = (value :: {any})[index]
			if typeof(entry) ~= "table" or typeof((entry :: any).type) ~= "string" then
				return false, `Entry {index}: missing or invalid 'type'`
			end
			local shape = shapesByType[(entry :: any).type]
			if not shape then
				return false, `Entry {index}: unknown type '{tostring((entry :: any).type)}'`
			end
			local ok, cleanedEntry = matchesShape(entry, shape)
			if not ok then
				return false, `Entry {index}: {tostring(cleanedEntry)}`
			end
			local key = dedupKey(cleanedEntry)
			if typeof(key) ~= "string" then
				return false, `Entry {index}: could not derive dedup key`
			end
			if not seen[key] then
				seen[key] = true
				table.insert(cleaned, cleanedEntry)
			end
		end
		if #cleaned > maxEntries then
			return false, `Too many entries (max {maxEntries})`
		end
		return true, cleaned
	end
end


return settingVerifiers
