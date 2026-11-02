-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

local function version_tostring(p1) --[[ version_tostring | Line: 35 ]]
	return string.format("%d.%d", p1.Major, p1.Minor)
end

local function version_lt(p1, p2) --[[ version_lt | Line: 39 ]]
	if p1.Major == p2.Major then
		return p1.Minor < p2.Minor
	end

	return p1.Major < p2.Major
end

local function version_eq(p1, p2) --[[ version_eq | Line: 43 ]]
	return if p1.Major == p2.Major then p1.Minor == p2.Minor else false
end

local function double_to_int32(p1) --[[ double_to_int32 | Line: 47 ]]
	if math.clamp(tonumber(p1) or 0, -2147483648, 2147483647) ~= p1 then
		return UDim.new(nil, p1).Offset
	end

	if p1 <= -1 then
		return math.ceil(p1)
	end

	if p1 >= 1 then
		return math.floor(p1)
	end

	return 0
end

function t.new(p1, p2) --[[ new | Line: 61 | Upvalues: version_tostring (copy), version_lt (copy), version_eq (copy) ]]
	local v1 = newproxy(true)
	local v2 = getmetatable(v1)
	local t = {}
	local v3 = tonumber(p1) or 0

	t.Major = if math.clamp(v3, -2147483648, 2147483647) == p1 then if p1 <= -1 then math.ceil(p1) elseif p1 >= 1 then math.floor(p1) else 0 else UDim.new(nil, p1).Offset

	local v5 = tonumber(p2) or 0

	t.Minor = if math.clamp(v5, -2147483648, 2147483647) == p2 then if p2 <= -1 then math.ceil(p2) elseif p2 >= 1 then math.floor(p2) else 0 else UDim.new(nil, p2).Offset
	v2.__index = t
	v2.__metatable = "The metatable is locked"
	v2.__tostring = version_tostring
	v2.__lt = version_lt
	v2.__eq = version_eq
	table.freeze(v2)

	return v1
end
t.current = t.new(31, 1)

return table.freeze(t)