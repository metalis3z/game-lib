--!strict

--[[

	A shared validator for ChangeYouSetting, ChangeGameSetting and ChangeRoleSetting:
	
	1. Find the matching row in their settings module (different lookup styles)
	2. Run that row's verifier with a `context` table on the new value
	3. Get back (true, coercedValue) or (false, errorString) and act on it

]]


-- LOCAL
local validateSettingChange = {}


-- CONFIG
local INERT_INPUT_TYPES: {[string]: true} = {
	ActionButton = true,
}


-- LOCAL FUNCTIONS
local function pathsMatch(pathA: {string}, pathB: {string}): boolean
	if #pathA ~= #pathB then return false end
	for segmentIndex, segment in pathA do
		if pathB[segmentIndex] ~= segment then return false end
	end
	return true
end


-- FINDERS
function validateSettingChange.findRowByPath(settingsModule: {any}, fullPath: {string}): any?
	if typeof(settingsModule) ~= "table" or typeof(fullPath) ~= "table" then return nil end
	for _, category in settingsModule do
		if typeof(category) ~= "table" then continue end
		local objects = category.objects
		if typeof(objects) ~= "table" then continue end
		for _, row in objects do
			if typeof(row) ~= "table" then continue end
			if typeof(row.settingPath) == "table" and pathsMatch(row.settingPath :: {string}, fullPath) then
				return row
			end
		end
	end
	return nil
end

function validateSettingChange.findRowByHeadingTitle(settingsModule: {any}, heading: string, title: string): any?
	if typeof(settingsModule) ~= "table" then return nil end
	for _, category in settingsModule do
		if typeof(category) ~= "table" or category.heading ~= heading then continue end
		local objects = category.objects
		if typeof(objects) ~= "table" then continue end
		for _, row in objects do
			if typeof(row) == "table" and row.title == title then
				return row
			end
		end
	end
	return nil
end

function validateSettingChange.findRowByFieldName(settingsModule: {any}, fieldName: string): any?
	if typeof(settingsModule) ~= "table" then return nil end
	for _, category in settingsModule do
		if typeof(category) ~= "table" then continue end
		local objects = category.objects
		if typeof(objects) ~= "table" then continue end
		for _, row in objects do
			if typeof(row) == "table" and row.title == fieldName then
				return row
			end
		end
	end
	return nil
end


-- RUN
function validateSettingChange.run(row: any?, newValue: any, context: any?): (boolean, any)
	if row == nil then
		return false, "Unknown setting"
	end
	if typeof(row) ~= "table" then
		return false, "Malformed setting row"
	end
	if row.immutable == true then
		return false, `Field '{tostring(row.title)}' is immutable`
	end
	if INERT_INPUT_TYPES[tostring(row.inputType)] then
		return false, `Field '{tostring(row.title)}' is not settable`
	end
	local verifier = row.verifier
	if typeof(verifier) ~= "function" then
		return false, `No verifier defined for '{tostring(row.title)}'`
	end
	local ok, validOrErr, cleanedOrErr = pcall(verifier, row.inputObject or row, newValue, context)
	if not ok then
		return false, "Internal error during verification"
	end
	if validOrErr == true then
		if cleanedOrErr == nil then
			return true, newValue
		end
		return true, cleanedOrErr
	end
	if typeof(cleanedOrErr) == "string" then
		return false, cleanedOrErr
	end
	return false, `Invalid value for '{tostring(row.title)}'`
end


return validateSettingChange
