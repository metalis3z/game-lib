--!strict


-- CONFIG
local ALWAYS_SKIP: {[string]: true} = {
	key = true,
	rank = true,
	internal = true,
	useDefaults = true,
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local DEFAULT_ROLE = require(modules.References.defaultRole)
local SettingsRole = require(frontend.Config.SettingsRole)
local RoleLockRules = require(frontend.Config.RoleLockRules)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)
local headingByTitle: {[string]: string}? = nil
local orderedHeadings: {string}? = nil


-- LOCAL FUNCTIONS
-- Titles not listed in SettingsRole fall into a catch-all "Other" bucket
local function buildHeadingMaps()
	if headingByTitle and orderedHeadings then return end
	local byTitle: {[string]: string} = {}
	local order: {string} = {}
	local seenHeadings: {[string]: true} = {}
	for _, category in SettingsRole :: any do
		local heading = category.heading
		if typeof(heading) ~= "string" then continue end
		if not seenHeadings[heading] then
			table.insert(order, heading)
			seenHeadings[heading] = true
		end
		for _, obj in category.objects do
			if typeof(obj.title) == "string" then
				byTitle[obj.title] = heading
			end
		end
	end
	table.insert(order, "Other")
	headingByTitle = byTitle
	orderedHeadings = order
end

local function valueToLuau(value: any, indent: string): string
	local valueType = typeof(value)
	if valueType == "boolean" then
		return tostring(value)
	elseif valueType == "number" then
		return tostring(value)
	elseif valueType == "string" then
		return string.format("%q", value)
	elseif valueType == "Color3" then
		local color = value :: Color3
		local red = math.round(color.R * 255)
		local green = math.round(color.G * 255)
		local blue = math.round(color.B * 255)
		return `Color3.fromRGB({red}, {green}, {blue})`
	elseif valueType == "table" then
		local tbl = value :: {any}
		if #tbl > 0 then
			local allPrimitive = true
			for _, element in tbl do
				local elementType = typeof(element)
				if elementType ~= "number" and elementType ~= "string" and elementType ~= "boolean" then
					allPrimitive = false
					break
				end
			end
			if allPrimitive then
				local parts: {string} = {}
				for _, element in tbl do
					table.insert(parts, valueToLuau(element, indent))
				end
				return "{" .. table.concat(parts, ", ") .. "}"
			end
			local parts: {string} = {}
			local innerIndent = indent .. "\t"
			for _, element in tbl do
				table.insert(parts, innerIndent .. valueToLuau(element, innerIndent) .. ",")
			end
			return "{\n" .. table.concat(parts, "\n") .. "\n" .. indent .. "}"
		end
		-- Keys emit "type" first, then the id fields, then the rest alphabetically
		local dict = value :: {[string]: any}
		local keys: {string} = {}
		for key in dict do
			if typeof(key) == "string" then
				table.insert(keys, key)
			end
		end
		if #keys == 0 then return "{}" end
		local PRIORITY: {[string]: number} = {
			type = 1, groupId = 2, userId = 2, id = 2, preset = 3,
		}
		table.sort(keys, function(keyA, keyB)
			local priorityA = PRIORITY[keyA] or 100
			local priorityB = PRIORITY[keyB] or 100
			if priorityA ~= priorityB then return priorityA < priorityB end
			return keyA < keyB
		end)
		local parts: {string} = {}
		local innerIndent = indent .. "\t"
		for _, key in keys do
			table.insert(parts, `{innerIndent}{key} = {valueToLuau(dict[key], innerIndent)},`)
		end
		return "{\n" .. table.concat(parts, "\n") .. "\n" .. indent .. "}"
	end
	return tostring(value)
end


-- PUBLIC
-- The returned text is ready to paste into a new file under src/Loader/Config/Roles/
return function(roleData: {[string]: any}): string
	buildHeadingMaps()
	local heading2Title = headingByTitle :: {[string]: string}
	local order = orderedHeadings :: {string}

	local bucketsByHeading: {[string]: {{title: string, value: any}}} = {}
	for title, value in roleData do
		if ALWAYS_SKIP[title] then continue end
		local default = (DEFAULT_ROLE :: any)[title]
		if default == nil and title ~= "name" then continue end
		if areValuesEqual(value, default) then continue end
		if RoleLockRules.isSuppressed(title, roleData) then continue end
		local heading = heading2Title[title] or "Other"
		local bucket = bucketsByHeading[heading]
		if not bucket then
			bucket = {}
			bucketsByHeading[heading] = bucket
		end
		table.insert(bucket, { title = title, value = value })
	end

	local lines: {string} = {}
	table.insert(lines, "return {")
	table.insert(lines, "")
	local indent = "\t"
	local isFirstHeading = true
	for _, heading in order do
		local bucket = bucketsByHeading[heading]
		if not bucket or #bucket == 0 then continue end
		if not isFirstHeading then
			table.insert(lines, "")
		end
		isFirstHeading = false
		table.insert(lines, `{indent}-- {heading}`)
		for _, entry in bucket do
			table.insert(lines, `{indent}{entry.title} = {valueToLuau(entry.value, indent)},`)
		end
	end
	table.insert(lines, "")
	table.insert(lines, "}")
	return table.concat(lines, "\n")
end
