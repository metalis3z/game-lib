--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

require(script.Parent.Types)

local IconPool = require(script.Parent.IconPool)
local t = {}
local t2 = {
	Owner = true,
	Elder = true,
	Member = true
}
local DEFAULT_ICON_ID = IconPool.DEFAULT_ICON_ID

local function AssertGuildId(p1) --[[ AssertGuildId | Line: 60 | Upvalues: Asserts (copy) ]]
	if typeof(p1) ~= "string" or p1 == "" then
		error("AssertGuildId: expected non-empty string", 2)
	end

	if not Asserts.IsASCII(p1) then
		error("AssertGuildId: must be ASCII", 2)
	end

	if not (#p1 > 64) then
		return p1
	end

	error("AssertGuildId: too long", 2)
end

local function AssertName(p1) --[[ AssertName | Line: 73 | Upvalues: Asserts (copy) ]]
	if typeof(p1) ~= "string" then
		error("AssertName: expected string", 2)
	end

	if #p1 < 3 or #p1 > 24 then
		error(("AssertName: must be %*-%* characters"):format(3, 24), 2)
	end

	if not Asserts.IsASCII(p1) then
		error("AssertName: must be ASCII", 2)
	end

	if string.match(p1, "^[A-Za-z0-9 _%-\']+$") then
		return p1
	end

	error("AssertName: only letters, digits, spaces, dashes, apostrophes, underscores", 2)
end

local function AssertTag(p1) --[[ AssertTag | Line: 89 ]]
	if typeof(p1) ~= "string" then
		error("AssertTag: expected string", 2)
	end

	if #p1 < 2 or #p1 > 5 then
		error(("AssertTag: must be %*-%* characters"):format(2, 5), 2)
	end

	if string.match(p1, "^[A-Z0-9]+$") then
		return p1
	end

	error("AssertTag: must be uppercase letters / digits", 2)
end

local function AssertDescription(p1) --[[ AssertDescription | Line: 106 | Upvalues: Asserts (copy) ]]
	if typeof(p1) ~= "string" then
		error("AssertDescription: expected string", 2)
	end

	local v1 = utf8.len(p1)

	if not v1 then
		error("AssertDescription: invalid UTF-8", 2)
	end

	if v1 > 200 then
		error(("AssertDescription: must be <= %* characters"):format(200), 2)
	end

	if Asserts.IsASCII(p1) then
		return p1
	end

	error("AssertDescription: must be ASCII", 2)
end

local function AssertGuildRole(p1) --[[ AssertGuildRole | Line: 127 | Upvalues: t2 (copy) ]]
	if typeof(p1) ~= "string" or not t2[p1] then
		error("AssertGuildRole: must be \'Owner\' | \'Elder\' | \'Member\'", 2)
	end

	return p1
end

local function AssertSlotCount(p1) --[[ AssertSlotCount | Line: 134 ]]
	if typeof(p1) ~= "number" or p1 ~= math.floor(p1) then
		error("AssertSlotCount: must be an integer", 2)
	end

	if p1 < 20 or p1 > 50 then
		error(("AssertSlotCount: must be in [%*, %*]"):format(20, 50), 2)
	end

	return p1
end

local function AssertUserId(p1) --[[ AssertUserId | Line: 144 ]]
	if typeof(p1) ~= "number" or (p1 ~= math.floor(p1) or p1 <= 0) then
		error("AssertUserId: must be a positive integer", 2)
	end

	return p1
end

local function AssertHexColor(p1) --[[ AssertHexColor | Line: 151 ]]
	if typeof(p1) ~= "string" then
		error("AssertHexColor: expected string", 2)
	end

	if string.match(p1, "^#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]$") then
		return string.upper(p1)
	end

	error("AssertHexColor: must be #RRGGBB", 2)
end

local function AssertIconId(p1) --[[ AssertIconId | Line: 164 ]]
	if typeof(p1) ~= "number" or (p1 ~= math.floor(p1) or p1 <= 0) then
		error("AssertIconId: must be a positive integer", 2)
	end

	return p1
end

local function IsPoolIcon(p1) --[[ IsPoolIcon | Line: 173 | Upvalues: IconPool (copy) ]]
	return IconPool.IsPoolIcon(p1)
end

local function IconAssetString(p1) --[[ IconAssetString | Line: 179 | Upvalues: DEFAULT_ICON_ID (copy) ]]
	local v1 = DEFAULT_ICON_ID

	if typeof(p1) == "number" and p1 == p1 and p1 > 0 then
		v1 = p1
	end

	return ("rbxassetid://%*"):format((math.round(v1)))
end

t.AssertGuildId = AssertGuildId
t.AssertName = AssertName
t.AssertTag = AssertTag
t.AssertDescription = AssertDescription
t.AssertGuildRole = AssertGuildRole
t.AssertSlotCount = AssertSlotCount
t.AssertUserId = AssertUserId
t.AssertHexColor = AssertHexColor
t.AssertIconId = AssertIconId
t.IsPoolIcon = IsPoolIcon
t.IconAssetString = IconAssetString
t.MIN_NAME_LENGTH = 3
t.MAX_NAME_LENGTH = 24
t.MIN_TAG_LENGTH = 2
t.MAX_TAG_LENGTH = 5
t.MAX_DESCRIPTION_LENGTH = 200
t.MIN_SLOTS = 20
t.MAX_SLOTS = 50
t.MAX_ELDERS = 5
t.GUILD_ROLES = t2
t.DEFAULT_COLOR = "#6EE7A7"
t.PRESET_COLORS = {
	"#6EE7A7",
	"#FBBF24",
	"#FB7185",
	"#A78BFA",
	"#60A5FA",
	"#34D399",
	"#F87171",
	"#FB923C",
	"#FACC15",
	"#22D3EE",
	"#F472B6",
	"#94A3B8"
}
t.GetIconPool = IconPool.GetPool
t.RandomIcon = IconPool.Random
t.DEFAULT_ICON_ID = DEFAULT_ICON_ID

return table.freeze(t)