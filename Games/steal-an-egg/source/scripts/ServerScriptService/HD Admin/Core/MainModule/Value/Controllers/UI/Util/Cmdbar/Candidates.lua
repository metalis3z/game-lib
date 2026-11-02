--!strict

--[[

	This turns an argument's type into suggestion rows

--]]


-- CONFIG
local PICKER_CACHE_TTL = 5 -- seconds a pickerGetter result stays fresh
local DEFAULT_COLORS: { [string]: Color3 } = {
	Red = Color3.fromRGB(255, 0, 0),
	Orange = Color3.fromRGB(250, 100, 0),
	Yellow = Color3.fromRGB(255, 255, 0),
	Green = Color3.fromRGB(0, 255, 0),
	DarkGreen = Color3.fromRGB(0, 125, 0),
	Blue = Color3.fromRGB(0, 255, 255),
	DarkBlue = Color3.fromRGB(0, 50, 255),
	Purple = Color3.fromRGB(150, 0, 255),
	Pink = Color3.fromRGB(255, 85, 185),
	Black = Color3.fromRGB(0, 0, 0),
	White = Color3.fromRGB(255, 255, 255),
}
local DEFAULT_DURATIONS = {
	{ text = "30s", label = "30 seconds" },
	{ text = "5m", label = "5 minutes" },
	{ text = "1h", label = "1 hour" },
	{ text = "1d", label = "1 day" },
	{ text = "1w", label = "1 week" },
}


-- LOCAL
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Qualifiers = require(modules.Parser.Qualifiers)
local getGameSetting = require(modules.CommandUtil.getGameSetting)
local Candidates = {}
local pickerCache: { [string]: { fetchedAt: number, items: { any } } } = {}
local pickerInFlight: { [string]: boolean } = {}
local playerIdentifier = "@"
local commandColors: { [string]: any }? = nil


-- LOCAL LOADED
task.spawn(function()
	local fetched = getGameSetting("PlayerIdentifier")
	if typeof(fetched) == "string" and #fetched > 0 then
		playerIdentifier = fetched
	end
end)
task.spawn(function()
	local fetched = getGameSetting("CommandColors")
	if typeof(fetched) == "table" then
		commandColors = fetched :: any
	end
end)


-- TYPES
type Candidate = {
	keys: { string },
	text: string,
	display: string,
	insert: string,
	advance: boolean,
	caretBack: number,
	kind: string,
	description: string?,
	image: string?,
	swatch: Color3?,
	isDefault: boolean?,
}


-- LOCAL FUNCTIONS
local function makeCandidate(fields: any): Candidate
	return {
		keys = fields.keys,
		text = fields.text,
		display = fields.display or fields.text,
		insert = fields.insert or fields.text,
		advance = fields.advance ~= false,
		caretBack = fields.caretBack or 0,
		kind = fields.kind,
		description = fields.description,
		image = fields.image,
		swatch = fields.swatch,
		isDefault = fields.isDefault,
	}
end

local function numberCandidates(inputObject: any): { Candidate }
	local out: { Candidate } = {}
	local seen: { [number]: boolean } = {}
	local function add(value: any, label: string)
		if typeof(value) == "number" and not seen[value] then
			seen[value] = true
			local text = tostring(value)
			table.insert(out, makeCandidate({ keys = { text }, text = text, kind = "number", description = label, isDefault = label == "default"}))
		end
	end
	add(inputObject.default, "default")
	add(inputObject.min, "min")
	add(inputObject.max, "max")
	return out
end

local function durationCandidates(): { Candidate }
	local out: { Candidate } = {}
	for _, preset in DEFAULT_DURATIONS do
		table.insert(out, makeCandidate({
			keys = { preset.text },
			text = preset.text,
			kind = "duration",
			description = preset.label,
		}))
	end
	return out
end

local function colorCandidates(defaultColor: any): { Candidate }
	local out: { Candidate } = {}
	local source = if typeof(commandColors) == "table" then commandColors else DEFAULT_COLORS
	local names = {}
	for colorName in source :: { [string]: any } do
		table.insert(names, tostring(colorName))
	end
	table.sort(names)
	for _, colorName in names do
		local color = (source :: { [string]: any })[colorName]
		local isDefault = typeof(defaultColor) == "Color3" and color == defaultColor
		local candidate = makeCandidate({
			keys = { colorName },
			text = colorName,
			kind = "color",
			description = if isDefault then "default" else nil,
			swatch = if typeof(color) == "Color3" then color else nil,
			isDefault = isDefault,
		})
		if isDefault then
			table.insert(out, 1, candidate)
		else
			table.insert(out, candidate)
		end
	end
	return out
end

local function playerCandidates(): { Candidate }
	local out: { Candidate } = {}

	local ordered = {}
	for _, qualifier in Qualifiers.getAll() do
		if qualifier.isHidden ~= true and typeof(qualifier.key) == "string" then
			table.insert(ordered, qualifier)
		end
	end
	table.sort(ordered, function(left, right)
		return (left.displayOrder or math.huge) < (right.displayOrder or math.huge)
	end)
	for _, qualifier in ordered do
		local name = tostring(qualifier.key):lower()
		local needsCapsule = qualifier.requiresCapsule == true
		table.insert(out, makeCandidate({
			keys = { name },
			text = name,
			display = qualifier.key,
			insert = if needsCapsule then name .. "()" else name,
			advance = not needsCapsule,
			caretBack = if needsCapsule then 1 else 0,
			kind = "qualifier",
			description = qualifier.description,
		}))
	end

	for _, player in Players:GetPlayers() do
		local identified = playerIdentifier .. player.Name
		table.insert(out, makeCandidate({
			keys = { player.Name, player.DisplayName, identified },
			text = player.Name,
			display = player.DisplayName,
			insert = identified,
			kind = "player",
			description = if player.DisplayName ~= player.Name then identified else nil,
			image = `rbxthumb://type=AvatarHeadShot&id={player.UserId}&w=48&h=48`,
		}))
	end
	return out
end

local function optionCandidates(inputObject: any): { Candidate }
	local out: { Candidate } = {}
	local optionsArray = inputObject.optionsArray
	if typeof(optionsArray) ~= "table" then
		return out
	end
	local displayArray = inputObject.optionsDisplayArray
	for index, option in optionsArray :: { string } do
		local display = if typeof(displayArray) == "table" then (displayArray :: { string })[index] else nil
		table.insert(out, makeCandidate({
			keys = { tostring(option) },
			text = tostring(option),
			display = display or tostring(option),
			kind = "option",
		}))
	end
	return out
end

local function describeItem(item: any): (string?, string?)
	local itemType = typeof(item)
	if itemType == "string" then
		return item, item
	elseif itemType == "EnumItem" then
		local name = (item :: EnumItem).Name
		return name, name
	elseif itemType == "Instance" then
		local name = (item :: Instance).Name
		return name, name
	elseif itemType == "table" then
		local insert = item.rawValue or item.name or item.Name or item.key or item.label or item.title
		if typeof(insert) ~= "string" then
			return nil, nil
		end
		local display = item.label or item.display or item.displayName or item.name or item.Name or item.title or insert
		return insert, if typeof(display) == "string" then display else insert
	end
	return nil, nil
end

local function pickerCandidates(items: { any }): { Candidate }
	local out: { Candidate } = {}
	for _, item in items do
		local insert, display = describeItem(item)
		if insert then
			table.insert(out, makeCandidate({
				keys = { insert, display :: string },
				text = insert,
				display = display,
				kind = "picker",
			}))
		end
	end
	return out
end

local function pickerKeyFor(argDetail: any): string?
	local inputObject = argDetail.inputObject
	if typeof(inputObject) ~= "table" or typeof(inputObject.pickerGetter) ~= "function" then
		return nil
	end
	return tostring(argDetail.key or inputObject.inputType or "picker")
end


-- FUNCTIONS
-- Whatever's available without yielding
function Candidates.forArg(argDetail: any): { Candidate }
	if typeof(argDetail) ~= "table" then
		return {}
	end
	local inputObject = argDetail.inputObject
	if typeof(inputObject) ~= "table" then
		return {}
	end

	if argDetail.playerArg == true or inputObject.displayQualifiersInPicker == true then
		return playerCandidates()
	end
	if typeof(inputObject.optionsArray) == "table" then
		return optionCandidates(inputObject)
	end
	if inputObject.inputType == "ColorPicker" then
		return colorCandidates(inputObject.default)
	end
	if inputObject.inputType == "NumberInput" then
		return numberCandidates(inputObject)
	end
	if inputObject.inputType == "DurationSelector" then
		return durationCandidates()
	end

	local pickerKey = pickerKeyFor(argDetail)
	if pickerKey then
		local cached = pickerCache[pickerKey]
		if cached then
			return pickerCandidates(cached.items)
		end
	end
	return {}
end

function Candidates.needsPicker(argDetail: any): boolean
	local pickerKey = pickerKeyFor(argDetail)
	if not pickerKey then
		return false
	end
	local cached = pickerCache[pickerKey]
	return cached == nil or (os.clock() - cached.fetchedAt) > PICKER_CACHE_TTL
end

function Candidates.ensurePicker(argDetail: any, onReady: () -> ())
	local pickerKey = pickerKeyFor(argDetail)
	if not pickerKey or pickerInFlight[pickerKey] then
		return
	end
	if not Candidates.needsPicker(argDetail) then
		return
	end
	pickerInFlight[pickerKey] = true
	local getter = argDetail.inputObject.pickerGetter
	task.spawn(function()
		local success, items = pcall(getter)
		pickerInFlight[pickerKey] = false
		pickerCache[pickerKey] = {
			fetchedAt = os.clock(),
			items = if success and typeof(items) == "table" then items else {},
		}
		onReady()
	end)
end


return Candidates
