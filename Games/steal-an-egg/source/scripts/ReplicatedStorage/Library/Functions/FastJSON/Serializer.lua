-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {
	["\""] = "\\\"",
	["\\"] = "\\\\",
	["\8"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t"
}

setmetatable(t2, {
	__index = function(p1, p2) --[[ __index | Line: 14 ]]
		return string.format("\\u00%02X", p2:byte())
	end
})

local function escapeString(p1) --[[ escapeString | Line: 19 | Upvalues: t2 (copy) ]]
	if p1:find("[\0-\31\"\\]") then
		p1 = p1:gsub("[\0-\31\"\\]", t2)
	end

	return p1
end

local t4 = {}

function t.new() --[[ new | Line: 28 | Upvalues: t4 (copy) ]]
	return setmetatable({
		fragments = {}
	}, {
		__index = t4
	})
end

local function kindOf(p1) --[[ kindOf | Line: 32 ]]
	if type(p1) ~= "table" then
		return type(p1)
	end

	local count = 1

	for k in pairs(p1) do
		if p1[count] == nil then
			return "table"
		end

		count = count + 1
	end

	if count == 1 then
		return "table"
	end

	return "array"
end

function t4.WriteKey(p1, p2) --[[ WriteKey | Line: 46 | Upvalues: kindOf (copy), t2 (copy) ]]
	local v1 = kindOf(p2)

	if v1 == "array" then
		error("Can\'t encode array as key.")
	end

	if v1 == "table" then
		error("Can\'t encode table as key.")
	end

	if v1 == "string" then
		p1:WriteRaw(string.format("\"%s\"", if p2:find("[\0-\31\"\\]") then p2:gsub("[\0-\31\"\\]", t2) else p2))
	elseif v1 == "number" then
		p1:WriteRaw("\"")
		p1:WriteRaw((tostring(p2)))
		p1:WriteRaw("\"")
	else
		error(v1)
	end

	return p1
end
function t4.WriteArray(p1, p2) --[[ WriteArray | Line: 64 ]]
	p1:WriteRaw("[")

	for i, v in ipairs(p2) do
		p1:WriteRaw(if i == 1 then "" else ",")
		p1:WriteObject(v)
	end

	p1:WriteRaw("]")

	return p1
end
function t4.WriteTable(p1, p2) --[[ WriteTable | Line: 74 ]]
	p1:WriteRaw("{")

	local count = 0

	for k, v in pairs(p2) do
		if v ~= nil then
			p1:WriteRaw(if count == 0 then "" else ",")
			p1:WriteKey(k)
			p1:WriteObject(v)
			count = count + 1
		end
	end

	p1:WriteRaw("}")

	return p1
end
function t4.WriteObject(p1, p2) --[[ WriteObject | Line: 89 | Upvalues: kindOf (copy), t2 (copy) ]]
	local v1 = kindOf(p2)

	if v1 == "array" then
		p1:WriteArray(p2)

		return p1
	end

	if v1 == "table" then
		p1:WriteTable(p2)

		return p1
	end

	if v1 == "string" then
		p1:WriteRaw(string.format("\"%s\"", if p2:find("[\0-\31\"\\]") then p2:gsub("[\0-\31\"\\]", t2) else p2))
	else
		if v1 == "number" or v1 == "boolean" then
			p1:WriteRaw((tostring(p2)))

			return p1
		end

		if v1 == "nil" then
			p1:WriteRaw("null")
		else
			error(v1)
		end
	end

	return p1
end
function t4.WriteRaw(p1, p2) --[[ WriteRaw | Line: 107 ]]
	table.insert(p1.fragments, p2)
end
function t4.ToString(p1) --[[ ToString | Line: 111 ]]
	return table.concat(p1.fragments)
end

return t